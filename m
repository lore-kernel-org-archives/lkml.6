Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-570328-1518544269-2-13902428379520448320
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
    t=1518544268; b=C3545E9KsCYlnII8aGyVm+fLPI/1ll3QNiH0daBseEYPlo/
    5st0vXh4ZaDP9B5b8yz/i/9+97BJNA9wFHr75q36wZkG+NJqEG6hkTCszzSy+xbu
    PcpIyC4jtbWeiAK7qEyhtcuERD9oiwutAYWAKK7byEGkzHIZBZsG7j2koqTO2XRe
    P7t1Avh4bBwQxsBpRhaQwlYJWwbezgpMUPe44G6Vx8RglczOA37Eh0JOuNPXR2WF
    ANHQf1zhL0D8gzrLRQpeKEsgiuBsaPRfxnGlJcK5CpzjHov+95VKsJWm5KvxRfO/
    cLBbYXcYuD583Mffv8y6b+6CUGJTHO2Z98HSL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518544268;
    bh=YEYBiYVAu68cBlc6M6xazU/JiSGkKCwSlFNP2DdBjvY=; b=p8POzNqAKUce
    ljdU9bGuMqELmeuJ/ACBiEiXpuQvHTBIQ+muum1meZhsQTM3fK6cPElp9H15gHDt
    cmz6W4/yegBRl0+RVRRzNvxARn/1XIEE9EkuwPCcCkmjhmbt5smMc/zDvXicXjnG
    7W8v+Kl59b70+ndb9jRlUa49wW4Z4/vv3CjEMHpZGQP6EXGZEW37HEYLhosdoF2A
    pEwYCiqQ2HvbU1XWDaxPN4jfUYHXGDvTXVhxYLBaDSDFyhWlJ8TJq0UpEOiFqqPk
    Iznaawgl6TV73iIiCO3aXJSbl/D1viTDTaPzLXTCsUsq9dk+CGyTglzrOTPS5410
    SjhKj0a0Ug==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965440AbeBMRvG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 12:51:06 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:59111 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965419AbeBMRvE (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Tue, 13 Feb 2018 12:51:04 -0500
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org, mtk.manpages@gmail.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/3] ipc/shm: introduce shmctl(SHM_STAT_ALL)
Date: Tue, 13 Feb 2018 09:41:34 -0800
Message-Id: <20180213174136.6346-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180213174136.6346-1-dave@stgolabs.net>
References: <20180213174136.6346-1-dave@stgolabs.net>
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

This patch introduces a new SHM_STAT_ALL command such that
the shm ipc object permissions are ignored, and only audited
instead. In addition, I've left the lsm security hook checks
in place, as if some policy can block the call, then the user
has no other choice than just parsing the procfs file.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/uapi/linux/shm.h |  5 +++--
 ipc/shm.c                | 23 ++++++++++++++++++-----
 security/selinux/hooks.c |  1 +
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/shm.h b/include/uapi/linux/shm.h
index 4de12a39b075..017284fca194 100644
--- a/include/uapi/linux/shm.h
+++ b/include/uapi/linux/shm.h
@@ -83,8 +83,9 @@ struct shmid_ds {
 #define SHM_UNLOCK 	12
 
 /* ipcs ctl commands */
-#define SHM_STAT 	13
-#define SHM_INFO 	14
+#define SHM_STAT	13
+#define SHM_INFO	14
+#define SHM_STAT_ALL    15
 
 /* Obsolete, used only for backwards compatibility */
 struct	shminfo {
diff --git a/ipc/shm.c b/ipc/shm.c
index 4643865e9171..a84b45b4f50f 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -915,14 +915,14 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	memset(tbuf, 0, sizeof(*tbuf));
 
 	rcu_read_lock();
-	if (cmd == SHM_STAT) {
+	if (cmd == SHM_STAT || cmd == SHM_STAT_ALL) {
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
+	 * Semantically SHM_STAT_ALL ought to be identical to
+	 * that functionality provided by the /proc/sysvipc/
+	 * interface. As such, only audit these calls and
+	 * do not do traditional S_IRUGO permission checks on
+	 * the ipc object.
+	 */
+	if (cmd == SHM_STAT_ALL)
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
+	case SHM_STAT_ALL:
 	case IPC_STAT: {
 		err = shmctl_stat(ns, shmid, cmd, &sem64);
 		if (err < 0)
@@ -1245,6 +1257,7 @@ COMPAT_SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, void __user *, uptr)
 		return err;
 	}
 	case IPC_STAT:
+	case SHM_STAT_ALL:
 	case SHM_STAT:
 		err = shmctl_stat(ns, shmid, cmd, &sem64);
 		if (err < 0)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 35ef1e9045e8..dc2a9a0f6ddf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5734,6 +5734,7 @@ static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case SHM_STAT:
+	case SHM_STAT_ALL:
 		perms = SHM__GETATTR | SHM__ASSOCIATE;
 		break;
 	case IPC_SET:
-- 
2.13.6

