Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D5EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DFC2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgeDg8zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405904AbfBNVid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:38:33 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49163 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392660AbfBNVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:38:29 -0500
Received: by mail-pf1-f201.google.com with SMTP id y66so5816461pfg.16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SoRE8+uYlb20xlX661s+vuA7DD7As2RVdTcIlioYiq8=;
        b=rgeDg8zsoW5bbKgyPerCGY+hb3Hw/7MfO37JyT/Z3P5n9oEfPf6Xhp3pTSm2R5DF8/
         0jLEn1oIz7pVEOHPtRdRsZexmyBIwhtktaQScQ2sPAA1nXGSLt3/wXjzeJyI445PVGZW
         /e78RjS5NAkgwxRMhhIrFEMWjxSlTDbB8/ZJEk1HN1d9RxTuH1lJHD9vPvDU+l7ZSzJo
         PgP+YtiFv4y46xb1zO5NQpjNnfTB/dp46YP24QEdq/kFzDRaOhG6P1ztFuW7Nc2rnbTL
         ixDeLcJ3Dw2mWfTBAKzAg8VZ+U9lQMOyZPWv5KcU1xYlLRqz1Wzf996QIau92i8bpxyE
         rLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SoRE8+uYlb20xlX661s+vuA7DD7As2RVdTcIlioYiq8=;
        b=mwsz4bnQQTopilHAkKmapyu7wZe5OSP9IMxB+9LTDCAHVxe5cVDL8xXl4PMDq7EDkr
         w0viLSvJa+jq9IV+7FtoG9Fkw+oBseN6/gF1jtA7gxXMWqT6gOUtgZeFXAYXbPDc7C7i
         zuZJKVf8GR+6MfH9MyMVQ18e39k8k5sYlLGb2olutJDIJh98gUhXa42w5kb6euqofEYe
         kp0zNpjieGBrI4KeFK9YGjACoZh8K9TZYXdr0KorBJGSdDjMkJvnYqd0n9OmS9k4ec5j
         qnrwcXj7sodaA05Xtspaa0/iWRcCKs2Y1RLdYYJYQ6et03Ke1SvhRBMEFIX7aehnPbRE
         e0UQ==
X-Gm-Message-State: AHQUAubiVVSIXqbM5OkxZhmNznpQ+vd/mC9xnXFNSandP7wKm1sxdYSd
        EFUozhktV1rsbHNF87iZ3LZLUxbjiUdSeszhGwVh2w==
X-Google-Smtp-Source: AHgI3IYSs+euiTVdtb/Mp7wRiQZbwvIYIP86+kJ1rymlHJOgBolXQmUc+LHgsgTk2Nd+5WnZHVOTjfM73jYEgtGChRqTYw==
X-Received: by 2002:a63:6b84:: with SMTP id g126mr2379919pgc.19.1550180308941;
 Thu, 14 Feb 2019 13:38:28 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:37:13 -0800
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
Message-Id: <20190214213729.21702-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [RFC v4 01/17] kunit: test: add KUnit test runner core
From:   Brendan Higgins <brendanhiggins@google.com>
To:     keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        robh@kernel.org, kieran.bingham@ideasonboard.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, knut.omang@oracle.com,
        devicetree@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add core facilities for defining unit tests; this provides a common way
to define test cases, functions that execute code which is under test
and determine whether the code under test behaves as expected; this also
provides a way to group together related test cases in test suites (here
we call them test_modules).

Just define test cases and how to execute them for now; setting
expectations on code will be defined later.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 165 ++++++++++++++++++++++++++++++++++++++++++
 kunit/Kconfig        |  16 +++++
 kunit/Makefile       |   1 +
 kunit/test.c         | 168 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 350 insertions(+)
 create mode 100644 include/kunit/test.h
 create mode 100644 kunit/Kconfig
 create mode 100644 kunit/Makefile
 create mode 100644 kunit/test.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
