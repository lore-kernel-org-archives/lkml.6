Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7544EECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FDF2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RfBJSYzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FDF2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392228AbeIVGLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:11:20 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:40911 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391761AbeIVGLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575602; bh=D0y9tAp4PAnLglQyXk//qr5I8tURWoWKeQ4vbNh5qBc=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=RfBJSYzxfJzUQkSNuMy+AQ6Yqv7+bb4GA8ZAEzWdb4IumQP24nHbybzcaBWqR7S7njqQs8IeN4LnR6+GjMRVl7HNQC96+jbwhwv5T3RUIBcoB+xBeZiN8/sBZEHTbZRyIhs3hn5P7TryZKpw2pKyO+Zj+x9PusMfNUfJlR1VqVbkxC/1hmCFTIC+GX/aL9zEvKFioTvzkZdNAFR6Wy6hddYWm8OMCItcb0oItsMrwMqCm33LsHT30BNJescoP2WF86aoJpvWdnKcjF8i8RLOCYhGjcCa45A7vgLd/YuvsQreGeIOFdeQeLQOzN+vKCu9AxDb/Expw2e7t1Ia2Ws38w==
X-YMail-OSG: Qel5dt4VM1k8Dot_WR.4AN6LFlsYE5SM5hOgVveiP2emFOshobHNfX8Mvk8jF1j
 8l6kI8RPC5a.3GpJlHNr7_azhLDc0E0GpmSGsvCch..QwrpEbNpnUP.a6hRN0iteXhcRbgkS_l8p
 l_tuRX1Impqj_iKCN6REl4uKoYpFjCYTBGS.BUn3Sor52b13tXykVUad9GVtvlLhSNogaEa.FKwP
 dZFIyBaxORVYdJdc3AVkTS_hc2SxwyNJVsuih6zmCHfCt_GIQVrnn8e8WiuF.zW8EAdlApfqILIk
 fWKDdDsllkLnC4CU4cJ2ISZ_CxkCiGdPXP5u5uLS8hxu6gYVcWyk3U6BmeFlrkHNGW7aMmrrot2v
 1be.7fF7rY5mKtYJC9eQaszwl.Ig8EGbdQSzcYQp9E6uOGQifxCOASRVDYyzzgUWrRe.dFjL1VtZ
 Re7jS4.NfL4cyIG3kLvYSR3yCMaK2mB08F_AxmJKUGyJ46dUrrsjYpHdG9ZsfZ2bSy9.7AqZxgon
 sR67uBYyAP9XzS4rMKzoMJTzM.h_18lbgNopPQspE7L_squaT._mCkcu1Aur_DO2D5owzqsQ3MQ1
 9b5wmm2y58RvO7uzAewBViyFUO_VBm9ao2M4f1Y7ovc5KbcT_oKsx4vWk21EcxkTpynb9ABtGBjm
 7l6pyNuNqcwtw4z3Hfb9R7DeYqjXNqGBkJuRqCXRDzdXvZ8SLp_6NM8ZHqcatCv_GbKQe0yvx2B.
 ZPGeavmyyCudN7TA7FojNVDfM1KWYUmhGnhK6g_L0xGTqdMQi_5Tb_OSs_WY8PQRw86u3ql4DA96
 OFCIOaV4l_crT3ur2FujHTos4_ITdmL_b1cVhU4W1qPFCCu_UyEZg9nBZXx.DWqIg3.t6G1xwUXF
 t4Dx5Xn9Sj3OmNODtPDlXKWv.M3g7qVRVrreTwbttC70B5gEIlGcSiXuUtuj0e.hVKiv7Ptrd9Se
 zW.vOMCTb58HI97WjvHDdK_8AwaeDKVJWdCmwH2UPauaKVCKxsX0QvflkDloVXHQa7lzAwb1uON3
 5NeygHA6ezspVHcfH9fZ3ABRIvP9pHVg.zN8duNfrNQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:20:02 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 73f2d5a0b4ab1f0579e443cc260bef4f;
          Sat, 22 Sep 2018 00:20:00 +0000 (UTC)
Subject: [PATCH v4 17/19] Smack: Abstract use of ipc security blobs
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
Message-ID: <f8d020ad-2e50-d541-3187-81f63557f667@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:19:54 -0700
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

Don't use the ipc->security pointer directly.
Don't use the msg_msg->security pointer directly.
Provide helper functions that provides the security blob pointers.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h     | 11 +++++++++++
 security/smack/smack_lsm.c | 14 +++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index add19b7efc96..52cea142fcf6 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -24,6 +24,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/lsm_audit.h>
+#include <linux/msg.h>
 
 /*
  * Use IPv6 port labeling if IPv6 is enabled and secmarks
@@ -371,6 +372,16 @@ static inline struct inode_smack *smack_inode(const struct inode *inode)
 	return inode->i_security;
 }
 
+static inline struct smack_known **smack_msg_msg(const struct msg_msg *msg)
+{
+	return (struct smack_known **)&msg->security;
+}
+
+static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
+{
+	return (struct smack_known **)&ipc->security;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6617abb51732..4afc8899f83f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2905,7 +2905,9 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
  */
 static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
 {
-	return (struct smack_known *)isp->security;
+	struct smack_known **blob = smack_ipc(isp);
+
+	return *blob;
 }
 
 /**
@@ -2916,9 +2918,9 @@ static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
  */
 static int smack_ipc_alloc_security(struct kern_ipc_perm *isp)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_ipc(isp);
 
-	isp->security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
@@ -3230,7 +3232,8 @@ static int smack_msg_queue_msgrcv(struct kern_ipc_perm *isp, struct msg_msg *msg
  */
 static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 	int may = smack_flags_to_may(flag);
 	struct smk_audit_info ad;
 	int rc;
@@ -3251,7 +3254,8 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  */
 static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 
 	*secid = iskp->smk_secid;
 }
-- 
2.17.1


