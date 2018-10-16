Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F4C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D65214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cD87gkTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D65214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJQHrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:14 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48968 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJQHrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:13 -0400
Received: by mail-qk1-f201.google.com with SMTP id w6-v6so22526740qka.15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G8mUMu2GbUg2JX8LWDmnjinAwy7AJF1XWi8Z4EzyP2w=;
        b=cD87gkTcOY15FVf3OnY9ju2AYChLswyGiPO4qaT8gdvcGVkGIvKvt7wtEHYP80HnD1
         QRpEJLRWwfE0WMkD1M1v7egeqhHB1KM1hjHU0LAZynpldBJyOqtN1FQelV07daXW/iuB
         Yx0kYYsbE5KqlEMvVPWS0iVoCsyt5ypyRX9I81qXLSGh4shAbpO0J0mVaAxfm7AxXkOZ
         hDoAaEEmWwfU2Ow4n3z99cD+pqTBArGldXauqEFv+4/0TzC5iG/O/pUkWxoY9XUYZZ1R
         PdknRKzx2mMaPprbC6+0mlMsnjxSjjyY2e9AnkpN5tIdZ5gCh4PyO7fwmvQJ3gnxuSkb
         sHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G8mUMu2GbUg2JX8LWDmnjinAwy7AJF1XWi8Z4EzyP2w=;
        b=umO8A8kIWSN0OKxlnCM1zzrqeePhDjdYWMjnZuCmTCbdHxlHTX2tK5tdeu65zxZIr9
         jVnjhQGxj6L/JzXBPDfhzbTL6J+a7+154Ob0z/P6UoZ3tAUpNtv0n1zAMnPA+ytkqnj5
         d6FMmxKZKnHf+tv5/8ixZXVh05dki/kpBCNy7RvRTAt8FCAa7Mgr1qhn/hCtyeEtSS7V
         OvWhf2NOGOEGT7FNeVE1RBHCSsueqwkGGT+7FXNEqlbG/hlxoubtwFewlWm0gfU8JFE0
         H/EqgF4r2OL5okh0OENegYw+T7gjeppH+rE3I7WwSWDkKV7El0pvFsKhrKljL620H0HU
         FcfQ==
X-Gm-Message-State: ABuFfohPcohxJ+DGlZBKfHvtvbbc2E6jEu68owCFPzXQdLXOX5+tH+KE
        AVnLgEg+sZTc4u17Y6/jKAMfR0zNHJR4Zkvt+Eb5nQ==
X-Google-Smtp-Source: ACcGV63goyHFI0Ba5xYbIs9fHChd50SB7jnKKtV9799SecgHVnuGXxqOIClC29aphcr7I+bghKungYtXv51a2aZu1iC9HA==
X-Received: by 2002:a0c:d0f2:: with SMTP id b47-v6mr19387561qvh.20.1539734063602;
 Tue, 16 Oct 2018 16:54:23 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:04 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-16-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 15/31] kunit: mock: added basic matchers and actions
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

Added basic matchers and actions needed for any kind of mocking to be
useful; these matchers and actions are how expectations for mocks are
described: what calls the mocks are expected to receive, and what the
mock should do under those circumstances.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/mock.h | 222 +++++++++++++++++++++++++++++++++++
 kunit/Makefile       |   3 +-
 kunit/common-mocks.c | 272 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 496 insertions(+), 1 deletion(-)
 create mode 100644 kunit/common-mocks.c

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index 1a35c5702cb15..62e8afcaeab55 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -122,4 +122,226 @@ struct mock_expectation *mock_add_matcher(struct mock *mock,
 					  struct mock_param_matcher *matchers[],
 					  int len);
 
