Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886F5C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429652087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahWh4KkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429652087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJQHqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:38 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:50310 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJQHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:38 -0400
Received: by mail-ua1-f73.google.com with SMTP id q3so2183140uao.17
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJsydBHJBHH2EKQc0vg9/d0tw0KtYquVOLVEuVx4f9A=;
        b=ahWh4KkXQtuYcu7CO92XtCDzry1BTlRTtfQGrykZ/KsFGJmgJP3gWTjYVgnB29L8UT
         zH2nf/kBBSG8sHFtkQ0p0w9BAv0hrT22lG8JE+8GmvdZpyht/muIo6uPGBcn65PgzXjL
         kCxfT1XMDyBk40JbCU398KycI5ege89JsGYgonlK6Se6Ft+sAWAfr5os86cHPj0eaOZ0
         ArIw8I9+9FHExxXdTRgQ1quIFT8XYxcAIvegKY/SSYBI05kJroegTnvc9bMsj/oticYS
         tZjaj1PpuSmIK8ZR6um2MRsMO6HeeUCAI+WIwHT2+yfjYELcLW3FGRTB8qKweqIx2f11
         gCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJsydBHJBHH2EKQc0vg9/d0tw0KtYquVOLVEuVx4f9A=;
        b=TrlWF4lc+tT4wI3u7ZJmoQoM2JMVQBZNIESC2q8iftFASpUi2/ASfjnIi06060RLIs
         s5wwPE4GJeHlJnSEGv8UJbcPe3LbZAoPa9QxW5M64cxSeBkFz2aJWk3CeBF2u4UiHtem
         99CXWyRbqCACt1Qy1t+WiuhA98jwjFCBRS1U0TVFKYj7oZnLVbR5x+LsQ6EDrXfQI2wH
         QvnqRrBtaRInrk3oVGXo8tZZP3xgGXkF6trJLlsRhe1ar/4pjNPqnq95z5VK8g77XPiI
         IkRHymLn8bRh/oGRSaBaEyFpSjee9qNRGE/ngdjFQBkShRQY6NgAsvYlht5Ga3I43tww
         sXWA==
X-Gm-Message-State: ABuFfojV2mxqYkULXIHkrmyI5pWvHkG+jH3zVOIobnzd4rmiqI/lia33
        l+68JSSO52o/78QNdYbXSsJQkwoAi6Zh1AuVJjbJSw==
X-Google-Smtp-Source: ACcGV626iFXh+sYRDn2tqPaZXBMHp7jmeuW/cFe896r88kpzZ7TnegCDwJzWKXnQAckRCYWcOiA4sPPYTsgsJZ0VbWeWzA==
X-Received: by 2002:a1f:3250:: with SMTP id y77mr10272981vky.4.1539734028287;
 Tue, 16 Oct 2018 16:53:48 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:50 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 01/31] kunit: test: added string_stream a std::stream like
 string builder
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

A number of test features need to do pretty complicated string printing
where it may not be possible to rely on a single preallocated string
with parameters.

This provides a library for constructing the string as you go similar to
C++'s std::string.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/string-stream.h |  44 ++++++++++
 kunit/Kconfig                 |  16 ++++
 kunit/Makefile                |   1 +
 kunit/string-stream.c         | 149 ++++++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 kunit/Kconfig
 create mode 100644 kunit/Makefile
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
diff --git a/kunit/Kconfig b/kunit/Kconfig
new file mode 100644
index 0000000000000..64480092b2c24
--- /dev/null
+++ b/kunit/Kconfig
@@ -0,0 +1,16 @@
+#
+# KUnit base configuration
+#
+
+menu "KUnit support"
+
+config KUNIT
+	bool "Enable support for unit tests (KUnit)"
+	help
+	  Enables support for kernel unit tests (KUnit), a lightweight unit
+	  testing and mocking framework for the Linux kernel. These tests are
+	  able to be run locally on a developer's workstation without a VM or
+	  special hardware. For more information, please see
+	  Documentation/kunit/
+
+endmenu
diff --git a/kunit/Makefile b/kunit/Makefile
new file mode 100644
index 0000000000000..de16cce9d6a27
--- /dev/null
+++ b/kunit/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_KUNIT)		+= string-stream.o
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
2.19.1.331.ge82ca0e54c-goog

