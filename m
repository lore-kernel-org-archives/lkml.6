Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1BCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F72120870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmveBxgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfALBrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:47:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34825 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfALBrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:47:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so7543045plo.2;
        Fri, 11 Jan 2019 17:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=illMOt5TaobGwcDI7Guq/1X4h0CJv2ntS15Gr9KbqVs=;
        b=ZmveBxgE1z/B5oYqjdB2x4uZybFrWzQx04VDoQhQm4vPdU9tfNMrJuE2mOhKVNJtQy
         aJ2hmaJsAqiF4XtxW5OXmllaQU3BtzUL1bfGOvEQFM98RcIh1OjHAbSM9TMn057b9PIu
         X7qyAv4GiOjLC2hA76r9NyzuZXZYNmWJeTU4aZUC+cbfnsfP+tYARAkec7kdgqxwg8La
         BNLVkbAVhPXbDb8VV7o5hmLibhjF1i/kQDxzHRlB5E0n4Uzt5hDoM8YlzuGUJg1VdKzd
         GRTLHUP3I4IVAd2nh/Qtj1+L0Ri50VgextjcMHj36lUObgtlAmJn3SRw424FA0RJJavG
         M0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=illMOt5TaobGwcDI7Guq/1X4h0CJv2ntS15Gr9KbqVs=;
        b=o4lUSAIhtoB+NdJ4/pLueG9kpDWoa4rDKG4tN1yX32WXxPOfntSG2YNVccsja4qYxX
         mTBLpbwZmfon8Hsgeuv7jH3OqAHncP2WTnf2Xyr8IcT1u3SPQV86kGktX01X9ZpVEHLR
         EFloNAjCKZN3061HuZ1uQxyQzoLQB+ok8n2CgkvIkA0HShXk0wZRYi/Ona7CwZCjBHij
         KwrX0JPDHB/wN9cStYPvxWJCL+Wd/IPKudSM0yq/7ezCPuOd9hL5TNj4iyiq1+GBxT1X
         ALFwlWP+dWXeNLI1tr5Xop86XLBarloluoXQIu/meFGwKWLNUp0AUkZK4c/cZiri9Wo5
         A7SA==
X-Gm-Message-State: AJcUuke9siDIM93KDQZ1qjSr2pDSMR6pzCQ86WRLkqjHaPcAz2N9RekY
        4H5IN+/bnqwdk5YyznbgNpcheWX0
X-Google-Smtp-Source: ALg8bN5uq+eJVGOV4ZinkDWFmXW1PB+ryQAxeieq4m4cPotiC8i7gin6VG7AY2orsUTRxZhRc6oWkA==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr17110945plm.212.1547257650635;
        Fri, 11 Jan 2019 17:47:30 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:ffc5:36e2:bccb:ba63:9e84])
        by smtp.gmail.com with ESMTPSA id 128sm120175296pfu.129.2019.01.11.17.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 17:47:30 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v7 1/8] bitops: Introduce the for_each_set_clump8 macro
Date:   Sat, 12 Jan 2019 10:48:04 +0900
Message-Id: <cca4dc59b4eb0a65fca8c6954059b71f305d28c9.1547257386.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547257386.git.vilhelm.gray@gmail.com>
References: <cover.1547257386.git.vilhelm.gray@gmail.com>
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
index 8a1ee10014de..61c496ae94cf 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,18 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+unsigned int bitmap_get_value8(const unsigned long *const bitmap,
+			       const unsigned int start);
+
+void bitmap_set_value8(unsigned long *const bitmap,
+		       const unsigned long value,
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
index ee3df93ba69a..97d96e65a3d9 100644
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
+		       const unsigned long value,
+		       const unsigned int start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned int offset = start % BITS_PER_LONG;
+	const unsigned long mask = GENMASK(7, offset);
+
+	bitmap[index] &= ~mask;
+	bitmap[index] |= value << offset;
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

