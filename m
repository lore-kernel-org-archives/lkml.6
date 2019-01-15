Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A9EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB6D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="YgkipiVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbfAOShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:37:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35272 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbfAOShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:37:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so1602661pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEAAb76ViC9oXS8v2jECn2lHCM2ryX3CjzwSUOCigfQ=;
        b=YgkipiVOnKLW5hG8prFuuEaQrBNy86WEHH33STDljDPUNcQGl2zfsVsXOiDziV39Zj
         D6rCSoBhUDZdYCjIlHSoValGZfh5AXLVEHlkPJzsljdZ+85dXVNLb1k31P7eaNdDVLpt
         cPKRFvC/N5he89SnGDjeybqPoz7bfS9G7EsIwYyigW8S/+ljPCNQDRZnR5aWb5TF3mx2
         ywc3Db6Mr784jvmye0YTM55Q+6hFnEfHPFOmpeAO620bgz8XEG/cYtrhpBdXAbRv2e2E
         mXuM6kHMvdH8uTpdoIT5v0bZ/4uprehUBjxQOD8HaYQJWB8mOPt2cyUBELX8BPmbgxQR
         ++VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEAAb76ViC9oXS8v2jECn2lHCM2ryX3CjzwSUOCigfQ=;
        b=l5Jud76fie05jvCHIi+jprkXGf0WApcW201K3NNl6MSbWZrE0W3//8Qoyf2tYFH8rD
         h2eSFy1pBhsvXoXwZmm+EZXtIQJ3KA0aNamOoJV6WNFSdJ5NHGxAPLczGtsjBf+A94Rq
         RpPgzYgcuoaIsHM/LTm0b9zGvTpval1f0lcY7EBiIUF3GQ/lYzSME1NzROyJAL1a64qn
         6VeFZh9CJCeW/NDKrrkg9CkFB86LeauV3pOFR7TOwzobJ60OWG12QyeNRhQmoGlIwdAV
         CKlFXC/kW2GOAf3NQyGZ8a6xH15rVW0aR6aCJwlPQUGhwyTX9WBMF7NAtnLLjN38K51p
         vwOg==
X-Gm-Message-State: AJcUuke/XU4oY5nsdC2Dy7ho9yY/m+4j9xCk3WINHhO84SdlvQdxB2Cp
        zoc1wl6S9Qe8ZYogZnJBMsRE6Q==
X-Google-Smtp-Source: ALg8bN5v4lDmuDkDOQom8xiEc3iylUylKrzfKneQNIeOmuAHgHPdVqyMK1pvqzEIh+AyxMB23HJVQg==
X-Received: by 2002:a62:5ec5:: with SMTP id s188mr5302806pfb.145.1547577434221;
        Tue, 15 Jan 2019 10:37:14 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id i193sm10156113pgc.22.2019.01.15.10.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 10:37:13 -0800 (PST)
From:   Tri Vo <trong@android.com>
X-Google-Original-From: Tri Vo <trong@google.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>,
        Tri Vo <trong@android.com>, Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: [PATCH v2 2/4] gcov: clang support
Date:   Tue, 15 Jan 2019 10:36:41 -0800
Message-Id: <20190115183643.120619-3-trong@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190115183643.120619-1-trong@google.com>
References: <20190115183643.120619-1-trong@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@google.com>

LLVM uses profiling data that's deliberately similar to GCC, but has a very
different way of exporting that data.  LLVM calls llvm_gcov_init() once per
module, and provides a couple of callbacks that we can use to ask for more
data.

We care about the "writeout" callback, which in turn calls back into
compiler-rt/this module to dump all the gathered coverage data to disk:

   llvm_gcda_start_file()
     llvm_gcda_emit_function()
     llvm_gcda_emit_arcs()
     llvm_gcda_emit_function()
     llvm_gcda_emit_arcs()
     [... repeats for each function ...]
   llvm_gcda_summary_info()
   llvm_gcda_end_file()

This design is much more stateless and unstructured than gcc's, and is
intended to run at process exit.  This forces us to keep some local state
about which module we're dealing with at the moment.  On the other hand, it
also means we don't depend as much on how LLVM represents profiling data
internally.

