Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A024CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5083D2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLTnLmeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5083D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJQHqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:47 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33190 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeJQHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:45 -0400
Received: by mail-yw1-f73.google.com with SMTP id f66-v6so15741143ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IGBYeiYpCY/8G3zSHyqqYAJpX70mNKHubWHsRN/Tq5c=;
        b=DLTnLmeHnpLH0JF8SkW3nbKgh9Sg210AkhRc6IKlOEVJN8mXJGvOaLWJH0d3DAsji7
         2V7f2ftM+attD9ElyBfEAzK1i4bKElAiX+QKHrDth9jQFvLOcfE4ldgxnZu66RPnrJox
         AePVjP6+otP/P00+F9edI3Lskh9pNaGHrsFEqdCK3wARUMA9s8cN5ECRwhSMAMf7K4YK
         wnDdO3wXaYJs+J4YkG5KmKXWvQIVSCRIIBGekSGF72nDsVlhOx0HHtpqzukzI5He0gq/
         oHTKJwx+CkqKcZINhugkcnjf3byhh+F+ZH9I7AIomu4YvNnbvWd3t9xY+k/zhiGA2uBd
         ehXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IGBYeiYpCY/8G3zSHyqqYAJpX70mNKHubWHsRN/Tq5c=;
        b=aH5yQcKmr2FsVUPVqOkz91YN5/n4NxG9hgm48++eP7MLywxCwrQmRiQMz3YN/a5AQD
         jj+UNNSG5HIZE9woD6eWyhFtsD/qAUK4swA6EiBJqoAMgeT5jL74bszu+DuPuI52v6JU
         wcXfvtiycnSWFM3zlQ+FoS5Ah1psHIQBqxikYGhho9a4y9vbB2n5FYt0QZLcrzz1w0TF
         T/TT9cZuZfqWWbrmXj0Cqckxu43gB61DjjHd+0RAh5gE+2Kjx0r5Uob6T7vtNU5p10HC
         kYDS18rDFypnvuHqnda5WCL9qNMcOcIZo/eMB4gCUdmJj+uheNb6KWLRkQRY2bTCGnnS
         PDbg==
X-Gm-Message-State: ABuFfojCih/KRY/nBuURbyrdhCv1Ap8f7WDkvYiTG0VM+ISSSn00UVee
        hk0s7yWrs7dMBheWGMd1aEqvPtu9d+D1KgCSXBM2vQ==
X-Google-Smtp-Source: ACcGV63J5rTOco7nLPJ1eo5y8XVI9nCTpZyMdVRbiYVu8yPY/WuefiE+LM1q6V/7vTNgZwEypiWyAszH5LhrvyRi9cp8jg==
X-Received: by 2002:a25:a091:: with SMTP id y17-v6mr14812433ybh.53.1539734035869;
 Tue, 16 Oct 2018 16:53:55 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:53 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 04/31] kunit: test: added test_stream a std::stream like logger
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

Adds a C++ style log library for for logging test results.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test-stream.h |  49 ++++++++++++
 include/kunit/test.h        |   2 +
 kunit/Makefile              |   2 +-
 kunit/test-stream.c         | 153 ++++++++++++++++++++++++++++++++++++
 kunit/test.c                |   8 ++
 5 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/test-stream.h
 create mode 100644 kunit/test-stream.c

diff --git a/include/kunit/test-stream.h b/include/kunit/test-stream.h
new file mode 100644
index 0000000000000..c5dfd95ef21bb
--- /dev/null
+++ b/include/kunit/test-stream.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TEST_STREAM_H
+#define _KUNIT_TEST_STREAM_H
+
+#include <linux/types.h>
+#include <kunit/string-stream.h>
+
+struct test;
+
+/**
+ * struct test_stream - a std::stream style string builder.
+ * @set_level: sets the level that this string should be printed at.
+ * @add: adds the formatted input to the internal buffer.
+ * @commit: prints out the internal buffer to the user.
+ * @clear: clears the internal buffer.
+ *
+ * A std::stream style string builder. Allows messages to be built up and
+ * printed all at once.
+ */
+struct test_stream {
+	void (*set_level)(struct test_stream *this, const char *level);
+	void (*add)(struct test_stream *this, const char *fmt, ...);
+	void (*append)(struct test_stream *this, struct test_stream *other);
+	void (*commit)(struct test_stream *this);
+	void (*clear)(struct test_stream *this);
+	/* private: internal use only. */
+	struct test *test;
+	spinlock_t lock; /* Guards level. */
+	const char *level;
+	struct string_stream *internal_stream;
+};
+
+/**
+ * test_new_stream() - constructs a new &struct test_stream.
+ * @test: The test context object.
+ *
+ * Constructs a new test managed &struct test_stream.
+ */
+struct test_stream *test_new_stream(struct test *test);
+
+#endif /* _KUNIT_TEST_STREAM_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 1c116a20063da..68320fa2452de 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <kunit/test-stream.h>
 
 struct test_resource;
 
