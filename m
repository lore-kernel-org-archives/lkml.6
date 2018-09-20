Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EDAECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DEB21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jkIPWYzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DEB21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbeITGBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:01:25 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:42234 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387580AbeITGBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537402856; bh=gKbwLTBVM0jyPC0paoRS3Gf0k70rl6eD/ZhSMTnRwu8=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=jkIPWYzi/XapWZihuF7vk75bfOCT1GhBS8DhM/d/dCitRyeeheav5kRxFoR68V71GZsRiYDYHDFmOq7eZ0uWBHVBvYW49ZKJ1HAqICXa1NfZ/H4mOsnyKJ0+UB0/Nh8PAgPdRgMoYf2QXl8t5ekg61pAMIwmC13973Wrqd/K3T7pm5IGWcMqfUfTKAT/DHq6O9wJr+8E3C7+eoTM9IJDzAkYMfN1JJcT5xzVAp7EbzvNxvGwP5mI5aEHYIsZvny7mPWZlXe9QhDxhldqLmwOj807NZaw+B+O4zfNfBfzeL1QRd9YuyMx+1lqtN1C3pHzDX0k1fVXsWLoedxwLhmrCA==
X-YMail-OSG: X84erKAVM1leh6XmFSUXftQEHiliJrgrC1_FefJXzhxWle5l5u.1X6fkWjmPTnD
 ZTJEfvkNEBDSqSLboGYJGGw3AiTFYsnGD_KYdUsuI_2PCXBQE8w1l2nJdf.wQS9B6LHSvMIXOMsM
 9gidiObf57mwKDYRTa5QIK1AWg6KrOFFvbbjoSxLiHgns1XxllhGT38n8Hk0fVC..zOojvA0R3TG
 cKQlU6cLBFqy2YVj0d_6BQIIR6qKFIjzraiozWcUz7AJnYocC7a_y3xICa_wVL4iBVzumrh9srcy
 Ph.9OFg6uY_n255XTONSuuOiRw5ba9L8Nnx6P_ET5kLV7MnyyzVln8I0aaHUN4dz4RYsTxCGSsBG
 UbQwlKR7Mfqv4br9CsVJPnFUbYfX6guds1J0CrNz1yMUF8HqG0KELCkwzkZ1mzW2yZk6_JSAT3Ms
 oSnmwtvXEGlhIt.o8fc4_sodXqbVNXKTCWK4KCPHr7pd2gM6EPNInAnA.j50v1OyaPvjkutZnEFj
 K1fqyF_j5bE4Pq.d.iUTjcOeFfM517H7rQSC6Q6f1dYdSrNFZW0EdQQiQtpUefeothejgCLURzFx
 MiC6U3.JFFh15EvR1PKwRroffZhs9lFqztCMo0NW5TPaFPCukzUqp.QybBixPkTnxeizhbKMXgfB
 vhNxEHPnbvSrLPbA19KPvVNSpyllAG4PjuMci__lU0c37dksIAv8q_XdN30ij0zA7mH7P0cZpijv
 2uT0r9jIzZeo0rs9qL6WmWR69d7h3o3KTMZ_s1ShpR0jn.webT.ObGngJ2.CPVddHuF2Wdti.1LL
 5gYdVIeUJwQ6mJ9gujI1Yuhb5K4cyG.ed1lpEjGUuWB48zwbqFAmU.p1rYwddKtipdsXhsOzIYDm
 FR2IUqyrM3tZOMn2d31Dbv1c9N0rrC9498bAXPd9KSK1.z5ZEvn2F8O66kbAp7mP8dpFM0ziPOqL
 5zZ4dDf2ebU_zydGaHdVBFWnN5WWwYUJp6eKp5jDRsYreax2UUiqzDG9LJvhv1eZsZj6u3rRu.jj
 cZzZ9vQjcj_xy3z2mw_lx_98i8KRg3ckgfoVpQM_pDQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:20:56 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3c0b56d500b44c109d5ca8877838dc44;
          Thu, 20 Sep 2018 00:20:55 +0000 (UTC)
Subject: [PATCH v3 09/16] SELinux: Abstract use of file security blob
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
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:20:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
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


