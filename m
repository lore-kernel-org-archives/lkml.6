Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB86C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A3E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ob6JecNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A3E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeK2Gkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:40:40 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:45579 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbeK2Gki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:40:38 -0500
Received: by mail-ot1-f74.google.com with SMTP id s12so12385701otc.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kYyv/RTHzJjGNg9RbFN3NZsq45WeoGrJwFQsspAHU+g=;
        b=Ob6JecNpave3zhvIzALx2WdTG2Xf/wGlI/aOCikKVn7jzvpI2ltvh23barswRa5c14
         3tqzjK0a9Vpy6Zbhov5vaM+si1RPqBkT/9MgrerDKynQXSQzUxuznSJSHNPUNyHZT48H
         59hgN9IqUhaCcN9V18TPDmKbCQ5vEQqLm6tNYBGrgtT9a1KCVXvHLEazCzr/yUXaJttV
         cl7gzvJIN/tCmINTta3CLCiYXRylhaU6LSgdi+Lfvphl7XAdvF6sS19eKGA0Z2iVRRwz
         VOgxRJFZc/EFRhs7HF2PqZRVu9yzsTNA6j8cbGWZz5o4izuKO5PcRWTp5xKeBioj4jzC
         KBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kYyv/RTHzJjGNg9RbFN3NZsq45WeoGrJwFQsspAHU+g=;
        b=WfRwt6LfxQh3pWDbwpXxUrDiHzcoMiTvmf7Hg5Cp1XwPIPqSnZJKvlqRDZVHqSVoJa
         nSHUJDiFH+4oV0JQb3CegcQf7pf3HtmktXQQU3gtKZcU66tIlPEgFZyH9N+BWngn3+8J
         j+kMC7kaRhBGYdE2E9neRIJnsV2o9aSAOZhL6QnuZI8Mmk69rlwej1tZ3zwGvtAf5XM4
         C4Jaqm68QhkxA9+I2ZlFEZwgvKlPJR+lZhxipRmi7gtxVnJM/B1gLZV7s8J/Zz9lYUOj
         jzW4LYBqBQn0+2v25i7AkmcEbjvCx6o25G9bPUSp36+W6Oyu3fJCUnbDo2ZZOQVN9MWc
         Apdw==
X-Gm-Message-State: AA+aEWa1GtOepeenaYIoPooj3M2pNyjptdYhdlZkC04wzDrZqSWjGTP7
        0KBORvovaWo1ZleEKeo9RP3jsRB6V14TUDWCkAcUWQ==
X-Google-Smtp-Source: AFSGD/VmjDGXZv/Qf9wHBL015DQW6wWAWy/xIyPqNqjwxASmV1d+01uM7VvOaizuli4IdMjUSTMMhsj0NyLNeOs4RvhTsw==
X-Received: by 2002:aca:c255:: with SMTP id s82-v6mr4424965oif.50.1543433873527;
 Wed, 28 Nov 2018 11:37:53 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:21 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 04/19] kunit: test: add test_stream a std::stream like logger
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
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of the expectation and assertion infrastructure prints out fairly
complicated test failure messages, so add a C++ style log library for
for logging test results.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/kunit-stream.h |  50 ++++++++++++
 include/kunit/test.h         |   2 +
 kunit/Makefile               |   3 +-
 kunit/kunit-stream.c         | 153 +++++++++++++++++++++++++++++++++++
 kunit/test.c                 |   8 ++
 5 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/kunit-stream.h
 create mode 100644 kunit/kunit-stream.c

diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
new file mode 100644
index 0000000000000..3b3119450be3f
--- /dev/null
+++ b/include/kunit/kunit-stream.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_KUNIT_STREAM_H
+#define _KUNIT_KUNIT_STREAM_H
+
+#include <linux/types.h>
+#include <kunit/string-stream.h>
+
+struct kunit;
+
+/**
+ * struct kunit_stream - a std::stream style string builder.
+ * @set_level: sets the level that this string should be printed at.
+ * @add: adds the formatted input to the internal buffer.
+ * @append: adds the contents of other to this.
+ * @commit: prints out the internal buffer to the user.
+ * @clear: clears the internal buffer.
+ *
+ * A std::stream style string builder. Allows messages to be built up and
+ * printed all at once.
+ */
+struct kunit_stream {
+	void (*set_level)(struct kunit_stream *this, const char *level);
+	void (*add)(struct kunit_stream *this, const char *fmt, ...);
+	void (*append)(struct kunit_stream *this, struct kunit_stream *other);
+	void (*commit)(struct kunit_stream *this);
+	void (*clear)(struct kunit_stream *this);
+	/* private: internal use only. */
+	struct kunit *test;
+	spinlock_t lock; /* Guards level. */
+	const char *level;
+	struct string_stream *internal_stream;
+};
+
+/**
+ * kunit_new_stream() - constructs a new &struct kunit_stream.
+ * @test: The test context object.
+ *
+ * Constructs a new test managed &struct kunit_stream.
+ */
+struct kunit_stream *kunit_new_stream(struct kunit *test);
+
+#endif /* _KUNIT_KUNIT_STREAM_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 583840e24ffda..ea424095e4fb4 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <kunit/kunit-stream.h>
 
 struct kunit_resource;
 
