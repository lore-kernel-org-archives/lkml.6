Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EC1C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD262157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EwHK/SiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD262157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392112AbeIVGN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:57 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:37786 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbeIVGN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575757; bh=Iu+tSavlo7t7q7n3Olg0VNVdtV/eWmeqFaZXnw9uMGQ=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=EwHK/SiGqCVb80ePHfMiMED/MFmPWaBRkh9xrsSXR5KKAhFXTTlisAuTAMljWj7DtJmkcGBoh3QbVoEWiTVoaa2+1SJ0p5UP09qMi4hh1uNOTfHuacFKR1IMhW8E6tPMhJH+RLyP9jdoQBEV16Hzt8Mc18CZbgbSPEXcalss+ZU0pBveqSwI+iPfvos72hrH7CkyB4AM9kaCGcJ4HePJsjYPmVwLqaU8Xtyl8o1qcCLXNVC2d8z6q1tRWISblt25wnp/cL9mKSaaWVoohtmhu7jft3bSfGm7JIYJkmPb5LU7fJKZ0zRJYkNuWtWUkyqlzX7Bv9CW9FKOp8x76PrIKQ==
X-YMail-OSG: mYZXFYAVM1lVoWPokzHRxWvWAUDVA.vbkLkKy0mzbMBQgkcUQfARil.f0Gj_lJD
 x6QVmFW2qBbVcVrD.CSsMw.ThD9VQ.LawsfMJS4klkIdX2MtFjukoYkATH8PU8TOsJ8X1Eh_AuBb
 evazV0PxAXp8el8ptxckx7m17WVUnP_D0G0biXUgJnTw7EHS1XtDvCbTtU4ws65An8j1..aKh5Kk
 CTHk7eVQ3lfFp4AyrAZtI0AX5dE2UuqDXe_xXtQwrDFlFQiLGEPGYdyBEE9Dth3HOWujIMZlWl78
 t6dwwUAY6fwx__SSJn9NzJaEOiNDRitCBNff3uIl0iZOT_ar8Pr58QtOehyptY9gDeGBDDu9GZKC
 psx2QLynWJEQ2F8NxqB2p5uOPeRVBy_cym5QVYqGPBL4PKSeqJxFaMPPE5qFkz_EpQWRr6.U3zbi
 Zn4YmzvF6B3qOLsyBlt2b7HCEbOVGFvUOwd1k.qIQhmK4EQE3fQ7izr6WefrJ_.cUr3mcbXlq7gr
 Vhhk96ZsQorC2SC9iZzVkjALXm_WiL9EcnL6Y5Y1_OEEDsZlH3hImTKKzNC0GvTi1wa5L_.XkiqY
 dzjZ0RtTN8PRJJpd3dXte_t5Az2o.isNEfi_DYInQuYMTwP0XR4woUt4VG4lM5lXSzUz4WcmzhZs
 CHXF.vqn37YlZ3bEMqeTQF...Mi0wO7GjQ_wpo6r0tJVELRe5oQfv831QqDT7w3618uGXnWqWx4d
 UhHMdYVsTFOFl1hAoXJol.SqnV87eF4jrcyiFh_lyg11SfCJE3lJ3KfaNgLuQVFzSICcRTiLdLBj
 HVhBvn2TWJQwbLhXPhaEeUNpLiP9Qw.LlLBrPTXAeEWYiJOOfxLXoch5KSOM47ZQYOUrM7HxfNv5
 t1O5_lSRm2BxOrhbYnluZHzbMvV3_lk_LR3KiRpLk03J1dRHgkJmuy3CdmIQO9EL7UyfctJUJB4o
 TgCHptZeB7zsb.omxCjwi2liIECwebkprXmk0k1f3txVYLATleqKzxjxAfWOv3EInWeLFdy5k8v0
 _l0HoE79_22emyxpXIQCa17eWOtxXoVerw9GJ6q9cLQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:22:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b48542295dd1eb116f37600aab27ad1d;
          Sat, 22 Sep 2018 00:22:37 +0000 (UTC)
Subject: [PATCH v4 09/19] SELinux: Abstract use of file security blob
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
Message-ID: <3acc0eab-7081-fcc4-f146-1b17772cc97d@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:22:32 -0700
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

Don't use the file->f_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b629cc302088..641a8ce726ff 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -396,7 +396,7 @@ static int file_alloc_security(struct file *file)
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	file->f_security = NULL;
 	kmem_cache_free(file_security_cache, fsec);
 }
@@ -1879,7 +1879,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -2223,7 +2223,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct file *file)
 {
 	u32 sid = task_sid(to);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
@@ -3535,7 +3535,7 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
@@ -3570,7 +3570,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
@@ -3822,7 +3822,7 @@ static void selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	fsec->fown_sid = current_sid();
 }
 
@@ -3837,7 +3837,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3861,7 +3861,7 @@ static int selinux_file_open(struct file *file)
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	isec = inode_security(file_inode(file));
 	/*
 	 * Save inode label and policy sequence number
@@ -4000,7 +4000,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
 		rc = avc_has_perm(&selinux_state,
 				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index ad511c3d2eb7..cad8b765f6dd 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -165,4 +165,9 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
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


