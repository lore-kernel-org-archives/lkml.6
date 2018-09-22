Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6F0C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0771E2156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IOes+eKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0771E2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391730AbeIVGIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:08:40 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:42039 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391717AbeIVGIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575442; bh=NJlgySVhKkti88Ke2/CP6DIkkD+ndlpqrxjeWUpvOF4=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=IOes+eKq/koFarDALuVwzCWjtPk2isx8TCQhoFOO+6sYgxdUdX0c+VvUFAOysRD687bez0ljFLy7uGlsNs41LGwXTlE5M9GM+5vrS1m9Zmc6DNgaT369pJ0bQfmhZvTzBH3D4dNVod5XoYOnLt0RNZBhn7Or5pmcEaQmJ2wiHnJgX3pVPK5QHBWTVfn3cdrAWQ+atJhfR1W8Hqt0stnQ/ssBCO50xiEQYexPLdmcOe2hrODw6bCn2salHYSuLDhtFbUZzycGBF/Lpgo/n7mXR2SxEjGfDOst5c+aLHeJFSSQL76TqCEIzAkmYorKX6MpgKFBIS+MyXJxTDCHsTcWpA==
X-YMail-OSG: 4lH2B7gVM1k8Fo0JbexzVq.0MOe8ygO724hZU7zrVbVdWmr2QRMnUFukGAZRPo3
 wtFLGEUsZMakUvQGLATk_cxGilj_GSMkO5he7Yun5naxXvoRZRxTtOyLLh7LaJh0Tqr8rfZ27dy8
 7uMGxsBQEgW00jIYQ7IuTHLje2bYTArToQjNvVBIgK0uyti.3KMWu3GApwxFoVLB5T2gQrPNYSs4
 azs1FF3OOamIMfucnQBi8b59TOHKOzINrlQfQm0iz2czY9_1vPslK3CBw0s5CWrJA0aZvw32t8uf
 ho5rWZxn18NOMuzS284bzoyfGiayDC10w7n7bGP0C_2vLvzWBC0vfv8UDl8OQOXIHnsDhpzjsm0u
 8Pp23xeM7u_.mAgjivbAPCfR8rATaEMNRUWGBUp9casea6BCnMXqtP.zuVi48w86D1yH_VA7fP_h
 galqOmPr.kVYmu6pxH58g4c2JaCLJGajKM1oQk0WBa8iMfhhse2fthjk1JnO03EjNPjzeZ6dHQC_
 gIZU9LVwm1eljv4m7sBi16yGC6zth2L.jsBpRUmHtrCsi6QoW4UmVqE9jCBCluhIwRfTBd4ZRVhI
 So0edGKxpmpNsdAgEr1wFK0wbr87cSySJewjO1o2KFsEJK4eK9XwGYQovk3utZJIWbiH1YxPvCuj
 eLIQ4PVyDQ7GQdw.0Koa8Xc19TgBeCaUNFEBlj3iCLBwUXQYVYCh1Ex5BolA0p_VCKjVyBhMG5AJ
 UgGXFFwW02xgNFKk1MsfFmndalliNoWmrTRjcsm97hEntdFPgAzcJb7tIjlVLMjOQbUD1TgOzT6J
 VMG9Fe5nURDU8RAhOgOIXyt2g6z5LHNppB7POpUHZwv45Q9gjR4Uzmq629l_7a3ouXrgFyRncBZq
 VToJgX9T6I2cU6_N6Pt7flKXsKKG.b9ANqjD2hgeCmMljcMcSxGrkkOB6Bh_H.AN.XMReGpvISTr
 f7OImyhxxVnSIOaF03Gzu1lV0Z4sYt1VlCPNDrTU8q0z2glHw9qIWk.dZydb.oOMfxFFmy2tGh2f
 C7ykEgqMAiNbiD5o46NupdIQvY4X8eQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:17:22 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e2a7d46096dc622f046581817a1535e3;
          Sat, 22 Sep 2018 00:17:21 +0000 (UTC)
Subject: [PATCH v4 03/19] SELinux: Abstract use of cred security blob
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
Message-ID: <8b652ffb-5636-7aed-0715-f896a6a7cdf6@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:17:16 -0700
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

Don't use the cred->security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 54 +++++++++++++++----------------
 security/selinux/include/objsec.h |  5 +++
 security/selinux/xfrm.c           |  4 +--
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad9a9b8e9979..9d6cdd21acb6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -228,7 +228,7 @@ static inline u32 cred_sid(const struct cred *cred)
 {
 	const struct task_security_struct *tsec;
 
-	tsec = cred->security;
+	tsec = selinux_cred(cred);
 	return tsec->sid;
 }
 
