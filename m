Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D4A21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YD0djaj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503373AbfBNViu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:38:50 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55160 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503339AbfBNVir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:38:47 -0500
Received: by mail-pg1-f202.google.com with SMTP id 2so5229418pgg.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cDMRDRCAlooQqtKbNZe3mHp8Nf74M7H0TRYUBwRK+90=;
        b=YD0djaj8uAXMKZE/bLyWHMvkjXaVCHyCujJ7HIf8k2LK7+cyL+G4V8oMZMh4xD/DhF
         3CRKbYN+U+oiXoMPd5XaaoutV9cRyswnv7mGxCYUC/OIWUlR4dH8gxVTp5a1SAvcCLvW
         o/KnvwDFlrus5phWIEvUET9RGZf8o41uxxm7/6faUyymAlMj0FpGrY9/GWYo7cDcRkFf
         uufQ1ChaQXZB7kYz/XDTtaDe01p1bru2JB90sfkjNYsMmJSsA5/y87Wf+8UEwfmxZqe2
         g4b6kYkELhKsqjzq6Rkb0m6Oxk8nMFDbHDNv/jvy1rOZlrLxoLSVTXdGEAG/kWcvsg+7
         qN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cDMRDRCAlooQqtKbNZe3mHp8Nf74M7H0TRYUBwRK+90=;
        b=musg9bUk3BIMBMMjyh9eoprVataf+roAXeTI/iMaYbsb0a/y6LVKhjzHNw4t5l2+jz
         Uvhb3NmVIlhegKjPUtlxuBWAHbtz1MsI5naaKh1pNfIRaZUcJ1NOx00mlQ9rTQ0U9XaL
         bqvprtirktkt/J6537hXqWlX1l3to4cN8+0W07E1fVa+fUlZTfyPp25OIMN+bWPGlC6i
         C0AE/gzUvuUxsEpWBZsJsqmSQOaMJonL6BCRqyF/uO/kLtgil8wlghRIDGCSZKAchbWH
         aQ9sdzWhc3EeAYBBxbKb89kf2Czzk9zXAnqOisUokgrwgPfMrz7S4pQPMD9IUswhk+rL
         PO0Q==
X-Gm-Message-State: AHQUAuaFbFuqkWjo26B+xOWw2obrLvNeEvTQDYvboej1MY+3zaI84zrn
        V4ZcYxcbkP2YiLTi/2yRR4OwBxb8eUZBXl1plfvMbw==
X-Google-Smtp-Source: AHgI3IYZqykWPbNRxaAWHvyvjK7un9lYLHAch5SAzkwe/bGzSaIPXlfqdx9paWdx+9WnB7Ya/avgvlR2hoFJYdTLz/bcOw==
X-Received: by 2002:a62:f550:: with SMTP id n77mr2348156pfh.117.1550180325957;
 Thu, 14 Feb 2019 13:38:45 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:37:19 -0800
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
Message-Id: <20190214213729.21702-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [RFC v4 07/17] kunit: test: add initial tests
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

Add a test for string stream along with a simpler example.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 kunit/Kconfig              | 12 ++++++
 kunit/Makefile             |  4 ++
 kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
 kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 kunit/example-test.c
 create mode 100644 kunit/string-stream-test.c

diff --git a/kunit/Kconfig b/kunit/Kconfig
index 64480092b2c24..5cb500355c873 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
@@ -13,4 +13,16 @@ config KUNIT
 	  special hardware. For more information, please see
 	  Documentation/kunit/
 
+config KUNIT_TEST
+	bool "KUnit test for KUnit"
+	depends on KUNIT
+	help
+	  Enables KUnit test to test KUnit.
+
+config KUNIT_EXAMPLE_TEST
+	bool "Example test for KUnit"
+	depends on KUNIT
+	help
+	  Enables example KUnit test to demo features of KUnit.
+
 endmenu
diff --git a/kunit/Makefile b/kunit/Makefile
index 6ddc622ee6b1c..60a9ea6cb4697 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,3 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
 					kunit-stream.o
