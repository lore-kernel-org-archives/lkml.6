Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E6EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A9B2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfBSIQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:16:49 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35903 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:16:49 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A7D6EE0009;
        Tue, 19 Feb 2019 08:16:46 +0000 (UTC)
Date:   Tue, 19 Feb 2019 09:16:46 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: iomap: add missing const to ioread addr argument
Message-ID: <20190219081646.GB2294@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioread*() signatures from include/asm-generic/iomap.h and lib/iomap.c
have been recently modified to add the missing const qualifier to the
addr parameter. This broke the powerpc build which still had ioread*()
definitions without the const (conflicting types).

Add const qualifier to ioread*() definitions from
arch/powerpc/kernel/iomap.c.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 arch/powerpc/kernel/iomap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 5ac84efc6ede..9fe4fb3b08aa 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -15,23 +15,23 @@
  * Here comes the ppc64 implementation of the IOMAP 
  * interfaces.
  */
-unsigned int ioread8(void __iomem *addr)
+unsigned int ioread8(const void __iomem *addr)
 {
 	return readb(addr);
 }
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	return readw(addr);
 }
-unsigned int ioread16be(void __iomem *addr)
+unsigned int ioread16be(const void __iomem *addr)
 {
 	return readw_be(addr);
 }
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	return readl(addr);
 }
-unsigned int ioread32be(void __iomem *addr)
+unsigned int ioread32be(const void __iomem *addr)
 {
 	return readl_be(addr);
 }
@@ -41,27 +41,27 @@ EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 #ifdef __powerpc64__
-u64 ioread64(void __iomem *addr)
+u64 ioread64(const void __iomem *addr)
 {
 	return readq(addr);
 }
-u64 ioread64_lo_hi(void __iomem *addr)
+u64 ioread64_lo_hi(const void __iomem *addr)
 {
 	return readq(addr);
 }
-u64 ioread64_hi_lo(void __iomem *addr)
+u64 ioread64_hi_lo(const void __iomem *addr)
 {
 	return readq(addr);
 }
-u64 ioread64be(void __iomem *addr)
+u64 ioread64be(const void __iomem *addr)
 {
 	return readq_be(addr);
 }
-u64 ioread64be_lo_hi(void __iomem *addr)
+u64 ioread64be_lo_hi(const void __iomem *addr)
 {
 	return readq_be(addr);
 }
-u64 ioread64be_hi_lo(void __iomem *addr)
+u64 ioread64be_hi_lo(const void __iomem *addr)
 {
 	return readq_be(addr);
 }
@@ -139,15 +139,15 @@ EXPORT_SYMBOL(iowrite64be_hi_lo);
  * FIXME! We could make these do EEH handling if we really
  * wanted. Not clear if we do.
  */
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsb(addr, dst, count);
 }
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsw(addr, dst, count);
 }
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsl(addr, dst, count);
 }
-- 
2.20.1
