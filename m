Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022FAC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A375D2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6vu7l5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A375D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJQHqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:49 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34132 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeJQHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:48 -0400
Received: by mail-qt1-f202.google.com with SMTP id t27-v6so26831892qta.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SMfpYWXs7qn4Sw4Z7AL4Z3LRAaaGLbh/rhFfhnaO+uA=;
        b=S6vu7l5fvXpOUULIQIlpB+Fvika8OOQAf1IeSogBtJfdbdpFRHbnt55m/v+T0uCRws
         STUGVGDtc+JKs/ekscRGuMJGNkDmrQnEmkyhkzm3iyw2TScSRELLPkDRwPMa3vT2y/G3
         PwDlRccwpaKzbr5PJEMdQKWiLv1o9131r3IA6Bjfg/eANqoni3EYDI8NK0zrbNwpczuH
         kzl7Xh4nf9qmssCRLgk0PsIYr8gUcsCIZvdCfk3Vhzxrah7K1O1wEmRv/ZEHzClygNby
         Lzr8b4ZYQFJuSwkVEZyYQzlcDl6oYbname/2/QRw+VPMCIC5Xdxt5LxSTv5/rqMtiHnB
         UzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SMfpYWXs7qn4Sw4Z7AL4Z3LRAaaGLbh/rhFfhnaO+uA=;
        b=rEyB3JA74GfIwSnWlN6b/DKXqvlOqF8zrIfFugwPs1wr+svpjL5h1RFVIm9wePOL4l
         6RPzz07lPVtQIQTmLuXmUYfx7QG7SzhrRG7r9WSh38iAqqjdDXHpFAdBDoWQygOzuAng
         nMglEPVg0cRTvv6px/VG7GIBqLVs85rkXqrOyO9Ui+jOf2LUv1csQHUGyUx+FRZtORyW
         gQOhgxVZr++q1i+1VeGVLndyfrHEbGXXVsEmjZcfGvRo+1T7xnMU6OBo/lbzBIhnDGGi
         lkDtsByfkMCuUnk1iP/RE1gYyG3ohfld41oJvONQV1kh0c7M9ZckJHTR/MEEKOcYqzGA
         bHgg==
X-Gm-Message-State: ABuFfogwzuVYFUPbfwJRPX2sEEC7MtzCSmUabsYi3QjBI0gHVHfm8S4w
        t/UOVVkS/t1pbW+lKTdU+geeSMf55rMCQ4Ss8KzRTQ==
X-Google-Smtp-Source: ACcGV63vK8S1qFNhUgm7on4fM0NsUIifBJ57Xr+AXYTE21YTajkAaryoKydALzboq67bT/3rmKwXYuYp21Jp4nUfZoVuNQ==
X-Received: by 2002:a37:3cc2:: with SMTP id j185-v6mr316589qka.48.1539734038831;
 Tue, 16 Oct 2018 16:53:58 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:54 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 05/31] kunit: test: added the concept of expectations
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

Added support for expectations, which allow properties to be specified
and then verified in tests.

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
2.19.1.331.ge82ca0e54c-goog

