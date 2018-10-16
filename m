Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB8C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A112087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t25OKSQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A112087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeJQHrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:16 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:52645 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJQHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:16 -0400
Received: by mail-it1-f202.google.com with SMTP id n132-v6so234715itn.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eYgRPNileDwgvqqyHv6bH3k+biiDMeehKa3nWE2sDeg=;
        b=t25OKSQ9zcvMWXvA/j/yO893F3RUC3gcgUH+TXYxjVYtjtHFseMJ1CVGF1VWpviqRv
         qno8hUtS214ythFe7WcAPrfua4RYeFFDg0TEz2gz3/iJkWJiTNNJsTJh/K0y7oX7Uq59
         D+PCMMOU5Sf3kTtZgcXRmDTcTwJVhcLbYP0DIiAsFlvdn3mHPu9Ww7p2BG8EWeeoGJMh
         +Gkrh1wod+Jq8hih6xsBW0jiZPy0YLUO7aLyiG96/YP846CDo6+OSlz/OVCqoFTvwje0
         c5tpk4dR6j6vaQkD7AQpuS2xllFYPBCWHJxavSQn4D3GaDZfpsuPZPUJcjvNE/DIVaqi
         oSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eYgRPNileDwgvqqyHv6bH3k+biiDMeehKa3nWE2sDeg=;
        b=gs8QQhtyHWRhMQeju1hW7mUAxxrF59Im0mV/7XOaqAQkOiJaoEsYCc01Uwdbj1frEF
         pv42lkVRHaQFgge3yVo6pxmiCc5pPJ9rwW+TVgJMXBEWs98TKPXIOmouvHAiAQ6dFekF
         mfq4pU6oqhmMICPKwrjTdCLyqj7H2KHao30MCaPOf9Pf7iXBU+8IKnumZLNiBx/YQcqa
         /Stvx6CXeao0v9yXmyc7omSlLhUfZxb6yJ5wSZmpKHItA8pvpg48/usaFaVMCTledocg
         PGrqmyXFJZp0vKo9kMYM7qY23bYFZYj9ifyGc1kzkxkIlA/qONs4L2pNvwPcJczhfwrU
         +Z5w==
X-Gm-Message-State: ABuFfoiMhwUQvyHDRA1dKP/IPswA2EYQcmjUd/mWc1HByEmwQGOhl70Z
        ROUpUJ7exyMon/MVZLNqPaRU6GQN8N0ePv4qEeRxRg==
X-Google-Smtp-Source: ACcGV603sB8VhNBjAmSgSitkpW+o+yP69w/yJ4Vhra8w7uyYdqVP6BkVPXavyl4xUanhAR3xjB2ufoSwlE7WnJLPTEJ3Aw==
X-Received: by 2002:a24:17c5:: with SMTP id 188-v6mr203693ith.19.1539734066132;
 Tue, 16 Oct 2018 16:54:26 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:05 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 16/31] kunit: mock: added class mocking support
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

