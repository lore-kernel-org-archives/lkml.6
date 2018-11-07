Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7CDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5920862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MHAxmtBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D5920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbeKHCT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:19:27 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37160 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHCT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:19:27 -0500
Received: by mail-yb1-f194.google.com with SMTP id d18-v6so7107138yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=l4MR/yOzdaiu3RpU/lV7h41WnaZXbr8Qd0ZxkXDndnI=;
        b=MHAxmtBdrLOpj/+G6QszVt5hzyJJAMuZ9wtPMwwVM73DEAZ7Q7JbE6eRSJdqa94cG9
         RKtcn8fxOcITsEDvKrSTWXp/kYJFzMVJDm99jdhMNo06KF2jO7Fk3jb11GvI2OXeVO09
         /UbfTSiNqwEQxkwuy3wFHtqNrBphX9kvgIUCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l4MR/yOzdaiu3RpU/lV7h41WnaZXbr8Qd0ZxkXDndnI=;
        b=mJSgjsWw6yWg7gtHTiEllcaShpGjU5F/dj5MVXoGFLNeD0d05PAgWJil0fIp4bhUIx
         ft55H4GvhDrqz2Ut/l4N+HhAiUfFzpuxCA9051IBC5B73HR5nzdZHnPLoKg1XS+tHj5n
         ngjqvkoS9bZKYALcuB+BBcwzJi0nv0ykQMgfZHKWuB8soSpaJkRGWExe5uAGYO0KOmAF
         m80I0h/+cjHg2VsGd435GMB2XZGvEsCSN9f1Jq3BrVsq7hH8wS3suqt99/nFaAW2giOF
         VK12YXojeJapxUW53D7CQTo+sY1N4so5HTJVNrT50lmO8QfYCXVPyfQk3bYIUwi65DDS
         NvUw==
X-Gm-Message-State: AGRZ1gLVZ+l1sm6z0uTTJYaenxpIvIG4B9ugmRrN38NrfUmlsMsryOGs
        be1EkXiCFW/aflnTfvWUrcHQ6EzofwJbnYIk
X-Google-Smtp-Source: AJdET5cRk/YqzTBW7UM4kWNm0y9JIOB+6gMyb4TS8v129Hp3N4Fp/PGHDg97uspZQ1x7mo50Zow8lw==
X-Received: by 2002:a25:c781:: with SMTP id w123-v6mr957761ybe.135.1541609296891;
        Wed, 07 Nov 2018 08:48:16 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 10-v6sm267894ywt.47.2018.11.07.08.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 08:48:16 -0800 (PST)
Subject: Re: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181107093613.26734-1-peron.clem@gmail.com>
 <20181107161247.sesu2comhes2d4kx@pengutronix.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com>
Date:   Wed, 7 Nov 2018 08:48:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107161247.sesu2comhes2d4kx@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-11-07 8:12 a.m., Uwe Kleine-König wrote:
> On Wed, Nov 07, 2018 at 10:36:12AM +0100, Clément Péron wrote:
>> The Cygnus architecture use a Kona PWM. This is already present
>> in the device tree but can't be built actually. Hence, allow the
>> Kona PWM to be built for Cygnus arch.
>>
>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
>> ---
>>   drivers/pwm/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 763ee50ea57d..76d56fc8b1b7 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -88,7 +88,8 @@ config PWM_BCM_IPROC
>>   
>>   config PWM_BCM_KONA
>>   	tristate "Kona PWM support"
>> -	depends on ARCH_BCM_MOBILE
>> +	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
>> +	default ARCH_BCM_CYGNUS
> Is it possible to build this driver also on other arches? Then you might
> want to consider
>
> 	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
good idea to add the COMPILE_TEST just to increase compile coverage
>
> Best regards
> Uwe
>
