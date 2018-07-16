Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16439ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C154420870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tQD9/tJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C154420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeGPSv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:51:27 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:35660
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729969AbeGPSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765370; bh=MlGGKoQYr7U5v6wDGI5gi2EIDQu/aB102bB9SZNJHvA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=tQD9/tJRA6JtgkrTuLEvpjzE7Sz2yCo0Z66wFRtIvhAL3ZVLTxmMAZfwlOtXnjhcOxmq1saWxdBGrebxH9QX87GFMQt9/MzuhKW1xPrDb+YEBfD/Qp7XZVEFc7BMVLyyd2oUhC8F/UUhQukqlqVz1TPnTIxWmNO884kL/iXhCItcFD4o7Ol7+J5nS7v72gG9qJvM1mydgmyyLGkt90PKG0qS3UynTbTID+HZXanRG5SIo5G4Ooc+1RxEHzQGXQFks/oc7nh282YKnck3CQA3qH+gmuayNSC5PFI11ue8TSc/RVyI6JEn3EDKTcnf6DIAgvN4+RFq9SspgNRYTA+/Zg==
X-YMail-OSG: QzPBwRgVM1lwfXOleqQq1q9MdW4CVEhcT3_9019TKAyJB0QEp0m22U7KAu1be3X
 m3LSQJYb8HSjuGtHPX0AdhqZphlWooxgRUk43dFKTWEBpGbbL1ayg4EHW6v3rzjsd0r7EnFKq8pX
 X24QLP5pWQ6GSehHXd4cxV86DB61NO9rKJ7vNwtP1oVBSx8DcUXA.hmxkobKeGRnHhGtWztH_iJh
 oRPY.gqfnZdBJfw6yMGOsIACmxu7kgf11K2iPB_n6ctWWpjJLE.mAu6D0zpCJ.2o7btvr4rLug8Z
 1Ifrv_COqsgtlzyeWrzIVQ_0pBo4H225uBRdRvsDBzwMrVjwYMJDIFcCrsIv4uRpHE0wv_Gqc_g.
 q8NtrsYeR_ADZGOt_jih5Cj.IfP.M5jD_VbvbwbLPsg8dkG7BVvZCOR0._82ZOweJt_STTd1VSV5
 4vu0SjjOW2Clzk3WkjHkZSwIvaYadEt.trHIZ2mJjDpzwmcp.TwrFKBJfXyJDpSsC_PeuBpQ3KuX
 HONTJcnxRCIE261quhJyx4dqCAYMd1g2qidCeF2562stnkFpP4dJPmrTvNcv8e8sdegnY38S1FLM
 ZDo2BLcWSptW0QkNpWSC5iHGaU3oBySzNhUKgmCTHrIwn6oQ6Kr0hxlMprI2U22Dp8Bhik.9kniD
 _UcUxAvqUBF7IhwzF0tB7msd0mnpgn4CG_4pBfLyKXoDOrQNUVZ30AdfXnBxcEc1J5Y7wB9no63q
 .B6Fi8qiAG7QaT5Jik89o7DNbF1qkuWT8uLWcP8XhV_ri7o2AzCOIu0zhZOrZ_sopn.EPeM5H64w
 i1AhE7WKPGBK3bHNZ4iqZsMm50byxbclfcMV2hpz52Ht9k5EKw6At8y3dXV3iaNpLTGagWAqC_9f
 4uO2qDjiWh.QVUFe3U87g.TBH.GT89CxA5hytgDR.oUAi4sURd4VqSIoe8WzP.Yj_CGdWSImLXNI
 qBcemnkWiXAWwzQUm_1YXrZVVZNVG96AGah0Z2mRo1uMYMXSjnLkvrQXxplhrQ7zKDIRNYweVppc
 yGspdPgukl4VqOr9L.4kP
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:22:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c21abde1eafbd1d358aefd50f46dd47e;
          Mon, 16 Jul 2018 18:22:49 +0000 (UTC)
Subject: [PATCH v1 05/22] SELinux: Abstract use of file security blob
To:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0ce8deed-d89d-5d88-a609-eeca6ccf5520@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:22:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SELinux: Abstract use of file security blob

Don't use the file->f_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1d2487f8e88b..98ee88156e11 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -397,7 +397,7 @@ static int file_alloc_security(struct file *file)
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	file->f_security = NULL;
 	kmem_cache_free(file_security_cache, fsec);
 }
@@ -1882,7 +1882,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -2226,7 +2226,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct file *file)
 {
 	u32 sid = task_sid(to);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
@@ -3538,7 +3538,7 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
@@ -3573,7 +3573,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
@@ -3825,7 +3825,7 @@ static void selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	fsec->fown_sid = current_sid();
 }
 
@@ -3840,7 +3840,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3864,7 +3864,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	isec = inode_security(file_inode(file));
 	/*
 	 * Save inode label and policy sequence number
@@ -4004,7 +4004,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
 		rc = avc_has_perm(&selinux_state,
 				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index db1c7000ada3..2586fbc7e38c 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -167,4 +167,9 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security;
 }
 
+static inline struct file_security_struct *selinux_file(const struct file *file)
+{
+	return file->f_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.17.1


