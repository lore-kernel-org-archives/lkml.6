Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC1AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171462086D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLWJn15f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171462086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeIGVij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:38:39 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45430 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeIGVii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:38:38 -0400
Received: by mail-ua1-f66.google.com with SMTP id q7-v6so12422079uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1onzFDwfY4fkZLPwWUd06kigQPqmUETWgTKnKf56I7g=;
        b=qLWJn15f9exyp9+Ann8EVs1xeQ1tZeVMSZyf4UScFw807tdZflp13TuTL01afBB8ZE
         ySVABipKa/4Q+owmF8V+YdzD1wM3p/vR0SlsI+sxfiIAMzwm3vwRdz2t22P5b7JAZixi
         zK8uPOO7RSr1nRoF9qHRWOBjpujs514wqN/0+avratxD0foypVnOf3ElxLxUiTUHMgHY
         +jdr0jY9QQz9Qt7zrAGRi1OfddZNdo/KTsqJ4AvHoSHH2f7+ca8zNKpD5RQpIkT0kfGU
         Ec2b8AysbWFF2SH2xHBS+LXfRngj5YfSmYSYmtzHN5vN8qh504F3Pj94uCm5jSrrLR2G
         yetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1onzFDwfY4fkZLPwWUd06kigQPqmUETWgTKnKf56I7g=;
        b=QiBpHvo0MYb7CTkSGuMlpMKhnWEGrf0uzwABcnxEGlPtMFYQAd5uy+wVW16i4nqDRd
         k3m375orcIs2P0cl0LEbrrvgd2CabLitHt5FQZFAA5e9JdSK6HIUH2B1iWN2dhcL1rSR
         hjBjUgHOBDhNeUkNylWgLRussF4hMpowAsSMHiwB9c3aZMfJKpzOcWmGXEqxoWXsg8+0
         z08z1g7FNaEC5O/OREv7qeo9b0ziBtuRx7IhovVO2KE4xDAdzC1gNr8QytM9kw+fikLN
         uHPaD+CPbZniHKwrsgMrjCNV8PyjreHnGmwmEzS91vj7wdchi13qlOHi3t0m1bZC/7Z+
         zEqQ==
X-Gm-Message-State: APzg51DrSr0SCKeaK2YM5zkqBH8llO0pg/XO2woqpv2kWUosulXeEx8F
        VmJPqonxHwbLXjKXmgwR9q3OKgJcxg==
X-Google-Smtp-Source: ANB0VdZUjdSRw+evzWqo7s64X7f5M629dpzJtWSU0u1gv+SDTd/QkvA7Y5TXwSUAMNPnk2/M/txUUg==
X-Received: by 2002:ab0:2258:: with SMTP id z24-v6mr3119570uan.127.1536339409240;
        Fri, 07 Sep 2018 09:56:49 -0700 (PDT)
Received: from localhost.localdomain (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id q202-v6sm1039619vke.53.2018.09.07.09.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:56:48 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/6] proc: commit to genradix
Date:   Fri,  7 Sep 2018 12:56:34 -0400
Message-Id: <20180907165635.8469-6-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180907165635.8469-1-kent.overstreet@gmail.com>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the new generic radix trees have a simpler API and implementation, and
no limitations on number of elements, so all flex_array users are being
converted

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/base.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index aaffc0c302..e11fbb390a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -59,6 +59,7 @@
 #include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
+#include <linux/generic-radix-tree.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/namei.h>
@@ -92,7 +93,6 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
-#include <linux/flex_array.h>
 #include <linux/posix-timers.h>
 #include <trace/events/oom.h>
 #include "internal.h"
@@ -2128,11 +2128,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	struct task_struct *task;
 	struct mm_struct *mm;
 	unsigned long nr_files, pos, i;
-	struct flex_array *fa = NULL;
-	struct map_files_info info;
+	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
 
+	genradix_init(&fa);
+
 	ret = -ENOENT;
 	task = get_proc_task(file_inode(file));
 	if (!task)
@@ -2164,35 +2165,22 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	 */
 
 	for (vma = mm->mmap, pos = 2; vma; vma = vma->vm_next) {
-		if (vma->vm_file && ++pos > ctx->pos)
-			nr_files++;
-	}
+		if (!vma->vm_file)
+			continue;
+		if (++pos <= ctx->pos)
+			continue;
 
-	if (nr_files) {
-		fa = flex_array_alloc(sizeof(info), nr_files,
-					GFP_KERNEL);
-		if (!fa || flex_array_prealloc(fa, 0, nr_files,
-						GFP_KERNEL)) {
+		p = genradix_ptr_alloc(&fa, nr_files++, GFP_KERNEL);
+		if (!p) {
 			ret = -ENOMEM;
-			if (fa)
-				flex_array_free(fa);
 			up_read(&mm->mmap_sem);
 			mmput(mm);
 			goto out_put_task;
 		}
-		for (i = 0, vma = mm->mmap, pos = 2; vma;
-				vma = vma->vm_next) {
-			if (!vma->vm_file)
-				continue;
-			if (++pos <= ctx->pos)
-				continue;
 
-			info.start = vma->vm_start;
-			info.end = vma->vm_end;
-			info.mode = vma->vm_file->f_mode;
-			if (flex_array_put(fa, i++, &info, GFP_KERNEL))
-				BUG();
-		}
+		p->start = vma->vm_start;
+		p->end = vma->vm_end;
+		p->mode = vma->vm_file->f_mode;
 	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);
@@ -2201,7 +2189,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
 		unsigned int len;
 
-		p = flex_array_get(fa, i);
+		p = genradix_ptr(&fa, i);
 		len = snprintf(buf, sizeof(buf), "%lx-%lx", p->start, p->end);
 		if (!proc_fill_cache(file, ctx,
 				      buf, len,
@@ -2211,12 +2199,11 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		ctx->pos++;
 	}
-	if (fa)
-		flex_array_free(fa);
 
 out_put_task:
 	put_task_struct(task);
 out:
+	genradix_free(&fa);
 	return ret;
 }
 
-- 
2.19.0.rc2