@@ -171,6 +172,7 @@ struct kunit {
 	void (*vprintk)(const struct kunit *test,
 			const char *level,
 			struct va_format *vaf);
+	void (*fail)(struct kunit *test, struct kunit_stream *stream);
 };
 
 int kunit_init_test(struct kunit *test, const char *name);
diff --git a/kunit/Makefile b/kunit/Makefile
index 275b565a0e81f..6ddc622ee6b1c 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
-					string-stream.o
+					string-stream.o \
+					kunit-stream.o
diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
new file mode 100644
index 0000000000000..70f5182245e0b
--- /dev/null
+++ b/kunit/kunit-stream.c
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
+#include <kunit/kunit-stream.h>
+#include <kunit/string-stream.h>
+
+static const char *kunit_stream_get_level(struct kunit_stream *this)
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
+static void kunit_stream_set_level(struct kunit_stream *this, const char *level)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	this->level = level;
+	spin_unlock_irqrestore(&this->lock, flags);
+}
+
+static void kunit_stream_add(struct kunit_stream *this, const char *fmt, ...)
+{
+	va_list args;
+	struct string_stream *stream = this->internal_stream;
+
+	va_start(args, fmt);
+	if (stream->vadd(stream, fmt, args) < 0)
+		kunit_err(this->test, "Failed to allocate fragment: %s", fmt);
+
+	va_end(args);
+}
+
+static void kunit_stream_append(struct kunit_stream *this,
+				struct kunit_stream *other)
+{
+	struct string_stream *other_stream = other->internal_stream;
+	const char *other_content;
+
+	other_content = other_stream->get_string(other_stream);
+
+	if (!other_content) {
+		kunit_err(this->test,
+			  "Failed to get string from second argument for appending.");
+		return;
+	}
+
+	this->add(this, other_content);
+}
+
+static void kunit_stream_clear(struct kunit_stream *this)
+{
+	this->internal_stream->clear(this->internal_stream);
+}
+
+static void kunit_stream_commit(struct kunit_stream *this)
+{
+	struct string_stream *stream = this->internal_stream;
+	struct string_stream_fragment *fragment;
+	const char *level;
+	char *buf;
+
+	level = kunit_stream_get_level(this);
+	if (!level) {
+		kunit_err(this->test,
+			  "Stream was committed without a specified log level.");
+		level = KERN_ERR;
+		this->set_level(this, level);
+	}
+
+	buf = stream->get_string(stream);
+	if (!buf) {
+		kunit_err(this->test,
+			 "Could not allocate buffer, dumping stream:");
+		list_for_each_entry(fragment, &stream->fragments, node) {
+			kunit_err(this->test, fragment->fragment);
+		}
+		goto cleanup;
+	}
+
+	kunit_printk(level, this->test, buf);
+	kfree(buf);
+
+cleanup:
+	this->clear(this);
+}
+
+static int kunit_stream_init(struct kunit_resource *res, void *context)
+{
+	struct kunit *test = context;
+	struct kunit_stream *stream;
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
+	stream->set_level = kunit_stream_set_level;
+	stream->add = kunit_stream_add;
+	stream->append = kunit_stream_append;
+	stream->commit = kunit_stream_commit;
+	stream->clear = kunit_stream_clear;
+
+	return 0;
+}
+
+static void kunit_stream_free(struct kunit_resource *res)
+{
+	struct kunit_stream *stream = res->allocation;
+
+	if (!stream->internal_stream->is_empty(stream->internal_stream)) {
+		kunit_err(stream->test,
+			 "End of test case reached with uncommitted stream entries.");
+		stream->commit(stream);
+	}
+
+	destroy_string_stream(stream->internal_stream);
+	kfree(stream);
+}
+
+struct kunit_stream *kunit_new_stream(struct kunit *test)
+{
+	struct kunit_resource *res;
+
+	res = kunit_alloc_resource(test,
+				   kunit_stream_init,
+				   kunit_stream_free,
+				   test);
+
+	if (res)
+		return res->allocation;
+	else
+		return NULL;
+}
diff --git a/kunit/test.c b/kunit/test.c
index fb1a786e4c94f..abeb939dc7fa2 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -63,12 +63,20 @@ static void kunit_vprintk(const struct kunit *test,
 			  "kunit %s: %pV", test->name, vaf);
 }
 
+static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
+{
+	kunit_set_success(test, false);
+	stream->set_level(stream, KERN_ERR);
+	stream->commit(stream);
+}
+
 int kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->vprintk = kunit_vprintk;
+	test->fail = kunit_fail;
 
 	return 0;
 }
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

