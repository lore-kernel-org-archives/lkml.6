Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0CFC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C905820651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNmzlSPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C905820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeJXLO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:14:57 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:50932 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXLO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:14:57 -0400
Received: by mail-ua1-f73.google.com with SMTP id p4so936431uam.17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q13duKIyYV+s4a1e8KYz3mhnW90ooz5WLIig/Ym6Guo=;
        b=GNmzlSPiR5RiQuJVWlL8BF8X+JVEeJ0FcP9c/PgljM6K8EcLal1FRuXsKjYAYLz+0N
         EYfke56T2jMykzcxUTY37f6h1bcms0QAIjrBcLIA7mgVW7STtp9WFJxQpwgwDt8la3KY
         zBqhBGj9PHOpwEyTxrPHicjEm18G+0O5IY6b0DHKSViZiJQ1/TbLMn2p0znE3YhqwvDC
         dj+rG5sT4JPABhGm+pkEmSlHbLzmYIiMBqGhlID8MdH0n5N+62Y5bSk01+316q0rxL7l
         1fZw7cRnn6tdBAm+qBt0M4yDWgddBaRowscM9HznrEQISHfGvzPh9O0aWQEkhUGUBALX
         bf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q13duKIyYV+s4a1e8KYz3mhnW90ooz5WLIig/Ym6Guo=;
        b=jxk/wcxRxHK4ZRKqhVVhZICqFOB8NQPiT7cGRprmBkuvcwCZKGThZW8+HgQ50EQsrs
         RQym0WDIwdbN0J/At1YtZ70Xs9k2GMEYGyuHd3Bw4j6uhS50dvtABKGT0QXBd98Z/01T
         U0690Q+P2fKA7AuLNjhg3byRmBM5YVcYOY4a8NEl/3y+p4GUn8lYJVBt/+PDFgKWuTjM
         OJGIpCWgczBS+BLEXWUNfh8JF/PLxCSnKDUa8MEK98HUIgrtefrFWlHDiB7tHP8q5SBE
         1BjSeQv0lMDg/tfe9OAiwboR1z46OHWjvoaBYCZ27sBR77MFw4hQH0jGKM+XLHcj+dD8
         EnXg==
X-Gm-Message-State: AGRZ1gJ3qLg6PhHZ8M/h33eSXJLO1wYn+VtZa2Zg9oFuVv2QQYXeqzgr
        h2qg665bRaKoKgiWnfyGCAJW/m2FaU/8bSYH+bdGdw==
X-Google-Smtp-Source: AJdET5d2mWTycEJUEvDMAXC6cK2fUJolxQD8HMYvbjOTcbsKfePkHR8uVX27Q192X9sQVkUl+X2IUVYRdQkkAxGPPNhgOQ==
X-Received: by 2002:ab0:3159:: with SMTP id e25mr395346uam.16.1540339195414;
 Tue, 23 Oct 2018 16:59:55 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:43 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 07/14] kunit: test: add initial tests
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

Add a test for string stream along with a simpler example.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 kunit/Kconfig              | 12 ++++++
 kunit/Makefile             |  4 +-
 kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
 kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 kunit/example-test.c
 create mode 100644 kunit/string-stream-test.c

diff --git a/kunit/Kconfig b/kunit/Kconfig
index 49b44c4f6630a..c3dc7bca83f9d 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
@@ -14,4 +14,16 @@ config KUNIT
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
index 5b4562ea7f322..b437bd546ab70 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1,3 @@
-obj-$(CONFIG_KUNIT)		+= test.o string-stream.o test-stream.o
+obj-$(CONFIG_KUNIT)			+= test.o string-stream.o test-stream.o
+obj-$(CONFIG_KUNIT_TEST)		+= string-stream-test.o
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST)	+= example-test.o
diff --git a/kunit/example-test.c b/kunit/example-test.c
new file mode 100644
index 0000000000000..e9bd2b41c5fd2
--- /dev/null
+++ b/kunit/example-test.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example KUnit test to show how to use KUnit.
+ *
+ * Copyright (C) 2018, Google LLC.
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
+ * `void (*)(struct test *)`. `struct test` is a context object that stores
+ * information about the current test.
+ */
+static void example_simple_test(struct test *test)
+{
+	/*
+	 * This is an EXPECTATION; it is how KUnit tests things. When you want
+	 * to test a piece of code, you set some expectations about what the
+	 * code should do. KUnit then runs the test and verifies that the code's
+	 * behavior matched what was expected.
+	 */
+	TEST_EXPECT_EQ(test, 1 + 1, 2);
+}
+
+/*
+ * This is run once before each test case, see the comment on
+ * example_test_module for more information.
+ */
+static int example_test_init(struct test *test)
+{
+	test_info(test, "initializing");
+
+	return 0;
+}
+
+/*
+ * Here we make a list of all the test cases we want to add to the test module
+ * below.
+ */
+static struct test_case example_test_cases[] = {
+	/*
+	 * This is a helper to create a test case object from a test case
+	 * function; its exact function is not important to understand how to
+	 * use KUnit, just know that this is how you associate test cases with a
+	 * test module.
+	 */
+	TEST_CASE(example_simple_test),
+	{},
+};
+
+/*
+ * This defines a suite or grouping of tests.
+ *
+ * Test cases are defined as belonging to the suite by adding them to
+ * `test_cases`.
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
+static struct test_module example_test_module = {
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
index 0000000000000..07c626cbfffbf
--- /dev/null
+++ b/kunit/string-stream-test.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for struct string_stream.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/slab.h>
+#include <kunit/test.h>
+#include <kunit/string-stream.h>
+
+static void string_stream_test_get_string(struct test *test)
+{
+	struct string_stream *stream = new_string_stream();
+	char *output;
+
+	stream->add(stream, "Foo");
+	stream->add(stream, " %s", "bar");
+
+	output = stream->get_string(stream);
+	TEST_EXPECT_STREQ(test, output, "Foo bar");
+	kfree(output);
+	destroy_string_stream(stream);
+}
+
+static void string_stream_test_add_and_clear(struct test *test)
+{
+	struct string_stream *stream = new_string_stream();
+	char *output;
+	int i;
+
+	for (i = 0; i < 10; i++)
+		stream->add(stream, "A");
+
+	output = stream->get_string(stream);
+	TEST_EXPECT_STREQ(test, output, "AAAAAAAAAA");
+	TEST_EXPECT_EQ(test, stream->length, 10);
+	TEST_EXPECT_FALSE(test, stream->is_empty(stream));
+	kfree(output);
+
+	stream->clear(stream);
+
+	output = stream->get_string(stream);
+	TEST_EXPECT_STREQ(test, output, "");
+	TEST_EXPECT_TRUE(test, stream->is_empty(stream));
+	destroy_string_stream(stream);
+}
+
+static struct test_case string_stream_test_cases[] = {
+	TEST_CASE(string_stream_test_get_string),
+	TEST_CASE(string_stream_test_add_and_clear),
+	{}
+};
+
+static struct test_module string_stream_test_module = {
+	.name = "string-stream-test",
+	.test_cases = string_stream_test_cases
+};
+module_test(string_stream_test_module);
+
-- 
2.19.1.568.g152ad8e336-goog

