Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F2DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22411205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv7Sy98Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22411205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeK2Gkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:40:37 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:38640 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbeK2Gkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:40:36 -0500
Received: by mail-it1-f202.google.com with SMTP id m128so1715465itd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xfxjf+CSXWbmb3vEodnCAywAKpdNOSt3qX2Z15+pCtI=;
        b=Fv7Sy98Q8RFjZMHxwG7JynC7AcGNeOGek9vQeCpHnDobT29qNccUYR96dj0+VIllkk
         ZQhjsll+dUALguLu/laCF6LE969tx0gKGzf0JAFf4CI40FwXWZ+HjwBSXCqSfKqwGppQ
         6Lj3d5gDH309ilY5/hgd4ovu9kebLsNg+VP/a9Vrt6dwJ9KNR/sK86w/X0hWI1iZS2AV
         YqSnyKsoKRBpm3zqxVFfxo5fRlpKZsOIiTiMdho1WJdiZ9ZJ5/G7qTzuHeiFRFuh2vuI
         hYJ5xjiLZ6wW+JzvdMDA28X22ehvu140pEPenelrp0nE0iWgmPdcNAktu/Ze3B2ewb71
         oQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xfxjf+CSXWbmb3vEodnCAywAKpdNOSt3qX2Z15+pCtI=;
        b=Zzqt/kNik865000/0tmj0lJMa2GwoRWYqvkVbbIXJpGsg+MVcVzD5GjNajX1ha6nSm
         odUW+zh+LnS216zcKJwQAf3a2/1FINk1EcryqDHZ7ypGWrNQy6/6ZyvvKQjkn0NkOM21
         R4bNDLouodcYbOzwEqN7d5cIyqPdznge8BXNeuZqCsvgtonGPSWFSYNjAYpo+fkHIh3i
         jq12J7u5s6UMTDUWoG0zXO4HSz0NJw9sPvKfsCkyRHr1j74MegbJ/U6Gycfs4ZwJ0NOx
         DiZZbZqQPPT1U/vvN4H6TOxdLkrsTOfimbp4i6zpeLxpMav0tLnpdxAKOJ2e/3uMn3oU
         mqBQ==
X-Gm-Message-State: AA+aEWZsAnACQxWf0Ck3aD4cUIVxephNhLGKt5exs36u9u61vDw8ZZG/
        2J5YCHr8idc4i9JPy4Z/bNfRmW4t81xDqdh1Isdw4A==
X-Google-Smtp-Source: AFSGD/WXZbOijT965825ZIr9pOufHnotkvLuF1R50wIHqrUjKPJrZ6JJcjxQfQjkhabysTq8H+f5AJfYosxEeUhlF5Vbxw==
X-Received: by 2002:a24:4ac4:: with SMTP id k187mr3369102itb.8.1543433871194;
 Wed, 28 Nov 2018 11:37:51 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:20 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 03/19] kunit: test: add string_stream a std::stream like
 string builder
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

A number of test features need to do pretty complicated string printing
where it may not be possible to rely on a single preallocated string
with parameters.

So provide a library for constructing the string as you go similar to
C++'s std::string.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/string-stream.h |  44 ++++++++++
 kunit/Makefile                |   3 +-
 kunit/string-stream.c         | 149 ++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 kunit/string-stream.c

diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
new file mode 100644
index 0000000000000..933ed5740cf07
--- /dev/null
+++ b/include/kunit/string-stream.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_STRING_STREAM_H
+#define _KUNIT_STRING_STREAM_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/kref.h>
+#include <stdarg.h>
+
+struct string_stream_fragment {
+	struct list_head node;
+	char *fragment;
+};
+
+struct string_stream {
+	size_t length;
+	struct list_head fragments;
+
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+	struct kref refcount;
+	int (*add)(struct string_stream *this, const char *fmt, ...);
+	int (*vadd)(struct string_stream *this, const char *fmt, va_list args);
+	char *(*get_string)(struct string_stream *this);
+	void (*clear)(struct string_stream *this);
+	bool (*is_empty)(struct string_stream *this);
+};
+
+struct string_stream *new_string_stream(void);
+
+void destroy_string_stream(struct string_stream *stream);
+
+void string_stream_get(struct string_stream *stream);
+
+int string_stream_put(struct string_stream *stream);
+
+#endif /* _KUNIT_STRING_STREAM_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index 5efdc4dea2c08..275b565a0e81f 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1,2 @@
-obj-$(CONFIG_KUNIT) +=			test.o
+obj-$(CONFIG_KUNIT) +=			test.o \
+					string-stream.o
diff --git a/kunit/string-stream.c b/kunit/string-stream.c
new file mode 100644
index 0000000000000..1e7efa630cc35
--- /dev/null
+++ b/kunit/string-stream.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <kunit/string-stream.h>
+
+static int string_stream_vadd(struct string_stream *this,
+			       const char *fmt,
+			       va_list args)
+{
+	struct string_stream_fragment *fragment;
+	int len;
+	va_list args_for_counting;
+	unsigned long flags;
+
+	/* Make a copy because `vsnprintf` could change it */
+	va_copy(args_for_counting, args);
+
+	/* Need space for null byte. */
+	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
+
+	va_end(args_for_counting);
+
+	fragment = kmalloc(sizeof(*fragment), GFP_KERNEL);
+	if (!fragment)
+		return -ENOMEM;
+
+	fragment->fragment = kmalloc(len, GFP_KERNEL);
+	if (!fragment->fragment) {
+		kfree(fragment);
+		return -ENOMEM;
+	}
+
+	len = vsnprintf(fragment->fragment, len, fmt, args);
+	spin_lock_irqsave(&this->lock, flags);
+	this->length += len;
+	list_add_tail(&fragment->node, &this->fragments);
+	spin_unlock_irqrestore(&this->lock, flags);
+	return 0;
+}
+
+static int string_stream_add(struct string_stream *this, const char *fmt, ...)
+{
+	va_list args;
+	int result;
+
+	va_start(args, fmt);
+	result = string_stream_vadd(this, fmt, args);
+	va_end(args);
+	return result;
+}
+
+static void string_stream_clear(struct string_stream *this)
+{
+	struct string_stream_fragment *fragment, *fragment_safe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	list_for_each_entry_safe(fragment,
+				 fragment_safe,
+				 &this->fragments,
+				 node) {
+		list_del(&fragment->node);
+		kfree(fragment->fragment);
+		kfree(fragment);
+	}
+	this->length = 0;
+	spin_unlock_irqrestore(&this->lock, flags);
+}
+
+static char *string_stream_get_string(struct string_stream *this)
+{
+	struct string_stream_fragment *fragment;
+	size_t buf_len = this->length + 1; /* +1 for null byte. */
+	char *buf;
+	unsigned long flags;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	spin_lock_irqsave(&this->lock, flags);
+	list_for_each_entry(fragment, &this->fragments, node)
+		strlcat(buf, fragment->fragment, buf_len);
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return buf;
+}
+
+static bool string_stream_is_empty(struct string_stream *this)
+{
+	bool is_empty;
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	is_empty = list_empty(&this->fragments);
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return is_empty;
+}
+
+void destroy_string_stream(struct string_stream *stream)
+{
+	stream->clear(stream);
+	kfree(stream);
+}
+
+static void string_stream_destroy(struct kref *kref)
+{
+	struct string_stream *stream = container_of(kref,
+						    struct string_stream,
+						    refcount);
+	destroy_string_stream(stream);
+}
+
+struct string_stream *new_string_stream(void)
+{
+	struct string_stream *stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+
+	if (!stream)
+		return NULL;
+
+	INIT_LIST_HEAD(&stream->fragments);
+	spin_lock_init(&stream->lock);
+	kref_init(&stream->refcount);
+	stream->add = string_stream_add;
+	stream->vadd = string_stream_vadd;
+	stream->get_string = string_stream_get_string;
+	stream->clear = string_stream_clear;
+	stream->is_empty = string_stream_is_empty;
+	return stream;
+}
+
+void string_stream_get(struct string_stream *stream)
+{
+	kref_get(&stream->refcount);
+}
+
+int string_stream_put(struct string_stream *stream)
+{
+	return kref_put(&stream->refcount, &string_stream_destroy);
+}
+
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

