Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7171BC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37892214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="az9Zainq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37892214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbeKVFmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:51 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34462 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbeKVFmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:49 -0500
Received: by mail-yb1-f196.google.com with SMTP id a67-v6so1093949ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FXmZyDQrnB/R7IwvmEFezSUeuxMTKCF1MIbIMhJN7jA=;
        b=az9ZainqXrHwwihNYqz79e1us+ISRyKSt5879HJ+wYiPLp16zO/U81+dxKN8/cFTeq
         oquWMc/h6tKULr/zjAXoJSStwF2fqpX5IDnPe0pMXfIaSqAqnzLVeZ/66wU44oMcr2Kb
         rKGbCDdxuZaed8ZYKqQDmsxSV5BnnVPCpS+kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FXmZyDQrnB/R7IwvmEFezSUeuxMTKCF1MIbIMhJN7jA=;
        b=bShXtEyP0BKy4dTBjTzYRwG15SMHSgzTT3iW39b7GcBU4UniLgZfPef+UbGX8mrLie
         fbm6qIQPnLeqTcYitSm9p78+YzP1H2yOuN4Bfqd6yEyqHO4Jbgr4CKIFlKkeH52M7VhI
         LZGmWp0dcs9NEN2HXAaZwTmnzs6iF4d7O12c6r1W67XKu/NoGmhpizoaHF6h4HFgxjuw
         7kkiMNEnXMdnAN8tL0Dr89Kyv0kDqKtJSbW1b4cJ66aOcglaXccEiddk3yIgpVK2YBvG
         zoeTMg5ysw1sxOD5H6+r08v+Qefitf/9uNLeYUPIYG+Lsoh/fvVT6tIiZ+bbSageI/gd
         a6Ww==
X-Gm-Message-State: AA+aEWat/AjWP1TBDZjFOWCzP5+OkUedGW9RD34nUhhweLlxyZW9xoej
        6dIuinJoK6daQaGVCLNaLndOK5MOrmBz5STO
X-Google-Smtp-Source: AFSGD/W/B/7lSCYn1Aytx/8QVEGpCopOsoLZJs9Z7ZKGznHlqagz/Ko4RG+UgwxhIMollmROdQjUpA==
X-Received: by 2002:a25:13ca:: with SMTP id 193-v6mr7743888ybt.468.1542827236545;
        Wed, 21 Nov 2018 11:07:16 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w70sm13151964yww.76.2018.11.21.11.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:07:15 -0800 (PST)
Subject: Re: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181121123508.25119-1-peron.clem@gmail.com>
 <29dc5815-e897-ca7d-0e26-668faa635938@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <dcadd42d-1ef6-732b-400c-8008bc4fcd0a@broadcom.com>
Date:   Wed, 21 Nov 2018 11:07:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <29dc5815-e897-ca7d-0e26-668faa635938@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-11-21 11:00 a.m., Florian Fainelli wrote:
>
> On 11/21/2018 4:35 AM, Clément Péron wrote:
>> The Cygnus architecture use a Kona PWM. This is already present
>> in the device tree but can't be built actually. Hence, allow the
>> Kona PWM to be built for Cygnus arch.
>>
>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Scott Branden <scott.branden@broadcom.com>

>
> The "default ARCH_BCM_CYGNUS" could arguably cover ARCH_BCM_MOBILE as
> well, but this is not probably worth a respin just to address that.
Yes, it's fine as is.
>
>> ---
>>   drivers/pwm/Kconfig | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 27e5dd47a01f..982f4059f4e8 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -88,7 +88,9 @@ config PWM_BCM_IPROC
>>   
>>   config PWM_BCM_KONA
>>   	tristate "Kona PWM support"
>> -	depends on ARCH_BCM_MOBILE
>> +	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
>> +	depends on HAVE_CLK && HAS_IOMEM
>> +	default ARCH_BCM_CYGNUS
>>   	help
>>   	  Generic PWM framework driver for Broadcom Kona PWM block.
>>   
>>
