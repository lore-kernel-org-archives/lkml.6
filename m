Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996CDC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485E8214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Og+J2o2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485E8214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeJQHql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:41 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:55780 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJQHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:41 -0400
Received: by mail-it1-f201.google.com with SMTP id m123-v6so224227ith.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g8+DXEehmEsKPJ5EdMFvj4dPmmBKovok5Rh31GZ5sNo=;
        b=Og+J2o2y/qIJzKDTrhQzAbp6JfF26UQSl33cgzhn0CeXHTzSX64huCQNNYnFXuFHr9
         2iA+EmBI8JAeyPR6su6LG7qP5Quokm+Na5QjsX7gBpB0+YR+011cpKarp4jQfYXl+fKq
         qHdy2YqgAX7tKDKFk2n2xx9H1Vl/e5vKTlAkeYLak9qtTejIk2zZS11ZmscASPDqegXf
         TY//M+N5LBIgTxbzuK2LYHKvfhbmy9p4QheVg0q5g/sq/ZJp7DrnpPv0H0D+QeQ4iULI
         YfLBC4kLT1jthZeMilJL4PWBYHRSmMEzOJ/9vho/NKHen5xLKzfFCmXY80k0oijMfaxN
         EQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g8+DXEehmEsKPJ5EdMFvj4dPmmBKovok5Rh31GZ5sNo=;
        b=Npwv98VARN4KGXRqm0XPvX6spJdeZnwZbOIsBXY90Zd9uzXWUja2gTQfu37eGVmBtB
         +l+a7Cl8/B1pT4IziwcCGuqM6IcgjQAWvzSykEeqENdob9RmiNu5TTsWMZsV640C9ksM
         UjO5q/QTrWccwghcYy6RBTda8XYx1+Sllzi6dGi2tdBbLs1itsygNaUCHSTvJBv5n1N8
         L7m06japv9I5c3qZfKO46H7ipykPdcjHyj2siY6JTeb8MiMj1bArQA8bFdhOLBulKbnw
         2bO8IdNl2Q8uNWDMfQyjdH51ZPyBzVA0TUsqWwQNctuuNNEoevWquOgA75T6LtnBPI42
         ZfIg==
X-Gm-Message-State: AGRZ1gKrP3Y9X9fwqR/LayrZCFpbk8If2pv41o4w1VaJ1bAaRDKS67tt
        SSNgOA63C0yDF7QcjL0Z3b6twZX4E7lMZxxyqpXO/Q==
X-Google-Smtp-Source: ACcGV62YFgztZjXre4oDVW7eHJ6X2JeDtpCzrkRI/kSKmsM/prFgxXrNKgeYROcVEqyYKwOGkaTe1ObvRb/7C3tFPSAvPw==
X-Received: by 2002:a24:6b97:: with SMTP id v145-v6mr203332itc.40.1539734030616;
 Tue, 16 Oct 2018 16:53:50 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:51 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 02/31] kunit: test: adds KUnit test runner core
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

Adds the KUnit core, which allows test cases to be defined and
associated with common initialization and cleanup logic.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 165 ++++++++++++++++++++++++++++++++++++++++++
 kunit/Makefile       |   2 +-
 kunit/test.c         | 168 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/test.h
 create mode 100644 kunit/test.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
