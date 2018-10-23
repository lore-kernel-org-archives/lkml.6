Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0810CC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C1520651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqTUqp8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C1520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeJXMc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:32:56 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:40747 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJXMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:32:56 -0400
Received: by mail-it1-f201.google.com with SMTP id z136-v6so3712801itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 21:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i4liTM7DhPQkyMhWTx9SIOf7oCnvjh8LOHAI/o3dxM0=;
        b=vqTUqp8Tg6ilFvs6r7sRzs2MGC2n9yceVmD4gqlTxgWfh6Dz7MMBS4I7H6ZW9n6ntZ
         VCa3f4lwvst9ngY6Hd+H7jzKfzIA32kDxIAxbQRzEenV+eFC6BReOLIzSUF2akgrAsfk
         e9Fk3zUYuxU7+APyETXfgYo/s7t67mP0RL8BGR99svsodE2uBTbcgQwtGNiwDZVxjfQC
         W++SIFYEW+szMba3q8sBuqj5gnF2u8OVVJcYpum5nS+I77FskiLhPG/juf/KzAZc2CAN
         mDCyR64PKgX5HSLVS67YsnRVOM04jvuLFWQh9m+HhHLRo/wvXUQ+gA/Qx9CFTnwgnPVC
         HpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i4liTM7DhPQkyMhWTx9SIOf7oCnvjh8LOHAI/o3dxM0=;
        b=mzuIgB6/F/GeXhgtoyVQZncwl/mnUiuWmuqD6eIVCLCDNAcTf5zNblAYYe8i4cXCMd
         VPRli9cwx0EF0EW+cX1K+2Ju+jmVOfCcu7OjPdcccOEgFLlC/54MjkqWZBhqHA8QHVvh
         Jg7d06bY/nR4/LZ0R9lm7+Js9IFxIw2zzBx2HxWFifYC1Zxek3Ic4vFoF2j64cz0XOUr
         eIrybqtUaFLqTxwGdD29b6nttRWaXRS9r+YdBMoDRRI2uit/3z3g61RSZt2b9i1mInDN
         xyGUPxOXG7oPoHaA7KCm0ohx1791BDKUAttQ8ujCYzuHSWY3xz8619izaevZZx/Q9hM+
         qjUg==
X-Gm-Message-State: AGRZ1gKMMMH+RjKMV5dbwDT1ERJBp7R8Th+WkgdgROE6APwj6M5B/CRs
        rBhPinCN5VrBFBj95/RBsa1JMzwOznxXFfEMIQOZzg==
X-Google-Smtp-Source: AJdET5d7P8dRci7ukLx0FEvpHPKz1sJLYItNi2iv8ph7KOhrIkPTa82qKlIFTNKssRTKSW6z4VzGZIyf1HNaVOftl1DFlA==
X-Received: by 2002:a24:7445:: with SMTP id o66-v6mr257273itc.20.1540339183059;
 Tue, 23 Oct 2018 16:59:43 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:38 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 02/14] kunit: test: add test resource management API
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common API for test managed resources like memory and test
objects. A lot of times a test will want to set up infrastructure to be
used in test cases; this could be anything from just wanting to allocate
some memory to setting up a driver stack; this defines facilities for
creating "test resources" which are managed by the test infrastructure
and are automatically cleaned up at the conclusion of the test.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 109 +++++++++++++++++++++++++++++++++++++++++++
 kunit/test.c         |  95 +++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e0b14b227ac44..1c116a20063da 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,69 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
+struct test_resource;
+
+typedef int (*test_resource_init_t)(struct test_resource *, void *);
+typedef void (*test_resource_free_t)(struct test_resource *);
+
+/**
+ * struct test_resource - represents a *test managed resource*
+ * @allocation: for the user to store arbitrary data.
+ * @free: a user supplied function to free the resource. Populated by
+ * test_alloc_resource().
+ *
+ * Represents a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	struct test_kmalloc_params {
+ *		size_t size;
+ *		gfp_t gfp;
+ *	};
+ *
+ *	static int test_kmalloc_init(struct test_resource *res, void *context)
+ *	{
+ *		struct test_kmalloc_params *params = context;
+ *		res->allocation = kmalloc(params->size, params->gfp);
+ *
+ *		if (!res->allocation)
+ *			return -ENOMEM;
+ *
+ *		return 0;
+ *	}
+ *
+ *	static void test_kmalloc_free(struct test_resource *res)
+ *	{
+ *		kfree(res->allocation);
+ *	}
+ *
+ *	void *test_kmalloc(struct test *test, size_t size, gfp_t gfp)
+ *	{
+ *		struct test_kmalloc_params params;
+ *		struct test_resource *res;
+ *
+ *		params.size = size;
+ *		params.gfp = gfp;
+ *
+ *		res = test_alloc_resource(test, test_kmalloc_init,
+ *			test_kmalloc_free, &params);
+ *		if (res)
+ *			return res->allocation;
+ *		else
+ *			return NULL;
+ *	}
+ */
+struct test_resource {
+	void *allocation;
+	test_resource_free_t free;
+
+	/* private: internal use only. */
+	struct list_head node;
+};
+
 struct test;
 
 /**
@@ -104,6 +167,7 @@ struct test {
 	const char *name; /* Read only after initialization! */
 	spinlock_t lock; /* Gaurds all mutable test state. */
 	bool success; /* Protected by lock. */
