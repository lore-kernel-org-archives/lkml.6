Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F93C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E642087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E642087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbeGKIsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:48:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41002 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeGKIsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:48:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BFEA92074F; Wed, 11 Jul 2018 10:44:47 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 80A86206A6;
        Wed, 11 Jul 2018 10:44:47 +0200 (CEST)
Date:   Wed, 11 Jul 2018 10:44:46 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand/raw: MTD_NAND_BCM47XXNFLASH needs CONFIG_BCMA
Message-ID: <20180711104446.69af988a@bbrezillon>
In-Reply-To: <20180711084010.57950-1-arnd@arndb.de>
References: <20180711084010.57950-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 10:39:44 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> We already have a dependency on BCMA_NFLASH, which in turn depends on
> BCMA, but since BCMA is a tristate option and BCMA_NFLASH is bool,
> we can run into an invalid configuration with MTD_NAND_BCM47XXNFLASH=y
> and BCMA=m:
> 
> drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.o: In function `bcm47xxnflash_ops_bcm4706_init':
> ops_bcm4706.c:(.text+0x790): undefined reference to `bcma_chipco_pll_read'
> 
> Adding the dependency here forces MTD_NAND_BCM47XXNFLASH to only be
> configured =m here so it can link against the BCMA driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 230311fa2cc0..b457f92d55d4 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -364,6 +364,7 @@ config MTD_NAND_BRCMNAND
>  config MTD_NAND_BCM47XXNFLASH
>  	tristate "Support for NAND flash on BCM4706 BCMA bus"
>  	depends on BCMA_NFLASH
> +	depends on BCMA
>  	help
>  	  BCMA bus can have various flash memories attached, they are
>  	  registered by bcma as platform devices. This enables driver for

