Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F4CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1F62148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wt2CLAmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1F62148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJQHqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:54 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:44130 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJQHqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:53 -0400
Received: by mail-it1-f202.google.com with SMTP id k69-v6so235612ite.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uw9R47stJ0hTnKGMpz+45emoI+mx7jNptXF9kuz1348=;
        b=Wt2CLAmZ01nzug3igoC7QMWBTWiNCk2KyQeIforWF4nlybC7ZEhAAyYRVdH1zxAtzd
         pkOhW6g8H71Qvjbo+4UDKVWHR25ZLcCGnFZJlvKN2nXEE1zPb7NLvTY1IDQuohmg2Fxq
         wM3p2EuCN/DKI+SvMDHbH5K8RZtXeJWOQ9/MkvXW3qxPyjQGRjIpq91SNprEskd7YUnG
         MazK/PM7sdXZ1Y1eGs6Cf8sh7PODTkKGVurljr+88cCTY2JnkTNpnmCKZzSiRghYa4gw
         5xBGJDMA7i2TQpHLnBIHS5pZz4COlFB+wDLnDM3KxhKGj89TVgGvSYScAe2JrawpCkhB
         hmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uw9R47stJ0hTnKGMpz+45emoI+mx7jNptXF9kuz1348=;
        b=EJZmS0FkfriHXce2YU4YE+TdJ2s234fwxkP9LzGbPPrOSwXM10BMMJh/xquA3uM9nx
         JskNAfIDyD6rti2NUpBgYsEPyj0pd/Dq2lpIHNspm8p5Xk7XPVgLbjwBoD5qQujYybLJ
         F3Ue7C+t6fnM2xzMjd1Yiljm0t0DQv3T9xyJ4TUxaQoQmSxSthdGAD3ujf8bAX4wd5ri
         xRMjSlyOrevCpymskImUrJFV/9ShrfcxDROFcXE0CBN1LuJp7iVVR6EZIfqzegRCX0nE
         YyyLrYHzISYPYPWk4+p3Hrtqnn84esALLazN4G1dlGh4WE0ygZChEcItswrNnzCP6hcL
         uTWw==
X-Gm-Message-State: ABuFfohEr4e4Vfs9MKInVaotQGSjSxDBpyrLxwvfGec009SqPO4YXzRL
        mB7ZkIPoTmLykiDDCDw6Bjjfg+wj9iZ0nA5HZvqYJw==
X-Google-Smtp-Source: ACcGV61KdtPmTfcO7rEaKongwQUAt/iV2T/cpr8Eoi6ca+lQX2dvI0CMHPDnpwwbfq9++5sRsoyW2MyoUagwnWdjIHuwYA==
X-Received: by 2002:a24:8082:: with SMTP id g124-v6mr223410itd.12.1539734043663;
 Tue, 16 Oct 2018 16:54:03 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:56 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 07/31] kunit: test: added initial tests
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

Added a test for string stream along with a more simple example.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 kunit/Kconfig              | 12 ++++++
 kunit/Makefile             |  2 +
 kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
 kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)
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
index 5b4562ea7f322..319eb9dc8be0e 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1,3 @@
 obj-$(CONFIG_KUNIT)		+= test.o string-stream.o test-stream.o
+obj-$(CONFIG_KUNIT_TEST)		+= string-stream-test.o
+obj-$(CONFIG_EXAMPLE_TEST)	+= example-test.o
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
2.19.1.331.ge82ca0e54c-goog

