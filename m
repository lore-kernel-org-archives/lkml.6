Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC686C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E091208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3dlC9PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E091208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJCBhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:37:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37485 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeJCBhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:37:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so2245842lfa.4;
        Tue, 02 Oct 2018 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h8ZRaxo66HYhdZG8+z/WI/w1O3d9MxngUdeLFT2xV6Q=;
        b=h3dlC9PNWO4LwPF7au/5XdlfWTgwFYbcvWqZcTkMfW+wxKnAlPhVVhz8Zgvje6TtGp
         D4P/ms745DW83yW158wHrfCl3iSdEjM4rlDjseBjUEhVcO2DC023lYd1uj+QCl4dmocH
         eKTreLKIYR79OaoowrRYSSaeAPd12HcT9L8C/LMvlWWOlI39GspP4HtRijIN/73Tg/um
         wl5O4GZqoFWK4rqyLiFBaF6X5XXfeLqz3F/BJTaRZDxVYmPA3VEUc9MpXSaaRY+dyfXj
         laAwIS9ngNbb4HE1miGwb0AFQ0vP9JzHxDq8bFMhyYvXaU+/gLMpob3bEzp4lYQPWWXF
         lmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h8ZRaxo66HYhdZG8+z/WI/w1O3d9MxngUdeLFT2xV6Q=;
        b=RC0IVtIL1gOaU5LqQ10fxwCwG+/xMPigcj5fcrVlO3nEebqxoXvqQl1L2JGc1ZSDPR
         9oIAnzKhdjuvYRBJ021TSrH5fxzHqFV7AoDrXdif89lYBBD9vAYa9Hgzf1yfkigNqH05
         C3QfS4dd4FnGKUOVP98OH9uZfEI98bdSRVZw7xlFqcDHfarSFoVSGNGUByyOReFdWzHf
         /A4U9sIHqsCV/wedGQm9zCGVMlVrMI1eNRCQjoiSUvnezRE7IywsnZIoAce7gtQ0Lpm1
         /1cRJh9U7T+V3cSBS58lblKH69MVFyr2e4p50y+899ARxFZ6ymZ//SExqAEYGmRJph8A
         fdgQ==
X-Gm-Message-State: ABuFfohAwhzfPcmbohy87KLEGo0p/ZQ8dGWdbuMDQKHQ38lbg6KtaUlM
        HZxsGau8XxaEEDulhr11m2c=
X-Google-Smtp-Source: ACcGV61dmT5GJTlqkpKJpfhAMLA+GHca/XXLprzEmsAmg/eNSHsOau26OdyIRDHycbiuxeXvSs/rzg==
X-Received: by 2002:a19:1588:: with SMTP id 8-v6mr9468534lfv.36.1538506333542;
        Tue, 02 Oct 2018 11:52:13 -0700 (PDT)
Received: from [192.168.1.18] (dkq108.neoplus.adsl.tpnet.pl. [83.24.20.108])
        by smtp.gmail.com with ESMTPSA id e67-v6sm3378732lfg.2.2018.10.02.11.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 11:52:12 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux-omap@vger.kernel.org, linux-leds@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com> <20181002075629.GB19677@amd>
 <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com>
Date:   Tue, 2 Oct 2018 20:52:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 02:32 PM, Dan Murphy wrote:
> Pavel
> 
> On 10/02/2018 02:56 AM, Pavel Machek wrote:
>> On Fri 2018-09-28 13:29:46, Dan Murphy wrote:
>>> From: Pavel Machek <pavel@ucw.cz>
>>>
>>> This adds backlight support for the following TI LMU
>>> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>>>
>>> It controls LEDs on Droid 4
>>> smartphone, including keyboard and screen backlights.
>>>
>>> Signed-off-by: Milo Kim <milo.kim@ti.com>
>>> [add LED subsystem support for keyboard backlight and rework DT
>>> binding according to Rob Herrings feedback]
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>> [remove backlight subsystem support for now]
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> So... this driver adds support for LM3532, LM3631, LM3632, LM3633,
>> LM3695 and LM3697 (or it did when I signed it off).
> 
> Yes I have to pull these out of the patch.
> 
>>
>> The rest of the series does not really bring any advantages (you claim
>> it may add advantages in future). It takes code out of common driver
>> and duplicates it.
> 
> 
> I disagree.  Honestly using that ideallogy all LED drivers should use the common code
> as it is a wrapper around regmap and a few if statements.
> 
> The 3632 adds the proper LED flash class support coupled with proper backlight support.
> The 3633 adds the proper support for LV and HV LED support.
> 
> Duplicate code that I could find is put in the common file.
> This patch set adds the LED devices as all other LED devices are added in the LED directory.
> 
>>
>> Could we take this patch, get the basic support for LM3532, LM3631,
>> LM3632, LM3633, LM3695 and LM3697, and then split out the drivers when
>> we actually gain some advantage doing so (and also when the costs are
>> clear)?
> 
> We have debated this over and over and now we have 3 different implementations
> available we need to collude on which one we want to support.
> 
> Jacek I defer to you and Pavel since you are both LED maintainers.
> 
> I can support the dedicated LED drivers but I cannot support the TI LMU only implementation.

I uphold my previous opinion - please go ahead with moving the support
for non-MFD devices from MFD subsystem to the LED subsystem. And yes -
along with the bindings. This is semantically correct, and yet we don't
have mainline users.

Pavel - you will have to engage more people for your crusade to prevail.
For now, to speed up the things, I am forced to ignore your NAK.
So NAK to your NAK. Sorry.

-- 
Best regards,
Jacek Anaszewski