+
+obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/kunit/example-test.c b/kunit/example-test.c
new file mode 100644
index 0000000000000..352f64a423e7c
--- /dev/null
+++ b/kunit/example-test.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example KUnit test to show how to use KUnit.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+
+/*
+ * This is the most fundamental element of KUnit, the test case. A test case
+ * makes a set EXPECTATIONs and ASSERTIONs about the behavior of some code; if
+ * any expectations or assertions are not met, the test fails; otherwise, the
+ * test passes.
+ *
+ * In KUnit, a test case is just a function with the signature
+ * `void (*)(struct kunit *)`. `struct kunit` is a context object that stores
+ * information about the current test.
+ */
+static void example_simple_test(struct kunit *test)
+{
+	/*
+	 * This is an EXPECTATION; it is how KUnit tests things. When you want
+	 * to test a piece of code, you set some expectations about what the
+	 * code should do. KUnit then runs the test and verifies that the code's
+	 * behavior matched what was expected.
+	 */
+	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+}
+
+/*
+ * This is run once before each test case, see the comment on
+ * example_test_module for more information.
+ */
+static int example_test_init(struct kunit *test)
+{
+	kunit_info(test, "initializing");
+
+	return 0;
+}
+
+/*
+ * Here we make a list of all the test cases we want to add to the test module
+ * below.
+ */
+static struct kunit_case example_test_cases[] = {
+	/*
+	 * This is a helper to create a test case object from a test case
+	 * function; its exact function is not important to understand how to
+	 * use KUnit, just know that this is how you associate test cases with a
+	 * test module.
+	 */
+	KUNIT_CASE(example_simple_test),
+	{},
+};
+
+/*
+ * This defines a suite or grouping of tests.
+ *
+ * Test cases are defined as belonging to the suite by adding them to
+ * `kunit_cases`.
+ *
+ * Often it is desirable to run some function which will set up things which
+ * will be used by every test; this is accomplished with an `init` function
+ * which runs before each test case is invoked. Similarly, an `exit` function
+ * may be specified which runs after every test case and can be used to for
+ * cleanup. For clarity, running tests in a test module would behave as follows:
+ *
+ * module.init(test);
+ * module.test_case[0](test);
+ * module.exit(test);
+ * module.init(test);
+ * module.test_case[1](test);
+ * module.exit(test);
+ * ...;
+ */
+static struct kunit_module example_test_module = {
+	.name = "example",
+	.init = example_test_init,
+	.test_cases = example_test_cases,
+};
+
+/*
+ * This registers the above test module telling KUnit that this is a suite of
+ * tests that need to be run.
+ */
+module_test(example_test_module);
diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
new file mode 100644
index 0000000000000..6cfef69568011
--- /dev/null
+++ b/kunit/string-stream-test.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for struct string_stream.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/slab.h>
+#include <kunit/test.h>
+#include <kunit/string-stream.h>
+
+static void string_stream_test_get_string(struct kunit *test)
+{
+	struct string_stream *stream = new_string_stream();
+	char *output;
+
+	stream->add(stream, "Foo");
+	stream->add(stream, " %s", "bar");
+
+	output = stream->get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+	kfree(output);
+	destroy_string_stream(stream);
+}
+
+static void string_stream_test_add_and_clear(struct kunit *test)
+{
+	struct string_stream *stream = new_string_stream();
+	char *output;
+	int i;
+
+	for (i = 0; i < 10; i++)
+		stream->add(stream, "A");
+
+	output = stream->get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "AAAAAAAAAA");
+	KUNIT_EXPECT_EQ(test, stream->length, 10);
+	KUNIT_EXPECT_FALSE(test, stream->is_empty(stream));
+	kfree(output);
+
+	stream->clear(stream);
+
+	output = stream->get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "");
+	KUNIT_EXPECT_TRUE(test, stream->is_empty(stream));
+	destroy_string_stream(stream);
+}
+
+static struct kunit_case string_stream_test_cases[] = {
+	KUNIT_CASE(string_stream_test_get_string),
+	KUNIT_CASE(string_stream_test_add_and_clear),
+	{}
+};
+
+static struct kunit_module string_stream_test_module = {
+	.name = "string-stream-test",
+	.test_cases = string_stream_test_cases
+};
+module_test(string_stream_test_module);
+
-- 
2.21.0.rc0.258.g878e2cd30e-goog

