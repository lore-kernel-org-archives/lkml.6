Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6637C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AC42082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OhPKPqKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AC42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeK0KkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:40:11 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:43739
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbeK0KkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275860; bh=yzS41n1rCVRHChOBSSjNfES4FV7tKjQHrZu9+D9erQU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=OhPKPqKyYgBsuAWX9RQsB0x9lSngT5tTyMx6j6bRU5yPG2GCt9sbbR+mn0bngaFsezZ7lkzVsU2EgtSj8PyWFO/+xpfCztFSRSkONgzmz3FsE+Azk/8XNKE/gRfngZIfg036JHNJm7b4inhY2+Ds+89SCCuDcM/fqoduZRnK8gk9UhYe6UnoP24it4YsU3SVYyRktBbzN8ZyiUs6GkFMVo39PxeU8KMu/lADqLoFjaGu9S1ieAi03HLxmuPT7rmP+ehJfX4oVwE3H7brwuga1zDCuQiHIXVCsQEJxgqp35GZaQj3cMtD1YSOHkdWtQUrYf6AMTVjiRiWlgl9xSx1tw==
X-YMail-OSG: rcQMkEoVM1kK8eF0F0mhvNFVxw2ZBcOoRbTsOysxC6LJLj7uCaRHVQ0_EJnNKkG
 jjm3neZGIhjTEnVXzQNQ6t6jrNGGRmgmOUeh2.4cu48MLBOeIgjSNyzhAcRUfTBQqIVWfI.t2Alr
 923pnbDSOKl.zu3FRRyKl8j2VJeh57lnX2vV.nbPi6nt1AVZNJMVLcpf5cwIZtVE.l9zLQNgNrNx
 xoDErRlgh2zZCigT4jvTKNFb81Q8WR_cTKX2eAvF.yUNpAaCvbi9bzjisRqWHSCG_3PVDKUl3Yo4
 xtgpJtUyEw.iSGT.qBGt4IMi2WbOeXP6OApDJGYJrHopTR9y.KpUN3.SiZthGtO0CZYzVkeXr3PC
 1w_leOrgKWGWCrPNgyUq74z7BaWNkmNGWG2yA1NGozmWP5u2M1Dv7jo7oDiN_H2_BaQoKJZi7Umw
 E8it6EP95U1Mg7VBL2e588z4mMwtERtPIK1U791jpfSicgsNt3OMqQNewVM9KAtf5kiMF2i93J_x
 .gUw2ctN.wY6ksPBxUO_rJnZuhmSkQCWsLbCEX3Z._OLRMO95UPckqO2VBgKHg.SUb6qYB67yiyL
 HihUznKLMtemYG8uksLl.G_NdIkIrVI3Oatlot1SU3Y57XyqdE.jJeO_08qEMUl39RDYmGZ0F5vJ
 h78Wxc8nNgXmzsCeyDDQCad0qFtDSTg7RjgS_rJmO8jrR7ULDjDG9tbKm90Xv5AXHZp5g_ufs6CZ
 GuN3r6RmCT_IOOMwYnKvEkEhO0MnAhSb9CconIi2JnCSZYqgFmlLd2DNkcoILZBYzhQm4PsbItL2
 I4aqNLRrxfa41UdYTS3QQs_d06tR14a7DPXUCWqD1PF16mcrT1G5RgnSJQ4PWqm5OdMDkZ9p2mv4
 PLqaoLhVPnL.FpGlXsVKL58s_pkWXXslDpWPq9IxpRDdm9JxayA2dh5XRUVAv2jSzV4gJ1p8Qv0Z
 rScnTJXPYpHmhk8Iz7LmJpBdpbRAaFi6QVP2.ewfVgNyQBUQZfVnqpXUQPcvnEcffwDXOoGyqru1
 Ncz3NbgkGkSGBbWopCJwnJzgCxgzZES6ERx9IUzr6qGHsIJsoRnM7jq16wdH823i5aCn99cEOyDv
 Ye8YB9tjC5ufaw9uaFI5xqMlN2ew0W8dslwEfpw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:44:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 20db7ce71dffaa24efe91d4689b48987;
          Mon, 26 Nov 2018 23:44:19 +0000 (UTC)
Subject: [PATCH v5 23/38] SELinux: Remove cred security blob poisoning
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
Message-ID: <80666d37-ea25-1b25-5108-426ebbc384ce@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:44:17 -0800
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

The SELinux specific credential poisioning only makes sense
if SELinux is managing the credentials. As the intent of this
patch set is to move the blob management out of the modules
and into the infrastructure, the SELinux specific code has
to go. The poisioning could be introduced into the infrastructure
at some later date.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
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
index 24b6b459fa2a..41b230d459a6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3922,12 +3922,6 @@ static void selinux_cred_free(struct cred *cred)
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
2.14.5