+#define CONVERT_TO_ACTUAL_TYPE(type, ptr) (*((type *) ptr))
+
+/**
+ * DOC: Built In Matchers
+ *
+ * These are the matchers that can be used when matching arguments in
+ * :c:func:`EXPECT_CALL` (more can be defined manually).
+ *
+ * For example, there's a matcher that matches any arguments:
+ *
+ * .. code-block:: c
+ *
+ *    struct mock_param_matcher *any(struct test *test);
+ *
+ * There are matchers for integers based on the binary condition:
+ *
+ * * eq: equals to
+ * * ne: not equal to
+ * * lt: less than
+ * * le: less than or equal to
+ * * gt: greater than
+ * * ge: greater than or equal to
+ *
+ * .. code-block:: c
+ *
+ *    struct mock_param_matcher *test_int_eq(struct test *test, int expected);
+ *    struct mock_param_matcher *test_int_ne(struct test *test, int expected);
+ *    struct mock_param_matcher *test_int_lt(struct test *test, int expected);
+ *    struct mock_param_matcher *test_int_le(struct test *test, int expected);
+ *    struct mock_param_matcher *test_int_gt(struct test *test, int expected);
+ *    struct mock_param_matcher *test_int_ge(struct test *test, int expected);
+ *
+ * For a detailed list, please see
+ * ``include/linux/mock.h``.
+ */
+
+/* Matches any argument */
+struct mock_param_matcher *test_any(struct test *test);
+
+/*
+ * Matches different types of integers, the argument is compared to the
+ * `expected` field, based on the comparison defined.
+ */
+struct mock_param_matcher *test_u8_eq(struct test *test, u8 expected);
+struct mock_param_matcher *test_u8_ne(struct test *test, u8 expected);
+struct mock_param_matcher *test_u8_le(struct test *test, u8 expected);
+struct mock_param_matcher *test_u8_lt(struct test *test, u8 expected);
+struct mock_param_matcher *test_u8_ge(struct test *test, u8 expected);
+struct mock_param_matcher *test_u8_gt(struct test *test, u8 expected);
+
+struct mock_param_matcher *test_u16_eq(struct test *test, u16 expected);
+struct mock_param_matcher *test_u16_ne(struct test *test, u16 expected);
+struct mock_param_matcher *test_u16_le(struct test *test, u16 expected);
+struct mock_param_matcher *test_u16_lt(struct test *test, u16 expected);
+struct mock_param_matcher *test_u16_ge(struct test *test, u16 expected);
+struct mock_param_matcher *test_u16_gt(struct test *test, u16 expected);
+
+struct mock_param_matcher *test_u32_eq(struct test *test, u32 expected);
+struct mock_param_matcher *test_u32_ne(struct test *test, u32 expected);
+struct mock_param_matcher *test_u32_le(struct test *test, u32 expected);
+struct mock_param_matcher *test_u32_lt(struct test *test, u32 expected);
+struct mock_param_matcher *test_u32_ge(struct test *test, u32 expected);
+struct mock_param_matcher *test_u32_gt(struct test *test, u32 expected);
+
+struct mock_param_matcher *test_u64_eq(struct test *test, u64 expected);
+struct mock_param_matcher *test_u64_ne(struct test *test, u64 expected);
+struct mock_param_matcher *test_u64_le(struct test *test, u64 expected);
+struct mock_param_matcher *test_u64_lt(struct test *test, u64 expected);
+struct mock_param_matcher *test_u64_ge(struct test *test, u64 expected);
+struct mock_param_matcher *test_u64_gt(struct test *test, u64 expected);
+
+struct mock_param_matcher *test_char_eq(struct test *test, char expected);
+struct mock_param_matcher *test_char_ne(struct test *test, char expected);
+struct mock_param_matcher *test_char_le(struct test *test, char expected);
+struct mock_param_matcher *test_char_lt(struct test *test, char expected);
+struct mock_param_matcher *test_char_ge(struct test *test, char expected);
+struct mock_param_matcher *test_char_gt(struct test *test, char expected);
+
+struct mock_param_matcher *test_uchar_eq(struct test *test,
+					 unsigned char expected);
+struct mock_param_matcher *test_uchar_ne(struct test *test,
+					 unsigned char expected);
+struct mock_param_matcher *test_uchar_le(struct test *test,
+					 unsigned char expected);
+struct mock_param_matcher *test_uchar_lt(struct test *test,
+					 unsigned char expected);
+struct mock_param_matcher *test_uchar_ge(struct test *test,
+					 unsigned char expected);
+struct mock_param_matcher *test_uchar_gt(struct test *test,
+					 unsigned char expected);
+
+struct mock_param_matcher *test_schar_eq(struct test *test,
+					 signed char expected);
+struct mock_param_matcher *test_schar_ne(struct test *test,
+					 signed char expected);
+struct mock_param_matcher *test_schar_le(struct test *test,
+					 signed char expected);
+struct mock_param_matcher *test_schar_lt(struct test *test,
+					 signed char expected);
+struct mock_param_matcher *test_schar_ge(struct test *test,
+					 signed char expected);
+struct mock_param_matcher *test_schar_gt(struct test *test,
+					 signed char expected);
+
+struct mock_param_matcher *test_short_eq(struct test *test, short expected);
+struct mock_param_matcher *test_short_ne(struct test *test, short expected);
+struct mock_param_matcher *test_short_le(struct test *test, short expected);
+struct mock_param_matcher *test_short_lt(struct test *test, short expected);
+struct mock_param_matcher *test_short_ge(struct test *test, short expected);
+struct mock_param_matcher *test_short_gt(struct test *test, short expected);
+
+struct mock_param_matcher *test_ushort_eq(struct test *test,
+					  unsigned short expected);
+struct mock_param_matcher *test_ushort_ne(struct test *test,
+					  unsigned short expected);
+struct mock_param_matcher *test_ushort_le(struct test *test,
+					  unsigned short expected);
+struct mock_param_matcher *test_ushort_lt(struct test *test,
+					  unsigned short expected);
+struct mock_param_matcher *test_ushort_ge(struct test *test,
+					  unsigned short expected);
+struct mock_param_matcher *test_ushort_gt(struct test *test,
+					  unsigned short expected);
+
+struct mock_param_matcher *test_int_eq(struct test *test, int expected);
+struct mock_param_matcher *test_int_ne(struct test *test, int expected);
+struct mock_param_matcher *test_int_lt(struct test *test, int expected);
+struct mock_param_matcher *test_int_le(struct test *test, int expected);
+struct mock_param_matcher *test_int_gt(struct test *test, int expected);
+struct mock_param_matcher *test_int_ge(struct test *test, int expected);
+
+struct mock_param_matcher *test_uint_eq(struct test *test,
+					unsigned int expected);
+struct mock_param_matcher *test_uint_ne(struct test *test,
+					unsigned int expected);
+struct mock_param_matcher *test_uint_lt(struct test *test,
+					unsigned int expected);
+struct mock_param_matcher *test_uint_le(struct test *test,
+					unsigned int expected);
+struct mock_param_matcher *test_uint_gt(struct test *test,
+					unsigned int expected);
+struct mock_param_matcher *test_uint_ge(struct test *test,
+					unsigned int expected);
+
+struct mock_param_matcher *test_long_eq(struct test *test, long expected);
+struct mock_param_matcher *test_long_ne(struct test *test, long expected);
+struct mock_param_matcher *test_long_le(struct test *test, long expected);
+struct mock_param_matcher *test_long_lt(struct test *test, long expected);
+struct mock_param_matcher *test_long_ge(struct test *test, long expected);
+struct mock_param_matcher *test_long_gt(struct test *test, long expected);
+
+struct mock_param_matcher *test_ulong_eq(struct test *test,
+					 unsigned long expected);
+struct mock_param_matcher *test_ulong_ne(struct test *test,
+					 unsigned long expected);
+struct mock_param_matcher *test_ulong_le(struct test *test,
+					 unsigned long expected);
+struct mock_param_matcher *test_ulong_lt(struct test *test,
+					 unsigned long expected);
+struct mock_param_matcher *test_ulong_ge(struct test *test,
+					 unsigned long expected);
+struct mock_param_matcher *test_ulong_gt(struct test *test,
+					 unsigned long expected);
+
+struct mock_param_matcher *test_longlong_eq(struct test *test,
+					    long long expected);
+struct mock_param_matcher *test_longlong_ne(struct test *test,
+					    long long expected);
+struct mock_param_matcher *test_longlong_le(struct test *test,
+					    long long expected);
+struct mock_param_matcher *test_longlong_lt(struct test *test,
+					    long long expected);
+struct mock_param_matcher *test_longlong_ge(struct test *test,
+					    long long expected);
+struct mock_param_matcher *test_longlong_gt(struct test *test,
+					    long long expected);
+
+struct mock_param_matcher *test_ulonglong_eq(struct test *test,
+					     unsigned long long expected);
+struct mock_param_matcher *test_ulonglong_ne(struct test *test,
+					     unsigned long long expected);
+struct mock_param_matcher *test_ulonglong_le(struct test *test,
+					     unsigned long long expected);
+struct mock_param_matcher *test_ulonglong_lt(struct test *test,
+					     unsigned long long expected);
+struct mock_param_matcher *test_ulonglong_ge(struct test *test,
+					     unsigned long long expected);
+struct mock_param_matcher *test_ulonglong_gt(struct test *test,
+					     unsigned long long expected);
+
+/* Matches pointers. */
+struct mock_param_matcher *test_ptr_eq(struct test *test, void *expected);
+struct mock_param_matcher *test_ptr_ne(struct test *test, void *expected);
+struct mock_param_matcher *test_ptr_lt(struct test *test, void *expected);
+struct mock_param_matcher *test_ptr_le(struct test *test, void *expected);
+struct mock_param_matcher *test_ptr_gt(struct test *test, void *expected);
+struct mock_param_matcher *test_ptr_ge(struct test *test, void *expected);
+
+/* Matches memory sections and strings. */
+struct mock_param_matcher *test_memeq(struct test *test,
+				      const void *buf,
+				      size_t size);
+struct mock_param_matcher *test_streq(struct test *test, const char *str);
+
+struct mock_action *test_u8_return(struct test *test, u8 ret);
+struct mock_action *test_u16_return(struct test *test, u16 ret);
+struct mock_action *test_u32_return(struct test *test, u32 ret);
+struct mock_action *test_u64_return(struct test *test, u64 ret);
+struct mock_action *test_char_return(struct test *test, char ret);
+struct mock_action *test_uchar_return(struct test *test, unsigned char ret);
+struct mock_action *test_schar_return(struct test *test, signed char ret);
+struct mock_action *test_short_return(struct test *test, short ret);
+struct mock_action *test_ushort_return(struct test *test, unsigned short ret);
+struct mock_action *test_int_return(struct test *test, int ret);
+struct mock_action *test_uint_return(struct test *test, unsigned int ret);
+struct mock_action *test_long_return(struct test *test, long ret);
+struct mock_action *test_ulong_return(struct test *test, unsigned long ret);
+struct mock_action *test_longlong_return(struct test *test, long long ret);
+struct mock_action *test_ulonglong_return(struct test *test,
+					  unsigned long long ret);
+struct mock_action *test_ptr_return(struct test *test, void *ret);
+
 #endif /* _KUNIT_MOCK_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index ad58110de695c..52a1da46cbd21 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,4 +1,5 @@
