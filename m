Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852F1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E2225741
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fO74Wumz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E2225741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755196AbeFYKLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:11:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35493 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755178AbeFYKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:11:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id z137-v6so3593423wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZPMk3UvdXqGovYsPdV0HSX8rsRhp+BgB3A0YEeHpjk=;
        b=fO74Wumz8MxkU/yQpCqgvkXL14CEWUmxBWuk4NSLTKk/OOyaGjPU4R2iHb+hksael6
         1MWRjDm6FcC3eexdsyRKFz0oXVpYQumHg+ddyt3YTzfrBUpf3hzEfNN0Zz1tFc7O0oov
         XhAlVkbx4zfpJKniN1mmk782VUAblfR1Rkhts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZPMk3UvdXqGovYsPdV0HSX8rsRhp+BgB3A0YEeHpjk=;
        b=j9ckkTVafyxPQ9XViKtxpRmzk7w491w8DmYDCY8ZVf378oq2cpSjOut6QZqyRdc+ru
         iQA0G/3bkeMSHib1w/VLjmnKv3IwnL0b1pRCK/6vWncwKpcj6lVLX0GIbeBq0nk4EfoI
         8+wIWctqQ6j10jMTkFNwaVo4qdG1UMbC397SV1JoeeEYvBdStdLYkujDMNzjxmNebxW6
         E74/3xnOmmHSA6UK7D44zRzrx8C0xALQR/shrE1zk7798RFb3rMpJ3wkQPM66BMysOwQ
         /K/8ATTc2gKD9abiT5JXim7CXyZ8/EhGukwqo15Q/NrW1A+sxUEsTdF/oFgjFfjGzcVe
         Dh9Q==
X-Gm-Message-State: APt69E33xMC6HQuEOmc/Ow1uIHUi9uFsaQ/XZuPJ5/4+mibfNeLu/3w9
        XiQw4XUgLrB1PmlY+QMjY/Wli0TU02M=
X-Google-Smtp-Source: ADUXVKLaeQ7q4GBKciJRCxF+fMx0Z0whbpgZnCaXfptzzvtMlQFuko3pDoTw0p2513P5h1IxMXDT7A==
X-Received: by 2002:a1c:ec0a:: with SMTP id k10-v6mr473031wmh.4.1529921481589;
        Mon, 25 Jun 2018 03:11:21 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id b124-v6sm12984767wmf.11.2018.06.25.03.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 03:11:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
To:     Vinod <vkoul@kernel.org>
Cc:     gregkh@linuxfoundation.org, broonie@kernel.org,
        sdharia@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        ctatlor97@gmail.com
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
 <20180622125050.GO27187@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a922d359-2096-48ed-c442-affc5b0c4ccf@linaro.org>
Date:   Mon, 25 Jun 2018 11:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180622125050.GO27187@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for the Review,

