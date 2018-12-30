Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0120C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEF9218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlz2qUbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeL3Qbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:31:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36285 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeL3Qbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:31:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so12418101pfc.3;
        Sun, 30 Dec 2018 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nb0RmDBa19Ouia07fHp4izMVq1fsE5b35wttiwrK/1g=;
        b=Qlz2qUbeyWPAyVTXHOD9EZfarB3O9An/5nrEOo6332coJaZulYvieuIV4c9b8cRTLH
         iuVZEY1hD7JrOzQTc4gHqHFjhGTfyDLghSQfBpTXZx+YJwDAGw4vO7ixrNB6uK2RiRrh
         2RqLrABs0dLB/Leq1yvtdCzC22jg21pZZefrYHVSMXwB98qUvcvW3XqOitrvly2+Xb3h
         i1O8LklC2JFwjRQ1xvZZWhtgwv0DL1/FZJzuer91HebNfxOCrz1m4K+36c0lklqUuCV3
         R4iLiM50M2iepROvXaJLdqyzlrjJfHwF4CbyZPw58AypmSCmO5Brhk/t+qEFhs/EFp4f
         q2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nb0RmDBa19Ouia07fHp4izMVq1fsE5b35wttiwrK/1g=;
        b=KKcp65gb0vfSoM2BO4X7I2h84CcnZ3h9Yntv6WdcPKp6PrbOnUaJytJllHjnFvG1Pq
         SjS3jRso5idEHPkaYBxwxTMqxwaXhTS9VsBcX2WYL6XOOi2ONGdDHzx9oJBXOB+nbBNn
         uTDx7mCvDjFkx5FV3U6bJSQn6xiTC5++AWu+f1903y2Kn6dhX4klMgR+nlDPLJWIrYVp
         1VBtFwvuVHDzkmIseV9Z0mi0ltV4wNAFLAcyHqBsIW+3kRPx05HcBjzf/i8dLywwoTk9
         blugUKjOz6UUL9YMv3RR9BAlnx2ecyqHLf8STaFe4Cok13q+xnDeltRXZqXpZq92sBiX
         OK0w==
X-Gm-Message-State: AA+aEWaEkYCvlSDednoo3eMNcdDe/MFzfADfhVPDw2rUos4CWyzKPjXn
        m1BlSZ+Zco39dZk2XeiMtxc=
X-Google-Smtp-Source: AFSGD/WO/Xe5WUSqASFAmSDLn2jJU8enp8x3yfKtDQo7aczMe9NH6MqBJ6YO5L9djV83/j+zGjCyIQ==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr35199301pfd.224.1546187511991;
        Sun, 30 Dec 2018 08:31:51 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id d80sm128632785pfm.146.2018.12.30.08.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 08:31:51 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net 1/4] umh: add exit routine for UMH process
Date:   Mon, 31 Dec 2018 01:31:43 +0900
Message-Id: <20181230163143.21030-1-ap420073@gmail.com>
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

The exit_umh() does not release members of the umh_info.
Hence umh_info->cleanup callback should release both members of the
umh_info and the private data.

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 include/linux/umh.h |  4 ++++
 kernel/exit.c       |  1 +
 kernel/umh.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

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
index 0e21e6d21f35..63ce4c958390 100644
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
index 0baa672e023c..9b2238e440eb 100644
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
@@ -517,6 +519,11 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
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
@@ -679,6 +686,26 @@ static int proc_cap_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
+void exit_umh(struct task_struct *tsk)
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

