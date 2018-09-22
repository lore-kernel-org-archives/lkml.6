Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF76ECE567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BA921523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Zt70wU3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BA921523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392251AbeIVGLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:11:35 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:41629 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391706AbeIVGLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575613; bh=2CGCJEUpF3YIrHqqWt89ryNw4AuWxu0q3zbKjNwCFek=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=Zt70wU3coh7BnIzTcgfjNyzRBYcG5sg53BT11QgWdrg5fh329N2nVn7yg/qcq3bFtZZwaxWHistjBVNMCswtvAcME/9K9kXRuXcsRAQHA1Ngj9g6dgmSr+z7McNQiWWhbB/0MNljarsqX2gKm6/1ri8QucPC/a3Dph/4SvR9QN1tXRrZ1JlwBDAMj5Omr9kmZdhkyy1XEuu+wBCunIAm5hxhq0Y5WovkE/VzxxUd2wUcel/fYhAw4Rl4imoEBG0jJjEnKAtQcBRMz1hG1aLiaEAD3z0UfDwpZIH/LmeNBEJ74ExZpvQfF2FeXuqTWd6+5NMwLYchbdS2aGKso8Pjyg==
X-YMail-OSG: zopfscAVM1kzd8GLoKHQh168FGD7WRVL.eZgsuYh_iKEd9Atzwofh3jymOxie79
 wZbzeyzdNRBm65ev4I.zH7hVPMa0wjta7gqF7W78jOP9S8pWUMzq_NJOPMr28y.5z31CT7oVRdZk
 9fWeF7yDxxPqLzw9IhyjKrIgxLOT9PMPDnng_sAmsJS8BNV9FjmEyaU2MdwJsL9tgMgjoVqLM7id
 soa8aVSZSpb139sQjLjJHHss0uZg1pMtTwfjU9vtU9PYjuHnaBls.IzTRm5NkvbVz0Trb5vURRsM
 6W8sgC3pGHiQi.AUL4zEPVUa246pgSE_M422Mu0cXCqy4U5oNBSIu51RJqYWMlR0Egun2nb4M_st
 _puUx3__1uDG2DdGOw50G8teWiM3ICJwOywIYb85os0HYLRyXVDDE_Ek8klcVMBlqilnsvVKyvZE
 47W76JH5q.X9WdVM6enVgWxWyb6UzN_gFBhNPfj5nl0dvdw8Sfy3pYWvGUSHQg37NIFX8SVNu03Y
 yJp0kBrGn74e.wbB52SGMghOyMhJSMaQON2WqJx1Flwh9OyGcdnFooFAFuwlQXbZCTiYQh7zHbp1
 KaQle8.IiRjdI47ycbLJ1iQmZcP0lahRKvIlJkPUTqg.rn3E0LXmoiY29XcQ2NfXmkdJ8Oz8tlVw
 M5ePN_ctteElviETh58_5WF2G.siP9sXOdQV6qOYQjyT5eT6M3IcMhgg1M.UxmKmBw2U1WJ5.zrY
 l9Fx1Yq3TRCyLA_kgjtZtCFNvZq_zlR7dbv38Ut_r3ZQfIFAaLd3XcRdCZs5N1CBxFfHUdDTWLhz
 bj_jX21I2W0ajPlfa0RcdeIXpRTE8qLKimtUv97gVvbONqIbL5.K4N.HpozH0Q1WphUXWmLOupzc
 fqQvjyVWFhtLJ9DhUOLbrDu1qqEm5tgf8XRc4vhLl3MuCX5JQRj0KTpxXwIcTWo2Pgi2qoDNOdos
 oZbmKPQqQl7jLsna0YUQCP._V50tlh95MvYVBlET8pkgBaTx.KRXsFruqFUWuXxswMhVeCOe1Qpm
 eiqjbVP95y.NxqG6CjbhPi7v2kcNAEUUBX8uEdse9fQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:20:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp405.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4d7b45fd86c4ff0833c661a0082d9044;
          Sat, 22 Sep 2018 00:20:09 +0000 (UTC)
