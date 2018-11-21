Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7866EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B09A20878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaEXx/0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B09A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbeKVHIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:08:20 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52331 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeKVHIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:08:19 -0500
Received: by mail-wm1-f43.google.com with SMTP id r11-v6so6803668wmb.2;
        Wed, 21 Nov 2018 12:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZDNpzCU+EsoDZ857ASMZVtKmYhKP1SV8EHH5PU77BnA=;
        b=CaEXx/0s54wenJ3aXKIF4vsOW607ou6sWUY39bP3+6IzFW1wautX7KmX85Y+9UBo/h
         brBHuW3GkeKTKGdz48m64wETxY+GRFsNNKYnpus3pgNkawTQw12Uxoz3uj6/PYIV1zHd
         asTZRqa9jOLZ+GibrUueUUGvpcdrFGPNuYypVXX6iHnjiOz/U2roJ5GXaRxTuYAmyCGe
         nYfCImNWHWb1bXLOiIFGjYMm9Hp30MFKJ1N0flfqbJykxYGDre0xARHpwYPBVGnSNV61
         QRHp44PdPRvduqCH+JbEtSiHWR5clYiyy3UYHGO2QxEZu/FNROV+SXu4/NvswWHJqGv8
         bOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZDNpzCU+EsoDZ857ASMZVtKmYhKP1SV8EHH5PU77BnA=;
        b=rlli2GS7Zb+AO6esjRqaMHntQMMUethubLnxUsxfOgQf5IB+XO3ZJeFLjjmqtBWH7x
         OdOshkOHz7KzWrC4VtaOhDu3JUF1N0hsCIUVy4qF2YqjY8LCVc6xVLU0dGl/DKKIRPXW
         T4QuEkGQeDS1m5ryjOUATdyG27NjaBQ+6CSGzPDzwoP+ZnsNB5zXEAXmYqh69cEBcVso
         TAPExwL2Qg4DV8yh/34Y16QazT3CYc9LGYyqHcPN9QuzvSEgS9e5OToWjXuemE7TABke
         OBmOpqFTQbC6uon9N3U3AGu/8hihbAXMY4mnK4hwD4ygz8Ure07SNa3swnsHqyoNxsrZ
         LdtQ==
X-Gm-Message-State: AGRZ1gIKSaJHKPZIwh+ha5qegDL3tkLVIQqd5a3ProzpWFWUmWz2zV1s
        J/sxsccfabg5Q5Z5dvMTwzc=
X-Google-Smtp-Source: AJdET5eesM8OE/Negg9pL8qkkO/S45J9dpFYbE5PKjaDxszo8/zXj2EO9vckIszBou8cQGEaOAwjDQ==
X-Received: by 2002:a1c:cf0d:: with SMTP id f13mr6971752wmg.70.1542832346658;
        Wed, 21 Nov 2018 12:32:26 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:14d:188e:adb0:9ba6? (p200300EA8BCFE300014D188EADB09BA6.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:14d:188e:adb0:9ba6])
        by smtp.googlemail.com with ESMTPSA id z8sm29546270wrr.52.2018.11.21.12.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:32:26 -0800 (PST)
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Norbert Jurkeit <norbert.jurkeit@web.de>, nic_swsd@realtek.com,
        Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.wiktowy@gmail.com, jcline@redhat.com,
        marc.c.dionne@gmail.com
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de>
 <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
 <20181121202034.GA10697@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <eda84d0b-2d9f-07ae-34a1-767bc5200964@gmail.com>
Date:   Wed, 21 Nov 2018 21:32:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181121202034.GA10697@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2018 21:20, Andrew Lunn wrote:
>> request_module() is supposed to be synchronous, however after some
>> reading this may not be 100% guaranteed. Maybe the module init
>> function on some systems isn't finished yet when request_module()
>> returns. As a result the genphy driver may be used instead of
>> the PHY version-specific driver.
> 
> Hi Heiner
> 
> That would be true for all PHYs i think. We would of noticed this
> problem with other systems using other PHY drivers.
> 
> 	Andrew
> 
It could be a timing issue affecting certain systems only. At least
for now I don't have a good explanation why loading the module via
request_module() and loading it upfront manually makes a difference.

One affected user just reported the PHY to be a RTL8211B. This is
what I expected, because this PHY crashes when writing to the MMD
registers (the MMD registers are used otherwise by this PHY).
See also commit 0231b1a074c6 ("net: phy: realtek: Use the dummy
stubs for MMD register access for rtl8211b").

Let's see whether the other affected systems use the same PHY
version.

Heiner

