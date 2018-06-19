Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0178C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561022083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KK8NfTb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561022083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965783AbeFSJgr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:36:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36048 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965682AbeFSJgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:36:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so19815932wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OYMo7MCQtGyXmV0pwddzKECwIVlKRcAfzgV2DyV2iLM=;
        b=KK8NfTb7/Ax01mhCxyZCvz48R7wL+s3lRE8KBocyhZ7U4dERQ+qCa/0HgRn+bAvoWU
         KNNZtsVIOBZ5LLAoaBkGHBvglsBAFXfA69RobIweDkUbJa7Pls63awgaO94Go7BUQlp+
         XJxuHkrriteYZWpn5wrvb2MzXGFnyJTZnPh6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OYMo7MCQtGyXmV0pwddzKECwIVlKRcAfzgV2DyV2iLM=;
        b=a2l5Ogp9g+Q+ip+cJDgEspF2CSeCeBBzkRQt1rzf6aqzISpThiyVt39eb2TwzZoyYN
         x+dRXmafP6SyvvTckam42O0O9xa51R1AM41WUBePeNPYdrfDYhDuzrOJJxLklAhEfqZl
         CJ2yFk/3jAjUrkMriTtzROb/qBODCNPgbcG1+WHKI6vnlOls2xpa6eve6srlW6/20QSb
         48DO14z6Y/YSOlmL0brLmHFskH7vKOwOd9MqzMPpCIL/RT8YzomZ/0qFTOz4tETpUJCg
         K9fQBHYZZxyTHJm6tqJcCVSo9GXi1ZeHDTK0kF9xvDKAslKNshnh6J69LVzsUWHueAIF
         WcIQ==
X-Gm-Message-State: APt69E2mu9fyKuDGJrCKLavA4uLnEjl8LjE5xwmJSj1+BiVcuWn59wS5
        RbG2uR2Cvo0GsryaSmTXlXgNHsNFjwY=
X-Google-Smtp-Source: ADUXVKLhxf1SajwMOGNcWIw06nBVQ25QcSo0ci62CCpEIsQcDYVWHbopnehtANscemRIckoCm1Q3LA==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr13774389wrq.58.1529401003426;
        Tue, 19 Jun 2018 02:36:43 -0700 (PDT)
Received: from [192.168.1.180] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id k36-v6sm33734423wrc.20.2018.06.19.02.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 02:36:42 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
To:     Rob Herring <robh+dt@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org>
 <20180618110642.GA6928@sirena.org.uk> <20180618123932.GA28476@centauri.lan>
 <CAL_JsqJQ0GbFtnpP9-YCEcVKHDdHbT5hshZGvNDQw=u5ZANdvg@mail.gmail.com>
 <20180618200848.GA32482@centauri.lan>
 <CAL_JsqJti8JzQ7mVQ6Y2zaWD_Q5R9bK4XVh3mJPohXh4sgSQwQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dc54226a-dee4-7557-fc36-98e4e1ed54cf@linaro.org>
Date:   Tue, 19 Jun 2018 10:36:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJti8JzQ7mVQ6Y2zaWD_Q5R9bK4XVh3mJPohXh4sgSQwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/06/18 21:53, Rob Herring wrote:
> On Mon, Jun 18, 2018 at 2:08 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>> On Mon, Jun 18, 2018 at 08:48:32AM -0600, Rob Herring wrote:
>>> On Mon, Jun 18, 2018 at 6:39 AM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>>>> On Mon, Jun 18, 2018 at 12:06:42PM +0100, Mark Brown wrote:
>>>>> On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
>>>>>> of_platform_device_destroy is only defined when building
>>>>>> with CONFIG_OF=y. Add a depends on OF.
>>>>>
>>>>> Is it sensible that of_platform_device_destroy() is only defined when
>>>>> building with CONFIG_OF=y?
>>>>
>>>> I'm redirecting that question to the device tree maintainers.
>>>>
>>>> There are a few of_* functions in include/linux/of_platform.h
>>>> that are only defined when CONFIG_OF=y:
>>>>
>>>> of_platform_device_create()
>>>> of_platform_device_destroy()
>>>> of_platform_bus_probe()
>>>> of_device_alloc()
>>>>
>>>> Rob, Frank, do you want me to create static inline dummy versions of these?
>>>
>>> No, because generally you should not be using these functions
>>> directly. Yes, there are some users, but if you look at the tree,
>>> there are few or isolated (PowerPC) users. Using
>>> of_platform_populate/of_platform_depopulate is preferred.
>>
>> of_platform_device_destroy() is also used by sound/soc/qcom/qdsp6/*
>> which is why I suggested this patch:
>> https://marc.info/?l=alsa-devel&m=152932497413567
>> that adds "depends on OF" for SND_SOC_QDSP6 in sound/soc/qcom/Kconfig.
>>
>> Or do you think that a better solution would be to modify
>> sound/soc/qcom/qdsp6/* so that it instead uses
>> of_platform_populate()/of_platform_depopulate()?
> 
> Yes, that is preferred. However, that won't work here because the
> child nodes don't have compatible strings. Maybe we should add them as
> this all just went in. That would also allow DT based module
> autoloading to work (which I don't think would currently). Really, as
> is, of_platform_device_create isn't needed here and you could just use
> platform_device_register_simple instead. The child driver would have
> to get the DT node pointer from the parent device instead.
> 
compatible was the reason why I started using 
of_platform_device_{create,destroy} apis. As you said we could also do 
it with simple platform device too.

I think adding compatible seems to be better option here along with 
of_platform_populate()/of_platform_depopulate(), I will try this!

thanks,
srini

> But if you want to add empty functions for just
> of_platform_device_{create,destroy}, I guess that is fine.
> 
> Rob
> 
