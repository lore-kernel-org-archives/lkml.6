Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3702529-1519933670-2-1458725780441597728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519933670; b=TaFTLzG51LXIh1xFIwelMbN9zGi4IL7k290HrI4KJ+AuZC+
    q4RG3NXM3NBVahnjWC93TQNZPySzRUKhw14SXzbvSO0on44jtLRkidmTwMQL9aOi
    28ARcaH/qb2c8P2kW9rCTxzuB3fQFXjAXkk+tdLUyv1O6gU1FZwKel/1CSGDAdIN
    u7VqYLSqm1O09bEURc8j053tXnLsuFILID9njKxFVXS9PlAAEvghuWpSSk5H70ci
    4NwQQ40jdCvrMneMc1WglPwt1m6lpWm6IlqViUVgqMBGeJIC+EHebTGEG6Ix0OAR
    p8c/xX/b+dtG9QzUoyHxvqqPvziT83OmGuiNWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933670; bh=KPkLRXR46ZNILbcUN483Yuwg82ELDYJn3gH
    Mhi+lSSo=; b=IH++1fUVxQCtQqQ2auzveaP4TjfVJL9k51t0CdAIZ6h4XF9E8+i
    4bTRVRmIF3SLDLGqRj6dWU85y1YGrw7nU/UVdJF5fYVJ4kDjiA7Gu9AACVa6ZZjq
    ua0hwFE+SZ6XH37CsNKkHwokU6QNf1wciEZ1Z17rVk79Nilw0FOVWNZZgENG5KSi
    GZaeByrzcNe0sQUhYHkqNceX2VvH/RotJxIMmawyf8nVGeH5YI1jCisFe6UTiwpJ
    flHH43ffj2POTB2L7jHVsMitnB9TApCbig4v0wrp4LlZess+d5BeL5n65Etcn5kb
    CbB6mXNm4wTImybzwBo9cryHkrJgi1KSDSA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034213AbeCATrf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:47:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033812AbeCATrc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:47:32 -0500
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
Subject: [RFC PATCH V1 12/12] debug! audit: add container id
Date: Thu,  1 Mar 2018 14:41:15 -0500
Message-Id: <c6da3e0fe8cdd173cf9d5cd090229d3f215bc590.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Debugging code for verbose output to aid in development.
---
 fs/proc/base.c   | 10 ++++++++++
 kernel/auditsc.c | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f66d1e2..63d1ca4 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1309,9 +1309,13 @@ static ssize_t proc_containerid_read(struct file *file, char __user *buf,
 	char tmpbuf[TMPBUFLEN*2];
 
 	if (!task)
+	{
+		pr_info("no inode owner");
 		return -ESRCH;
+	}
 	length = scnprintf(tmpbuf, TMPBUFLEN*2, "%llu", audit_get_containerid(task));
 	put_task_struct(task);
+	pr_info("read: pid=%d opid=%d contid=%llu", pid_nr(task_tgid(current)), pid_nr(task_tgid(task)), audit_get_containerid(task));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -1324,14 +1328,19 @@ static ssize_t proc_containerid_write(struct file *file, const char __user *buf,
 	struct task_struct *task = get_proc_task(inode);
 
 	if (!task)
+	{
+		pr_info("no inode owner");
 		return -ESRCH;
+	}
 	if (*ppos != 0) {
 		/* No partial writes. */
 		put_task_struct(task);
+		pr_info("no partial writes");
 		return -EINVAL;
 	}
 
 	rv = kstrtou64_from_user(buf, count, 10, &containerid);
+	pr_info("write: pid=%d rv=%d count=%ld opid=%d contid=%llu", task_tgid_nr(current), rv, count, task_tgid_nr(task), containerid);
 	if (rv < 0) {
 		put_task_struct(task);
 		return rv;
@@ -1339,6 +1348,7 @@ static ssize_t proc_containerid_write(struct file *file, const char __user *buf,
 
 	rv = audit_set_containerid(task, containerid);
 	put_task_struct(task);
+	//pr_info("audit_set_containerid: rv=%d", rv);
 	if (rv < 0)
 		return rv;
 	return count;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index fcee34e..39e7dc10 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2111,16 +2111,28 @@ static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
 
 	/* Don't allow to set our own containerid */
 	if (current == task)
+	{
+		pr_info("pid=%d can't set own containerid", task_tgid_nr(task));
 		return -EPERM;
+	}
 	/* Don't allow the containerid to be unset */
 	if (!cid_valid(containerid))
+	{
+		pr_info("can't unset containerid");
 		return -EINVAL;
+	}
 	/* if we don't have caps, reject */
 	if (!capable(CAP_AUDIT_CONTROL))
+	{
+		pr_info("don't have CAP_AUDIT_CONTROL");
 		return -EPERM;
+	}
 	/* if containerid is unset, allow */
 	if (!audit_containerid_set(task))
+	{
+		//pr_info("unset, allow");
 		return 0;
+	}
 	/* it is already set, and not inherited from the parent, reject */
 	ccontainerid = audit_get_containerid(task);
 	rcu_read_lock();
@@ -2131,7 +2143,11 @@ static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
 	ppid = task_tgid_nr(parent);
 	task_unlock(parent);
 	if (ccontainerid != pcontainerid)
+	{
+		pr_info("pid=%d already has contid=%llu set, not inherited from ppid=%d with contid=%llu, can't set containerid %llu",
+			task_tgid_nr(task), ccontainerid, ppid, pcontainerid, containerid);
 		return -EPERM;
+	}
 	return 0;
 }
 
-- 
1.8.3.1

