Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B072FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B9420020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B9420020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756350AbeFSH2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:28:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60165 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755868AbeFSH2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:28:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C66E120862; Tue, 19 Jun 2018 09:28:43 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5C62220850;
        Tue, 19 Jun 2018 09:28:33 +0200 (CEST)
Date:   Tue, 19 Jun 2018 09:28:32 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Message-ID: <20180619092832.3b6c8f22@bbrezillon>
In-Reply-To: <VI1PR0402MB2845767966A437E0D376219799700@VI1PR0402MB2845.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180612091328.67734adb@bbrezillon>
        <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615145019.734f23a9@bbrezillon>
        <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615155541.4f43e9bb@bbrezillon>
        <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180618211536.0bf44f55@bbrezillon>
        <VI1PR0402MB2845767966A437E0D376219799700@VI1PR0402MB2845.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

Could you please use a mailer that is quoting things correctly. I have
a hard time differentiating your replies from mine.

On Tue, 19 Jun 2018 07:10:37 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Let us take below layout of memory address space map.
> QuadSPI Controller can access range from 0x2000_0000 - 0x2FFF_FFFF i.e. 256 MB address space reserved and it is having 4 slave devices connected.
> These slave devices[of size 64MB, 64MB, 32MB and 64MB ] are connected at below address
> 0x2000_0000, 0x2400_0000, 0x2A00_0000, 0x2C00_0000
> i.e. there is gap of 32MB from 0x2800_0000 to 0x29FF_FFFF.

Okay, I'm fine with pre-reserving 32MB per chip select.

> 
> As per my understanding of the controller, flash XX top address, register should have below values:
>   QUADSPI_SFA1AD - 0x0
>   QUADSPI_SFA2AD - 0x400_0000
>   QUADSPI_SFB1AD - 0xA00_0000
>   QUADSPI_SFB2AD - 0xC00_0000
> And Register QUADSPI_SFAR should point to the range for the flash in which operation is happening.

Wait, I thought it was supposed to be an absolute address, not one
relative to the 0x20000000 offset.

> 
> Please check Table10-32, page 1657, in [1] for more details on flash address assignment.

Yes, I still don't see where it says that having one of the range with
a zero size is forbidden, or anything mentioning a required alignment.

> 
> But say if I assign address to register QUADSPI_SFA2AD as "0 + 2 * ->ahb_buf_size" then this address value is not correct as per the value range explained in above mentioned table.

Why? If the SFA1AD is set to zero, that should not, right?
