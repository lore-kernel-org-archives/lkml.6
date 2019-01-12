Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD35CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA72720835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hZbJUPab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfALAAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:00:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35963 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfALAAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:00:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so7672404pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 16:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DIb5ZZ61dhJIsm5eebZpvwyPOg9fvjGO5QFZAz5c3pU=;
        b=hZbJUPabkl9in2iiBjnWYzk8UbY26yaewu/ypOFm1xJvr/GG94DumCeDxXm/TC7w4W
         Cn9JS2USdW6L2VKDg4m5jskquiuO4FHOrPSqkdii2aaVVApSokYhgTJXfdTh0pF//osU
         XyMTo5a9Wq3xbRKi+YfVxyZwIBZ0fM/xsYLvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DIb5ZZ61dhJIsm5eebZpvwyPOg9fvjGO5QFZAz5c3pU=;
        b=YAiqLh+UWkfbUoTtt401BvgSPOm2Cp1uhHaSPq8LqbKRlyDTplzUz7Q1BOlLpsBQgv
         C6Nr8/8zFT1pSpczTco9Xhq0+t6Z/j3KibNMJcYYkIDjgqB/NP9lwbkFQSU+PexiBg1W
         HUKxgAGZwgQxige3kw6SeEM0UVy+tkpNTN6QnFm27vWlq1MCI2hjjiqOsWWCSCm75RDE
         kDrdlJuOgd5D+gXhGiG1ITK/7VEiKTyv108UxOiwdo5TUpvipei7lBgV1TLSBQ2FT5C+
         KxoW/a3JyNRxXSd/M2+EOQ2S4k46sVHj6P9Dah/iR6B4kNz/gwU5zIuYuh3j9DCzpPCU
         cdhg==
X-Gm-Message-State: AJcUukeWB461UcJnJBO5MH+lyzjeLH3l7PCrMJn2B7Wx8imHVOBZ+9Ec
        CkCs1BuijfYVCpjUy8QFbqlS7w==
X-Google-Smtp-Source: ALg8bN4Q/mF7DRfyKP6GSmsmR4tjPIiDsgaCYqss7xOssnsfPRn/ohM8P/D1V1G6RiMqtsTTcjBrZQ==
X-Received: by 2002:a62:9f1b:: with SMTP id g27mr16055565pfe.87.1547251206166;
        Fri, 11 Jan 2019 16:00:06 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v9sm115020476pfg.144.2019.01.11.16.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 16:00:05 -0800 (PST)
Subject: Re: [PATCH INTERNAL V3 0/3] Add support for PWM Configure and
 stablize for PWM kona
From:   Ray Jui <ray.jui@broadcom.com>
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <4678b237-d0df-ef85-182f-759125a5c085@broadcom.com>
Message-ID: <2b177b2c-e7f1-791b-087c-b01d9b81f923@broadcom.com>
Date:   Fri, 11 Jan 2019 16:00:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4678b237-d0df-ef85-182f-759125a5c085@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2019 3:58 PM, Ray Jui wrote:
> Please remove 'INTERNAL' in all of your patches and cover letter.
> 

Never mind, saw your next patchset with this issue fixed....

> On 1/10/2019 9:08 PM, Sheetal Tigadoli wrote:
>> Hi,
>> 	This patchset contain support to make PWM changes configure
>> 	and stablize
>> 	Following are brief changes done
>> 	a. Add support for version2 compatible string
>> 	b. Change PWM config and stablize delay in PWM Kona
>>
>> Praveen Kumar B (3):
>>   dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
>>   drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
>>   ARM: dts: cygnus: Change pwm compatible to new version
>>
>>  .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
>>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
>>  drivers/pwm/pwm-bcm-kona.c                         | 128 ++++++++++++++++-----
>>  3 files changed, 100 insertions(+), 32 deletions(-)
>>