new file mode 100644
index 0000000000000..23c2ebedd6dd9
--- /dev/null
+++ b/include/kunit/test.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TEST_H
+#define _KUNIT_TEST_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+
+struct kunit;
+
+/**
+ * struct kunit_case - represents an individual test case.
+ * @run_case: the function representing the actual test case.
+ * @name: the name of the test case.
+ *
+ * A test case is a function with the signature, ``void (*)(struct kunit *)``
+ * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
+ * test case is associated with a &struct kunit_module and will be run after the
+ * module's init function and followed by the module's exit function.
+ *
+ * A test case should be static and should only be created with the KUNIT_CASE()
+ * macro; additionally, every array of test cases should be terminated with an
+ * empty test case.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	void add_test_basic(struct kunit *test)
+ *	{
+ *		KUNIT_EXPECT_EQ(test, 1, add(1, 0));
+ *		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
+ *		KUNIT_EXPECT_EQ(test, 0, add(-1, 1));
+ *		KUNIT_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
+ *		KUNIT_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
+ *	}
+ *
+ *	static struct kunit_case example_test_cases[] = {
+ *		KUNIT_CASE(add_test_basic),
+ *		{},
+ *	};
+ *
+ */
+struct kunit_case {
+	void (*run_case)(struct kunit *test);
+	const char name[256];
+
+	/* private: internal use only. */
+	bool success;
+};
+
+/**
+ * KUNIT_CASE - A helper for creating a &struct kunit_case
+ * @test_name: a reference to a test case function.
+ *
+ * Takes a symbol for a function representing a test case and creates a
+ * &struct kunit_case object from it. See the documentation for
+ * &struct kunit_case for an example on how to use it.
+ */
+#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+
+/**
+ * struct kunit_module - describes a related collection of &struct kunit_case s.
+ * @name: the name of the test. Purely informational.
+ * @init: called before every test case.
+ * @exit: called after every test case.
+ * @test_cases: a null terminated array of test cases.
+ *
+ * A kunit_module is a collection of related &struct kunit_case s, such that
+ * @init is called before every test case and @exit is called after every test
+ * case, similar to the notion of a *test fixture* or a *test class* in other
+ * unit testing frameworks like JUnit or Googletest.
+ *
+ * Every &struct kunit_case must be associated with a kunit_module for KUnit to
+ * run it.
+ */
+struct kunit_module {
+	const char name[256];
+	int (*init)(struct kunit *test);
+	void (*exit)(struct kunit *test);
+	struct kunit_case *test_cases;
+};
+
+/**
+ * struct kunit - represents a running instance of a test.
+ * @priv: for user to store arbitrary data. Commonly used to pass data created
+ * in the init function (see &struct kunit_module).
+ *
+ * Used to store information about the current context under which the test is
+ * running. Most of this data is private and should only be accessed indirectly
+ * via public functions; the one exception is @priv which can be used by the
+ * test writer to store arbitrary data.
+ */
+struct kunit {
+	void *priv;
+
+	/* private: internal use only. */
+	const char *name; /* Read only after initialization! */
+	spinlock_t lock; /* Gaurds all mutable test state. */
+	bool success; /* Protected by lock. */
+	void (*vprintk)(const struct kunit *test,
+			const char *level,
+			struct va_format *vaf);
+};
+
+int kunit_init_test(struct kunit *test, const char *name);
+
+int kunit_run_tests(struct kunit_module *module);
+
+/**
+ * module_test() - used to register a &struct kunit_module with KUnit.
+ * @module: a statically allocated &struct kunit_module.
+ *
+ * Registers @module with the test framework. See &struct kunit_module for more
+ * information.
+ */
+#define module_test(module) \
+		static int module_kunit_init##module(void) \
+		{ \
+			return kunit_run_tests(&module); \
+		} \
+		late_initcall(module_kunit_init##module)
+
+void __printf(3, 4) kunit_printk(const char *level,
+				 const struct kunit *test,
+				 const char *fmt, ...);
+
+/**
+ * kunit_info() - Prints an INFO level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * Prints an info level message associated with the test module being run. Takes
+ * a variable number of format parameters just like printk().
+ */
+#define kunit_info(test, fmt, ...) \
+		kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
+
+/**
+ * kunit_warn() - Prints a WARN level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * See kunit_info().
+ */
+#define kunit_warn(test, fmt, ...) \
+		kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
+
+/**
+ * kunit_err() - Prints an ERROR level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * See kunit_info().
+ */
+#define kunit_err(test, fmt, ...) \
+		kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
+
+#endif /* _KUNIT_TEST_H */
diff --git a/kunit/Kconfig b/kunit/Kconfig
new file mode 100644
index 0000000000000..64480092b2c24
--- /dev/null
+++ b/kunit/Kconfig
@@ -0,0 +1,16 @@
+#
+# KUnit base configuration
+#
+
+menu "KUnit support"
+
+config KUNIT
+	bool "Enable support for unit tests (KUnit)"
+	help
+	  Enables support for kernel unit tests (KUnit), a lightweight unit
+	  testing and mocking framework for the Linux kernel. These tests are
+	  able to be run locally on a developer's workstation without a VM or
+	  special hardware. For more information, please see
+	  Documentation/kunit/
+
+endmenu
diff --git a/kunit/Makefile b/kunit/Makefile
new file mode 100644
index 0000000000000..5efdc4dea2c08
--- /dev/null
+++ b/kunit/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_KUNIT) +=			test.o
diff --git a/kunit/test.c b/kunit/test.c
new file mode 100644
index 0000000000000..0b4396f92086e
--- /dev/null
+++ b/kunit/test.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <os.h>
+#include <kunit/test.h>
+
+static bool kunit_get_success(struct kunit *test)
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
+static void kunit_set_success(struct kunit *test, bool success)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	test->success = success;
+	spin_unlock_irqrestore(&test->lock, flags);
+}
+
+static int kunit_vprintk_emit(const struct kunit *test,
+			      int level,
+			      const char *fmt,
+			      va_list args)
+{
+	return vprintk_emit(0, level, NULL, 0, fmt, args);
+}
+
+static int kunit_printk_emit(const struct kunit *test,
+			     int level,
+			     const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = kunit_vprintk_emit(test, level, fmt, args);
+	va_end(args);
+
+	return ret;
+}
+
+static void kunit_vprintk(const struct kunit *test,
+			  const char *level,
+			  struct va_format *vaf)
+{
+	kunit_printk_emit(test,
+			  level[1] - '0',
+			  "kunit %s: %pV", test->name, vaf);
+}
+
+int kunit_init_test(struct kunit *test, const char *name)
+{
+	spin_lock_init(&test->lock);
+	test->name = name;
+	test->vprintk = kunit_vprintk;
+
+	return 0;
+}
+
+/*
+ * Initializes and runs test case. Does not clean up or do post validations.
+ */
+static void kunit_run_case_internal(struct kunit *test,
+				    struct kunit_module *module,
+				    struct kunit_case *test_case)
+{
+	int ret;
+
+	if (module->init) {
+		ret = module->init(test);
+		if (ret) {
+			kunit_err(test, "failed to initialize: %d", ret);
+			kunit_set_success(test, false);
+			return;
+		}
+	}
+
+	test_case->run_case(test);
+}
+
+/*
+ * Performs post validations and cleanup after a test case was run.
+ * XXX: Should ONLY BE CALLED AFTER kunit_run_case_internal!
+ */
+static void kunit_run_case_cleanup(struct kunit *test,
+				   struct kunit_module *module,
+				   struct kunit_case *test_case)
+{
+	if (module->exit)
+		module->exit(test);
+}
+
+/*
+ * Performs all logic to run a test case.
+ */
+static bool kunit_run_case(struct kunit *test,
+			   struct kunit_module *module,
+			   struct kunit_case *test_case)
+{
+	kunit_set_success(test, true);
+
+	kunit_run_case_internal(test, module, test_case);
+	kunit_run_case_cleanup(test, module, test_case);
+
+	return kunit_get_success(test);
+}
+
+int kunit_run_tests(struct kunit_module *module)
+{
+	bool all_passed = true, success;
+	struct kunit_case *test_case;
+	struct kunit test;
+	int ret;
+
+	ret = kunit_init_test(&test, module->name);
+	if (ret)
+		return ret;
+
+	for (test_case = module->test_cases; test_case->run_case; test_case++) {
+		success = kunit_run_case(&test, module, test_case);
+		if (!success)
+			all_passed = false;
+
+		kunit_info(&test,
+			  "%s %s",
+			  test_case->name,
+			  success ? "passed" : "failed");
+	}
+
+	if (all_passed)
+		kunit_info(&test, "all tests passed");
+	else
+		kunit_info(&test, "one or more tests failed");
+
+	return 0;
+}
+
+void kunit_printk(const char *level,
+		  const struct kunit *test,
+		  const char *fmt, ...)
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
2.21.0.rc0.258.g878e2cd30e-goog

