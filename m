Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D36FECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFA921479
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+Mlxc/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFA921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeJ0HzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:55:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45815 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbeJ0HzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:55:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id s3-v6so1180248pga.12;
        Fri, 26 Oct 2018 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1fmndq06ahonaQejAdyn+z2KwXXsdO3GdJbTk5M1bYA=;
        b=k+Mlxc/1rPyih5DW6TKjdYA2CrljPbJ0ew/JKxMldAv5x7BZIUsF5tNE92/Ws2tmNn
         TRxoY9TY9KWXLCaDX2N+sHUN3SMK3bxZufp/ynU6sPgWZsSAUxrCovWR0aljboaaHhho
         zNcRqMQdtFnje4/7NiDVdiEDJT8hrjqVTWHpJQL/aiTqGSepdNmrD6PuPM5zhtiwwNze
         3HMyalwUVqhQe5kJk9xLnwWqcZ8t/N3H5dGENU6S9bVbqbelQdtUdSOZjYa0b+xyohBl
         u89V121f5yUQIt0H/L22PVen0vfhECdWLA3Wkc6XEPDnqRVyWy8ttYLNlY5wEp3FGVCN
         ft9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1fmndq06ahonaQejAdyn+z2KwXXsdO3GdJbTk5M1bYA=;
        b=MLBIzgzBlvYjJg21CKcVvwCZl6P8w8FAporpC3V8xE6O/25Tzc55a/X1qYy9qCak9C
         65CdlphNiHKDD60FTB+RRctLKCTzmo5kaClrJeRoj3OrcdP7b39ODD2bZl6NtXbnp38a
         m3CGrqGl+6YTHOrfQU5mRGfCf5AvoH2x6OD0TCUyW5KJTc7wVG/rzI6fy9BRrU76N35V
         NHrJ1Na3FavOJ6fk0WH/BfXjQrE8Rlh0EiAObqmXjrKBkL0b9cGPOVexh442VwEXtxHa
         /aGEJLOF35edMOMnTZhqFoacp5aICdhp3USqfPj0yIJ3W1/N50siLDimFv/lIXXsWF7T
         GrlA==
X-Gm-Message-State: AGRZ1gKXWVDh2EkCyA1pDcGkDHZ1i68ajYybSoOuciwMRrWezVAk2JkG
        TgiNSCCEX03C2gk+IUgQXH86IIiy
X-Google-Smtp-Source: AJdET5d6/MzU24ko6fSk5U/2q60QPMQ1po5V2aAtD2xpDe4wDYrQ5nC8GI2FEOjSO2jlQz7jFLiZWA==
X-Received: by 2002:a63:66c1:: with SMTP id a184-v6mr5387708pgc.26.1540595775561;
        Fri, 26 Oct 2018 16:16:15 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id s186-v6sm2071795pfs.164.2018.10.26.16.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:16:14 -0700 (PDT)
Subject: Re: [PATCH RFC] net: dsa: Make switches VLAN aware when enslaved into
 a bridge
To:     Ido Schimmel <idosch@mellanox.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        "privat@egil-hjelmeland.no" <privat@egil-hjelmeland.no>,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        "tristram.ha@microchip.com" <tristram.ha@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20181024193657.24012-1-f.fainelli@gmail.com>
 <20181026151019.GA15354@splinter.mtl.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <27f6afc1-403d-9f11-554e-8ad5b998d0fb@gmail.com>
Date:   Fri, 26 Oct 2018 16:16:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026151019.GA15354@splinter.mtl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 8:10 AM, Ido Schimmel wrote:
> On Wed, Oct 24, 2018 at 12:36:57PM -0700, Florian Fainelli wrote:
>> Commit 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is
>> disabled") changed the behavior of DSA switches when the switch ports
>> are enslaved into the bridge and only pushed the VLAN configuration down
>> to the switch if the bridge is configured with VLAN filtering enabled.
> 
> This is what mlxsw is doing.
> 
>> This is unfortunately wrong, because what vlan_filtering configures is a
>> policy on the acceptance of VLAN tagged frames with an unknown VID.
>>
>> vlan_filtering=0 means a frame with a VLAN tag that is not part of the
>> VLAN table should be allowed to ingress the switch, and vlan_fltering=1
>> would reject that frame.
> 
> While you correctly describe the logic, this is not how VLAN-unaware
> bridges are actually used. The expectation is that packets will be
> untagged when entering the bridge. Either because they are truly
> untagged or because they were untagged by a VLAN netdev.
> 
> For a long time we rejected the enslavement of physical ports to
> VLAN-unaware bridges and only allowed VLAN netdevs to be enslaved. In
> order to support the logic you described, we would need to map all 4K
> VLANs on each port to 4K different FIDs. In addition, each FDB entry
> would need to be programmed 4K times, each time with a different FID.
> This is because FDB lookup is performed using {MAC, FID} and not only
> MAC. I can go into more details about why we cannot map different VLANs
> on a port to the same FID, but I do not think it is pertinent to our
> discussion.
> 
> Eventually, users started complaining about this constraint and we
> relaxed it in commit 65b53bfd497b ("mlxsw: spectrum_switchdev: Allow
> port enslavement to a VLAN-unaware bridge").

Thanks for providing more context, I suppose we will keep the current
logic then, if nothing else it aligns us with mlxsw.
-- 
Florian
