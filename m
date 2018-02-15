Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1936761-1518712507-2-581884242807436468
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
    t=1518712507; b=uu2G9WBAsp1OOsV/W+qBYxFQv0s2ZlB5BuKAM+tq1Q8Cj2j
    qThnksxgd7cNMi8PRLSiNSmy+wrnX8veUY9TDvegpAJIegzp8/5dongeFSsoWEaz
    2kZ+NRk+lTrOiotpwsMKoqV3iBmwdIskkR2xPkRGXkQnb+0UsH1DW+AJhzsKHwrB
    M72gmm9B7cOD3cm81grWC6x0RDCmSYIn7fpcC1ZBNVd3TZJR+DEvuFgwfeIcSz6a
    4iWmBDK8MYpXsfC05fJO7UCuS/OVJZzgaDAqmDNT30UwBrx8V1fq4WQTOffdQcmG
    IYe2P4Udx+cVvMu5qzBg+gI80p5QP/yTCXFkOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518712507;
    bh=7LyHDoH1+bbzgoGouY3n5pIQ4NuQlq03fcOQxe7ox3Q=; b=MXoCcb5D/ar8
    w5o1yGRlQKzJJqikFWEJMJJqUx9A35NZ/fkbxXiOn6Zh2TMPwTIgxd/FxA/D4ZpY
    Kb6HBwonW6yY8RkuCjTVCHNhbvIb4i+KfXk/orW7w7BLaRjg2UD1iJFpqivwtGT4
    yelKUypiV+CmIGk1pOnaww1Z2Go2Vb5GBXiHTuN4oHT5CcKGJdfbc5aBYnujhEW1
    zj+KuZDvS5wHfM0C6lOTUt2Rc9KrGoqnOzRqS+vN5RROcRpJCSK/5UcbehgbVPcn
    I40r+JtO6opt8aH6WkfGA9cRL2AFGQFzvpRvlhgdhOfv1+sU1QdbinAAPgH3fckw
    oTZnvH89aw==
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
        id S1426045AbeBOQeo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:34:44 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:36085 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424084AbeBOQel (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 15 Feb 2018 11:34:41 -0500
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org, mtk.manpages@gmail.com,
        robert.kettler@outlook.com, manfred@colorfullife.com,
        ebiederm@xmission.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/3] ipc/msg: introduce msgctl(MSG_STAT_ANY)
Date: Thu, 15 Feb 2018 08:24:58 -0800
Message-Id: <20180215162458.10059-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180215162458.10059-1-dave@stgolabs.net>
References: <20180215162458.10059-1-dave@stgolabs.net>
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

This patch introduces a new MSG_STAT_ANY command such that
the msq ipc object permissions are ignored, and only audited
instead. In addition, I've left the lsm security hook checks
in place, as if some policy can block the call, then the user
has no other choice than just parsing the procfs file.

Reported-by: Robert Kettler <robert.kettler@outlook.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/uapi/linux/msg.h   |  1 +
 ipc/msg.c                  | 17 ++++++++++++-----
 security/selinux/hooks.c   |  1 +
 security/smack/smack_lsm.c |  1 +
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/msg.h b/include/uapi/linux/msg.h
index 5d5ab81dc9be..e4a0d9a9a9e8 100644
--- a/include/uapi/linux/msg.h
+++ b/include/uapi/linux/msg.h
@@ -7,6 +7,7 @@
 /* ipcs ctl commands */
 #define MSG_STAT 11
 #define MSG_INFO 12
+#define MSG_STAT_ANY 13
 
 /* msgrcv options */
 #define MSG_NOERROR     010000  /* no error if message is too big */
diff --git a/ipc/msg.c b/ipc/msg.c
index 0dcc6699dc53..644032335921 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -483,14 +483,14 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	memset(p, 0, sizeof(*p));
 
 	rcu_read_lock();
-	if (cmd == MSG_STAT) {
+	if (cmd == MSG_STAT || cmd == MSG_STAT_ANY) {
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
+	/* see comment for SHM_STAT_ANY */
+	if (cmd == MSG_STAT_ANY)
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
+	case MSG_STAT_ANY:
 	case IPC_STAT:
 		err = msgctl_stat(ns, msqid, cmd, &msqid64);
 		if (err < 0)
@@ -671,6 +677,7 @@ COMPAT_SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, void __user *, uptr)
 	}
 	case IPC_STAT:
 	case MSG_STAT:
+	case MSG_STAT_ANY:
 		err = msgctl_stat(ns, msqid, cmd, &msqid64);
 		if (err < 0)
 			return err;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 38f71d12206a..f87f538c83a9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5591,6 +5591,7 @@ static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case MSG_STAT:
+	case MSG_STAT_ANY:
 		perms = MSGQ__GETATTR | MSGQ__ASSOCIATE;
 		break;
 	case IPC_SET:
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d478c0940b00..193159d5acf8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3296,6 +3296,7 @@ static int smack_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 	switch (cmd) {
 	case IPC_STAT:
 	case MSG_STAT:
+	case MSG_STAT_ANY:
 		may = MAY_READ;
 		break;
 	case IPC_SET:
-- 
2.13.6

