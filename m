Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1C9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A862184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWyavLmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeLRKLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:11:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39704 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:11:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so855562pfc.6;
        Tue, 18 Dec 2018 02:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CxXXUv+EgkVrU6KdE+cFR4qqon7JP0P+l/dMlMJYIp0=;
        b=oWyavLmbkSMk/CnwrLC4jXM8RdYEz51OStmyxaKPcgo8p9DiaJL9ehfOJUAWKfCLcr
         OTd/nvoSICO7oAqxv1AqnZmSCCN0rKG1cq/o6saBP4CqmmlmgJhRQsSzEALLOcwEaSpa
         9lD4UMpxXU0u6nmzIwn90CsQjK2n7FlJI4c2F4wBZqc9WSjAa62yhTOn1UFqVuPkJQws
         sdwepQ4EBDrEYkbJp1EZjpho1zGb5apWJW3D+FaJTRw0XYK6S9eTJE4FxU93ihVteNWY
         MIUaauJXiGEHkfoRpwR1DlSjKIywvij9PXdqAZGIjypzR7+b3rW43Ncdg4d3ymQ0Q4rb
         bOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CxXXUv+EgkVrU6KdE+cFR4qqon7JP0P+l/dMlMJYIp0=;
        b=DFCiBrLB6lvr2OYf2P8hx4MSfo8kYAQq1Gnimyld93YqK97cMbmwXapu9OGkZB/7V4
         tVmVym+WIb9K/EFLSL2dH+tmpq3alTrtZZsePm4ajTqb60yeaW5fbicyYwFMD5BPjpWU
         ymMQWUkh3C0GckBanfTeui/sF1xS4FAzcudbgdlf+pdeJhLUAL8vEOIaqTp4C/Iz6VUr
         l6ReSJAYfdKFO4gblkl7Cz0C3zZe7ZiABYE4X2Toor7tUdzWMjqaRtnfzsYK9ObXFSHN
         h9E0CeeH78m5ikz6veY7dCBbfECA/U62gDr/Ll7zwFLkpkbwH0E1wzIjwbt3xupDCmds
         eWjQ==
X-Gm-Message-State: AA+aEWZVjjgWGABjw+SfFLbLEHbxLBz3V0fRZRL++9Uh76tdEkStAaZx
        G4yvuv+3wKyeAAVESS6zEU4=
X-Google-Smtp-Source: AFSGD/XVG0PcT9XaYdiaeCLgoJ6xtsBtgEpQCgZZXDGzdt3KPoscEvt4hqQT+61plkybrKOEkjWTHQ==
X-Received: by 2002:a63:f515:: with SMTP id w21mr15176931pgh.220.1545127900916;
        Tue, 18 Dec 2018 02:11:40 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:b5e9:3c79:e26e:bf45:b953])
        by smtp.gmail.com with ESMTPSA id m19sm38420743pgn.35.2018.12.18.02.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:11:40 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 1/8] bitops: Introduce the for_each_set_clump8 macro
Date:   Tue, 18 Dec 2018 19:12:09 +0900
Message-Id: <40f8a86600f6c741b8c577dc821042d5a250f95f.1545126272.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1545126272.git.vilhelm.gray@gmail.com>
References: <cover.1545126272.git.vilhelm.gray@gmail.com>
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
index 705f7c442691..850af60d36b9 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (offset) + 1, (size)))
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

