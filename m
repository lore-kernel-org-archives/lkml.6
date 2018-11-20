Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDE8C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC9420851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeKTTIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:08:25 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:57615 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbeKTTIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:08:25 -0500
Received: from [192.168.0.2] (ip5f5bf24c.dynamic.kabel-deutschland.de [95.91.242.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F30432012BAC0D;
        Tue, 20 Nov 2018 09:40:25 +0100 (CET)
To:     Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Realtek NIC uses over 1 Watt with no traffic
Message-ID: <081beaeb-be22-55b3-2927-fec04e9f714a@molgen.mpg.de>
Date:   Tue, 20 Nov 2018 09:40:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Using Ubuntu 18.10, Linux 4.18.0-11-generic, PowerTOP 2.9 shows, the NIC 
uses 1.77 Watts. A network cable is plugged in, but there is no real 
traffic according to `iftop`. Only an email program is running.

     $ lspci -nn -s 3:00.1
     03:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] 
(rev 12)

Is that a measurement error, or does the NIC really need that much power?

> Der Akku meldet eine Entladungsrate von 10.2 W
> Der verbrauchte Strom ist: 0.00 J
> Grundsätzlich benötigte Energie wird auf 10.5 W geschätzt
> 
> Energieschätz.    Auslastung     Gerätename
>   7.03 W      4,9%        Display backlight
>   1.77 W      0,0 pkts/s  Netzwerkschnittstelle: enp3s0f1(r8169)

Letting it run for a while, the value even grows to 3.5 Watts, but
closing and starting PowerTOP, it goes back to 1.7X Watts.


Kind regards,

Paul
