Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4ADC46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76815214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76815214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeKUGvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:51:05 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39665 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbeKUGvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:51:05 -0500
Received: from [192.168.0.4] (ip5f5bf248.dynamic.kabel-deutschland.de [95.91.242.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0B7FB2012BAC06;
        Tue, 20 Nov 2018 21:20:08 +0100 (CET)
Subject: Re: Realtek NIC uses over 1 Watt with no traffic
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <081beaeb-be22-55b3-2927-fec04e9f714a@molgen.mpg.de>
 <20181120144556.GC18335@lunn.ch>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <7714a7b7-ca22-19ea-499a-e2d60f3c9fb5@molgen.mpg.de>
Date:   Tue, 20 Nov 2018 21:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120144556.GC18335@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,


Am 20.11.18 um 15:45 schrieb Andrew Lunn:
> On Tue, Nov 20, 2018 at 09:40:25AM +0100, Paul Menzel wrote:

>> Using Ubuntu 18.10, Linux 4.18.0-11-generic, PowerTOP 2.9 shows, the NIC
>> uses 1.77 Watts. A network cable is plugged in, but there is no real traffic
>> according to `iftop`. Only an email program is running.
>>
>>      $ lspci -nn -s 3:00.1
>>      03:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev
>> 12)
>>
>> Is that a measurement error, or does the NIC really need that much power?

> This sounds like Energy Efficient Ethernet, EEE, is not enabled.

No, idea if the router from my provider supports that.

> What does ethtool --show-eee ethX say?

     $ sudo ethtool --show-eee enp3s0f1
     Cannot get EEE settings: Operation not supported


Kind regards,

Paul
