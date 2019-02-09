Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0DDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E21820863
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfBIKPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 05:15:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58120 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIKPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 05:15:05 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3979A269D48;
        Sat,  9 Feb 2019 10:14:57 +0000 (GMT)
Date:   Sat, 9 Feb 2019 11:14:54 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] mtd: Fixes for 5.0-rc6
Message-ID: <20190209111454.21c8c23b@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD fixes PR for 5.0-rc6.

Regards,

Boris

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-5.0-rc6

for you to fetch changes up to d5d27fd9826b59979b184ec288e4812abac0e988:

  mtd: rawnand: gpmi: fix MX28 bus master lockup problem (2019-02-06 09:39:22 +0100)

----------------------------------------------------------------
- Fix a problem with the imx28 ECC engine
- Remove a debug trace introduced in 2b6f0090a333 ("mtd: Check
  add_mtd_device() ret code")
- Make sure partitions of size 0 can be registered
- Fix kernel-doc warning in the rawnand core
- Fix the error path of spinand_init() (missing manufacturer cleanup
  in a few places)
- Address a problem with the SPI NAND PROGRAM LOAD operation which
  does not work as expected on some parts.

----------------------------------------------------------------
Boris Brezillon (4):
      mtd: spinand: Handle the case where PROGRAM LOAD does not reset the cache
      mtd: spinand: Fix the error/cleanup path in spinand_init()
      mtd: Remove a debug trace in mtdpart.c
      mtd: Make sure mtd->erasesize is valid even if the partition is of size 0

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Randy Dunlap (1):
      mtd: rawnand: fix kernel-doc warnings

 drivers/mtd/mtdpart.c                     |  5 ++++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c | 13 ++++++-------
 drivers/mtd/nand/raw/nand_base.c          |  1 +
 drivers/mtd/nand/raw/nand_bbt.c           |  2 +-
 drivers/mtd/nand/spi/core.c               | 46 ++++++++++++++++++++++------------------------
 5 files changed, 34 insertions(+), 33 deletions(-)
