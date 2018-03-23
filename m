Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832811-2-5450265949221772353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521832811; b=UG7ziWCaJM/9lp9YpaVCtYdC2swGOaL6Whn8QbAKvnJBVGo
    kvDoyShIWL6MEaASLI6vYdDqA3oJBlT6WnF+dBJAD/dJNwD/Cjym/TUYVlVU0jna
    02PbxYderUCFob80KF7m9buixhhjm3hSJKPmSooX8E/Mj2KR4HyWh4jG92j2bRkP
    WdsuXywOUPGOjKkwwFgVtHKc9WaxlWeBD/77y+/f56vPsCQD6jwY4bGhve5LLRCC
    G9Mdkmk7oj0mIovqh/UARa2a2tzWKaM0OY+ReIe5C9SnNPc5+54Fib7PeyqVwMfi
    gqa/Doo6hYhDDMRXzcCutQKK7lgOp1WekTotr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832811; bh=
    GzraqqlHpgfC/A2IcGNJwAtScj9Ez7Oci+zCG9VRrV4=; b=IHtJfswOZF3L7B4N
    6jfjTA9ePhxJjZjLyCeQKE6qRDaUy1co5DBF5wIT/suw8P+jnUjEgie6/KqrQrKk
    A930vAoiK6wMVLCPFJNpww9kUqs0s4P3UnVitiN1nclZ4BNHncCLq1KYasgc7c/X
    tkwdY+zkk3h6gjg2AnU5dPS3eJRMjUrV09+JO2/IgswisSi/rbG4o3f4slj6vSB+
    /XEPguWDh3uVPA/nPJv5RQ9Wsj2i+4PjsxRb9PAg1dfiiBzsEUEO2S58+MuxVEXJ
    x0iMdUo7XVJxaonl6+tQ6e5Smeo+WEQT7gNEZLwvqNLLEWat+swryAPf8hI1x9rd
    THj4cg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeCWTUI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:20:08 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44420 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeCWTRt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:17:49 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 23 Mar 2018 14:16:05 -0500
Message-Id: <20180323191614.32489-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCB-00033I-8o;;;mid=<20180323191614.32489-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+NlLApMFYqRguXWvLsrX+w8Y63SMapM1o=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa05.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 700 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.7 (0.5%), b_tie_ro: 2.5 (0.4%), parse: 1.97 (0.3%),
        extract_message_metadata: 24 (3.5%), get_uri_detail_list: 10 (1.5%),
        tests_pri_-1000: 8 (1.2%), tests_pri_-950: 1.72 (0.2%), tests_pri_-900: 1.34
        (0.2%), tests_pri_-400: 51 (7.4%), check_bayes: 50 (7.2%), b_tokenize: 28
        (4.0%), b_tok_get_all: 11 (1.6%), b_comp_prob: 2.7 (0.4%), b_tok_touch_all: 6
        (0.8%), b_finish: 0.64 (0.1%), tests_pri_0: 594 (84.9%),
        check_dkim_signature: 0.69 (0.1%), check_dkim_adsp: 2.7 (0.4%),
        tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 02/11] shm/security: Pass kern_ipc_perm not shmid_kernel into the shm security hooks
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All of the implementations of security hooks that take shmid_kernel only
access shm_perm the struct kern_ipc_perm member.  This means the
dependencies of the shm security hooks can be simplified by passing
the kern_ipc_perm member of shmid_kernel..

Making this change will allow struct shmid_kernel to become private to ipc/shm.c.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/lsm_hooks.h  | 10 +++++-----
 include/linux/security.h   | 21 ++++++++++-----------
 ipc/shm.c                  | 17 +++++++----------
 security/security.c        | 10 +++++-----
 security/selinux/hooks.c   | 28 ++++++++++++++--------------
 security/smack/smack_lsm.c | 22 +++++++++++-----------
 6 files changed, 52 insertions(+), 56 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e4a94863a88c..cac7a8082c43 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1585,11 +1585,11 @@ union security_list_options {
 				struct task_struct *target, long type,
 				int mode);
 
