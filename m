Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA587C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63945214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8sUC5H0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63945214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJQHr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:26 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:39638 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeJQHrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:25 -0400
Received: by mail-it1-f201.google.com with SMTP id h62-v6so258963itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JQQypJJAnP+qflEUqHeoEbsw+NOpA25x72IRPpWFfJA=;
        b=S8sUC5H0lz/9D9UvlvG5pDq8orOH5Gw7jK5Rn1lGsaYiVb8o+UYMu0DYMc40ewW3OG
         AfFWdGKpnlA53/s7mR+yqgKCmp4SA9qjvuQfZjRGqqw7T4qkGmC5VP+ViGez9hSx/4xu
         XtdqiAerQCxKR/Npt6f3+wTvILEVLuF2Uqpdz00GxYige47tiD9WIDSe/HJPU54FPqYT
         d5fQ0IAUGLMAqp6cGP1j+4+UemlZPAruB4NcPwC11cH/DrPipLKusIK2I7M+2Y9M30CS
         b9IjhWWSfhuG/o3uVuYgkefYl25nnW6nytosnUypbP7LsCWaJFOT4TC2OykloUkQd6mq
         j9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JQQypJJAnP+qflEUqHeoEbsw+NOpA25x72IRPpWFfJA=;
        b=i8lyN7HGLJR+mKWgicSiTctoPwLSkMOlPb2VZNWo7ILHzWb3LBsRa3tmm9ZRCWqxA6
         /ZqR3hIoSNIrm0oT61/xnUkHn7hmXfRM6GQFPnxmUEl5stmt62TCo/dYGx27H/ZtcZ/D
         x2dtv0k7d/3JD9/DAuh8vuQqQFjvtpLJFCmBU6itLfld2uA+a6AjITJ+DXl4rdHXDqh5
         fqAgtobZjhVKoYn/6dsXWcK9xsL0CLXRTfZPSggaX5jZRNQ9NyN34WLcspRaoj8Rx0zQ
         j50/Gu8oGt3jGitPffI1upWoDqhCh1VRpiswFr+SL4E+5m4UXCGmKOuubsN0bkGyJpXm
         OqjQ==
X-Gm-Message-State: ABuFfohj+9060VYakYlomeMmk/zrUHfmqsQBR9MfmSyqecmV7qluUALP
        DQ4bm6ZwCoZu46rq2Lv/C9mUHTu2VzBx0CFY/B0/rg==
X-Google-Smtp-Source: ACcGV62N4dkBvqEoT4+RYlijGYh5xVfbd4JDN4WJS0sm/H+cbP/iw13mEIJbg0zbO8CYJ23NyxKgn74atOFhtcnRDz826g==
X-Received: by 2002:a24:7f05:: with SMTP id r5-v6mr17839290itc.2.1539734075686;
 Tue, 16 Oct 2018 16:54:35 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:09 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-21-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 20/31] kunit: mock: add ability to mock functions with void context
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

Adds ability to mock functions with a void* context object.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/mock.h    | 53 +++++++++++++++++++++++++++++++++++++++++
 kunit/mock-macro-test.c | 30 +++++++++++++++++++++++
 kunit/mock.c            |  9 +++++++
 3 files changed, 92 insertions(+)

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index 8d155b27a257a..89e95b3fcf09e 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -381,6 +381,24 @@ static inline bool is_naggy_mock(struct mock *mock)
 		struct MOCK(struct_name) *MOCK_INIT_ID(struct_name)(	       \
 				struct test *test)
 