See LLVM's lib/Transforms/Instrumentation/GCOVProfiling.cpp for more
details on how this works, particularly GCOVProfiler::emitProfileArcs(),
GCOVProfiler::insertCounterWriteout(), and GCOVProfiler::insertFlush().

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Trilok Soni <tsoni@quicinc.com>
Tested-by: Prasad Sodagudi <psodagud@quicinc.com>
Tested-by: Tri Vo <trong@android.com>
---
 kernel/gcov/Kconfig  |   5 +
 kernel/gcov/Makefile |   1 +
 kernel/gcov/clang.c  | 531 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 537 insertions(+)
 create mode 100644 kernel/gcov/clang.c

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 1e3823fa799b..eb428e570923 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -71,6 +71,11 @@ config GCOV_FORMAT_4_7
 	---help---
 	Select this option to use the format defined by GCC 4.7.
 
+config GCOV_FORMAT_CLANG
+	bool "Clang format"
+	---help---
+	Select this option to use the format defined by Clang.
+
 endchoice
 
 endmenu
diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index 45431ed679d1..83da4765c18d 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -4,3 +4,4 @@ ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 obj-y := base.o fs.o
 obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
 obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
+obj-$(CONFIG_GCOV_FORMAT_CLANG) += clang.o
diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
new file mode 100644
index 000000000000..b00795d28137
--- /dev/null
+++ b/kernel/gcov/clang.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Google, Inc.
+ * modified from kernel/gcov/gcc_4_7.c
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ * LLVM uses profiling data that's deliberately similar to GCC, but has a
+ * very different way of exporting that data.  LLVM calls llvm_gcov_init() once
+ * per module, and provides a couple of callbacks that we can use to ask for
+ * more data.
+ *
+ * We care about the "writeout" callback, which in turn calls back into
+ * compiler-rt/this module to dump all the gathered coverage data to disk:
+ *
+ *    llvm_gcda_start_file()
+ *      llvm_gcda_emit_function()
+ *      llvm_gcda_emit_arcs()
+ *      llvm_gcda_emit_function()
+ *      llvm_gcda_emit_arcs()
+ *      [... repeats for each function ...]
+ *    llvm_gcda_summary_info()
+ *    llvm_gcda_end_file()
+ *
+ * This design is much more stateless and unstructured than gcc's, and is
+ * intended to run at process exit.  This forces us to keep some local state
+ * about which module we're dealing with at the moment.  On the other hand, it
+ * also means we don't depend as much on how LLVM represents profiling data
+ * internally.
+ *
+ * See LLVM's lib/Transforms/Instrumentation/GCOVProfiling.cpp for more
+ * details on how this works, particularly GCOVProfiler::emitProfileArcs(),
+ * GCOVProfiler::insertCounterWriteout(), and
+ * GCOVProfiler::insertFlush().
+ */
+
+#define pr_fmt(fmt)	"gcov: " fmt
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/printk.h>
+#include <linux/ratelimit.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include "gcov.h"
+
+#define GCOV_TAG_FUNCTION_LENGTH	3
+
+typedef void (*llvm_gcov_callback)(void);
+
+struct gcov_info {
+	struct list_head head;
+
+	const char *filename;
+	unsigned int version;
+	u32 checksum;
+
+	struct list_head functions;
+};
+
+struct gcov_fn_info {
+	struct list_head head;
+
+	u32 ident;
+	u32 checksum;
+	u8 use_extra_checksum;
+	u32 cfg_checksum;
+
+	u32 num_counters;
+	u64 *counters;
+};
+
+static struct gcov_info *current_info;
+
+static LIST_HEAD(clang_gcov_list);
+
+void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush)
+{
+	struct gcov_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info) {
+		pr_warn_ratelimited("failed to allocate gcov info\n");
+		return;
+	}
+
+	INIT_LIST_HEAD(&info->head);
+	INIT_LIST_HEAD(&info->functions);
+
+	mutex_lock(&gcov_lock);
+
+	list_add_tail(&info->head, &clang_gcov_list);
+	current_info = info;
+	writeout();
+	current_info = NULL;
+	if (gcov_events_enabled)
+		gcov_event(GCOV_ADD, info);
+
+	mutex_unlock(&gcov_lock);
+}
+EXPORT_SYMBOL(llvm_gcov_init);
+
+void llvm_gcda_start_file(const char *orig_filename, const char version[4],
+		u32 checksum)
+{
+	current_info->filename = orig_filename;
+	memcpy(&current_info->version, version, sizeof(current_info->version));
+	current_info->checksum = checksum;
+}
+EXPORT_SYMBOL(llvm_gcda_start_file);
+
+void llvm_gcda_emit_function(u32 ident, const char *function_name,
+		u32 func_checksum, u8 use_extra_checksum, u32 cfg_checksum)
+{
+	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info) {
+		pr_warn_ratelimited("failed to allocate gcov function info for %s\n",
+				function_name);
+		return;
+	}
+
+	INIT_LIST_HEAD(&info->head);
+	info->ident = ident;
+	info->checksum = func_checksum;
+	info->use_extra_checksum = use_extra_checksum;
+	info->cfg_checksum = cfg_checksum;
+
+	list_add_tail(&info->head, &current_info->functions);
+}
+EXPORT_SYMBOL(llvm_gcda_emit_function);
+
+void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
+{
+	struct gcov_fn_info *info = list_last_entry(&current_info->functions,
+			struct gcov_fn_info, head);
+
+	info->num_counters = num_counters;
+	info->counters = counters;
+}
+EXPORT_SYMBOL(llvm_gcda_emit_arcs);
+
+void llvm_gcda_summary_info(void)
+{
+}
+EXPORT_SYMBOL(llvm_gcda_summary_info);
+
+void llvm_gcda_end_file(void)
+{
+}
+EXPORT_SYMBOL(llvm_gcda_end_file);
+
+/**
+ * gcov_info_filename - return info filename
+ * @info: profiling data set
+ */
+const char *gcov_info_filename(struct gcov_info *info)
+{
+	return info->filename;
+}
+
+/**
+ * gcov_info_version - return info version
+ * @info: profiling data set
+ */
+unsigned int gcov_info_version(struct gcov_info *info)
+{
+	return info->version;
+}
+
+/**
+ * gcov_info_next - return next profiling data set
+ * @info: profiling data set
+ *
+ * Returns next gcov_info following @info or first gcov_info in the chain if
+ * @info is %NULL.
+ */
+struct gcov_info *gcov_info_next(struct gcov_info *info)
+{
+	if (!info)
+		return list_first_entry_or_null(&clang_gcov_list,
+				struct gcov_info, head);
+	if (list_is_last(&info->head, &clang_gcov_list))
+		return NULL;
+	return list_next_entry(info, head);
+}
+
+/* Symbolic links to be created for each profiling data file. */
+const struct gcov_link gcov_link[] = {
+	{ OBJ_TREE, "gcno" },	/* Link to .gcno file in $(objtree). */
+	{ 0, NULL},
+};
+
+/**
+ * gcov_info_reset - reset profiling data to zero
+ * @info: profiling data set
+ */
+void gcov_info_reset(struct gcov_info *info)
+{
+	struct gcov_fn_info *fn;
+
+	list_for_each_entry(fn, &info->functions, head)
+		memset(fn->counters, 0,
+				sizeof(fn->counters[0]) * fn->num_counters);
+}
+
+/**
+ * gcov_info_is_compatible - check if profiling data can be added
+ * @info1: first profiling data set
+ * @info2: second profiling data set
+ *
+ * Returns non-zero if profiling data can be added, zero otherwise.
+ */
+int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
+{
+	return (info1->checksum == info2->checksum);
+}
+
+/**
+ * gcov_info_add - add up profiling data
+ * @dest: profiling data set to which data is added
+ * @source: profiling data set which is added
+ *
+ * Adds profiling counts of @source to @dest.
+ */
+void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
+{
+	struct gcov_fn_info *dfn_ptr;
+	struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
+			struct gcov_fn_info, head);
+
+	list_for_each_entry(dfn_ptr, &dst->functions, head) {
+		u32 i;
+
+		for (i = 0; i < sfn_ptr->num_counters; i++)
+			dfn_ptr->counters[i] += sfn_ptr->counters[i];
+
+		if (!list_is_last(&sfn_ptr->head, &src->functions))
+			sfn_ptr = list_next_entry(sfn_ptr, head);
+	}
+}
+
+static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
+{
+	struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
+			GFP_KERNEL);
+	if (!fn_dup)
+		return NULL;
+	INIT_LIST_HEAD(&fn_dup->head);
+
+	fn_dup->name = kstrdup(fn->name, GFP_KERNEL);
+	if (!fn_dup->name)
+		goto err_name;
+
+	fn_dup->counters = kmemdup(fn->counters,
+			fn->num_counters * sizeof(fn->counters[0]),
+			GFP_KERNEL);
+	if (!fn_dup->counters)
+		goto err_counters;
+
+	return fn_dup;
+
+err_counters:
+	kfree(fn_dup->name);
+err_name:
+	kfree(fn_dup);
+	return NULL;
+}
+
+/**
+ * gcov_info_dup - duplicate profiling data set
+ * @info: profiling data set to duplicate
+ *
+ * Return newly allocated duplicate on success, %NULL on error.
+ */
+struct gcov_info *gcov_info_dup(struct gcov_info *info)
+{
+	struct gcov_info *dup;
+	struct gcov_fn_info *fn, *tmp;
+
+	dup = kmemdup(info, sizeof(*dup), GFP_KERNEL);
+	if (!dup)
+		return NULL;
+	INIT_LIST_HEAD(&dup->head);
+	INIT_LIST_HEAD(&dup->functions);
+	dup->filename = kstrdup(info->filename, GFP_KERNEL);
+
+	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
+		struct gcov_fn_info *fn_dup = gcov_fn_info_dup(fn);
+
+		if (!fn_dup)
+			goto err;
+		list_add_tail(&fn_dup->head, &dup->functions);
+	}
+
+	return dup;
+
+err:
+	gcov_info_free(dup);
+	return NULL;
+}
+
+/**
+ * gcov_info_free - release memory for profiling data set duplicate
+ * @info: profiling data set duplicate to free
+ */
+void gcov_info_free(struct gcov_info *info)
+{
+	struct gcov_fn_info *fn, *tmp;
+
+	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
+		kfree(fn->name);
+		kfree(fn->counters);
+		list_del(&fn->head);
+		kfree(fn);
+	}
+	kfree(info->filename);
+	kfree(info);
+}
+
+#define ITER_STRIDE	PAGE_SIZE
+
+/**
+ * struct gcov_iterator - specifies current file position in logical records
+ * @info: associated profiling data
+ * @buffer: buffer containing file data
+ * @size: size of buffer
+ * @pos: current position in file
+ */
+struct gcov_iterator {
+	struct gcov_info *info;
+	void *buffer;
+	size_t size;
+	loff_t pos;
+};
+
+/**
+ * store_gcov_u32 - store 32 bit number in gcov format to buffer
+ * @buffer: target buffer or NULL
+ * @off: offset into the buffer
+ * @v: value to be stored
+ *
+ * Number format defined by gcc: numbers are recorded in the 32 bit
+ * unsigned binary form of the endianness of the machine generating the
+ * file. Returns the number of bytes stored. If @buffer is %NULL, doesn't
+ * store anything.
+ */
+static size_t store_gcov_u32(void *buffer, size_t off, u32 v)
+{
+	u32 *data;
+
+	if (buffer) {
+		data = buffer + off;
+		*data = v;
+	}
+
+	return sizeof(*data);
+}
+
+/**
+ * store_gcov_u64 - store 64 bit number in gcov format to buffer
+ * @buffer: target buffer or NULL
+ * @off: offset into the buffer
+ * @v: value to be stored
+ *
+ * Number format defined by gcc: numbers are recorded in the 32 bit
+ * unsigned binary form of the endianness of the machine generating the
+ * file. 64 bit numbers are stored as two 32 bit numbers, the low part
+ * first. Returns the number of bytes stored. If @buffer is %NULL, doesn't store
+ * anything.
+ */
+static size_t store_gcov_u64(void *buffer, size_t off, u64 v)
+{
+	u32 *data;
+
+	if (buffer) {
+		data = buffer + off;
+
+		data[0] = (v & 0xffffffffUL);
+		data[1] = (v >> 32);
+	}
+
+	return sizeof(*data) * 2;
+}
+
+/**
+ * convert_to_gcda - convert profiling data set to gcda file format
+ * @buffer: the buffer to store file data or %NULL if no data should be stored
+ * @info: profiling data set to be converted
+ *
+ * Returns the number of bytes that were/would have been stored into the buffer.
+ */
+static size_t convert_to_gcda(char *buffer, struct gcov_info *info)
+{
+	struct gcov_fn_info *fi_ptr;
+	size_t pos = 0;
+
+	/* File header. */
+	pos += store_gcov_u32(buffer, pos, GCOV_DATA_MAGIC);
+	pos += store_gcov_u32(buffer, pos, info->version);
+	pos += store_gcov_u32(buffer, pos, info->checksum);
+
+	list_for_each_entry(fi_ptr, &info->functions, head) {
+		u32 i;
+		u32 len = 2;
+
+		if (fi_ptr->use_extra_checksum)
+			len++;
+
+		pos += store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION);
+		pos += store_gcov_u32(buffer, pos, len);
+		pos += store_gcov_u32(buffer, pos, fi_ptr->ident);
+		pos += store_gcov_u32(buffer, pos, fi_ptr->checksum);
+		if (fi_ptr->use_extra_checksum)
+			pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
+
+		pos += store_gcov_u32(buffer, pos, GCOV_TAG_COUNTER_BASE);
+		pos += store_gcov_u32(buffer, pos, fi_ptr->num_counters * 2);
+		for (i = 0; i < fi_ptr->num_counters; i++)
+			pos += store_gcov_u64(buffer, pos, fi_ptr->counters[i]);
+	}
+
+	return pos;
+}
+
+/**
+ * gcov_iter_new - allocate and initialize profiling data iterator
+ * @info: profiling data set to be iterated
+ *
+ * Return file iterator on success, %NULL otherwise.
+ */
+struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
+{
+	struct gcov_iterator *iter;
+
+	iter = kzalloc(sizeof(struct gcov_iterator), GFP_KERNEL);
+	if (!iter)
+		goto err_free;
+
+	iter->info = info;
+	/* Dry-run to get the actual buffer size. */
+	iter->size = convert_to_gcda(NULL, info);
+	iter->buffer = vmalloc(iter->size);
+	if (!iter->buffer)
+		goto err_free;
+
+	convert_to_gcda(iter->buffer, info);
+
+	return iter;
+
+err_free:
+	kfree(iter);
+	return NULL;
+}
+
+
+/**
+ * gcov_iter_get_info - return profiling data set for given file iterator
+ * @iter: file iterator
+ */
+void gcov_iter_free(struct gcov_iterator *iter)
+{
+	vfree(iter->buffer);
+	kfree(iter);
+}
+
+/**
+ * gcov_iter_get_info - return profiling data set for given file iterator
+ * @iter: file iterator
+ */
+struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter)
+{
+	return iter->info;
+}
+
+/**
+ * gcov_iter_start - reset file iterator to starting position
+ * @iter: file iterator
+ */
+void gcov_iter_start(struct gcov_iterator *iter)
+{
+	iter->pos = 0;
+}
+
+/**
+ * gcov_iter_next - advance file iterator to next logical record
+ * @iter: file iterator
+ *
+ * Return zero if new position is valid, non-zero if iterator has reached end.
+ */
+int gcov_iter_next(struct gcov_iterator *iter)
+{
+	if (iter->pos < iter->size)
+		iter->pos += ITER_STRIDE;
+
+	if (iter->pos >= iter->size)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * gcov_iter_write - write data for current pos to seq_file
+ * @iter: file iterator
+ * @seq: seq_file handle
+ *
+ * Return zero on success, non-zero otherwise.
+ */
+int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
+{
+	size_t len;
+
+	if (iter->pos >= iter->size)
+		return -EINVAL;
+
+	len = ITER_STRIDE;
+	if (iter->pos + len > iter->size)
+		len = iter->size - iter->pos;
+
+	seq_write(seq, iter->buffer + iter->pos, len);
+
+	return 0;
+}
-- 
2.20.1.97.g81188d93c3-goog

