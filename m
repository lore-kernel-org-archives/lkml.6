Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156085-2-12293833821262846329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156084; b=Y192aJw1YKqf9ljtvZs1srDGpVV7k0nDo/v6yjioD/UUHApHvE
    9JGf0U1cPNB7o6v33QFV3UIP531qX+FbksKVapCgY4s/aCYYLmaJgf/XAudP9FEp
    trx7108bX33QzmrglgZlHnOIgsD6CIbwl3LHePGN1IKOnKxH1hfsm96bROlUwNhV
    trwve0dkGEykFGMiMAnDWgOBAKQL+Yau+vrqxSj1B/x/h5dTh/rjBQMUNPwTWVa9
    2DzjaaZxlbFZEwXcYQjdRP5Dlvd7GiQnte8V72a+NtGYKEwZQ6a9QfyJWERQEJ3J
    MMWi15FoY6cTxTpsk5YHs4TEcx0Ydz5A9OVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156084; bh=v2VpXqipmljw9ImwWyI/524zC+Dfoc
    joi0lBhgs5cV8=; b=lNX4xyLQt5ZN2FCH4cQsTA9qtKqm8vb5Rs9UM7yzXokPM1
    xAbfndri/W8Ydr0ey1ji0YKitInuJqaoixkz6N6D5+8zU89L0q0Vk1aEgObLtaSc
    5ZVncjHiVkusaXC/J4ukn3LOPSyigiuUh5D8mcD5Bb+HsFDJwbmoQcDdfT8yhRMI
    SXdAfhYRbuAOcmKdHbtMMCxubNVhXav7ARIEosxLYF6ATo3PpOC601uiE0x0psfi
    9Y03WAN8y6iwqb1LeTObV5tDv4XfJPwpcblPXO8sg4lPwn8gFg75yZ3UmhqEyL0U
    w459rTg1xA9x5bk8PJTi+S3EZjQGv/At3zhVtz2Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=GXXWLr8n x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=GXXWLr8n x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM/NDn4rMfiLVEA887eiedOVl/1WxKKuBZPcIE3ztyfeKoYHQHDCKo3cOxEfW++JrM6U0X6BR458QEBxEmRm4guBnsNPTP8vhncKuKf7aa4ZUjIEPuMj
    h2ZY2sgB3SgDN5KfZ4iwOzjPI3EJLRRy+VE4hwP4+FtsKZl5P0IWYzDgp3Wg3tZks6Y8/2YK0zufPa8UAN3hJHZzNIU3MlwXnKjF9Jj8WAhkhxi/VDq7CafJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=ZorGynhXn63rTCUqaxEA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030589AbeEXKBV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030878AbeEXKBR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 054/161] s390: correct nospec auto detection init order
Date: Thu, 24 May 2018 11:37:59 +0200
Message-Id: <20180524093024.923002276@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 6a3d1e81a434fc311f224b8be77258bafc18ccc6 ]

With CONFIG_EXPOLINE_AUTO=y the call of spectre_v2_auto_early() via
early_initcall is done *after* the early_param functions. This
overwrites any settings done with the nobp/no_spectre_v2/spectre_v2
parameters. The code patching for the kernel is done after the
evaluation of the early parameters but before the early_initcall
is done. The end result is a kernel image that is patched correctly
but the kernel modules are not.

Make sure that the nospec auto detection function is called before the
early parameters are evaluated and before the code patching is done.

Fixes: 6e179d64126b ("s390: add automatic detection of the spectre defense")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/nospec-branch.h |    1 +
 arch/s390/kernel/nospec-branch.c      |    8 ++------
 arch/s390/kernel/setup.c              |    3 +++
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/s390/include/asm/nospec-branch.h
+++ b/arch/s390/include/asm/nospec-branch.h
@@ -9,6 +9,7 @@
 extern int nospec_disable;
 
 void nospec_init_branches(void);
+void nospec_auto_detect(void);
 void nospec_revert(s32 *start, s32 *end);
 
 #endif /* __ASSEMBLY__ */
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -72,7 +72,7 @@ static int __init nospectre_v2_setup_ear
 }
 early_param("nospectre_v2", nospectre_v2_setup_early);
 
-static int __init spectre_v2_auto_early(void)
+void __init nospec_auto_detect(void)
 {
 	if (IS_ENABLED(CC_USING_EXPOLINE)) {
 		/*
@@ -87,11 +87,7 @@ static int __init spectre_v2_auto_early(
 	 * nobp setting decides what is done, this depends on the
 	 * CONFIG_KERNEL_NP option and the nobp/nospec parameters.
 	 */
-	return 0;
 }
-#ifdef CONFIG_EXPOLINE_AUTO
-early_initcall(spectre_v2_auto_early);
-#endif
 
 static int __init spectre_v2_setup_early(char *str)
 {
@@ -102,7 +98,7 @@ static int __init spectre_v2_setup_early
 	if (str && !strncmp(str, "off", 3))
 		nospec_disable = 1;
 	if (str && !strncmp(str, "auto", 4))
-		spectre_v2_auto_early();
+		nospec_auto_detect();
 	return 0;
 }
 early_param("spectre_v2", spectre_v2_setup_early);
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -893,6 +893,9 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
+	if (IS_ENABLED(CONFIG_EXPOLINE_AUTO))
+		nospec_auto_detect();
+
 	parse_early_param();
 #ifdef CONFIG_CRASH_DUMP
 	/* Deactivate elfcorehdr= kernel parameter */
