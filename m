Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA2C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B586C2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jObYhDzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B586C2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJQHrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:33 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:48010 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeJQHrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:32 -0400
Received: by mail-io1-f74.google.com with SMTP id c21-v6so23253260ioi.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FPIYCn6EOx1XsTWZ4p6VpTMVblaLhIfS9g7PdcTELME=;
        b=jObYhDzdAodeqbMaupPyJOZrepJm1v4ub0X324PwVojcSD6LzyRBYEJlGkf5WJ/4iO
         xFCcn4TF+vvga75ygcFE5OqkwSSNioPrAG5NtFTrZpiOcyiNYFFwjREjywoR6FdAnR6o
         mvym6+WDHPTe2YlVpA4vkRw1McojScwQZB/0y11Ox51mDiFrxxPrMNXDI6/7O2i0MJbs
         NyzyQUUgpacKymiZ+cJRCrU4qhwH+yr4D9/IhS5eaPOcgCAp7ts/9oaCvgk4NTW/Cqn9
         QXAEmzv9NWz/ypXUomOiaLdlMowNBH7nzRHi+j5kKS4EimsM22xRppfl76ZVeacwtf5P
         i3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FPIYCn6EOx1XsTWZ4p6VpTMVblaLhIfS9g7PdcTELME=;
        b=aWsQYWsdUvcCKEU8byUHHjbzCir+4BM1pHQmvx1WZwvKeLf3bgNZ9mReCJ96eR7YZW
         TWP/qtQkHNJ/7SfXd9H17QbLoEe54x+pUvngcahRjBS3ydYCk6xMUwrdIdozZ4ZvAE0H
         JtCc01RDFeWQSOnVvBeYZWpN+gXGHOu6szQ9TpXplL4tokMW+/J730pnx10C9CulAjXw
         8EcSBsMKNyUm0fVNDjObJ8YeBguXKB4l4fuHHT1NO3r+BDekIoDY5Oj7yVCZJdP1s2Ky
         sQO5SVglx9AAvEJMFD4xJMu8d04HcTx2L7XmvkxzHH6VnltRlRkPV874JS2+GDGmnvdG
         8Q/g==
X-Gm-Message-State: ABuFfoh22RYYskgzS6Jz6bShR1rPdEd5fApVC+2QDnOi2+uty4hbFzIy
        fnqhJv0WJOb2seG79JsN45dInsolvIoresLpq+DZGw==
X-Google-Smtp-Source: ACcGV62ehVJ8AHeD9ZnEiqipPbKj1hD4xI+nJJKTsv8DRZBI3hKxGL6otUBF/c4WZRoECtmpAv/O5TQ2IAmPVzpPgWWMTg==
X-Received: by 2002:a24:8903:: with SMTP id s3-v6mr211702itd.26.1539734082598;
 Tue, 16 Oct 2018 16:54:42 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:12 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-24-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 23/31] kunit: mock: add parameter capturers
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

Adds the concept of an argument capturer which, when used with a matcher
in an EXPECT_CALL(...), will capture the value of the matching argument.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/mock.h | 83 ++++++++++++++++++++++++++++++++++++++++++++
 kunit/common-mocks.c | 78 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index c3615e80d96ee..0e1aa568709a1 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -1172,6 +1172,89 @@ struct mock_param_matcher *test_struct_cmp(
 		const char *struct_name,
 		struct mock_struct_matcher_entry *entries);
 
