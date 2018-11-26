Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A33C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EE22082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KowtF5DM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EE22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeK0Koj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:44:39 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:44815
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbeK0Koi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276126; bh=qbpXcajJrA98ZZWDlgqmt0cbStnF49zKm903egriuBg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=KowtF5DMSc298/qt2gWvaYu22JFcylgEW2xik0Bl4lMS/P1BiJY4sQMza8STTf2Moe2g0C9R+nTASF7xpgrqB4JxSiCJvnG1qJX7omximaTs2pGYtixJbr2TRl9tHGiWfn2g8Z2oUyHtZNhgxV9yxSPhKNS+M2/+2eYujTvzp1o4nAe/WLjV6JJc2tnGooZ6ym0mE0/dyryAT23f/NuVuERxcSKw9ZFlvP9ZkCsfT7RblklvL2zCALlENMIRbkWB2PhPvvxjo/+LZj60lDvdW8NGbNF7sQR1kKGVRJgKfgkSkcVEMcs4cmcd7PTUYQfUbMgVt1hkLb/DF70K32QxFQ==
X-YMail-OSG: JP5K1QAVM1nKa.vRMNBzjG0jIEuf9a_7fD.DXkm7j4GbvQjNE3Fv2.4.TyutJai
 XQtSm0Wpr.4LmroZBOagKW5hxY35UhFLi7ze5OsrGY7bXbqmWgz0sC._C7f8bxxPN4hRogIWW8vv
 6xnXVHKqf3eqSMSjVnfITarNT7Br1Sezcu5ZkFrOXoT0C9A1kQ.cCocRcMTvIci0rbPJuYUUBoEl
 4TiEuyVKa5gOLvSDsnsvGUdDFd99d6ssNVPiOcqt9Ztjq35nDY4xy6.rP8VdjQBQ5lt8Ehi21NjY
 cTaaj_uQXIV7qlw2uLRapG.ouXq1XakQzzFaCifjVGdRdtDWUO3_qpDOql3RAoaZRWW_WhBWbMBX
 QbPrlqnVeFu8xF38KnrFxEhSIvy1jO5scg8EEHufvvrkJO1ZxFMfUY020SBt7qeSRxnv2XydimUi
 i4S_kZztIvbRGq14xYQf0y7MSNFlHDMKgTyLkQNySLZyo30pGCesVKEGlvK5PoMqkEjYzsRuCRea
 ODbdzzm3oLDyhIvGDrh59nXsZixc3Go7FuLeMOHz9HikDokQDuZdl_mSjFAFBDhVPO4pZBzjTFxY
 piZn3A2lyHZ9bKnnROMjPG4xT6kOb_XF4t_gFZOJglJM6VABXmy1lZ10VsgpOvHv4jjppdSXj4i4
 3bZQ70Q3h.yY08U_BC4MEeX.IjoVjoL24uOMyI7IoH73T4nlMyGclZn0skeBk6qswfdn0arCWkC7
 V9OCfCPN7oYf_Y4T2tiDrw.K_RW_NgARPD3hfK8ZQawOgHrHsyjocfbYg.xxv_9386jGhQ85x_Qe
 dYSeMgGIx_P70a.X6BOxYiJDl32SvrtMkTwZCbGMJTf7uXK96AK5VZxELhJLyyVXNUz0AFBMalm1
 3wll2aX_iQ62I9_4rkaTG2osn3chNZw8UPwJFYUx6HeCNUnq.LEaXoKSNC071KjiG6jimigyxPRt
 ZjWlo9HW2fl2kjCA9wl7D5a5yM7exx7TKGvBiTBl_v0QykoKWbQ.E0FpjbYRem80ecQHxoxOFA1u
 .t2fdQF1Et4_Zypmx..IJJDWoMfGMDEonSD.14YirWPzeGgT4K7Cy5hOiVRLQCZzFs3eUCA_DVXh
 zpe8MIqeWUdc2.qxZvyEXQLJYHHETGvDOHLUeug--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:48:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f5346034b70e818e7690c08090f23b62;
          Mon, 26 Nov 2018 23:48:45 +0000 (UTC)
Subject: [PATCH v5 28/38] SELinux: Abstract use of file security blob
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
Message-ID: <d9b63669-c163-449a-dd13-c28baa02485c@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:48:42 -0800
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

Don't use the file->f_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ac6d8a2d00f1..ce1d37378eb5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -393,7 +393,7 @@ static int file_alloc_security(struct file *file)
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	file->f_security = NULL;
 	kmem_cache_free(file_security_cache, fsec);
 }
@@ -1881,7 +1881,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -2225,7 +2225,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct file *file)
 {
 	u32 sid = task_sid(to);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
@@ -3537,7 +3537,7 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
@@ -3572,7 +3572,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
@@ -3824,7 +3824,7 @@ static void selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	fsec->fown_sid = current_sid();
 }
 
@@ -3839,7 +3839,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3863,7 +3863,7 @@ static int selinux_file_open(struct file *file)
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	isec = inode_security(file_inode(file));
 	/*
 	 * Save inode label and policy sequence number
@@ -4002,7 +4002,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
 		rc = avc_has_perm(&selinux_state,
 				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c2974b031d05..e0ac2992e059 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -165,4 +165,9 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security + selinux_blob_sizes.lbs_cred;
 }
 
+static inline struct file_security_struct *selinux_file(const struct file *file)
+{
+	return file->f_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.14.5


