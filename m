Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3702529-1519933849-5-17433367913530281805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1519933849; b=au7nND+sQRfBI8BtTgQPJxiIp2S428nzTxp/dz0SqNOzwmU
    KGssJ4J9/BtIx/cBK8D+27mPiBbsClAhv8xdLCfNRuTOWUlUBb2mf7jzKwdHCQsM
    +ny7zMQ5pyGjcom9h7GORb/XMMGveqT6mA0WpoFSlNZyDRekyemvGMl9UUV5BWI5
    2JxXJKnk1JQs+t3t6DQKCpLhYfhFL+iScv31msHG0iA1+hMTxXXSYD7HVCt+AFcR
    tP15ZlCRjALqEzHozTZVnnAf60kcOOo354BYFPKgJ+Prvz0Fr0affvyv1L+DhJfd
    zDOptuP7uK6Kq8xx1XR0u4n/Da4vVvSHLmkfuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933849; bh=6fu0+0UtQR+nIMewHqf3fu9KtVko8CFtGFL
    H2vochgA=; b=vOI1jeezzPuP4Fr6rA0Mykyib81hC1zXmehh11ZB9sOEQ5SousT
    SiG3Xdazn3nN3N/Uyg+IHQfMS+lYEmExURl4/oVzDynjJWwGErS5MR5YsSBTnIBF
    Sj4ZybRcYiQGwznZ34DSeNscFiWiVTj8f2lf0c9uvBtMYMQ6ZrVf37dNZd9Xq+y1
    KltND1fGxdXKfFNx62NsP2uLAVkasYRAMQ3Fnsc9qy/Q+fNjcLZJujbYcmpaj/l9
    OWn8sWf+Z8ZKV8Mkzpos45KzBO64eccyjZPojRasCYSyjfwQBFT8aIVG0vx2Z04/
    QhtLcYkIcLL87VHMA+s3LbHltGuhTPDUDNA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034167AbeCATu1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:50:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033307AbeCATqk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:46:40 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: mszeredi@redhat.com, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, trondmy@primarydata.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com, madzcar@gmail.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH V1 04/12] audit: read container ID of a process
Date: Thu,  1 Mar 2018 14:41:07 -0500
Message-Id: <7b1511e27c3239c2d356044fe1acca1375fd9233.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
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