Subject: [PATCH v4 18/19] LSM: Infrastructure management of the ipc security
 blob
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4e4a7033-a86d-a30f-7420-acd765f90534@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:20:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move management of the kern_ipc_perm->security and
msg_msg->security blobs out of the individual security
modules and into the security infrastructure. Instead
of allocating the blobs from within the modules the modules
tell the infrastructure how much space is required, and
the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  2 +
 security/security.c        | 91 +++++++++++++++++++++++++++++++++--
 security/selinux/hooks.c   | 98 +++++---------------------------------
 security/smack/smack.h     |  4 +-
 security/smack/smack_lsm.c | 32 ++-----------
 5 files changed, 108 insertions(+), 119 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6057c603b979..f6dbde28833a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2031,6 +2031,8 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_ipc;
+	int	lbs_msg_msg;
 	int	lbs_task;
 };
 
diff --git a/security/security.c b/security/security.c
index 7e11de7eec21..a151d728aed2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
 #include <linux/string.h>
+#include <linux/msg.h>
 #include <net/flow.h>
 
 #include <trace/events/initcall.h>
@@ -117,6 +118,8 @@ int __init security_init(void)
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
 	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
+	pr_info("LSM: ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+	pr_info("LSM: msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 #endif
 
@@ -302,6 +305,8 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
@@ -387,6 +392,48 @@ int lsm_task_alloc(struct task_struct *task)
 	return 0;
 }
 
+/**
+ * lsm_ipc_alloc - allocate a composite ipc blob
+ * @kip: the ipc that needs a blob
+ *
+ * Allocate the ipc blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_ipc_alloc(struct kern_ipc_perm *kip)
+{
+	if (blob_sizes.lbs_ipc == 0) {
+		kip->security = NULL;
+		return 0;
+	}
+
+	kip->security = kzalloc(blob_sizes.lbs_ipc, GFP_KERNEL);
+	if (kip->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * lsm_msg_msg_alloc - allocate a composite msg_msg blob
+ * @mp: the msg_msg that needs a blob
+ *
+ * Allocate the ipc blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_msg_msg_alloc(struct msg_msg *mp)
+{
+	if (blob_sizes.lbs_msg_msg == 0) {
+		mp->security = NULL;
+		return 0;
+	}
+
+	mp->security = kzalloc(blob_sizes.lbs_msg_msg, GFP_KERNEL);
+	if (mp->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /**
  * lsm_early_task - during initialization allocate a composite task blob
  * @task: the task that needs a blob
@@ -1468,22 +1515,40 @@ void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 
 int security_msg_msg_alloc(struct msg_msg *msg)
 {
-	return call_int_hook(msg_msg_alloc_security, 0, msg);
+	int rc = lsm_msg_msg_alloc(msg);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(msg_msg_alloc_security, 0, msg);
+	if (unlikely(rc))
+		security_msg_msg_free(msg);
+	return rc;
 }
 
 void security_msg_msg_free(struct msg_msg *msg)
 {
 	call_void_hook(msg_msg_free_security, msg);
+	kfree(msg->security);
+	msg->security = NULL;
 }
 
 int security_msg_queue_alloc(struct kern_ipc_perm *msq)
 {
-	return call_int_hook(msg_queue_alloc_security, 0, msq);
+	int rc = lsm_ipc_alloc(msq);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(msg_queue_alloc_security, 0, msq);
+	if (unlikely(rc))
+		security_msg_queue_free(msq);
+	return rc;
 }
 
 void security_msg_queue_free(struct kern_ipc_perm *msq)
 {
 	call_void_hook(msg_queue_free_security, msq);
+	kfree(msq->security);
+	msq->security = NULL;
 }
 
 int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -1510,12 +1575,21 @@ int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
 
 int security_shm_alloc(struct kern_ipc_perm *shp)
 {
-	return call_int_hook(shm_alloc_security, 0, shp);
+	int rc = lsm_ipc_alloc(shp);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(shm_alloc_security, 0, shp);
+	if (unlikely(rc))
+		security_shm_free(shp);
+	return rc;
 }
 
 void security_shm_free(struct kern_ipc_perm *shp)
 {
 	call_void_hook(shm_free_security, shp);
+	kfree(shp->security);
+	shp->security = NULL;
 }
 
 int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -1535,12 +1609,21 @@ int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmf
 
 int security_sem_alloc(struct kern_ipc_perm *sma)
 {
-	return call_int_hook(sem_alloc_security, 0, sma);
+	int rc = lsm_ipc_alloc(sma);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sem_alloc_security, 0, sma);
+	if (unlikely(rc))
+		security_sem_free(sma);
+	return rc;
 }
 
 void security_sem_free(struct kern_ipc_perm *sma)
 {
 	call_void_hook(sem_free_security, sma);
+	kfree(sma->security);
+	sma->security = NULL;
 }
 
 int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e6cb5fce5437..3c53a3ba480e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5832,51 +5832,22 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	return selinux_nlmsg_perm(sk, skb);
 }
 
-static int ipc_alloc_security(struct kern_ipc_perm *perm,
-			      u16 sclass)
+static void ipc_init_security(struct ipc_security_struct *isec, u16 sclass)
 {
-	struct ipc_security_struct *isec;
-
-	isec = kzalloc(sizeof(struct ipc_security_struct), GFP_KERNEL);
-	if (!isec)
-		return -ENOMEM;
-
 	isec->sclass = sclass;
 	isec->sid = current_sid();
-	perm->security = isec;
-
-	return 0;
-}
-
-static void ipc_free_security(struct kern_ipc_perm *perm)
-{
-	struct ipc_security_struct *isec = perm->security;
-	perm->security = NULL;
-	kfree(isec);
 }
 
 static int msg_msg_alloc_security(struct msg_msg *msg)
 {
 	struct msg_security_struct *msec;
 
-	msec = kzalloc(sizeof(struct msg_security_struct), GFP_KERNEL);
-	if (!msec)
-		return -ENOMEM;
-
+	msec = selinux_msg_msg(msg);
 	msec->sid = SECINITSID_UNLABELED;
-	msg->security = msec;
 
 	return 0;
 }
 
-static void msg_msg_free_security(struct msg_msg *msg)
-{
-	struct msg_security_struct *msec = msg->security;
-
-	msg->security = NULL;
-	kfree(msec);
-}
-
 static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 			u32 perms)
 {
@@ -5898,11 +5869,6 @@ static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
 	return msg_msg_alloc_security(msg);
 }
 
-static void selinux_msg_msg_free_security(struct msg_msg *msg)
-{
-	msg_msg_free_security(msg);
-}
-
 /* message queue security operations */
 static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 {
@@ -5911,11 +5877,8 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(msq, SECCLASS_MSGQ);
-	if (rc)
-		return rc;
-
-	isec = msq->security;
+	isec = selinux_ipc(msq);
+	ipc_init_security(isec, SECCLASS_MSGQ);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -5923,16 +5886,7 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	rc = avc_has_perm(&selinux_state,
 			  sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__CREATE, &ad);
-	if (rc) {
-		ipc_free_security(msq);
-		return rc;
-	}
-	return 0;
-}
-
-static void selinux_msg_queue_free_security(struct kern_ipc_perm *msq)
-{
-	ipc_free_security(msq);
+	return rc;
 }
 
 static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -6062,11 +6016,8 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(shp, SECCLASS_SHM);
