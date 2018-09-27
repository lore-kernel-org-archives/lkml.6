Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED15C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1911821571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="1R1tcron"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1911821571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI0Va2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:30:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37096 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeI0Va1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:30:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so2193520pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RBPw+7zsUoOhRuxaXkMx/xgeCphN9zUCYK/fAuidvzw=;
        b=1R1tcronSS1Fe6VHU5W/mOkLlckQ9Lzqv/La0Qs7npCSYotGoA2lWE29/6twoAvm1u
         A9KHoOZf3rsCqlHQiArh/dqs+8jNNrQcLW/uujiz4nqs5AKS5eBquImM9pz//Qvq/X0P
         4/AYXjFr5BWkeyq0JwsRxCVrD/88loz/1F4xWanocQqRuC+3y7jcKOge064BPHMC6Tkt
         3TxFSDacIAF9MxPKC8wIXGIRAX9BkSX4Y+vJ0R+026gwvTNehwT1ZtAnDPwXYRsqzDUM
         0i4S/RDXh8KWIFQo88aHRd985WPa7Jr3moR6zMYHdWMVE1XGJ0luAJWVJrpX+reFu4IB
         xXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RBPw+7zsUoOhRuxaXkMx/xgeCphN9zUCYK/fAuidvzw=;
        b=TdWcKuwpPkDij+H26PWxu5HpE1+PuKRgjEevQzByno+dgq4LKW0m1p63qJtGKU7YjE
         4vRexbVMERTWE9ukucvrpu5vxwwa3ZDIJATNHEVCXjr3xvvGOGL0vBAQaZq8fsgNy/Nj
         AtbrUdLW/StvS/FTYb9ZXH0p7ZX22Gtj3FULor5B1CNr8g0G1vrjVtC0c4XDm2aFq7Cq
         Ce+Ffd0ZGvDwSZMZ6s6D3DIjqTrbFyneuBEHclFB76Xrw9lIgVSNLg3QrMkfNlznrA/i
         Ro+gLZQOk9HCe4+mOh7cESjtWSF4MNqag9o2w28oJzS5rhuTkwMJhxO953znEQxYyWFl
         Y1Ww==
X-Gm-Message-State: ABuFfoj3pW8IQ9BW8Z5ARjRWqicWARcFaCQmcje5TVDHVLHLlXixiNED
        VpXToW3h3Ui2LnN7F/znSRQ/sw==
X-Google-Smtp-Source: ACcGV63fSTxh4HlBCirYvTIW+fQLmpkBUoVvDThuvTnZuu8LU8mIhrdfrR8ELrymg+k26ZIyf5chAg==
X-Received: by 2002:a63:1245:: with SMTP id 5-v6mr10676571pgs.299.1538061103958;
        Thu, 27 Sep 2018 08:11:43 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.178])
        by smtp.gmail.com with ESMTPSA id y19-v6sm5429610pff.14.2018.09.27.08.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:11:43 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v7 4/6] files: add a replace_fd_files() function
Date:   Thu, 27 Sep 2018 09:11:17 -0600
Message-Id: <20180927151119.9989-5-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927151119.9989-1-tycho@tycho.ws>
References: <20180927151119.9989-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to fd_install/__fd_install, we want to be able to replace an fd of
an arbitrary struct files_struct, not just current's. We'll use this in the
next patch to implement the seccomp ioctl that allows inserting fds into a
stopped process' context.

v7: new in v7

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
 fs/file.c            | 22 +++++++++++++++-------
 include/linux/file.h |  8 ++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..3b3c5aadaadb 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -850,24 +850,32 @@ __releases(&files->file_lock)
 }
 
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
+{
+	return replace_fd_task(current, fd, file, flags);
+}
+
+/*
+ * Same warning as __alloc_fd()/__fd_install() here.
+ */
+int replace_fd_task(struct task_struct *task, unsigned fd,
+		    struct file *file, unsigned flags)
 {
 	int err;
-	struct files_struct *files = current->files;
 
 	if (!file)
-		return __close_fd(files, fd);
+		return __close_fd(task->files, fd);
 
-	if (fd >= rlimit(RLIMIT_NOFILE))
+	if (fd >= task_rlimit(task, RLIMIT_NOFILE))
 		return -EBADF;
 
-	spin_lock(&files->file_lock);
-	err = expand_files(files, fd);
+	spin_lock(&task->files->file_lock);
+	err = expand_files(task->files, fd);
 	if (unlikely(err < 0))
 		goto out_unlock;
-	return do_dup2(files, file, fd, flags);
+	return do_dup2(task->files, file, fd, flags);
 
 out_unlock:
-	spin_unlock(&files->file_lock);
+	spin_unlock(&task->files->file_lock);
 	return err;
 }
 
diff --git a/include/linux/file.h b/include/linux/file.h
index 6b2fb032416c..f94277fee038 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -11,6 +11,7 @@
 #include <linux/posix_types.h>
 
 struct file;
+struct task_struct;
 
 extern void fput(struct file *);
 
@@ -79,6 +80,13 @@ static inline void fdput_pos(struct fd f)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
+/*
+ * Warning! This is only safe if you know the owner of the files_struct is
+ * stopped outside syscall context. It's a very bad idea to use this unless you
+ * have similar guarantees in your code.
+ */
+extern int replace_fd_task(struct task_struct *task, unsigned fd,
+			   struct file *file, unsigned flags);
 extern void set_close_on_exec(unsigned int fd, int flag);
 extern bool get_close_on_exec(unsigned int fd);
 extern int get_unused_fd_flags(unsigned flags);
-- 
2.17.1

