Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD48214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zbh6m5Zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfBKX2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45417 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfBKX2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so632224wrn.12;
        Mon, 11 Feb 2019 15:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=z2wBXeZpdgS2whrOf1GfxoMk6jA5R7ZT/5qYfN3QkBU=;
        b=Zbh6m5Zrmm+VHGJ2ULclwxxHyG6ftZXov0BIoqLCRCUDGFRFYOa+lc9EQX6MwTSph4
         SZTPzgeaijGSBTtX3Lx/J3NIoKr0ZNUT3fNnTvYL45vxrtWPE3ZU0L/VXgvh1NNdBTRm
         else8gozkwQFQhjYHAOeDynf11VjS2XGUJKDOJfrz1GxdoMO2birYoU4tZ5ykfp2TQhv
         jy3MYKWOK86RKIHQiHypKlcYncXysEX0xWtZPebS1EswWwY/n5CyCq9pX1wd8QQB0tQz
         nTv2dej89BxSfee7e6JU83FBZgvZ2y/Lg1h6DpAwo0jkykSpUx6RXyJskr1ys5NZ3bAb
         83yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=z2wBXeZpdgS2whrOf1GfxoMk6jA5R7ZT/5qYfN3QkBU=;
        b=DXkoowZwatknyRJf0rY0488PJAR+5bMLww7ZmEWMdb9kwgG8E41TVtYvcFlcwbaZIl
         GktzCiHAHs/BkZQCrB2kK1RCVc1p4cZhKqSYutWDmOjEZai/yxMRsohVfY7GNxGhMdXm
         Jo7X/5ktDl6wGCOoG7XIkOX56bj4oTPp78RsmFmnlTOIV9g49Z45H2X+8xnuV+ZvZX2r
         zQRx9nPVoF9R+aJk678Iv/z9o2O18vszm8kyj4ewoZixybL4xSFtQxjvuI9j9Ld1oN2L
         M8N46jNAqawzBgR9n321mceR3bncDvObkbV2ZuqMOfcs60XHsYhE+0F+wcz/jlzNur5Q
         bzdw==
X-Gm-Message-State: AHQUAubtBYwHb9MsMOTkHmtYFg3OsYPNJroTw2RkK0ZxWcmQ2HYU0hFV
        DUZ2yL2LWFRS/GAKQfahESw=
X-Google-Smtp-Source: AHgI3IZy4G/4e2saYx+CEztdSuW7qvUMx60+naYXdTjvjWygEiGkF8VDSetOvwTz4ZeilENVWIwR+A==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr516008wrr.218.1549927720856;
        Mon, 11 Feb 2019 15:28:40 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:40 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 11/12] __wr_after_init: test write rare functionality
Date:   Tue, 12 Feb 2019 01:27:48 +0200
Message-Id: <3a5bbfcf067bbbf03b04c70a1b57eef114f2f192.1549927666.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set of test cases meant to confirm that the write rare functionality
works as expected.
It can be optionally compiled as module.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 mm/Kconfig.debug           |   8 +++
 mm/Makefile                |   1 +
 mm/test_write_rare.c (new) | 136 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 9a7b8b049d04..a62c31901fea 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -94,3 +94,11 @@ config DEBUG_RODATA_TEST
     depends on STRICT_KERNEL_RWX
     ---help---
       This option enables a testcase for the setting rodata read-only.
+
+config DEBUG_PRMEM_TEST
+    tristate "Run self test for statically allocated protected memory"
+    depends on PRMEM
+    default n
+    help
+      Tries to verify that the protection for statically allocated memory
+      works correctly and that the memory is effectively protected.
diff --git a/mm/Makefile b/mm/Makefile
index ef3867c16ce0..8de1d468f4e7 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_PRMEM) += prmem.o
+obj-$(CONFIG_DEBUG_PRMEM_TEST) += test_write_rare.o
 obj-$(CONFIG_KSM) += ksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_SLAB) += slab.o
