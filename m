Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDA2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B0920892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmPVHwv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B0920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389248AbeKPTdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:33:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51818 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeKPTdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:33:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so21306216wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a0fCbhskByF8MHox8U6kPsydOMji/9uIZ5KhUQ42GH4=;
        b=kmPVHwv27iO1EOsrpcfv6FUE1GCuf/QNXCMKqA1Bn6hMqGHH99eq4cxgHGJ6GCg8hU
         DqJuA+AmCr2A/w7k1zjxIH8g+jCXv2Q0E/fgt+bMp/68Yp7dlRPWLbdTWPttItOzfCJZ
         E+1g2T8On/ruuADuPUZg5dOTPK29ypQ9GGO+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0fCbhskByF8MHox8U6kPsydOMji/9uIZ5KhUQ42GH4=;
        b=ObYIIN+krBp0RQP9/s5MxRln7lE04e62JmCyucbGO/X9cwvqLi6vI9I1oO0hotSoIv
         KRaGHhnqoEjGBDEoKJuS2PIEux40YNmSMM+U5TE/RqVqNiBYt9IHJHIhWTy87/jQafkm
         FECK2YEgizsFYdRGTrG4woN2RHWJq84JlNnaJJ8WzHpCQ6eriDpOpYSD3ttO3aNM+B6G
         e2lnmBGKd58jpfoPMCluI7a/Nb0i3VKx44LWEtkKgGiWoFlgJC5cjH7y9x6XGsGmORDC
         qgYVbgK9OhY/mq+lN2G9iWBB2A4iQsejjiWDlkz03Hp0l4BqXKff+Q/CYJDHlwFIetAe
         uPug==
X-Gm-Message-State: AGRZ1gKceMRVT9leS/t8lH/PLEpK7SrMJOWKDVRuTQzh7hA0h6TAuj5K
        XIyo5pXyBA/vQ8F7vxsPnb5jeA==
X-Google-Smtp-Source: AJdET5dUFNM0vOTGFqYlp02gmHP1nOlBaZ7VT9rsHFGu+Lix95VgwUjlbcT1jTEjmZ5j1HmVhNwbgg==
X-Received: by 2002:a1c:8a91:: with SMTP id m139-v6mr7918512wmd.27.1542360103900;
        Fri, 16 Nov 2018 01:21:43 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id c4-v6sm21301348wrr.74.2018.11.16.01.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 01:21:43 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v3 1/5] ALSA: soc-compress: add support to
 snd_compr_set_runtime_buffer()
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, vkoul@kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        bgoswami@codeaurora.org, Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, rohitkr@codeaurora.org,
        srini@kernel.org
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
 <20181115181324.26784-2-srinivas.kandagatla@linaro.org>
 <CAEnQRZBGQX7C2=fUr-6et6Wh=fOgX3nB=eFYG959XiuDMqbaKg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <336ad4dd-6046-7386-4080-d3061d04d8c2@linaro.org>
Date:   Fri, 16 Nov 2018 09:21:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBGQX7C2=fUr-6et6Wh=fOgX3nB=eFYG959XiuDMqbaKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comments!

On 16/11/18 07:18, Daniel Baluta wrote:
> One minor comment:
> 
> <snip>
> 
>>          struct snd_compr_ops *ops;
>> +       struct snd_dma_buffer *dma_buffer_p;
> I don't think it is necessary to encode the type inside the name variable
> So, dma_buffer would sounds better to me then dma_buffer_p;
> 
>>          void *buffer;
> It is also consistent with this ^
> 
> <snip>
>> +static inline void snd_compr_set_runtime_buffer(
>> +                                       struct snd_compr_stream *substream,
>> +                                       struct snd_dma_buffer *bufp)
> Also buf instead of bufp here.

TBH, I followed what ./include/sound/pcm.h does!

--srini
