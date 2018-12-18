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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91F3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C677217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpg2EnR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeLRKL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:11:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45093 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:11:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so7601043plm.12;
        Tue, 18 Dec 2018 02:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzUs0MYu4GePpdrRNVIKhIaQXap8GWwj1gOzqd2qYeQ=;
        b=cpg2EnR/fvELVee/BbsQcOgfbUbWOJPVOoasayVvkBA6j57skrj7uLBgF+/DXJTGL4
         uurWL6k3YdOc4i8q127ZXL7AOssuLPN0hWVGh+qyqfMH7Q28Vl32Iuh6Jh94iJN6qvvu
         EuXvoeJfKHqXtTUqnDYDGAQk6fT+9Cqos/y3HhfPHRCLNqbA7X/0QXcsR3PDDg9qYiMP
         ZzEjPvWVuIJQBAQIzF+G5ja0hmk11whkYTkH3sP/7RvF/9CPYvDQXIbllyxCw7vUEffv
         02xcf44zRwtxZRDwuuzifa9DY9vSh6lju2wonsPRPgfGs/mVO3QMghNydh2AjlwtFR0S
         0DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzUs0MYu4GePpdrRNVIKhIaQXap8GWwj1gOzqd2qYeQ=;
        b=hunvr9gkEow6fEJl80kqREUkqU3grnJHS87OFj+ENaj2GdpiqMX7zmIGochFWjok4+
         rpaBdFvuOSPoVKP0ott8GE/H6vAh0xkkQD1AqIs+lX3cv4JGLyomoTpQd8FMMQbjenWH
         BlCStZP5zlcSs4kJjCthVvyJcxawtwUgbqvAhHDY1p2fsTxoegbXXQPX+IaA0WyhCSab
         TcZOv7jT5P3s7V8qRcsvB9f0BQ71Zk/TxllaYyzs1jML5klIHD8v/hntfUl/Zhmie/vL
         pLT8PgZ1B4lIzJ3EazhFXeUK5wqRC9Ol+arLv/+0VsfOZZt+RW9y7k0HZ7r9BiFZOwIF
         YSSA==
X-Gm-Message-State: AA+aEWZXZsukNULPOnh8q4xgbHMpFRm6pm8ubdN5JqUP+EZep+Fhe9OA
        Uvp2XMwn8Na5WLtTVVbBa7E=
X-Google-Smtp-Source: AFSGD/XL0JoJcCF0Sq1X6yorJNEdNt9rT3t9m2UNKRHQbDyYZRNxapOmEKTtYj1e9gxsFn5c8xJbEg==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr16281043plt.30.1545127918260;
        Tue, 18 Dec 2018 02:11:58 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:b5e9:3c79:e26e:bf45:b953])
        by smtp.gmail.com with ESMTPSA id h15sm17981488pgl.43.2018.12.18.02.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:11:57 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 2/8] lib/test_bitmap.c: Add for_each_set_clump8 test cases
Date:   Tue, 18 Dec 2018 19:12:25 +0900
Message-Id: <b48e27a46567a6870e3bedfea1fd74f3f3177004.1545126272.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1545126272.git.vilhelm.gray@gmail.com>
References: <cover.1545126272.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of the for_each_set_clump8 macro warrants test cases to
verify the implementation. This patch adds test case checks for whether
an out-of-bounds clump index is returned, a zero clump is returned, or
the returned clump value differs from the expected clump value.

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 lib/test_bitmap.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..8a8dbe513ab4 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -88,6 +88,36 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
+				    const unsigned int offset,
+				    const unsigned int size,
+				    const unsigned char *const clump_exp,
+				    const unsigned long *const clump)
+{
+	unsigned long exp;
+
+	if (offset >= size) {
+		pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %zu, got %zu\n",
+			srcfile, line, size, offset);
+		return false;
+	}
+
+	exp = clump_exp[offset / 8];
+	if (!exp) {
+		pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %zu with clump value 0",
+			srcfile, line, offset);
+		return false;
+	}
+
+	if (*clump != exp) {
+		pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
+			srcfile, line, exp, *clump);
+		return false;
+	}
+
+	return true;
+}
+
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -104,6 +134,7 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
+#define expect_eq_clump8(...)		__expect_eq(clump, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -361,6 +392,41 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
+static const unsigned char clump_exp[] __initconst = {
+	0x01,	/* 1 bit set */
+	0x02,	/* non-edge 1 bit set */
+	0x00,	/* zero bits set */
+	0x28,	/* 3 bits set across 4-bit boundary */
+	0x28,	/* Repeated clump */
+	0x0F,	/* 4 bits set */
+	0xFF,	/* all bits set */
+	0x05,	/* non-adjacent 2 bits set */
+};
+
+static void __init test_for_each_set_clump8(void)
+{
+	unsigned int start;
+	unsigned long clump;
+#define CLUMP_BITMAP_NUMBITS 64
+	DECLARE_BITMAP(bits, CLUMP_BITMAP_NUMBITS);
+#define CLUMP_SIZE 8
+	const size_t size = DIV_ROUND_UP(CLUMP_BITMAP_NUMBITS, CLUMP_SIZE);
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_BITMAP_NUMBITS);
+	bitmap_set(bits, 0, 1);		/* 0x01 */
+	bitmap_set(bits, 8, 1);		/* 0x02 */
+	bitmap_set(bits, 27, 3);	/* 0x28 */
+	bitmap_set(bits, 35, 3);	/* 0x28 */
+	bitmap_set(bits, 40, 4);	/* 0x0F */
+	bitmap_set(bits, 48, 8);	/* 0xFF */
+	bitmap_set(bits, 56, 1);	/* 0x05 - part 1 */
+	bitmap_set(bits, 58, 1);	/* 0x05 - part 2 */
+
+	for_each_set_clump8(start, clump, bits, size)
+		expect_eq_clump8(offset, size, clump_exp, clump);
+}
+
 static int __init test_bitmap_init(void)
 {
 	test_zero_clear();
@@ -369,6 +435,7 @@ static int __init test_bitmap_init(void)
 	test_bitmap_arr32();
 	test_bitmap_parselist();
 	test_mem_optimisations();
+	test_for_each_set_clump8();
 
 	if (failed_tests == 0)
 		pr_info("all %u tests passed\n", total_tests);
-- 
2.20.1

