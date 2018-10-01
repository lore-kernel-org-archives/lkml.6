Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927272089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927272089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeJASdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:33:46 -0400
Received: from ni.piap.pl ([195.187.100.4]:55930 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbeJASdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:33:46 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2018 14:33:45 EDT
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTP id 5810A440CF3;
        Mon,  1 Oct 2018 13:46:14 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: ixp4xx: include linux/mtd/platnand.h
References: <20180926130458.2406549-1-arnd@arndb.de>
        <20180926130458.2406549-2-arnd@arndb.de>
Date:   Mon, 01 Oct 2018 13:46:13 +0200
In-Reply-To: <20180926130458.2406549-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 26 Sep 2018 15:04:39 +0200")
Message-ID: <m3in2ldh4q.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, not scanned, whitelist
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The platform_nand_data structure definition is required for ixdp425
> but has now moved to a new header file:
>
> arch/arm/mach-ixp4xx/ixdp425-setup.c:98:15: error: variable 'ixdp425_flash_nand_data' has initializer but incomplete type
>  static struct platform_nand_data ixdp425_flash_nand_data = {
>                ^~~~~~~~~~~~~~~~~~
> arch/arm/mach-ixp4xx/ixdp425-setup.c:99:3: error: 'struct platform_nand_data' has no member named 'chip'
>
> Fixes: 19cf5dfa3a31 ("mtd: rawnand: Move platform_nand_xxx definitions out of rawnand.h")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ixp4xx/ixdp425-setup.c | 1 +

Right.
Acked-by: Krzysztof Halasa <khalasa@piap.pl>

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
