Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840313-2-9074049781552006753
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840312; b=mcn2UPBvAlUxQQUq588m3B9bFdIOOqVhXx2VMhvkooiv49jH5T
    NGtr6gqdic3Ch6pINZnI4Fm0YLXWp6pS5PXHgcjKF7JUt/laEMJ6bh+bHI7mjQVf
    jq+TVlGparSQNRBWiPwCKB1rYM50RkyIYBkt4zJS7Y3xPog0ASod6arnV6x8MY4Z
    llqrNINgn6A3owTKXaIyn9k/PNbZ4W2dWqig3FGZRPksolKH+l0pSQJD7nELgW3m
    HHz+2h6sqpPy+ahULk+unn3hKBJlykYfKRMvLQKfOX+yzpBgmfzueuikksxe7a3T
    eBM9IwFdLt91eQyKAVDj9HV56S6t7mlFVNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840312; bh=GsD5YlgNHyJRn24PVCCx9dThXWhr1a
    Y8HR8NdsmLwKw=; b=LcYTLGsmG21J5czWE8Rp9IvKgRg1hRXelf9xBUVTrQfETp
    JV0KoKfredUy8Gu33u9R++Jzq2Cz0iix2SGi45pto0MLxp/2CsRSTcJxo5WgbuL4
    MFllvowz7EA7pQ7GVb7XCNXLWFnbtPUhgTxJD4zP4hXdnfY70HEHbb+OeSo5kbep
    4iqL+BqpBR78F9A3OKnBrDs9FD5oFoRSC5ysFxwG3T/EsjH8NhsuVxX6tuKA6B5F
    v2xNAxwek22ArEtlHvdTlyGFwKgVXVQe5Ffm4DYaEoT3nDJySGwY29EDLogPjst1
    arf8rnAyOKQL9apLOyHSOQcR4ptzlM9HTsuWXT3w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKcpSTD3bemkqNhjPo92hboooQ9WmAugim1rFKsIfOjIUaowkUGxDHSbLOVWiT9TUskYxoJ7+/NVboJTWpHLsSgpzEgEwaIjeKyG0XjVB20qtKxDXNpS
    GQojPFZjA/oSfHnZjTCJYjbZZqBnn0M+PkSM3i1uAJUbPk1OcEtox7Xn2UpXLesNqKKortSur2bQjCrjDW/eOXmR0gf2PDQDaMcNKGRF4CS+hbcbm95mpUTH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=ZorGynhXn63rTCUqaxEA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934473AbeD0Oo6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934457AbeD0OIR (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AE921864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 59/80] s390: correct nospec auto detection init order
Date: Fri, 27 Apr 2018 15:58:52 +0200
Message-Id: <20180427135735.948729998@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -73,7 +73,7 @@ static int __init nospectre_v2_setup_ear
 }
 early_param("nospectre_v2", nospectre_v2_setup_early);
 
-static int __init spectre_v2_auto_early(void)
+void __init nospec_auto_detect(void)
 {
 	if (IS_ENABLED(CC_USING_EXPOLINE)) {
 		/*
@@ -88,11 +88,7 @@ static int __init spectre_v2_auto_early(
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
@@ -103,7 +99,7 @@ static int __init spectre_v2_setup_early
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
@@ -897,6 +897,9 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
+	if (IS_ENABLED(CONFIG_EXPOLINE_AUTO))
+		nospec_auto_detect();
+
 	parse_early_param();
 #ifdef CONFIG_CRASH_DUMP
 	/* Deactivate elfcorehdr= kernel parameter */
