Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37161C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD8D21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sZp+05X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD8D21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391747AbeIVGIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:08:50 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:34988 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391716AbeIVGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575453; bh=fgnGW7YBVBAQItw8fK/1P4rs3EmF4/uKZk7uW14uDgU=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=sZp+05X/LVMSqts2ZPDB+I1rDwHd9zVDHItscHIPtI8GCJMslmbTM+IlN0p/YDOvf3hlhfpPBPTx0sNghsCdccFggJr2m+gVOQlT70J7wtaAKCSQV3Ki94qVafOlJgx9p8mao8GgNDxq7mJlRppT6RJ5vxNFQLLB9lW8lTqQd1IwvFmz3TM8HBOk0zNhiMq09CIqXFZppeSciEVYXNVW92nYUVteEOuFJTL7FfHqxkgoKjwgA3ue33T6f4NHTE3DNZ+BFd2l8yZncPeCVm3PbsXq9KWm6SjftWqSC4rr3GhbB5ERhOlgVq7i6AmKFAv1FQszmlXpSPCTNHe6UIq3xA==
X-YMail-OSG: eS2hAUoVM1mavthSOPBKXr164KY3Fc_SMuVv3QP91Jhb4MBkYvZM8rl1ne1mnWx
 d0Fo55Jcri5Jh_v553qUGYR8q6yK3HFHtPzfIiqvoYuSUGyorJjkXJTKxf7Hjz8ifTlPhqBwkPWt
 oD.0763lQ2qwrBGGIsGzJv7wgGrUDD18U3PV9ahX9d0bfr3Z9V1aP0UGv2Cn5ZBgTDXZjPfTQV1Z
 _PzImruRJoiVJCvb3Rd2QpAbZNPWDj30p9blG3VvBGcNLV9l8LrG9k1uQyEfZRu.3RsB2HM0M3YA
 qI4mSlVslT3Q9wxeYNjGtM_SMuUPnwKcmOcCfdUM66WvnDe2w8x.WC9QXg6brI8yP7w8JiB5sda7
 GbGzlSSe_D03aIrOPENvA_nqEZCAcXnsuA0p.nm_iyYm9IFQw3vxRl3jQyE_OqsQs1s.3palSXtH
 9JoTxcaDek9NQJMVhBfarjtrF5pN7rMSrjzYyBIP6iXnbUVKinEAfUQ7mNrOvgMUGYe8sYmkiXA6
 S3.G85F65D4lfuZ3_WXwudA64kuzQWxgYPrgjQN4n1qW86BnlR_7nxDWus_jDyqhQnE6q_c.PrJP
 8EHBJ.GxHSAhNn1o77q1.dyfCFcIt.vWL9OSyafh9pO.oJ2WJXEckc.M9315JwyWPl8fsljJhWQb
 ghCl9Zwpx6yTdQhHCarLpnZfLllzQo_C8GLleg.z_t1lZaJHA9m05DMO3WRrszJdtQ1nlmazYRH8
 5YL9INi0HHPKH0LvyCCv74fMzJKt4nLbXmvOvDlQ494r9ygmdipbk0gY_tVEs8E9zIJgo3A6eb60
 XXkUu.013I81MIFmXaUjofAi6EGVYCUUnAy2Edy1noE.CUTFMMCRun3JrkTI8aWmxCPGrJsUkH.o
 5iy0h3SmRuH1UemdriA34qB8iZi8A9rAlY4m8jNknSOTLSanK6F7DX2wQPeBEtQ7_6w8kldhKNaQ
 _pOrLJSvmYVMof73c0qhRWRLbQWHneJiqzrvdvtXcw5OOX3q6sJZ_cvWGMiVjzivwMy_a8Swwurt
 fyqRQwbgucWQK0FeZjFXbV3sYoVK8LNI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:17:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e31236e55fb46ae50941c78f1aaaf6e2;
          Sat, 22 Sep 2018 00:17:30 +0000 (UTC)
Subject: [PATCH v4 04/19] SELinux: Remove cred security blob poisoning
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
Message-ID: <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:17:25 -0700
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

The SELinux specific credential poisioning only makes sense
if SELinux is managing the credentials. As the intent of this
patch set is to move the blob management out of the modules
and into the infrastructure, the SELinux specific code has
to go. The poisioning could be introduced into the infrastructure
at some later date.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/cred.c            | 13 -------------
 security/selinux/hooks.c |  6 ------
 2 files changed, 19 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index ecf03657e71c..fa2061ee4955 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
 {
 	if (cred->magic != CRED_MAGIC)
 		return true;
-#ifdef CONFIG_SECURITY_SELINUX
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	if (selinux_is_enabled() && cred->security) {
-		if ((unsigned long) cred->security < PAGE_SIZE)
-			return true;
-		if ((*(u32 *)cred->security & 0xffffff00) ==
-		    (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
-			return true;
-	}
-#endif
 	return false;
 }
 EXPORT_SYMBOL(creds_are_invalid);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9d6cdd21acb6..80614ca25a2b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3920,12 +3920,6 @@ static void selinux_cred_free(struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
-	cred->security = (void *) 0x7UL;
 	kfree(tsec);
 }
 
-- 
2.17.1


