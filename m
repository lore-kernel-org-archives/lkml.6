Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840374-2-3520754744139662697
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840370; b=Vo8l+LsjESiovjRvDZvyEi/WcoL4NoUWJ73jqMH2s8P0tWFlRl
    BIuXVxD3ydw9dD/fY4V0W7dv9VqK3yPaXFT9q9m2wU3Z8g/0FJX2Ph/SA+/TJ8pu
    R//vpGfG5zgUrJjefBsbUhhM6aQ6G1wVzMxEigOYMlgG5SMHhxMC99/7qkQRGUv1
    BnpvOkF3ivrV78BD2DIzBUtXByulUb9nV9xcuE4gAyZIzK7rbZHGqC6KYiLh4imL
    +r0sfYBdkwcASuU3Ulc9wkhSisFQ9UG3CLnMZHXD0xjD7jazueFlngTdvJZq11Su
    tf4R8X9EncxpzbevChVA6RLbF/Ghjzr7ET+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840370; bh=f0i/ai78pBVtoTkR5KnCQstjWc1tUt
    XZbHuJ6b8zCDQ=; b=bRYX2os0AqMxYezBEhOporjIn1mtnLgITuJOkzdeH2Vu2A
    ncSRmKBCgokL7VsA8GvSoQZiEWfXTHR6CIV1VUns3epeWkDCfBXcCDR3dIxZv8l1
    iHZlsh/IZ4i3vSaWgHcUBgXjyXu3FhaUtDWCIqeZOkGAYkzA/xiIjEHtu5ZD4cTy
    JEbsVm+SV/Gkugr9hlvDLHVUtQ7Q009rh9SchgdQ0ADzsZhh78Yxfk/B3WElJRL2
    bMXfeRKXb75WrH5SmdBfaF7eGsb+gomZnwVuIfRc9vK5tOqjfn9vEF2UczgRxS0d
    bS2BkpAoe6kUPebA7cPkhJ4zi8kxbhqfwF7pdFXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfI7NiFUxlOo8oNPr9XUn7KZDkFOEqyPmD8NaDYSaUrzgEjSZHQvo0D3bqXph/XfsYvIW/aC2LDuNZy4vyyT5+uvGvxiez0gWyt6uJm8FdyyAGAY718ip
    BbqxmcXM8vzublA/MINj6T3cuiVlvyCFO7k8s6aH7+PJkU3Irmg00nW9VxhjdxoXyoEr0uBy9rO116GSf/qoIYcG2q0szwj6ucX4K7bcWUzLpnDEr+Nmu73R
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=iJqRFIza-8VYWujlYPgA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934435AbeD0OIK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934116AbeD0OIJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDEE218C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 56/80] s390: add automatic detection of the spectre defense
Date: Fri, 27 Apr 2018 15:58:49 +0200
Message-Id: <20180427135735.788426777@linuxfoundation.org>
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


[ Upstream commit 6e179d64126b909f0b288fa63cdbf07c531e9b1d ]

Automatically decide between nobp vs. expolines if the spectre_v2=auto
kernel parameter is specified or CONFIG_EXPOLINE_AUTO=y is set.

The decision made at boot time due to CONFIG_EXPOLINE_AUTO=y being set
can be overruled with the nobp, nospec and spectre_v2 kernel parameters.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig                     |    2 -
 arch/s390/Makefile                    |    2 -
 arch/s390/include/asm/nospec-branch.h |    6 +--
 arch/s390/kernel/alternative.c        |    1 
 arch/s390/kernel/module.c             |   11 ++---
 arch/s390/kernel/nospec-branch.c      |   68 +++++++++++++++++++++-------------
 6 files changed, 52 insertions(+), 38 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -575,7 +575,7 @@ choice
 config EXPOLINE_OFF
 	bool "spectre_v2=off"
 
-config EXPOLINE_MEDIUM
+config EXPOLINE_AUTO
 	bool "spectre_v2=auto"
 
 config EXPOLINE_FULL
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -87,7 +87,7 @@ ifdef CONFIG_EXPOLINE
     CC_FLAGS_EXPOLINE += -mfunction-return=thunk
     CC_FLAGS_EXPOLINE += -mindirect-branch-table
     export CC_FLAGS_EXPOLINE
-    cflags-y += $(CC_FLAGS_EXPOLINE)
+    cflags-y += $(CC_FLAGS_EXPOLINE) -DCC_USING_EXPOLINE
   endif
 endif
 
--- a/arch/s390/include/asm/nospec-branch.h
+++ b/arch/s390/include/asm/nospec-branch.h
@@ -6,12 +6,10 @@
 
 #include <linux/types.h>
 
-extern int nospec_call_disable;
-extern int nospec_return_disable;
+extern int nospec_disable;
 
 void nospec_init_branches(void);
-void nospec_call_revert(s32 *start, s32 *end);
-void nospec_return_revert(s32 *start, s32 *end);
+void nospec_revert(s32 *start, s32 *end);
 
 #endif /* __ASSEMBLY__ */
 
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -1,6 +1,7 @@
 #include <linux/module.h>
 #include <asm/alternative.h>
 #include <asm/facility.h>
