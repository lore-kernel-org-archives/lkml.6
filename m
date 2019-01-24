Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF4AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B25D218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gygzfM8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfAXVPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:15:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42075 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfAXVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so3619509pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucF1EwcLVxCtpPOBrQuqUFcO6ME+3ZXcCq84fU7zCQU=;
        b=gygzfM8DMwdV2iIuQLyTUNZoqz3zBV3YtlUapmjclo6FC0Cojxkyvg4NivMng9lbsQ
         UWdyeeLEfhPEp8uDGJi7V+xJ1r8fLv7cSF3AgCBMzvurwt/n6qyU4ar7Cg9qTtZeIxbU
         J6YSkeKSSK0UPNMIulk/GIHII8GRmfVYhpB65NdU5mVAAkC5EC5Z9ITK8S75A88PP/rM
         YCmvpjQontE64hJ0camuKp/QHj5ID+XU4FRhNKvHB2zo3jpM7bZb6q/XuMvwwy6vaDwK
         BPTQ0nG+MGuEYAZ0eOa1zCAzJnqN3qOecuomYBNuInO5ONQIFkVFx7A78idtIZ3d2iHh
         EAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucF1EwcLVxCtpPOBrQuqUFcO6ME+3ZXcCq84fU7zCQU=;
        b=MH4uIc0aUUe/Wh7lqyrLEmwwXQ7QGZBuaWOk+X9O5SiuIFL+AzO+cxnFa5Uu/QDwGP
         sUvu8pk+NdOoPgbCEVsgrSQaXamfzUexC4W7GvVcNUFWXcCPXMTOa2WqEa7UstxpFYAT
         kUbD1m0+qoI3NpOYdhhdQztFI4imYLKaD0+x/TfRhn0ubMlgX2TjtEk2Shq1zrGWS1E6
         YAYVfxuvVysVpheFA7+n9hgo8xQ797oUztg/oodDIZ/p/mVuGwAM+6m3eFiOXgU+xqAw
         vQEbWhMU8pC4MOJKBvUNj4/mG1CUXEeLaT68kmdspqrQlIvunTgYy9GWS9MdTqQJUfaM
         fXUQ==
X-Gm-Message-State: AJcUukfRotNESMas4IUIvtvWqdLyHH0N1AWUOQyJZdJr8eIQEW9akyJa
        e3rCk+9NTAnYTPmeP72L8IR/TA==
X-Google-Smtp-Source: ALg8bN7SzOSe/SY78Pfzr1GOzAhXFURTr4LVGcJJzkPSCrKgxlqMkTFLV98NujEgXfWObOrL6iJgLg==
X-Received: by 2002:a63:31cc:: with SMTP id x195mr7538081pgx.52.1548364543402;
        Thu, 24 Jan 2019 13:15:43 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id j197sm29626418pgc.76.2019.01.24.13.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:15:42 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 1/5] fs: kernfs: add poll file operation
Date:   Thu, 24 Jan 2019 13:15:14 -0800
Message-Id: <20190124211518.244221-2-surenb@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190124211518.244221-1-surenb@google.com>
References: <20190124211518.244221-1-surenb@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

Kernfs has a standardized poll/notification mechanism for waking all
pollers on all fds when a filesystem node changes. To allow polling
for custom events, add a .poll callback that can override the default.

This is in preparation for pollable cgroup pressure files which have
per-fd trigger configurations.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/kernfs/file.c       | 31 ++++++++++++++++++++-----------
 include/linux/kernfs.h |  6 ++++++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f8d5021a652e..ae948aaa4c53 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -832,26 +832,35 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
  * to see if it supports poll (Neither 'poll' nor 'select' return
  * an appropriate error code).  When in doubt, set a suitable timeout value.
  */
+__poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
+{
+	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
+	struct kernfs_open_node *on = kn->attr.open;
+
+	poll_wait(of->file, &on->poll, wait);
+
+	if (of->event != atomic_read(&on->event))
+		return DEFAULT_POLLMASK|EPOLLERR|EPOLLPRI;
+
+	return DEFAULT_POLLMASK;
+}
+
 static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 {
 	struct kernfs_open_file *of = kernfs_of(filp);
 	struct kernfs_node *kn = kernfs_dentry_node(filp->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	__poll_t ret;
 
 	if (!kernfs_get_active(kn))
-		goto trigger;
+		return DEFAULT_POLLMASK|EPOLLERR|EPOLLPRI;
 
-	poll_wait(filp, &on->poll, wait);
+	if (kn->attr.ops->poll)
+		ret = kn->attr.ops->poll(of, wait);
+	else
+		ret = kernfs_generic_poll(of, wait);
 
 	kernfs_put_active(kn);
-
-	if (of->event != atomic_read(&on->event))
-		goto trigger;
-
-	return DEFAULT_POLLMASK;
-
- trigger:
-	return DEFAULT_POLLMASK|EPOLLERR|EPOLLPRI;
+	return ret;
 }
 
 static void kernfs_notify_workfn(struct work_struct *work)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 5b36b1287a5a..0cac1207bb00 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -25,6 +25,7 @@ struct seq_file;
 struct vm_area_struct;
 struct super_block;
 struct file_system_type;
+struct poll_table_struct;
 
 struct kernfs_open_node;
 struct kernfs_iattrs;
@@ -261,6 +262,9 @@ struct kernfs_ops {
 	ssize_t (*write)(struct kernfs_open_file *of, char *buf, size_t bytes,
 			 loff_t off);
 
+	__poll_t (*poll)(struct kernfs_open_file *of,
+			 struct poll_table_struct *pt);
+
 	int (*mmap)(struct kernfs_open_file *of, struct vm_area_struct *vma);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -350,6 +354,8 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns);
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
+__poll_t kernfs_generic_poll(struct kernfs_open_file *of,
+			     struct poll_table_struct *pt);
 void kernfs_notify(struct kernfs_node *kn);
 
 const void *kernfs_super_ns(struct super_block *sb);
-- 
2.20.1.321.g9e740568ce-goog

