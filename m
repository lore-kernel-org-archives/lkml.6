Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA73C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C891020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVHSWKJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C891020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeILPeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:34:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34875 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeILPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:34:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so1813239wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gpmHpjTuXE2kjGizbR0n7fMAZabAlmknpxhK8q9stYw=;
        b=FVHSWKJRVr5cbgymlHYigxGcTS7ikv3EKtu8X0rmZDsgT82PrEmYjOR5sReYZy7lfk
         2uQxuWccNjmnM6ocdLQIjwxJdnfEiDBiaLChpUhQw+bZ3Zm1XsROPHY1WfIQXsszRXJi
         20exofeFJg9V34B7VqqX0pO7OYQV8/Lj1DA78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpmHpjTuXE2kjGizbR0n7fMAZabAlmknpxhK8q9stYw=;
        b=sh5/nKctvIeWxHfK7YgLiCN83ZllWwIaVZ7XknoeACcvdMJF/ya5hFx+rXws/T5s2n
         optaoB1tuqyjsWwCbn8tQrWv7/iWHNrRgOrZN8j61bcgp42xM9p3CAZGOh6PTBNlpqv9
         F6cBcN1BUCy1MQBJsnzWZ5yO73a+40Az00JU6P3tooBwB4KvccRIUWQ6Xdk+E7Vl/B3N
         Ecc1FNw+QJ0W8fWHrlioKPquUcAYPqYI50CxLfDIbh1tNGcFqsKlfxnuj/W5L/NmvkUh
         ScX3LdqDp1RJEFQhdYEUMCH/XJEeWKjznbDxhQhunDMQQNjhgQsW7xg+4RpL3rkKm1N1
         pObA==
X-Gm-Message-State: APzg51BdMBU2b+FjUNsbwMKe0eCTuiXoKx03jyAV6WlQjd7dcy2Pgd6N
        KZ9XOv1FoxBYOXQE7bplgUR63A==
X-Google-Smtp-Source: ANB0VdaINgGQynfj+L5AG8c9MBUpUvMrAg0wvLurnVWwLRTk0qMOG+XQG3f/UOZrE8vI/MmHDZ8VSQ==
X-Received: by 2002:a1c:7412:: with SMTP id p18-v6mr1183610wmc.49.1536748228227;
        Wed, 12 Sep 2018 03:30:28 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 144-v6sm1418965wma.19.2018.09.12.03.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 03:30:27 -0700 (PDT)
Subject: Re: [PATCH 3/3] ASoC: qdsp6: q6asm-dai: Add support to compress
 offload
To:     Vinod <vkoul@kernel.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        devicetree@vger.kernel.org, mark.rutland@arm.com
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
 <20180903123455.9290-4-srinivas.kandagatla@linaro.org>
 <20180904135526.GK2322@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4dfddf39-04f2-3d0a-221b-14e0970e489b@linaro.org>