-	int (*shm_alloc_security)(struct shmid_kernel *shp);
-	void (*shm_free_security)(struct shmid_kernel *shp);
-	int (*shm_associate)(struct shmid_kernel *shp, int shmflg);
-	int (*shm_shmctl)(struct shmid_kernel *shp, int cmd);
-	int (*shm_shmat)(struct shmid_kernel *shp, char __user *shmaddr,
+	int (*shm_alloc_security)(struct kern_ipc_perm *shp);
+	void (*shm_free_security)(struct kern_ipc_perm *shp);
+	int (*shm_associate)(struct kern_ipc_perm *shp, int shmflg);
+	int (*shm_shmctl)(struct kern_ipc_perm *shp, int cmd);
+	int (*shm_shmat)(struct kern_ipc_perm *shp, char __user *shmaddr,
 				int shmflg);
 
 	int (*sem_alloc_security)(struct kern_ipc_perm *sma);
diff --git a/include/linux/security.h b/include/linux/security.h
index fa7adac4b99a..f390755808ea 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -49,7 +49,6 @@ struct qstr;
 struct iattr;
 struct fown_struct;
 struct file_operations;
-struct shmid_kernel;
 struct msg_msg;
 struct msg_queue;
 struct xattr;
@@ -362,11 +361,11 @@ int security_msg_queue_msgsnd(struct msg_queue *msq,
 			      struct msg_msg *msg, int msqflg);
 int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 			      struct task_struct *target, long type, int mode);
-int security_shm_alloc(struct shmid_kernel *shp);
-void security_shm_free(struct shmid_kernel *shp);
-int security_shm_associate(struct shmid_kernel *shp, int shmflg);
-int security_shm_shmctl(struct shmid_kernel *shp, int cmd);
-int security_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr, int shmflg);
+int security_shm_alloc(struct kern_ipc_perm *shp);
+void security_shm_free(struct kern_ipc_perm *shp);
+int security_shm_associate(struct kern_ipc_perm *shp, int shmflg);
+int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd);
+int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmflg);
 int security_sem_alloc(struct kern_ipc_perm *sma);
 void security_sem_free(struct kern_ipc_perm *sma);
 int security_sem_associate(struct kern_ipc_perm *sma, int semflg);
@@ -1077,26 +1076,26 @@ static inline int security_msg_queue_msgrcv(struct msg_queue *msq,
 	return 0;
 }
 
-static inline int security_shm_alloc(struct shmid_kernel *shp)
+static inline int security_shm_alloc(struct kern_ipc_perm *shp)
 {
 	return 0;
 }
 
-static inline void security_shm_free(struct shmid_kernel *shp)
+static inline void security_shm_free(struct kern_ipc_perm *shp)
 { }
 
-static inline int security_shm_associate(struct shmid_kernel *shp,
+static inline int security_shm_associate(struct kern_ipc_perm *shp,
 					 int shmflg)
 {
 	return 0;
 }
 
-static inline int security_shm_shmctl(struct shmid_kernel *shp, int cmd)
+static inline int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
 	return 0;
 }
 
-static inline int security_shm_shmat(struct shmid_kernel *shp,
+static inline int security_shm_shmat(struct kern_ipc_perm *shp,
 				     char __user *shmaddr, int shmflg)
 {
 	return 0;
diff --git a/ipc/shm.c b/ipc/shm.c
index 4643865e9171..387a786e7be1 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -181,7 +181,7 @@ static void shm_rcu_free(struct rcu_head *head)
 							rcu);
 	struct shmid_kernel *shp = container_of(ptr, struct shmid_kernel,
 							shm_perm);
-	security_shm_free(shp);
+	security_shm_free(&shp->shm_perm);
 	kvfree(shp);
 }
 
@@ -554,7 +554,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	shp->mlock_user = NULL;
 
 	shp->shm_perm.security = NULL;
