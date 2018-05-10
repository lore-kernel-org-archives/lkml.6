Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1831883-1525939649-2-1671732765493030981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525939648; b=kcC0Mqa5vOkvVPMTBhKPiyIBLlXlB5MLyEfLx38D8g3Cx4wNEO
    cpCLI3KCzyjrtHFQhc/E3YlnF900YraCT6syZaj92bI4DhIO9kH2F0LtXoy5h9P/
    fX4rCnbSAPP/dI62CsFy+0UQv6T6+DDO3XcMLBiPfJGvbfizaKOblezRu60uNQsi
    77CLBNPNuuVXQU4SdGNdmQEeKO3g/TSyHSn67pIioRM+jT0cJiyn9VhgxLqRuRdT
    YsfnR33FKrjcEK4elyqfpoxJRex8nVjkLw3i14Sj/6JynV2Qw/krlCDYDcta6xiF
    Q6l7/+rtB5hkbgIyA6m1Be7ATx0pdvD5ndrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525939648; bh=
    BuX0HjTiVjxx5ZCdLGrHcS/M7K4+1JhFnT9ZhbOQGcQ=; b=R4PFrMNgg4sO/hyA
    JCb7iM0yK1jf/D4BIvdQkcH7pcFWhDX0IyfWMmOiV5rwFxhZbZ/dEVewX50SX072
    PtO/RJAASWnmrEtOgxbWyPYzoMcuhVrcf7mWegsnKavMb3z+KFcgRznWwPXyTZrU
    4feyDlCi/Itqvd5p6jQcaTixE0wDYkKBdVKTsto82um10BDghpMqCkmhkNG/A/ga
    ySsOXx2HMdVaecdhcm2CWHrkxYJBQQgbVXhB3jL+N8j520u47hrfoGvyS+K0ZsjY
    FtKjUJGhysx8jwkci2aqTN9/fxfgB3mw1NycIT8Yw83Jvi1ZCi5sF/tpQM5hIK09
    QgFYuQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB3jSemo/dm2Ic1MM2efhtolYcVGBl3dmukmWdOsb+Yrz3FOyhlgGi+uavYfeuXGJeRQ0Fd0hrSl6es5GPQWeEk8hlBK9UAmYQuy8nhangK93oj++QeW
    aEW9G4+gtkB4T7pPt0moYZHCz+3TkjYDt2Dd7dPQV4Bc8SJW+H61nEugufsZSGqE+RKTa+fMjglRPEGlA/DtTRmhzuZQxEG88LlUA2vF+t06XiqJS9RyiqIr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8 a=hYA099koL3Nll-PByIQA:9
    a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756744AbeEJIH1 (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 04:07:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756820AbeEJIHL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 May 2018 04:07:11 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH -resend 27/27] x86: assembly, replace WEAK uses
Date: Thu, 10 May 2018 10:06:44 +0200
Message-Id: <20180510080644.19752-28-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the new SYM_CODE_INNER_LABEL for WEAK entries in the middle of x86
assembly functions.

And make sure WEAK is not defined for x86 anymore as these were the last
users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/ftrace_32.S | 2 +-
 arch/x86/kernel/ftrace_64.S | 2 +-
 arch/x86/kernel/head_32.S   | 2 +-
 include/linux/linkage.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 0404a2103730..a19dff47b47b 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -98,7 +98,7 @@ ftrace_graph_call:
 #endif
 
 /* This is weak to keep gas from relaxing the jumps */
-WEAK(ftrace_stub)
+SYM_CODE_INNER_LABEL(ftrace_stub, SYM_L_WEAK)
 	ret
 SYM_CODE_END(ftrace_caller)
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 6bd43895c13e..55aa71446a4b 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -186,7 +186,7 @@ SYM_CODE_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 #endif
 
 /* This is weak to keep gas from relaxing the jumps */
-WEAK(ftrace_stub)
+SYM_CODE_INNER_LABEL(ftrace_stub, SYM_L_WEAK)
 	retq
 SYM_FUNC_END(ftrace_caller)
 
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 7840ab96bee3..5d8b0bfcda54 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -156,7 +156,7 @@ SYM_CODE_START(startup_32)
 	jmp *%eax
 
 .Lbad_subarch:
-WEAK(xen_entry)
+SYM_CODE_INNER_LABEL(xen_entry, SYM_L_WEAK)
 	/* Unknown implementation; there's really
 	   nothing we can do at this point. */
 	ud2a
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index ff13228f3e38..2e270b8b167b 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -114,13 +114,13 @@
 #endif /* CONFIG_X86 */
 #endif /* LINKER_SCRIPT */
 
+#ifndef CONFIG_X86
 #ifndef WEAK
 /* deprecated, use SYM_FUNC_START_WEAK* */
 #define WEAK(name)	   \
 	SYM_FUNC_START_WEAK_NOALIGN(name)
 #endif
 
-#ifndef CONFIG_X86
 #ifndef END
 /* deprecated, use SYM_FUNC_END, SYM_DATA_END, or SYM_END */
 #define END(name) \
-- 
2.16.3
