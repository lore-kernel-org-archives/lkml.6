Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA9C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A2520880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NOQLHU2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A2520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeIKVmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:42:14 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:44294
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728111AbeIKVmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536684124; bh=4ClzVXf1c1vpYtXQSRli2QiS1/B1yPxp/XJLpx83RE4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NOQLHU2WEBVGd+KCIdBFuayYNSCLu+XTn9qEt735RL789OIiAHNfySu7yZrEAdGe3OVms54e2Lc1BSdS536uCvdM2pvueoV0UOxaRlIYg0iVcB+nU3/ngkhIlNUQa7Hy1Y67I0gD6HiVOci3Vh4qFBs3UTNrTCL3WZyqHNzqNCw9EBNSKte020XmIikkqW7hMChS7FUk2J15AAi33gvKB1mxLpCWX7hgWpqbMr0IIbQxhyuuxchwZivxhGT3bYzVCOmrXVsGYYiMVAf4KJM/v+zg93AEqfpYNOL9i40MpgRUxoqmK7Q4GEer5CX/UOrZKPEJurjrTorJ9VePDx1mag==
X-YMail-OSG: 6ZDxm_0VM1koAFi1MIitN0syDJYKOHQjoEBj8xwz7BqTDz7LZlQBNNfr5TC3iyl
 I7EViKe8ulHTTBwDsjFFtBenJ0Ebr8lGHA33UBKVZRhLYoc5H5iqb.dMJHUvKup8JvxTJlZ0MsGx
 vCcOB96dj9TYamQuN2aZ1tIO60ewN1r3qDFaoBG6.1byoGFqo5NiFufPITazp3ISeB6JXmTFXVwE
 ZoJqhUqhNKdISy870gvMxeN_8SL5fbT3J3884WinIfuZVw.egFUhWitljZF1nna2CC5cevZvLcds
 k3dYX4CPDJLkTHdQhrAE8DLjTSnw0mIkhp8IPQEjXZpvQyLDTBTuNYQNciGAHP9T8S88SWqMUFr5
 edhhT.NMF63y5DYp.5fduj2c5uoDIlQ.lUeSCgYdg6IzmyfHcUmaDl4ZHkG_XoAh_ew2_gfLpVz.
 AtVBZZLJBzUDsVeklQYsSjxqiasbaXJntQ4ke4ZG6quG2J2UwpyovU9wA2GjSvTSXFOiIViw5qac
 ZFlFT.UwksTqeCtuGxzi5Fyd67khNh4a1qoRk1IAgTeNfTMte26IPFvG1ysJXoUmMaAAYR.NBsGt
 RV6xemUByGDwv4oTlJ_f3_Y_qEGTHoY1dQeASPfKdKqDcfPh0tDjQeXiORku9hbyvpUMYmPU9bq.
 s1K8lRpTMQAFPg8Bo7UwwbTmtc4AxiR38ccfII394ITosOfoLd0JRBANBfNfvvH7RGmUkqBcgxrO
 X_HFL05IAs9xEF5dADzzpuW64o4XXy_tJ_UGwi3yQ.etfHtNKpXWckPCOfwgUQLDFw5Xpm6IXprk
 Va9zDmRxlVQL.dGduRp68yqEZx55bUJdFjZdzGEQQeaZG4spXqTfjgLnoGE4.n0aqBAR0kPyBxvK
 Cfphi8lfiG8xR3LjkS6IBtK8i2i.KeLVnHfJCRHK93yX8leI8ar0BNJTXEa3ylE93PVVVmisoL89
 nt3iY8wgwTnJGLznmWUck9yB37Yed5t7.dUyZC9UdGoXosFFdTlKvAZuCRyDkkPtOJWqx11fw6ut
 ShS6rfinXqeyEI0e729ygTYWP_Gy8FiAnQ9KQ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Sep 2018 16:42:04 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fa9305f2bb603b002ee5198a503b0a13;
          Tue, 11 Sep 2018 16:42:01 +0000 (UTC)
Subject: [PATCH 05/10] SELinux: Abstract use of file security blob
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <65bccad6-5669-9f4a-a645-35e0da301817@schaufler-ca.com>
Date:   Tue, 11 Sep 2018 09:41:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
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
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9b49698754a7..94b3123c237b 100644
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
@@ -1880,7 +1880,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -2224,7 +2224,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct file *file)
 {
 	u32 sid = task_sid(to);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
@@ -3536,7 +3536,7 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
@@ -3571,7 +3571,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
@@ -3823,7 +3823,7 @@ static void selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	fsec->fown_sid = current_sid();
 }
 
@@ -3838,7 +3838,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3862,7 +3862,7 @@ static int selinux_file_open(struct file *file)
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


