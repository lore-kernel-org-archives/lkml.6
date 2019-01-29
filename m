Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F92C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E552148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9eGdkZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfA2GWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:22:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40554 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfA2GWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:22:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so20651017wrt.7;
        Mon, 28 Jan 2019 22:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OulpkHK1W3wCTLsa4tU3WH70de/mnFZqHAE3uaFmX6w=;
        b=l9eGdkZKEOKb8oFOCEU9/fk2n3CZLgcW3EjimVJqv2LtNC8uZixzSW4x+sFlBBa/LV
         l13OZTNnKkIK3HwTCHeWLSrVtcjJNXZpw86UAvwBMdgVoUqUZvQ1eEnUu2+CCOVyggOa
         2pmyRaXBFJ6FXfZnoyXwaWY/5Vm22oXiZusfSgbjcAkietIYuWHABK+fDvw7xjU9csqF
         EGre3OZ4sAV4oDyWjsQsQf6YP1RkzjVXqs8SlXpa0UaWvulz/mbhtBby98SLYRV7S9iz
         9eSl/Kk6cWv9ZoelwcFbczhxDI54iRNii4l5ZaBqYtiaoxgJG8ICdhgCUCWpPY7T21/u
         8KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OulpkHK1W3wCTLsa4tU3WH70de/mnFZqHAE3uaFmX6w=;
        b=RLNjKj9srbIHMAccnmpnATAxKWiJJ7VFQe9SfOUY0UEsHazv4dDJVAnkAP3HIbOtq8
         zYEe4xA+KEog4brEaLrFy96OO2di50H1EFB7wizNZ84FT/eqseikNMgVWLVchEQIh8uB
         B7wP7sppsfA3SaV8E6iSNTpsuPETfDbU4BUvkXkkMoTtF7qPOWi8WBL2r44oWwjYWB39
         U1FLO6eMM8XAd2X4rX8D2+xRgH7jZwPfnelLmOssB8CUMUYOzqqLz6PZOobEXnRJ9alA
         tl/6qMAb7Um6WrKvdJH7IWvWpvB0lm9DZ3Nkv5ZzZCGuBb7oZFpbBrVeq4WBAwwjAu1e
         +aKQ==
X-Gm-Message-State: AJcUukcHm7/psTjw+4WF66ErfMSgkjAaMcIoCu409CBfH2riteHiq3Ek
        MvvbKuZCT5kiyJzj0spVn1U=
X-Google-Smtp-Source: ALg8bN4X7PD0aSauo6zQkOg/DTN1q1hXljZgcGiFO66APcZM/rsUbnTWm9ZM3sPVuE/AI1BqJZHJwQ==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr23456399wri.210.1548742957563;
        Mon, 28 Jan 2019 22:22:37 -0800 (PST)
Received: from ?IPv6:2001:16b8:a03b:5a00:437e:83f9:772d:3f24? ([2001:16b8:a03b:5a00:437e:83f9:772d:3f24])
        by smtp.gmail.com with ESMTPSA id 129sm2449223wmd.18.2019.01.28.22.22.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 22:22:36 -0800 (PST)
Subject: Re: [PATCH] pinctrl: mediatek: fix dependencies for PINCTRL_MT76XX
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190128223521.2690-1-voytikd@gmail.com>
 <CAGp9LzoVZQx2fb-ETY=sGBB3Xx81jC8t2krczv7h=dVNE-ph2Q@mail.gmail.com>
From:   Dmitry Voytik <voytikd@gmail.com>
Message-ID: <3e1acf90-9975-12cb-5e78-24e4bd03b507@gmail.com>
Date:   Tue, 29 Jan 2019 07:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGp9LzoVZQx2fb-ETY=sGBB3Xx81jC8t2krczv7h=dVNE-ph2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/19 6:02 AM, Sean Wang wrote:
> On Mon, Jan 28, 2019 at 2:35 PM Dmitry Voytik <voytikd@gmail.com> wrote:
>>
>> How to reproduce the problem:
>> $ make tinyconfig
>> $ make menuconfig
>> then enable:
>>  CONFIG_COMPILE_TEST=y
>>  CONFIG_PINCTRL=y
>> and any of these:
>>  CONFIG_PINCTRL_MT7622=y
>>  CONFIG_PINCTRL_MT7629=y
>>  CONFIG_PINCTRL_MT7623=y
>>
>> This combination causes build failure.
>>
>> Fix the problem by making PINCTRL_MT76XX to depend on CONFIG_OF=y.
>>
>> Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
>> ---
>>  drivers/pinctrl/mediatek/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
>> index 1817786ab6aa..a005cbccb4f7 100644
>> --- a/drivers/pinctrl/mediatek/Kconfig
>> +++ b/drivers/pinctrl/mediatek/Kconfig
>> @@ -45,12 +45,14 @@ config PINCTRL_MT2701
>>  config PINCTRL_MT7623
>>         bool "Mediatek MT7623 pin control with generic binding"
>>         depends on MACH_MT7623 || COMPILE_TEST
>> +       depends on OF
>>         default MACH_MT7623
>>         select PINCTRL_MTK_MOORE
>>
>>  config PINCTRL_MT7629
>>         bool "Mediatek MT7629 pin control"
>>         depends on MACH_MT7629 || COMPILE_TEST
>> +       depends on OF
>>         default MACH_MT7629
>>         select PINCTRL_MTK_MOORE
>>
>> @@ -92,6 +94,7 @@ config PINCTRL_MT6797
>>
>>  config PINCTRL_MT7622
>>         bool "MediaTek MT7622 pin control"
>> +       depends on OF
>>         depends on ARM64 || COMPILE_TEST
>>         default ARM64 && ARCH_MEDIATEK
>>         select PINCTRL_MTK_MOORE
>> --
>> 2.20.1
>>
> 
> It seems the commit 2d2d478576d71000b29c52668c5712c825ee9af8 already
> fixed the problem or is there something I'm missing?
> 

Opps, sorry. Should have checked linux-pinctrl.git.
Sorry for spamming.

BR,
Dmitry.
