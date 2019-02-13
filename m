Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DDFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD539222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIw6rtOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395253AbfBMWmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33961 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395202AbfBMWmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so4414198wrg.1;
        Wed, 13 Feb 2019 14:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=wCRDB9N5TtYa3rCa6suYTZMLeDPPoUYVjqLC9Yos7dc=;
        b=TIw6rtOyjaONtQsjhIlQpVLu2ZEQ+rEV+L3V2lcYZ0in1bYgfu7uBdU5k23yOKY1fu
         XU9Mxu+MU2HuBZVjPKxLOXmTqy6w5940ncoJTA0nr67mtrVOFBX5c7KM91Yn0FA0U+gb
         NkowSC0nyRckPRsIDwiUOslXXKxWKbadr043RBh+Cga1oyqFagDiS1WiT3agTR3Z3Plu
         fRTH0dNdS7wH4tCEuMF81FGEoyLIjYgzlBohqqUYqT/CNuZAGcMsdUKrgkAs2UI+h4WS
         +d4L7KdQHozJkRft3bsWZnCXq4PzN7QJ3ZozDtfNsKw6lEYxQuWxNq8TgDGfZhsGgqBp
         zF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=wCRDB9N5TtYa3rCa6suYTZMLeDPPoUYVjqLC9Yos7dc=;
        b=GAk3y8sDJzyE3CF78Pefm+ZYGTBw/cCSOQDbY55hRDxFARtm82V5sAlwfT8Rzciu7C
         0pT/Se956mcbiETttudkUuXHqE3NcK3sw8uJ2KtSomqruEupbeXpXntaaIya3P0Pezvp
         fGIWyvM8+CSYLuegtkGwLuAEqY+IAi7MkeH8LBQ1WgLYO7g9aF3NTedSXYT37TI+KU7q
         krek1lpo3Qt4X2foeBhjGwVk1eIdeU/WKeStJzL2az655s825ZRu3VocCvUKnuxjYdMS
         iLn4lX/19Gvq2ZahDRhpg3ZYAxbHHdo8g7AQszc6c1+NRJkmeautuj7hdQ45JcgZh8qQ
         Wg9Q==
X-Gm-Message-State: AHQUAuaLfKKo5hoHYw0i347lBk7aYr1Z8WkBQTo7fUgUpHnh4f4ne3pz
        +GJledTnaGN2BhnLOKVYWh8=
X-Google-Smtp-Source: AHgI3Ial7QSwV8vc2DB+PujK1Kt2IXsKfk76ElX0Wf6gNMPti4q1AkMfAbFdrtoGcQolDZsKqU9/qg==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr292984wrr.233.1550097754132;
        Wed, 13 Feb 2019 14:42:34 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:33 -0800 (PST)
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
Subject: [RFC PATCH v5 11/12] __wr_after_init: test write rare functionality
Date:   Thu, 14 Feb 2019 00:41:40 +0200
Message-Id: <16a099a9d40e00591b106676eb7f18cc304b1f85.1550097697.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550097697.git.igor.stoppa@huawei.com>
References: <cover.1550097697.git.igor.stoppa@huawei.com>
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
 mm/test_write_rare.c (new) | 142 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

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
index 000000000000..e9ebc8e12041
--- /dev/null
+++ b/mm/test_write_rare.c
@@ -0,0 +1,142 @@
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
+	if (memchr_inv(array, '0', PAGE_SIZE / 2))
+		return pr_info("Pattern part 1 failed.");
+	if (memchr_inv(array + PAGE_SIZE / 2, '1', PAGE_SIZE * 3 / 4) )
+		return pr_info("Pattern part 2 failed.");
+	if (memchr_inv(array + PAGE_SIZE * 5 / 4, '0', PAGE_SIZE / 2))
+		return pr_info("Pattern part 3 failed.");
+	if (memchr_inv(array + PAGE_SIZE * 7 / 4, '1', PAGE_SIZE * 3 / 4))
+		return pr_info("Pattern part 4 failed.");
+	if (memchr_inv(array + PAGE_SIZE * 5 / 2, '0', PAGE_SIZE / 2))
+		return pr_info("Pattern part 5 failed.");
+	return 0;
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
+		 "Array page aligned write rare memset test failed."))
+		return false;
+
+	wr_memset(array + PAGE_SIZE / 2, '1', PAGE_SIZE * 2);
+	if (WARN(memchr_inv(array + PAGE_SIZE / 2, '1', PAGE_SIZE * 2),
+		 "Array half page aligned write rare memset test failed."))
+		return false;
+
+	wr_memset(array + PAGE_SIZE * 5 / 4, '0', PAGE_SIZE / 2);
+	if (WARN(memchr_inv(array + PAGE_SIZE * 5 / 4, '0', PAGE_SIZE / 2),
+		 "Array quarter page aligned write rare memset test failed."))
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

