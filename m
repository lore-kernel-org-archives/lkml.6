Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D60C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B12A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0nUGjsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B12A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeKUGpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:45:24 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34820 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeKUGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:45:24 -0500
Received: by mail-wr1-f42.google.com with SMTP id 96so3336734wrb.2;
        Tue, 20 Nov 2018 12:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aL+uBxu8H/PW5jap2Yo+g5CWQ5G3LNkURP8x96ixk/4=;
        b=C0nUGjsQcW3wEsaXLs/3E05TaOT1DDpEnD7cV40PdzWOmew//qlNhItWi38KnSpzoA
         220+ssLdHVrmuPkKoERwxc5ribcuNTXRLtWzzn+yd4jhCKtIzTFUmopKTmKD85bOrGY8
         hJ08/36G46ZaCH1ik+zgW5TGweTbKbcuxq0jlue2DVGoR5/2vu9YvDanE5V6CO4B2YAK
         xiCQVc8WmVI/O4m8Ax5whxPiHcmfNz2it36gyXSSFWpmuTXhNVcGtn+aIOzsW3NaQk7v
         moS3oLVP/REXKGVnP42kYI2REmoZCPj6+mjS9SPOozmdpOmXkpZmRMJmuJARxohKWYAf
         30Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aL+uBxu8H/PW5jap2Yo+g5CWQ5G3LNkURP8x96ixk/4=;
        b=JhMNwzh8tZcBs6WaJxrMo8aTM4PDzYyrbO6sO/X9XCTOJzeiDqMY6pDQVhu8uNxpkM
         rk5xgREbHf3XfFRYzTjSWWd9l+2EF29/vyIjeU2RaNU454yMcpdpxBEdUsu/zWJJU8+E
         GLLQNfH4NoG5CvDIxe8Y+/b108KUFUToNtCpeFQk7uau0nG/FT9XQnD+5gGjJdKEMwLJ
         uRPU/NmJ04LHxB6+JRXQ/fLaNlHWgpNryw1bCOetqWiGnEMZhUGgKBSk4fiL+AJwQ1cv
         UGmyK7WgrGVzIhvQhehLbfYzLTdvtaZGRWIpaJE5dnyK6X9aE7iJrwRgnM8+bAd/Q4TG
         dbEg==
X-Gm-Message-State: AA+aEWbimKWowTKZDHWkyJAViMoXFwpWk+5Oy5rNhnOIFUdPvx/0f71z
        mfFQk55UvJXY5K2clCWdoomfU3zT
X-Google-Smtp-Source: AFSGD/WfotzqN5U64wNb621xNzvXGYW0HrNWD/Vx71+YjATlbV+l9zIl8dnhBw8A4+JM78wRuFshqg==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr3399968wrn.27.1542744867995;
        Tue, 20 Nov 2018 12:14:27 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6519:a58c:3fd:9cdd? (p200300EA8BCFE3006519A58C03FD9CDD.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6519:a58c:3fd:9cdd])
        by smtp.googlemail.com with ESMTPSA id a12sm28398724wro.18.2018.11.20.12.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:14:27 -0800 (PST)
Subject: Re: Realtek NIC uses over 1 Watt with no traffic
To:     Andrew Lunn <andrew@lunn.ch>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <081beaeb-be22-55b3-2927-fec04e9f714a@molgen.mpg.de>
 <20181120144556.GC18335@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <c3ff00a1-ac51-7f27-8e90-b753f316866d@gmail.com>
Date:   Tue, 20 Nov 2018 21:14:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120144556.GC18335@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 15:45, Andrew Lunn wrote:
> On Tue, Nov 20, 2018 at 09:40:25AM +0100, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> Using Ubuntu 18.10, Linux 4.18.0-11-generic, PowerTOP 2.9 shows, the NIC
>> uses 1.77 Watts. A network cable is plugged in, but there is no real traffic
>> according to `iftop`. Only an email program is running.
>>
>>     $ lspci -nn -s 3:00.1
>>     03:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev
>> 12)
>>
>> Is that a measurement error, or does the NIC really need that much power?
> 
> Hi Paul
> 
> This sounds like Energy Efficient Ethernet, EEE, is not enabled.
> 
> What does ethtool --show-eee ethX say?
> 
>      Andrew
> 
The r8169 driver doesn't support the get_eee ethtool_ops callback.
For certain chip versions EEE gets enabled in the PHY init, for others
not and some don't seem to support EEE at all.

Apart from EEE one important factor affecting power consumption is ASPM.
This was recently enabled for certain chip versions.

Information that would help:

whether Wake-on-LAN is enabled ("Wake-on:" line from ethtool output)

lspci -vv output for the Realtek NIC

Info from powertop about package C states. With ASPM my system reaches
50% PC7 + 50% PC10.

dmesg output filtered for "r8169". Primarily relevant is the line with
the chip name and XID.

Heiner