+#define DECLARE_VOID_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,		       \
+						      handle_index,	       \
+						      return_type,	       \
+						      param_types...)	       \
+		DECLARE_MOCK_COMMON(name,				       \
+				    handle_index,			       \
+				    return_type,			       \
+				    param_types)
+
+#define DECLARE_VOID_CLASS_MOCK_HANDLE_INDEX(name,			       \
+					     handle_index,		       \
+					     return_type,		       \
+					     param_types...)		       \
+		DECLARE_VOID_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,	       \
+							      handle_index,    \
+							      return_type,     \
+							      param_types)
+
 /**
  * CONSTRUCT_MOCK()
  * @struct_name: name of the class
@@ -631,6 +649,41 @@ static inline bool is_naggy_mock(struct mock *mock)
 			return mock_obj;				       \
 		}
 
+struct MOCK(void) {
+	struct mock	ctrl;
+	void		*trgt;
+};
+
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdiscarded-qualifiers"
+static inline struct mock *from_void_ptr_to_mock(const void *ptr)
+{
+	struct MOCK(void) *mock_void_ptr = ptr;
+
+	return mock_get_ctrl(mock_void_ptr);
+}
+#pragma GCC diagnostic pop
+
+#define DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,		       \
+						     handle_index,	       \
+						     return_type,	       \
+						     param_types...)	       \
+		DEFINE_MOCK_COMMON(name,				       \
+				   handle_index,			       \
+				   from_void_ptr_to_mock,		       \
+				   return_type,				       \
+				   param_types)
+#define DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX(name,			       \
+					    handle_index,		       \
+					    return_type,		       \
+					    param_types...)		       \
+		DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,	       \
+							     handle_index,     \
+							     return_type,      \
+							     param_types)
+
+DECLARE_STRUCT_CLASS_MOCK_INIT(void);
+
 #define CONVERT_TO_ACTUAL_TYPE(type, ptr) (*((type *) ptr))
 
 /**
diff --git a/kunit/mock-macro-test.c b/kunit/mock-macro-test.c
index 84d9d3f484366..0f95105ec032a 100644
--- a/kunit/mock-macro-test.c
+++ b/kunit/mock-macro-test.c
@@ -48,8 +48,19 @@ static int test_struct_init(struct MOCK(test_struct) *mock_test_struct)
 
 DEFINE_STRUCT_CLASS_MOCK_INIT(test_struct, test_struct_init);
 
+DECLARE_VOID_CLASS_MOCK_HANDLE_INDEX(METHOD(test_void_ptr_func),
+				     HANDLE_INDEX(0),
+				     RETURNS(int),
+				     PARAMS(void*, int));
+
+DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX(METHOD(test_void_ptr_func),
+				    HANDLE_INDEX(0),
+				    RETURNS(int),
+				    PARAMS(void*, int));
+
 struct mock_macro_context {
 	struct MOCK(test_struct) *mock_test_struct;
+	struct MOCK(void) *mock_void_ptr;
 };
 
 #define TO_STR_INTERNAL(...) #__VA_ARGS__
@@ -195,6 +206,20 @@ static void mock_macro_test_generated_method_code_works(struct test *test)
 	test_struct->non_first_slot_param(5, test_struct);
 }
 
+static void mock_macro_test_generated_method_void_code_works(struct test *test)
+{
+	struct mock_macro_context *ctx = test->priv;
+	struct MOCK(void) *mock_void_ptr = ctx->mock_void_ptr;
+	struct mock_expectation *handle;
+
+	handle = TEST_EXPECT_CALL(test_void_ptr_func(
+			mock_get_ctrl(mock_void_ptr),
+			test_int_eq(test, 3)));
+	handle->action = test_int_return(test, 0);
+
+	test_void_ptr_func(mock_void_ptr, 3);
+}
+
 static int mock_macro_test_init(struct test *test)
 {
 	struct mock_macro_context *ctx;
@@ -208,6 +233,10 @@ static int mock_macro_test_init(struct test *test)
 	if (!ctx->mock_test_struct)
 		return -EINVAL;
 
+	ctx->mock_void_ptr = CONSTRUCT_MOCK(void, test);
+	if (!ctx->mock_void_ptr)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -220,6 +249,7 @@ static struct test_case mock_macro_test_cases[] = {
 	TEST_CASE(mock_macro_param_list_from_types_basic),
 	TEST_CASE(mock_macro_arg_names_from_types),
 	TEST_CASE(mock_macro_test_generated_method_code_works),
+	TEST_CASE(mock_macro_test_generated_method_void_code_works),
 	{},
 };
 
diff --git a/kunit/mock.c b/kunit/mock.c
index 314cebb54e236..7a9fcf6ae4a55 100644
--- a/kunit/mock.c
+++ b/kunit/mock.c
@@ -8,6 +8,15 @@
 
 #include <kunit/mock.h>
 
+static int mock_void_ptr_init(struct MOCK(void) *mock_void_ptr)
+{
+	mock_void_ptr->trgt = mock_void_ptr;
+
+	return 0;
+}
+
+DEFINE_STRUCT_CLASS_MOCK_INIT(void, mock_void_ptr_init);
+
 static bool mock_match_params(struct mock_matcher *matcher,
 		       struct test_stream *stream,
 		       const void **params,
-- 
2.19.1.331.ge82ca0e54c-goog

