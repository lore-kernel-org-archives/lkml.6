Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C97C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BA52177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfBRKyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:54:54 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56503 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfBRKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:54:54 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F281DC0006;
        Mon, 18 Feb 2019 10:54:51 +0000 (UTC)
Date:   Mon, 18 Feb 2019 11:54:51 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] lib/iomap: add missing const to mmio_ins* addr arg
Message-ID: <860beee91f5f22a3f8afc75390a488eba095fa85.1550485787.git.hle@owl.eu.com>
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

mmio_ins* definitions from lib/iomap.c are missing const qualifiers
for the addr argument. This results in compilation warnings when
compiling drivers.

Add missing const qualifiers.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 lib/iomap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/iomap.c b/lib/iomap.c
index 8cc3270697e9..2bcc5d9d30b1 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -143,7 +143,7 @@ EXPORT_SYMBOL(iowrite32be);
  * order" (we also don't have IO barriers).
  */
 #ifndef mmio_insb
-static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
+static inline void mmio_insb(const void __iomem *addr, u8 *dst, int count)
 {
 	while (--count >= 0) {
 		u8 data = __raw_readb(addr);
@@ -151,7 +151,7 @@ static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
 		dst++;
 	}
 }
-static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
+static inline void mmio_insw(const void __iomem *addr, u16 *dst, int count)
 {
 	while (--count >= 0) {
 		u16 data = __raw_readw(addr);
@@ -159,7 +159,7 @@ static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
 		dst++;
 	}
 }
-static inline void mmio_insl(void __iomem *addr, u32 *dst, int count)
+static inline void mmio_insl(const void __iomem *addr, u32 *dst, int count)
 {
 	while (--count >= 0) {
 		u32 data = __raw_readl(addr);
-- 
2.20.1
