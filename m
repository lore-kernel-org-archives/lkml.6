Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2999894-1525999956-2-10241865051052076944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525999956; b=PXJ4qzzw+QloedMpCwQRL+Io1xWdWRHHviJom8jBfe7RK6dR+o
    YPqk8y8RhBI4AJnTBMTB0VUkxU+kAwCIsCcQ/qCDFOFxG6EaoMhiAQhnkgc83VhD
    52/KtmcXUYd/cuTbax9FvNaZf/4ampB89yN5HuRf+Shz4NVgPmJyUIY4CrVnAU1r
    cp+d/dt6tH1kYim0NTHYt2jpW4Iaz0tSwfSKNsk7zk+xhtidCmsmpzhkJuhBfq7j
    v1qoVdAQybWFfRcYrW04mm0tSmFnuOUw8FhtGLd+SZAu3FOCoxNjJ7cRC9B5kmQw
    R1TkSIwVRX70TnaD08+mybDgPlkNFpM270zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525999956;
    bh=Yz5mRph3JNCws1enAMlpaHrJWYqDf1c7EdBEKT72P2k=; b=mYeWKZe5htVP
    xBrLZ4EI+yRznGuTawqyt/S2DW/Q1G1f6mq4DS/I9B70vDwPlLTBJM1hZ6+O6vtL
    Of6V0JpYebUIwWr/aJU5lJsuLK1ZM0e2S7OY+mgnHukFTOdcdvHKL3IuAoXdCFjv
    yJTCw6ZonXv90XrEyhDANQZfLunV/ujhE807Qt6CGX+HvZ3vVJgzxv8CCkfK0uVD
    NgUILvR4xhHpHpvYywT7XgnnsQcR0RW+o6/SKLaS2u6Xr5LszHIKIBi21M00qL6Q
    uvs2oJNpe+uXP6PLxIPNyouAEaY7xRUFzagVZ1kdnH7z+RPGiQEYF8lf7gAJRHtm
    uu1p0PfY1A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=SURHigup x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=schaufler-ca.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=SURHigup x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=schaufler-ca.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBqeFuNWq/MmMbuRDhtGyMyVV7ofIUALnRir/t8Hx54k47rcxf4Jg1vIb5SZhhHiIDuR7tqNltN20kMxoW+gz2ZWv/fE0z1t17KliyoARILD3XeCwiBK
    +iC5shy4Fz59yTmXgOerpu3tONQZUgWV2po1JdJABaxf6lEPIxHA69uY2vQkDySXC7uX0GvpUOqwiqPn8rNQerCezdhH+NEIerti8gs8K0qknhHAK0NWxoUP
    cxqhT820bHC+dZvLtlsiYQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=VUJBJC2UJ8kA:10 a=EtzIAuyirS4A:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=Yi9GK-Yom8Gbbdc3e5MA:9
    a=kLE17UqYBglrZ6tk:21 a=xU-OuGExBoRIiet0:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeEKAwe (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 20:52:34 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:41931
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750937AbeEKAwd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 20:52:33 -0400
X-YMail-OSG: eKOSvScVM1mSA1986Je3dwWNmBps759mbFVt0nLTnUE_xRE2qL4fEVBqO9tgVPk
 DCld5OgoyMp2HVKbVlrYBnuTlXkLS4IQQEI64ych6xlmz1DnV9AHVpEM8ksOPpv4nuBaBrjqm8pl
 GpV8jEoaX22QtQ2snq8t079oV4VNnOaeafQcXL5L_0A0jIOJS_1NLxJnx1NE0loFFKD163k10VMv
 eQH4avqXCSsbGTU3_YX0PHJ95Rcjx_NQ56AZ7BXgb_SyepSbP08fsej8Dq_RcZd9Rr2h_9Hlm78g
 u3Ju0nY5TQArsgIR24mENdxB2C7F1J.MXKXfS8K4T_TyWzeSEjmbXwpiet6Kqa78wK731.7eqLL9
 ggKZlUehpNZTpw_qIjeZ7BTJP.iQlq_Fm7ov_S9bxKulJ0.TLYwMyEIfb7GlItDVFzw1HBUNBWAm
 98VS8X2I0gxXHIin220fu9z69FyIwuWjfCNUkAUSK3ReQz.MyEc3qvlduqxea.DYej6EarLqrkNF
 RYHw1DME3abgvOAumd1uZSCf8FmMxpHimFxrG5U2tfLJH_FxR1Mri1FHm1ye2xtED97xTjEpjX_o
 R9Vx9Fn1tDjU0IlbVrKDdSBJ8qc9f1c82TLdDNK61ivNWDTwdemVFKjeOh2SbfcT56j9uVmF04jQ
 jYdI-
Subject: [PATCH 02/23] Smack: Abstract use of cred security blob
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8e198147-b5a5-7087-beed-900983a34d35@schaufler-ca.com>
Date: Thu, 10 May 2018 17:52:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 13:44:35 -0700
Subject: [PATCH 02/23] Smack: Abstract use of cred security blob

Don't use the cred->security poiter directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h        | 14 ++++++++---
 security/smack/smack_access.c |  4 +--
 security/smack/smack_lsm.c    | 57 +++++++++++++++++++++----------------------
 security/smack/smackfs.c      | 18 +++++++-------
 4 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index f7db791fb566..0b55d6a55b26 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -356,6 +356,11 @@ extern struct list_head smack_onlycap_list;
 #define SMACK_HASH_SLOTS 16
 extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
 
+static inline struct task_smack *smack_cred(const struct cred *cred)
+{
+	return cred->security;
+}
+
 /*
  * Is the directory transmuting?
  */
@@ -382,13 +387,16 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
 	return tsp->smk_task;
 }
 