diff --git a/mm/test_write_rare.c b/mm/test_write_rare.c
new file mode 100644
index 000000000000..dd2a0e2d6024
--- /dev/null
+++ b/mm/test_write_rare.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * test_write_rare.c
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/prmem.h>
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+extern long __start_wr_after_init;
+extern long __end_wr_after_init;
+
+static __wr_after_init int scalar = '0';
+static __wr_after_init u8 array[PAGE_SIZE * 3] __aligned(PAGE_SIZE);
+
+/* The section must occupy a non-zero number of whole pages */
+static bool test_alignment(void)
+{
+	unsigned long pstart = (unsigned long)&__start_wr_after_init;
+	unsigned long pend = (unsigned long)&__end_wr_after_init;
+
+	if (WARN((pstart & ~PAGE_MASK) || (pend & ~PAGE_MASK) ||
+		 (pstart >= pend), "Boundaries test failed."))
+		return false;
+	pr_info("Boundaries test passed.");
+	return true;
+}
+
+static bool test_pattern(void)
+{
+	return (memchr_inv(array, '0', PAGE_SIZE / 2) ||
+		memchr_inv(array + PAGE_SIZE / 2, '1', PAGE_SIZE * 3 / 4) ||
+		memchr_inv(array + PAGE_SIZE * 5 / 4, '0', PAGE_SIZE / 2) ||
+		memchr_inv(array + PAGE_SIZE * 7 / 4, '1', PAGE_SIZE * 3 / 4) ||
+		memchr_inv(array + PAGE_SIZE * 5 / 2, '0', PAGE_SIZE / 2));
+}
+
+static bool test_wr_memset(void)
+{
+	int new_val = '1';
+
+	wr_memset(&scalar, new_val, sizeof(scalar));
+	if (WARN(memchr_inv(&scalar, new_val, sizeof(scalar)),
+		 "Scalar write rare memset test failed."))
+		return false;
+
+	pr_info("Scalar write rare memset test passed.");
+
+	wr_memset(array, '0', PAGE_SIZE * 3);
+	if (WARN(memchr_inv(array, '0', PAGE_SIZE * 3),
+		 "Array write rare memset test failed."))
+		return false;
+
+	wr_memset(array + PAGE_SIZE / 2, '1', PAGE_SIZE * 2);
+	if (WARN(memchr_inv(array + PAGE_SIZE / 2, '1', PAGE_SIZE * 2),
+		 "Array write rare memset test failed."))
+		return false;
+
+	wr_memset(array + PAGE_SIZE * 5 / 4, '0', PAGE_SIZE / 2);
+	if (WARN(memchr_inv(array + PAGE_SIZE * 5 / 4, '0', PAGE_SIZE / 2),
+		 "Array write rare memset test failed."))
+		return false;
+
+	if (WARN(test_pattern(), "Array write rare memset test failed."))
+		return false;
+
+	pr_info("Array write rare memset test passed.");
+	return true;
+}
+
+static u8 array_1[PAGE_SIZE * 2];
+static u8 array_2[PAGE_SIZE * 2];
+
+static bool test_wr_memcpy(void)
+{
+	int new_val = 0x12345678;
+
+	wr_assign(scalar, new_val);
+	if (WARN(memcmp(&scalar, &new_val, sizeof(scalar)),
+		 "Scalar write rare memcpy test failed."))
+		return false;
+	pr_info("Scalar write rare memcpy test passed.");
+
+	wr_memset(array, '0', PAGE_SIZE * 3);
+	memset(array_1, '1', PAGE_SIZE * 2);
+	memset(array_2, '0', PAGE_SIZE * 2);
+	wr_memcpy(array + PAGE_SIZE / 2, array_1, PAGE_SIZE * 2);
+	wr_memcpy(array + PAGE_SIZE * 5 / 4, array_2, PAGE_SIZE / 2);
+
+	if (WARN(test_pattern(), "Array write rare memcpy test failed."))
+		return false;
+
+	pr_info("Array write rare memcpy test passed.");
+	return true;
+}
+
+static __wr_after_init int *dst;
+static int reference = 0x54;
+
+static bool test_wr_rcu_assign_pointer(void)
+{
+	wr_rcu_assign_pointer(dst, &reference);
+	return dst == &reference;
+}
+
+static int __init test_static_wr_init_module(void)
+{
+	pr_info("static write rare test");
+	if (WARN(!(test_alignment() &&
+		   test_wr_memset() &&
+		   test_wr_memcpy() &&
+		   test_wr_rcu_assign_pointer()),
+		 "static write rare test failed"))
+		return -EFAULT;
+	pr_info("static write rare test passed");
+	return 0;
+}
+
+module_init(test_static_wr_init_module);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Igor Stoppa <igor.stoppa@huawei.com>");
+MODULE_DESCRIPTION("Test module for static write rare.");
-- 
2.19.1

