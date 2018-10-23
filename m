Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F08ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7482082B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9X2B2Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7482082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeJXGBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46968 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbeJXGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so2783963lji.13;
        Tue, 23 Oct 2018 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=5k2OYOiqWNcnfE7W+3KF/KBNiSrfTjcJhGVfescDD7o=;
        b=E9X2B2CpnKD8qa/LlwKbw4cqywWLq+kgQJxUHmDXA/7aJp+l2MwLvziy7JYXJR2pEv
         9ibFPiGUYTS/Qlb0EaDxVRWYjcdvYGbvdL3im1xYKw1TGKh8dJ/tXwP/AUV0dYTUqYPO
         dbdOFG35QNYcyRS3e1oO/wuojHCxN7/EOLMwQSo1/ko2daDNHFMzlW5eLmfHKqdKi8+I
         fA4rUKveaRuwVhnXbvQvfkj9atodqyBsetdWmgi6drrvxPw36vSsWD/60sUqIbDKcDgf
         sGI6PCYGGEp8GrYUaYwWLruOvkU+/A2BBMDTX+SIeB6NVHmFiqj2jLq/1A9Atn3JB8T4
         5plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=5k2OYOiqWNcnfE7W+3KF/KBNiSrfTjcJhGVfescDD7o=;
        b=nCIV64TuBEnR/h0a0Ldq/unF9rUtuzBivll1OoBKrPvfWigqinPM0G9PlL/PVD6vQc
         UdndujIV2RFANDSnIZQpQ0h/4ueYkZU3HLAoETLvO2MKT8FPJ/8lxyk8ytnbDxHnspeH
         2Rblo6j46nhVHGehaxLPqzzyNUBqGpHRtQVoQYxu1CYhFlhgxgFUdRfwHiUVexZVyxXP
         XdUVRnEJw8XqDjedsIzyEmoVeU/rGDxSWmD41ZPdPIEIakQgA7DZvlrvf5gG4YteIORY
         Pbog8/03pFaoJlo6C6dLWRyNWOa/FbK0TV4Yl75ou84ltQijU9c3xJmlSSg3eRzdFsff
         aIwg==
X-Gm-Message-State: AGRZ1gJu/AIcBIK2koVECplOLhT52tacndzeoJmMcp10/L69S0ezw7+j
        VqB0IYe7r45kHfaAnLfQSqo=
X-Google-Smtp-Source: ACcGV62ipIIRNsS/46sZsIuOqouun/oWdvVQjUzMek7vtdGeL9YSFlZUWQAvsBQSWnrWxYsmQTJLtA==
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr10422349ljh.154.1540330579056;
        Tue, 23 Oct 2018 14:36:19 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:36:18 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Edward Cree <ecree@solarflare.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] prmem: test cases for prlist and prhlist
Date:   Wed, 24 Oct 2018 00:35:02 +0300
Message-Id: <20181023213504.28905-16-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These test cases focus on the basic operations required to operate
both prlist and prhlist data, in particular creating, growing, shrinking,
destroying.

They can also be useful as reference for practical use of write-rare lists.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Edward Cree <ecree@solarflare.com>
CC: linux-kernel@vger.kernel.org
---
 MAINTAINERS       |   1 +
 lib/Kconfig.debug |   9 ++
 lib/Makefile      |   1 +
 lib/test_prlist.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 263 insertions(+)
 create mode 100644 lib/test_prlist.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f5689c014e07..e7f7cb1682a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9465,6 +9465,7 @@ F:	mm/test_write_rare.c
 F:	mm/test_pmalloc.c
 F:	Documentation/core-api/prmem.rst
 F:	include/linux/prlist.h
+F:	lib/test_prlist.c
 
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4966c4fbe7f7..40039992f05f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2034,6 +2034,15 @@ config IO_STRICT_DEVMEM
 
 	  If in doubt, say Y.
 
+config DEBUG_PRLIST_TEST
+	bool "Testcase for Protected Linked List"
+	depends on STRICT_KERNEL_RWX && PRMEM
+	help
+	  This option enables the testing of an implementation of linked
+	  list based on write rare memory.
+	  The test cases can also be used as examples for how to use the
+	  prlist data structure(s).
+
 source "arch/$(SRCARCH)/Kconfig.debug"
 
 endmenu # Kernel hacking
