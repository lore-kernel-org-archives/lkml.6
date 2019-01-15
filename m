Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E053C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FBE20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="mbzx8Nqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbfAOShT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:37:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40591 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388811AbfAOShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:37:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so1591223pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yaTwDdPBhHbjdTxlPcCg5RXwpmur+DCR6kh9TUQ4zA=;
        b=mbzx8NquTpHK3NGh80GZR+FkS6XH3Jv2gQLamAcsguxfYByJZO9z63wtsoguAFjznY
         vzVfU0YutkG706O6nUkzkdQFHoua5LN337Y71R9drYxaNtlSyPNH6eb5cLERw7A3BlsW
         L0fFiUVzKJJnZt1fsCwYbUTi2Cws7DnGAymxGt6CMmvgQ94m2mNn1ZQzKYeH+QUpB/Cv
         WPR1xrv1TtW7xPkBDNDySMH4W9V4I0yHEOAuu0+/nyUGZpUNszlxtlwnNoUlCRV+ObQ2
         RVt4MJLtQIq5EX2GNh/Ulwl66tFJAPUOR2scgOlbWLZXAj/8GLxfenfeUldByMbZk5Z5
         pKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yaTwDdPBhHbjdTxlPcCg5RXwpmur+DCR6kh9TUQ4zA=;
        b=SYvllZy1MSQZl3ozpR94dtjqRRw+WN5IZs33P5beipEK6Y6eC0+yB+OxsPBeYfkOAK
         vnq/JS09Da2KEMr6YcsoqfGmlK8SNZ3Y+xJAM2A06TVkWrS7ppDihx4y5kHOo5NHbFLu
         5avfw3lHGh+tyz4jESmoSz1Tz+vUA+XzsP/oi7GR8QYzpO1O5M7vRY7bB/P4O0p2OSc9
         EL6/9rKcrCSSjUc7b1GgdFmXg5k3VVgsUwpaQcu5ZSDr5e5HbrJWgXtlCFKZtMvmDQzA
         jQDMFDJfPEAPAA4kA/LQMIVFPSXvrDQCxSA/SAejnOzySP4TsY59gN8KW3w2jJI76Zy0
         L8dw==
X-Gm-Message-State: AJcUukfrbWnUbm4gPQJ0kpwWJ9GBi8FXuUb7EtxzhDW9G3epIK/NVpGf
        DhRULHy+Yi4MZvyF07Ebyj+VfQ==
X-Google-Smtp-Source: ALg8bN6pv/hg41j8z+pD/BgbCn5s2/hqSodq0sWscCwtT6QyUU0zHTtFP8ArpiTeiZtGRBeejCgmIg==
X-Received: by 2002:a63:fc49:: with SMTP id r9mr4891431pgk.209.1547577436162;
        Tue, 15 Jan 2019 10:37:16 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id i193sm10156113pgc.22.2019.01.15.10.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 10:37:15 -0800 (PST)
From:   Tri Vo <trong@android.com>
X-Google-Original-From: Tri Vo <trong@google.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>, Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: [PATCH v2 3/4] gcov: clang: link/unlink profiling data set.
Date:   Tue, 15 Jan 2019 10:36:42 -0800
Message-Id: <20190115183643.120619-4-trong@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190115183643.120619-1-trong@google.com>
References: <20190115183643.120619-1-trong@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

gcov.h defines an interface to access gcov_info data.

Add Clang implementation of gcov_info_link/gcov_info_unlink interfaces.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Trilok Soni <tsoni@quicinc.com>
Tested-by: Prasad Sodagudi <psodagud@quicinc.com>
Tested-by: Tri Vo <trong@android.com>
---
 kernel/gcov/clang.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index b00795d28137..ea42deb852f7 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -77,6 +77,7 @@ struct gcov_fn_info {
 
 	u32 num_counters;
 	u64 *counters;
+	const char *function_name;
 };
 
 static struct gcov_info *current_info;
@@ -124,7 +125,7 @@ void llvm_gcda_emit_function(u32 ident, const char *function_name,
 
 	if (!info) {
 		pr_warn_ratelimited("failed to allocate gcov function info for %s\n",
-				function_name);
+				function_name ?: "UNKNOWN");
 		return;
 	}
 
@@ -133,6 +134,8 @@ void llvm_gcda_emit_function(u32 ident, const char *function_name,
 	info->checksum = func_checksum;
 	info->use_extra_checksum = use_extra_checksum;
 	info->cfg_checksum = cfg_checksum;
+	if (function_name)
+		info->function_name = kstrdup(function_name, GFP_KERNEL);
 
 	list_add_tail(&info->head, &current_info->functions);
 }
@@ -193,6 +196,26 @@ struct gcov_info *gcov_info_next(struct gcov_info *info)
 	return list_next_entry(info, head);
 }
 
+/**
+ * gcov_info_link - link/add profiling data set to the list
+ * @info: profiling data set
+ */
+void gcov_info_link(struct gcov_info *info)
+{
+	list_add_tail(&info->head, &clang_gcov_list);
+}
+
+/**
+ * gcov_info_unlink - unlink/remove profiling data set from the list
+ * @prev: previous profiling data set
+ * @info: profiling data set
+ */
+void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
+{
+	if (prev)
+		list_del(&prev->head);
+}
+
 /* Symbolic links to be created for each profiling data file. */
 const struct gcov_link gcov_link[] = {
 	{ OBJ_TREE, "gcno" },	/* Link to .gcno file in $(objtree). */
@@ -256,8 +279,8 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
 		return NULL;
 	INIT_LIST_HEAD(&fn_dup->head);
 
-	fn_dup->name = kstrdup(fn->name, GFP_KERNEL);
-	if (!fn_dup->name)
+	fn_dup->function_name = kstrdup(fn->function_name, GFP_KERNEL);
+	if (!fn_dup->function_name)
 		goto err_name;
 
 	fn_dup->counters = kmemdup(fn->counters,
@@ -269,7 +292,7 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
 	return fn_dup;
 
 err_counters:
-	kfree(fn_dup->name);
+	kfree(fn_dup->function_name);
 err_name:
 	kfree(fn_dup);
 	return NULL;
@@ -317,7 +340,7 @@ void gcov_info_free(struct gcov_info *info)
 	struct gcov_fn_info *fn, *tmp;
 
 	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
-		kfree(fn->name);
+		kfree(fn->function_name);
 		kfree(fn->counters);
 		list_del(&fn->head);
 		kfree(fn);
-- 
2.20.1.97.g81188d93c3-goog

