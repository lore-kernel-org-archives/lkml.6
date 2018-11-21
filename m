Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C52C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253F6204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWwKBhGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253F6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbeKVHZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:25:43 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45779 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeKVHZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:25:42 -0500
Received: by mail-wr1-f41.google.com with SMTP id v6so7076539wrr.12;
        Wed, 21 Nov 2018 12:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=346XCBRRQI0U8VUrVFMaflldXA9IwQC48vwIUtejHmg=;
        b=sWwKBhGk4upkcaRDP4orlbG1JyBBbvSzxnpXj8AdAx8uvATul7MNZ1Sk2TPJlV8Vh8
         0t6fcUsIQrCzoSPqnYzB4GOV6YwvLL8uD7vixlOtTEQKejzzLq3u9uoB3NkPL3b4tqIt
         6c2Px5Yx9rcfUqzMP3ApHSfDqkVe7Q4+8XSahemwkeVnkvbi1naDPoLWC+ByoRhEgeQw
         UocnhK9dhd9CKhIZxEiVeZ43euINYVUVMjxaVIO6K2+qwt0AprXwr2Cx4SEEsiR9C5G4
         +6faCUkqH/qO+VnbNMra4MnbXbsYwbpeX8DHEXKGwfJ6rSw+J9qOHTxDi2b1yrDf7O/q
         2Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=346XCBRRQI0U8VUrVFMaflldXA9IwQC48vwIUtejHmg=;
        b=UpzlZT6Ncac3vbV2dTFC15JnvGCIvPq7j7jgJCxctsKJjEGIUEOscq27jZrjBtd1rz
         CWdHssmCgLKZjL9MdgbKB9mMkSfNY3GDuipSkaYAb1GOTEIYDhKLFwpq9Td+xGgfqOIf
         NhwUnKisJKmYFUFau1Hmj9MRHuL4X/sywximtrvU0Ottm3VSyi8ltj9bfaVQTDLpbiyL
         id1i/PLNxF1KKb0NNTp7XuldEseEFTG039IMiRbSV94GWL3HGV2GBxK8YwkKIuRpOqKh
         B8HV3kBPvwCMlzyzSDd0X1gA9DLp87p+apWg43fKWh9YLIx5JHZ69QubTAQEMDbPywY0
         XHtA==
X-Gm-Message-State: AA+aEWb8IhlWFKjVGO3xcMVCTdTI794UgfOTKGH832dvgXDD/5BuflLI
        hY8kZqf59l0BRQ26b7dRV5s=
X-Google-Smtp-Source: AFSGD/WlcakhRcrqLtR6LXyiS6eqElTJ2oBMQ0mOsgjFEVqD8SFdPUeSzkIuPnC6hJmK2vpQUj3T0w==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr7102016wrm.143.1542833385590;
        Wed, 21 Nov 2018 12:49:45 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:14d:188e:adb0:9ba6? (p200300EA8BCFE300014D188EADB09BA6.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:14d:188e:adb0:9ba6])
        by smtp.googlemail.com with ESMTPSA id 68sm494702wmt.10.2018.11.21.12.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:49:44 -0800 (PST)
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
Message-ID: <6aeba3d6-2292-1221-9be7-1c0bb7cbc203@gmail.com>
Date:   Wed, 21 Nov 2018 21:49:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <eda84d0b-2d9f-07ae-34a1-767bc5200964@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2018 21:32, Heiner Kallweit wrote:
> On 21.11.2018 21:20, Andrew Lunn wrote:
>>> request_module() is supposed to be synchronous, however after some
>>> reading this may not be 100% guaranteed. Maybe the module init
>>> function on some systems isn't finished yet when request_module()
>>> returns. As a result the genphy driver may be used instead of
>>> the PHY version-specific driver.
>>
>> Hi Heiner
>>
>> That would be true for all PHYs i think. We would of noticed this
>> problem with other systems using other PHY drivers.
>>
>> 	Andrew
>>
> It could be a timing issue affecting certain systems only. At least
> for now I don't have a good explanation why loading the module via
> request_module() and loading it upfront manually makes a difference.
> 
> One affected user just reported the PHY to be a RTL8211B. This is
> what I expected, because this PHY crashes when writing to the MMD
> registers (the MMD registers are used otherwise by this PHY).
> See also commit 0231b1a074c6 ("net: phy: realtek: Use the dummy
> stubs for MMD register access for rtl8211b").
> 
> Let's see whether the other affected systems use the same PHY
> version.
> 
Next report is also about a RTL8211B and as I assumed:
- W/o manually loading the realtek module the genphy driver is used
  and network fails.
- W/ manually loading the realtek module the proper RTL8211B PHY
  driver is used and network works.

So it seems that even after request_module() the PHY driver isn't
yet available when device and driver are matched.

If further reports support this (pre-)analysis, then indeed it
seems to be a timing issue and a proper fix most likely is
difficult. As a workaround I could imagine to add a delay loop
after request_module() checking for a Realtek PHY driver via
driver_find(). When adding one small delay after this we should
be sufficiently sure that all Realtek PHY drivers are registered.

> Heiner
> 

