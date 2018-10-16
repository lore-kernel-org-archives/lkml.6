Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E66C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2BA2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9kdliPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2BA2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJQHrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:11 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:40873 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJQHrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:10 -0400
Received: by mail-io1-f73.google.com with SMTP id p22-v6so22733902ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2nQLxz37HjUkuxUdygmRZnfP5MQCOlygPN6h14eHwdw=;
        b=B9kdliPtLkssRcDNBO20RpbwwI987uXusttn+Q36tcmnUTC7qDFs3Yo/15XuSDIcUh
         JD2McpsO2rXUn+6He3Subar9wT3HYpzhEC+bCE5ot9wvISC5vxgBy6X9sIEF7Mbz1kCZ
         qq6dB+bLtKFiQuVU6IMAvLYq808mPvEm/+x82/m7nT3GUJeuiCKUk+vEYyi3hEFGwqPS
         sZr84Hwtb3hVFyER/iiWkkmDYq1QUrhKE73wvtePsg1OAp1VjHpk//vPUJ+7l7X8x48Z
         Pu8QykfuIHC/zNb9GTm5VZowq1JL2mMTMv5WjPJAcQJGUF13s0cTxVMK5IVLXgeXiGJ2
         Jo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2nQLxz37HjUkuxUdygmRZnfP5MQCOlygPN6h14eHwdw=;
        b=nKICYv9ctmPRzZfbOWHCwupKevbmL/17/Pl7RZ+jJlrncMvYZx8szxb0ZmWThLL3aZ
         88PwKnImwLBwHIisLzKi5dc6Zw27CqqZTJuVITN4QVl7DI7bS/KrSils5DAYoLXhf/x5
         xYmepeXDvCzdTNJDPMm5DLpfQ0qkg3UcC3fiabLiDIVVymhklTwm9j+Wq0MOMYZ7W4Kb
         V5gv7yNlP3HMUFccazVKzZgvGLHEp20oMKAWRO9szSAJLmEC5jExc6IAbV6C82WVKo+x
         Iwms73jDugBB62s11m/98YSbyvcRf73enc4e5ygE0RjeajLPdzeMywOlJcyIoTF5/XCt
         vJgA==
X-Gm-Message-State: ABuFfogpOdck/drsXZpyCKSJqR+0rNf8Vda2Xpp3EWrKCJTrpL/9GGrR
        X+aNIGfgKb8LVPHcD+hYYh0qaNw8/i8fde5vp8rdxQ==
X-Google-Smtp-Source: ACcGV62LSCvUVvKuQcKAzN7Zy7BphoHPZ6h3wkJ7rRKFgGJjkjCaPIHSivbsxMPzvUQJ2xCUfWyjfRwMQGlX3sis4gFhgA==
X-Received: by 2002:a24:3949:: with SMTP id l70-v6mr221173ita.6.1539734061067;
 Tue, 16 Oct 2018 16:54:21 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:03 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 14/31] kunit: mock: added internal mock infrastructure
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

