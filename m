Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7651AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D4214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6D4214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeIZVGM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:06:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51998 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeIZVGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:06:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7ECE720798; Wed, 26 Sep 2018 16:52:50 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32E51204AE;
        Wed, 26 Sep 2018 16:52:40 +0200 (CEST)
Date:   Wed, 26 Sep 2018 16:52:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Wolfram Sang <wsa@the-dreams.de>, Suman Anna <s-anna@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ARM: omap1: add nand_chip declaration
Message-ID: <20180926165240.77a78fc4@xps13>
In-Reply-To: <20180926142029.619397-1-arnd@arndb.de>
References: <20180926142029.619397-1-arnd@arndb.de>
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

Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 16:20:16 +0200:

> Recent MTD changes caused a minor build regression on OMAP1:
> 
> In file included from arch/arm/mach-omap1/devices.c:31:
> arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> v2: remove unused linux/mtd/mtd.h inclusion
> ---
>  arch/arm/mach-omap1/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index 11b87a4c84d4..504b959ba5cf 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -26,7 +26,6 @@
>  #ifndef __ARCH_ARM_MACH_OMAP1_COMMON_H
>  #define __ARCH_ARM_MACH_OMAP1_COMMON_H
>  
> -#include <linux/mtd/mtd.h>
>  #include <linux/platform_data/i2c-omap.h>
>  #include <linux/reboot.h>
>  
> @@ -82,6 +81,7 @@ void omap1_restart(enum reboot_mode, const char *);
>  
>  extern void __init omap_check_revision(void);
>  
> +struct nand_chip;
>  extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
>  			       unsigned int ctrl);
>  

Boris pointed me that the commit introducing the regression is still
in nand/next, so do you mind if I squash both patches with it?

Regards,
Miquèl