Date:   Wed, 12 Sep 2018 11:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180904135526.GK2322@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 04/09/18 14:55, Vinod wrote:
> On 03-09-18, 13:34, Srinivas Kandagatla wrote:
> 
>> +static void compress_event_handler(uint32_t opcode, uint32_t token,
>> +				   uint32_t *payload, void *priv)
>> +{
>> +	struct q6asm_dai_rtd *prtd = priv;
>> +	struct snd_compr_stream *substream = prtd->cstream;
>> +	unsigned long flags;
>> +	uint64_t avail;
>> +
>> +	switch (opcode) {
>> +	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>> +		spin_lock_irqsave(&prtd->lock, flags);
>> +		avail = prtd->bytes_received - prtd->bytes_sent;
>> +		if (!prtd->bytes_sent) {
>> +			if (avail < substream->runtime->fragment_size) {
>> +				prtd->xrun = 1;
> 
> so you are trying to detect xrun :) So in compress core we added support
> for .ack callback which tells driver how much data is valid in ring
> buffer and we can send this to DSP, so DSP "knows" valid data and should
> not overrun, ofcourse DSP needs support for it
> 
Thanks, I will take a closer look at ack callback.

>> +			} else {
>> +				q6asm_write_async(prtd->audio_client,
>> +						  prtd->pcm_count,
>> +						  0, 0, NO_TIMESTAMP);
>> +				prtd->bytes_sent += prtd->pcm_count;
>> +			}
>> +		}
>> +
>> +		spin_unlock_irqrestore(&prtd->lock, flags);
>> +		break;
> 
> empty line after break helps readability

Yes,  I will do.
> 
>> +	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
>> +		prtd->state = Q6ASM_STREAM_STOPPED;
>> +		break;
>> +	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
>> +		spin_lock_irqsave(&prtd->lock, flags);
>> +		prtd->byte_offset += prtd->pcm_count;
>> +		prtd->copied_total += prtd->pcm_count;
> 
> so should you need two counters, copied_total should give you byte_offset
> as well, we know the ring buffer size

Yep, looks redundant to me too.
> 
>> +
>> +		if (prtd->byte_offset >= prtd->pcm_size)
>> +			prtd->byte_offset -= prtd->pcm_size;
> 
> :)
> 
>> +
>> +		snd_compr_fragment_elapsed(substream);
> 
> so will ASM_CLIENT_EVENT_DATA_WRITE_DONE be invoked on fragment bytes
> consumed?
Yes.
> 
>> +static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
>> +				      struct snd_compr_params *params)
>> +{
>> +
> 
> redundant empty line
ya.
> 
>> +static int q6asm_dai_compr_trigger(struct snd_compr_stream *stream, int cmd)
>> +{
>> +	struct snd_compr_runtime *runtime = stream->runtime;
>> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
>> +	int ret = 0;
>> +
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
> 
> the triggers are not in atomic context, do we have q6asm_run()
> 
Yes, we do have q6asm_run() which is a blocking call.

>> +static int q6asm_dai_compr_copy(struct snd_compr_stream *stream,
>> +				char __user *buf, size_t count)
>> +{
>> +	struct snd_compr_runtime *runtime = stream->runtime;
>> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
>> +	uint64_t avail = 0;
>> +	unsigned long flags;
>> +	size_t copy;
>> +	void *dstn;
>> +
>> +	dstn = prtd->buffer + prtd->copy_pointer;
>> +	if (count < prtd->pcm_size - prtd->copy_pointer) {
>> +		if (copy_from_user(dstn, buf, count))
>> +			return -EFAULT;
>> +
>> +		prtd->copy_pointer += count;
>> +	} else {
>> +		copy = prtd->pcm_size - prtd->copy_pointer;
>> +		if (copy_from_user(dstn, buf, copy))
>> +			return -EFAULT;
>> +
>> +		if (copy_from_user(prtd->buffer, buf + copy, count - copy))
>> +			return -EFAULT;
>> +		prtd->copy_pointer = count - copy;
>> +	}
>> +
>> +	spin_lock_irqsave(&prtd->lock, flags);
>> +	prtd->bytes_received += count;
> 
> why not use core copy method and..

Which core method are you referring to?
.
>> +
>> +	if (prtd->state == Q6ASM_STREAM_RUNNING && prtd->xrun) {
>> +		avail = prtd->bytes_received - prtd->copied_total;
>> +		if (avail >= runtime->fragment_size) {
>> +			prtd->xrun = 0;
>> +			q6asm_write_async(prtd->audio_client,
>> +				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
>> +			prtd->bytes_sent += prtd->pcm_count;
>> +		}
>> +	}
...
> 
>> +static int q6asm_dai_compr_get_codec_caps(struct snd_compr_stream *stream,
>> +					  struct snd_compr_codec_caps *codec)
>> +{
>> +	switch (codec->codec) {
>> +	case SND_AUDIOCODEC_MP3:
>> +		codec->num_descriptors = 2;
>> +		codec->descriptor[0].max_ch = 2;
>> +		memcpy(codec->descriptor[0].sample_rates,
>> +		       supported_sample_rates,
>> +		       sizeof(supported_sample_rates));
>> +		codec->descriptor[0].num_sample_rates =
>> +			sizeof(supported_sample_rates)/sizeof(unsigned int);
>> +		codec->descriptor[0].bit_rate[0] = 320; /* 320kbps */
>> +		codec->descriptor[0].bit_rate[1] = 128;
>> +		codec->descriptor[0].num_bitrates = 2;
>> +		codec->descriptor[0].profiles = 0;
>> +		codec->descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO;
>> +		codec->descriptor[0].formats = 0;
> 
> since we are static here, how about using a table based approach and
> use that here
Sure, will do that in next version.

thanks,
srini
> 
