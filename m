Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A50C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F49C214F1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F49C214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLCJXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:23:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53246 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLCJXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:23:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2861F20CFA; Mon,  3 Dec 2018 10:22:51 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id BB91E206A1;
        Mon,  3 Dec 2018 10:22:40 +0100 (CET)
Date:   Mon, 3 Dec 2018 10:22:40 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, robh+dt@kernel.org,
        mark.rutland@arm.com, yuenn@google.com, venture@google.com,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au,
        linux-mtd@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/2] SPI-NOR add NPCM FIU controller driver
Message-ID: <20181203102240.79a86a26@bbrezillon>
In-Reply-To: <20181203091456.454030-1-tmaimon77@gmail.com>
References: <20181203091456.454030-1-tmaimon77@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Dec 2018 11:14:54 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:

> This patch set adds Flash Interface Unit(FIU) SPI-NOR
> support for the Nuvoton NPCM Baseboard Management 
> Controller (BMC).
>     
> The FIU supports single, dual or quad communication interface.
>     
> the FIU controller can operate in following modes:
> - User Mode Access(UMA): provides flash access by using an
>   indirect address/data mechanism.
> - direct rd/wr mode: maps the flash memory into the core
>   address space.
> - SPI-X mode: used for an expansion bus to an ASIC or CPLD.
> 
> The NPCM750/730/715/710 supports up to three FIU devices:
> - FIU0 supports two chip select.
> - FIU3 supports four chip select.
> - FIUX supports two chip select.
> 
> The NPCM FIU driver tested on NPCM750 evaluation board.
> 
> Tomer Maimon (2):
>   dt-binding: mtd: add NPCM FIU controller
>   mtd: spi-nor: add NPCM FIU controller driver
> 
>  Documentation/devicetree/bindings/mtd/npcm-fiu.txt |  64 ++
>  drivers/mtd/spi-nor/Kconfig                        |   8 +
>  drivers/mtd/spi-nor/Makefile                       |   1 +
>  drivers/mtd/spi-nor/npcm-fiu.c                     | 930 +++++++++++++++++++++

We are currently trying to move all SPI NOR controller drivers out of
drivers/mtd/spi-nor. Can you try to implement the spi-mem interface [1]
and place your driver in drivers/spi/. 

[1]https://elixir.bootlin.com/linux/v4.20-rc5/source/include/linux/spi/spi-mem.h#L185