Adds the core internal mechanisms that mocks are implemented with; in
particular, this adds the mechanisms by which expectation on mocks are
validated and by which actions may be supplied and then executed when
mocks are called.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/mock.h | 125 +++++++++++++++
 kunit/Makefile       |   5 +-
 kunit/mock.c         | 359 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 487 insertions(+), 2 deletions(-)
 create mode 100644 include/kunit/mock.h
 create mode 100644 kunit/mock.c

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
new file mode 100644
index 0000000000000..1a35c5702cb15
--- /dev/null
+++ b/include/kunit/mock.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mocking API for KUnit.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_MOCK_H
+#define _KUNIT_MOCK_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h> /* For PARAMS(...) */
+#include <kunit/test.h>
+#include <kunit/test-stream.h>
+#include <kunit/params.h>
+
+/**
+ * struct mock_param_matcher - represents a matcher used in a *call expectation*
+ * @match: the function that performs the matching
+ *
+ * The matching function takes a couple of parameters:
+ *
+ * - ``this``: refers to the parent struct
+ * - ``stream``: a &test_stream to which a detailed message should be added as
+ *   to why the parameter matches or not
+ * - ``param``: a pointer to the parameter to check for a match
+ *
+ * The matching function should return whether or not the passed parameter
+ * matches.
+ */
+struct mock_param_matcher {
+	bool (*match)(struct mock_param_matcher *this,
+		      struct test_stream *stream,
+		      const void *param);
+};
+
+#define MOCK_MAX_PARAMS 255
+
+struct mock_matcher {
+	struct mock_param_matcher *matchers[MOCK_MAX_PARAMS];
+	int num;
+};
+
+/**
+ * struct mock_action - Represents an action that a mock performs when
+ *                      expectation is matched
+ * @do_action: the action to perform
+ *
+ * The action function is given some parameters:
+ *
+ * - ``this``: refers to the parent struct
+ * - ``params``: an array of pointers to the params passed into the mocked
+ *   method or function. **The class argument is excluded for a mocked class
+ *   method.**
+ * - ``len``: size of ``params``
+ *
+ * The action function returns a pointer to the value that the mocked method
+ * or function should be returning.
+ */
+struct mock_action {
+	void *(*do_action)(struct mock_action *this,
+			   const void **params,
+			   int len);
+};
+
+/**
+ * struct mock_expectation - represents a *call expectation* on a function.
+ * @action: A &struct mock_action to perform when the function is called.
+ * @max_calls_expected: maximum number of times an expectation may be called.
+ * @min_calls_expected: minimum number of times an expectation may be called.
+ * @retire_on_saturation: no longer match once ``max_calls_expected`` is
+ *			  reached.
+ *
+ * Represents a *call expectation* on a function created with EXPECT_CALL().
+ */
+struct mock_expectation {
+	struct mock_action *action;
+	int max_calls_expected;
+	int min_calls_expected;
+	bool retire_on_saturation;
+	/* private: internal use only. */
+	const char *expectation_name;
+	struct list_head node;
+	struct mock_matcher *matcher;
+	int times_called;
+};
+
+struct mock_method {
+	struct list_head node;
+	const char *method_name;
+	const void *method_ptr;
+	struct mock_action *default_action;
+	struct list_head expectations;
+};
+
+struct mock {
+	struct test_post_condition parent;
+	struct test *test;
+	struct list_head methods;
+	/* TODO(brendanhiggins@google.com): add locking to do_expect. */
+	const void *(*do_expect)(struct mock *mock,
+				 const char *method_name,
+				 const void *method_ptr,
+				 const char * const *param_types,
+				 const void **params,
+				 int len);
+};
+
+void mock_init_ctrl(struct test *test, struct mock *mock);
+
+void mock_validate_expectations(struct mock *mock);
+
+int mock_set_default_action(struct mock *mock,
+			    const char *method_name,
+			    const void *method_ptr,
+			    struct mock_action *action);
+
+struct mock_expectation *mock_add_matcher(struct mock *mock,
+					  const char *method_name,
+					  const void *method_ptr,
+					  struct mock_param_matcher *matchers[],
+					  int len);
+
+#endif /* _KUNIT_MOCK_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index f72a02cb9f23d..ad58110de695c 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,3 +1,4 @@
-obj-$(CONFIG_KUNIT)		+= test.o string-stream.o test-stream.o
-obj-$(CONFIG_KUNIT_TEST)		+= test-test.o mock-macro-test.o string-stream-test.o
+obj-$(CONFIG_KUNIT)		+= test.o mock.o string-stream.o test-stream.o
+obj-$(CONFIG_KUNIT_TEST)		+= \
+  test-test.o mock-macro-test.o string-stream-test.o
 obj-$(CONFIG_EXAMPLE_TEST)	+= example-test.o
