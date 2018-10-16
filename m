Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9485C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B452087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miUaO1AJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B452087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJQHqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:43 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:55708 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeJQHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:43 -0400
Received: by mail-oi1-f202.google.com with SMTP id m129-v6so16618614oif.22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EYulDhUL2KJVxxT6QuwulYTstXbq7G4YKkwaMmylt1I=;
        b=miUaO1AJLXHjsNVBpjHC9wyz/g+j/lcPAowKHe7DbDrdWInlhVembL7hgcfTsA3LPM
         IfsjBgjXdJuSxXIgUh2Qe0J3y8k5CLel8kfxRRZTLNqiogneQuujdSXQ/kXG1P0GpXpY
         NhIPynQfbzvbzZwVfJvHQJRoTCdIGAImo0aUYPQrZ0QDePW+lIqtcBqbZ/VSY5MsYcrr
         Og3he5RBlbSVenrSm3kI1nCfqCocmHcptt2Gqr9+ERrIDtRQnfH4QiTybeISLfkGxZ1W
         ClMDVFcT+VGMqBXSNaBkOWAOm4dM5rz/i1WsHg3RcVqRQBH8vYdQeaHo2dOnHkuRcg0e
         ljzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EYulDhUL2KJVxxT6QuwulYTstXbq7G4YKkwaMmylt1I=;
        b=hObXigMwVnm2LTVk6pcU6xVv4rCArQ0SOy8IRIm1YZRbGvp/OlkP9b+N6YWz/RqJeC
         pvTiWY0rQeKr3nog/hKcCOaRe6FhIznHiwO6jq1FRsDXQpK/19gykFwNm4UxXMvuuzmW
         SRePYrZ3ewjz7VpFN26d2NeC9PB/42J3zIarocudPi2oZ/cWRVHqrxuXicJDEECuMYet
         gsItsAmtTVcWEkm2YpHRKDCuDDutF1Zu/0OnBlKS3LbTfIczhOJ5V3BbaUxStjEmK5d9
         wX84HLIxZZlnNA/T05PMqiRbErjS41ehgC/y369yPNyBq84nSkjR0YfjeI0A8VaRjcFQ
         5v3w==
X-Gm-Message-State: ABuFfogRsbpvHByeW/3QXw/6aklJjN6OAlBUiKMS+7zqEAyBhY2vYrNn
        WoJx/HhbEXBgUuhx25bzg1saWd0OJtf7GBVm7Tpdkw==
X-Google-Smtp-Source: ACcGV62cYwMOTA2v1YY9R8wzoV39vOQvSZOW4hobtRYUMuHbOvcBHZfxiG+3UH0nQZ2u1v2ftoc/qEqZuufghCk5we7cKA==
X-Received: by 2002:aca:6a88:: with SMTP id f130-v6mr20441244oic.0.1539734033400;
 Tue, 16 Oct 2018 16:53:53 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:52 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 03/31] kunit: test: added test resource management API
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This creates a common API for test managed resources like memory and
test objects.

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
2.19.1.331.ge82ca0e54c-goog