@@ -171,6 +172,7 @@ struct test {
 	void (*vprintk)(const struct test *test,
 			const char *level,
 			struct va_format *vaf);
+	void (*fail)(struct test *test, struct test_stream *stream);
 };
 
 int test_init_test(struct test *test, const char *name);
diff --git a/kunit/Makefile b/kunit/Makefile
index 7fc613a9b383b..5b4562ea7f322 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_KUNIT)		+= test.o string-stream.o
+obj-$(CONFIG_KUNIT)		+= test.o string-stream.o test-stream.o
diff --git a/kunit/test-stream.c b/kunit/test-stream.c
new file mode 100644
index 0000000000000..392966864a708
--- /dev/null
+++ b/kunit/test-stream.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/test-stream.h>
+#include <kunit/string-stream.h>
+
+static const char *test_stream_get_level(struct test_stream *this)
+{
+	unsigned long flags;
+	const char *level;
+
+	spin_lock_irqsave(&this->lock, flags);
+	level = this->level;
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return level;
+}
+
+static void test_stream_set_level(struct test_stream *this, const char *level)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	this->level = level;
+	spin_unlock_irqrestore(&this->lock, flags);
+}
+
+static void test_stream_add(struct test_stream *this, const char *fmt, ...)
+{
+	va_list args;
+	struct string_stream *stream = this->internal_stream;
+
+	va_start(args, fmt);
+	if (stream->vadd(stream, fmt, args) < 0)
+		test_err(this->test, "Failed to allocate fragment: %s", fmt);
+
+	va_end(args);
+}
+
+static void test_stream_append(struct test_stream *this,
+			       struct test_stream *other)
+{
+	struct string_stream *other_stream = other->internal_stream;
+	const char *other_content;
+
+	other_content = other_stream->get_string(other_stream);
+
+	if (!other_content) {
+		test_err(this->test,
+			 "Failed to get string from second argument for appending.");
+		return;
+	}
+
+	this->add(this, other_content);
+}
+
+static void test_stream_clear(struct test_stream *this)
+{
+	this->internal_stream->clear(this->internal_stream);
+}
+
+static void test_stream_commit(struct test_stream *this)
+{
+	struct string_stream *stream = this->internal_stream;
+	struct string_stream_fragment *fragment;
+	const char *level;
+	char *buf;
+
+	level = test_stream_get_level(this);
+	if (!level) {
+		test_err(this->test,
+			 "Stream was committed without a specified log level.");
+		level = KERN_ERR;
+		this->set_level(this, level);
+	}
+
+	buf = stream->get_string(stream);
+	if (!buf) {
+		test_err(this->test,
+			 "Could not allocate buffer, dumping stream:");
+		list_for_each_entry(fragment, &stream->fragments, node) {
+			test_err(this->test, fragment->fragment);
+		}
+		goto cleanup;
+	}
+
+	test_printk(level, this->test, buf);
+	kfree(buf);
+
+cleanup:
+	this->clear(this);
+}
+
+static int test_stream_init(struct test_resource *res, void *context)
+{
+	struct test *test = context;
+	struct test_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+	res->allocation = stream;
+	stream->test = test;
+	spin_lock_init(&stream->lock);
+	stream->internal_stream = new_string_stream();
+
+	if (!stream->internal_stream)
+		return -ENOMEM;
+
+	stream->set_level = test_stream_set_level;
+	stream->add = test_stream_add;
+	stream->append = test_stream_append;
+	stream->commit = test_stream_commit;
+	stream->clear = test_stream_clear;
+
+	return 0;
+}
+
+static void test_stream_free(struct test_resource *res)
+{
+	struct test_stream *stream = res->allocation;
+
+	if (!stream->internal_stream->is_empty(stream->internal_stream)) {
+		test_err(stream->test,
+			 "End of test case reached with uncommitted stream entries.");
+		stream->commit(stream);
+	}
+
+	destroy_string_stream(stream->internal_stream);
+	kfree(stream);
+}
+
+struct test_stream *test_new_stream(struct test *test)
+{
+	struct test_resource *res;
+
+	res = test_alloc_resource(test,
+				  test_stream_init,
+				  test_stream_free,
+				  test);
+
+	if (res)
+		return res->allocation;
+	else
+		return NULL;
+}
diff --git a/kunit/test.c b/kunit/test.c
index fd0a51245215e..f798183533c8d 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -63,12 +63,20 @@ static void test_vprintk(const struct test *test,
 			 "kunit %s: %pV", test->name, vaf);
 }
 
+static void test_fail(struct test *test, struct test_stream *stream)
+{
+	test_set_success(test, false);
+	stream->set_level(stream, KERN_ERR);
+	stream->commit(stream);
+}
+
 int test_init_test(struct test *test, const char *name)
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->vprintk = test_vprintk;
+	test->fail = test_fail;
 
 	return 0;
 }
-- 
2.19.1.331.ge82ca0e54c-goog

