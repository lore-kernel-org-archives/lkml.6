Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C530FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB922148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUzm2Rzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB922148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeJQHrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:08 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50992 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeJQHrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:07 -0400
Received: by mail-pl1-f202.google.com with SMTP id ba5-v6so15685521plb.17
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ji1t0J8eGmzbl7MSzcr9XutVhXSRB1rerFRgUj/ivO8=;
        b=HUzm2RzpAf7KqyFVBvVTe4BrOZbQ0+Amgf4b325MRKc69JUHL0InN6yTxbKrDPXae9
         GrJ49aePoJpXuAWZzrm0bMlPZ3nu7a30ZIIEFQfLF9tnJ8BiPMoAWKkTszzXfvnWw6yZ
         Jnx10o+coULr4DUsEYbRN9xuBYwcNB05bM+IQBGYIJcClrTrkfTXzibvxalBmDNokaSk
         OZ5S+j3QprSngUeIyKL8RhESjw2zJ0MNkrcPJtSkWUTtQLCCfjWvJrA830tS5nMelJOW
         1+aWEPAjABYCIrbz+J1Wv+n52G3IU44cWeXtmAbpxjCcJwHJswuvYsHM04CB8SN0iGcD
         D9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ji1t0J8eGmzbl7MSzcr9XutVhXSRB1rerFRgUj/ivO8=;
        b=hq6on/FG8t7T61m/6OzOcfkayUG4x3BmUgvQUeO7qMU307MxvXDKpopzUjv486Ocgr
         pM7kmKMNGGZwg4v/7s9NfQgTUXez5UvK7znfABhOrn6aXsmiDT4DVtBP6/g1BnX5zHiX
         y6Cmxh4HZo2FSsSfJxQkKi46kFt3Ilkf8lQlwrcKs7A0Iu1L+/40TVYJQ06Laa6O1dJn
         +ykCBnEnRBPSRY6I9YZwju4FRLvUW8dVUL0W6o8DDSja0MgBcaE7sJJUk/d3U66VNc1+
         20JOsKupg2dUYkvkM1xXyQTP1XvZGH+2Zvy9aCwhM9O+JPUfnS7LhU0cG19ZCmf+fTHS
         zRLg==
X-Gm-Message-State: ABuFfohcAzVXQfwIxs7p2+nMjyrHLjh0I/OsOYqmoN239mXgYMkTPxmL
        nIjy85HQL4VIMC6ws7ADs4TAzlGXMjfz/quA0fZnSA==
X-Google-Smtp-Source: ACcGV61O5ZEPCWXnN8I0E+VNPClekZmLZJGbUygjOMJ+Av+8wDP8THabU2aj1USBxJfOKwZfSYWL2aUGXLcnSyvUpkoVzA==
X-Received: by 2002:a65:60cc:: with SMTP id r12-v6mr11893684pgv.78.1539734058465;
 Tue, 16 Oct 2018 16:54:18 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:02 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-14-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 13/31] kunit: mock: added parameter list minipulation macros
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

Adds macros for parsing and manipulating parameter lists needed for
generating mocks.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/params.h  | 305 ++++++++++++++++++++++++++++++++++++++++
 kunit/Makefile          |   2 +-
 kunit/mock-macro-test.c | 149 ++++++++++++++++++++
 3 files changed, 455 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/params.h
 create mode 100644 kunit/mock-macro-test.c