diff --git a/kunit/mock.c b/kunit/mock.c
new file mode 100644
index 0000000000000..424c612de553b
--- /dev/null
+++ b/kunit/mock.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mocking API for KUnit.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/mock.h>
+
+static bool mock_match_params(struct mock_matcher *matcher,
+		       struct test_stream *stream,
+		       const void **params,
+		       int len)
+{
+	struct mock_param_matcher *param_matcher;
+	bool ret = true, tmp;
+	int i;
+
+	BUG_ON(matcher->num != len);
+
+	for (i = 0; i < matcher->num; i++) {
+		param_matcher = matcher->matchers[i];
+		stream->add(stream, "\t");
+		tmp = param_matcher->match(param_matcher, stream, params[i]);
+		ret = ret && tmp;
+		stream->add(stream, "\n");
+	}
+
+	return ret;
+}
+
+static const void *mock_do_expect(struct mock *mock,
+				  const char *method_name,
+				  const void *method_ptr,
+				  const char * const *type_names,
+				  const void **params,
+				  int len);
+
+void mock_validate_expectations(struct mock *mock)
+{
+	struct mock_expectation *expectation, *expectation_safe;
+	struct mock_method *method;
+	struct test_stream *stream;
+	int times_called;
+
+	stream = test_new_stream(mock->test);
+	list_for_each_entry(method, &mock->methods, node) {
+		list_for_each_entry_safe(expectation, expectation_safe,
+					 &method->expectations, node) {
+			times_called = expectation->times_called;
+			if (!(expectation->min_calls_expected <= times_called &&
+			      times_called <= expectation->max_calls_expected)
+			    ) {
+				stream->add(stream,
+					    "Expectation was not called the specified number of times:\n\t");
+				stream->add(stream,
+					    "Function: %s, min calls: %d, max calls: %d, actual calls: %d",
+					    method->method_name,
+					    expectation->min_calls_expected,
+					    expectation->max_calls_expected,
+					    times_called);
+				mock->test->fail(mock->test, stream);
+			}
+			list_del(&expectation->node);
+		}
+	}
+}
+
+static void mock_validate_wrapper(struct test_post_condition *condition)
+{
+	struct mock *mock = container_of(condition, struct mock, parent);
+
+	mock_validate_expectations(mock);
+}
+
+void mock_init_ctrl(struct test *test, struct mock *mock)
+{
+	mock->test = test;
+	INIT_LIST_HEAD(&mock->methods);
+	mock->do_expect = mock_do_expect;
+	mock->parent.validate = mock_validate_wrapper;
+	list_add_tail(&mock->parent.node, &test->post_conditions);
+}
+
+static struct mock_method *mock_lookup_method(struct mock *mock,
+					      const void *method_ptr)
+{
+	struct mock_method *ret;
+
+	list_for_each_entry(ret, &mock->methods, node) {
+		if (ret->method_ptr == method_ptr)
+			return ret;
+	}
+
+	return NULL;
+}
+
+static struct mock_method *mock_add_method(struct mock *mock,
+					   const char *method_name,
+					   const void *method_ptr)
+{
+	struct mock_method *method;
+
+	method = test_kzalloc(mock->test, sizeof(*method), GFP_KERNEL);
+	if (!method)
+		return NULL;
+
+	INIT_LIST_HEAD(&method->expectations);
+	method->method_name = method_name;
+	method->method_ptr = method_ptr;
+	list_add_tail(&method->node, &mock->methods);
+
+	return method;
+}
+
+static int mock_add_expectation(struct mock *mock,
+				const char *method_name,
+				const void *method_ptr,
+				struct mock_expectation *expectation)
+{
+	struct mock_method *method;
+
+	method = mock_lookup_method(mock, method_ptr);
+	if (!method) {
+		method = mock_add_method(mock, method_name, method_ptr);
+		if (!method)
+			return -ENOMEM;
+	}
+
+	list_add_tail(&expectation->node, &method->expectations);
+
+	return 0;
+}
+
+struct mock_expectation *mock_add_matcher(struct mock *mock,
+					  const char *method_name,
+					  const void *method_ptr,
+					  struct mock_param_matcher *matchers[],
+					  int len)
+{
+	struct mock_expectation *expectation;
+	struct mock_matcher *matcher;
+	int ret;
+
+	expectation = test_kzalloc(mock->test,
+				   sizeof(*expectation),
+				   GFP_KERNEL);
+	if (!expectation)
+		return NULL;
+
+	matcher = test_kmalloc(mock->test, sizeof(*matcher), GFP_KERNEL);
+	if (!matcher)
+		return NULL;
+
+	memcpy(&matcher->matchers, matchers, sizeof(*matchers) * len);
+	matcher->num = len;
+
+	expectation->matcher = matcher;
+	expectation->max_calls_expected = 1;
+	expectation->min_calls_expected = 1;
+
+	ret = mock_add_expectation(mock, method_name, method_ptr, expectation);
+	if (ret < 0)
+		return NULL;
+
+	return expectation;
+}
+
+int mock_set_default_action(struct mock *mock,
+			    const char *method_name,
+			    const void *method_ptr,
+			    struct mock_action *action)
+{
+	struct mock_method *method;
+
+	method = mock_lookup_method(mock, method_ptr);
+	if (!method) {
+		method = mock_add_method(mock, method_name, method_ptr);
+		if (!method)
+			return -ENOMEM;
+	}
+
+	method->default_action = action;
+
+	return 0;
+}
+
+static void mock_format_param(struct test_stream *stream,
+			      const char *type_name,
+			      const void *param)
+{
+	/*
+	 * Cannot find formatter, so just print the pointer of the
+	 * symbol.
+	 */
+	stream->add(stream, "<%pS>", param);
+}
+
+static void mock_add_method_declaration_to_stream(
+		struct test_stream *stream,
+		const char *function_name,
+		const char * const *type_names,
+		const void **params,
+		int len)
+{
+	int i;
+
+	stream->add(stream, "%s(", function_name);
+	for (i = 0; i < len; i++) {
+		mock_format_param(stream, type_names[i], params[i]);
+		if (i < len - 1)
+			stream->add(stream, ", ");
+	}
+	stream->add(stream, ")\n");
+}
+
+static struct test_stream *mock_initialize_failure_message(
+		struct test *test,
+		const char *function_name,
+		const char * const *type_names,
+		const void **params,
+		int len)
+{
+	struct test_stream *stream;
+
+	stream = test_new_stream(test);
+	if (!stream)
+		return NULL;
+
+	stream->add(stream, "EXPECTATION FAILED: no expectation for call: ");
+	mock_add_method_declaration_to_stream(stream,
+					      function_name,
+					      type_names,
+					      params,
+					      len);
+	return stream;
+}
+
+static bool mock_is_expectation_retired(struct mock_expectation *expectation)
+{
+	return expectation->retire_on_saturation &&
+			expectation->times_called ==
+			expectation->max_calls_expected;
+}
+
+static void mock_add_method_expectation_error(struct test *test,
+					      struct test_stream *stream,
+					      char *message,
+					      struct mock *mock,
+					      struct mock_method *method,
+					      const char * const *type_names,
+					      const void **params,
+					      int len)
+{
+	stream->clear(stream);
+	stream->set_level(stream, KERN_WARNING);
+	stream->add(stream, message);
+	mock_add_method_declaration_to_stream(stream,
+		method->method_name, type_names, params, len);
+}
+
+static struct mock_expectation *mock_apply_expectations(
+		struct mock *mock,
+		struct mock_method *method,
+		const char * const *type_names,
+		const void **params,
+		int len)
+{
+	struct test *test = mock->test;
+	struct mock_expectation *ret;
+	struct test_stream *attempted_matching_stream;
+	bool expectations_all_saturated = true;
+
+	struct test_stream *stream = test_new_stream(test);
+
+	if (list_empty(&method->expectations)) {
+		mock_add_method_expectation_error(test, stream,
+			"Method was called with no expectations declared: ",
+			mock, method, type_names, params, len);
+		stream->commit(stream);
+		return NULL;
+	}
+
+	attempted_matching_stream = mock_initialize_failure_message(
+			test,
+			method->method_name,
+			type_names,
+			params,
+			len);
+
+	list_for_each_entry(ret, &method->expectations, node) {
+		if (mock_is_expectation_retired(ret))
+			continue;
+		expectations_all_saturated = false;
+
+		attempted_matching_stream->add(attempted_matching_stream,
+			"Tried expectation: %s, but\n", ret->expectation_name);
+		if (mock_match_params(ret->matcher,
+			attempted_matching_stream, params, len)) {
+			/*
+			 * Matcher was found; we won't print, so clean up the
+			 * log.
+			 */
+			attempted_matching_stream->clear(
+					attempted_matching_stream);
+			return ret;
+		}
+	}
+
+	if (expectations_all_saturated) {
+		mock_add_method_expectation_error(test, stream,
+			"Method was called with fully saturated expectations: ",
+			mock, method, type_names, params, len);
+	} else {
+		mock_add_method_expectation_error(test, stream,
+			"Method called that did not match any expectations: ",
+			mock, method, type_names, params, len);
+		stream->append(stream, attempted_matching_stream);
+	}
+	test->fail(test, stream);
+	attempted_matching_stream->clear(attempted_matching_stream);
+	return NULL;
+}
+
+static const void *mock_do_expect(struct mock *mock,
+				  const char *method_name,
+				  const void *method_ptr,
+				  const char * const *param_types,
+				  const void **params,
+				  int len)
+{
+	struct mock_expectation *expectation;
+	struct mock_method *method;
+	struct mock_action *action;
+
+	method = mock_lookup_method(mock, method_ptr);
+	if (!method)
+		return NULL;
+
+	expectation = mock_apply_expectations(mock,
+					      method,
+					      param_types,
+					      params,
+					      len);
+	if (!expectation) {
+		action = method->default_action;
+	} else {
+		expectation->times_called++;
+		if (expectation->action)
+			action = expectation->action;
+		else
+			action = method->default_action;
+	}
+	if (!action)
+		return NULL;
+
+	return action->do_action(action, params, len);
+}
-- 
2.19.1.331.ge82ca0e54c-goog

