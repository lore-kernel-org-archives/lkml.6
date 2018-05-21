Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938049-2-16991310150243643631
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938048; b=jleWb+RREvwzpcJ0NF+IPI/tnbqGd8ffzxnM4USigfYgVVWLTq
    d4c8C6a0cWJfOFA275RFsQvgGBU2w+lpzWnipX5OfLtwrnIyrrFvzIy5KjGQJ3hH
    7CLDABz5ht8uxuXyUc4WJLBJM5LhJ+p5X2rv5hMtGfDeHx6tA7y2OFJwc1fDmb5m
    fZsEjCKbp2kyt1g7cNvxVIfi9khuJOuWcenwpCB0ExbicilXOQY9CoVUur9USmgh
    6JLQumzYpFkTN/daN1K0SoauhMDINsl+mLWIwLN2p1+me8ScQ5Ti051XrWFI74sO
    xNIp6BHwYyzZUR9nkYdT8eVl1Z1+v+6KZbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938048; bh=pfcG+GE5lkNzga8JJxF5yG5EnIhFGB
    bp3ai6106Ts0Y=; b=eMfrp8xoD67QPLjXomasNDu7/eSn29f4PwlJaJ96J4OApk
    TN7ZwPsEAYd7RH5Sdt9MAsRSdgdy/R0HaGlqKgyhMmAPLNiw4/Nirf+VOy0eupFB
    X+XRk5O/3OuqTtgtqeIixQxifB/AwAXDuA+5yAjpw7RVM+NwFT3YE5o4ZmxZdGxd
    PaEjgiOANvUHaqirMyqcSUj9aVTIYc3M+Q0W6IROwHxp4200ynAK5Ckk9uiWdDnb
    LfClqYMrK/fLPyCmPwzG8GG34ZW8wkzmgjgc0rmOOltDFcXv1F2VfVinsG+9FuuY
    U2s8T1wsAS8WcMP00pYXqksDCKtHliez6cmM3dNw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=KKXQVIGc x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=KKXQVIGc x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKHZDVXd9S/w/KrhoQzRriX+dGMR0H0skixMp/SXGg+opO0QY9eT1//rkVl5zIuK2ujqPWMbDLk57mOtosZQeNQFqN74A26hqRmL2MuC6rkHuU2xBJvN
    aY3wFAgjNtVNrV65irfI3kg/sffVVtHLjVMRXmE8jKyT6ppSc/0KH+Ft6qFfJ+hSD14q0fe7mfxfRiBdpO0i4Ik0h7h86pvG19hDEabhxtmNo4VpEMEN2DIL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=JuBd0jeNRUqeSgXHdO0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932726AbeEUV1S (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932239AbeEUV1P (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:27:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.16 105/110] x86/bugs: Remove x86_spec_ctrl_set()
Date: Mon, 21 May 2018 23:12:42 +0200
Message-Id: <20180521210514.888843533@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 4b59bdb569453a60b752b274ca61f009e37f4dae upstream

x86_spec_ctrl_set() is only used in bugs.c and the extra mask checks there
provide no real value as both call sites can just write x86_spec_ctrl_base
to MSR_SPEC_CTRL. x86_spec_ctrl_base is valid and does not need any extra
masking or checking.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    2 --
 arch/x86/kernel/cpu/bugs.c           |   13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -217,8 +217,6 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
-extern void x86_spec_ctrl_set(u64);
-
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -133,15 +133,6 @@ static const char *spectre_v2_strings[]
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
-void x86_spec_ctrl_set(u64 val)
-{
-	if (val & x86_spec_ctrl_mask)
-		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
-	else
-		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
-
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
@@ -503,7 +494,7 @@ static enum ssb_mitigation __init __ssb_
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask &= ~SPEC_CTRL_SSBD;
-			x86_spec_ctrl_set(SPEC_CTRL_SSBD);
+			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			break;
 		case X86_VENDOR_AMD:
 			x86_amd_ssb_disable();
@@ -615,7 +606,7 @@ int arch_prctl_spec_ctrl_get(struct task
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
 		x86_amd_ssb_disable();