+#include <asm/nospec-branch.h>
 
 #define MAX_PATCH_LEN (255 - 1)
 
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -172,7 +172,7 @@ int module_frob_arch_sections(Elf_Ehdr *
 	me->core_layout.size += me->arch.got_size;
 	me->arch.plt_offset = me->core_layout.size;
 	if (me->arch.plt_size) {
-		if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_call_disable)
+		if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_disable)
 			me->arch.plt_size += PLT_ENTRY_SIZE;
 		me->core_layout.size += me->arch.plt_size;
 	}
@@ -331,8 +331,7 @@ static int apply_rela(Elf_Rela *rela, El
 				info->plt_offset;
 			ip[0] = 0x0d10e310;	/* basr 1,0  */
 			ip[1] = 0x100a0004;	/* lg	1,10(1) */
-			if (IS_ENABLED(CONFIG_EXPOLINE) &&
-			    !nospec_call_disable) {
+			if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_disable) {
 				unsigned int *ij;
 				ij = me->core_layout.base +
 					me->arch.plt_offset +
@@ -453,7 +452,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	void *aseg;
 
 	if (IS_ENABLED(CONFIG_EXPOLINE) &&
-	    !nospec_call_disable && me->arch.plt_size) {
+	    !nospec_disable && me->arch.plt_size) {
 		unsigned int *ij;
 
 		ij = me->core_layout.base + me->arch.plt_offset +
@@ -480,11 +479,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
 		    (!strcmp(".nospec_call_table", secname)))
-			nospec_call_revert(aseg, aseg + s->sh_size);
+			nospec_revert(aseg, aseg + s->sh_size);
 
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
 		    (!strcmp(".nospec_return_table", secname)))
-			nospec_return_revert(aseg, aseg + s->sh_size);
+			nospec_revert(aseg, aseg + s->sh_size);
 	}
 
 	jump_label_apply_nops(me);
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -11,10 +11,17 @@ static int __init nobp_setup_early(char
 	rc = kstrtobool(str, &enabled);
 	if (rc)
 		return rc;
-	if (enabled && test_facility(82))
+	if (enabled && test_facility(82)) {
+		/*
+		 * The user explicitely requested nobp=1, enable it and
+		 * disable the expoline support.
+		 */
 		__set_facility(82, S390_lowcore.alt_stfle_fac_list);
-	else
+		if (IS_ENABLED(CONFIG_EXPOLINE))
+			nospec_disable = 1;
+	} else {
 		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	}
 	return 0;
 }
 early_param("nobp", nobp_setup_early);
@@ -28,31 +35,46 @@ early_param("nospec", nospec_setup_early
 
 #ifdef CONFIG_EXPOLINE
 
-int nospec_call_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
-int nospec_return_disable = !IS_ENABLED(CONFIG_EXPOLINE_FULL);
+int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
 
 static int __init nospectre_v2_setup_early(char *str)
 {
-	nospec_call_disable = 1;
-	nospec_return_disable = 1;
+	nospec_disable = 1;
 	return 0;
 }
 early_param("nospectre_v2", nospectre_v2_setup_early);
 
+static int __init spectre_v2_auto_early(void)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE)) {
+		/*
+		 * The kernel has been compiled with expolines.
+		 * Keep expolines enabled and disable nobp.
+		 */
+		nospec_disable = 0;
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	}
+	/*
+	 * If the kernel has not been compiled with expolines the
+	 * nobp setting decides what is done, this depends on the
+	 * CONFIG_KERNEL_NP option and the nobp/nospec parameters.
+	 */
+	return 0;
+}
+#ifdef CONFIG_EXPOLINE_AUTO
+early_initcall(spectre_v2_auto_early);
+#endif
+
 static int __init spectre_v2_setup_early(char *str)
 {
 	if (str && !strncmp(str, "on", 2)) {
-		nospec_call_disable = 0;
-		nospec_return_disable = 0;
-	}
-	if (str && !strncmp(str, "off", 3)) {
-		nospec_call_disable = 1;
-		nospec_return_disable = 1;
-	}
-	if (str && !strncmp(str, "auto", 4)) {
-		nospec_call_disable = 0;
-		nospec_return_disable = 1;
+		nospec_disable = 0;
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
 	}
+	if (str && !strncmp(str, "off", 3))
+		nospec_disable = 1;
+	if (str && !strncmp(str, "auto", 4))
+		spectre_v2_auto_early();
 	return 0;
 }
 early_param("spectre_v2", spectre_v2_setup_early);
@@ -105,15 +127,9 @@ static void __init_or_module __nospec_re
 	}
 }
 
-void __init_or_module nospec_call_revert(s32 *start, s32 *end)
-{
-	if (nospec_call_disable)
-		__nospec_revert(start, end);
-}
-
-void __init_or_module nospec_return_revert(s32 *start, s32 *end)
+void __init_or_module nospec_revert(s32 *start, s32 *end)
 {
-	if (nospec_return_disable)
+	if (nospec_disable)
 		__nospec_revert(start, end);
 }
 
@@ -121,8 +137,8 @@ extern s32 __nospec_call_start[], __nosp
 extern s32 __nospec_return_start[], __nospec_return_end[];
 void __init nospec_init_branches(void)
 {
-	nospec_call_revert(__nospec_call_start, __nospec_call_end);
-	nospec_return_revert(__nospec_return_start, __nospec_return_end);
+	nospec_revert(__nospec_call_start, __nospec_call_end);
+	nospec_revert(__nospec_return_start, __nospec_return_end);
 }
 
 #endif /* CONFIG_EXPOLINE */