-static inline struct smack_known *smk_of_task_struct(const struct task_struct *t)
+static inline struct smack_known *smk_of_task_struct(
+						const struct task_struct *t)
 {
 	struct smack_known *skp;
+	const struct cred *cred;
 
 	rcu_read_lock();
-	skp = smk_of_task(__task_cred(t)->security);
+	cred = __task_cred(t);
 	rcu_read_unlock();
+	skp = smk_of_task(smack_cred(cred));
 	return skp;
 }
 
@@ -405,7 +413,7 @@ static inline struct smack_known *smk_of_forked(const struct task_smack *tsp)
  */
 static inline struct smack_known *smk_of_current(void)
 {
-	return smk_of_task(current_security());
+	return smk_of_task(smack_cred(current_cred()));
 }
 
 /*
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 9a4c0ad46518..489d49a20b47 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -275,7 +275,7 @@ int smk_tskacc(struct task_smack *tsp, struct smack_known *obj_known,
 int smk_curacc(struct smack_known *obj_known,
 	       u32 mode, struct smk_audit_info *a)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_tskacc(tsp, obj_known, mode, a);
 }
@@ -635,7 +635,7 @@ DEFINE_MUTEX(smack_onlycap_lock);
  */
 bool smack_privileged_cred(int cap, const struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *skp = tsp->smk_task;
 	struct smack_known_list_elem *sklep;
 	int rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0b414836bebd..d9307a172ab7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -121,7 +121,7 @@ static int smk_bu_note(char *note, struct smack_known *sskp,
 static int smk_bu_current(char *note, struct smack_known *oskp,
 			  int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (rc <= 0)
@@ -142,7 +142,7 @@ static int smk_bu_current(char *note, struct smack_known *oskp,
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *smk_task = smk_of_task_struct(otp);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
@@ -164,7 +164,7 @@ static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_inode(struct inode *inode, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *isp = inode->i_security;
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
@@ -194,7 +194,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_file(struct file *file, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
 	struct inode_smack *isp = inode->i_security;
@@ -224,7 +224,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 static int smk_bu_credfile(const struct cred *cred, struct file *file,
 				int mode, int rc)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
 	struct inode_smack *isp = inode->i_security;
@@ -428,7 +428,7 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 	}
 
 	rcu_read_lock();
-	tsp = __task_cred(tracer)->security;
+	tsp = smack_cred(__task_cred(tracer));
 	tracer_known = smk_of_task(tsp);
 
 	if ((mode & PTRACE_MODE_ATTACH) &&
@@ -495,7 +495,7 @@ static int smack_ptrace_traceme(struct task_struct *ptp)
 	int rc;
 	struct smack_known *skp;
 
-	skp = smk_of_task(current_security());
+	skp = smk_of_task(smack_cred(current_cred()));
 
 	rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
 	return rc;
@@ -912,7 +912,7 @@ static int smack_sb_statfs(struct dentry *dentry)
 static int smack_bprm_set_creds(struct linux_binprm *bprm)
 {
 	struct inode *inode = file_inode(bprm->file);
-	struct task_smack *bsp = bprm->cred->security;
+	struct task_smack *bsp = smack_cred(bprm->cred);
 	struct inode_smack *isp;
 	struct superblock_smack *sbsp;
 	int rc;
@@ -1743,7 +1743,7 @@ static int smack_mmap_file(struct file *file,
 		return -EACCES;
 	mkp = isp->smk_mmap;
 
-	tsp = current_security();
+	tsp = smack_cred(current_cred());
 	skp = smk_of_current();
 	rc = 0;
 
@@ -1839,7 +1839,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task(tsk->cred->security);
+	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	struct file *file;
 	int rc;
 	struct smk_audit_info ad;
@@ -1887,7 +1887,7 @@ static int smack_file_receive(struct file *file)
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
 		ssp = sock->sk->sk_security;
-		tsp = current_security();
+		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
 		 * passed socket or if the passed socket can't
@@ -1929,7 +1929,7 @@ static int smack_file_receive(struct file *file)
  */
 static int smack_file_open(struct file *file, const struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct inode *inode = file_inode(file);
 	struct smk_audit_info ad;
 	int rc;
@@ -1976,7 +1976,7 @@ static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void smack_cred_free(struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_rule *rp;
 	struct list_head *l;
 	struct list_head *n;
@@ -2006,7 +2006,7 @@ static void smack_cred_free(struct cred *cred)
 static int smack_cred_prepare(struct cred *new, const struct cred *old,
 			      gfp_t gfp)
 {
-	struct task_smack *old_tsp = old->security;
+	struct task_smack *old_tsp = smack_cred(old);
 	struct task_smack *new_tsp;
 	int rc;
 
@@ -2037,15 +2037,14 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void smack_cred_transfer(struct cred *new, const struct cred *old)
 {
-	struct task_smack *old_tsp = old->security;
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *old_tsp = smack_cred(old);
+	struct task_smack *new_tsp = smack_cred(new);
 
 	new_tsp->smk_task = old_tsp->smk_task;
 	new_tsp->smk_forked = old_tsp->smk_task;
 	mutex_init(&new_tsp->smk_rules_lock);
 	INIT_LIST_HEAD(&new_tsp->smk_rules);
 
-
 	/* cbs copy rule list */
 }
 
@@ -2056,12 +2055,12 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  *
  * Sets the secid to contain a u32 version of the smack label.
  */
-static void smack_cred_getsecid(const struct cred *c, u32 *secid)
+static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
 {
 	struct smack_known *skp;
 
 	rcu_read_lock();
-	skp = smk_of_task(c->security);
+	skp = smk_of_task(smack_cred(cred));
 	*secid = skp->smk_secid;
 	rcu_read_unlock();
 }
@@ -2075,7 +2074,7 @@ static void smack_cred_getsecid(const struct cred *c, u32 *secid)
  */
 static int smack_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *new_tsp = smack_cred(new);
 
 	new_tsp->smk_task = smack_from_secid(secid);
 	return 0;
@@ -2093,7 +2092,7 @@ static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
 	struct inode_smack *isp = inode->i_security;
-	struct task_smack *tsp = new->security;
+	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
 	tsp->smk_task = tsp->smk_forked;
@@ -2277,7 +2276,7 @@ static int smack_task_kill(struct task_struct *p, struct siginfo *info,
 	 * specific behavior. This is not clean. For one thing
 	 * we can't take privilege into account.
 	 */
-	skp = smk_of_task(cred->security);
+	skp = smk_of_task(smack_cred(cred));
 	rc = smk_access(skp, tkp, MAY_DELIVER, &ad);
 	rc = smk_bu_note("USB signal", skp, tkp, MAY_DELIVER, rc);
 	return rc;
@@ -3582,7 +3581,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
  */
 static int smack_setprocattr(const char *name, void *value, size_t size)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
 	struct smack_known *skp;
 	struct smack_known_list_elem *sklep;
@@ -3623,7 +3622,7 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (new == NULL)
 		return -ENOMEM;
 
-	tsp = new->security;
+	tsp = smack_cred(new);
 	tsp->smk_task = skp;
 	/*
 	 * process can change its label only once
@@ -4259,7 +4258,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
-	struct smack_known *skp = smk_of_task(cred->security);
+	struct smack_known *skp = smk_of_task(smack_cred(cred));
 
 	key->security = skp;
 	return 0;
@@ -4290,7 +4289,7 @@ static int smack_key_permission(key_ref_t key_ref,
 {
 	struct key *keyp;
 	struct smk_audit_info ad;
-	struct smack_known *tkp = smk_of_task(cred->security);
+	struct smack_known *tkp = smk_of_task(smack_cred(cred));
 	int request = 0;
 	int rc;
 
@@ -4561,7 +4560,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsp = new_creds->security;
+	tsp = smack_cred(new_creds);
 
 	/*
 	 * Get label from overlay inode and set it in create_sid
@@ -4589,8 +4588,8 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 					const struct cred *old,
 					struct cred *new)
 {
-	struct task_smack *otsp = old->security;
-	struct task_smack *ntsp = new->security;
+	struct task_smack *otsp = smack_cred(old);
+	struct task_smack *ntsp = smack_cred(new);
 	struct inode_smack *isp;
 	int may;
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f6482e53d55a..9d2dde608298 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2208,14 +2208,14 @@ static const struct file_operations smk_logging_ops = {
 
 static void *load_self_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -2262,7 +2262,7 @@ static int smk_open_load_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_FIXED24_FMT);
@@ -2414,14 +2414,14 @@ static const struct file_operations smk_load2_ops = {
 
 static void *load_self2_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self2_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -2467,7 +2467,7 @@ static int smk_open_load_self2(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self2(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_LONG_FMT);
@@ -2681,14 +2681,14 @@ static const struct file_operations smk_syslog_ops = {
 
 static void *relabel_self_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_relabel);
 }
 
 static void *relabel_self_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_relabel);
 }
@@ -2736,7 +2736,7 @@ static int smk_open_relabel_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	char *data;
 	int rc;
 	LIST_HEAD(list_tmp);
-- 
2.14.3


