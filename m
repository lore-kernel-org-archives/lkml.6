Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1946992-1518712537-2-216642642034896768
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
    t=1518712537; b=uVOehpZ5hHPK1haAzSPaOrpx0C5v5qGKEsdQzIWzIzU4r+t
    6rdR9WErRuQao3yjBA3PkoTiJKC/MK5lybkEXqudLIEnichDs7VYB1Mwa5mJTLnk
    44q7zLq+cbYc3Gimevb2Ic25iYCoKKesj/pCjVHfWzSMhPPMh3xjudYcw6QcGUAB
    DyPhoKBW71AclkeRkiSOnQVF14qsB6cGKdrf0bbWpRlFGh2m3ZbEgvE+mMmENSyu
    It2dprWE4O40bqB/AVuEi9UC07o+7YT74bmZdsSxzHhqtjugE3wmjYd1WcttOTSR
    6zRexNNI8nOX+zPWUArnNWOme6/WUufUmYeTTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518712537;
    bh=Gsq3+GgqA5o+Pk30agDCpisxt+uDPkw0CwAZuNnD3/M=; b=qE8yFhNebJvg
    6w1rKDvthDtp5Zsk6IOshufHkV+1EPpvRCJmvdyYhdzrf9VMUxnghCfImcIUX8wF
    N4rK09v8YmPZhMy921t/0CTNZij8onYI9HD3iwa8U7sscr/CAYOlsl1G5XxfLlnm
    y6NIOm+qtxH4MmDL911QALZNFwd9C75ogX+pes/C1S2lvVdKG+UpO7wawosMJ1yS
    tkBOs/bF3SIdZCOxXC+xtm2AKEX+YaZqRN48e6D4iu4o02HutZiX4KUo0cN3BtBj
    FP2s+drqQuNhYUIfB1kMOKleVXQhcQJMDyl9itgKCQgv7I7epMRkEf8zxFOR5JxV
    ID5a1TXmgQ==
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
        id S1426022AbeBOQee (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:34:34 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:58178 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425903AbeBOQed (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 15 Feb 2018 11:34:33 -0500
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org, mtk.manpages@gmail.com,
        robert.kettler@outlook.com, manfred@colorfullife.com,
        ebiederm@xmission.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/3] ipc/shm: introduce shmctl(SHM_STAT_ANY)
Date: Thu, 15 Feb 2018 08:24:56 -0800
Message-Id: <20180215162458.10059-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180215162458.10059-1-dave@stgolabs.net>
References: <20180215162458.10059-1-dave@stgolabs.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is a permission discrepancy when consulting shm ipc
object metadata between /proc/sysvipc/shm (0444) and the
SHM_STAT shmctl command. The later does permission checks
for the object vs S_IRUGO. As such there can be cases where
EACCESS is returned via syscall but the info is displayed
anyways in the procfs files.

While this might have security implications via info leaking
(albeit no writing to the shm metadata), this behavior goes
way back and showing all the objects regardless of the
permissions was most likely an overlook - so we are stuck
with it. Furthermore, modifying either the syscall or the
procfs file can cause userspace programs to break (ie ipcs).
Some applications require getting the procfs info (without
root privileges) and can be rather slow in comparison with
a syscall -- up to 500x in some reported cases.

This patch introduces a new SHM_STAT_ANY command such that
the shm ipc object permissions are ignored, and only audited
instead. In addition, I've left the lsm security hook checks
in place, as if some policy can block the call, then the user
has no other choice than just parsing the procfs file.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/uapi/linux/shm.h   |  5 +++--
 ipc/shm.c                  | 23 ++++++++++++++++++-----
 security/selinux/hooks.c   |  1 +
 security/smack/smack_lsm.c |  1 +
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/shm.h b/include/uapi/linux/shm.h
index 4de12a39b075..dde1344f047c 100644
--- a/include/uapi/linux/shm.h
+++ b/include/uapi/linux/shm.h
@@ -83,8 +83,9 @@ struct shmid_ds {
 #define SHM_UNLOCK 	12
 
 /* ipcs ctl commands */
-#define SHM_STAT 	13
-#define SHM_INFO 	14
+#define SHM_STAT	13
+#define SHM_INFO	14
+#define SHM_STAT_ANY    15
 
 /* Obsolete, used only for backwards compatibility */
 struct	shminfo {
diff --git a/ipc/shm.c b/ipc/shm.c
index 4643865e9171..60827d9c3716 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -915,14 +915,14 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	memset(tbuf, 0, sizeof(*tbuf));
 
 	rcu_read_lock();
-	if (cmd == SHM_STAT) {
+	if (cmd == SHM_STAT || cmd == SHM_STAT_ANY) {
 		shp = shm_obtain_object(ns, shmid);
 		if (IS_ERR(shp)) {
 			err = PTR_ERR(shp);
 			goto out_unlock;
 		}
 		id = shp->shm_perm.id;
-	} else {
+	} else { /* IPC_STAT */
 		shp = shm_obtain_object_check(ns, shmid);
 		if (IS_ERR(shp)) {
 			err = PTR_ERR(shp);
@@ -930,9 +930,20 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 		}
 	}
 
-	err = -EACCES;
-	if (ipcperms(ns, &shp->shm_perm, S_IRUGO))
-		goto out_unlock;
+	/*
+	 * Semantically SHM_STAT_ANY ought to be identical to
+	 * that functionality provided by the /proc/sysvipc/
+	 * interface. As such, only audit these calls and
+	 * do not do traditional S_IRUGO permission checks on
+	 * the ipc object.
+	 */
+	if (cmd == SHM_STAT_ANY)
+		audit_ipc_obj(&shp->shm_perm);
+	else {
+		err = -EACCES;
+		if (ipcperms(ns, &shp->shm_perm, S_IRUGO))
+			goto out_unlock;
+	}
 
 	err = security_shm_shmctl(shp, cmd);
 	if (err)
@@ -1072,6 +1083,7 @@ SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, struct shmid_ds __user *, buf)
 		return err;
 	}
 	case SHM_STAT:
+	case SHM_STAT_ANY:
 	case IPC_STAT: {
 		err = shmctl_stat(ns, shmid, cmd, &sem64);
 		if (err < 0)
@@ -1245,6 +1257,7 @@ COMPAT_SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, void __user *, uptr)
 		return err;
 	}
 	case IPC_STAT:
+	case SHM_STAT_ANY:
 	case SHM_STAT:
 		err = shmctl_stat(ns, shmid, cmd, &sem64);
 		if (err < 0)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 35ef1e9045e8..373dceede50d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5734,6 +5734,7 @@ static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case SHM_STAT:
+	case SHM_STAT_ANY:
 		perms = SHM__GETATTR | SHM__ASSOCIATE;
 		break;
 	case IPC_SET:
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 03fdecba93bb..51d22b03b0ae 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3034,6 +3034,7 @@ static int smack_shm_shmctl(struct shmid_kernel *shp, int cmd)
 	switch (cmd) {
 	case IPC_STAT:
 	case SHM_STAT:
+	case SHM_STAT_ANY:
 		may = MAY_READ;
 		break;
 	case IPC_SET:
-- 
2.13.6