On 22/06/18 13:50, Vinod wrote:
> On 21-06-18, 14:40, Srinivas Kandagatla wrote:
>> This patch adds support to SLIMbus stream apis for slimbus device.
>> SLIMbus streaming involves adding support to Data Channel Management and
>> channel Reconfiguration Messages to slim core plus few stream apis.
>> >From slim device side the apis are very simple mostly inline with other
>    ^^
> Bad char >
Yep, will fix it.
> 
>> +/**
>> + * enum slim_port_direction: SLIMbus port direction
> 
> blank line here makes it more readable
> 
Sure it makes sense.
>> +/**
>> + * struct slim_presence_rate - Presense Rate table for all Natural Frequencies
>> + *	The Presense rate of a constant bitrate stram is mean flow rate of the
>                                                  ^^^^^
> Do you mean stream?
Yep will fix it.
> 
>> +static struct slim_presence_rate {
>> +	int rate;
>> +	int pr_code;
>> +} prate_table[] = {
>> +	{12000,		0x01},
>> +	{24000,		0x02},
>> +	{48000,		0x03},
>> +	{96000,		0x04},
>> +	{192000,	0x05},
>> +	{384000,	0x06},
>> +	{768000,	0x07},
>> +	{110250,	0x09},
>> +	{220500,	0x0a},
>> +	{441000,	0x0b},
>> +	{882000,	0x0c},
>> +	{176400,	0x0d},
>> +	{352800,	0x0e},
>> +	{705600,	0x0f},
>> +	{4000,		0x10},
>> +	{8000,		0x11},
>> +	{16000,		0x12},
>> +	{32000,		0x13},
>> +	{64000,		0x14},
>> +	{128000,	0x15},
>> +	{256000,	0x16},
>> +	{512000,	0x17},
> 
> this table values are indices, so how about using only rate and removing
> pr_code and use array index for that, saves half the space..
> 
look like I over done it, I will fix this in next version.

>> +struct slim_stream_runtime *slim_stream_allocate(struct slim_device *dev,
>> +						 const char *name)
>> +{
>> +	struct slim_stream_runtime *rt;
>> +	unsigned long flags;
>> +
>> +	rt = kzalloc(sizeof(*rt), GFP_KERNEL);
>> +	if (!rt)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	rt->name = kasprintf(GFP_KERNEL, "slim-%s", name);
>> +	if (!rt->name) {
>> +		kfree(rt);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	rt->dev = dev;
>> +	rt->state = SLIM_STREAM_STATE_ALLOCATED;
>> +	spin_lock_irqsave(&dev->stream_list_lock, flags);
>> +	list_add_tail(&rt->node, &dev->stream_list);
>> +	spin_unlock_irqrestore(&dev->stream_list_lock, flags);
> 
> Any reason for _irqsave variant? Do you expect stream APIs to be called
> from ISR?We can move to non irqsave variant here, as i do not see a case where 
this list would be interrupted from irq context.


> 
>> +/*
>> + * slim_stream_prepare() - Prepare a SLIMbus Stream
>> + *
>> + * @rt: instance of slim stream runtime to configure
>> + * @cfg: new configuration for the stream
>> + *
>> + * This API will configure SLIMbus stream with config parameters from cfg.
>> + * return zero on success and error code on failure. From ASoC DPCM framework,
>> + * this state is linked to hw_params()/prepare() operation.
> 
> so would this be called from either.. btw prepare can be invoked
> multiple times, so that should be taken into consideration by caller.

This should be just hw_params() where we have more information on the 
audio parameters, I will make this more clear in the doc about this.

> 
>> + */
>> +int slim_stream_prepare(struct slim_stream_runtime *rt,
>> +			struct slim_stream_config *cfg)
>> +{
>> +	struct slim_controller *ctrl = rt->dev->ctrl;
>> +	struct slim_port *port;
>> +	int num_ports, i, port_id;
>> +
>> +	num_ports = hweight32(cfg->port_mask);
>> +	rt->ports = kcalloc(num_ports, sizeof(*port), GFP_ATOMIC);
> 
> since this is supposed to be invoked in hw_params()/prepare, why would
> we need GFP_ATOMIC here?
No, we do not need this to be ATOMIC, will remove this!

> 
>> +static int slim_activate_channel(struct slim_stream_runtime *stream,
>> +				 struct slim_port *port)
>> +{
>> +	struct slim_device *sdev = stream->dev;
>> +	struct slim_val_inf msg = {0, 0, NULL, NULL};
>> +	u8 mc = SLIM_MSG_MC_NEXT_ACTIVATE_CHANNEL;
>> +	DEFINE_SLIM_LDEST_TXN(txn, mc, 5, stream->dev->laddr, &msg);
>> +	u8 wbuf[1];
>> +
>> +	txn.msg->num_bytes = 1;
>> +	txn.msg->wbuf = wbuf;
>> +	wbuf[0] = port->ch.id;
>> +	port->ch.state = SLIM_CH_STATE_ACTIVE;
>> +
>> +	return slim_do_transfer(sdev->ctrl, &txn);
>> +}
> 
> how about adding a macro for sending message, which fills slim_val_inf
> and you invoke that with required parameters to be filled.
> 
Sounds sensible thing, I will give that a try and see!

>> +/*
>> + * slim_stream_enable() - Enable a prepared SLIMbus Stream
> 
> Do you want to check if it is already prepared ..?
Yep, I think most of the code needs similar state machine check, I will 
add this in next version.
> 
>> +/**
>> + * slim_stream_direction: SLIMbus stream direction
>> + *
>> + * @SLIM_STREAM_DIR_PLAYBACK: Playback
>> + * @SLIM_STREAM_DIR_CAPTURE: Capture
>> + */
>> +enum slim_stream_direction {
>> +	SLIM_STREAM_DIR_PLAYBACK = 0,
>> +	SLIM_STREAM_DIR_CAPTURE,
> 
> this is same as SNDRV_PCM_STREAM_PLAYBACK, so should we use that here?
Sure will do, makes it clear!

> 