@@ -464,7 +464,7 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
 	rc = avc_has_perm(&selinux_state,
@@ -483,7 +483,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 	rc = avc_has_perm(&selinux_state,
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
@@ -1949,7 +1949,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -1971,7 +1971,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = selinux_determine_inode_label(current_security(), dir,
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()), dir,
 					   &dentry->d_name, tclass, &newsid);
 	if (rc)
 		return rc;
@@ -2478,8 +2478,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	old_tsec = current_security();
-	new_tsec = bprm->cred->security;
+	old_tsec = selinux_cred(current_cred());
+	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
 	/* Default to the current task SID. */
@@ -2643,7 +2643,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	new_tsec = bprm->cred->security;
+	new_tsec = selinux_cred(bprm->cred);
 	if (new_tsec->sid == new_tsec->osid)
 		return;
 
@@ -2686,7 +2686,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct itimerval itimer;
 	u32 osid, sid;
 	int rc, i;
@@ -2989,7 +2989,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	u32 newsid;
 	int rc;
 
-	rc = selinux_determine_inode_label(current_security(),
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 					   d_inode(dentry->d_parent), name,
 					   inode_mode_to_security_class(mode),
 					   &newsid);
@@ -3009,14 +3009,14 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 	int rc;
 	struct task_security_struct *tsec;
 
-	rc = selinux_determine_inode_label(old->security,
+	rc = selinux_determine_inode_label(selinux_cred(old),
 					   d_inode(dentry->d_parent), name,
 					   inode_mode_to_security_class(mode),
 					   &newsid);
 	if (rc)
 		return rc;
 
-	tsec = new->security;
+	tsec = selinux_cred(new);
 	tsec->create_sid = newsid;
 	return 0;
 }
@@ -3026,7 +3026,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const char **name,
 				       void **value, size_t *len)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	u32 newsid, clen;
 	int rc;
@@ -3036,7 +3036,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	newsid = tsec->create_sid;
 
-	rc = selinux_determine_inode_label(current_security(),
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 		dir, qstr,
 		inode_mode_to_security_class(inode->i_mode),
 		&newsid);
@@ -3498,7 +3498,7 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsec = new_creds->security;
+	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
 	selinux_inode_getsecid(d_inode(src), &sid);
 	tsec->create_sid = sid;
@@ -3918,7 +3918,7 @@ static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void selinux_cred_free(struct cred *cred)
 {
-	struct task_security_struct *tsec = cred->security;
+	struct task_security_struct *tsec = selinux_cred(cred);
 
 	/*
 	 * cred->security == NULL if security_cred_alloc_blank() or
@@ -3938,7 +3938,7 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *tsec;
 
-	old_tsec = old->security;
+	old_tsec = selinux_cred(old);
 
 	tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
 	if (!tsec)
@@ -3953,8 +3953,8 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct task_security_struct *old_tsec = old->security;
-	struct task_security_struct *tsec = new->security;
+	const struct task_security_struct *old_tsec = selinux_cred(old);
+	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
 }
@@ -3970,7 +3970,7 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -3995,7 +3995,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4544,7 +4544,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -4564,7 +4564,7 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	u16 sclass = socket_type_to_security_class(family, type, protocol);
@@ -5442,7 +5442,7 @@ static int selinux_secmark_relabel_packet(u32 sid)
 	const struct task_security_struct *__tsec;
 	u32 tsid;
 
-	__tsec = current_security();
+	__tsec = selinux_cred(current_cred());
 	tsid = __tsec->sid;
 
 	return avc_has_perm(&selinux_state,
@@ -6379,7 +6379,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	unsigned len;
 
 	rcu_read_lock();
-	__tsec = __task_cred(p)->security;
+	__tsec = selinux_cred(__task_cred(p));
 
 	if (current != p) {
 		error = avc_has_perm(&selinux_state,
@@ -6502,7 +6502,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	   operation.  See selinux_bprm_set_creds for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = new->security;
+	tsec = selinux_cred(new);
 	if (!strcmp(name, "exec")) {
 		tsec->exec_sid = sid;
 	} else if (!strcmp(name, "fscreate")) {
@@ -6631,7 +6631,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 	if (!ksec)
 		return -ENOMEM;
 
-	tsec = cred->security;
+	tsec = selinux_cred(cred);
 	if (tsec->keycreate_sid)
 		ksec->sid = tsec->keycreate_sid;
 	else
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index cc5e26b0161b..734b6833bdff 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -158,4 +158,9 @@ struct bpf_security_struct {
 	u32 sid;  /*SID of bpf obj creater*/
 };
 
+static inline struct task_security_struct *selinux_cred(const struct cred *cred)
+{
+	return cred->security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 91dc3783ed94..8ffe7e1053c4 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -79,7 +79,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 				   gfp_t gfp)
 {
 	int rc;
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct xfrm_sec_ctx *ctx = NULL;
 	u32 str_len;
 
@@ -138,7 +138,7 @@ static void selinux_xfrm_free(struct xfrm_sec_ctx *ctx)
  */
 static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 
 	if (!ctx)
 		return 0;
-- 
2.17.1