+/**
+ * struct mock_param_capturer - used to capture parameter when matching
+ *
+ * Use the associated helper macros to access relevant fields.
+ * Example:
+ *
+ * .. code-block::c
+ *
+ *	static int some_test(struct test *test)
+ *	{
+ *		// imagine a mocked function: int add(int a, int b)
+ *		struct mock_param_capturer *capturer =
+ *			mock_int_capturer_create(test, any(test));
+ *		TEST_EXPECT_CALL(add(any(test), capturer_to_matcher(capturer)));
+ *		TEST_ASSERT_PARAM_CAPTURED(test, capturer);
+ *
+ *		int captured_value = mock_capturer_get(capturer, int);
+ *	}
+ */
+struct mock_param_capturer {
+	/* private: internal use only. */
+	struct mock_param_matcher matcher;
+	struct mock_param_matcher *child_matcher;
+	void *(*capture_param)(struct test *test, const void *param);
+	void *captured_param;
+};
+
+struct mock_param_capturer *mock_param_capturer_create(
+		struct test *test,
+		struct mock_param_matcher *child_matcher,
+		void *(*capture_param)(struct test *, const void *));
+
+/**
+ * mock_int_capturer_create() - creates a int parameter capturer
+ * @test: associated test
+ * @child_matcher: matcher used to match the integer
+ *
+ * The capturer will capture the value if the matcher is satisfied.
+ */
+struct mock_param_capturer *mock_int_capturer_create(
+		struct test *test, struct mock_param_matcher *child_matcher);
+
+/**
+ * mock_int_capturer_create() - creates a generic pointer parameter capturer
+ * @test: associated test
+ * @child_matcher: matcher used to match the pointer
+ *
+ * The capturer will capture the value if the matcher is satisfied
+ */
+struct mock_param_capturer *mock_ptr_capturer_create(
+		struct test *test, struct mock_param_matcher *child_matcher);
+
+/**
+ * capturer_to_matcher()
+ * @capturer: the param capturer
+ *
+ * Use this function when passing a capturer into an EXPECT_CALL() where a
+ * matcher would be expected. See the example for &struct mock_param_capturer.
+ */
+#define capturer_to_matcher(capturer) (&(capturer)->matcher)
+
+/**
+ * TEST_ASSERT_PARAM_CAPTURED(): Asserts that a parameter has been captured.
+ * @test: the associated test
+ * @capturer: the param capturer
+ *
+ * See &struct mock_param_capturer for an example.
+ */
+#define TEST_ASSERT_PARAM_CAPTURED(test, capturer)			       \
+		TEST_ASSERT(test,					       \
+		       !IS_ERR_OR_NULL((capturer)->captured_param),	       \
+		       "Asserted " #capturer " captured param, but did not.")
+
+/**
+ * mock_capturer_get(): Returns the value captured by ``capturer``
+ * @capturer: the param capturer
+ * @type: the type of the value
+ *
+ * See &struct mock_param_capturer for an example.
+ */
+#define mock_capturer_get(capturer, type) \
+		CONVERT_TO_ACTUAL_TYPE(type, (capturer)->captured_param)
+
 struct mock_action *invoke(struct test *test,
 			   void *(*invokable)(struct test *,
 					      const void *params[],
diff --git a/kunit/common-mocks.c b/kunit/common-mocks.c
index ce0159923814d..62528b7df83c6 100644
--- a/kunit/common-mocks.c
+++ b/kunit/common-mocks.c
@@ -323,6 +323,84 @@ struct mock_param_matcher *test_struct_cmp(
 	return &matcher->matcher;
 }
 
+static bool match_and_capture_param(struct mock_param_matcher *pmatcher,
+				    struct test_stream *stream,
+				    const void *param)
+{
+	struct mock_param_capturer *capturer =
+			container_of(pmatcher,
+				     struct mock_param_capturer,
+				     matcher);
+	struct mock_param_matcher *child_matcher = capturer->child_matcher;
+	bool matches;
+
+	matches = child_matcher->match(child_matcher, stream, param);
+	if (matches)
+		capturer->captured_param = capturer->capture_param(stream->test,
+								   param);
+
+	return matches;
+}
+
+struct mock_param_capturer *mock_param_capturer_create(
+		struct test *test,
+		struct mock_param_matcher *child_matcher,
+		void *(*capture_param)(struct test *, const void *))
+{
+	struct mock_param_capturer *capturer;
+
+	capturer = test_kzalloc(test, sizeof(*capturer), GFP_KERNEL);
+	if (!capturer)
+		return NULL;
+
+	capturer->matcher.match = match_and_capture_param;
+	capturer->child_matcher = child_matcher;
+	capturer->capture_param = capture_param;
+	capturer->captured_param = NULL;
+
+	return capturer;
+}
+
+static void *mock_capture_int(struct test *test, const void *param)
+{
+	int value = CONVERT_TO_ACTUAL_TYPE(int, param);
+	int *pvalue;
+
+	pvalue = test_kzalloc(test, sizeof(*pvalue), GFP_KERNEL);
+	if (!pvalue)
+		return NULL;
+	*pvalue = value;
+
+	return pvalue;
+}
+
+struct mock_param_capturer *mock_int_capturer_create(
+		struct test *test, struct mock_param_matcher *child_matcher)
+{
+	return mock_param_capturer_create(test,
+					  child_matcher,
+					  mock_capture_int);
+}
+
+static void *mock_capture_ptr(struct test *test, const void *param)
+{
+	void *ptr = CONVERT_TO_ACTUAL_TYPE(void *, param);
+	void **pptr;
+
+	pptr = test_kzalloc(test, sizeof(*pptr), GFP_KERNEL);
+	*pptr = ptr;
+
+	return pptr;
+}
+
+struct mock_param_capturer *mock_ptr_capturer_create(
+		struct test *test, struct mock_param_matcher *child_matcher)
+{
+	return mock_param_capturer_create(test,
+					  child_matcher,
+					  mock_capture_ptr);
+}
+
 #define DEFINE_RETURN_ACTION_STRUCT(type_name, type)			       \
 		struct mock_##type_name##_action {			       \
 			struct mock_action action;			       \
-- 
2.19.1.331.ge82ca0e54c-goog