diff --git a/lib/Makefile b/lib/Makefile
index 423876446810..fe7200e84c5f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -270,3 +270,4 @@ obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
 obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
 obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
 obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
+obj-$(CONFIG_DEBUG_PRLIST_TEST) += test_prlist.o
diff --git a/lib/test_prlist.c b/lib/test_prlist.c
new file mode 100644
index 000000000000..8ee46795d72a
--- /dev/null
+++ b/lib/test_prlist.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * test_prlist.c: Test cases for protected doubly linked list
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/bug.h>
+#include <linux/prlist.h>
+
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+static struct pmalloc_pool *pool;
+
+static PRLIST_HEAD(test_prlist_head);
+
+/* ---------------------- prlist test functions ---------------------- */
+static bool test_init_prlist_head(void)
+{
+	if (WARN(test_prlist_head.prev != &test_prlist_head ||
+		 test_prlist_head.next != &test_prlist_head,
+		 "static initialization of static prlist_head failed"))
+		return false;
+	wr_ptr(&test_prlist_head.next, NULL);
+	wr_ptr(&test_prlist_head.prev, NULL);
+	if (WARN(test_prlist_head.prev || test_prlist_head.next,
+		 "resetting of static prlist_head failed"))
+		return false;
+	INIT_PRLIST_HEAD(&test_prlist_head);
+	if (WARN(test_prlist_head.prev != &test_prlist_head ||
+		 test_prlist_head.next != &test_prlist_head,
+		 "initialization of static prlist_head failed"))
+		return false;
+	pr_info("initialization of static prlist_head passed");
+	return true;
+}
+
+struct prlist_data {
+	int d_int;
+	union prlist_head node;
+	unsigned long long d_ulonglong;
+};
+
+
+#define LIST_INTERVAL 5
+#define LIST_INTERVALS 3
+#define LIST_NODES (LIST_INTERVALS * LIST_INTERVAL)
+static bool test_build_prlist(void)
+{
+	short i;
+	struct prlist_data *data;
+	int delta;
+
+	pool = prlist_create_pool();
+	if (WARN(!pool, "could not create pool"))
+		return false;
+
+	for (i = 0; i < LIST_NODES; i++) {
+		data = (struct prlist_data *)pmalloc(pool, sizeof(*data));
+		if (WARN(!data, "Failed to allocate prlist node"))
+			goto out;
+		wr_int(&data->d_int, i);
+		wr_ulonglong(&data->d_ulonglong, i);
+		prlist_add_tail(&data->node, &test_prlist_head);
+	}
+	for (i = 1; i < LIST_NODES; i++) {
+		data = (struct prlist_data *)pmalloc(pool, sizeof(*data));
+		if (WARN(!data, "Failed to allocate prlist node"))
+			goto out;
+		wr_int(&data->d_int, i);
+		wr_ulonglong(&data->d_ulonglong, i);
+		prlist_add(&data->node, &test_prlist_head);
+	}
+	i = LIST_NODES;
+	delta = -1;
+	list_for_each_entry(data, &test_prlist_head, node) {
+		i += delta;
+		if (!i)
+			delta = 1;
+		if (WARN(data->d_int != i || data->d_ulonglong != i,
+			 "unexpected value in prlist, build test failed"))
+			goto out;
+	}
+	pr_info("build prlist test passed");
+	return true;
+out:
+	pmalloc_destroy_pool(pool);
+	return false;
+}
+
+static bool test_teardown_prlist(void)
+{
+	short i;
+
+	for (i = 0; !list_empty(&test_prlist_head.list); i++)
+		prlist_del(test_prlist_head.next);
+	if (WARN(i != LIST_NODES * 2 - 1, "teardown prlist test failed"))
+		return false;
+	pmalloc_destroy_pool(pool);
+	pr_info("teardown prlist test passed");
+	return true;
+}
+
+static bool test_prlist(void)
+{
+	if (WARN(!(test_init_prlist_head() &&
+		   test_build_prlist() &&
+		   test_teardown_prlist()),
+		 "prlist test failed"))
+		return false;
+	pr_info("prlist test passed");
+	return true;
+}
+
+/* ---------------------- prhlist test functions ---------------------- */
+static PRHLIST_HEAD(test_prhlist_head);
+
+static bool test_init_prhlist_head(void)
+{
+	if (WARN(test_prhlist_head.first,
+		 "static initialization of static prhlist_head failed"))
+		return false;
+	wr_ptr(&test_prhlist_head.first, (void *)-1);
+	if (WARN(!test_prhlist_head.first,
+		 "resetting of static prhlist_head failed"))
+		return false;
+	INIT_PRHLIST_HEAD(&test_prhlist_head);
+	if (WARN(!test_prlist_head.prev,
+		 "initialization of static prhlist_head failed"))
+		return false;
+	pr_info("initialization of static prlist_head passed");
+	return true;
+}
+
+struct prhlist_data {
+	int d_int;
+	union prhlist_node node;
+	unsigned long long d_ulonglong;
+};
+
+static bool test_build_prhlist(void)
+{
+	short i;
+	struct prhlist_data *data;
+	union prhlist_node *anchor;
+
+	pool = prhlist_create_pool();
+	if (WARN(!pool, "could not create pool"))
+		return false;
+
+	for (i = 2 * LIST_INTERVAL - 1; i >= LIST_INTERVAL; i--) {
+		data = (struct prhlist_data *)pmalloc(pool, sizeof(*data));
+		if (WARN(!data, "Failed to allocate prhlist node"))
+			goto out;
+		wr_int(&data->d_int, i);
+		wr_ulonglong(&data->d_ulonglong, i);
+		prhlist_add_head(&data->node, &test_prhlist_head);
+	}
+	anchor = test_prhlist_head.first;
+	for (i = 0; i < LIST_INTERVAL; i++) {
+		data = (struct prhlist_data *)pmalloc(pool, sizeof(*data));
+		if (WARN(!data, "Failed to allocate prhlist node"))
+			goto out;
+		wr_int(&data->d_int, i);
+		wr_ulonglong(&data->d_ulonglong, i);
+		prhlist_add_before(&data->node, anchor);
+	}
+	hlist_for_each_entry(data, &test_prhlist_head, node)
+		if (!data->node.next)
+			anchor = &data->node;
+	for (i = 3 * LIST_INTERVAL - 1; i >= 2 * LIST_INTERVAL; i--) {
+		data = (struct prhlist_data *)pmalloc(pool, sizeof(*data));
+		if (WARN(!data, "Failed to allocate prhlist node"))
+			goto out;
+		wr_int(&data->d_int, i);
+		wr_ulonglong(&data->d_ulonglong, i);
+		prhlist_add_behind(&data->node, anchor);
+	}
+	i = 0;
+	hlist_for_each_entry(data, &test_prhlist_head, node) {
+		if (WARN(data->d_int != i || data->d_ulonglong != i,
+			 "unexpected value in prhlist, build test failed"))
+			goto out;
+		i++;
+	}
+	if (WARN(i != LIST_NODES,
+		 "wrong number of nodes: %d, expectd %d", i, LIST_NODES))
+		goto out;
+	pr_info("build prhlist test passed");
+	return true;
+out:
+	pmalloc_destroy_pool(pool);
+	return false;
+}
+
+static bool test_teardown_prhlist(void)
+{
+	union prhlist_node **pnode;
+	bool retval = false;
+
+	for (pnode = &test_prhlist_head.first->next; *pnode;) {
+		if (WARN(*(*pnode)->pprev != *pnode,
+			 "inconsistent pprev value, delete test failed"))
+			goto err;
+		prhlist_del(*pnode);
+	}
+	prhlist_del(test_prhlist_head.first);
+	if (WARN(!hlist_empty(&test_prhlist_head.head),
+		 "prhlist is not empty, delete test failed"))
+		goto err;
+	pr_info("deletion of prhlist passed");
+	retval = true;
+err:
+	pmalloc_destroy_pool(pool);
+	return retval;
+}
+
+static bool test_prhlist(void)
+{
+	if (WARN(!(test_init_prhlist_head() &&
+		   test_build_prhlist() &&
+		   test_teardown_prhlist()),
+		 "prhlist test failed"))
+		return false;
+	pr_info("prhlist test passed");
+	return true;
+}
+
+static int __init test_prlists_init_module(void)
+{
+	if (WARN(!(test_prlist() &&
+		   test_prhlist()),
+		 "protected lists test failed"))
+		return -EFAULT;
+	pr_info("protected lists test passed");
+	return 0;
+}
+
+module_init(test_prlists_init_module);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Igor Stoppa <igor.stoppa@huawei.com>");
+MODULE_DESCRIPTION("Test module for protected doubly linked list.");
-- 
2.17.1

