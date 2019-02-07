Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4312DC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E6E21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfBGMpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:50 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60778 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbfBGMps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:48 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2D74C5400B5;
        Thu,  7 Feb 2019 15:45:45 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Denis Efremov <efremov@ispras.ru>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] security: fix documentation for the sem_* hooks
Date:   Thu,  7 Feb 2019 15:44:57 +0300
Message-Id: <61203dee8c760e0d3627be17f0473c1a9bfce3f3.1549540487.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sem_* hooks were changed in the commit
"sem/security: Pass kern_ipc_perm not sem_array into the
sem security hooks" (aefad9593ec5). The type of the argument
sma was changed from sem_array to kern_ipc_perm. This patch
updates the documentation for the hooks accordingly.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f61f39c73208..4bfb6532cbb3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1172,34 +1172,34 @@
  * Security hooks for System V Semaphores
  *
  * @sem_alloc_security:
- *	Allocate and attach a security structure to the sma->sem_perm.security
- *	field.  The security field is initialized to NULL when the structure is
+ *	Allocate and attach a security structure to the perm->security
+ *	field. The security field is initialized to NULL when the structure is
  *	first created.
- *	@sma contains the semaphore structure
+ *	@perm contains the IPC permissions of the semaphore.
  *	Return 0 if operation was successful and permission is granted.
  * @sem_free_security:
  *	deallocate security struct for this semaphore
- *	@sma contains the semaphore structure.
+ *	@perm contains the IPC permissions of the semaphore.
  * @sem_associate:
  *	Check permission when a semaphore is requested through the semget
- *	system call.  This hook is only called when returning the semaphore
+ *	system call. This hook is only called when returning the semaphore
  *	identifier for an existing semaphore, not when a new one must be
  *	created.
- *	@sma contains the semaphore structure.
+ *	@perm contains the IPC permissions of the semaphore.
  *	@semflg contains the operation control flags.
  *	Return 0 if permission is granted.
  * @sem_semctl:
  *	Check permission when a semaphore operation specified by @cmd is to be
- *	performed on the semaphore @sma.  The @sma may be NULL, e.g. for
+ *	performed on the semaphore. The @perm may be NULL, e.g. for
  *	IPC_INFO or SEM_INFO.
- *	@sma contains the semaphore structure.  May be NULL.
+ *	@perm contains the IPC permissions of the semaphore. May be NULL.
  *	@cmd contains the operation to be performed.
  *	Return 0 if permission is granted.
  * @sem_semop:
  *	Check permissions before performing operations on members of the
- *	semaphore set @sma.  If the @alter flag is nonzero, the semaphore set
+ *	semaphore set. If the @alter flag is nonzero, the semaphore set
  *	may be modified.
- *	@sma contains the semaphore structure.
+ *	@perm contains the IPC permissions of the semaphore.
  *	@sops contains the operations to perform.
  *	@nsops contains the number of operations to perform.
  *	@alter contains the flag indicating whether changes are to be made.
@@ -1632,11 +1632,11 @@ union security_list_options {
 	int (*shm_shmat)(struct kern_ipc_perm *shp, char __user *shmaddr,
 				int shmflg);
 
-	int (*sem_alloc_security)(struct kern_ipc_perm *sma);
-	void (*sem_free_security)(struct kern_ipc_perm *sma);
-	int (*sem_associate)(struct kern_ipc_perm *sma, int semflg);
-	int (*sem_semctl)(struct kern_ipc_perm *sma, int cmd);
-	int (*sem_semop)(struct kern_ipc_perm *sma, struct sembuf *sops,
+	int (*sem_alloc_security)(struct kern_ipc_perm *perm);
+	void (*sem_free_security)(struct kern_ipc_perm *perm);
+	int (*sem_associate)(struct kern_ipc_perm *perm, int semflg);
+	int (*sem_semctl)(struct kern_ipc_perm *perm, int cmd);
+	int (*sem_semop)(struct kern_ipc_perm *perm, struct sembuf *sops,
 				unsigned nsops, int alter);
 
 	int (*netlink_send)(struct sock *sk, struct sk_buff *skb);
-- 
2.17.2

