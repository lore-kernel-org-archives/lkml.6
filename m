Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF12C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BB5217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="k7cMgRR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfBFAMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:12:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45745 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfBFALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:43 -0500
Received: by mail-ed1-f68.google.com with SMTP id t6so3213344edw.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cvq3ho7ev4E3iI9XxeFOmqSWdHYslt3os8SFMFZoq+0=;
        b=k7cMgRR5z7R7xvCZ+cySSXExVHDch3yGE0nGs2TORoqzan5r0/FLz1lmRxdMmnNiJQ
         9daWdr44SJgWxlSG5hxsqcu4QXPnwl/i3CbvnIw2JdIBL5W8wugu15SZ8//TN3cteo+N
         yAQA3amIQICubQzG87kRE/Lu4eHxDowFDjofWGYIM8k/cQ1SBbPJSj+0rYDu12vxRvtB
         vDzwKDr0SOOuFCSMjMbiS6Ou/aQaJ2GvRxhoGSRfVbLJgFUVDExW4LsZGTiYAwwTMpQ/
         B8VkbcrlL2JuUnmwNGhLU3MmYgs1oWbBIu8i0pjjKEP1qE9Qodb9GFDe263QVcQbp3ES
         CDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cvq3ho7ev4E3iI9XxeFOmqSWdHYslt3os8SFMFZoq+0=;
        b=huMqqG6iX8MeYQ0H2klRrndxQUOLZUeEYXPYt8+5whUMrbyMaNPbhkLeM4woSC2PL1
         rainpTia1yDT0Zv7Xw9onqYTCXErisONviD5ovFUI8v2tSZJvao4GCciJs4Uwwi6/cJ2
         ibFHm00yGsAa1BnC1F9nGxrKz/eVTaQgqriEyIEAzFGaOv9Dy6gVy5kJToQcR2maI5uv
         OmWzC0DI5j6fhPbGobAraXCcengY9FjXYA+tJRvwfGnEfa736npbL+PSRvsl5gxbP7mm
         F5dEurVe6+fYUwww8HVX3qFUttR3tBNjGoaCwQXZTENcobqZd/J1ZDLSVDgoayFnZtqW
         dOBg==
X-Gm-Message-State: AHQUAuY0JUa4Y6XrhEEOYomoqsSiTdu8Kt5bWPIZgzpFbh3kDkkYf3N5
        RcP5SMO3o516rBRkKteCYN23gzxreOU=
X-Google-Smtp-Source: AHgI3IbmoDbLFz7lGbxJZ/ochE7wPIpnbme1XBz+ufeWnrIZyOCUHS0Vh+YPQcevaIO0Q1ft8fOdug==
X-Received: by 2002:a50:9291:: with SMTP id k17mr5955796eda.243.1549411900397;
        Tue, 05 Feb 2019 16:11:40 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:39 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 23/32] timens/fs/proc: Introduce /proc/pid/timens_offsets
Date:   Wed,  6 Feb 2019 00:10:57 +0000
Message-Id: <20190206001107.16488-24-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

API to set time namespace offsets for children processes, i.e.:
echo "clockid off_ses off_nsec" > /proc/self/timens_offsets

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/proc/base.c                 | 101 +++++++++++++++++++++++++++++++++
 include/linux/time_namespace.h |  10 ++++
 kernel/time_namespace.c        |  71 +++++++++++++++++++++++
 3 files changed, 182 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 633a63462573..1ba31050dcb5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/stat.h>
 #include <linux/flex_array.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -1520,6 +1521,103 @@ static const struct file_operations proc_pid_sched_autogroup_operations = {
 
 #endif /* CONFIG_SCHED_AUTOGROUP */
 
