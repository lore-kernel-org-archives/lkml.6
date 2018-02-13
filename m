Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-570328-1518544319-2-3484431511395836007
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
    t=1518544318; b=uF1P2FT0j+rRV0vmo1ZRLVUrE1++Y/RlOmpYPtrXxZY4P1g
    RvA+pndQJ+WjoUfXzwyf8rtvPGYrR4W7C07vitQ6inIyr8clvOekQplZPKYzpC3c
    Ang0oD7+p1EK3gTtLuu6nWrCU/bNOF72zExXh6am/EADe7kaTCPjhVg4BtRgkZ/Q
    7yB4gifD07WrzSmnOlatZGMZtPsVAy0kqFe2d062UKtctMhZoDPZBHJcG0g3XOc/
    GUJ1dUqKcHrMXq33fjjeUWHe4zb9qmnlPdsjoTGQfhSVk0yPjYFoyYD5KyyOVQjd
    KxY4lzOO1wQA9dT777hDrrwHpaTgK+16bVw268Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518544318;
    bh=yjqcIN8aBu6SqvwDASeWz5xr2nORIIYhbBhERjS/+8g=; b=g0eZ8KI9E7oA
    DNCLzUH/mJji5qPmAZuIsLGjYRX46lYMFYYaLmoWRGVmuwutJtyngiNvKBWgbh1B
    myrZgb+ZMnhK4rrPqRVUEBnaA6dw6ym8dPUN+pw3ZYllYemtwXKQBmZs98phUDby
    FJZ42mZkNsf5IGbgWjii9AUPvUhVsOn08i6Oy/MriklJ+g2i54BAhHpvc/R+aJi/
    ssflKcDfjYUt5XuKd8wQ8iTBCWhRfqxal9pie5i8mN5Ek/jKTcZ24DOaKlH0d0bN
    qh9d8Fy76s0BK2FbyBOvVT1k7EcnKayZAbMcpNstyrskP8HpMciqg5+vE+bISL+z
    wb2h/n+PIw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965206AbeBMRvj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 12:51:39 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:48751 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965310AbeBMRvJ (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Tue, 13 Feb 2018 12:51:09 -0500
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org, mtk.manpages@gmail.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/3] ipc/msg: introduce shmctl(MSG_STAT_ALL)
Date: Tue, 13 Feb 2018 09:41:36 -0800
Message-Id: <20180213174136.6346-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180213174136.6346-1-dave@stgolabs.net>
References: <20180213174136.6346-1-dave@stgolabs.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is a permission discrepancy when consulting msq ipc
object metadata between /proc/sysvipc/msg (0444) and the
MSG_STAT shmctl command. The later does permission checks
for the object vs S_IRUGO. As such there can be cases where
EACCESS is returned via syscall but the info is displayed
anyways in the procfs files.

While this might have security implications via info leaking
(albeit no writing to the msq metadata), this behavior goes
way back and showing all the objects regardless of the
permissions was most likely an overlook - so we are stuck
with it. Furthermore, modifying either the syscall or the
procfs file can cause userspace programs to break (ie ipcs).
Some applications require getting the procfs info (without
root privileges) and can be rather slow in comparison with
a syscall -- up to 500x in some reported cases for shm.

This patch introduces a new MSG_STAT_ALL command such that
the msq ipc object permissions are ignored, and only audited
instead. In addition, I've left the lsm security hook checks
in place, as if some policy can block the call, then the user
has no other choice than just parsing the procfs file.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/uapi/linux/msg.h |  1 +
 ipc/msg.c                | 17 ++++++++++++-----
 security/selinux/hooks.c |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/msg.h b/include/uapi/linux/msg.h
index 5d5ab81dc9be..fe9bdfb25a2f 100644
--- a/include/uapi/linux/msg.h
+++ b/include/uapi/linux/msg.h
@@ -7,6 +7,7 @@
 /* ipcs ctl commands */
 #define MSG_STAT 11
 #define MSG_INFO 12
+#define MSG_STAT_ALL 13
 
 /* msgrcv options */
 #define MSG_NOERROR     010000  /* no error if message is too big */
diff --git a/ipc/msg.c b/ipc/msg.c
index 0dcc6699dc53..533c9ac2fb13 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -483,14 +483,14 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	memset(p, 0, sizeof(*p));
 
 	rcu_read_lock();
-	if (cmd == MSG_STAT) {
+	if (cmd == MSG_STAT || cmd == MSG_STAT_ALL) {
 		msq = msq_obtain_object(ns, msqid);
 		if (IS_ERR(msq)) {
 			err = PTR_ERR(msq);
 			goto out_unlock;
 		}
 		id = msq->q_perm.id;
-	} else {
+	} else { /* IPC_STAT */
 		msq = msq_obtain_object_check(ns, msqid);
 		if (IS_ERR(msq)) {
 			err = PTR_ERR(msq);
@@ -498,9 +498,14 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 		}
 	}
 
-	err = -EACCES;
-	if (ipcperms(ns, &msq->q_perm, S_IRUGO))
-		goto out_unlock;
+	/* see comment for SHM_STAT_ALL */
+	if (cmd == MSG_STAT_ALL)
+		audit_ipc_obj(&msq->q_perm);
+	else {
+		err = -EACCES;
+		if (ipcperms(ns, &msq->q_perm, S_IRUGO))
+			goto out_unlock;
+	}
 
 	err = security_msg_queue_msgctl(msq, cmd);
 	if (err)
@@ -558,6 +563,7 @@ SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, struct msqid_ds __user *, buf)
 		return err;
 	}
 	case MSG_STAT:	/* msqid is an index rather than a msg queue id */
+	case MSG_STAT_ALL:
 	case IPC_STAT:
 		err = msgctl_stat(ns, msqid, cmd, &msqid64);
 		if (err < 0)
@@ -671,6 +677,7 @@ COMPAT_SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, void __user *, uptr)
 	}
 	case IPC_STAT:
 	case MSG_STAT:
+	case MSG_STAT_ALL:
 		err = msgctl_stat(ns, msqid, cmd, &msqid64);
 		if (err < 0)
 			return err;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index aa965742bba9..457e80f6b4e7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5591,6 +5591,7 @@ static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case MSG_STAT:
+	case MSG_STAT_ALL:
 		perms = MSGQ__GETATTR | MSGQ__ASSOCIATE;
 		break;
 	case IPC_SET:
-- 
2.13.6

