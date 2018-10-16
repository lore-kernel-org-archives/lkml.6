Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D1FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14DB20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14DB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeJPTym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:54:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44404 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbeJPTym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:54:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B3832079D; Tue, 16 Oct 2018 14:04:30 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id AF60E20DCD;
        Tue, 16 Oct 2018 14:04:10 +0200 (CEST)
Date:   Tue, 16 Oct 2018 14:04:11 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
Message-ID: <20181016140411.3f06e449@bbrezillon>
In-Reply-To: <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 09:51:47 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Tudor,
> 
> This patch is breaking the 1-4-4 Read protocol for the spansion flash "s25fl512s".
> 
> Without this patch read request command for Quad mode, 4-byte enable, is coming as 0xEC i.e. SPINOR_OP_READ_1_4_4_4B.
> But after applying this patch, read request command for Quad mode is coming as 0x6C i.e. SPINOR_OP_READ_1_1_4_4B.
> 
> This flash also supports non-uniform erase.
> Can you please check and provide some suggestion?

Are you sure the regression comes from this patch? I suspect your bug
comes from 41fe242979e4 ("mtd: spi-nor: fsl-quadspi: fix read error for
flash size larger than 16MB").
