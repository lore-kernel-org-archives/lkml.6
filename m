Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89654C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBA420832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBA420832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeK1S6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:58:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40066 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbeK1S6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:58:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EE99820743; Wed, 28 Nov 2018 08:57:56 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id AEF32206D8;
        Wed, 28 Nov 2018 08:57:46 +0100 (CET)
Date:   Wed, 28 Nov 2018 08:57:45 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <Cyrille.Pitchen@microchip.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: parse SFDP 4-byte Address Instruction
 Table
Message-ID: <20181128085745.1ef607b3@bbrezillon>
In-Reply-To: <20181120115512.15958-1-tudor.ambarus@microchip.com>
References: <20181120115512.15958-1-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 11:55:21 +0000
<Tudor.Ambarus@microchip.com> wrote:

> +
> +	/*
> +	 * We set nor->addr_width here to skip spi_nor_set_4byte_opcodes()
> +	 * later because this latest function implements a legacy quirk for
> +	 * the erase size of Spansion memory. However this quirk is no longer
> +	 * needed with new SFDP compliant memories.
> +	 */
> +	nor->addr_width = 4;
> +	nor->flags |= SPI_NOR_4B_OPCODES;

You mean SNOR_F_4B_OPCODES (the one introduced here [1]), because
SPI_NOR_4B_OPCODES should only be used for flash_info->flags and might
soon conflict with another SNOR_F_ flag?

[1]http://patchwork.ozlabs.org/patch/991476/