-	error = security_shm_alloc(shp);
+	error = security_shm_alloc(&shp->shm_perm);
 	if (error) {
 		kvfree(shp);
 		return error;
@@ -635,10 +635,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
  */
 static inline int shm_security(struct kern_ipc_perm *ipcp, int shmflg)
 {
-	struct shmid_kernel *shp;
-
-	shp = container_of(ipcp, struct shmid_kernel, shm_perm);
-	return security_shm_associate(shp, shmflg);
+	return security_shm_associate(ipcp, shmflg);
 }
 
 /*
@@ -835,7 +832,7 @@ static int shmctl_down(struct ipc_namespace *ns, int shmid, int cmd,
 
 	shp = container_of(ipcp, struct shmid_kernel, shm_perm);
 
-	err = security_shm_shmctl(shp, cmd);
+	err = security_shm_shmctl(&shp->shm_perm, cmd);
 	if (err)
 		goto out_unlock1;
 
@@ -934,7 +931,7 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	if (ipcperms(ns, &shp->shm_perm, S_IRUGO))
 		goto out_unlock;
 
-	err = security_shm_shmctl(shp, cmd);
+	err = security_shm_shmctl(&shp->shm_perm, cmd);
 	if (err)
 		goto out_unlock;
 
@@ -978,7 +975,7 @@ static int shmctl_do_lock(struct ipc_namespace *ns, int shmid, int cmd)
 	}
 
 	audit_ipc_obj(&(shp->shm_perm));
-	err = security_shm_shmctl(shp, cmd);
+	err = security_shm_shmctl(&shp->shm_perm, cmd);
 	if (err)
 		goto out_unlock1;
 
@@ -1348,7 +1345,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	if (ipcperms(ns, &shp->shm_perm, acc_mode))
 		goto out_unlock;
 
-	err = security_shm_shmat(shp, shmaddr, shmflg);
+	err = security_shm_shmat(&shp->shm_perm, shmaddr, shmflg);
 	if (err)
 		goto out_unlock;
 
diff --git a/security/security.c b/security/security.c
index d3b9aeb6b73b..77b69bd6f234 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1195,27 +1195,27 @@ int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
 }
 
-int security_shm_alloc(struct shmid_kernel *shp)
+int security_shm_alloc(struct kern_ipc_perm *shp)
 {
 	return call_int_hook(shm_alloc_security, 0, shp);
 }
 
-void security_shm_free(struct shmid_kernel *shp)
+void security_shm_free(struct kern_ipc_perm *shp)
 {
 	call_void_hook(shm_free_security, shp);
 }
 
-int security_shm_associate(struct shmid_kernel *shp, int shmflg)
+int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 {
 	return call_int_hook(shm_associate, 0, shp, shmflg);
 }
 
-int security_shm_shmctl(struct shmid_kernel *shp, int cmd)
+int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
 	return call_int_hook(shm_shmctl, 0, shp, cmd);
 }
 
-int security_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr, int shmflg)
+int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmflg)
 {
 	return call_int_hook(shm_shmat, 0, shp, shmaddr, shmflg);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index cce994e9fc0a..14f9e6c08273 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5674,53 +5674,53 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 }
 
 /* Shared Memory security operations */
-static int selinux_shm_alloc_security(struct shmid_kernel *shp)
+static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(&shp->shm_perm, SECCLASS_SHM);
+	rc = ipc_alloc_security(shp, SECCLASS_SHM);
 	if (rc)
 		return rc;
 
-	isec = shp->shm_perm.security;
+	isec = shp->security;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
-	ad.u.ipc_id = shp->shm_perm.key;
+	ad.u.ipc_id = shp->key;
 
 	rc = avc_has_perm(sid, isec->sid, SECCLASS_SHM,
 			  SHM__CREATE, &ad);
 	if (rc) {
-		ipc_free_security(&shp->shm_perm);
+		ipc_free_security(shp);
 		return rc;
 	}
 	return 0;
 }
 
-static void selinux_shm_free_security(struct shmid_kernel *shp)
+static void selinux_shm_free_security(struct kern_ipc_perm *shp)
 {
-	ipc_free_security(&shp->shm_perm);
+	ipc_free_security(shp);
 }
 
-static int selinux_shm_associate(struct shmid_kernel *shp, int shmflg)
+static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = shp->shm_perm.security;
+	isec = shp->security;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
-	ad.u.ipc_id = shp->shm_perm.key;
+	ad.u.ipc_id = shp->key;
 
 	return avc_has_perm(sid, isec->sid, SECCLASS_SHM,
 			    SHM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, shp is locked down */
-static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
+static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
 	int perms;
 	int err;
@@ -5749,11 +5749,11 @@ static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
 		return 0;
 	}
 
