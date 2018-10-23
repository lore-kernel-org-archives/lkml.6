Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FDC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9386920832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mD+BbG5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9386920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJXLW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:22:29 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42730 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeJXLW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:22:29 -0400
Received: by mail-qt1-f201.google.com with SMTP id j17-v6so4232823qtp.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 19:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hggIhHZOBoGnIe1JWpZaHOxuaagkXsAnGysTwFMbwVw=;
        b=mD+BbG5EfoOJuafg+Wbpsj2AjwfGY80yTXPV3X/SY4BIgO09xri/6J92ndmVQ+Nv6Q
         nwFNptmGkLnib0JrkiO3/fccU0jznaQicVa9spsa2lhvihnFdeEjqR0tTEJNEvbqGZta
         /gsdFvB4d+UM6Ix+yXhZuBwxMRgmuFNJn09w46IGg1DHwrUkvudnK0IdzldzPsjh7xxu
         aDY3zU6vg581S9usnK9GsBv8vBqPjYwgT9h/S6GaWCc2Rki2b+N4NfhcP+Ld03Ceg5NA
         0L+f1+TilgklLIIXSkIsqxFpNXXc6ktPLLrCSeQ6YUNePY6NWC8lU+MdJ7ln7Ibf9/jE
         s5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hggIhHZOBoGnIe1JWpZaHOxuaagkXsAnGysTwFMbwVw=;
        b=mUM79j7mw4r9RBhZyDdIho28l6iHy6DCvNWNHVvZlODnFMhlhV1WDj591ea2ioHpDo
         YdSzL+Kg3MMPCYbKNYQc3tKcptBUlnNfAdvLqbRnUBdjaT46Z+MxMEseUmyvSwGqG1l8
         8I4sKI/IMUa1qi/yN9cjiiX3XYJVBdkNoBf9Sf9Z5ng5+CoL9f+Og0pctPn2rm5jRz9S
         i+bYbugchfe957LMK/He/xNgC950z+/TqdKSSKQgn8oykys0ubP/A3KY6lsWL7iKo5pB
         wYDTG7/8PXeCkU7OzE4NRFEyNW8yTvoQn+edB3ENBsXxghONHSliLfTvflat3XUiH11j
         W/Jg==
X-Gm-Message-State: AGRZ1gKjKtlxE+UypV1hjUfwAlPmQz4aCK/ZMh5E4EQ5klw3gPeUBTnf
        qJH5IAN9cw/qFfM5Dx5Dwatatd5mT30YHvdGJ7WTYg==
X-Google-Smtp-Source: AJdET5eVZWWV4JsUBsRwaDh0ZdGjZSBYlAMnYpXD6vjkS3s7Y/R/PlfeklK7czGdfOUuGOYXYltntH7whLiVf+i4v/NA1w==
X-Received: by 2002:ac8:1870:: with SMTP id n45-v6mr314473qtk.46.1540339190237;
 Tue, 23 Oct 2018 16:59:50 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:41 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 05/14] kunit: test: add the concept of expectations
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