+#ifdef CONFIG_TIME_NS
+static int timens_offsets_show(struct seq_file *m, void *v)
+{
+	struct inode *inode = m->private;
+	struct task_struct *p;
+
+	p = get_proc_task(inode);
+	if (!p)
+		return -ESRCH;
+	proc_timens_show_offsets(p, m);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static ssize_t
+timens_offsets_write(struct file *file, const char __user *buf,
+	    size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct proc_timens_offset offsets[2];
+	char *kbuf = NULL, *pos, *next_line;
+	struct task_struct *p;
+	int ret, noffsets;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	/* Slurp in the user data */
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/* Parse the user data */
+	ret = -EINVAL;
+	noffsets = 0;
+	pos = kbuf;
+	for (; pos; pos = next_line) {
+		struct proc_timens_offset *off = &offsets[noffsets];
+		int err;
+
+		/* Find the end of line and ensure I don't look past it */
+		next_line = strchr(pos, '\n');
+		if (next_line) {
+			*next_line = '\0';
+			next_line++;
+			if (*next_line == '\0')
+				next_line = NULL;
+		}
+
+		err = sscanf(pos, "%u %lld %lu", &off->clockid,
+				&off->val.tv_sec, &off->val.tv_nsec);
+		if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
+			goto out;
+		if (noffsets++ == ARRAY_SIZE(offsets))
+			break;
+	}
+
+	ret = -ESRCH;
+	p = get_proc_task(inode);
+	if (!p)
+		goto out;
+	ret = proc_timens_set_offset(p, offsets, noffsets);
+	put_task_struct(p);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+static int timens_offsets_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = single_open(filp, timens_offsets_show, NULL);
+	if (!ret) {
+		struct seq_file *m = filp->private_data;
+
+		m->private = inode;
+	}
+	return ret;
+}
+
+static const struct file_operations proc_timens_offsets_operations = {
+	.open		= timens_offsets_open,
+	.read		= seq_read,
+	.write		= timens_offsets_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_TIME_NS */
+
 static ssize_t comm_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *offset)
 {
@@ -2953,6 +3051,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
+#endif
+#ifdef CONFIG_TIME_NS
+	REG("timens_offsets",  S_IRUGO|S_IWUSR, proc_timens_offsets_operations),
 #endif
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index f1807d7f524d..c9ba7366b3d6 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -41,6 +41,16 @@ static inline void put_time_ns(struct time_namespace *ns)
 }
 
 
+extern void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m);
+
+struct proc_timens_offset {
+	int clockid;
+	struct timespec64 val;
+};
+
+extern int proc_timens_set_offset(struct task_struct *p,
+				struct proc_timens_offset *offsets, int n);
+
 extern void timens_clock_to_host(int clockid, struct timespec64 *val);
 extern void timens_clock_from_host(int clockid, struct timespec64 *val);
 
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 1d1d1c023ec1..6e2e6629e1ba 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -13,6 +13,7 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
+#include <linux/seq_file.h>
 #include <linux/mm.h>
 #include <asm/vdso.h>
 
@@ -202,6 +203,76 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
 	return to_time_ns(ns)->user_ns;
 }
 
+static void show_offset(struct seq_file *m, int clockid, struct timespec64 *ts)
+{
+	seq_printf(m, "%d %lld %ld\n", clockid, ts->tv_sec, ts->tv_nsec);
+}
+
+void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+	struct timens_offsets *ns_offsets;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return;
+	time_ns = to_time_ns(ns);
+
+	if (!time_ns->offsets) {
+		put_time_ns(time_ns);
+		return;
+	}
+	ns_offsets = time_ns->offsets;
+
+	show_offset(m, CLOCK_MONOTONIC, &ns_offsets->monotonic_time_offset);
+	show_offset(m, CLOCK_BOOTTIME, &ns_offsets->monotonic_boottime_offset);
+	put_time_ns(time_ns);
+}
+
+int proc_timens_set_offset(struct task_struct *p,
+			   struct proc_timens_offset *offsets, int noffsets)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+	struct timens_offsets *ns_offsets;
+	int i, err;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return -ESRCH;
+	time_ns = to_time_ns(ns);
+
+	if (!time_ns->offsets || time_ns->initialized ||
+	    !ns_capable(time_ns->user_ns, CAP_SYS_TIME)) {
+		put_time_ns(time_ns);
+		return -EPERM;
+	}
+	ns_offsets = time_ns->offsets;
+
+	err = -EINVAL;
+	for (i = 0; i < noffsets; i++) {
+		struct proc_timens_offset *off = &offsets[i];
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			ns_offsets->monotonic_time_offset = off->val;
+			break;
+		case CLOCK_BOOTTIME:
+			ns_offsets->monotonic_boottime_offset = off->val;
+			break;
+		default:
+			goto out;
+		}
+	}
+
+	err = 0;
+out:
+	put_time_ns(time_ns);
+
+	return err;
+}
+
 static void clock_timens_fixup(int clockid, struct timespec64 *val, bool to_ns)
 {
 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
-- 
2.20.1

