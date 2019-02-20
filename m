Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA90DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC3920685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE/VJWup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfBTIhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:37:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38393 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfBTIh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:37:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id j19so19256641ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PHclHZKSkpOVEQ71tOTWZyHKtx1aXyaZkJRRxxKNEY=;
        b=OE/VJWupM6QrjhRXdG/R3xwWUhdIsisEvXyQbOSQSt+MZ5Klo4Ap2ORf1d8Cz0f449
         NzqumUEcPRcwtS2VPMnNvFtYg1+ra0zuzw07n3AMg4tfaPqsy6H9Zu6kcRzoOlgtQI91
         zqhbIE/hpGNF7JkN3pMGdxkAmFw+waL6Q+UWe/eLRya2fJM8OLBaz30W9xHBkUON1gJX
         Ex2ycuKtHDFTHvlr8POu5NvGepwpZnXbngJW0SDfjTKKsq6kAiad8LWAdbWenT+FquPN
         9oWH3T1FbL6qdIj5OPGw77KazbFanNwotZILj9lpzYwlUYELJYXoVmrov4mJmcc6EHFi
         TeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5PHclHZKSkpOVEQ71tOTWZyHKtx1aXyaZkJRRxxKNEY=;
        b=h9jLwB+9n+dUEj0DrEhRuRpQQmA9XfE6W9vnXtQUESMrKkxQD1Yafar8rqS8jN5Xhy
         ueQRdXc7j0XqFYCKB+7ghij+OXvA/mM7ECzW4vmugEBwNUugzZAcAYmTzwM/MR+jAqLy
         3bWm3bOhjKP4KoXAumLu2nJ9g9DVkO72rOZl49mkIlPz0VfVNQ1fcWXbS3tbijjoluzC
         JTdTKjjNiSKB7L+5G2iW59xefsXNjPMX0Q1NjecfwyKd882ZyIci8jckqLV0i9KK6hV/
         4BC2NBqvY8AROtUPJLY/kwPsjOXPwqGdpbixhCNkE/YBj6A2i9rWl+ul4UKgvnCKSOsO
         3oyg==
X-Gm-Message-State: AHQUAuZkMNAr1GTnz6RPIVGYDW4PUA7e4KwlQd3JS3k9DyoFJWuxZmYV
        RcaXD8QCKAzoTkXlsuoa9sg=
X-Google-Smtp-Source: AHgI3Ib2MLT/K3gadPy4a6oCQ6xURtNQlrmuYPORq6G8dVmLpUt4dolb4ahSHC9IE+YO3Pil8o/KPg==
X-Received: by 2002:a2e:9204:: with SMTP id k4mr2620189ljg.0.1550651844712;
        Wed, 20 Feb 2019 00:37:24 -0800 (PST)
Received: from localhost ([188.162.52.148])
        by smtp.gmail.com with ESMTPSA id b14sm860911lji.25.2019.02.20.00.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:37:24 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 6/6] lib/test_bitmap: add tests for bitmap_parselist_user
Date:   Wed, 20 Feb 2019 11:37:05 +0300
Message-Id: <20190220083705.14050-7-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220083705.14050-1-ynorov@marvell.com>
References: <20190220083705.14050-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate existing bitmap_parselist() tests to bitmap_parselist_user().

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 709424a788ee..d4ecac0da160 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 static unsigned total_tests __initdata;
 static unsigned failed_tests __initdata;
@@ -278,39 +279,63 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "0-\n", NULL, 8, 0},
 };
 
-static void __init test_bitmap_parselist(void)
+static void __init __test_bitmap_parselist(int is_user)
 {
 	int i;
 	int err;
 	ktime_t time;
 	DECLARE_BITMAP(bmap, 2048);
+	char *mode = is_user ? "_user"  : "";
 
 	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
 #define ptest parselist_tests[i]
 
-		time = ktime_get();
-		err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
-		time = ktime_get() - time;
+		if (is_user) {
+			mm_segment_t orig_fs = get_fs();
+			size_t len = strlen(ptest.in);
+
+			set_fs(KERNEL_DS);
+			time = ktime_get();
+			err = bitmap_parselist_user(ptest.in, len,
+						    bmap, ptest.nbits);
+			time = ktime_get() - time;
+			set_fs(orig_fs);
+		} else {
+			time = ktime_get();
+			err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
+			time = ktime_get() - time;
+		}
 
 		if (err != ptest.errno) {
-			pr_err("test %d: input is %s, errno is %d, expected %d\n",
-					i, ptest.in, err, ptest.errno);
+			pr_err("parselist%s: %d: input is %s, errno is %d, expected %d\n",
+					mode, i, ptest.in, err, ptest.errno);
 			continue;
 		}
 
 		if (!err && ptest.expected
 			 && !__bitmap_equal(bmap, ptest.expected, ptest.nbits)) {
-			pr_err("test %d: input is %s, result is 0x%lx, expected 0x%lx\n",
-					i, ptest.in, bmap[0], *ptest.expected);
+			pr_err("parselist%s: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
+					mode, i, ptest.in, bmap[0],
+					*ptest.expected);
 			continue;
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_err("test %d: input is '%s' OK, Time: %llu\n",
-					i, ptest.in, time);
+			pr_err("parselist%s: %d: input is '%s' OK, Time: %llu\n",
+					mode, i, ptest.in, time);
 	}
 }
 
+static void __init test_bitmap_parselist(void)
+{
+	__test_bitmap_parselist(0);
+}
+
+static void __init test_bitmap_parselist_user(void)
+{
+	__test_bitmap_parselist(1);
+}
+
 #define EXP_BYTES	(sizeof(exp) * 8)
 
 static void __init test_bitmap_arr32(void)
@@ -383,6 +408,7 @@ static int __init test_bitmap_init(void)
 	test_copy();
 	test_bitmap_arr32();
 	test_bitmap_parselist();
+	test_bitmap_parselist_user();
 	test_mem_optimisations();
 
 	if (failed_tests == 0)
-- 
2.17.1

