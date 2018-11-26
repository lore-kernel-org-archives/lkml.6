Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748C3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D83B208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZWxVekW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D83B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeK0KvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:51:16 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:44671
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbeK0KvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276522; bh=Il9GpnbV91+fys2zxOGbpdhryeWPuMQjgXeEO7Bfh2k=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZWxVekW7QEQTPeCM3ZCjhSUGQhDoUnXSC+L0oavrboqnYU8cLzrJ6EE239yTD+w9Dk4cOvwDzUcH8v6JSZ9LUOlsfL50Q9s3PePcuZkcx9hmDu+qWoluXQn6iJUwscOVuxaTBPss6Gi+PAPwZVJNeWgg888zK9gddaVXR1m5FCwAYJSs8jfmXiWa5LeypW/QF0XHkV9/FSd8eD+V2dDCQocpnlDVLfzP6iSs1pE5wSO9Cf+dEG6NW+M+Wg13SXQ7NMqlmXZu2iKPiFYFNMmqhH+HYOjZsT8OVA0xR3HBBRdS0rBBNoh9+ytf/18qpQdLeszwB9mTMCxko5keNX8InA==
X-YMail-OSG: KAZ_tZ8VM1llt0ISCXyAp.AbJ.7sZc.hlfCIXxtKub5HTFXcv0xNt8X96uJVt6d
 _8hFGiIL0qouhoogkuKm_CIk3vfan3edUPPuQKibDI6eiT20VUhMxBtWCAgDcDZWBIZq1vlooQFB
 2trPJH5zrJv71n8mCF49DeJ_RpMnVgDPxPlIWazb5_eK9Gj8T7igaKOp8LBugUINFf2Ogr5IwSz.
 p5TO6k6gNeiXAUJ.2Q_KrzOPsZ7wcbj5UQ8ROqWNsO7viWg1DLYDZw3bWoWD3ek5NtX9m73OdzdE
 IU83BzZy6xA29hOi0J8yJwmpaxEQflywuI3yd1s2XziUnedKjqjvVOfWP8Vj__laofyrWLJ1N0Zr
 vfQy7TqAJ.SIhBovFFxSDRhz2FfovM.Y0sSpIPa4bSTul1Q5l3q0Wwr4eedFeAs1xNMUI0A2VyC1
 KOt24OrZFZRSqYUSv0RRAmkroH7CA0jpX2lyrmRvfdA1g4YD5tccgzSER.ZVHsXgG4vHywi.VEhB
 vUrnR0NvFNakZYv9GJZkIPWWUAtLdA9jIPX1pQX.ekfxZXgAy8FLEDQTbjHrImnif9HxDol1yCzo
 Jb82AFHT17lEMV55lwu3HnF9KGBFSi.tdz3Yh5JsGd7bgDHsiQUUp3GbsOsGmvNFz6iC4PuiysLY
 DERHK0NEqRZouXZhjg8ayDutD2Rh1fUdb7yfaTjQu6SROvdUlx2iImmKqa8qOv.ZGeqQRiQh2lIQ
 F5kvTSR2utJ_BGKTvRpzwRIUZUNH3.4XTtPJg_nBUZq.T5s0M2E4gwQ_GsRp2stdoCAOqu8.rY2n
 x82TAlMbgsqCfPh0WwnT0WR8JKT6Yc.dPG.87yGKcPhJjlqt2JNLSiGXCZuxsI6y2q6hY3tocw7.
 nO_1RaZuSzzhGZrf2UN.fwI.aYbX2SvS2AcPB1HlffG223wyLFzeoostcTW0vCro9E6zMmFsaxxZ
 gGFF_wNXPM_HP.VlnPdn8rYKsXNM2DjUVLx3fRJ4bNk5XJB55M8fd6WxLJuw51kT8pxk2GW9unEv
 tGvZAE8wRxKKt7.cA9244vjNLIj0fdbzpqf3eSx8p1CFgUMTiue9hHOY.eTyqmskFkvyhXL7FbFf
 UaGxvh3TFaDQf9dPdSfm6N9jyzSg85uZX17av52ZgQ7g-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:55:22 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7e67d836b7a9d318158d6e4814839b1d;
          Mon, 26 Nov 2018 23:55:20 +0000 (UTC)
Subject: [PATCH v5 36/38] Smack: Abstract use of ipc security blobs
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
Message-ID: <36cc3a88-0982-2b42-be5d-1944fe954c30@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:55:17 -0800
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

Don't use the ipc->security pointer directly.
Don't use the msg_msg->security pointer directly.
Provide helper functions that provides the security blob pointers.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/smack/smack.h     | 11 +++++++++++
 security/smack/smack_lsm.c | 14 +++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf0abc35ca1c..0adddbeecc62 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -24,6 +24,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/lsm_audit.h>
+#include <linux/msg.h>
 
 /*
  * Use IPv6 port labeling if IPv6 is enabled and secmarks
@@ -373,6 +374,16 @@ static inline struct inode_smack *smack_inode(const struct inode *inode)
 	return inode->i_security + smack_blob_sizes.lbs_inode;
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
index 9ff185af378a..ceda326a6e47 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2918,7 +2918,9 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
  */
 static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
 {
-	return (struct smack_known *)isp->security;
+	struct smack_known **blob = smack_ipc(isp);
+
+	return *blob;
 }
 
 /**
@@ -2929,9 +2931,9 @@ static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
  */
 static int smack_ipc_alloc_security(struct kern_ipc_perm *isp)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_ipc(isp);
 
-	isp->security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
@@ -3243,7 +3245,8 @@ static int smack_msg_queue_msgrcv(struct kern_ipc_perm *isp, struct msg_msg *msg
  */
 static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 	int may = smack_flags_to_may(flag);
 	struct smk_audit_info ad;
 	int rc;
@@ -3264,7 +3267,8 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  */
 static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 
 	*secid = iskp->smk_secid;
 }
-- 
2.14.5


