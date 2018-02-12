Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeBLDIq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 22:08:46 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56780 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbeBLDIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 22:08:44 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <46988f8227bd3ad617b5c7dd0ce8f159b75ffdb2.1518397634.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net v4 01/13] net/8390: Remove redundant make dependencies
Date: Sun, 11 Feb 2018 22:08:43 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hydra, zorro8390 and mcf8390 drivers all #include "lib8390.c" and
have no need for 8390.o. modinfo confirms no dependency on 8390.ko.
Drop the redundant dependency from the Makefile. objdump confirms
that this has no effect on the module binaries.

Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/8390/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/8390/Makefile b/drivers/net/ethernet/8390/Makefile
index f975c2fc88a3..1d650e66cc6e 100644
--- a/drivers/net/ethernet/8390/Makefile
+++ b/drivers/net/ethernet/8390/Makefile
@@ -7,8 +7,8 @@ obj-$(CONFIG_MAC8390) += mac8390.o
 obj-$(CONFIG_APNE) += apne.o 8390.o
 obj-$(CONFIG_ARM_ETHERH) += etherh.o
 obj-$(CONFIG_AX88796) += ax88796.o
-obj-$(CONFIG_HYDRA) += hydra.o 8390.o
-obj-$(CONFIG_MCF8390) += mcf8390.o 8390.o
+obj-$(CONFIG_HYDRA) += hydra.o
+obj-$(CONFIG_MCF8390) += mcf8390.o
 obj-$(CONFIG_NE2000) += ne.o 8390p.o
 obj-$(CONFIG_NE2K_PCI) += ne2k-pci.o 8390.o
 obj-$(CONFIG_PCMCIA_AXNET) += axnet_cs.o 8390.o
@@ -16,4 +16,4 @@ obj-$(CONFIG_PCMCIA_PCNET) += pcnet_cs.o 8390.o
 obj-$(CONFIG_STNIC) += stnic.o 8390.o
 obj-$(CONFIG_ULTRA) += smc-ultra.o 8390.o
 obj-$(CONFIG_WD80x3) += wd.o 8390.o
-obj-$(CONFIG_ZORRO8390) += zorro8390.o 8390.o
+obj-$(CONFIG_ZORRO8390) += zorro8390.o
-- 
2.13.6