Introduces basic class mocking, the ability to automatically generate a
Linux C-style class implementation whose behavior is controlled by test
cases, which can also set expectations on when and how mocks are called.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/mock.h    | 438 +++++++++++++++++++++++++++++++++++++++-
 kunit/Makefile          |   2 +-
 kunit/example-test.c    |  90 +++++++++
 kunit/mock-macro-test.c |  82 ++++++++
 kunit/mock-test.c       | 276 +++++++++++++++++++++++++
 kunit/test-mock.c       |  39 ++++
 kunit/test-mock.h       |  23 +++
 7 files changed, 947 insertions(+), 3 deletions(-)
 create mode 100644 kunit/mock-test.c
 create mode 100644 kunit/test-mock.c
 create mode 100644 kunit/test-mock.h

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index 62e8afcaeab55..1b7485e2cedb8 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -72,7 +72,8 @@ struct mock_action {
  * @retire_on_saturation: no longer match once ``max_calls_expected`` is
  *			  reached.
  *
- * Represents a *call expectation* on a function created with EXPECT_CALL().
+ * Represents a *call expectation* on a function created with
+ * TEST_EXPECT_CALL().
  */
 struct mock_expectation {
 	struct mock_action *action;
@@ -122,13 +123,446 @@ struct mock_expectation *mock_add_matcher(struct mock *mock,
 					  struct mock_param_matcher *matchers[],
 					  int len);
 
+#define MOCK(name) name##_mock
+
+/**
+ * TEST_EXPECT_CALL() - Declares a *call expectation* on a mock function.
+ * @expectation_call: a mocked method or function with parameters replaced with
+ *                    matchers.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	// Class to mock.
+ *	struct example {
+ *		int (*foo)(struct example *, int);
+ *	};
+ *
+ *	// Define the mock.
+ *	DECLARE_STRUCT_CLASS_MOCK_PREREQS(example);
+ *
+ *	DEFINE_STRUCT_CLASS_MOCK(METHOD(foo), CLASS(example),
+ *				 RETURNS(int),
+ *				 PARAMS(struct example *, int));
+ *
+ *	static int example_init(struct MOCK(example) *mock_example)
+ *	{
+ *		struct example *example = mock_get_trgt(mock_example);
+ *
+ *		example->foo = foo;
+ *		return 0;
+ *	}
+ *
+ *	DEFINE_STRUCT_CLASS_MOCK_INIT(example, example_init);
+ *
+ *	static void foo_example_test_success(struct test *test)
+ *	{
+ *		struct MOCK(example) *mock_example;
+ *		struct example *example = mock_get_trgt(mock_example);
+ *		struct mock_expectation *handle;
+ *
+ *		mock_example = CONSTRUCT_MOCK(example, test);
+ *
+ *		handle = TEST_EXPECT_CALL(foo(mock_get_ctrl(mock_example),
+ *				     test_int_eq(test, 5)));
+ *		handle->action = int_return(test, 2);
+ *
+ *		EXPECT_EQ(test, 2, example_bar(example, 5));
+ *	}
+ *
+ * Return:
+ * A &struct mock_expectation representing the call expectation.
+ * allowing additional conditions and actions to be specified.
+ */
+#define TEST_EXPECT_CALL(expectation_call) mock_master_##expectation_call
+
+#define mock_get_ctrl_internal(mock_object) (&(mock_object)->ctrl)
+#define mock_get_ctrl(mock_object) mock_get_ctrl_internal(mock_object)
+
+#define mock_get_trgt_internal(mock_object) (&(mock_object)->trgt)
+#define mock_get_trgt(mock_object) mock_get_trgt_internal(mock_object)
+
+#define mock_get_test(mock_object) (mock_get_ctrl(mock_object)->test)
+
+#define CLASS(struct_name) struct_name
+#define HANDLE_INDEX(index) index
+#define METHOD(method_name) method_name
+#define RETURNS(return_type) return_type
+/* #define PARAMS(...) __VA_ARGS__ included by linux/tracepoint.h */
+
+#define MOCK_INIT_ID(struct_name) struct_name##mock_init
+#define REAL_ID(func_name) __real__##func_name
+#define INVOKE_ID(func_name) __invoke__##func_name
+
+#define DECLARE_MOCK_CLIENT(name, return_type, param_types...) \
+		return_type name(PARAM_LIST_FROM_TYPES(param_types))
+
+#define DECLARE_MOCK_MASTER(name, ctrl_index, param_types...)		       \
+		struct mock_expectation *mock_master_##name(		       \
+				MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index,      \
+							      param_types));
+
+#define DECLARE_MOCK_COMMON(name, handle_index, return_type, param_types...)   \
+		DECLARE_MOCK_CLIENT(name, return_type, param_types);	       \
+		DECLARE_MOCK_MASTER(name, handle_index, param_types)
+
+#define DECLARE_STRUCT_CLASS_MOCK_STRUCT(struct_name)			       \
+		struct MOCK(struct_name) {				       \
+			struct mock		ctrl;			       \
+			struct struct_name	trgt;			       \
+		}
+
+#define DECLARE_STRUCT_CLASS_MOCK_CONVERTER(struct_name)		       \
+		static inline struct mock *from_##struct_name##_to_mock(       \
+				const struct struct_name *trgt)		       \
+		{							       \
+			return mock_get_ctrl(				       \
+					container_of(trgt,		       \
+						     struct MOCK(struct_name), \
+						     trgt));		       \
+		}
+
+/**
+ * DECLARE_STRUCT_CLASS_MOCK_PREREQS() - Create a mock child class
+ * @struct_name: name of the class/struct to be mocked
+ *
+ * Creates a mock child class of ``struct_name`` named
+ * ``struct MOCK(struct_name)`` along with supporting internally used methods.
+ *
+ * See TEST_EXPECT_CALL() for example usages.
+ */
+#define DECLARE_STRUCT_CLASS_MOCK_PREREQS(struct_name)			       \
+		DECLARE_STRUCT_CLASS_MOCK_STRUCT(struct_name);		       \
+		DECLARE_STRUCT_CLASS_MOCK_CONVERTER(struct_name)
+
+#define DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,		       \
+							struct_name,	       \
+							handle_index,	       \
+							return_type,	       \
+							param_types...)	       \
+		DECLARE_MOCK_COMMON(name,				       \
+				    handle_index,			       \
+				    return_type,			       \
+				    param_types)
+
+#define DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,			       \
+					       struct_name,		       \
+					       handle_index,		       \
+					       return_type,		       \
+					       param_types...)		       \
+		DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,	       \
+								struct_name,   \
+								handle_index,  \
+								return_type,   \
+								param_types)
+
+/**
+ * DECLARE_STRUCT_CLASS_MOCK()
+ * @name: method name
+ * @struct_name: name of the class/struct
+ * @return_type: return type of the method
+ * @param_types: parameters of the method
+ *
+ * Same as DEFINE_STRUCT_CLASS_MOCK(), but only makes header compatible
+ * declarations.
+ */
+#define DECLARE_STRUCT_CLASS_MOCK(name,					       \
+				  struct_name,				       \
+				  return_type,				       \
+				  param_types...)			       \
+		DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,		       \
+						       struct_name,	       \
+						       0,		       \
+						       return_type,	       \
+						       param_types)
+
+/**
+ * DECLARE_STRUCT_CLASS_MOCK_VOID_RETURN()
+ * @name: method name
+ * @struct_name: name of the class/struct
+ * @param_types: parameters of the method
+ *
+ * Same as DEFINE_STRUCT_CLASS_MOCK_VOID_RETURN(), but only makes header
+ * compatible declarations.
+ */
+#define DECLARE_STRUCT_CLASS_MOCK_VOID_RETURN(name,			       \
+					      struct_name,		       \
+					      param_types...)		       \
+		DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,		       \
+						       struct_name,	       \
+						       0,		       \
+						       void,		       \
+						       param_types)
+
+/**
+ * DECLARE_STRUCT_CLASS_MOCK_INIT()
+ * @struct_name: name of the class/struct
+ *
+ * Same as DEFINE_STRUCT_CLASS_MOCK_INIT(), but only makes header compatible
+ * declarations.
+ */
+#define DECLARE_STRUCT_CLASS_MOCK_INIT(struct_name)			       \
+		struct MOCK(struct_name) *MOCK_INIT_ID(struct_name)(	       \
+				struct test *test)
+
+/**
+ * CONSTRUCT_MOCK()
+ * @struct_name: name of the class
+ * @test: associated test
+ *
+ * Constructs and allocates a test managed ``struct MOCK(struct_name)`` given
+ * the name of the class for which the mock is defined and a test object.
+ *
+ * See TEST_EXPECT_CALL() for example usage.
+ */
+#define CONSTRUCT_MOCK(struct_name, test) MOCK_INIT_ID(struct_name)(test)
+
+#define DEFINE_MOCK_CLIENT_COMMON(name,					       \
+				  handle_index,				       \
+				  MOCK_SOURCE,				       \
+				  mock_source_ctx,			       \
+				  return_type,				       \
+				  RETURN,				       \
+				  param_types...)			       \
+		return_type name(PARAM_LIST_FROM_TYPES(param_types))	       \
+		{							       \
+			struct mock *mock = MOCK_SOURCE(mock_source_ctx,       \
+							handle_index);	       \
+			static const char * const param_type_names[] = {       \
+				TYPE_NAMES_FROM_TYPES(handle_index,	       \
+						      param_types)	       \
+			};						       \
+			const void *params[] = {			       \
+				PTR_TO_ARG_FROM_TYPES(handle_index,	       \
+						      param_types)	       \
+			};						       \
+			const void *retval;				       \
+									       \
+			retval = mock->do_expect(mock,			       \
+						 #name,			       \
+						 name,			       \
+						 param_type_names,	       \
+						 params,		       \
+						 ARRAY_SIZE(params));	       \
+			TEST_ASSERT_NOT_ERR_OR_NULL(mock->test, retval);       \
+			if (!retval) {					       \
+				test_info(mock->test,			       \
+					  "no action installed for "#name);    \
+				BUG();					       \
+			}						       \
+			RETURN(return_type, retval);			       \
+		}
+
+#define CLASS_MOCK_CLIENT_SOURCE(ctx, handle_index) ctx(arg##handle_index)
+#define DEFINE_MOCK_METHOD_CLIENT_COMMON(name,				       \
+					 handle_index,			       \
+					 mock_converter,		       \
+					 return_type,			       \
+					 RETURN,			       \
+					 param_types...)		       \
+		DEFINE_MOCK_CLIENT_COMMON(name,				       \
+					  handle_index,			       \
+					  CLASS_MOCK_CLIENT_SOURCE,	       \
+					  mock_converter,		       \
+					  return_type,			       \
+					  RETURN,			       \
+					  param_types)
+
+#define CAST_AND_RETURN(return_type, retval) return *((return_type *) retval)
+#define NO_RETURN(return_type, retval)
+
+#define DEFINE_MOCK_METHOD_CLIENT(name,					       \
+				  handle_index,				       \
+				  mock_converter,			       \
+				  return_type,				       \
+				  param_types...)			       \
+		DEFINE_MOCK_METHOD_CLIENT_COMMON(name,			       \
+						 handle_index,		       \
+						 mock_converter,	       \
+						 return_type,		       \
+						 CAST_AND_RETURN,	       \
+						 param_types)
+
+#define DEFINE_MOCK_METHOD_CLIENT_VOID_RETURN(name,			       \
+					      handle_index,		       \
+					      mock_converter,		       \
+					      param_types...)		       \
+		DEFINE_MOCK_METHOD_CLIENT_COMMON(name,			       \
+						 handle_index,		       \
+						 mock_converter,	       \
+						 void,			       \
+						 NO_RETURN,		       \
+						 param_types)
+
+#define DEFINE_MOCK_MASTER_COMMON_INTERNAL(name,			       \
+					   ctrl_index,			       \
+					   MOCK_SOURCE,			       \
+					   param_types...)		       \
+		struct mock_expectation *mock_master_##name(		       \
+				MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index,      \
+							      param_types))    \
+		{ \
+			struct mock_param_matcher *matchers[] = {	       \
+				ARG_NAMES_FROM_TYPES(ctrl_index, param_types)  \
+			};						       \
+									       \
+			return mock_add_matcher(MOCK_SOURCE(ctrl_index),       \
+						#name,			       \
+						(const void *) name,	       \
+						matchers,		       \
+						ARRAY_SIZE(matchers));	       \
+		}
+#define DEFINE_MOCK_MASTER_COMMON(name,					       \
+				  ctrl_index,				       \
+				  MOCK_SOURCE,				       \
+				  param_types...)			       \
+		DEFINE_MOCK_MASTER_COMMON_INTERNAL(name,		       \
+						   ctrl_index,		       \
+						   MOCK_SOURCE,		       \
+						   param_types)
+
+#define CLASS_MOCK_MASTER_SOURCE(ctrl_index) arg##ctrl_index
+#define DEFINE_MOCK_METHOD_MASTER(name, ctrl_index, param_types...)	       \
+		DEFINE_MOCK_MASTER_COMMON(name,				       \
+					  ctrl_index,			       \
+					  CLASS_MOCK_MASTER_SOURCE,	       \
+					  param_types)
+
+#define DEFINE_MOCK_COMMON(name,					       \
+			   handle_index,				       \
+			   mock_converter,				       \
+			   return_type,					       \
+			   param_types...)				       \
+		DEFINE_MOCK_METHOD_CLIENT(name,				       \
+					  handle_index,			       \
+					  mock_converter,		       \
+					  return_type,			       \
+					  param_types);			       \
+		DEFINE_MOCK_METHOD_MASTER(name, handle_index, param_types)
+
+#define DEFINE_MOCK_COMMON_VOID_RETURN(name,				       \
+				       handle_index,			       \
+				       mock_converter,			       \
+				       param_types...)			       \
+		DEFINE_MOCK_METHOD_CLIENT_VOID_RETURN(name,		       \
+						      handle_index,	       \
+						      mock_converter,	       \
+						      param_types);	       \
+		DEFINE_MOCK_METHOD_MASTER(name, handle_index, param_types)
+
+#define DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,		       \
+						       struct_name,	       \
+						       handle_index,	       \
+						       return_type,	       \
+						       param_types...)	       \
+		DEFINE_MOCK_COMMON(name,				       \
+				   handle_index,			       \
+				   from_##struct_name##_to_mock,	       \
+				   return_type, param_types)
+#define DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,			       \
+					      struct_name,		       \
+					      handle_index,		       \
+					      return_type,		       \
+					      param_types...)		       \
+		DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,	       \
+							       struct_name,    \
+							       handle_index,   \
+							       return_type,    \
+							       param_types)
+
+#define DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_VOID_RETURN_INTERNAL(	       \
+		name,							       \
+		struct_name,						       \
+		handle_index,						       \
+		param_types...)						       \
+		DEFINE_MOCK_COMMON_VOID_RETURN(name,			       \
+					       handle_index,		       \
+					       from_##struct_name##_to_mock,   \
+					       param_types)
+#define DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_VOID_RETURN(name,		       \
+							  struct_name,	       \
+							  handle_index,	       \
+							  param_types...)      \
+		DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_VOID_RETURN_INTERNAL(    \
+				name,					       \
+				struct_name,				       \
+				handle_index,				       \
+				param_types)
+
+/**
+ * DEFINE_STRUCT_CLASS_MOCK()
+ * @name: name of the method
+ * @struct_name: name of the class of which the method belongs
+ * @return_type: return type of the method to be created. **Must not be void.**
+ * @param_types: parameters to method to be created.
+ *
+ * See TEST_EXPECT_CALL() for example usage.
+ */
+#define DEFINE_STRUCT_CLASS_MOCK(name,					       \
+				 struct_name,				       \
+				 return_type,				       \
+				 param_types...)			       \
+		DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,		       \
+						      struct_name,	       \
+						      0,		       \
+						      return_type,	       \
+						      param_types)
+
+/**
+ * DEFINE_STRUCT_CLASS_MOCK_VOID_RETURN()
+ * @name: name of the method
+ * @struct_name: name of the class of which the method belongs
+ * @param_types: parameters to method to be created.
+ *
+ * Same as DEFINE_STRUCT_CLASS_MOCK() except the method has a ``void`` return
+ * type.
+ */
+#define DEFINE_STRUCT_CLASS_MOCK_VOID_RETURN(name, struct_name, param_types...)\
+		DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_VOID_RETURN(name,	       \
+								  struct_name, \
+								  0,	       \
+								  param_types)
+
+/**
+ * DEFINE_STRUCT_CLASS_MOCK_INIT()
+ * @struct_name: name of the class
+ * @init_func: a function of type ``int (*)(struct MOCK(struct_name) *)``. This
+ *             function is passed a pointer to an allocated, *but not
+ *             initialized*, ``struct MOCK(struct_name)``. The job of this user
+ *             provided function is to perform remaining initialization. Usually
+ *             this entails assigning mock methods to the function pointers in
+ *             the parent struct.
+ *
+ * See TEST_EXPECT_CALL() for example usage.
+ */
+#define DEFINE_STRUCT_CLASS_MOCK_INIT(struct_name, init_func)		       \
+		struct MOCK(struct_name) *MOCK_INIT_ID(struct_name)(	       \
+				struct test *test)			       \
+		{							       \
+			struct MOCK(struct_name) *mock_obj;		       \
+									       \
+			mock_obj = test_kzalloc(test,			       \
+						sizeof(*mock_obj),	       \
+						GFP_KERNEL);		       \
+			if (!mock_obj)					       \
+				return NULL;				       \
+									       \
+			mock_init_ctrl(test, mock_get_ctrl(mock_obj));	       \
+									       \
+			if (init_func(mock_obj))			       \
+				return NULL;				       \
+									       \
+			return mock_obj;				       \
+		}
+
 #define CONVERT_TO_ACTUAL_TYPE(type, ptr) (*((type *) ptr))
 
 /**
  * DOC: Built In Matchers
  *
  * These are the matchers that can be used when matching arguments in
- * :c:func:`EXPECT_CALL` (more can be defined manually).
+ * :c:func:`TEST_EXPECT_CALL` (more can be defined manually).
  *
  * For example, there's a matcher that matches any arguments:
  *
diff --git a/kunit/Makefile b/kunit/Makefile
index 52a1da46cbd21..6fccfcdbc6f84 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_KUNIT)		+= test.o mock.o common-mocks.o string-stream.o \
   test-stream.o
 obj-$(CONFIG_KUNIT_TEST)		+= \
-  test-test.o mock-macro-test.o string-stream-test.o
+  test-test.o test-mock.o mock-macro-test.o mock-test.o string-stream-test.o
 obj-$(CONFIG_EXAMPLE_TEST)	+= example-test.o
diff --git a/kunit/example-test.c b/kunit/example-test.c
index e9bd2b41c5fd2..dd3b75a61d5b4 100644
--- a/kunit/example-test.c
+++ b/kunit/example-test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/mock.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -29,6 +30,84 @@ static void example_simple_test(struct test *test)
 	TEST_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+/*
+ * A lot of times, you have a C-style class like this, which acts an abstraction
+ * over hardware, a file system implementation, or some other subsystem that you
+ * want to reason about in a generic way.
+ */
+struct example {
+	int (*foo)(struct example *example, int num);
+};
+
+static int example_bar(struct example *example, int num)
+{
+	return example->foo(example, num);
+}
+
+/*
+ * KUnit allows such a class to be "mocked out" with the following:
+ */
+
+/*
+ * This macro creates a mock subclass of the specified class.
+ */
+DECLARE_STRUCT_CLASS_MOCK_PREREQS(example);
+
+/*
+ * This macro creates a mock implementation of the specified method of the
+ * specified class.
+ */
+DEFINE_STRUCT_CLASS_MOCK(METHOD(foo), CLASS(example),
+			 RETURNS(int),
+			 PARAMS(struct example *, int));
+
+/*
+ * This tells KUnit how to initialize the parts of the mock that come from the
+ * parent. In this example, all we have to do is populate the member functions
+ * of the parent class with the mock versions we defined.
+ */
+static int example_init(struct MOCK(example) *mock_example)
+{
+	/* This is how you get a pointer to the parent class of a mock. */
+	struct example *example = mock_get_trgt(mock_example);
+
+	/*
+	 * Here we populate the member function (method) with our mock method.
+	 */
+	example->foo = foo;
+	return 0;
+}
+
+/*
+ * This registers our parent init function above, allowing KUnit to create a
+ * constructor for the mock.
+ */
+DEFINE_STRUCT_CLASS_MOCK_INIT(example, example_init);
+
+/*
+ * This is a test case where we use our mock.
+ */
+static void example_mock_test(struct test *test)
+{
+	struct MOCK(example) *mock_example = test->priv;
+	struct example *example = mock_get_trgt(mock_example);
+	struct mock_expectation *handle;
+
+	/*
+	 * Here we make an expectation that our mock method will be called with
+	 * a parameter equal to 5 passed in.
+	 */
+	handle = TEST_EXPECT_CALL(foo(mock_get_ctrl(mock_example),
+				      test_int_eq(test, 5)));
+	/*
+	 * We specify that when our mock is called in this way, we want it to
+	 * return 2.
+	 */
+	handle->action = test_int_return(test, 2);
+
+	TEST_EXPECT_EQ(test, 2, example_bar(example, 5));
+}
+
 /*
  * This is run once before each test case, see the comment on
  * example_test_module for more information.
@@ -37,6 +116,16 @@ static int example_test_init(struct test *test)
 {
 	test_info(test, "initializing");
 
+	/*
+	 * Here we construct the mock and store it in test's `priv` field; this
+	 * field is for KUnit users. You can put whatever you want here, but
+	 * most often it is a place that the init function can put stuff to be
+	 * used by test cases.
+	 */
+	test->priv = CONSTRUCT_MOCK(example, test);
+	if (!test->priv)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -52,6 +141,7 @@ static struct test_case example_test_cases[] = {
 	 * test module.
 	 */
 	TEST_CASE(example_simple_test),
+	TEST_CASE(example_mock_test),
 	{},
 };
 
