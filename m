Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A7F217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfBRLEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:04:51 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39808 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbfBRLEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:04:51 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A604C3A5858;
        Mon, 18 Feb 2019 11:53:42 +0100 (CET)
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B1F96FF80E;
        Mon, 18 Feb 2019 10:53:40 +0000 (UTC)
Date:   Mon, 18 Feb 2019 11:53:40 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iomap: add missing function args identifier names
Message-ID: <99db3b9c5c87d7eb599b114013a24b478bb48d27.1550485787.git.hle@owl.eu.com>
References: <cover.1550485787.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550485787.git.hle@owl.eu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing function arguments identifier names to asm-generic/iomap.h
definitions. This addresses multiple checkpatch.pl code style
warnings.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 include/asm-generic/iomap.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 5b63b94ef6b5..7e26f21b466f 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -26,24 +26,24 @@
  * in the low address range. Architectures for which this is not
  * true can't use this generic implementation.
  */
-extern unsigned int ioread8(void __iomem *);
-extern unsigned int ioread16(void __iomem *);
-extern unsigned int ioread16be(void __iomem *);
-extern unsigned int ioread32(void __iomem *);
-extern unsigned int ioread32be(void __iomem *);
+extern unsigned int ioread8(void __iomem *addr);
+extern unsigned int ioread16(void __iomem *addr);
+extern unsigned int ioread16be(void __iomem *addr);
+extern unsigned int ioread32(void __iomem *addr);
+extern unsigned int ioread32be(void __iomem *addr);
 #ifdef CONFIG_64BIT
-extern u64 ioread64(void __iomem *);
-extern u64 ioread64be(void __iomem *);
+extern u64 ioread64(void __iomem *addr);
+extern u64 ioread64be(void __iomem *addr);
 #endif
 
-extern void iowrite8(u8, void __iomem *);
-extern void iowrite16(u16, void __iomem *);
-extern void iowrite16be(u16, void __iomem *);
-extern void iowrite32(u32, void __iomem *);
-extern void iowrite32be(u32, void __iomem *);
+extern void iowrite8(u8 value, void __iomem *addr);
+extern void iowrite16(u16 value, void __iomem *addr);
+extern void iowrite16be(u16 value, void __iomem *addr);
+extern void iowrite32(u32 value, void __iomem *addr);
+extern void iowrite32be(u32 value, void __iomem *addr);
 #ifdef CONFIG_64BIT
-extern void iowrite64(u64, void __iomem *);
-extern void iowrite64be(u64, void __iomem *);
+extern void iowrite64(u64 value, void __iomem *addr);
+extern void iowrite64be(u64 value, void __iomem *addr);
 #endif
 
 /*
@@ -68,7 +68,7 @@ extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long cou
 #ifdef CONFIG_HAS_IOPORT_MAP
 /* Create a virtual mapping cookie for an IO port range */
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
-extern void ioport_unmap(void __iomem *);
+extern void ioport_unmap(void __iomem *addr);
 #endif
 
 #ifndef ARCH_HAS_IOREMAP_WC
@@ -82,7 +82,7 @@ extern void ioport_unmap(void __iomem *);
 #ifdef CONFIG_PCI
 /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 #elif defined(CONFIG_GENERIC_IOMAP)
 struct pci_dev;
 static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-- 
2.20.1