diff --git a/include/kunit/params.h b/include/kunit/params.h
new file mode 100644
index 0000000000000..f9692d3cd703f
--- /dev/null
+++ b/include/kunit/params.h
@@ -0,0 +1,305 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros for parsing and manipulating parameter lists needed for generating
+ * mocks.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_PARAMS_H
+#define _KUNIT_PARAMS_H
+
+#define NUM_VA_ARGS_IMPL(__dummy,					       \
+			 __1,						       \
+			 __2,						       \
+			 __3,						       \
+			 __4,						       \
+			 __5,						       \
+			 __6,						       \
+			 __7,						       \
+			 __8,						       \
+			 __9,						       \
+			 __10,						       \
+			 __11,						       \
+			 __12,						       \
+			 __13,						       \
+			 __14,						       \
+			 __15,						       \
+			 __16,						       \
+			 __nargs, args...) __nargs
+
+#define NUM_VA_ARGS(args...) NUM_VA_ARGS_IMPL(__dummy, ##args,		       \
+					  16,				       \
+					  15,				       \
+					  14,				       \
+					  13,				       \
+					  12,				       \
+					  11,				       \
+					  10,				       \
+					  9,				       \
+					  8,				       \
+					  7,				       \
+					  6,				       \
+					  5,				       \
+					  4,				       \
+					  3,				       \
+					  2,				       \
+					  1,				       \
+					  0)
+
+#define CONCAT_INTERNAL(left, right) left##right
+#define CONCAT(left, right) CONCAT_INTERNAL(left, right)
+
+#define EMPTY()
+
+/*
+ * Takes the name of a function style macro such as FOO() and prevents it from
+ * being evaluated on the current pass.
+ *
+ * This is useful when you need to write a "recursive" macro since a macro name
+ * becomes painted after it is pasted. If a different macro is pasted, this
+ * different macro won't be pasted; if we then defer the evaluation of the this
+ * "indirection macro", we can prevent the original definition from getting
+ * painted.
+ *
+ * Example:
+ *   #define EXAMPLE EXPAND(FOO()) // FOO() is evaluated on 1st pass.
+ *   #define EXAMPLE EXPAND(DEFER(FOO)()) // FOO() is evaluated on the second
+ *					  // pass.
+ */
+#define DEFER(macro_id) macro_id EMPTY()
+
+/*
+ * Takes the name of a function style macro such as FOO() and prevents it from
+ * being evaluated on the current or following pass.
+ *
+ * This is useful when you need to DEFER inside an operation which causes an
+ * extra pass, like IF.
+ *
+ * Example:
+ *   #define EXAMPLE EXPAND(FOO()) // FOO() is evaluated on 1st pass.
+ *   #define EXAMPLE EXPAND(DEFER(FOO)()) // FOO() is evaluated on the second
+ *					  // pass.
+ *   #define EXAMPLE EXPAND(OBSTRUCT(FOO)()) // FOO() is evaluated on the third
+ *					     // pass.
+ */
+#define OBSTRUCT(macro_id) macro_id DEFER(EMPTY)()
+
+#define EXPAND_1(args...) args
+#define EXPAND_2(args...) EXPAND_1(EXPAND_1(args))
+#define EXPAND_4(args...) EXPAND_2(EXPAND_2(args))
+#define EXPAND_8(args...) EXPAND_4(EXPAND_4(args))
+#define EXPAND_16(args...) EXPAND_8(EXPAND_8(args))
+
+/*
+ * Causes multiple evaluation passes of a macro.
+ *
+ * CPP is implemented as a push down automaton. It consumes a stream of tokens
+ * and as it comes across macros, it either evaluates them and pastes the
+ * result, or if the macro is a function macro, it pushes the macro to a stack,
+ * it evaluates the input to the function macro, pops the state from the stack
+ * and continues.
+ *
+ * This macro serves the function of making the cursor return to the beginging
+ * of a macro that requires mulitple passes to evaluate. It is most useful when
+ * used with DEFER(...) and OBSTRUCT(...).
+ */
+#define EXPAND(args...) EXPAND_16(args)
+
+#define INC(id) INC_##id
+#define INC_0  1
+#define INC_1  2
+#define INC_2  3
+#define INC_3  4
+#define INC_4  5
+#define INC_5  6
+#define INC_6  7
+#define INC_7  8
+#define INC_8  9
+#define INC_9  10
+#define INC_10 11
+#define INC_11 12
+#define INC_12 13
+#define INC_13 14
+#define INC_14 15
+#define INC_15 16
+#define INC_16 17
+
+#define DEC(id) DEC_##id
+#define DEC_1  0
+#define DEC_2  1
+#define DEC_3  2
+#define DEC_4  3
+#define DEC_5  4
+#define DEC_6  5
+#define DEC_7  6
+#define DEC_8  7
+#define DEC_9  8
+#define DEC_10 9
+#define DEC_11 10
+#define DEC_12 11
+#define DEC_13 12
+#define DEC_14 13
+#define DEC_15 14
+#define DEC_16 15
+
+#define DROP_FIRST_ARG_INTERNAL(dropped, x, args...) x
+#define DROP_FIRST_ARG(args...) DROP_FIRST_ARG_INTERNAL(args)
+
+#define EQUAL(left, right) EQUAL_##left##_##right
+#define EQUAL_0_0 dropped, 1
+#define EQUAL_1_1 dropped, 1
+#define EQUAL_2_2 dropped, 1
+#define EQUAL_3_3 dropped, 1
+#define EQUAL_4_4 dropped, 1
+#define EQUAL_5_5 dropped, 1
+#define EQUAL_6_6 dropped, 1
+#define EQUAL_7_7 dropped, 1
+#define EQUAL_8_8 dropped, 1
+#define EQUAL_9_9 dropped, 1
+#define EQUAL_10_10 dropped, 1
+#define EQUAL_11_11 dropped, 1
+#define EQUAL_12_12 dropped, 1
+#define EQUAL_13_13 dropped, 1
+#define EQUAL_14_14 dropped, 1
+#define EQUAL_15_15 dropped, 1
+#define EQUAL_16_16 dropped, 1
+
+#define IS_EQUAL(left, right) DROP_FIRST_ARG(EQUAL(left, right), 0)
+
+#define NOT_INTERNAL(condition) NOT_##condition
+#define NOT(condition) NOT_INTERNAL(condition)
+#define NOT_0 1
+#define NOT_1 0
+
+#define IS_NOT_EQUAL(left, right) NOT(IS_EQUAL(left, right))
+
+#define EMPTY_IMPL(tokens) CONCAT(EMPTY_, tokens)
+#define IS_EMPTY(tokens)
+
+#define OR_INTERNAL(left, right) OR_##left##_##right
+#define OR(left, right) OR_INTERNAL(left, right)
+#define OR_0_0 0
+#define OR_0_1 1
+#define OR_1_0 1
+#define OR_1_1 1
+
+#define IF(condition) CONCAT(IF_, condition)
+#define IF_0(body)
+#define IF_1(body) body
+
+#define COMMA() ,
+
+#define APPLY_TOKENS_INTERNAL(tokens, yield_token, seen_token) \
+		IF(yield_token)(IF(seen_token)(COMMA()) tokens)
+#define APPLY_TOKENS(tokens, yield_token, seen_token) \
+		APPLY_TOKENS_INTERNAL(tokens, yield_token, seen_token)
+
+/*
+ * Provides the indirection to keep the PARAM_LIST_RECURSE_INTERNAL from getting
+ * pasted, only useful if used with DEFER(...) or OBSTRUCT(...).
+ */
+#define PARAM_LIST_RECURSE_INDIRECT() PARAM_LIST_RECURSE_INTERNAL
+
+/*
+ * Given a starting index, a number of args, a MACRO to apply, and a list of
+ * types (with at least one element) this will call MACRO with the first type in
+ * the list and index; it will then call itself again on all remaining types, if
+ * any, while incrementing index, and decrementing nargs.
+ *
+ * Assumes nargs is the number of types in the list.
+ */
+#define PARAM_LIST_RECURSE_INTERNAL(index,				       \
+				    nargs,				       \
+				    MACRO,				       \
+				    FILTER,				       \
+				    context,				       \
+				    seen_token,				       \
+				    type,				       \
+				    args...)				       \
+		APPLY_TOKENS(MACRO(context, type, index),		       \
+			     FILTER(context, type, index),		       \
+			     seen_token)				       \
+		IF(IS_NOT_EQUAL(nargs, 1))				       \
+			(OBSTRUCT(PARAM_LIST_RECURSE_INDIRECT)()	       \
+			 (INC(index), DEC(nargs),			       \
+			  MACRO, FILTER, context,			       \
+			  OR(seen_token, FILTER(context, type, index)),	       \
+			  args))
+
+#define PARAM_LIST_RECURSE(index, nargs, MACRO, FILTER, context, args...)      \
+		IF(IS_NOT_EQUAL(nargs, 0))				       \
+			(OBSTRUCT(PARAM_LIST_RECURSE_INTERNAL)(index,	       \
+							       nargs,	       \
+							       MACRO,	       \
+							       FILTER,	       \
+							       context,	       \
+							       0,	       \
+							       args))
+
+#define FILTER_NONE(context, type, index) 1
+
+#define FILTER_INDEX_INTERNAL(index_to_drop, type, index) \
+		IS_NOT_EQUAL(index, index_to_drop)
+#define FILTER_INDEX(index_to_drop, type, index) \
+		FILTER_INDEX_INTERNAL(index_to_drop, type, index)
+
+/*
+ * Applies a MACRO which takes a type and the index of the type and outputs a
+ * sequence of tokens to a list of types.
+ */
+#define FOR_EACH_PARAM(MACRO, FILTER, context, args...) \
+		EXPAND(PARAM_LIST_RECURSE(0,\
+					  NUM_VA_ARGS(args),\
+					  MACRO,\
+					  FILTER,\
+					  context,\
+					  args))
+
+#define PRODUCE_TYPE_AND_ARG(context, type, index) type arg##index
+#define PARAM_LIST_FROM_TYPES(args...)					       \
+		FOR_EACH_PARAM(PRODUCE_TYPE_AND_ARG,			       \
+			       FILTER_NONE,				       \
+			       not_used,				       \
+			       args)
+
+#define PRODUCE_TYPE_NAME(context, type, index) #type
+#define TYPE_NAMES_FROM_TYPES(handle_index, args...)			       \
+		FOR_EACH_PARAM(PRODUCE_TYPE_NAME,			       \
+			       FILTER_INDEX,				       \
+			       handle_index,				       \
+			       args)
+
+#define PRODUCE_PTR_TO_ARG(context, type, index) &arg##index
+#define PTR_TO_ARG_FROM_TYPES(handle_index, args...)			       \
+		FOR_EACH_PARAM(PRODUCE_PTR_TO_ARG,			       \
+			       FILTER_INDEX,				       \
+			       handle_index,				       \
+			       args)
+
+#define PRODUCE_MATCHER_AND_ARG(ctrl_index, type, index)		       \
+		IF(IS_EQUAL(index, ctrl_index))(struct mock *arg##ctrl_index)  \
+		IF(IS_NOT_EQUAL(index, ctrl_index))(			       \
+				struct mock_param_matcher *arg##index)
+#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)		       \
+		FOR_EACH_PARAM(PRODUCE_MATCHER_AND_ARG,			       \
+			       FILTER_NONE,				       \
+			       ctrl_index,				       \
+			       args)
+
+#define PRODUCE_ARG(context, type, index) arg##index
+#define ARG_NAMES_FROM_TYPES(ctrl_index, args...)			       \
+		FOR_EACH_PARAM(PRODUCE_ARG,				       \
+			       FILTER_INDEX,				       \
+			       ctrl_index,				       \
+			       args)
+
+#define PRODUCE_ARRAY_ACCESSOR(context, type, index) *((type *) params[index])
+#define ARRAY_ACCESSORS_FROM_TYPES(args...)				       \
+		FOR_EACH_PARAM(PRODUCE_ARRAY_ACCESSOR,			       \
+			       FILTER_NONE,				       \
+			       not_used,				       \
+			       args)
+
+#endif /* _KUNIT_PARAMS_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index 2f1c069e165cb..f72a02cb9f23d 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_KUNIT)		+= test.o string-stream.o test-stream.o
-obj-$(CONFIG_KUNIT_TEST)		+= test-test.o string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST)		+= test-test.o mock-macro-test.o string-stream-test.o
 obj-$(CONFIG_EXAMPLE_TEST)	+= example-test.o
diff --git a/kunit/mock-macro-test.c b/kunit/mock-macro-test.c
new file mode 100644
index 0000000000000..c30b859ff2b14
--- /dev/null
+++ b/kunit/mock-macro-test.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for parameter list parsing macros.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/params.h>
+
+#define TO_STR_INTERNAL(...) #__VA_ARGS__
+#define TO_STR(...) TO_STR_INTERNAL(__VA_ARGS__)
+
+static void mock_macro_is_equal(struct test *test)
+{
+	TEST_EXPECT_STREQ(test, "dropped, 1", TO_STR(EQUAL(1, 1)));
+	TEST_EXPECT_EQ(test, 1, DROP_FIRST_ARG(dropped, 1, 0));
+	TEST_EXPECT_EQ(test, 0, DROP_FIRST_ARG(1, 0));
+	TEST_EXPECT_EQ(test, 0, DROP_FIRST_ARG(EQUAL(1, 0), 0));
+	TEST_EXPECT_EQ(test, 1, IS_EQUAL(1, 1));
+	TEST_EXPECT_EQ(test, 0, IS_EQUAL(1, 0));
+}
+
+static void mock_macro_if(struct test *test)
+{
+	TEST_EXPECT_STREQ(test, "body", ""IF(1)("body"));
+	TEST_EXPECT_STREQ(test, "", ""IF(0)("body"));
+	TEST_EXPECT_STREQ(test, "body", ""IF(IS_EQUAL(1, 1))("body"));
+	TEST_EXPECT_STREQ(test, "", ""IF(IS_EQUAL(0, 1))("body"));
+}
+
+static void mock_macro_apply_tokens(struct test *test)
+{
+	TEST_EXPECT_STREQ(test, "type", TO_STR(APPLY_TOKENS(type, 1, 0)));
+	TEST_EXPECT_STREQ(test, ", type", TO_STR(APPLY_TOKENS(type, 1, 1)));
+	TEST_EXPECT_STREQ(test, "", TO_STR(APPLY_TOKENS(type, 0, 1)));
+}
+
+#define IDENTITY(context, type, index) type
+
+static void mock_macro_param_list_recurse(struct test *test)
+{
+	TEST_EXPECT_STREQ(test, "", TO_STR(PARAM_LIST_RECURSE(0,
+							      0,
+							      IDENTITY,
+							      FILTER_NONE,
+							      not_used)));
+	TEST_EXPECT_STREQ(test,
+			  "type",
+			  TO_STR(EXPAND(PARAM_LIST_RECURSE(0,
+							   1,
+							   IDENTITY,
+							   FILTER_NONE,
+							   not_used,
+							   type))));
+	TEST_EXPECT_STREQ(test,
+			  "type0 , type1 , type2 , type3 , type4 , type5 , "
+			  "type6 , type7 , type8 , type9 , type10 , type11 , "
+			  "type12 , type13 , type14 , type15",
+			  TO_STR(EXPAND(PARAM_LIST_RECURSE(0, 16,
+							   IDENTITY,
+							   FILTER_NONE,
+							   not_used,
+							   type0, type1, type2,
+							   type3, type4, type5,
+							   type6, type7, type8,
+							   type9, type10,
+							   type11, type12,
+							   type13, type14,
+							   type15))));
+}
+
+static void mock_macro_for_each_param(struct test *test)
+{
+	TEST_EXPECT_STREQ(test,
+			  "type0 , type1",
+			  TO_STR(FOR_EACH_PARAM(IDENTITY,
+						FILTER_NONE,
+						not_used,
+						type0,
+						type1)));
+	TEST_EXPECT_STREQ(test,
+			  "type1",
+			  TO_STR(FOR_EACH_PARAM(IDENTITY,
+						FILTER_INDEX,
+						0,
+						type0,
+						type1)));
+}
+
+static void mock_macro_param_list_from_types_basic(struct test *test)
+{
+	TEST_EXPECT_STREQ(test, "", TO_STR(PARAM_LIST_FROM_TYPES()));
+	TEST_EXPECT_STREQ(test, "int arg0", TO_STR(PARAM_LIST_FROM_TYPES(int)));
+	TEST_EXPECT_STREQ(test, "struct test_struct * arg0 , int arg1",
+			  TO_STR(PARAM_LIST_FROM_TYPES(struct test_struct *,
+						       int)));
+	TEST_EXPECT_STREQ(test,
+			  "type0 arg0 , type1 arg1 , type2 arg2 , type3 arg3 , "
+			  "type4 arg4 , type5 arg5 , type6 arg6 , type7 arg7 , "
+			  "type8 arg8 , type9 arg9 , type10 arg10 , "
+			  "type11 arg11 , type12 arg12 , type13 arg13 , "
+			  "type14 arg14 , type15 arg15",
+			  TO_STR(PARAM_LIST_FROM_TYPES(type0, type1, type2,
+						       type3, type4, type5,
+						       type6, type7, type8,
+						       type9, type10, type11,
+						       type12, type13, type14,
+						       type15)));
+}
+
+static void mock_macro_arg_names_from_types(struct test *test)
+{
+	TEST_EXPECT_STREQ(test, "", TO_STR(ARG_NAMES_FROM_TYPES(0)));
+	TEST_EXPECT_STREQ(test, "", TO_STR(ARG_NAMES_FROM_TYPES(0, int)));
+	TEST_EXPECT_STREQ(test,
+			  "arg1",
+			  TO_STR(ARG_NAMES_FROM_TYPES(0,
+						      struct test_struct *,
+						      int)));
+	TEST_EXPECT_STREQ(test,
+			  "arg0 , arg1 , arg3 , arg4 , arg5 , arg6 , arg7 , "
+			  "arg8 , arg9 , arg10 , arg11 , arg12 , arg13 , "
+			  "arg14 , arg15",
+			  TO_STR(ARG_NAMES_FROM_TYPES(2, type0, type1, type2,
+						      type3, type4, type5,
+						      type6, type7, type8,
+						      type9, type10, type11,
+						      type12, type13, type14,
+						      type15)));
+}
+
+static struct test_case mock_macro_test_cases[] = {
+	TEST_CASE(mock_macro_is_equal),
+	TEST_CASE(mock_macro_if),
+	TEST_CASE(mock_macro_apply_tokens),
+	TEST_CASE(mock_macro_param_list_recurse),
+	TEST_CASE(mock_macro_for_each_param),
+	TEST_CASE(mock_macro_param_list_from_types_basic),
+	TEST_CASE(mock_macro_arg_names_from_types),
+	{},
+};
+
+static struct test_module mock_macro_test_module = {
+	.name = "mock-macro-test",
+	.test_cases = mock_macro_test_cases,
+};
+module_test(mock_macro_test_module);
-- 
2.19.1.331.ge82ca0e54c-goog

