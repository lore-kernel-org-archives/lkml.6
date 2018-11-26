Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9611BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y8OOtXNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeK0KjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:39:25 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:43872
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbeK0KjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275814; bh=2uARvLb1q2zznR0LcReH3B1TK7Gvxnoz0sP/IEti4Co=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Y8OOtXNC9bhfhc+rJ0Jr8jQfXQJtm6gkgsfx4UrvMT8x8GTaThhAWiv+WCCdY5Bqh9ln/34LzeM1SGXiH9vdMsw/4ofdH8QpdKlRP9pQ1An9olDLpp8Vmo5+mXoYXWk7RXDbwbIWAzyEuZ6qp9qaVhLIllnjCQjVyauQEhasTLLlLPvhTaxA2RFbZNJ5JzjcGs+SPCZW01Pcgtoc2E6lic8ArO9hsm7EhGz1esHHulg/2skNALOhayIWu9UWEfpGrboMc7js8+y5KrhUH0Ni7d6SU+Sn61maYno1GlMn+ryspouVIar7B3kvhu1KWIl+S+8LwjIJTsS+hjwIrgFeAg==
X-YMail-OSG: 1N_rOtYVM1ks0YG0kZQ8VfJoMqSmaJuytj76WlyydOosAEtUhvRYkuyj0NRs.HU
 Aksb6FI1knxLWDECuOVeJ6HynN16E.BloK02vdlMT79R7yiFOsiHK24CTHJXn9U.px21Rrzx_8la
 lsAyCIUTm2mtqJb.dMeEe1jCD3F7d9OMWOhG.1mzH2nrS11KFNQ.gPLwiF1zAOqTBdggX3doNjnb
 S2uboU7Rsumc.gS_U8qVXOJA1wMX58pL0lsPQ2aoWN9MXoYhxWg9v8aIjaqOlGk_VUyV.MTAJmUx
 pmxstQW4tyUyaJ_TOPB7p99UKForMOxttbaMrzfzIQOcczwnuk_vC4P_h5oiKDGtqKG5Yor1uVSa
 U0WpH3UJ2NBmUH8obiYiXVtlNAASj42Gx_KK4.3BnFWZzchH110j0I73oUPhrrf_GEi5nfPkAZor
 eDKSn4jP.I62WU.E8vIBv3nWSL0Zm8n1F3y6OKgF0GMQ6QJ3hg1QzRXM.h2kItzBgQ1v6zUuEFkW
 D0g6UkkZlvfdsZFyxrp8plUcRqNtS.sXHAlOQshXijQRiWPrpRFlr.q99m0G2IgxiwQ2cT23JjUA
 FrLgl75RPBu4cwzeVz9n1il0bqqnqgFV5V2W1kj9Y4kJCPM8vX7swgcaxAmns0ih5Th7Fu9FTABp
 BeYrmadSl5DNcmVyyr_dBUMgcYgBJp7Fv7uJKA5eV1_tnLIwAxygfAkdwUkHnNOpnRELlcYiR0Z1
 TzAgWuo_S7BsvV_Zr7H75oMvto2Bc1n.IJPVB9jCE83QoqD_e8RcsbYXLiaXeTJAVktwa9J_RN9A
 EznfER5B02IXlC9zGXVCUDiIWNRA8wdGZ0zed4Eb9NIMptjz.B7btMCIvNciMt69iTqpcpuY7DlK
 HUJjmvjeZr__IFPc6ubeT1TGKw.8rXmECPOiWhULgxsQQElX1YGGRAmDyeTGnDm.cqGemBNSaRG2
 iy8aK_Xu9bfQQfu_3oEuwpWaAHk8heUiGTujKoPwT10VTjORrDipPR8f41rRKqbRN9NpVWzuWg1X
 .ZY516_a2W9No4fMiwiZ.ErruBnxEVXRKZt0g3RKpeXamiUpWS4ZlgOMBO5LE4WWI_0F6dFQaVlY
 QrCn9ItPcBDcTOW4.NFL_pi3bBxSBLgEoSMfZhw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:43:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp404.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9e458e4f214f6e0156b0d8fc322fb9a6;
          Mon, 26 Nov 2018 23:43:33 +0000 (UTC)