-	if (rc)
-		return rc;
-
-	isec = shp->security;
+	isec = selinux_ipc(shp);
+	ipc_init_security(isec, SECCLASS_SHM);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
@@ -6074,16 +6025,7 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	rc = avc_has_perm(&selinux_state,
 			  sid, isec->sid, SECCLASS_SHM,
 			  SHM__CREATE, &ad);
-	if (rc) {
-		ipc_free_security(shp);
-		return rc;
-	}
-	return 0;
-}
-
-static void selinux_shm_free_security(struct kern_ipc_perm *shp)
-{
-	ipc_free_security(shp);
+	return rc;
 }
 
 static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -6159,11 +6101,8 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(sma, SECCLASS_SEM);
-	if (rc)
-		return rc;
-
-	isec = sma->security;
+	isec = selinux_ipc(sma);
+	ipc_init_security(isec, SECCLASS_SEM);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
@@ -6171,16 +6110,7 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	rc = avc_has_perm(&selinux_state,
 			  sid, isec->sid, SECCLASS_SEM,
 			  SEM__CREATE, &ad);
-	if (rc) {
-		ipc_free_security(sma);
-		return rc;
-	}
-	return 0;
-}
-
-static void selinux_sem_free_security(struct kern_ipc_perm *sma)
-{
-	ipc_free_security(sma);
+	return rc;
 }
 
 static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
@@ -6813,6 +6743,8 @@ struct lsm_blob_sizes selinux_blob_sizes = {
 	.lbs_cred = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
+	.lbs_ipc = sizeof(struct ipc_security_struct),
+	.lbs_msg_msg = sizeof(struct msg_security_struct),
 };
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
@@ -6923,24 +6855,20 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
-	LSM_HOOK_INIT(msg_msg_free_security, selinux_msg_msg_free_security),
 
 	LSM_HOOK_INIT(msg_queue_alloc_security,
 			selinux_msg_queue_alloc_security),
