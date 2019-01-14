Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73922C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AEB20896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ihFJBjL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfANVF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:05:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45804 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfANVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:05:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so480989wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yaTwDdPBhHbjdTxlPcCg5RXwpmur+DCR6kh9TUQ4zA=;
        b=ihFJBjL1NvFAieS4tTcIGIge+zojv5aTvNinL7MBVIN/95xZ7Q4VnVKhEn0xSPeH7n
         KPs27hc4XfdiUT+b8JK+oljt8StgpAxB4LAF5KmRWbfnlUxfGSKwMGqFDcXlNYm6uDaV
         leMCdxHqYAGlcXJBOyeQUbtj1bPZy/DUgliqIiPqmTmmeZf313utQX2sY5ViuC9pdDW9
         VLZPdb2tX7Z5RyTCPhn8xaDnbDZV2ANXRZrGz+SSq5xW6miZ/UByYAE6gPIGFRQZm397
         gaRhtTVTIZgFD1Zq6bvfow1WaLTE2OkVyaBiOIqJ1//tMQBwn45blhsX2L9wduivdNbW
         50Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yaTwDdPBhHbjdTxlPcCg5RXwpmur+DCR6kh9TUQ4zA=;
        b=J0pWXO8K+fodse4ytkRFlb2n89k37XqzXlCM3RkVXG8pPeyTLTwVJYQDSLbRZ9fXYc
         DxeYny1iEuUjhnAeyM6f04FmNaO72qa6oiIkOFy2hPJo2wxarzYrFdcFR+FGsrN5xeZr
         Umdl/Gyx+ace56ribgRz3K0nmiSxjeyFP9/3PzHSCJiPk8cws5vNDyNotsIdbDNq3gQt
         sEjsiiUykx6iS0VT4H6OyPTJNYaIkTcjd1Tb3reonFdoLS/GizyS0m+5MdLhOf97CHRW
         8GXmG5Kly3CSBO6XpU5TCt8hGpfM6y8Wku+iJa6JOmb3I+AlxURiT9G0rNpWP0aU6QPa
         glgg==
X-Gm-Message-State: AJcUukf89iPS0B+ChsLqiz5QbwvHRR0QYhk14RZyhx/2tUXfyuruPQ+A
        bbY+KDlNTcnqziEjcZ6qrPXk2w==
X-Google-Smtp-Source: ALg8bN6oMM9w02WpUM5gaIXOwg9Ftc0tjLiUbaiabL+l60ZG6zlODYduQmn+o9D3x51UVSiiDZEryg==
X-Received: by 2002:adf:e407:: with SMTP id g7mr252144wrm.277.1547499921784;
        Mon, 14 Jan 2019 13:05:21 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id s1sm106981548wro.9.2019.01.14.13.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 13:05:21 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>, Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: [PATCH 3/4] gcov: clang: link/unlink profiling data set.
Date:   Mon, 14 Jan 2019 13:04:25 -0800
Message-Id: <20190114210426.177543-4-trong@android.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190114210426.177543-1-trong@android.com>
References: <20190114210426.177543-1-trong@android.com>
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

