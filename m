Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73565C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2870B21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iXUNPLh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2870B21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbeIVGKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:17 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:43367 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391585AbeIVGKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575539; bh=lpcJ0LJNJQkOQB1cATo9pTayV1N+KRu1y19vOF1v29s=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=iXUNPLh0P6caU33tNq6uq6cugVxCUwOUNVneMIgQm6lTVWwlNMdwiVtUUfJcgr2CMhLnNnlnoLobcJBZMKHHpzzFBgOjwHwQt99p1xZHEIIDul1dblymAFqL6EosMQt+YrNxSKzBEyzhyGyfmhZHk9FKolfDNe4EdmnuQO+8VQDsXMiMRSbUsgGKCTrMGbRDFPuO7XLo50dTjqkgvL1jzGXtPJOUyI0SKl9EPKQ3fChJgdMfleySLnBmZbM9ycITIsaKyg9is54s/f49J+xwRyyDuEPl482FnVR1RomzZi6WVVm+vbCOrQIgQngMC+r45KV5ssbaGSGKbVGV62GsAA==
X-YMail-OSG: WVySZggVM1m5fGrv7SlScyVxUMu1dCCaaVINek5Ub_qZrP0mix76mufPUZXHQYF
 m0T4RcPE1KpPv.RlcorxjGcR0jLuEAvj5UsM8B1rpz0C5m1DvIgBn9h9kglS2zKtYOkukUk8jign
 mQWGRcir9UaycwBOqB4XqTFLJOXW3M_Vg_Ukn5aptKry32mQks5waC2HiNZ_p9_5mARAdQKVpyew
 XHFyYLT1blrGxVDIv0qiyyVGs7gfYGWqqqu3ILlwgNBoXW9YXNuwrWP_m5UL4u4RYgTuGtpDwY96
 iOUJvXYokNNAGU3BEuSUsCGT9iIJqtU2oLr3DmtvDu5rWLwezMUHRDmiUOdoUpacVozMjaSU5OX8
 P8wHUqx3Lb3jNRbFuvfPfJG2fROu_wsMeecbtaqPRM9ErW8VHTnSs204OkzjzSXplGC3v92mVHN.
 OAwqrprxHpeheJ0NTRX.Z6gISi6CnUQSUQx4xPeKEszHU2pB.xaIQImfE19no7RbSXejFtMp64Ox
 pRHukCkbMD.PDJFdpwH2DGr.skBAr_Tom_vBNB14vkbP2zKsxzojIoZk3JApfJuN66BO2qnN.s2u
 imufKad3aCBo8F7s.no3QldrlGpzk2l8x.nSYCnyP4XZSWVSfmKAxk_CEHrGxm4JJkxLI.GLritu
 B10RVxfKfxMKQOWeOH8xFlZaU8DBR_LGX2cD6lKykLLKKy6Xg2xmzfHw8PgDDmU8rul2Irr_TrNS
 JaUqHDjIJ_NvkewtUSu6lIrLGYwiu2zAxwQMK8rc6MHBwVWSDRT5ZvUc1qpLQ4zmcVETYxWwzChp
 oBUTyjAomDwzZ6zbzf5.fqwfpRGnN6kyQHxJO.Wr.YFzA3Uc5TyxY7TjlKZJCHkcWl7d0.CkKNIw
 ZuTV5VgTEaT2EtRkrvI2pC.TvdhmjWAexjfz5G42iGBSqzRam4NnwuA67mqaNkYdzcRROeuYdJQK
 RYJJdRZFEkXuWU4jSVr9_nhTmRvZ0o21sho4pCP74ozKAZEbuAcPwAa8Z12d1ZPtwww.0Q7RqQ5Y
 Ph25NF5n.YcHam1PKdYT8GB1XMClYdlqnkrUqkFrehUY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:18:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6faf49e772eb78bd00dc72e8b7f62217;
          Sat, 22 Sep 2018 00:18:54 +0000 (UTC)
Subject: [PATCH v4 10/19] Smack: Abstract use of file security blob
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
Message-ID: <bd7c5604-ebb1-b42b-cf29-589494dbb1c5@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:18:49 -0700
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
---
 security/smack/smack.h     |  5 +++++
 security/smack/smack_lsm.c | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 01a922856eba..22ca30379209 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -361,6 +361,11 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 	return cred->security;
 }
 
+static inline struct smack_known **smack_file(const struct file *file)
+{
+	return (struct smack_known **)&file->f_security;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a06ea8aa89c4..9ec595f0c3f1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1571,9 +1571,9 @@ static void smack_inode_getsecid(struct inode *inode, u32 *secid)
  */
 static int smack_file_alloc_security(struct file *file)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_file(file);
 
-	file->f_security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
@@ -1813,7 +1813,9 @@ static int smack_mmap_file(struct file *file,
  */
 static void smack_file_set_fowner(struct file *file)
 {
-	file->f_security = smk_of_current();
+	struct smack_known **blob = smack_file(file);
+
+	*blob = smk_of_current();
 }
 
 /**
@@ -1830,6 +1832,7 @@ static void smack_file_set_fowner(struct file *file)
 static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
+	struct smack_known **blob;
 	struct smack_known *skp;
 	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	struct file *file;
@@ -1842,7 +1845,8 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	file = container_of(fown, struct file, f_owner);
 
 	/* we don't log here as rc can be overriden */
-	skp = file->f_security;
+	blob = smack_file(file);
+	skp = *blob;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
 	rc = smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);
 	if (rc != 0 && has_capability(tsk, CAP_MAC_OVERRIDE))
-- 
2.17.1


