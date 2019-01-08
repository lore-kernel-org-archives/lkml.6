Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3579C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1182070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9ZnE/mL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfAHRYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:24:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47004 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbfAHRYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:24:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so2220042pfe.13;
        Tue, 08 Jan 2019 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hgd3aG7edIN45QryDxwTooIqwI3vpe+mJxnSU2IXBvo=;
        b=G9ZnE/mLhrZcSQfr2OJsBs2IM9JaSTAiDT9B5lZBgeAtM+C55u6u4yVswVsmCjzDSr
         qLa4RMW9chlpfS/P8BdwczOUs5K6rOJUEQfegt2JksEErOBAcann0mr2C5v8/J71oN/M
         4FKD1dbWtLx2+5YtxR/PGLJpIWX5xW+/MX8OHr3DncEj1ya1nMTh+MnE4cwTl0V7nGi1
         FtwvVgGZDJAepKPBshuZEMVzdeswC+Eg0b/jnF1+LVQo8nu7imLh1a4IId2MIuroKbMq
         V7f0UecWD702mAKQf1mjSi0Rd9VYcb6Fe7X6bowrWI9L2ibnp105dUIFy3G35MhzvXvT
         SVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hgd3aG7edIN45QryDxwTooIqwI3vpe+mJxnSU2IXBvo=;
        b=GuQl/j94kigOa6Uq2oynDBkTMD6ue94pYJmgL5vpLNqwE3IbHMjrBszsMwOu3qZbhJ
         rsDZROx07i2gFgMs7Gkkr1CdrrM2NCgP6+n07VTDhn6SCeIMhSJZffldXBc903FTiNGJ
         ypaUcoIE65cId7R2d6AZa6gRfQ8+3uXRs6uXTC2RwfoAFbzeCbXXxXJM2WxOV6VS3gDF
         nVknQS92LtISON54r3ZhWS6uV06er+Tbsl/E69h4vJk6v94YlA3gVEZheT89sk3SJAss
         46pbIvWO39DhFeIfpPcmrOc9UJkUY2Ccf1smWEDZiEUlDsAtkAqwBwh/kFFXYd/49PMl
         uXMQ==
X-Gm-Message-State: AJcUukfUk/vJRCQoUIA7H8kYVWDiguMxVZa73rpiF7q9nPTNMSmsyKkS
        uKAXQG9cHSe5PJsYqjmXEVA=
X-Google-Smtp-Source: ALg8bN7SlQcNQfi8C3Z+nD4jkqfFhsYhh1XzeyQ1LWK2wKFY4EhRkd5KPP2g0sMDWC1tdVRejXXgvw==
X-Received: by 2002:a62:670f:: with SMTP id b15mr2566558pfc.212.1546968253055;
        Tue, 08 Jan 2019 09:24:13 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id g26sm91466468pfh.61.2019.01.08.09.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:24:12 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net v4 1/4] umh: add exit routine for UMH process
Date:   Wed,  9 Jan 2019 02:23:56 +0900
Message-Id: <20190108172356.12009-1-ap420073@gmail.com>
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

v4 : declare the exit_umh() as static inline

 include/linux/sched.h |  9 +++++++++
 include/linux/umh.h   |  2 ++
 kernel/exit.c         |  1 +
 kernel/umh.c          | 33 +++++++++++++++++++++++++++++++--
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 89541d248893..e35e35b9fc48 100644
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
@@ -1904,6 +1905,14 @@ static inline void rseq_execve(struct task_struct *t)
 
 #endif
 
+void __exit_umh(struct task_struct *tsk);
+
+static inline void exit_umh(struct task_struct *tsk)
+{
+	if (unlikely(tsk->flags & PF_UMH))
+		__exit_umh(tsk);
+}
+
 #ifdef CONFIG_DEBUG_RSEQ
 
 void rseq_syscall(struct pt_regs *regs);
diff --git a/include/linux/umh.h b/include/linux/umh.h
index 235f51b62c71..0c08de356d0d 100644
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
index 0baa672e023c..d937cbad903a 100644
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
@@ -679,6 +688,26 @@ static int proc_cap_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
+void __exit_umh(struct task_struct *tsk)
+{
+	struct umh_info *info;
+	pid_t pid = tsk->pid;
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

