Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006DEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9991214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9991214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbeIZThJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:37:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46978 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeIZThI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:37:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1BC8320725; Wed, 26 Sep 2018 15:24:10 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id D039B206DE;
        Wed, 26 Sep 2018 15:24:09 +0200 (CEST)
Date:   Wed, 26 Sep 2018 15:24:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: ixp4xx: include linux/mtd/platnand.h
Message-ID: <20180926152410.454560f0@xps13>
In-Reply-To: <20180926130458.2406549-2-arnd@arndb.de>
References: <20180926130458.2406549-1-arnd@arndb.de>
        <20180926130458.2406549-2-arnd@arndb.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 15:04:39 +0200:

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

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