diff --git a/kunit/mock-macro-test.c b/kunit/mock-macro-test.c
index c30b859ff2b14..84d9d3f484366 100644
--- a/kunit/mock-macro-test.c
+++ b/kunit/mock-macro-test.c
@@ -8,6 +8,49 @@
 
 #include <kunit/test.h>
 #include <kunit/params.h>
+#include <kunit/mock.h>
+
+struct test_struct {
+	int (*one_param)(struct test_struct *test_struct);
+	int (*two_param)(struct test_struct *test_struct, int num);
+	int (*non_first_slot_param)(int num, struct test_struct *test_struct);
+	void *(*void_ptr_return)(struct test_struct *test_struct);
+};
+
+DECLARE_STRUCT_CLASS_MOCK_PREREQS(test_struct);
+
+DEFINE_STRUCT_CLASS_MOCK(METHOD(one_param), CLASS(test_struct),
+			 RETURNS(int),
+			 PARAMS(struct test_struct *));
+
+DEFINE_STRUCT_CLASS_MOCK(METHOD(two_param), CLASS(test_struct),
+			 RETURNS(int),
+			 PARAMS(struct test_struct *, int));
+
+DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX(METHOD(non_first_slot_param),
+			 CLASS(test_struct), HANDLE_INDEX(1),
+			 RETURNS(int),
+			 PARAMS(int, struct test_struct *));
+
+DEFINE_STRUCT_CLASS_MOCK(METHOD(void_ptr_return), CLASS(test_struct),
+			 RETURNS(void *),
+			 PARAMS(struct test_struct *));
+
+static int test_struct_init(struct MOCK(test_struct) *mock_test_struct)
+{
+	struct test_struct *test_struct = mock_get_trgt(mock_test_struct);
+
+	test_struct->one_param = one_param;
+	test_struct->two_param = two_param;
+	test_struct->non_first_slot_param = non_first_slot_param;
+	return 0;
+}
+
+DEFINE_STRUCT_CLASS_MOCK_INIT(test_struct, test_struct_init);
+
+struct mock_macro_context {
+	struct MOCK(test_struct) *mock_test_struct;
+};
 
 #define TO_STR_INTERNAL(...) #__VA_ARGS__
 #define TO_STR(...) TO_STR_INTERNAL(__VA_ARGS__)
