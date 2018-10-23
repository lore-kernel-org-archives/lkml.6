Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F3C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8A82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWs7uz6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8A82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeJXLYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:24:32 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38614 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXLYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:24:31 -0400
Received: by mail-qk1-f202.google.com with SMTP id e189-v6so4049373qkf.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 19:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gy1z5IJ8lmZZLNQjD9BeGt7y/mUTpSE9tAcZ55XfP9c=;
        b=CWs7uz6jfvPMST7mWX3jWqnDzBLK+UFcEj7CZQzHZJjJjez+v1Piq15AuqyLvk3Uwe
         Lb3vVLFyCHOIFnVcvNiAXdX+ndtB793hPo+MxAe7pFcc+brB7QGPR36UL/zx2OuBbRTm
         tz2c1+XGHWMQo4A755CNhTtmZIMadmaLE62DOhHCaWdr0XOKR3sEuiqKGXrdB2n/TyyT
         zxwnDHhcactkITtjVDQKtlG8W3E/1OuqlyKElUeCgH89Wq7JSWXiQJzsLwQCXkDFZSwT
         PZumgW5mzf26Jp6kyRA9nJKWKjgkMxrSE0ur8ch7vUVYIH1ALG9O3mnarxFhAU+5w/L7
         5sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gy1z5IJ8lmZZLNQjD9BeGt7y/mUTpSE9tAcZ55XfP9c=;
        b=m3Q6mem+0OjN0nnaGx9MIeAmh+T9FB5JZXr/h5G+NIdGiES84hM2UVFPf0VdkxOLzP
         OQLkBrZckGbXRy8kmHG1hOubqFRGntkCuDj3Sfd1+lh7UqBDPQw8MWkqLOYEYycfvRUw
         8UloyRe5qVJ7V7TQCSeRZbSwib+Egc/mc05Urgksfyf4Shp+qruB/w4pnm4qujI0OM1Z
         vlpIia/uV2EQPpUZCPk6O7xQH9HFNWdsqj/8pDWvT8TsbIvRPlCGqsyBPjQNDe4H+ZxE
         dhDLYk20By38nYlPfRun+fBP6Wz4l7qYeT+2oktvDDCcNhZzQW77IUyKxNBDYfVO7S3r
         WxJw==
X-Gm-Message-State: AGRZ1gLyp3BVcattPEK/JpIJliz3Krkyma2tVMJltoOA+dhFEHWF1kiH
        CIVwCphlohDFp9MK3+A6A4s9RUDcSaQE1qmTnKrHHw==
X-Google-Smtp-Source: AJdET5fAIots2hhr31+tW6+sIGVN1XFOUKNnuC9zw1arMVS+dFmwGU+MzLTf2EvPEucobVjEO5QF8FAtz95wRdYOa1Pl/A==
X-Received: by 2002:a37:ba44:: with SMTP id k65-v6mr316792qkf.49.1540339185533;
 Tue, 23 Oct 2018 16:59:45 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:39 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 03/14] kunit: test: add string_stream a std::stream like
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
        kieran.bingham@ideasonboard.com,
        Brendan Higgins <brendanhiggins@google.com>
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
 kunit/Makefile                |   2 +-
 kunit/string-stream.c         | 149 ++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+), 1 deletion(-)
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
index dd7a0299514b7..7fc613a9b383b 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_KUNIT)		+= test.o
+obj-$(CONFIG_KUNIT)		+= test.o string-stream.o
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
2.19.1.568.g152ad8e336-goog

