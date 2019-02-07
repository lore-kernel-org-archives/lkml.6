Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A455FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8B021902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBGMpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:49 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60742 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfBGMpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:46 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id E51285400AD;
        Thu,  7 Feb 2019 15:45:43 +0300 (MSK)
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
Subject: [PATCH 08/10] security: fix documentation for the msg_queue_* hooks
Date:   Thu,  7 Feb 2019 15:44:56 +0300
Message-Id: <3fba6c919f2125262b9939cb36d8df912f834433.1549540487.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msg_queue_* hooks were changed in the commit
"msg/security: Pass kern_ipc_perm not msg_queue into the msg_queue
security hooks" (d8c6e8543294). The type of the argument msq was changed
from msq_queue to kern_ipc_perm. This patch updates the documentation
for the hooks accordingly.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 307714b8b072..f61f39c73208 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1093,41 +1093,41 @@
  *
  * @msg_queue_alloc_security:
  *	Allocate and attach a security structure to the
- *	msq->q_perm.security field. The security field is initialized to
+ *	perm->security field. The security field is initialized to
  *	NULL when the structure is first created.
- *	@msq contains the message queue structure to be modified.
+ *	@perm contains the IPC permissions of the message queue.
  *	Return 0 if operation was successful and permission is granted.
  * @msg_queue_free_security:
  *	Deallocate security structure for this message queue.
- *	@msq contains the message queue structure to be modified.
+ *	@perm contains the IPC permissions of the message queue.
  * @msg_queue_associate:
  *	Check permission when a message queue is requested through the
- *	msgget system call.  This hook is only called when returning the
+ *	msgget system call. This hook is only called when returning the
  *	message queue identifier for an existing message queue, not when a
  *	new message queue is created.
- *	@msq contains the message queue to act upon.
+ *	@perm contains the IPC permissions of the message queue.
  *	@msqflg contains the operation control flags.
  *	Return 0 if permission is granted.
  * @msg_queue_msgctl:
  *	Check permission when a message control operation specified by @cmd
- *	is to be performed on the message queue @msq.
- *	The @msq may be NULL, e.g. for IPC_INFO or MSG_INFO.
- *	@msq contains the message queue to act upon.  May be NULL.
+ *	is to be performed on the message queue with permissions @perm.
+ *	The @perm may be NULL, e.g. for IPC_INFO or MSG_INFO.
+ *	@perm contains the IPC permissions of the msg queue. May be NULL.
  *	@cmd contains the operation to be performed.
  *	Return 0 if permission is granted.
  * @msg_queue_msgsnd:
  *	Check permission before a message, @msg, is enqueued on the message
- *	queue, @msq.
- *	@msq contains the message queue to send message to.
+ *	queue with permissions @perm.
+ *	@perm contains the IPC permissions of the message queue.
  *	@msg contains the message to be enqueued.
  *	@msqflg contains operational flags.
  *	Return 0 if permission is granted.
  * @msg_queue_msgrcv:
  *	Check permission before a message, @msg, is removed from the message
- *	queue, @msq.  The @target task structure contains a pointer to the
+ *	queue. The @target task structure contains a pointer to the
  *	process that will be receiving the message (not equal to the current
  *	process when inline receives are being performed).
- *	@msq contains the message queue to retrieve message from.
+ *	@perm contains the IPC permissions of the message queue.
  *	@msg contains the message destination.
  *	@target contains the task structure for recipient process.
  *	@type contains the type of message requested.
@@ -1615,13 +1615,13 @@ union security_list_options {
 	int (*msg_msg_alloc_security)(struct msg_msg *msg);
 	void (*msg_msg_free_security)(struct msg_msg *msg);
 
-	int (*msg_queue_alloc_security)(struct kern_ipc_perm *msq);
-	void (*msg_queue_free_security)(struct kern_ipc_perm *msq);
-	int (*msg_queue_associate)(struct kern_ipc_perm *msq, int msqflg);
-	int (*msg_queue_msgctl)(struct kern_ipc_perm *msq, int cmd);
-	int (*msg_queue_msgsnd)(struct kern_ipc_perm *msq, struct msg_msg *msg,
+	int (*msg_queue_alloc_security)(struct kern_ipc_perm *perm);
+	void (*msg_queue_free_security)(struct kern_ipc_perm *perm);
+	int (*msg_queue_associate)(struct kern_ipc_perm *perm, int msqflg);
+	int (*msg_queue_msgctl)(struct kern_ipc_perm *perm, int cmd);
+	int (*msg_queue_msgsnd)(struct kern_ipc_perm *perm, struct msg_msg *msg,
 				int msqflg);
-	int (*msg_queue_msgrcv)(struct kern_ipc_perm *msq, struct msg_msg *msg,
+	int (*msg_queue_msgrcv)(struct kern_ipc_perm *perm, struct msg_msg *msg,
 				struct task_struct *target, long type,
 				int mode);
 
-- 
2.17.2

