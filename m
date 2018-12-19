Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3197C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BE72184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqubCjyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeLSGAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:00:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46937 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeLSGAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:00:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so8945479pgp.13;
        Tue, 18 Dec 2018 22:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1oZXhPLBwf6ld/Ap5bG26cpxbbDtyrh+8dpvM7Fc0E=;
        b=TqubCjyIfIJJbFdMSsP5578TCHQFawBB5j28IM913BWu5NKWtsn34/uCMSTVNW+dXK
         W+CieSYpmmOY2V6v52Oi7HfZKhlNUs6J5tiRvUGOlR++7Eq9PCAKNH+YSk6e4IfFCx5w
         HmiqWVM/DB7pini343cGVPIo3a2Z0nfnDurTiJjWjX650ibEs6c5MYNzx0XDsf20BvW1
         Ch/hmOWNJ8ojH5CV0WP87ghMiqRquCy26aSFS8F0oOGppddcf4bS/6mOfh9MnuSce7eb
         8wQBx/MoD4nUEymCKinPHg/z8/uRhxCqohJGo7yfdUQbR2jyB0v/6ahsho2RCNxG49yu
         6P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1oZXhPLBwf6ld/Ap5bG26cpxbbDtyrh+8dpvM7Fc0E=;
        b=HNda6cRBeShPP3OCVtuHWLmdCbAL5AbzwN98rfWxopxuvDAOH9D7NydpLlRfbr6S2L
         9jPEw11MZf7j/o1arIUi6NNnCrlrMwc4YC3CKUxSo7EFFJD0/Tu+Cd5YWITHZNQJSSc7
         fXaNXGaAzA3lrKa4TraMHBv/GJQT/lupimbRIdyKr40U1cqzbM5Ad0flgosm6C9OhK51
         z7nXhWYiC7nV6f2wOS61HOMfMP+d4Vfrm1LYygLi5S879/LxjYyk3B7MF6+qdLAAOdh6
         lEmM4i+WwRQQmCps9zULSutM8eYu6qXMLJkqWxY0G2fXf9XlAMw/HRxPmS1Hh7/navRF
         /GpQ==
X-Gm-Message-State: AA+aEWaH6RZBaL/bNMUG85MVM+JQhy6uBCJWpEmfdXd76PD8JZa4GSJG
        3o/LZR9haND+bx+FQpGL4WmwJPst
X-Google-Smtp-Source: AFSGD/WdnZ2lJ9Y2Xvo7N21mpAuZKWH8m/p5IqXc3iIbpashwifPPehbLDpY6fIZ2XKZcB8unP1i/g==
X-Received: by 2002:a63:ac46:: with SMTP id z6mr1850033pgn.162.1545199211433;
        Tue, 18 Dec 2018 22:00:11 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a2:eb51:6018:45d4:55a2:e94b])
        by smtp.gmail.com with ESMTPSA id h15sm20600853pgl.43.2018.12.18.22.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 22:00:10 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 1/8] bitops: Introduce the for_each_set_clump8 macro
Date:   Wed, 19 Dec 2018 15:00:39 +0900
Message-Id: <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1545198260.git.vilhelm.gray@gmail.com>
References: <cover.1545198260.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro iterates for each 8-bit group of bits (clump) with set bits,
within a bitmap memory region. For each iteration, "start" is set to the
bit offset of the found clump, while the respective clump value is
stored to the location pointed by "clump". Additionally, the
bitmap_get_value8 and bitmap_set_value8 functions are introduced to
respectively get and set an 8-bit value in a bitmap memory region.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 14 +++++++
 include/linux/bitops.h            |  5 +++
 lib/find_bit.c                    | 63 +++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..457b93e6f5c9 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,18 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+unsigned int bitmap_get_value8(const unsigned long *const bitmap,
+			       const unsigned int start);
+
+void bitmap_set_value8(unsigned long *const bitmap,
+		       const unsigned long *const value,
+		       const unsigned int start);
+
+unsigned int find_next_clump8(unsigned long *const clump,
+			      const unsigned long *const addr,
+			      unsigned int offset, const unsigned int size);
+
+#define find_first_clump8(clump, bits, size) \
+	find_next_clump8((clump), (bits), 0, (size))
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 705f7c442691..61c10f20079e 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (start) + 8, (size)))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index ee3df93ba69a..2e56d2b907bc 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -218,3 +218,66 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+/**
+ * bitmap_get_value8 - get an 8-bit value within a memory region
+ * @bitmap: address to the bitmap memory region
+ * @start: bit offset of the 8-bit value
+ *
+ * Returns the 8-bit value located at the @start bit offset within the @bitmap
+ * memory region.
+ */
+unsigned int bitmap_get_value8(const unsigned long *const bitmap,
+			       const unsigned int start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned int offset = start % BITS_PER_LONG;
+
+	return (bitmap[index] >> offset) & 0xFF;
+}
+EXPORT_SYMBOL(bitmap_get_value8);
+
+/**
+ * bitmap_set_value8 - set an 8-bit value within a memory region
+ * @bitmap: address to the bitmap memory region
+ * @value: the 8-bit value
+ * @start: bit offset of the 8-bit value
+ */
+void bitmap_set_value8(unsigned long *const bitmap,
+		       const unsigned long *const value,
+		       const unsigned int start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned int offset = start % BITS_PER_LONG;
+	const unsigned long mask = GENMASK(7, offset);
+
+	bitmap[index] &= ~mask;
+	bitmap[index] |= (*value << offset) & mask;
+}
+EXPORT_SYMBOL(bitmap_set_value8);
+
+/**
+ * find_next_clump8 - find next 8-bit clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @offset: bit offset at which to start searching
+ * @size: bitmap size in number of bits
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+unsigned int find_next_clump8(unsigned long *const clump,
+			      const unsigned long *const addr,
+			      unsigned int offset, const unsigned int size)
+{
+	for (; offset < size; offset += 8) {
+		*clump = bitmap_get_value8(addr, offset);
+		if (!*clump)
+			continue;
+
+		return offset;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(find_next_clump8);
-- 
2.20.1