@@ -131,6 +174,43 @@ static void mock_macro_arg_names_from_types(struct test *test)
 						      type15)));
 }
 
+static void mock_macro_test_generated_method_code_works(struct test *test)
+{
+	struct mock_macro_context *ctx = test->priv;
+	struct MOCK(test_struct) *mock_test_struct = ctx->mock_test_struct;
+	struct test_struct *test_struct = mock_get_trgt(mock_test_struct);
+	struct mock_expectation *handle;
+
+	handle = TEST_EXPECT_CALL(one_param(mock_get_ctrl(mock_test_struct)));
+	handle->action = test_int_return(test, 0);
+	handle = TEST_EXPECT_CALL(two_param(mock_get_ctrl(mock_test_struct),
+					    test_int_eq(test, 5)));
+	handle->action = test_int_return(test, 1);
+	handle = TEST_EXPECT_CALL(non_first_slot_param(
+			test_int_eq(test, 5), mock_get_ctrl(mock_test_struct)));
+	handle->action = test_int_return(test, 1);
+
+	test_struct->one_param(test_struct);
+	test_struct->two_param(test_struct, 5);
+	test_struct->non_first_slot_param(5, test_struct);
+}
+
+static int mock_macro_test_init(struct test *test)
+{
+	struct mock_macro_context *ctx;
+
+	ctx = test_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ctx->mock_test_struct = CONSTRUCT_MOCK(test_struct, test);
+	if (!ctx->mock_test_struct)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct test_case mock_macro_test_cases[] = {
 	TEST_CASE(mock_macro_is_equal),
 	TEST_CASE(mock_macro_if),
@@ -139,11 +219,13 @@ static struct test_case mock_macro_test_cases[] = {
 	TEST_CASE(mock_macro_for_each_param),
 	TEST_CASE(mock_macro_param_list_from_types_basic),
 	TEST_CASE(mock_macro_arg_names_from_types),
+	TEST_CASE(mock_macro_test_generated_method_code_works),
 	{},
 };
 
 static struct test_module mock_macro_test_module = {
 	.name = "mock-macro-test",
+	.init = mock_macro_test_init,
 	.test_cases = mock_macro_test_cases,
 };
 module_test(mock_macro_test_module);
diff --git a/kunit/mock-test.c b/kunit/mock-test.c
new file mode 100644
index 0000000000000..523ddee8f24e2
--- /dev/null
+++ b/kunit/mock-test.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for mock.h.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/mock.h>
+
+#include "test-mock.h"
+
+struct mock_test_context {
+	struct MOCK(test)	*mock_test;
+	struct mock		*mock;
+};
+
+static void mock_test_do_expect_basic(struct test *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct MOCK(test) *mock_test = ctx->mock_test;
+	struct test *trgt = mock_get_trgt(mock_test);
+	struct mock *mock = ctx->mock;
+	int param0 = 5, param1 = -4;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *matchers_any_two[] = {
+		test_any(trgt), test_any(trgt)
+	};
+	struct mock_expectation *expectation;
+	const void *ret;
+
+	expectation = mock_add_matcher(mock,
+				       "",
+				       NULL,
+				       matchers_any_two,
+				       ARRAY_SIZE(matchers_any_two));
+	expectation->action = test_int_return(trgt, 5);
+	TEST_EXPECT_EQ(test, 0, expectation->times_called);
+
+	ret = mock->do_expect(mock,
+			      "",
+			      NULL,
+			      two_param_types,
+			      two_params,
+			      ARRAY_SIZE(two_params));
+	TEST_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	TEST_EXPECT_EQ(test, 5, *((int *) ret));
+	TEST_EXPECT_EQ(test, 1, expectation->times_called);
+}
+
+static void mock_test_ptr_eq(struct test *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct MOCK(test) *mock_test = ctx->mock_test;
+	struct test *trgt = mock_get_trgt(mock_test);
+	struct mock *mock = ctx->mock;
+	void *param0 = ctx, *param1 = trgt;
+	static const char * const two_param_types[] = {"void *", "void *"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *matchers_two_ptrs[] = {
+		test_ptr_eq(trgt, param0), test_ptr_eq(trgt, param1)
+	};
+	struct mock_expectation *expectation;
+	const void *ret;
+
+	expectation = mock_add_matcher(mock,
+				       "",
+				       NULL,
+				       matchers_two_ptrs,
+				       ARRAY_SIZE(matchers_two_ptrs));
+	expectation->action = test_int_return(trgt, 0);
+	TEST_EXPECT_EQ(test, 0, expectation->times_called);
+
+	ret = mock->do_expect(mock,
+			      "",
+			      NULL,
+			      two_param_types,
+			      two_params,
+			      ARRAY_SIZE(two_params));
+	TEST_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	TEST_EXPECT_EQ(test, 1, expectation->times_called);
+}
+
+static void mock_test_ptr_eq_not_equal(struct test *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct MOCK(test) *mock_test = ctx->mock_test;
+	struct test *trgt = mock_get_trgt(mock_test);
+	struct mock *mock = ctx->mock;
+	void *param0 = ctx, *param1 = trgt;
+	static const char * const two_param_types[] = {"void *", "void *"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *matchers_two_ptrs[] = {
+		test_ptr_eq(trgt, param0), test_ptr_eq(trgt, param1 - 1)
+	};
+	struct mock_expectation *expectation;
+	const void *ret;
+
+	expectation = mock_add_matcher(mock,
+				       "",
+				       NULL,
+				       matchers_two_ptrs,
+				       ARRAY_SIZE(matchers_two_ptrs));
+	expectation->action = test_int_return(trgt, 0);
+	TEST_EXPECT_EQ(test, 0, expectation->times_called);
+
+	ret = mock->do_expect(mock,
+			      "",
+			      NULL,
+			      two_param_types,
+			      two_params,
+			      ARRAY_SIZE(two_params));
+	TEST_EXPECT_FALSE(test, ret);
+	TEST_EXPECT_EQ(test, 0, expectation->times_called);
+}
+
+/*
+ * In order for us to be able to rely on TEST_EXPECT_CALL to validate other
+ * behavior, we need to test that unsatisfied TEST_EXPECT_CALL causes a test
+ * failure.
+ */
+static void mock_test_failed_expect_call_fails_test(struct test *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct MOCK(test) *mock_test = ctx->mock_test;
+	struct mock *mock = ctx->mock;
+
+	/* mock is a pretend mock belonging to our mocked_test */
+
+	/* Put an expectation on mocked mock */
+	TEST_EXPECT_CALL(fail(mock, test_any(mock_get_trgt(mock_test))));
+
+	/*
+	 * Expect that mock_test will fail because the above won't be satisfied
+	 */
+	TEST_EXPECT_CALL(fail(mock_get_ctrl(mock_test), test_any(test)));
+
+	/*
+	 * Validate expectations of mocked mock, which should fail mocked test
+	 */
+	mock_validate_expectations(mock);
+
+	/* Validate mock_test's expectations, that is, it should have failed */
+	mock_validate_expectations(mock_get_ctrl(mock_test));
+	TEST_EXPECT_FALSE(test, mock_get_trgt(mock_test)->success);
+}
+
+static void mock_test_do_expect_default_return(struct test *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct MOCK(test) *mock_test = ctx->mock_test;
+	struct test *trgt = mock_get_trgt(mock_test);
+	struct mock *mock = ctx->mock;
+	int param0 = 5, param1 = -5;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *matchers[] = {
+		test_int_eq(trgt, 5),
+		test_int_eq(trgt, -4)
+	};
+	struct mock_expectation *expectation;
+	const void *ret;
+
+	expectation = mock_add_matcher(mock,
+				       "test_printk",
+				       test_printk,
+				       matchers,
+				       ARRAY_SIZE(matchers));
+	expectation->action = test_int_return(trgt, 5);
+	TEST_EXPECT_EQ(test, 0, expectation->times_called);
+
+	TEST_EXPECT_FALSE(test, mock_set_default_action(mock,
+						   "test_printk",
+						   test_printk,
+						   test_int_return(trgt, -4)));
+
+	ret = mock->do_expect(mock,
+			      "test_printk",
+			      test_printk,
+			      two_param_types,
+			      two_params,
+			      ARRAY_SIZE(two_params));
+	TEST_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	TEST_EXPECT_EQ(test, -4, *((int *) ret));
+	TEST_EXPECT_EQ(test, 0, expectation->times_called);
+}
+
+static void mock_test_mock_validate_expectations(struct test *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct MOCK(test) *mock_test = ctx->mock_test;
+	struct test *trgt = mock_get_trgt(mock_test);
+	struct mock *mock = ctx->mock;
+	struct mock_param_matcher *matchers[] = {
+		test_int_eq(trgt, 5),
+		test_int_eq(trgt, -4)
+	};
+	struct mock_expectation *expectation;
+
+	TEST_EXPECT_EQ(test, mock_get_trgt(mock_test), mock->test);
+
+	expectation = mock_add_matcher(mock,
+				       "test_printk",
+				       test_printk,
+				       matchers,
+				       ARRAY_SIZE(matchers));
+	expectation->times_called = 0;
+	expectation->min_calls_expected = 1;
+	expectation->max_calls_expected = 1;
+
+	TEST_EXPECT_CALL(fail(mock_get_ctrl(mock_test), test_any(test)));
+
+	mock_validate_expectations(mock);
+}
+
+void *do_mocked_fail(struct mock_action *this, const void **params, int len)
+{
+	static const int ret;
+	struct test_stream * const *stream_ptr = params[0];
+	struct test_stream *stream = *stream_ptr;
+
+	stream->set_level(stream, KERN_ERR);
+	stream->commit(stream);
+	return (void *) &ret;
+}
+
+static struct mock_action mocked_fail = {
+	.do_action = do_mocked_fail
+};
+
+static int mock_test_init(struct test *test)
+{
+	struct mock_test_context *ctx;
+
+	ctx = test_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ctx->mock_test = CONSTRUCT_MOCK(test, test);
+	if (!ctx->mock_test)
+		return -EINVAL;
+
+	ctx->mock = test_kzalloc(test, sizeof(*ctx->mock), GFP_KERNEL);
+	if (!ctx->mock)
+		return -ENOMEM;
+	mock_init_ctrl(mock_get_trgt(ctx->mock_test), ctx->mock);
+
+	/* This test suite tests the behaviour of the error messages printed
+	 * when mocks fail, which requires the mocked fail to commit the
+	 * stream.
+	 */
+	mock_set_default_action(mock_get_ctrl(ctx->mock_test),
+		"fail", fail, &mocked_fail);
+	return 0;
+}
+
+static struct test_case mock_test_cases[] = {
+	TEST_CASE(mock_test_do_expect_basic),
+	TEST_CASE(mock_test_ptr_eq),
+	TEST_CASE(mock_test_ptr_eq_not_equal),
+	TEST_CASE(mock_test_failed_expect_call_fails_test),
+	TEST_CASE(mock_test_do_expect_default_return),
+	TEST_CASE(mock_test_mock_validate_expectations),
+	{},
+};
+
+static struct test_module mock_test_module = {
+	.name = "mock-test",
+	.init = mock_test_init,
+	.test_cases = mock_test_cases,
+};
+
+module_test(mock_test_module);
diff --git a/kunit/test-mock.c b/kunit/test-mock.c
new file mode 100644
index 0000000000000..a0858d6b3f9c1
--- /dev/null
+++ b/kunit/test-mock.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit mock for struct test.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include "test-mock.h"
+
+DEFINE_STRUCT_CLASS_MOCK_VOID_RETURN(METHOD(fail), CLASS(test),
+				     PARAMS(struct test *,
+					    struct test_stream *));
+
+DEFINE_STRUCT_CLASS_MOCK_VOID_RETURN(METHOD(mock_vprintk), CLASS(test),
+				     PARAMS(const struct test *,
+					    const char *,
+					    struct va_format *));
+
+static int test_init(struct MOCK(test) *mock_test)
+{
+	struct test *trgt = mock_get_trgt(mock_test);
+	int ret;
+
+	ret = test_init_test(trgt, "MOCK(test)");
+	trgt->fail = fail;
+	mock_set_default_action(mock_get_ctrl(mock_test),
+				"fail",
+				fail,
+				test_int_return(mock_get_test(mock_test), 0));
+	trgt->vprintk = mock_vprintk;
+	mock_set_default_action(mock_get_ctrl(mock_test),
+				"mock_vprintk",
+				mock_vprintk,
+				test_int_return(mock_get_test(mock_test), 0));
+	return ret;
+}
+
+DEFINE_STRUCT_CLASS_MOCK_INIT(test, test_init);
diff --git a/kunit/test-mock.h b/kunit/test-mock.h
new file mode 100644
index 0000000000000..c57e9384b1d8a
--- /dev/null
+++ b/kunit/test-mock.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit mock for struct test.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/mock.h>
+
+DECLARE_STRUCT_CLASS_MOCK_PREREQS(test);
+
+DECLARE_STRUCT_CLASS_MOCK_VOID_RETURN(METHOD(fail), CLASS(test),
+				      PARAMS(struct test *,
+					     struct test_stream *));
+
+DECLARE_STRUCT_CLASS_MOCK_VOID_RETURN(METHOD(mock_vprintk), CLASS(test),
+				      PARAMS(const struct test *,
+					     const char *,
+					     struct va_format *));
+
+DECLARE_STRUCT_CLASS_MOCK_INIT(test);
-- 
2.19.1.331.ge82ca0e54c-goog

