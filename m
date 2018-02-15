Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1936761-1518712536-2-13539791482561448520
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
    t=1518712535; b=OwAXRQuNW5eqS55VSQZeKyWgl+CEw/46c+bsRj60rMu1bFN
    EwOiPS/801vfMghIkSQTnBhQnZaW235VfgfgjaXvTSB1nD6Nx/SiVYWtGiF8ncyw
    +15j1J8rX60iL1O//yJwh4z6UigT0NSi7C60kVXpOtYW2m7XpDXdfVfPtxUg08/G
    S8fZtBajyMX0wQt0euJPR/6NA7vjxOFlZPvcD8pF5DgMdI61sycm//FBpr+aTVce
    UrYjt/WmhObyxs0a3SLRxhMVMu9CXUEuVXkgA0zeRzi8HDTVGVuLBEKuUhAjhZq3
    4UVLPgSZApNCE4Qfum4lAqhLg15vGWxWhSPyfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518712535;
    bh=tK4PYXremrEA+4sPclg2vPS7LSvSw1VGNfscCZhIQsM=; b=dTo0d5YB0oDD
    mE7Vy9n9fztymJIJHLLJAtNhQ56x3IqcO0Ak5DwwbYm+wOFUgH+4wd+NvCfgQ0hR
    27lHsO8E4F8LI2T4hsSHivQwoA2Ddb4RlZXFw4IE3xuirk1DO5DJNZ/Iy5EkI9Ti
    tpkZM30GV98RykgbMTYYlQfPIocrYe1BS78RHBk2QjIOVrJdM7NLqDUMibNTfkkE
    x91hfi9bDYDTIROXWL5uEzkF//HD9mXwR8lt9qy9p+DcnFWbWxOpm3wJEEQ/md3Q
    uP10abfwPtXQ5UBx0d1qxoVyqcB0a54P7qERhIWjRbjqvchliYf4ASADexra2lMU
    4/m5bptTug==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423426AbeBOQfP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:35:15 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:49722 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426030AbeBOQef (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 15 Feb 2018 11:34:35 -0500
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org, mtk.manpages@gmail.com,
        robert.kettler@outlook.com, manfred@colorfullife.com,
        ebiederm@xmission.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/3] ipc/sem: introduce semctl(SEM_STAT_ANY)
Date: Thu, 15 Feb 2018 08:24:57 -0800
Message-Id: <20180215162458.10059-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180215162458.10059-1-dave@stgolabs.net>
References: <20180215162458.10059-1-dave@stgolabs.net>
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

This patch introduces a new SEM_STAT_ANY command such that
the sem ipc object permissions are ignored, and only audited
instead. In addition, I've left the lsm security hook checks
in place, as if some policy can block the call, then the user
has no other choice than just parsing the procfs file.

Reported-by: Robert Kettler <robert.kettler@outlook.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/uapi/linux/sem.h   |  1 +
 ipc/sem.c                  | 17 ++++++++++++-----
 security/selinux/hooks.c   |  1 +
 security/smack/smack_lsm.c |  1 +
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/sem.h b/include/uapi/linux/sem.h
index 9c3e745b0656..39a1876f039e 100644
--- a/include/uapi/linux/sem.h
+++ b/include/uapi/linux/sem.h
@@ -19,6 +19,7 @@
 /* ipcs ctl cmds */
 #define SEM_STAT 18
 #define SEM_INFO 19
+#define SEM_STAT_ANY 20
 
 /* Obsolete, used only for backwards compatibility and libc5 compiles */
 struct semid_ds {
diff --git a/ipc/sem.c b/ipc/sem.c
index a4af04979fd2..79acad0e0aa1 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1190,14 +1190,14 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 	memset(semid64, 0, sizeof(*semid64));
 
 	rcu_read_lock();
-	if (cmd == SEM_STAT) {
+	if (cmd == SEM_STAT || cmd == SEM_STAT_ANY) {
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
+	/* see comment for SHM_STAT_ANY */
+	if (cmd == SEM_STAT_ANY)
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
+	case SEM_STAT_ANY:
 		err = semctl_stat(ns, semid, cmd, &semid64);
 		if (err < 0)
 			return err;
@@ -1697,6 +1703,7 @@ COMPAT_SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, int, arg)
 		return semctl_info(ns, semid, cmd, p);
 	case IPC_STAT:
 	case SEM_STAT:
+	case SEM_STAT_ANY:
 		err = semctl_stat(ns, semid, cmd, &semid64);
 		if (err < 0)
 			return err;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 373dceede50d..38f71d12206a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5847,6 +5847,7 @@ static int selinux_sem_semctl(struct sem_array *sma, int cmd)
 		break;
 	case IPC_STAT:
 	case SEM_STAT:
+	case SEM_STAT_ANY:
 		perms = SEM__GETATTR | SEM__ASSOCIATE;
 		break;
 	default:
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 51d22b03b0ae..d478c0940b00 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3167,6 +3167,7 @@ static int smack_sem_semctl(struct sem_array *sma, int cmd)
 	case GETALL:
 	case IPC_STAT:
 	case SEM_STAT:
+	case SEM_STAT_ANY:
 		may = MAY_READ;
 		break;
 	case SETVAL:
-- 
2.13.6

