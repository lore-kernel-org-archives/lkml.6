Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939F920C51
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZAYK9S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939F920C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeHPEYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:24:43 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37705 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeHPEYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:24:43 -0400
Received: by mail-oi0-f65.google.com with SMTP id j205-v6so5271011oib.4;
        Wed, 15 Aug 2018 18:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yXP1jPSQg60pXT7IG6zEKr5fjnrv4hGwHPnSE9uF7l4=;
        b=PZAYK9S6Xfnp7cEMx7ZNcltvVWdBArSP8VB1niEZtoi1MNLvg8W8Tp+Ul0dbMg0iw/
         V529sobZduE6+S50BPwSdgYu4MVAXa+kww8mo9HSJ0M1wQweznZAQf9FIGwbKvLZ05jJ
         z3D9mvmox/5ehmR7PtBnW1TPZuCBSL2Oxu5qHKKNzfmm65oGPvBSVmupJILRa+0YzkOk
         O7QVsjJ64l15GmKbIlL5quho3FlOwQExAWdWkoQ7oSBmKSWk/eDZz529QycY1gpo+z7y
         FD1atPBczyxycu7cNg6pf9QRFeopSm0Y/eCFOxALurBT/kSxZ3YMuqrXtvacEk6iPYKc
         8bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yXP1jPSQg60pXT7IG6zEKr5fjnrv4hGwHPnSE9uF7l4=;
        b=NU8mnGcE+aakcSqt13ola87YfWtx/RVS91n92kpnywK74a1dZIwdU9LE6EzYz4Prgm
         V3X40iljMtw57PBUL9vE7IqB4v07gI7t5Ed3SGijuBKJmfQEaRQWQsqJ+uwHMLvuFomE
         qCibFPmiLVsqVoWPlSpveIOfWtkOU4UfDEMn8O7J/ADWJmXUNeoyclS9krcgEBMsWyjw
         kumvneNn94kmK+mOjrXC759yYyzNWPBtPCCW7aHZM4cR3jvKYzFZwJRnWkH0gY1m3AzS
         64oPRcnj5JXLK2MtBoM0epXsePhXPge89x8PUZhUcBnh1wxGje17MMVQDI4hYYFLTlym
         y2pg==
X-Gm-Message-State: AOUpUlES0p8GEC6mgqZP/S/5F56eAkACtlWeIO6v7NFFN54SBwKaMePe
        0ijptq/Fkq9+M2O/ug9zEe+d/MNXY6g=
X-Google-Smtp-Source: AA+uWPydfE2VwGKIKNoe9l4QvCxQa5FQY6oS9mY9rvpE+GKPpNOpA8LkD7cgmlCoUDW24eeoTWCsDw==
X-Received: by 2002:aca:1802:: with SMTP id h2-v6mr30310930oih.353.1534382990764;
        Wed, 15 Aug 2018 18:29:50 -0700 (PDT)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id w204-v6sm38501636oif.2.2018.08.15.18.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 18:29:49 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/6] ARM: config: multi_v5: enable dynamic debug
To:     Joe Perches <golf@perches.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
References: <20180814140612.12554-1-marcel@ziswiler.com>
 <9461e62248cc7c1b5585004ff8cf7268b823e29c.camel@perches.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <f20387e3-4cce-78eb-886c-03ab8c39ae42@gmail.com>
Date:   Wed, 15 Aug 2018 18:29:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9461e62248cc7c1b5585004ff8cf7268b823e29c.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/14/2018 07:16 AM, Joe Perches wrote:
> On Tue, 2018-08-14 at 16:06 +0200, Marcel Ziswiler wrote:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> Dynamic debug is really helpful.
> 
> It's useful, but perhaps not appropriate.
> 
> Most arm configs are for small resource constrained systems.

Yes, but multi_v*_defconfig, by definition are not, so this really seems
acceptable to me here.

> dynamic_debug adds a lot of additional text and a fair amount of data.
> 
> 
>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> ---
>>
>>  arch/arm/configs/multi_v5_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
>> index 318b76fa26d1..b302ac68d587 100644
>> --- a/arch/arm/configs/multi_v5_defconfig
>> +++ b/arch/arm/configs/multi_v5_defconfig
>> @@ -275,6 +275,7 @@ CONFIG_NLS_CODEPAGE_850=y
>>  CONFIG_NLS_ISO8859_1=y
>>  CONFIG_NLS_ISO8859_2=y
>>  CONFIG_NLS_UTF8=y
>> +CONFIG_DYNAMIC_DEBUG=y
>>  CONFIG_DEBUG_INFO=y
>>  CONFIG_DEBUG_FS=y
>>  CONFIG_MAGIC_SYSRQ=y
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Florian