Subject: [PATCH v5 22/38] SELinux: Abstract use of cred security blob
To:     James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <01fc2b8c-d924-4752-9974-e08527e31b47@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:43:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
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
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 54 +++++++++++++++++++--------------------
 security/selinux/include/objsec.h |  5 ++++
 security/selinux/xfrm.c           |  4 +--
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index edd5b8dd3e56..24b6b459fa2a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -225,7 +225,7 @@ static inline u32 cred_sid(const struct cred *cred)
 {
 	const struct task_security_struct *tsec;
 
-	tsec = cred->security;
+	tsec = selinux_cred(cred);
 	return tsec->sid;
 }
 
@@ -461,7 +461,7 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
 	rc = avc_has_perm(&selinux_state,
@@ -480,7 +480,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 	rc = avc_has_perm(&selinux_state,
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
@@ -1951,7 +1951,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -1973,7 +1973,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = selinux_determine_inode_label(current_security(), dir,
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()), dir,
 					   &dentry->d_name, tclass, &newsid);
 	if (rc)
 		return rc;
@@ -2480,8 +2480,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	old_tsec = current_security();
-	new_tsec = bprm->cred->security;
+	old_tsec = selinux_cred(current_cred());
+	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
 	/* Default to the current task SID. */
@@ -2645,7 +2645,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	new_tsec = bprm->cred->security;
+	new_tsec = selinux_cred(bprm->cred);
 	if (new_tsec->sid == new_tsec->osid)
 		return;
 
@@ -2688,7 +2688,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct itimerval itimer;
 	u32 osid, sid;
 	int rc, i;
@@ -2991,7 +2991,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	u32 newsid;
 	int rc;
 
-	rc = selinux_determine_inode_label(current_security(),
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 					   d_inode(dentry->d_parent), name,
 					   inode_mode_to_security_class(mode),
 					   &newsid);
@@ -3011,14 +3011,14 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
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
@@ -3028,7 +3028,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const char **name,
 				       void **value, size_t *len)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	u32 newsid, clen;
 	int rc;
@@ -3038,7 +3038,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	newsid = tsec->create_sid;
 
-	rc = selinux_determine_inode_label(current_security(),
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 		dir, qstr,
 		inode_mode_to_security_class(inode->i_mode),
 		&newsid);
@@ -3500,7 +3500,7 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsec = new_creds->security;
+	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
 	selinux_inode_getsecid(d_inode(src), &sid);
 	tsec->create_sid = sid;
@@ -3920,7 +3920,7 @@ static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void selinux_cred_free(struct cred *cred)
 {
-	struct task_security_struct *tsec = cred->security;
+	struct task_security_struct *tsec = selinux_cred(cred);
 
 	/*
 	 * cred->security == NULL if security_cred_alloc_blank() or
@@ -3940,7 +3940,7 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *tsec;
 
-	old_tsec = old->security;
+	old_tsec = selinux_cred(old);
 
 	tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
 	if (!tsec)
@@ -3955,8 +3955,8 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct task_security_struct *old_tsec = old->security;
-	struct task_security_struct *tsec = new->security;
+	const struct task_security_struct *old_tsec = selinux_cred(old);
+	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
 }
@@ -3972,7 +3972,7 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -3997,7 +3997,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4546,7 +4546,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -4566,7 +4566,7 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	u16 sclass = socket_type_to_security_class(family, type, protocol);
@@ -5444,7 +5444,7 @@ static int selinux_secmark_relabel_packet(u32 sid)
 	const struct task_security_struct *__tsec;
 	u32 tsid;
 
-	__tsec = current_security();
+	__tsec = selinux_cred(current_cred());
 	tsid = __tsec->sid;
 
 	return avc_has_perm(&selinux_state,
@@ -6381,7 +6381,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	unsigned len;
 
 	rcu_read_lock();
-	__tsec = __task_cred(p)->security;
+	__tsec = selinux_cred(__task_cred(p));
 
 	if (current != p) {
 		error = avc_has_perm(&selinux_state,
@@ -6504,7 +6504,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	   operation.  See selinux_bprm_set_creds for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = new->security;
+	tsec = selinux_cred(new);
 	if (!strcmp(name, "exec")) {
 		tsec->exec_sid = sid;
 	} else if (!strcmp(name, "fscreate")) {
@@ -6633,7 +6633,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
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
2.14.5