-obj-$(CONFIG_KUNIT)		+= test.o mock.o string-stream.o test-stream.o
+obj-$(CONFIG_KUNIT)		+= test.o mock.o common-mocks.o string-stream.o \
+  test-stream.o
 obj-$(CONFIG_KUNIT_TEST)		+= \
   test-test.o mock-macro-test.o string-stream-test.o
 obj-$(CONFIG_EXAMPLE_TEST)	+= example-test.o
diff --git a/kunit/common-mocks.c b/kunit/common-mocks.c
new file mode 100644
index 0000000000000..ecac9c1c29c0e
--- /dev/null
+++ b/kunit/common-mocks.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common KUnit mock call arg matchers and formatters.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/kernel.h>
+#include <kunit/mock.h>
+
+static bool match_any(struct mock_param_matcher *pmatcher,
+		      struct test_stream *stream,
+		      const void *actual)
+{
+	stream->add(stream, "don't care");
+	return true;
+}
+
+static struct mock_param_matcher any_matcher = {
+	.match = match_any,
+};
+
+struct mock_param_matcher *test_any(struct test *test)
+{
+	return &any_matcher;
+}
+
+#define DEFINE_MATCHER_STRUCT(type_name, type)				       \
+		struct mock_##type_name##_matcher {			       \
+			struct mock_param_matcher matcher;		       \
+			type expected;					       \
+		};
+
+#define DEFINE_TO_MATCHER_STRUCT(type_name)				       \
+		struct mock_##type_name##_matcher *			       \
+		to_mock_##type_name##_matcher(				       \
+				struct mock_param_matcher *matcher)	       \
+		{							       \
+			return container_of(matcher,			       \
+					    struct mock_##type_name##_matcher, \
+					    matcher);			       \
+		}
+
+#define DEFINE_MATCH_FUNC(type_name, type, op_name, op)			       \
+		bool match_##type_name##_##op_name(			       \
+				struct mock_param_matcher *pmatcher,	       \
+				struct test_stream *stream,		       \
+				const void *pactual)			       \
+		{							       \
+			struct mock_##type_name##_matcher *matcher =	       \
+				to_mock_##type_name##_matcher(pmatcher);       \
+			type actual = *((type *) pactual);		       \
+			bool matches = actual op matcher->expected;	       \
+									       \
+			if (matches)					       \
+				stream->add(stream,			       \
+					    "%d "#op" %d",		       \
+					    actual,			       \
+					    matcher->expected);		       \
+			else						       \
+				stream->add(stream,			       \
+					    "%d not "#op" %d",		       \
+					    actual,			       \
+					    matcher->expected);		       \
+									       \
+			return matches;					       \
+		}
+
+#define DEFINE_MATCH_FACTORY(type_name, type, op_name)			       \
+		struct mock_param_matcher *test_##type_name##_##op_name(       \
+				struct test *test, type expected)	       \
+		{							       \
+			struct mock_##type_name##_matcher *matcher;	       \
+									       \
+			matcher = test_kmalloc(test,			       \
+					       sizeof(*matcher),	       \
+					       GFP_KERNEL);		       \
+			if (!matcher)					       \
+				return NULL;				       \
+									       \
+			matcher->matcher.match = match_##type_name##_##op_name;\
+			matcher->expected = expected;			       \
+			return &matcher->matcher;			       \
+		}
+
+#define DEFINE_MATCHER_WITH_TYPENAME(type_name, type)			       \
+		DEFINE_MATCHER_STRUCT(type_name, type)			       \
+		DEFINE_TO_MATCHER_STRUCT(type_name)			       \
+		DEFINE_MATCH_FUNC(type_name, type, eq, ==)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, eq)		       \
+		DEFINE_MATCH_FUNC(type_name, type, ne, !=)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, ne)		       \
+		DEFINE_MATCH_FUNC(type_name, type, le, <=)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, le)		       \
+		DEFINE_MATCH_FUNC(type_name, type, lt, <)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, lt)		       \
+		DEFINE_MATCH_FUNC(type_name, type, ge, >=)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, ge)		       \
+		DEFINE_MATCH_FUNC(type_name, type, gt, >)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, gt)
+
+#define DEFINE_MATCHER(type) DEFINE_MATCHER_WITH_TYPENAME(type, type)
+
+DEFINE_MATCHER(u8);
+DEFINE_MATCHER(u16);
+DEFINE_MATCHER(u32);
+DEFINE_MATCHER(u64);
+DEFINE_MATCHER(char);
+DEFINE_MATCHER_WITH_TYPENAME(uchar, unsigned char);
+DEFINE_MATCHER_WITH_TYPENAME(schar, signed char);
+DEFINE_MATCHER(short);
+DEFINE_MATCHER_WITH_TYPENAME(ushort, unsigned short);
+DEFINE_MATCHER(int);
+DEFINE_MATCHER_WITH_TYPENAME(uint, unsigned int);
+DEFINE_MATCHER(long);
+DEFINE_MATCHER_WITH_TYPENAME(ulong, unsigned long);
+DEFINE_MATCHER_WITH_TYPENAME(longlong, long long);
+DEFINE_MATCHER_WITH_TYPENAME(ulonglong, unsigned long long);
+
+DEFINE_MATCHER_WITH_TYPENAME(ptr, void *);
+
+struct mock_memeq_matcher {
+	struct mock_param_matcher matcher;
+	const void *expected;
+	size_t size;
+};
+
+static bool match_memeq(struct mock_param_matcher *pmatcher,
+			struct test_stream *stream,
+			const void *pactual)
+{
+	struct mock_memeq_matcher *matcher =
+			container_of(pmatcher,
+				     struct mock_memeq_matcher,
+				     matcher);
+	const void *actual = CONVERT_TO_ACTUAL_TYPE(const void *, pactual);
+	bool matches = !memcmp(actual, matcher->expected, matcher->size);
+	int i;
+
+	for (i = 0; i < matcher->size; i++)
+		stream->add(stream, "%02x, ", ((const char *) actual)[i]);
+	if (matches)
+		stream->add(stream, "== ");
+	else
+		stream->add(stream, "!= ");
+	for (i = 0; i < matcher->size; i++)
+		stream->add(stream,
+			    "%02x, ",
+			    ((const char *) matcher->expected)[i]);
+
+	return matches;
+}
+
+struct mock_param_matcher *test_memeq(struct test *test,
+				      const void *buf,
+				      size_t size)
+{
+	struct mock_memeq_matcher *matcher;
+
+	matcher = test_kzalloc(test, sizeof(*matcher), GFP_KERNEL);
+	if (!matcher)
+		return NULL;
+
+	matcher->matcher.match = match_memeq;
+	matcher->expected = buf;
+	matcher->size = size;
+
+	return &matcher->matcher;
+}
+
+struct mock_streq_matcher {
+	struct mock_param_matcher matcher;
+	const char *expected;
+};
+
+static bool match_streq(struct mock_param_matcher *pmatcher,
+			struct test_stream *stream,
+			const void *pactual)
+{
+	struct mock_streq_matcher *matcher =
+			container_of(pmatcher,
+				     struct mock_streq_matcher,
+				     matcher);
+	const char *actual = CONVERT_TO_ACTUAL_TYPE(const char *, pactual);
+	bool matches = !strcmp(actual, matcher->expected);
+
+	if (matches)
+		stream->add(stream, "%s == %s", actual, matcher->expected);
+	else
+		stream->add(stream, "%s != %s", actual, matcher->expected);
+
+	return matches;
+}
+
+struct mock_param_matcher *test_streq(struct test *test, const char *str)
+{
+	struct mock_streq_matcher *matcher;
+
+	matcher = test_kzalloc(test, sizeof(*matcher), GFP_KERNEL);
+	if (!matcher)
+		return NULL;
+
+	matcher->matcher.match = match_streq;
+	matcher->expected = str;
+
+	return &matcher->matcher;
+}
+
+#define DEFINE_RETURN_ACTION_STRUCT(type_name, type)			       \
+		struct mock_##type_name##_action {			       \
+			struct mock_action action;			       \
+			type ret;					       \
+		};
+
+#define DEFINE_RETURN_ACTION_FUNC(type_name, type)			       \
+		void *do_##type_name##_return(struct mock_action *paction,     \
+					      const void **params,	       \
+					      int len)			       \
+		{							       \
+			struct mock_##type_name##_action *action =	       \
+					container_of(paction,		       \
+						     struct mock_##type_name##_action,\
+						     action);		       \
+									       \
+			return (void *) &action->ret;			       \
+		}
+
+#define DEFINE_RETURN_ACTION_FACTORY(type_name, type)			       \
+		struct mock_action *test_##type_name##_return(		       \
+				struct test *test,			       \
+				type ret)				       \
+		{							       \
+			struct mock_##type_name##_action *action;	       \
+									       \
+			action = test_kmalloc(test,			       \
+					      sizeof(*action),		       \
+					      GFP_KERNEL);		       \
+			if (!action)					       \
+				return NULL;				       \
+									       \
+			action->action.do_action = do_##type_name##_return;    \
+			action->ret = ret;				       \
+									       \
+			return &action->action;				       \
+		}
+
+#define DEFINE_RETURN_ACTION_WITH_TYPENAME(type_name, type)		       \
+		DEFINE_RETURN_ACTION_STRUCT(type_name, type);		       \
+		DEFINE_RETURN_ACTION_FUNC(type_name, type);		       \
+		DEFINE_RETURN_ACTION_FACTORY(type_name, type);
+
+#define DEFINE_RETURN_ACTION(type) \
+		DEFINE_RETURN_ACTION_WITH_TYPENAME(type, type)
+
+DEFINE_RETURN_ACTION(u8);
+DEFINE_RETURN_ACTION(u16);
+DEFINE_RETURN_ACTION(u32);
+DEFINE_RETURN_ACTION(u64);
+DEFINE_RETURN_ACTION(char);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(uchar, unsigned char);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(schar, signed char);
+DEFINE_RETURN_ACTION(short);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(ushort, unsigned short);
+DEFINE_RETURN_ACTION(int);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(uint, unsigned int);
+DEFINE_RETURN_ACTION(long);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(ulong, unsigned long);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(longlong, long long);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(ulonglong, unsigned long long);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(ptr, void *);
+
-- 
2.19.1.331.ge82ca0e54c-goog

