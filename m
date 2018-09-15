Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A03ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FC621477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwbmRny8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FC621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIPBUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 21:20:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37566 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeIPBUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 21:20:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id t140-v6so4683103lff.4;
        Sat, 15 Sep 2018 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GvGclNcw+eYmdMZ9yAzYUL73NmsnJf00Z1fgB2kN0WE=;
        b=ZwbmRny8zmRBcvyGfYFQ4fg5g00e0ow2BFPfmksYuCBfZ7AjxSv3n4k46jJ8wfGDcI
         PcWZuhufrkVZYyOr4s/fIprCgOyGV3uYwz+gDmbpKa+llIPkBTCBJIKOplb2HOh4CRiz
         WFi57rjOJ3iVgKPuAMP2nRWmr4LuWygacXqVrtKuBrR+w6ee9HCBkYArB0+ovbkRMqRh
         aBStOt/RlU4STDMcmyZsKNWRlqVEK6Ap7kihtA9FuArd/3EKFNABk0Iv953oZwR+etgl
         CabLYaEjzp9wSOguhKZRzCvuhShkjUIZx/r6puoI94Gjoj52VayPRMaH69DErGCwN/FM
         SzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GvGclNcw+eYmdMZ9yAzYUL73NmsnJf00Z1fgB2kN0WE=;
        b=E0tzayoNTp9gAesjmFv6OK7pVKLvMA6vH5dUCvjtUEhmTs8QmTBf+7AP4xX6MNC4xW
         7ofOh3Nt8W4koBWT04K1FqvefMFRIIfQ02yUP0p2AohUysmxJ3S0n6rxpjvj+gkjmGEI
         1Enxp4fGVzcAT498ae9J4uKff4FL+nVg8NxH0F0seX5dwvok7T52TiZP9dPk4sb2hTbz
         xyiPXZ6KQD3KCIbjXerGx5VyxyaZjaB4Yf3v6XkKWbjfOTUKOU8fxUbeq1OqQ07Hhiyh
         HCESuHwlBXNlFT8EBWXBJGOO9+aFdkIGFXdEj1b5k5SC7UGg7itvQ2O1ao8O1KJ8rscl
         B35A==
X-Gm-Message-State: APzg51BpiKUeD9xYgrNeKYlExrpnxYRVITol5trm+SS6HQW4R56HkTgE
        uhz4RTc9Xbdm3lLpgZGdh+mQvigp
X-Google-Smtp-Source: ANB0VdZISayKoZFBmLGfN1ZJxCfGaXAzOK/C2IkjTf3GOmDZofDfAHvw8PeOvt6Yndj16LtDp1vXTQ==
X-Received: by 2002:a19:8f8c:: with SMTP id s12-v6mr12085941lfk.83.1537041640936;
        Sat, 15 Sep 2018 13:00:40 -0700 (PDT)
Received: from [192.168.1.18] (bku9.neoplus.adsl.tpnet.pl. [83.28.188.9])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1920380ljc.50.2018.09.15.13.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 13:00:40 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com> <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com> <20180914081822.GA21830@amd>
 <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com> <20180914214220.GA2081@amd>
Message-ID: <be2ee681-7ae0-6545-0208-6ae5c1b7affd@gmail.com>
Date:   Sat, 15 Sep 2018 22:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914214220.GA2081@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

On 09/14/2018 11:42 PM, Pavel Machek wrote:
> Hi!
> 
>>> You may want to learn more about device tree and/or talk to the device
>>> tree maintainers. This is an old article. https://lwn.net/Articles/561462/
>>
>> The article title is "Device trees as ABI". A device tree is defined
>> in the "*.dts" file that is then compiled to a dtb blob, which
>> constitutes the ABI. And this ABI should be kept backwards compatible.
>>
>> What is discussed here is a documentation of bindings, i.e. according
>> to ePAPR: "requirements for how specific types and classes of devices
>> are represented in the device tree".
>>
>> >From the bindings documented in the
>> Documentation/devicetree/bindings/mfd/ti-lmu.txt only
>> ti,lm3532-backlight is used in the mainline dts file
>> (arch/arm/boot/dts/omap4-droid4-xt894.dts).
>>
>> Having the above it seems that there is no risk of breaking any
>> users.
> 
> DTBs and bindings are supposed to be portable between operating
> systems. You are right there are no _mainline_ _Linux_ users.

No mainline users means no users we should care of.
Other people also don't care - see patch [0].

>>> NAK on this patch. I see that this binding has problems, but
>>> introducing different binding for subset of devices is _not_ a fix.
>>>
>>>>> What about the multi function devices? They should have same binding.
>>>>
>>>> The MFD devices defined are not in contention here only the SFD.
>>>
>>> I'd like to see common solutions for SFD and MFD, as the hardware is
>>> similar, and that includes the code. Having code that is easier to
>>> maintain is important, and having many drivers are harder to maintain
>>> than one driver.
>>>
>>> Milo's code looks better than yours in that regard. I disagree about
>>> Milo's code being "nightmare" to modify, and care about "easy to
>>> maintain" more than "binary size".
>>
>> Easy to maintain will be a dedicated LED class driver.
> 
> You mean, 3 dedicated LED class drivers and 3 MFD drivers with LED
> parts? We'll need complex driver anyway, and I'd really like to have
> just one.

In the LED subsystem we can wrap common functionalities
into a library object. MFD driver will be able to reuse it then.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/commit/?h=droid4-pending-v4.19&id=d774c7e447ac911e73a1b3c775e6d89f0422218c

-- 
Best regards,
Jacek Anaszewski
