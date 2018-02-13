Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-570328-1518544283-2-16438055584585521610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518544282; b=R+oPIfwXZscQP+cP29SNT6i16aRu870oSmThdaYokct3laX
    11+gVGqzuSoJbVzAmeG1rvp7tJLjqFNOaFWHgGncZp23PI4MNAr6Uapywcu+sJ4Y
    sLIr5eEHOSKjsDje/gxgMHo8UeF0cWdXC75TlzYZdGARU8tJcC6j/0C3UnfaKkxy
    tDQRUH5hBpHRjd1i5s8C73qGQZ3zo6bbOhV6bIQJtcchVtH4iQStt5LPuoYRkCeH
    f6PJKH4VQmqZ3v10BlnlqNkNseWB2b4phfDJeFkM1pUS1G3J/ctweWgKv9Mg/n2i
    T/AQ+blwEm5OkdYihYiTEDTDdih/obXO0MjneLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518544282;
    bh=eOcQUgP5i0GPKGXBkTHq6Vbdc7IyeXLaUWQFykKdsbM=; b=vwK1Q9wtS3dl
    ad+QjvFrpXQKy3VbI8L1hBAG143pocs1QqsLaoOClEMgO0cvtoWL5d5cnXXXmuXu
    HzMSoy/n0p0Iw1W7ndj2j+UhbulOcraaTzGW7Wu4o8LtsFFtxTlawgPScgOdybUf
    P9OePoObYtiwUzs41U3TMcDccjHnlxURkURCVdGLw/NVqMFQxqXb4mpFu/iWd1eX
    q2V8VZyrZD9B0lcHYv40JdvAkMk3K+maeNB5Wj+FOI/kXcvT7NqpDms6lfstuTv8
    otaKWR5kO21GCxnw9kF6ner43ubw+iStna2LUCmq5Hlote8WZY2lkeMnd8Yulk0o
    Xb5ukua3oQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965549AbeBMRvK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 12:51:10 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:33953 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965411AbeBMRvI (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Tue, 13 Feb 2018 12:51:08 -0500
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org, mtk.manpages@gmail.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/3] ipc/sem: introduce shmctl(SEM_STAT_ALL)
Date: Tue, 13 Feb 2018 09:41:35 -0800
Message-Id: <20180213174136.6346-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180213174136.6346-1-dave@stgolabs.net>
References: <20180213174136.6346-1-dave@stgolabs.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is a permission discrepancy when consulting shm ipc
object metadata between /proc/sysvipc/sem (0444) and the
SEM_STAT semctl command. The later does permission checks
for the object vs S_IRUGO. As such there can be cases where
EACCESS is returned via syscall but the info is displayed
anyways in the procfs files.

While this might have security implications via info leaking
(albeit no writing to the sma metadata), this behavior goes
way back and showing all the objects regardless of the
permissions was most likely an overlook - so we are stuck
with it. Furthermore, modifying either the syscall or the
procfs file can cause userspace programs to break (ie ipcs).
Some applications require getting the procfs info (without
root privileges) and can be rather slow in comparison with
a syscall -- up to 500x in some reported cases for shm.

This patch introduces a new SEM_STAT_ALL command such that
the sem ipc object permissions are ignored, and only audited
instead. In addition, I've left the lsm security hook checks
in place, as if some policy can block the call, then the user
has no other choice than just parsing the procfs file.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/uapi/linux/sem.h |  1 +
 ipc/sem.c                | 17 ++++++++++++-----
 security/selinux/hooks.c |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/sem.h b/include/uapi/linux/sem.h
index 9c3e745b0656..fde93f635660 100644
--- a/include/uapi/linux/sem.h
+++ b/include/uapi/linux/sem.h
@@ -19,6 +19,7 @@
 /* ipcs ctl cmds */
 #define SEM_STAT 18
 #define SEM_INFO 19
+#define SEM_STAT_ALL 20
 
 /* Obsolete, used only for backwards compatibility and libc5 compiles */
 struct semid_ds {
diff --git a/ipc/sem.c b/ipc/sem.c
index a4af04979fd2..cb2737c7f1d6 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1190,14 +1190,14 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 	memset(semid64, 0, sizeof(*semid64));
 
 	rcu_read_lock();
-	if (cmd == SEM_STAT) {
+	if (cmd == SEM_STAT || cmd == SEM_STAT_ALL) {
 		sma = sem_obtain_object(ns, semid);
 		if (IS_ERR(sma)) {
 			err = PTR_ERR(sma);
 			goto out_unlock;
 		}
 		id = sma->sem_perm.id;
-	} else {
+	} else { /* IPC_STAT */
 		sma = sem_obtain_object_check(ns, semid);
 		if (IS_ERR(sma)) {
 			err = PTR_ERR(sma);
@@ -1205,9 +1205,14 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 		}
 	}
 
-	err = -EACCES;
-	if (ipcperms(ns, &sma->sem_perm, S_IRUGO))
-		goto out_unlock;
+	/* see comment for SHM_STAT_ALL */
+	if (cmd == SEM_STAT_ALL)
+		audit_ipc_obj(&sma->sem_perm);
+	else {
+		err = -EACCES;
+		if (ipcperms(ns, &sma->sem_perm, S_IRUGO))
+			goto out_unlock;
+	}
 
 	err = security_sem_semctl(sma, cmd);
 	if (err)
@@ -1596,6 +1601,7 @@ SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
 		return semctl_info(ns, semid, cmd, p);
 	case IPC_STAT:
 	case SEM_STAT:
+	case SEM_STAT_ALL:
 		err = semctl_stat(ns, semid, cmd, &semid64);
 		if (err < 0)
 			return err;
@@ -1697,6 +1703,7 @@ COMPAT_SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, int, arg)
 		return semctl_info(ns, semid, cmd, p);
 	case IPC_STAT:
 	case SEM_STAT:
+	case SEM_STAT_ALL:
 		err = semctl_stat(ns, semid, cmd, &semid64);
 		if (err < 0)
 			return err;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dc2a9a0f6ddf..aa965742bba9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5847,6 +5847,7 @@ static int selinux_sem_semctl(struct sem_array *sma, int cmd)
 		break;
 	case IPC_STAT:
 	case SEM_STAT:
+	case SEM_STAT_ALL:
 		perms = SEM__GETATTR | SEM__ASSOCIATE;
 		break;
 	default:
-- 
2.13.6

