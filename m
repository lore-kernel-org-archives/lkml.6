Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2539098-1521191274-2-8316368222801145979
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521191273; b=KnyxGiDthDLNfuQKx7gPQrw0/j5XSBd09Vekcmpl/QDSK2Q
    K4o2DInk/QDhltpc2qRvEPvtVwPLN6s3vifKaUDx4WojcE+wyc+OCT0Zq640pEXV
    pQUpU3t4qZp9ied7rJKQrCifozvBnS75A6jWBfdHauz0GGvFF299uWD0zUuxnwot
    KL2hB3r/Di+AWfv3Re+45nAKo0eXkBoGdp8DlgX/LgiidPi/wmrmF1ClZNujibmq
    SWo9b3vpyHw3uUzTipETLF8FfJWsCvQeUnRKYDDTlyWkjv1iYfoAvm8uL7XvsD3g
    zg0j8S5j9Hi/t5j7i0HwRpruHLMqQw5lf4ocxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521191273; bh=6fu0+0UtQR+nIMewHqf3fu9KtVko8CFtGFL
    H2vochgA=; b=th0FT/9s9wj/H19Ixeq0QXLDIGuT5Gj7KayhBPe8f253CaWCDnx
    uYMvf2Chv3Z0krv4oxx+1dkDmcsmMftPTyBbNsq82+lT/+ulS/rM9xx2DYQ0/fAQ
    fTi7ksDHsxiZxGx0M8LVsTGlbb1if7RUBFX4vdTmXuuro1VOIrKqU1K/wlbLC4Ut
    RsPM6KYQ8cjxFyZQLYC+cB+SUH/dKW6U7zMnRpZO8DSgB3DThPDO4Ok3sJyW51mr
    L8xK4lEmUYjKh1zYusBQbz91yY6Jed95d0WmtL9mSR2c0S2p+4xahIcCgroY30no
    1qW8scnhVEp/ZCJ6HCRK8YCqUkITyLVsNew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeCPJHc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:07:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753519AbeCPJH3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:07:29 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: luto@kernel.org, jlayton@redhat.com, carlos@redhat.com,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        madzcar@gmail.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak32 V2 13/13] debug audit: read container ID of a process
Date: Fri, 16 Mar 2018 05:00:40 -0400
Message-Id: <1081821010c124fe4e35984ec3dac1654453bb7c.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for reading the container ID from the proc filesystem.

This is a read from the proc entry of the form /proc/PID/containerid
where PID is the process ID of the task whose container ID is sought.

The read expects up to a u64 value (unset: 18446744073709551615).

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/proc/base.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6ce4fbe..f66d1e2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1300,6 +1300,21 @@ static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t proc_containerid_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct task_struct *task = get_proc_task(inode);
+	ssize_t length;
+	char tmpbuf[TMPBUFLEN*2];
+
+	if (!task)
+		return -ESRCH;
+	length = scnprintf(tmpbuf, TMPBUFLEN*2, "%llu", audit_get_containerid(task));
+	put_task_struct(task);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
 static ssize_t proc_containerid_write(struct file *file, const char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -1330,6 +1345,7 @@ static ssize_t proc_containerid_write(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations proc_containerid_operations = {
+	.read		= proc_containerid_read,
 	.write		= proc_containerid_write,
 	.llseek		= generic_file_llseek,
 };
@@ -2996,7 +3012,7 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
 	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
-	REG("containerid", S_IWUSR, proc_containerid_operations),
+	REG("containerid", S_IWUSR|S_IRUSR, proc_containerid_operations),
 #endif
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
@@ -3391,7 +3407,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
 	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
-	REG("containerid", S_IWUSR, proc_containerid_operations),
+	REG("containerid", S_IWUSR|S_IRUSR, proc_containerid_operations),
 #endif
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
-- 
1.8.3.1

