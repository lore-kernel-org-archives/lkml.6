Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2852936-1526399412-2-9768397184428460657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526399412; b=LUGxojdX/RSmRnAQywoNvD62HrFyi1x/ORGRTFNBJTSAo4T2Zm
    EpeSDCWWV55U/DXx0CSQFkTuiR8OI2gGHg9MdoO3ovNPO6WGoQ9q3inTaiFZlebF
    jci0G9FJ8aJiKi1sDK0L7gO74x18/vN2o6eZYZzlh50tqVH/rPVg6FB4BXvK7RQY
    QHcyi+AO2RfoZsmW9AqCJ9hVyni04ota/cvdTq3WPHrL89CTVCzPAI/Tpt8C/nDb
    /iTcRarucFd1PstecxwdJUOLvYfmmShu8de1s6QX0ZFjtjkV5IXUqTM1sN48AhMX
    o8Bp+RZmycdo7YNcavrVAEAEq49Tpe26U8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526399412; bh=
    zXWx52J09B2XRIIWL2fJqPQYDuMBxPhU30oY293qaME=; b=lFS7UqNEyQ7ZB7NZ
    wcGZQnTfEpoZ7oe/F5HX3RAtzFBUtcWWeevINH1c8IFJey108N9NO01fAuKbPz+K
    d5tuPQ5ZBevXdx5ZPqjKv4cZ6tJDc7ZM6GWj6q3Owm1eocL4My3XQx/8Isz/lVan
    SmCY7IpcDsE3P9Qf1pvOVLMKML9YrikESTy6mkExF6K+UEohoqPnNtXDTTqEJRGv
    iS9qvKB1MslooUWdYM91mNSGoU+yBETtkf0bdb0wMmCUxF+pZayuAXeWJsChca52
    OiSKb2eXTnLk8Aa9FFEy7koHlA9hPG8W7HJ79nZ0ibV3hA2eAb9DiIsXSC5MecNL
    1FHqnQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=TQhQSEmr x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=szPPSRIy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=TQhQSEmr x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=szPPSRIy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ8fyDltRe3En2PrEYG4xX6b3FcO7YLQnNd3AK2T/Eb9G6Q84+m2thORB7kYSTtME7I+VIxADEuRBKSNvxmHbUDLF3R7hqduBGiDSvpoWqx3qZvrM6oJ
    AplqS7PuWHASHMJRTHpRMoW+aLVzwzYGpJ0MFfA9TFYO0vXlCKBVgHC9Y+SgegKdQ8tllYle2Luv8haQQmZtV+kbnzBDgUhi+dmZLnSLilYyKMmJDCOU1+Yr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=DEnnbVfQ4JbrHgTyWpMA:9
    a=ysS4RRhXWesU5ie8:21 a=epSM3QrjnODCKqLB:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEOPuJ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 11:50:09 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33418 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeEOPuI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 May 2018 11:50:08 -0400
X-Google-Smtp-Source: AB8JxZpxpt5KLHVO56jZl+0/YXriWm1bOYnLNE0o6yXdjbZA8jcBtjMcBIZDjrA+4xpO5lIQwEjULQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/8] bitops: Introduce the for_each_set_clump macro
Date: Tue, 15 May 2018 11:50:01 -0400
Message-Id: <87c7edee3bd6789345bd1cc6fd0cb91c2d508eda.1526397764.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526397764.git.vilhelm.gray@gmail.com>
References: <cover.1526397764.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This macro iterates for each group of bits (clump) with set bits, within
a bitmap memory region. For each iteration, "clump" is set to the found
clump index, "index" is set to the word index of the bitmap containing
the found clump, and "offset" is set to the bit offset of the found
clump within the respective bitmap word.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h |  9 +++++++
 include/linux/bitops.h            |  7 ++++++
 lib/find_bit.c                    | 40 +++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..3d3b2fc34908 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_BITOPS_FIND_H_
 #define _ASM_GENERIC_BITOPS_FIND_H_
 
+#include <linux/types.h>
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -80,4 +82,11 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+size_t find_next_clump(size_t *const index, unsigned int *const offset,
+		       const unsigned long *const bits, const size_t size,
+		       const size_t clump_index, const unsigned int clump_size);
+
+#define find_first_clump(index, offset, bits, size, clump_size) \
+	find_next_clump((index), (offset), (bits), (size), 0, (clump_size))
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 4cac4e1a72ff..cfaff6a14406 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -59,6 +59,13 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump(clump, index, offset, bits, size, clump_size) \
+	for ((clump) = find_first_clump(&(index), &(offset), (bits), (size), \
+					(clump_size)); \
+	     (clump) < (size); \
+	     (clump) = find_next_clump(&(index), &(offset), (bits), (size), \
+				       (clump) + 1, (clump_size)))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index ee3df93ba69a..1d547fe9304f 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -218,3 +218,43 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+/**
+ * find_next_clump - find next clump with set bits in a memory region
+ * @index: location to store bitmap word index of found clump
+ * @offset: bits offset of the found clump within the respective bitmap word
+ * @bits: address to base the search on
+ * @size: bitmap size in number of clumps
+ * @clump_index: clump index at which to start searching
+ * @clump_size: clump size in bits
+ *
+ * Returns the clump index for the next clump with set bits; the respective
+ * bitmap word index is stored at the location pointed by @index, and the bits
+ * offset of the found clump within the respective bitmap word is stored at the
+ * location pointed by @offset. If no bits are set, returns @size.
+ */
+size_t find_next_clump(size_t *const index, unsigned int *const offset,
+		       const unsigned long *const bits, const size_t size,
+		       const size_t clump_index, const unsigned int clump_size)
+{
+	size_t i;
+	unsigned int bits_offset;
+	unsigned long word_mask;
+	const unsigned long clump_mask = GENMASK(clump_size - 1, 0);
+
+	for (i = clump_index; i < size; i++) {
+		bits_offset = i * clump_size;
+
+		*index = BIT_WORD(bits_offset);
+		*offset = bits_offset % BITS_PER_LONG;
+
+		word_mask = bits[*index] & (clump_mask << *offset);
+		if (!word_mask)
+			continue;
+
+		return i;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(find_next_clump);
-- 
2.17.0
