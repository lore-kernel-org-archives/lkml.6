Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34E8ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA472150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AZb6DY7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA472150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbeITGAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:00:45 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:36059 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbeITGAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537402817; bh=dO1/+wA5zis+nu9FqdfY7SWRB5KrboIptvARcoyPSMM=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=AZb6DY7yY56/FIiqr0hRpdBjqbPubs15ZndaXBB8H5VU4Lz2cwPRQIBfr5c26+omJ1fJiMbltb7UCYYAXdKQWZqKXOU9Iftzaer6p2tpHAJ52lSHTDivqQBbr7loEBVfXnQpW6XTLNG4yJt11TcLU+qdI0r4JFswqRYNWztA9HTlADACfvlJ/+467bxtLHUQJL0RMRxt/HQQGbWI3uS1rbcaD2DladhBBxhnoCIYTfp6crOjmFU/CfuJvmOGKYsjryMVV2HfBu7dnP9l9wLeBMt8bttMv+nh2UzQQtXkPA2Ie0AUtSyFzzozDYWTNGbZO8pkeFhJXSV0dlpfZIRuPQ==
X-YMail-OSG: rEFxVKwVM1l68iYLRP.KU247ZpYCpqOGB3TVFwtx0Hvn_LK8ZEjPxRk2w97h8Cq
 LwQzmqHlPRLDbigySYVUp_sKpdH5z3ySG9yfoMX48ttqIELlGEetOs3_mI34SG2XXOmCgJBzEELM
 RMrTwG8mJNyWq8xWAhj8uljAYl5NazpSwrlK4v4TzrJXWd0gvnH2nAnH27pNoRpOT6brAJHCWqSa
 Glhyo5jggSmEVL7gohgnucCZR_cRo8cwt4JYqY3xGiHG.bh9gnR28H8bvl12hDGUwopw3iA4K5D5
 kiJDL1dpR0pefBY47GNhieC4Xnfqh4YYKvKfsez4L7gWScXTf9hjaOLA9gVKzc4cHpkMdpHDl2wV
 OFF6FL3fpY6Tq6qwocvTcXpYzKhrWJur_w36mgnfKxfKLsHs7Zp0cL0egNmmeiuDkA4dXwgL79Yj
 Phhn86ND_CDt5XjCVOBar.inGL0jteqDZ5v712OrQ7dU6j7eDmaxRz2MFzZQe41zHbxlVmGBQHsS
 hl6ukfnaKw4NLDgWRXNual.qDZju_rTQ9sdQAF3YZELg.1MQgmCcN3Nrc5spOFnoO2CXmZDiDHIw
 FvXn1G4pKIyO455yUPGqGer47.nBgpaS.nninKE17MotacsIotK.OHBCujHmHVKQhhtMkCsvMusA
 oFTZDzJ9TIKkzOXV937T8Ed7x1ajlPxkeEpTO_kmG.ADp_SQqhVxfF87UMbkZYJwubJEtUIE8FHc
 HPNTj7UF5EcpmCwWB.7e_6Cw39P7TzDSvv4ya.OH2zabSuO2bcT6Z8amyRC770E0hLOOP_ZfKV.M
 ieXC071vClVNUJc1KGfvV_gOfMH.TqVbsmSij7AKks84fkkGK1vacc47OCNLm87ilhOdnXv7P345
 OQIaOHvcRySfrqjZrUHmPRHNA7eHTVIqtalhGjyJR19bqnHAbJBxF43blPkxQoYlQ9PK0UCKMQqT
 rQnDnOOEwYmE6ugnknf9qbuk8vq39JDaYgZh.h..lqDeTkjb4Ru32DdUFUb3CMI8TkRJM5onSybm
 cs73IAchreUfzHApGaSiaB.P.C5uRil8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:20:17 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 66b637ae1be03f5963ba7d610a945ce8;
          Thu, 20 Sep 2018 00:20:13 +0000 (UTC)
Subject: [PATCH v3 04/16] SELinux: Remove cred security blob poisoning
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
Message-ID: <de3681aa-3e2e-a3dc-bc1d-9c7edb2f12a6@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:20:10 -0700
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

SELinux: Remove cred security blob poisoning

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


