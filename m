Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A98620665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDxZRzzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfAGMKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:10:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33570 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfAGMKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:10:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so81461plo.0;
        Mon, 07 Jan 2019 04:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=98DmvLc/H37HjAYgMJiooCx3JhogoHqBnW+idXeEU6E=;
        b=YDxZRzzoEtY7lzl2tzQfxk7iFUe2xjTO4oq6f0R3b2vvtjRaKTpsKQBMCGb+FQbWjI
         z3XDvIYTES0iFNiWe0PHvEktloKjOStsdcNxdYEHgTQYc3RvHVKhBBZrm2dJEaOBhSeV
         xvB8yR3CeQBQCYoecMiCSbXX/xm8vpaKBy7W3ththikXUY37uAJT9SZkGVp2sxTy0aXJ
         l5ZEmA8Ck6zI+wcCV0Vy1hb1e0WRInE5PNtBcem9YVjrpOg0QHb4FvbQdJf1dlTwac9c
         9JcYL3ge8hmwekeYkb5yIkkwAoKbPZq1dOa8MIjIhpU63WQfUmmbkXcxHn3jWGtBBtJZ
         yBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=98DmvLc/H37HjAYgMJiooCx3JhogoHqBnW+idXeEU6E=;
        b=ZBvOag/ZJvUozQeWjv3oScmL9hlRIDbUboAm0IcI24V9aXot5WPKAaaMpMEFI5SR2l
         KLfZTsdZNYNQfDv9+FPoobQlXRnekB2oD3rY2CU18ZQffkT8iB9bmR4REOKqOo5ot2YO
         uYZQC1ob7TCFzMgIxaqBW1WRyMjZwvT1lS3t4nxdCg45WogRqVh52NhMD9i/q2Z77ky0
         ML0xiJXVKhoVD5yIZq0Z3ENBXOCDuOGBxo4i2kGlFnm4OXgeXjTvSTutz2wVjWp/W38A
         CE0R7TUe644KEFNdbuhODRirv6GBjZgGqQP9Go/dM0IjsCxaAc3VVDeQFv2Y3uttgCxL
         pdJA==
X-Gm-Message-State: AJcUuke2rBj4ixhXWsVKEIBpyXVKCi6xhYB8ygwnNRII5WhI9q5eizGK
        GaJB72B8pH9kVIAKroxb9oY=
X-Google-Smtp-Source: ALg8bN5uBiF7BGP9/lz3bvGnwGuPFbaINu2kQzJMeaOXPdapSgoxthkV9ZZ0I5G3OKTywu179xgujg==
X-Received: by 2002:a17:902:e002:: with SMTP id ca2mr61911680plb.103.1546863028844;
        Mon, 07 Jan 2019 04:10:28 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id 62sm79666704pgc.61.2019.01.07.04.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 04:10:28 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net v3 1/4] umh: add exit routine for UMH process
Date:   Mon,  7 Jan 2019 21:10:14 +0900
Message-Id: <20190107121014.13499-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A UMH process which is created by the fork_usermode_blob() such as
bpfilter needs to release members of the umh_info when process is
terminated.
But the do_exit() does not release members of the umh_info. hence module
which uses UMH needs own code to detect whether UMH process is
terminated or not.
But this implementation needs extra code for checking the status of
UMH process. it eventually makes the code more complex.

The new PF_UMH flag is added and it is used to identify UMH processes.
The exit_umh() does not release members of the umh_info.
Hence umh_info->cleanup callback should release both members of the
umh_info and the private data.

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3 :
 - Avoid unnecessary list lookup for non-UMH processes
 - Add a new PF_UMH flag

 include/linux/sched.h |  1 +
 include/linux/umh.h   |  4 ++++
 kernel/exit.c         |  1 +
 kernel/umh.c          | 36 ++++++++++++++++++++++++++++++++++--
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 89541d248893..965da2d54c06 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1406,6 +1406,7 @@ extern struct pid *cad_pid;
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_MEMSTALL		0x01000000	/* Stalled due to lack of memory */
+#define PF_UMH			0x02000000	/* I'm an Usermodehelper process */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MUTEX_TESTER		0x20000000	/* Thread belongs to the rt mutex tester */
diff --git a/include/linux/umh.h b/include/linux/umh.h
index 235f51b62c71..c645f0a19103 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -47,6 +47,8 @@ struct umh_info {
 	const char *cmdline;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
+	struct list_head list;
+	void (*cleanup)(struct umh_info *info);
 	pid_t pid;
 };
 int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
@@ -75,6 +77,8 @@ static inline void usermodehelper_enable(void)
 	__usermodehelper_set_disable_depth(UMH_ENABLED);
 }
 
+void exit_umh(struct task_struct *tsk);
+
 extern int usermodehelper_read_trylock(void);
 extern long usermodehelper_read_lock_wait(long timeout);
 extern void usermodehelper_read_unlock(void);
diff --git a/kernel/exit.c b/kernel/exit.c
index 8a01b671dc1f..dad70419195c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -866,6 +866,7 @@ void __noreturn do_exit(long code)
 	exit_task_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
+	exit_umh(tsk);
 
 	/*
 	 * Flush inherited counters to the parent - before the parent
diff --git a/kernel/umh.c b/kernel/umh.c
index 0baa672e023c..d96e8cd14384 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -37,6 +37,8 @@ static kernel_cap_t usermodehelper_bset = CAP_FULL_SET;
 static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
 static DEFINE_SPINLOCK(umh_sysctl_lock);
 static DECLARE_RWSEM(umhelper_sem);
+static LIST_HEAD(umh_list);
+static DEFINE_MUTEX(umh_list_lock);
 
 static void call_usermodehelper_freeinfo(struct subprocess_info *info)
 {
@@ -100,10 +102,12 @@ static int call_usermodehelper_exec_async(void *data)
 	commit_creds(new);
 
 	sub_info->pid = task_pid_nr(current);
-	if (sub_info->file)
+	if (sub_info->file) {
 		retval = do_execve_file(sub_info->file,
 					sub_info->argv, sub_info->envp);
-	else
+		if (!retval)
+			current->flags |= PF_UMH;
+	} else
 		retval = do_execve(getname_kernel(sub_info->path),
 				   (const char __user *const __user *)sub_info->argv,
 				   (const char __user *const __user *)sub_info->envp);
@@ -517,6 +521,11 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 		goto out;
 
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
+	if (!err) {
+		mutex_lock(&umh_list_lock);
+		list_add(&info->list, &umh_list);
+		mutex_unlock(&umh_list_lock);
+	}
 out:
 	fput(file);
 	return err;
@@ -679,6 +688,29 @@ static int proc_cap_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
+void exit_umh(struct task_struct *tsk)
+{
+	struct umh_info *info;
+	pid_t pid = tsk->pid;
+
+	if (!(tsk->flags & PF_UMH))
+		return;
+
+	mutex_lock(&umh_list_lock);
+	list_for_each_entry(info, &umh_list, list) {
+		if (info->pid == pid) {
+			list_del(&info->list);
+			mutex_unlock(&umh_list_lock);
+			goto out;
+		}
+	}
+	mutex_unlock(&umh_list_lock);
+	return;
+out:
+	if (info->cleanup)
+		info->cleanup(info);
+}
+
 struct ctl_table usermodehelper_table[] = {
 	{
 		.procname	= "bset",
-- 
2.17.1