-	err = ipc_has_perm(&shp->shm_perm, perms);
+	err = ipc_has_perm(shp, perms);
 	return err;
 }
 
-static int selinux_shm_shmat(struct shmid_kernel *shp,
+static int selinux_shm_shmat(struct kern_ipc_perm *shp,
 			     char __user *shmaddr, int shmflg)
 {
 	u32 perms;
@@ -5763,7 +5763,7 @@ static int selinux_shm_shmat(struct shmid_kernel *shp,
 	else
 		perms = SHM__READ | SHM__WRITE;
 
-	return ipc_has_perm(&shp->shm_perm, perms);
+	return ipc_has_perm(shp, perms);
 }
 
 /* Semaphore security operations */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0402b8c1aec1..a3398c7f32c9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2950,9 +2950,9 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
  *
  * Returns a pointer to the smack value
  */
-static struct smack_known *smack_of_shm(struct shmid_kernel *shp)
+static struct smack_known *smack_of_shm(struct kern_ipc_perm *shp)
 {
-	return (struct smack_known *)shp->shm_perm.security;
+	return (struct smack_known *)shp->security;
 }
 
 /**
@@ -2961,9 +2961,9 @@ static struct smack_known *smack_of_shm(struct shmid_kernel *shp)
  *
  * Returns 0
  */
-static int smack_shm_alloc_security(struct shmid_kernel *shp)
+static int smack_shm_alloc_security(struct kern_ipc_perm *shp)
 {
-	struct kern_ipc_perm *isp = &shp->shm_perm;
+	struct kern_ipc_perm *isp = shp;
 	struct smack_known *skp = smk_of_current();
 
 	isp->security = skp;
@@ -2976,9 +2976,9 @@ static int smack_shm_alloc_security(struct shmid_kernel *shp)
  *
  * Clears the blob pointer
  */
-static void smack_shm_free_security(struct shmid_kernel *shp)
+static void smack_shm_free_security(struct kern_ipc_perm *shp)
 {
-	struct kern_ipc_perm *isp = &shp->shm_perm;
+	struct kern_ipc_perm *isp = shp;
 
 	isp->security = NULL;
 }
@@ -2990,7 +2990,7 @@ static void smack_shm_free_security(struct shmid_kernel *shp)
  *
  * Returns 0 if current has the requested access, error code otherwise
  */
-static int smk_curacc_shm(struct shmid_kernel *shp, int access)
+static int smk_curacc_shm(struct kern_ipc_perm *shp, int access)
 {
 	struct smack_known *ssp = smack_of_shm(shp);
 	struct smk_audit_info ad;
@@ -2998,7 +2998,7 @@ static int smk_curacc_shm(struct shmid_kernel *shp, int access)
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
-	ad.a.u.ipc_id = shp->shm_perm.id;
+	ad.a.u.ipc_id = shp->id;
 #endif
 	rc = smk_curacc(ssp, access, &ad);
 	rc = smk_bu_current("shm", ssp, access, rc);
@@ -3012,7 +3012,7 @@ static int smk_curacc_shm(struct shmid_kernel *shp, int access)
  *
  * Returns 0 if current has the requested access, error code otherwise
  */
-static int smack_shm_associate(struct shmid_kernel *shp, int shmflg)
+static int smack_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 {
 	int may;
 
@@ -3027,7 +3027,7 @@ static int smack_shm_associate(struct shmid_kernel *shp, int shmflg)
  *
  * Returns 0 if current has the requested access, error code otherwise
  */
-static int smack_shm_shmctl(struct shmid_kernel *shp, int cmd)
+static int smack_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
 	int may;
 
@@ -3062,7 +3062,7 @@ static int smack_shm_shmctl(struct shmid_kernel *shp, int cmd)
  *
  * Returns 0 if current has the requested access, error code otherwise
  */
-static int smack_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr,
+static int smack_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr,
 			   int shmflg)
 {
 	int may;
-- 
2.14.1

