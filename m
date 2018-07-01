Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2EFC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553092598E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553092598E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965295AbeGASZJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:25:09 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53331 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965029AbeGASZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:25:05 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41Jf1m5FZ3z1qvNr;
        Sun,  1 Jul 2018 20:24:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41Jf1l0Cj4z1rZMR;
        Sun,  1 Jul 2018 20:24:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id YWSdVObc2MXe; Sun,  1 Jul 2018 20:24:57 +0200 (CEST)
X-Auth-Info: NGDPfZ6UbfCwxToQ3S73cD2K6MC8uDeC+VSxiazQb8o=
Received: from [192.168.178.26] (unknown [62.91.12.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  1 Jul 2018 20:24:57 +0200 (CEST)
Subject: Re: [PATCH v2 0/3] Add clock driver for Actions S700 SoC
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     sboyd@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, manivannan.sadhasivam@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        Cubietech support <support@cubietech.com>,
        linux <linux@cubietech.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <8503ae31-aaf3-e4ba-f385-859a6cd3f8d6@suse.de>
From:   Parthiban Nallathambi <pn@denx.de>
Organization: DENX Software Engineering GmbH
Message-ID: <440c9eed-b930-5a4c-4320-11eec682add6@denx.de>
Date:   Sun, 1 Jul 2018 20:24:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8503ae31-aaf3-e4ba-f385-859a6cd3f8d6@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andreas,

On 07/01/2018 08:05 PM, Andreas Färber wrote:
> Hi Saravannan,
> 
> Am 28.06.2018 um 21:18 schrieb Saravanan Sekar:
>> Changelog v2:
>> Fixed 0 day compilation warning
>> Modified existing dts Actions S900 clock bindings common to Actions
>> Soc family
> 
> Please post v3 without --in-reply-to. It's becoming messy to read.
> 
>> This patchset adds clock support for Actions Semi OWL series S700 SoC
>> with relevant clock bindings and device tree info. 
>>
>> Changed the UART clock using CMU instance and changes are tested in
>> cubieboard7
> 
> Did you find any better way of testing than my "reboot bootloader" from
> preinstalled Android?

Flashing bootloader.bin and u-boot-dtb.img at below offset trigger the
automatic boot from SD. But ADFU needs to long pressed before connecting
the power.

sudo dd if=bootloader.bin of=/dev/sdX bs=512 seek=4097
sudo dd if=u-boot-dtb.img of=/dev/sdX bs=1024 seek=3072

With this is place, u-boot expects GPT layout by default. I am able to boot
the kernel from FAT/ext by updating the bootcmd/u-boot env accordingly. 

I haven't tried flashing/replacing u-boot in eMMC still.

> 
> In addition to missing Actions Semi you may want to CC Cubietech.

+Added cubitech linux group.

> 
> Thanks,
> Andreas
> 

-- 
Thanks,
Parthiban N
