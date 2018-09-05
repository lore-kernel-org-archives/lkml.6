Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1944C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CDE2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CDE2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeIFBGO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:06:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33474 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeIFBGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:06:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04C2F2072F; Wed,  5 Sep 2018 22:34:22 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6C766203DC;
        Wed,  5 Sep 2018 22:34:21 +0200 (CEST)
Date:   Wed, 5 Sep 2018 22:34:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] arch/sh: fix build warning in mach-kfr2r09/setup.c
Message-ID: <20180905223419.057a7c39@xps13>
In-Reply-To: <bad8a4af-a99d-c1ea-3494-02dbb0a47f6b@infradead.org>
References: <bad8a4af-a99d-c1ea-3494-02dbb0a47f6b@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Randy Dunlap <rdunlap@infradead.org> wrote on Wed, 5 Sep 2018 11:17:26
-0700:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> arch/sh/boards/mach-kfr2r09/setup.c does not need to #include
> <mtd/onenand.h>, and doing so causes a build warning, so drop
> that header file.
> 
> In file included from ../arch/sh/boards/mach-kfr2r09/setup.c:28:
> ../include/linux/mtd/onenand.h:225:12: warning: 'struct mtd_oob_ops' declared inside parameter list will not be visible outside of this definition or declaration
>      struct mtd_oob_ops *ops);
> 
> Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-mtd@lists.infradead.org
> ---
>  arch/sh/boards/mach-kfr2r09/setup.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- lnx-419-rc1.orig/arch/sh/boards/mach-kfr2r09/setup.c
> +++ lnx-419-rc1/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -25,7 +25,6 @@
>  #include <linux/memblock.h>
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
> -#include <linux/mtd/onenand.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/platform_data/lv5207lp.h>
>  #include <linux/platform_device.h>
> 
> 

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