Add support for expectations, which allow properties to be specified and
then verified in tests.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 259 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 259 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 68320fa2452de..d652825d7296f 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -273,4 +273,263 @@ void __printf(3, 4) test_printk(const char *level,
 #define test_err(test, fmt, ...) \
 		test_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+static inline struct test_stream *test_expect_start(struct test *test,
+						    const char *file,
+						    const char *line)
+{
+	struct test_stream *stream = test_new_stream(test);
+
+	stream->add(stream, "EXPECTATION FAILED at %s:%s\n\t", file, line);
+
+	return stream;
+}
+
+static inline void test_expect_end(struct test *test,
+				   bool success,
+				   struct test_stream *stream)
+{
+	if (!success)
+		test->fail(test, stream);
+	else
+		stream->clear(stream);
+}
+
+#define TEST_EXPECT_START(test) \
+		test_expect_start(test, __FILE__, __stringify(__LINE__))
+
+#define TEST_EXPECT_END(test, success, stream) \
+		test_expect_end(test, success, stream)
+
+#define TEST_EXPECT(test, success, message) do {			       \
+	struct test_stream *__stream = TEST_EXPECT_START(test);		       \
+									       \
+	__stream->add(__stream, message);				       \
+	TEST_EXPECT_END(test, success, __stream);			       \
+} while (0)
+
+/**
+ * TEST_SUCCEED() - A no-op expectation. Only exists for code clarity.
+ * @test: The test context object.
+ *
+ * The opposite of TEST_FAIL(), it is an expectation that cannot fail. In other
+ * words, it does nothing and only exists for code clarity. See
+ * TEST_EXPECT_TRUE() for more information.
+ */
+#define TEST_SUCCEED(test) do {} while (0)
+
+/**
+ * TEST_FAIL() - Always causes a test to fail when evaluated.
+ * @test: The test context object.
+ * @message: an informational message to be printed when the assertion is made.
+ *
+ * The opposite of TEST_SUCCEED(), it is an expectation that always fails. In
+ * other words, it always results in a failed expectation, and consequently
+ * always causes the test case to fail when evaluated. See TEST_EXPECT_TRUE()
+ * for more information.
+ */
+#define TEST_FAIL(test, message) TEST_EXPECT(test, false, message)
+
+/**
+ * TEST_EXPECT_TRUE() - Causes a test failure when the expression is not true.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to true.
+ *
+ * This and expectations of the form `TEST_EXPECT_*` will cause the test case to
+ * fail when the specified condition is not met; however, it will not prevent
+ * the test case from continuing to run; this is otherwise known as an
+ * *expectation failure*.
+ */
+#define TEST_EXPECT_TRUE(test, condition)				       \
+		TEST_EXPECT(test, (condition),				       \
+		       "Expected " #condition " is true, but is false.")
+
+/**
+ * TEST_EXPECT_FALSE() - Causes a test failure when the expression is not false.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to false.
+ *
+ * Sets an expectation that @condition evaluates to false. See
+ * TEST_EXPECT_TRUE() for more information.
+ */
+#define TEST_EXPECT_FALSE(test, condition)				       \
+		TEST_EXPECT(test, !(condition),				       \
+		       "Expected " #condition " is false, but is true.")
+
+static inline void test_expect_binary(struct test *test,
+				      long long left, const char *left_name,
+				      long long right, const char *right_name,
+				      bool compare_result,
+				      const char *compare_name,
+				      const char *file,
+				      const char *line)
+{
+	struct test_stream *stream = test_expect_start(test, file, line);
+
+	stream->add(stream,
+		    "Expected %s %s %s, but\n",
+		    left_name, compare_name, right_name);
+	stream->add(stream, "\t\t%s == %lld\n", left_name, left);
+	stream->add(stream, "\t\t%s == %lld", right_name, right);
+
+	test_expect_end(test, compare_result, stream);
+}
+
+/*
+ * A factory macro for defining the expectations for the basic comparisons
+ * defined for the built in types.
+ *
+ * Unfortunately, there is no common type that all types can be promoted to for
+ * which all the binary operators behave the same way as for the actual types
+ * (for example, there is no type that long long and unsigned long long can
+ * both be cast to where the comparison result is preserved for all values). So
+ * the best we can do is do the comparison in the original types and then coerce
+ * everything to long long for printing; this way, the comparison behaves
+ * correctly and the printed out value usually makes sense without
+ * interpretation, but can always be interpretted to figure out the actual
+ * value.
+ */
+#define TEST_EXPECT_BINARY(test, left, condition, right) do {		       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	test_expect_binary(test,					       \
+			   (long long) __left, #left,			       \
+			   (long long) __right, #right,			       \
+			   __left condition __right, #condition,	       \
+			   __FILE__, __stringify(__LINE__));		       \
+} while (0)
+
+/**
+ * TEST_EXPECT_EQ() - Sets an expectation that @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * TEST_EXPECT_TRUE(@test, (@left) == (@right)). See TEST_EXPECT_TRUE() for more
+ * information.
+ */
+#define TEST_EXPECT_EQ(test, left, right) \
+		TEST_EXPECT_BINARY(test, left, ==, right)
+
+/**
+ * TEST_EXPECT_NE() - An expectation that @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * TEST_EXPECT_TRUE(@test, (@left) != (@right)). See TEST_EXPECT_TRUE() for more
+ * information.
+ */
+#define TEST_EXPECT_NE(test, left, right) \
+		TEST_EXPECT_BINARY(test, left, !=, right)
+
+/**
+ * TEST_EXPECT_LT() - An expectation that @left is less than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than the
+ * value that @right evaluates to. This is semantically equivalent to
+ * TEST_EXPECT_TRUE(@test, (@left) < (@right)). See TEST_EXPECT_TRUE() for more
+ * information.
+ */
+#define TEST_EXPECT_LT(test, left, right) \
+		TEST_EXPECT_BINARY(test, left, <, right)
+
+/**
+ * TEST_EXPECT_LE() - An expectation that @left is less than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than or
+ * equal to the value that @right evaluates to. Semantically this is equivalent
+ * to TEST_EXPECT_TRUE(@test, (@left) <= (@right)). See TEST_EXPECT_TRUE() for
+ * more information.
+ */
+#define TEST_EXPECT_LE(test, left, right) \
+		TEST_EXPECT_BINARY(test, left, <=, right)
+
+/**
+ * TEST_EXPECT_GT() - An expectation that @left is greater than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * TEST_EXPECT_TRUE(@test, (@left) > (@right)). See TEST_EXPECT_TRUE() for more
+ * information.
+ */
+#define TEST_EXPECT_GT(test, left, right) \
+		TEST_EXPECT_BINARY(test, left, >, right)
+
+/**
+ * TEST_EXPECT_GE() - Expects that @left is greater than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * TEST_EXPECT_TRUE(@test, (@left) >= (@right)). See TEST_EXPECT_TRUE() for more
+ * information.
+ */
+#define TEST_EXPECT_GE(test, left, right) \
+		TEST_EXPECT_BINARY(test, left, >=, right)
+
+/**
+ * TEST_EXPECT_STREQ() - An expectation that strings @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * TEST_EXPECT_TRUE(@test, !strcmp((@left), (@right))). See TEST_EXPECT_TRUE()
+ * for more information.
+ */
+#define TEST_EXPECT_STREQ(test, left, right) do {			       \
+	struct test_stream *__stream = TEST_EXPECT_START(test);		       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	__stream->add(__stream, "Expected " #left " == " #right ", but\n");    \
+	__stream->add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	__stream->add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+									       \
+	TEST_EXPECT_END(test, !strcmp(left, right), __stream);		       \
+} while (0)
+
+/**
+ * TEST_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is not null and not
+ * an errno stored in a pointer. This is semantically equivalent to
+ * TEST_EXPECT_TRUE(@test, !IS_ERR_OR_NULL(@ptr)). See TEST_EXPECT_TRUE() for
+ * more information.
+ */
+#define TEST_EXPECT_NOT_ERR_OR_NULL(test, ptr) do {			       \
+	struct test_stream *__stream = TEST_EXPECT_START(test);		       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	if (!__ptr)							       \
+		__stream->add(__stream,					       \
+			      "Expected " #ptr " is not null, but is.");       \
+	if (IS_ERR(__ptr))						       \
+		__stream->add(__stream,					       \
+			      "Expected " #ptr " is not error, but is: %ld",   \
+			      PTR_ERR(__ptr));				       \
+									       \
+	TEST_EXPECT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
+} while (0)
+
 #endif /* _KUNIT_TEST_H */
-- 
2.19.1.568.g152ad8e336-goog

