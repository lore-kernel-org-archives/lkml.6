Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D2DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A633218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfBZUvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:51:18 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45492 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfBZUvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:51:17 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2D75D5400ED;
        Tue, 26 Feb 2019 23:51:13 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     Kees Cook <keescook@chromium.org>
Cc:     Denis Efremov <efremov@ispras.ru>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] LSM: lsm_hooks.h: fix documentation format
Date:   Tue, 26 Feb 2019 23:49:12 +0300
Message-Id: <3eb6e0f44a9f540922ba9951053218b60367f289.1551213058.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for name mismatch and omitted colons in the
security_list_options documentation.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f4a168c5e85c..bc5a2dc267d8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -486,7 +486,7 @@
  *	Return 0 if permission is granted.
  * @file_lock:
  *	Check permission before performing file locking operations.
- *	Note: this hook mediates both flock and fcntl style locks.
+ *	Note the hook mediates both flock and fcntl style locks.
  *	@file contains the file structure.
  *	@cmd contains the posix-translated lock operation to perform
  *	(e.g. F_RDLCK, F_WRLCK).
@@ -629,12 +629,12 @@
  *	@p contains the task_struct of process.
  *	@nice contains the new nice value.
  *	Return 0 if permission is granted.
- * @task_setioprio
+ * @task_setioprio:
  *	Check permission before setting the ioprio value of @p to @ioprio.
  *	@p contains the task_struct of process.
  *	@ioprio contains the new ioprio value
  *	Return 0 if permission is granted.
- * @task_getioprio
+ * @task_getioprio:
  *	Check permission before getting the ioprio value of @p.
  *	@p contains the task_struct of process.
  *	Return 0 if permission is granted.
@@ -664,7 +664,7 @@
  *	@p.
  *	@p contains the task_struct for process.
  *	Return 0 if permission is granted.
- * @task_movememory
+ * @task_movememory:
  *	Check permission before moving memory owned by process @p.
  *	@p contains the task_struct for process.
  *	Return 0 if permission is granted.
@@ -888,9 +888,9 @@
  * @secmark_relabel_packet:
  *	check if the process should be allowed to relabel packets to
  *	the given secid
- * @security_secmark_refcount_inc
+ * @secmark_refcount_inc:
  *	tells the LSM to increment the number of secmark labeling rules loaded
- * @security_secmark_refcount_dec
+ * @secmark_refcount_dec:
  *	tells the LSM to decrement the number of secmark labeling rules loaded
  * @req_classify_flow:
  *	Sets the flow's sid to the openreq sid.
@@ -1278,8 +1278,8 @@
  *	Return 0 if permission is granted.
  * @settime:
  *	Check permission to change the system time.
- *	struct timespec64 is defined in include/linux/time64.h and timezone
- *	is defined in include/linux/time.h
+ *	struct timespec64 is defined in <include/linux/time64.h> and timezone
+ *	is defined in <include/linux/time.h>
  *	@ts contains new time
  *	@tz contains new timezone
  *	Return 0 if permission is granted.
@@ -1321,7 +1321,7 @@
  * @audit_rule_init:
  *	Allocate and initialize an LSM audit rule structure.
  *	@field contains the required Audit action.
- *	Fields flags are defined in include/linux/audit.h
+ *	Fields flags are defined in <include/linux/audit.h>
  *	@op contains the operator the rule uses.
  *	@rulestr contains the context where the rule will be applied to.
  *	@lsmrule contains a pointer to receive the result.
@@ -1360,9 +1360,7 @@
  *	this hook to initialize the security context in its incore inode to the
  *	value provided by the server for the file when the server returned the
  *	file's attributes to the client.
- *
  *	Must be called with inode->i_mutex locked.
- *
  *	@inode we wish to set the security context of.
  *	@ctx contains the string which we wish to set in the inode.
  *	@ctxlen contains the length of @ctx.
@@ -1375,9 +1373,7 @@
  *	this hook to change the security context in its incore inode and on the
  *	backing filesystem to a value provided by the client on a SETATTR
  *	operation.
- *
  *	Must be called with inode->i_mutex locked.
- *
  *	@dentry contains the inode we wish to set the security context of.
  *	@ctx contains the string which we wish to set in the inode.
  *	@ctxlen contains the length of @ctx.
@@ -1385,7 +1381,6 @@
  * @inode_getsecctx:
  *	On success, returns 0 and fills out @ctx and @ctxlen with the security
  *	context for the given @inode.
- *
  *	@inode we wish to get the security context of.
  *	@ctx is a pointer in which to place the allocated security context.
  *	@ctxlen points to the place to put the length of @ctx.
-- 
2.17.2

