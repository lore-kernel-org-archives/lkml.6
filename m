Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeDYVKz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:10:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49953 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeDYVKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:10:52 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] mips: xilfpga: stop generating useless dtb.o
Date: Wed, 25 Apr 2018 23:10:35 +0200
Message-Id: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a dtb.o is generated from nexys4ddr.dts but this is never used since it has
been moved to mips/generic with commit b35565bb16a5 ("MIPS: generic: Add support
for MIPSfpga")

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/xilfpga/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
index 9987e0e378c5..69ca00590b8d 100644
--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= nexys4ddr.dtb
-
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-- 
2.17.0
