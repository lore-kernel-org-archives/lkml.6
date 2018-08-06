Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9072C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF08219F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF08219F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeHFLsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:48:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44823 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:48:17 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=somnus.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1fmbzb-0002oV-Ux; Mon, 06 Aug 2018 11:40:00 +0200
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH] bitops/find: Fix function description argument ordering
Date:   Mon,  6 Aug 2018 11:39:53 +0200
Message-Id: <20180806093953.14559-1-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order of the arguments in function documentation doesn't fit with
the implementation. Change the documentation so that it corresponds to
the code. This prevents to confuse people reading the documentation.

While at it fixing the line breaks between the type of an argument and
the arguments name in function declaration for better readability.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 include/asm-generic/bitops/find.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..30f0f8d0bd79 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -6,14 +6,15 @@
 /**
  * find_next_bit - find the next set bit in a memory region
  * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
-		size, unsigned long offset);
+extern unsigned long
+find_next_bit(const unsigned long *addr, unsigned long size,
+	      unsigned long offset);
 #endif
 
 #ifndef find_next_and_bit
@@ -21,29 +22,30 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
  * find_next_and_bit - find the next set bit in both memory regions
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_and_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long size,
-		unsigned long offset);
+extern unsigned long
+find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+		  unsigned long size, unsigned long offset);
 #endif
 
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
  * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
-extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
-		long size, unsigned long offset);
+extern unsigned long
+find_next_zero_bit(const unsigned long *addr, unsigned long size,
+		   unsigned long offset);
 #endif
 
 #ifdef CONFIG_GENERIC_FIND_FIRST_BIT
-- 
2.18.0