-	LSM_HOOK_INIT(msg_queue_free_security, selinux_msg_queue_free_security),
 	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
 	LSM_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
 	LSM_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
 
 	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
-	LSM_HOOK_INIT(shm_free_security, selinux_shm_free_security),
 	LSM_HOOK_INIT(shm_associate, selinux_shm_associate),
 	LSM_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
 	LSM_HOOK_INIT(shm_shmat, selinux_shm_shmat),
 
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
-	LSM_HOOK_INIT(sem_free_security, selinux_sem_free_security),
 	LSM_HOOK_INIT(sem_associate, selinux_sem_associate),
 	LSM_HOOK_INIT(sem_semctl, selinux_sem_semctl),
 	LSM_HOOK_INIT(sem_semop, selinux_sem_semop),
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 52cea142fcf6..dffa0ba8fd49 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -374,12 +374,12 @@ static inline struct inode_smack *smack_inode(const struct inode *inode)
 
 static inline struct smack_known **smack_msg_msg(const struct msg_msg *msg)
 {
-	return (struct smack_known **)&msg->security;
+	return msg->security;
 }
 
 static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
 {
-	return (struct smack_known **)&ipc->security;
+	return ipc->security;
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4afc8899f83f..8f3b809d7c26 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2880,23 +2880,12 @@ static int smack_flags_to_may(int flags)
  */
 static int smack_msg_msg_alloc_security(struct msg_msg *msg)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_msg_msg(msg);
 
-	msg->security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
-/**
- * smack_msg_msg_free_security - Clear the security blob for msg_msg
- * @msg: the object
- *
- * Clears the blob pointer
- */
-static void smack_msg_msg_free_security(struct msg_msg *msg)
-{
-	msg->security = NULL;
-}
-
 /**
  * smack_of_ipc - the smack pointer for the ipc
  * @isp: the object
@@ -2924,17 +2913,6 @@ static int smack_ipc_alloc_security(struct kern_ipc_perm *isp)
 	return 0;
 }
 
-/**
- * smack_ipc_free_security - Clear the security blob for ipc
- * @isp: the object
- *
- * Clears the blob pointer
- */
-static void smack_ipc_free_security(struct kern_ipc_perm *isp)
-{
-	isp->security = NULL;
-}
-
 /**
  * smk_curacc_shm : check if current has access on shm
  * @isp : the object
@@ -4576,6 +4554,8 @@ struct lsm_blob_sizes smack_blob_sizes = {
 	.lbs_cred = sizeof(struct task_smack),
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
+	.lbs_ipc = sizeof(struct smack_known *),
+	.lbs_msg_msg = sizeof(struct smack_known *),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4647,23 +4627,19 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_security),
-	LSM_HOOK_INIT(msg_msg_free_security, smack_msg_msg_free_security),
 
 	LSM_HOOK_INIT(msg_queue_alloc_security, smack_ipc_alloc_security),
-	LSM_HOOK_INIT(msg_queue_free_security, smack_ipc_free_security),
 	LSM_HOOK_INIT(msg_queue_associate, smack_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, smack_msg_queue_msgctl),
 	LSM_HOOK_INIT(msg_queue_msgsnd, smack_msg_queue_msgsnd),
 	LSM_HOOK_INIT(msg_queue_msgrcv, smack_msg_queue_msgrcv),
 
 	LSM_HOOK_INIT(shm_alloc_security, smack_ipc_alloc_security),
-	LSM_HOOK_INIT(shm_free_security, smack_ipc_free_security),
 	LSM_HOOK_INIT(shm_associate, smack_shm_associate),
 	LSM_HOOK_INIT(shm_shmctl, smack_shm_shmctl),
 	LSM_HOOK_INIT(shm_shmat, smack_shm_shmat),
 
 	LSM_HOOK_INIT(sem_alloc_security, smack_ipc_alloc_security),
-	LSM_HOOK_INIT(sem_free_security, smack_ipc_free_security),
 	LSM_HOOK_INIT(sem_associate, smack_sem_associate),
 	LSM_HOOK_INIT(sem_semctl, smack_sem_semctl),
 	LSM_HOOK_INIT(sem_semop, smack_sem_semop),
-- 
2.17.1


