Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38541C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4BA20878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucfbhv6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4BA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbeKVH2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:28:19 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35788 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbeKVH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:28:19 -0500
Received: by mail-wr1-f44.google.com with SMTP id 96so7120340wrb.2;
        Wed, 21 Nov 2018 12:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxDiRSde1dR+A9EgYOp57mlXagmRux/muba4EEXkYzc=;
        b=ucfbhv6n54hKl/584JiiJInsd6NMd7SgVXdsBdHYxCMk8yzrvVrnwPbNxUOLwln6I9
         UECbFH6nhr6faHm6lGQlCBKoWB4YgEtl6fUQ4wjr3sh1JiCKJUd8t9iE9F5SqhKy+ilu
         uqm2iewFW1uKkrUKeMRIUqiCyyRtT7FJPFvasjhvewfEryDJEzFDnh+miATjku98QqdZ
         ztNNv1xAJ73vFC1OyaXQz/CqhuoyhHaLEg8ic+5O8cTNB2AIgZdLB8ltv47GJ+RPuLqh
         ploFpQ4+xFh9dvbkBVFR2NrPbkEI+9fIbWd6E4WrauiY1vW8wY+UenNhvmi5KEhR7IcR
         mLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxDiRSde1dR+A9EgYOp57mlXagmRux/muba4EEXkYzc=;
        b=SEdSqYgIDEY619QqIiiBkZTId+9b7hCMfRufj/0OwYi6km70g7apiNgpzRoPG1uulj
         2i/V/YAg/r+XVZDp3U7+JIQ5YWp6s020cZAU15R4wz2Kjk+5M75qHGpfgFeS2i+FaRdI
         3GO7ctyeKkx3H1+DVbC5aLP9Qsu1HgvAFYydD91LP1a6i+xELTMb2g9ZpCGrX9PsStk7
         RXevajRPfSXk9/zq9tsa9EjaTQDymo5Gv43yDcPyJ7FhvVO2HDa2AFgjjEqD7odKWhj3
         aZ+5gv38wenn43OJMR+6uhCljFxLSeWSO0Om9xoGDk5zTx4Sw7Lx6suXkv39m2mAemCZ
         r1pg==
X-Gm-Message-State: AA+aEWZw/ZqcRPhQhSZIzcmDpwve11ZBjHWj7YUSkdz7KYxTLmDYjsX5
        THWEE5OHwJk861hVkbWB0GWNOZAt
X-Google-Smtp-Source: AFSGD/WYYhAMF4e3RpK74xj5xcbrYlIWL3xjjWVojQhPW3/89rp/KZHZYr4oZe+J8aqHRfHl8hwvbg==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr7266603wre.13.1542833541176;
        Wed, 21 Nov 2018 12:52:21 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:14d:188e:adb0:9ba6? (p200300EA8BCFE300014D188EADB09BA6.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:14d:188e:adb0:9ba6])
        by smtp.googlemail.com with ESMTPSA id c188-v6sm1038154wma.39.2018.11.21.12.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:52:20 -0800 (PST)
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Norbert Jurkeit <norbert.jurkeit@web.de>, nic_swsd@realtek.com,
        Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.wiktowy@gmail.com, jcline@redhat.com,
        marc.c.dionne@gmail.com
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de>
 <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
 <20181121202034.GA10697@lunn.ch>
 <eda84d0b-2d9f-07ae-34a1-767bc5200964@gmail.com>
 <6aeba3d6-2292-1221-9be7-1c0bb7cbc203@gmail.com>
Message-ID: <7d6362e1-e197-d338-d6b0-9036c3802e2c@gmail.com>
Date:   Wed, 21 Nov 2018 21:52:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <6aeba3d6-2292-1221-9be7-1c0bb7cbc203@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2018 21:49, Heiner Kallweit wrote:
> On 21.11.2018 21:32, Heiner Kallweit wrote:
>> On 21.11.2018 21:20, Andrew Lunn wrote:
>>>> request_module() is supposed to be synchronous, however after some
>>>> reading this may not be 100% guaranteed. Maybe the module init
>>>> function on some systems isn't finished yet when request_module()
>>>> returns. As a result the genphy driver may be used instead of
>>>> the PHY version-specific driver.
>>>
>>> Hi Heiner
>>>
>>> That would be true for all PHYs i think. We would of noticed this
>>> problem with other systems using other PHY drivers.
>>>
>>> 	Andrew
>>>
>> It could be a timing issue affecting certain systems only. At least
>> for now I don't have a good explanation why loading the module via
>> request_module() and loading it upfront manually makes a difference.
>>
>> One affected user just reported the PHY to be a RTL8211B. This is
>> what I expected, because this PHY crashes when writing to the MMD
>> registers (the MMD registers are used otherwise by this PHY).
>> See also commit 0231b1a074c6 ("net: phy: realtek: Use the dummy
>> stubs for MMD register access for rtl8211b").
>>
>> Let's see whether the other affected systems use the same PHY
>> version.
>>
> Next report is also about a RTL8211B and as I assumed:
> - W/o manually loading the realtek module the genphy driver is used
>   and network fails.
> - W/ manually loading the realtek module the proper RTL8211B PHY
>   driver is used and network works.
> 
> So it seems that even after request_module() the PHY driver isn't
> yet available when device and driver are matched.
> 
> If further reports support this (pre-)analysis, then indeed it
> seems to be a timing issue and a proper fix most likely is
> difficult. As a workaround I could imagine to add a delay loop
> after request_module() checking for a Realtek PHY driver via
> driver_find(). When adding one small delay after this we should
> be sufficiently sure that all Realtek PHY drivers are registered.
> 
Uups, no. We talk about phylib here, not about the r8169 driver.
So we need a different solution.

>> Heiner
>>
> 