+	struct list_head resources; /* Protected by lock. */
 	void (*vprintk)(const struct test *test,
 			const char *level,
 			struct va_format *vaf);
@@ -127,6 +191,51 @@ int test_run_tests(struct test_module *module);
 		} \
 		late_initcall(module_test_init##module)
 
+/**
+ * test_alloc_resource() - Allocates a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user supplied function to initialize the resource.
+ * @free: a user supplied function to free the resource.
+ * @context: for the user to pass in arbitrary data.
+ *
+ * Allocates a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. See &struct test_resource for an
+ * example.
+ */
+struct test_resource *test_alloc_resource(struct test *test,
+					  test_resource_init_t init,
+					  test_resource_free_t free,
+					  void *context);
+
+void test_free_resource(struct test *test, struct test_resource *res);
+
+/**
+ * test_kmalloc() - Just like kmalloc() except the allocation is *test managed*.
+ * @test: The test context object.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * Just like `kmalloc(...)`, except the allocation is managed by the test case
+ * and is automatically cleaned up after the test case concludes. See &struct
+ * test_resource for more information.
+ */
+void *test_kmalloc(struct test *test, size_t size, gfp_t gfp);
+
+/**
+ * test_kzalloc() - Just like test_kmalloc(), but zeroes the allocation.
+ * @test: The test context object.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kzalloc() and test_kmalloc() for more information.
+ */
+static inline void *test_kzalloc(struct test *test, size_t size, gfp_t gfp)
+{
+	return test_kmalloc(test, size, gfp | __GFP_ZERO);
+}
+
+void test_cleanup(struct test *test);
+
 void __printf(3, 4) test_printk(const char *level,
 				const struct test *test,
 				const char *fmt, ...);
diff --git a/kunit/test.c b/kunit/test.c
index 4732e5f0d7575..fd0a51245215e 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -66,6 +66,7 @@ static void test_vprintk(const struct test *test,
 int test_init_test(struct test *test, const char *name)
 {
 	spin_lock_init(&test->lock);
+	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->vprintk = test_vprintk;
 
@@ -93,6 +94,11 @@ static void test_run_case_internal(struct test *test,
 	test_case->run_case(test);
 }
 
+static void test_case_internal_cleanup(struct test *test)
+{
+	test_cleanup(test);
+}
+
 /*
  * Performs post validations and cleanup after a test case was run.
  * XXX: Should ONLY BE CALLED AFTER test_run_case_internal!
@@ -103,6 +109,8 @@ static void test_run_case_cleanup(struct test *test,
 {
 	if (module->exit)
 		module->exit(test);
+
+	test_case_internal_cleanup(test);
 }
 
 /*
@@ -150,6 +158,93 @@ int test_run_tests(struct test_module *module)
 	return 0;
 }
 
+struct test_resource *test_alloc_resource(struct test *test,
+					  test_resource_init_t init,
+					  test_resource_free_t free,
+					  void *context)
+{
+	struct test_resource *res;
+	unsigned long flags;
+	int ret;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return NULL;
+
+	ret = init(res, context);
+	if (ret)
+		return NULL;
+
+	res->free = free;
+	spin_lock_irqsave(&test->lock, flags);
+	list_add_tail(&res->node, &test->resources);
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return res;
+}
+
+void test_free_resource(struct test *test, struct test_resource *res)
+{
+	res->free(res);
+	list_del(&res->node);
+	kfree(res);
+}
+
+struct test_kmalloc_params {
+	size_t size;
+	gfp_t gfp;
+};
+
+static int test_kmalloc_init(struct test_resource *res, void *context)
+{
+	struct test_kmalloc_params *params = context;
+
+	res->allocation = kmalloc(params->size, params->gfp);
+	if (!res->allocation)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void test_kmalloc_free(struct test_resource *res)
+{
+	kfree(res->allocation);
+}
+
+void *test_kmalloc(struct test *test, size_t size, gfp_t gfp)
+{
+	struct test_kmalloc_params params;
+	struct test_resource *res;
+
+	params.size = size;
+	params.gfp = gfp;
+
+	res = test_alloc_resource(test,
+				  test_kmalloc_init,
+				  test_kmalloc_free,
+				  &params);
+
+	if (res)
+		return res->allocation;
+	else
+		return NULL;
+}
+
+void test_cleanup(struct test *test)
+{
+	struct test_resource *resource, *resource_safe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	list_for_each_entry_safe(resource,
+				 resource_safe,
+				 &test->resources,
+				 node) {
+		test_free_resource(test, resource);
+	}
+	spin_unlock_irqrestore(&test->lock, flags);
+}
+
 void test_printk(const char *level,
 		 const struct test *test,
 		 const char *fmt, ...)
-- 
2.19.1.568.g152ad8e336-goog

