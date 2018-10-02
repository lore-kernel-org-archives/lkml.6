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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3691EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4362213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJRdR+Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4362213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeJBHzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:55:06 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:42128 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:55:06 -0400
Received: by mail-io1-f46.google.com with SMTP id n18-v6so306238ioa.9;
        Mon, 01 Oct 2018 18:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83XPNCJOunaynfIDGxcIa0BRJM5qZxkC0ryWSn5Ilas=;
        b=BJRdR+NkX3knjLCNXiuYhgXumR84wYK7Jb9Pj3QiAS5wyHG5Qj3Yub4cBB8JNTRXDm
         zv3JAC7AI275w8gsYYKhycYI2BO26FVIu05m1N3DmNI2IwhW5kNr8IuXCbuNvpRQ4/6E
         ZEQZdVB/Ys9qUusSkG8q9XJBmHn+LIarbgpwHElb8pqBziqyrprcPEVfsshqgcZDLu2w
         WQlbBU3L1Wb6eL/rKgx9gyM4k7prGzCrt953m//hdjDPob8b9MEORDlTHTArSV1ngHW2
         UhYDzKjYPojVmhLTrULj4yrK8qbqgIk3vRPdEHEBpWuJjxXiw8GfQeuGnoHv5utnPKtm
         edfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83XPNCJOunaynfIDGxcIa0BRJM5qZxkC0ryWSn5Ilas=;
        b=Ms5PkuM9js4A4S87I46x4pZ7pbC2Kbj0g/Ko8EhNjE2GAOc21JcK0RSpuucUOsuHOu
         Y+G3M4NWTtPHLmy0/qelb4Tp3AiT6HPD+HuIk2gJ+1Do69iac9LQjqb+C7QqOlu1uyt8
         9LyyHMOGYNxlevVTm2UNIsMQvdt0yHfZoirO+0OVKfBYYJ/7O5vYprqhhlSZa5lBa8iI
         goiFBleRuPNsNfkOig9++9i4WeleGfpdUfIK+4ekbpu/UKIloXuDXjkepu7sPdaabqew
         YDMMJdgZuafHfnOAw+VqXXDyXi7SH0IkptgxbDmm0AiXgchj/bfMtrgN6Ui3q6aXRif1
         /Klw==
X-Gm-Message-State: ABuFfohsoXBVI6zROmpHKuDX8UAVJjUQcHgcn4Ee041cjxJj8esdUjyz
        7kfN48NfSZqIXgFqDP+TJUIQop43
X-Google-Smtp-Source: ACcGV602VkgR9TzuSCVI59Z4YTRTDWGvxD602FpWfy3cXr/E/H+EPtO8k/AQXnDELb2LTEWHcs3Y1w==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr14347858plq.77.1538442870548;
        Mon, 01 Oct 2018 18:14:30 -0700 (PDT)
Received: from localhost.localdomain (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id x4-v6sm18699836pfm.119.2018.10.01.18.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:14:30 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [RESEND PATCH v4 2/8] lib/test_bitmap.c: Add for_each_set_clump test cases
Date:   Tue,  2 Oct 2018 10:14:33 +0900
Message-Id: <9ac7e59bb34a9abb4430e7594dd183d7858679d1.1538441919.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1538441919.git.vilhelm.gray@gmail.com>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of the for_each_set_clump macro warrants test cases to
verify the implementation. This patch adds test case checks for whether
an out-of-bounds clump index is returned, a zero clump is returned, or
the returned clump value differs from the expected clump value. A 4-bit
clump size is chosen in order to verify non-8-bit iteration.

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 lib/test_bitmap.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..0a63313873c0 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -88,6 +88,39 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init __check_eq_clump(const char *srcfile, unsigned int line,
+				    const size_t clump_index, const size_t size,
+				    const unsigned char *const clump_exp,
+				    const unsigned long *const bits,
+				    const size_t index,
+				    const unsigned int offset)
+{
+	unsigned long clump;
+	unsigned long exp;
+
+	if (clump_index >= size) {
+		pr_warn("[%s:%u] clump index out-of-bounds: expected less than %zu, got %zu\n",
+			srcfile, line, size, clump_index);
+		return false;
+	}
+
+	exp = clump_exp[clump_index];
+	if (!exp) {
+		pr_warn("[%s:%u] clump index for zero clump: expected nonzero clump, got clump index %zu with clump value 0",
+			srcfile, line, clump_index);
+		return false;
+	}
+
+	clump = (bits[index] >> offset) & 0xF;
+	if (clump != exp) {
+		pr_warn("[%s:%u] expected 0x%lX, got 0x%lX",
+			srcfile, line, exp, clump);
+		return false;
+	}
+
+	return true;
+}
+
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -104,6 +137,7 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
+#define expect_eq_clump(...)		__expect_eq(clump, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -361,6 +395,42 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
+static const unsigned char clump_exp[] __initconst = {
+	0x1,	/* 1 bit set */
+	0x2,	/* non-edge 1 bit set */
+	0x0,	/* zero bits set */
+	0xE,	/* 3 bits set */
+	0xE,	/* Repeated clump */
+	0xF,	/* 4 bits set */
+	0x3,	/* 2 bits set */
+	0x5,	/* non-adjacent 2 bits set */
+};
+
+static void __init test_for_each_set_clump(void)
+{
+	size_t clump;
+	size_t index;
+	unsigned int offset;
+#define CLUMP_BITMAP_NUMBITS 32
+	DECLARE_BITMAP(bits, CLUMP_BITMAP_NUMBITS);
+#define CLUMP_SIZE 4
+	const size_t size = DIV_ROUND_UP(CLUMP_BITMAP_NUMBITS, CLUMP_SIZE);
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_BITMAP_NUMBITS);
+	bitmap_set(bits, 0, 1);		/* 0x1 */
+	bitmap_set(bits, 5, 1);		/* 0x2 */
+	bitmap_set(bits, 13, 3);	/* 0xE */
+	bitmap_set(bits, 17, 3);	/* 0xE */
+	bitmap_set(bits, 20, 4);	/* 0xF */
+	bitmap_set(bits, 24, 2);	/* 0x3 */
+	bitmap_set(bits, 28, 1);	/* 0x5 - part 1 */
+	bitmap_set(bits, 30, 1);	/* 0x5 - part 2 */
+
+	for_each_set_clump(clump, index, offset, bits, size, CLUMP_SIZE)
+		expect_eq_clump(clump, size, clump_exp, bits, index, offset);
+}
+
 static int __init test_bitmap_init(void)
 {
 	test_zero_clear();
@@ -369,6 +439,7 @@ static int __init test_bitmap_init(void)
 	test_bitmap_arr32();
 	test_bitmap_parselist();
 	test_mem_optimisations();
+	test_for_each_set_clump();
 
 	if (failed_tests == 0)
 		pr_info("all %u tests passed\n", total_tests);
-- 
2.19.0

