Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AE0C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE5320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE5320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeLJIp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:45:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49725 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLJIp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:45:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1A7D820DBC; Mon, 10 Dec 2018 09:45:55 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id CF0272037D;
        Mon, 10 Dec 2018 09:45:44 +0100 (CET)
Date:   Mon, 10 Dec 2018 09:45:44 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH 0/3] spi-nor: Add Octal SPI support
Message-ID: <20181210094544.3843e782@bbrezillon>
In-Reply-To: <0e4286ea-85d1-a909-17c0-47f9506b3e5a@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
        <0e4286ea-85d1-a909-17c0-47f9506b3e5a@ti.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2018 14:17:18 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Hi Boris,
> 
> On 03/10/18 10:26 PM, Vignesh R wrote:
> > This series adds support for octal mode of mt35x flash. Also, adds
> > support for OSPI version of Cadence QSPI controller.
> > 
> > Based on top of patches adding basic support for mt35xu512aba here:
> > https://patchwork.ozlabs.org/cover/971437/
> > 
> > Vignesh R (3):
> >   mtd: spi-nor: Add Octal mode support for mt35xu512aba  
> 
> 
> >   dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
> >   mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller  
> 
> Could you consider above two patches for v4.21 once [1][2] are merged?
> 
> [1] https://patchwork.ozlabs.org/patch/1006717/
> [2] https://patchwork.ozlabs.org/patch/1006715/

I asked Tudor to have a look at those patches. I'll apply them once I
have his R-b.

> 
> Let me know if this needs to be re-posted.
> 
> > 
> >  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
> >  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++
> >  drivers/mtd/spi-nor/spi-nor.c                         | 11 ++++++++++-
> >  include/linux/mtd/spi-nor.h                           |  2 ++
> >  4 files changed, 22 insertions(+), 1 deletion(-)
> >   
> 

