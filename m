Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11399206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11399206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJDCKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:10:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47819 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbeJDCKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:10:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CB822207CC; Wed,  3 Oct 2018 21:20:17 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5D722207C8;
        Wed,  3 Oct 2018 21:20:17 +0200 (CEST)
Date:   Wed, 3 Oct 2018 21:20:17 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH 0/3] spi-nor: Add Octal SPI support
Message-ID: <20181003212017.653e739f@bbrezillon>
In-Reply-To: <20181003165603.2579-1-vigneshr@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 22:26:00 +0530
Vignesh R <vigneshr@ti.com> wrote:

> This series adds support for octal mode of mt35x flash. Also, adds
> support for OSPI version of Cadence QSPI controller.
> 
> Based on top of patches adding basic support for mt35xu512aba here:
> https://patchwork.ozlabs.org/cover/971437/
> 
> Vignesh R (3):
>   mtd: spi-nor: Add Octal mode support for mt35xu512aba
>   dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
>   mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller

The patchset looks good to me, I'll just wait the next release cycle
before applying it, since I'd prefer to have it stay a bit longer in
-next. This should leave enough time to let other people review this
stuff.

> 
>  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
>  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++

On a slightly different topic, do you plan to convert the Cadence
driver to spi-mem? And if you don't, is it because you don't have time
or because some features are missing in spi-mem (I remember you
mentioned a few things back when you were reviewing the spi-mem series)?

>  drivers/mtd/spi-nor/spi-nor.c                         | 11 ++++++++++-
>  include/linux/mtd/spi-nor.h                           |  2 ++
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 

