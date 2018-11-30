Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0823C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1F22146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1F22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeK3VH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:07:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48238 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbeK3VH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:07:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 488BC20CFB; Fri, 30 Nov 2018 10:58:40 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0754C206FF;
        Fri, 30 Nov 2018 10:58:30 +0100 (CET)
Date:   Fri, 30 Nov 2018 10:58:29 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Vasut <marex@denx.de>
Subject: [GIT PULL] mtd: Fixes for 4.20-rc5
Message-ID: <20181130105829.0bbefe10@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD fixes PR for 4.20-rc5.

Regards,

Boris

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-4.20-rc5

for you to fetch changes up to 40b412897ccb4b98b2cfb2a0aaabed58dd9e2086:

  mtd: nand: Fix memory allocation in nanddev_bbt_init() (2018-11-28 15:41:50 +0100)

----------------------------------------------------------------
NAND fixes:
- Fix BBT cache allocation done in nanddev_bbt_init()

SPI NOR fixes:
- Fix the erase type selection logic

----------------------------------------------------------------
Frieder Schrempf (1):
      mtd: nand: Fix memory allocation in nanddev_bbt_init()

Tudor Ambarus (1):
      mtd: spi-nor: fix erase_type array to indicate current map conf

 drivers/mtd/nand/bbt.c        |  3 ++-
 drivers/mtd/spi-nor/spi-nor.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)	
