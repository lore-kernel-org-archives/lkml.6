Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF43C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B7F2064D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="emKqi2J/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B7F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeJEPNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:13:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33738 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbeJEPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:13:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so12612232wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXwvT2qZYt9+pmKJfLlB/EY46v3h63PSpxKFenUTAJs=;
        b=emKqi2J//Appd/T7Qu3TEbn+wumQ60sPKH7XdCLHl7VvggGdwytuz8J+kUE7MqTHqM
         uvtxBdBMLD9kXc5LkPuqNbg6XiJyc/nd+oD0wn/JDZchDdmxkR0CJ/kS4S4ejXTeKi4M
         TlutuibQqsgaCWVt5mBoAfqIG3q3ALjXaIhyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXwvT2qZYt9+pmKJfLlB/EY46v3h63PSpxKFenUTAJs=;
        b=ZgfAIuJjFB7BOawrj53WSDAK5zK3WR7xUM1J6qZlZJL85PW85cIy85mG+U7KmwJfnV
         bP5SM7MkMmdqaYbu+zm9tsMSVYnZ2sH3X3DEEAvwTt7AsJEyRfq9FcE3rHA9q7A+bOYM
         Enhncpybv9gwnS8gvoFyFaNT/Ts8S1t77skvt9ErjA4IcwXEmercyET/ECaDPx8CV3cH
         QXtEXBBCWS3lTv+/ZBsTZHytTCcGdCjGSb9rxUY4sW6HueYjae3dlLsx1DYv2ACTHzJJ
         4a+7YsWBOFAsZLIIZx5VipbA7rZpO6i33kNCNEvh3x+x9XDdo3lc7ympnhRUl3u9+w9W
         XRbA==
X-Gm-Message-State: ABuFfoiVY2xHsANGS4LfG3/THUmEUXEXlL6kSI+gZ3DgCIF41YId82Bs
        35cD41h+n8quTdNDPol89YFNUQ==
X-Google-Smtp-Source: ACcGV62KkSwWYoWo2O/C0Hqp9idhhF0cxZpgx4fAycmkx4/Z1vjXCedsDTSal7L1+GUIAJWQpESZ0A==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr7735223wrh.72.1538727332537;
        Fri, 05 Oct 2018 01:15:32 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm6766509wrb.30.2018.10.05.01.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:15:31 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] ASoC: qdsp6: q6asm-dai: Add support to compress
 offload
To:     Vinod <vkoul@kernel.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
 <20180926102349.23481-6-srinivas.kandagatla@linaro.org>
 <20181005003919.GH2372@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dd8fe500-ce7c-4a50-48a4-ef4b5c53dccc@linaro.org>
Date:   Fri, 5 Oct 2018 09:15:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181005003919.GH2372@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for the Review!

On 05/10/18 01:39, Vinod wrote:
> On 26-09-18, 11:23, Srinivas Kandagatla wrote:
>> This patch adds MP3 playback support in q6asm dais, adding other codec
>> support should be pretty trivial.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/Kconfig           |   1 +
>>   sound/soc/qcom/qdsp6/q6asm-dai.c | 377 ++++++++++++++++++++++++++++++-
>>   2 files changed, 377 insertions(+), 1 deletion(-)
>>
...
>> +#define Q6ASM_DAI_RX	2
>> +
>> +
> 
> Unnecessary double space
> 

I did notice this just after I sent the patch!
>>   enum stream_state {
>>   	Q6ASM_STREAM_IDLE = 0,
>>   	Q6ASM_STREAM_STOPPED,
>> @@ -39,11 +51,22 @@ enum stream_state {
>>   
>>   struct q6asm_dai_rtd {
>>   	struct snd_pcm_substream *substream;
>> +	struct snd_compr_stream *cstream;
>> +	struct snd_compr_params codec_param;
>> +	struct snd_dma_buffer dma_buffer;
>> +
>>   	phys_addr_t phys;
>> +	spinlock_t lock;
> 
> why would we need a lock for compress case?
bytes_received counter is updated as part of Ack and referenced in the 
irq context in the event_handler callback from dsp, this lock is to 
protect it !

--srini
> 
