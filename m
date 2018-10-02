Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACECDC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566B6213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSKOvFCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566B6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJBHyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:54:16 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53804 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeJBHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:54:16 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so1047329itb.3;
        Mon, 01 Oct 2018 18:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfa2koyh7eVMIEAS5/kPyF27HM45LnvHcNpvnhOSl4Q=;
        b=TSKOvFCZVPqbXYdOpuJlMXh6MmfgsVMjvwGmaZWaEp75dkL9b9MK8+lwZPZ5YFkD3I
         /WeWQHv8zDON8XVSnMgsk+pxqk33ovassq79VNxpBqDopi+U/cL4aJQMxTZRgZiuat9d
         pwt53/Fi6dpWiV4iWt6mJ+qQ6I+WDt4umS3qZlU9cDXWFh1sile+5XsLMCmHSQD2ZzAx
         Xc557OuP4ArCUs3v8mDQYeVTokJc9xIaofbiLSHNd+ysDR3GIeKM7xluxBY6rF4v1nGS
         yJrTITsn4f9ZjrImPQ446rFyg0rHX4xqfODFiTV6tvHai4i+We1inCLSc7asquCaY1Cb
         CfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfa2koyh7eVMIEAS5/kPyF27HM45LnvHcNpvnhOSl4Q=;
        b=SMOGL3vNWu/0S03+wzUsYuyDD4uQ2LmIWP2T0CfeqQTBd7KGcd7bQ1H6Ox7A9qKtfx
         uT/QvaEI5Z2ypR/PEGM3c/TYz+g5lkcyy4ElNMG10tYB33JNUMeqPsx+ERhLWMSt3Yfh
         JfyhvCVKSvFn1cGtrukcyXU82GqIjQVdqKFw6bhE+33zcTSg7U9GlF2IBhGW43Kw7BvA
         kIkCFrp6GqwFJH3VLy+DCZmcNng6aN4dFq+z3rorKVhMkCv5p+xN+GMOlu1kOEaztCFR
         aOEwf7uPtR0UV71UKx8ipJweXaRDvdN9/01WbwzKBE1vC6G76QarZeyw0UTk592AjDn5
         PS2Q==
X-Gm-Message-State: ABuFfogYGd6M5pqTFwj6htCWDYZxGsU3cB0qGZ6bRlQ0sZvG4W7G3tCM
        esEEijWPTBT7PxXLk9i0FNABSIHE
X-Google-Smtp-Source: ACcGV62TCbgeVwXJdsKUc9SDTS76apxtfzT2DI5C7D3B2WTL9lg0kbLUv5Bkh/7BRTi0J2I62dGs5w==
X-Received: by 2002:a65:5b07:: with SMTP id y7-v6mr12589723pgq.125.1538442821989;
        Mon, 01 Oct 2018 18:13:41 -0700 (PDT)
Received: from localhost.localdomain (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id v38-v6sm18783549pgn.57.2018.10.01.18.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:13:41 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump macro
Date:   Tue,  2 Oct 2018 10:13:44 +0900
Message-Id: <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1538441919.git.vilhelm.gray@gmail.com>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro iterates for each group of bits (clump) with set bits, within
a bitmap memory region. For each iteration, "clump" is set to the found
clump index, "index" is set to the word index of the bitmap containing
the found clump, and "offset" is set to the bit offset of the found
clump within the respective bitmap word.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
index 7ddb1349394d..089381017f74 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,13 @@ extern unsigned long __sw_hweight64(__u64 w);
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
2.19.0