new file mode 100644
index 0000000000000..e0b14b227ac44
--- /dev/null
+++ b/include/kunit/test.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TEST_H
+#define _KUNIT_TEST_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+
+struct test;
+
+/**
+ * struct test_case - represents an individual test case.
+ * @run_case: the function representing the actual test case.
+ * @name: the name of the test case.
+ *
+ * A test case is a function with the signature, ``void (*)(struct test *)``
+ * that makes expectations (see TEST_EXPECT_TRUE()) about code under test. Each
+ * test case is associated with a &struct test_module and will be run after the
+ * module's init function and followed by the module's exit function.
+ *
+ * A test case should be static and should only be created with the TEST_CASE()
+ * macro; additionally, every array of test cases should be terminated with an
+ * empty test case.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	void add_test_basic(struct test *test)
+ *	{
+ *		TEST_EXPECT_EQ(test, 1, add(1, 0));
+ *		TEST_EXPECT_EQ(test, 2, add(1, 1));
+ *		TEST_EXPECT_EQ(test, 0, add(-1, 1));
+ *		TEST_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
+ *		TEST_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
+ *	}
+ *
+ *	static struct test_case example_test_cases[] = {
+ *		TEST_CASE(add_test_basic),
+ *		{},
+ *	};
+ *
+ */
+struct test_case {
+	void (*run_case)(struct test *test);
+	const char name[256];
+
+	/* private: internal use only. */
+	bool success;
+};
+
+/**
+ * TEST_CASE - A helper for creating a &struct test_case
+ * @test_name: a reference to a test case function.
+ *
+ * Takes a symbol for a function representing a test case and creates a &struct
+ * test_case object from it. See the documentation for &struct test_case for an
+ * example on how to use it.
+ */
+#define TEST_CASE(test_name) { .run_case = test_name, .name = #test_name }
+
+/**
+ * struct test_module - describes a related collection of &struct test_case s.
+ * @name: the name of the test. Purely informational.
+ * @init: called before every test case.
+ * @exit: called after every test case.
+ * @test_cases: a null terminated array of test cases.
+ *
+ * A test_module is a collection of related &struct test_case s, such that
+ * @init is called before every test case and @exit is called after every test
+ * case, similar to the notion of a *test fixture* or a *test class* in other
+ * unit testing frameworks like JUnit or Googletest.
+ *
+ * Every &struct test_case must be associated with a test_module for KUnit to
+ * run it.
+ */
+struct test_module {
+	const char name[256];
+	int (*init)(struct test *test);
+	void (*exit)(struct test *test);
+	struct test_case *test_cases;
+};
+
+/**
+ * struct test - represents a running instance of a test.
+ * @priv: for user to store arbitrary data. Commonly used to pass data created
+ * in the init function (see &struct test_module).
+ *
+ * Used to store information about the current context under which the test is
+ * running. Most of this data is private and should only be accessed indirectly
+ * via public functions; the one exception is @priv which can be used by the
+ * test writer to store arbitrary data.
+ */
+struct test {
+	void *priv;
+
+	/* private: internal use only. */
+	const char *name; /* Read only after initialization! */
+	spinlock_t lock; /* Gaurds all mutable test state. */
+	bool success; /* Protected by lock. */
+	void (*vprintk)(const struct test *test,
+			const char *level,
+			struct va_format *vaf);
+};
+
+int test_init_test(struct test *test, const char *name);
+
+int test_run_tests(struct test_module *module);
+
+/**
+ * module_test() - used to register a &struct test_module with KUnit.
+ * @module: a statically allocated &struct test_module.
+ *
+ * Registers @module with the test framework. See &struct test_module for more
+ * information.
+ */
+#define module_test(module) \
+		static int module_test_init##module(void) \
+		{ \
+			return test_run_tests(&module); \
+		} \
+		late_initcall(module_test_init##module)
+
+void __printf(3, 4) test_printk(const char *level,
+				const struct test *test,
+				const char *fmt, ...);
+
+/**
+ * test_info() - Prints an INFO level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * Prints an info level message associated with the test module being run. Takes
+ * a variable number of format parameters just like printk().
+ */
+#define test_info(test, fmt, ...) \
+		test_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
+
+/**
+ * test_warn() - Prints a WARN level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * See test_info().
+ */
+#define test_warn(test, fmt, ...) \
+		test_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
+
+/**
+ * test_err() - Prints an ERROR level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * See test_info().
+ */
+#define test_err(test, fmt, ...) \
+		test_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
+
+#endif /* _KUNIT_TEST_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index de16cce9d6a27..7fc613a9b383b 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_KUNIT)		+= string-stream.o
+obj-$(CONFIG_KUNIT)		+= test.o string-stream.o
diff --git a/kunit/test.c b/kunit/test.c
new file mode 100644
index 0000000000000..4732e5f0d7575
--- /dev/null
+++ b/kunit/test.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <os.h>
+#include <kunit/test.h>
+
+static bool test_get_success(struct test *test)
+{
+	unsigned long flags;
+	bool success;
+
+	spin_lock_irqsave(&test->lock, flags);
+	success = test->success;
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return success;
+}
+
+static void test_set_success(struct test *test, bool success)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	test->success = success;
+	spin_unlock_irqrestore(&test->lock, flags);
+}
+
+static int test_vprintk_emit(const struct test *test,
+			     int level,
+			     const char *fmt,
+			     va_list args)
+{
+	return vprintk_emit(0, level, NULL, 0, fmt, args);
+}
+
+static int test_printk_emit(const struct test *test,
+			    int level,
+			    const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = test_vprintk_emit(test, level, fmt, args);
+	va_end(args);
+
+	return ret;
+}
+
+static void test_vprintk(const struct test *test,
+			 const char *level,
+			 struct va_format *vaf)
+{
+	test_printk_emit(test,
+			 level[1] - '0',
+			 "kunit %s: %pV", test->name, vaf);
+}
+
+int test_init_test(struct test *test, const char *name)
+{
+	spin_lock_init(&test->lock);
+	test->name = name;
+	test->vprintk = test_vprintk;
+
+	return 0;
+}
+
+/*
+ * Initializes and runs test case. Does not clean up or do post validations.
+ */
+static void test_run_case_internal(struct test *test,
+				   struct test_module *module,
+				   struct test_case *test_case)
+{
+	int ret;
+
+	if (module->init) {
+		ret = module->init(test);
+		if (ret) {
+			test_err(test, "failed to initialize: %d", ret);
+			test_set_success(test, false);
+			return;
+		}
+	}
+
+	test_case->run_case(test);
+}
+
+/*
+ * Performs post validations and cleanup after a test case was run.
+ * XXX: Should ONLY BE CALLED AFTER test_run_case_internal!
+ */
+static void test_run_case_cleanup(struct test *test,
+				  struct test_module *module,
+				  struct test_case *test_case)
+{
+	if (module->exit)
+		module->exit(test);
+}
+
+/*
+ * Performs all logic to run a test case.
+ */
+static bool test_run_case(struct test *test,
+			  struct test_module *module,
+			  struct test_case *test_case)
+{
+	test_set_success(test, true);
+
+	test_run_case_internal(test, module, test_case);
+	test_run_case_cleanup(test, module, test_case);
+
+	return test_get_success(test);
+}
+
+int test_run_tests(struct test_module *module)
+{
+	bool all_passed = true, success;
+	struct test_case *test_case;
+	struct test test;
+	int ret;
+
+	ret = test_init_test(&test, module->name);
+	if (ret)
+		return ret;
+
+	for (test_case = module->test_cases; test_case->run_case; test_case++) {
+		success = test_run_case(&test, module, test_case);
+		if (!success)
+			all_passed = false;
+
+		test_info(&test,
+			  "%s %s",
+			  test_case->name,
+			  success ? "passed" : "failed");
+	}
+
+	if (all_passed)
+		test_info(&test, "all tests passed");
+	else
+		test_info(&test, "one or more tests failed");
+
+	return 0;
+}
+
+void test_printk(const char *level,
+		 const struct test *test,
+		 const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	test->vprintk(test, level, &vaf);
+
+	va_end(args);
+}
-- 
2.19.1.331.ge82ca0e54c-goog

