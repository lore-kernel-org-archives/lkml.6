Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D662E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PUZWDRr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D662E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeK0KpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:45:21 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:36944
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbeK0KpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276168; bh=lKw+YFFirAcuaGMfYgMV+U5QfYDFlilvNclUnUdmOyY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PUZWDRr8EYLlnKnekUjgioCnumfLXNQ04xw1cyuCNWpBgqAZ9garQJFPRpjnjN2VEAPi+2fpWgFKHRs765YX9T4VC22Eb6PNo8fMAUFZ+jbZoWNP0PDsAoz9VCAuGcZ3+hztA3QiPiFp96sFh73ft/VE00jhCc56OIcNOBkLuJ8izANWPbBdts+oKKnlBqm6xtkJSlslXcTbAtJYRB3gAs07gl2tvzLGnPOWNeSjHiu4wr2igUVJDzEPfglk5vEncO1Wr2vsbw2Eknc1sfnYmB757/h/zD3VoV3aSmZWuJ/o6vYrOnQaRe1K9kyg1fQR0sbmkBar5fjnPxK2hRTm9w==
X-YMail-OSG: gS.HxdUVM1nlXMw0xCjA21XvdNUX6gCb8SJkztD8YX1gtO.B1dUDwLfwxAEqrW6
 tjgGh3VTkaZgWci8UZSiu6DN1tMjQqGr5A6xkRNQWWFDIfK5H3Kt.lgjKgUNi__38mz5.d2EOODO
 fibOhFOF9q2HZq4HfTlAWGTYYAzEvbcJlJhjgsEmDRDghJUnJvBHTNw9h0NrxV.1R9xrB_jfg3wF
 PHu9SSzvsoOYFEuGAbZltoBYUBTL6K5kcNCYFmRBQcAHoO9hsHrGdl_4wtkD3iURa2RbKhMx96sT
 LV2z2Td59VxzSrhvO0LOtf3KOQ.neFyu2LyBge.kZ6Pb1vJJXttq3OOY01nxgUWBT2MOvPohaa7w
 tijrbUFZUNXT46dZyA53oVAiGEZvdI2GMfJJocF3xe5_g0q0qGSBPYML_g_oOfz.Wqi0KGQBv6Yx
 JQF9WTRHIZLErErRpzfC_79K3bGbaZh5YJQRcyby4nm8T_LpbYFQUR54gzSe6f0zRd08agDj2kAm
 zoOwUAC8JHKFrPo8xjCQLR_WhrfCY.UhjAuLPdXZbRPStVXCvy_IQpKhpww7yRUCA.hMNKfyFlTL
 UWyKvmQZWTOFqWCFjPvNGukOBIv8sssY23xpXzLuIyC5MlFmRnDzUZzfsPLCWGhwX5iiYq_TOn_b
 GNP0.0HoRB0ydcML6jk9BW0Dj8TRAISpsqZ_o8rXx6lx9R8XO261k8.m1cqRgsW2WaEaxnEMFlhx
 Pe.18b7KlhHvIZ66Ofe5psQ.GFDP4gkt6HtyIHHQaHJYMHSBoQs3kNF7kM6yVN97R9N9kQmLYK5X
 Y0LWf6d2k.lHIihuCuNxW5sizCsTLUt_2CoYKtXDCGghRkDqALuNu2jYoWVXfh0R2p0tK4WAK_In
 5uN8ZGvq0xEg.XXTmM4lIWHC5D.s1ziyquI.2k08WJ92wURZluTJUtv0h5u0mRa6gjM4dtxCKKhT
 Auv4x4kY9bSY4CNbP8OUUzjDi3YKk9xFfdIuJnUeGOJpEVu7pcXCe.Un6qtu8GT3.Zj3mTli8NU5
 2PTp1vYPFLrcx19hhKZH9T3TfHkkfdnO0n4VicCmw6J47Z3Q3l1rJMRQpueqRYJn50RiVFfV.N1L
 LUzJDNFFisUC9W9PNewBqrFtDjhTKVHVHWNA03w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:49:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d56dcb8ac3e69b0ed5e21632e555d156;
          Mon, 26 Nov 2018 23:49:26 +0000 (UTC)
Subject: [PATCH v5 29/38] Smack: Abstract use of file security blob
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
Message-ID: <a158e14c-c75c-8f84-a131-aa1ba209a4d9@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:49:23 -0800
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
 security/smack/smack.h     |  5 +++++
 security/smack/smack_lsm.c | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index b27eb252e953..50854969a391 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -362,6 +362,11 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 	return cred->security + smack_blob_sizes.lbs_cred;
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
index 459f7d523ca6..3e11be8cce7e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1573,9 +1573,9 @@ static void smack_inode_getsecid(struct inode *inode, u32 *secid)
  */
 static int smack_file_alloc_security(struct file *file)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_file(file);
 
-	file->f_security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
@@ -1815,7 +1815,9 @@ static int smack_mmap_file(struct file *file,
  */
 static void smack_file_set_fowner(struct file *file)
 {
-	file->f_security = smk_of_current();
+	struct smack_known **blob = smack_file(file);
+
+	*blob = smk_of_current();
 }
 
 /**
@@ -1832,6 +1834,7 @@ static void smack_file_set_fowner(struct file *file)
 static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
+	struct smack_known **blob;
 	struct smack_known *skp;
 	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	const struct cred *tcred;
@@ -1845,7 +1848,8 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	file = container_of(fown, struct file, f_owner);
 
 	/* we don't log here as rc can be overriden */
-	skp = file->f_security;
+	blob = smack_file(file);
+	skp = *blob;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
 	rc = smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);
 
-- 
2.14.5


