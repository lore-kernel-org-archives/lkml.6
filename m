Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071467-1517855015-2-17576840224675717680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855015; b=Kw3Vzw+uR9X0NKArrAnJmMHBlP463sFoi7YBI5UObG+usLe
    zwjA4Hq5Jt3SgZjfUyg4RFObwa9CaHC4YNVEHw7I2K/52EWxC1yCM8QeQRQp7wm/
    5sFYZ4bYdxTPsWuPUc/Oq4ubvvT8Xg/R1GQumPooNY8CsJCV0hl4M53CZYj9D/Ij
    XX2EUhflQnFT7qKOuMF4WgUkCuIy4DlExDHyQsB2E0GzwM8h6QGXfb7AQEn3A2ak
    uYzMGEei5cpgNdis8OkTzZcjd/iSNBKNcJxyNw3bghKx5CdKXCtmkE5TrpicuAv/
    UTkywpRQEzyQ3IoTuOjTMnUDLFdFWltcxN/vj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855015; bh=VlWrIoWlfdDTft5/U35CLNMAMN
    Bi1fmv4wsoMN/IARA=; b=rnzE+YErXKVAwWkLwcWxtlOcegdtU6GmPV/sLa3tRv
    TsWD3K95oQIHjOlNqWPBfMpIjOXhD9tyI4/Q6dpRNIjM8CnOyL5GTIYV5T0tK9kE
    k8IgrCFGYrmEAh5KI+OKxec0J49kMEy+bdUPZH/T2xIbumGlmokQipyJeVvOVq8S
    8t9BQmUvDqOUQIQknP9XkMDKjCJg4IdOOvlFasZ8OdCjmbdibmOXq4CUm2iLgpye
    G3Ero4GmWRhwfHKy7JUeZd28rQWuytRNbmSB0IETDdCtm5Pj/iSrahxEzIPy69Gx
    tqx1EFQlAnvgyEPzp0qlOUNrGEmIyhuMpleH/n+czZCA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeBESXc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:23:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeBESXa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:23:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, dave.hansen@intel.com, arjan@linux.intel.com,
        torvalds@linux-foundation.org, peterz@infradead.org, bp@alien8.de,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com,
        gregkh@linux-foundation.org
Subject: [PATCH 4.14 14/64] x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support
Date: Mon,  5 Feb 2018 10:22:33 -0800
Message-Id: <20180205182139.157163812@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit 20ffa1caecca4db8f79fe665acdeaa5af815a24d

Expose indirect_branch_prediction_barrier() for use in subsequent patches.

[ tglx: Add IBPB status to spectre_v2 sysfs file ]

Co-developed-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-8-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/cpufeatures.h   |    2 ++
 arch/x86/include/asm/nospec-branch.h |   13 +++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   10 +++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -210,6 +210,8 @@
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switches */
 
+#define X86_FEATURE_IBPB		( 7*32+21) /* Indirect Branch Prediction Barrier enabled*/
+
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
 #define X86_FEATURE_VNMI		( 8*32+ 1) /* Intel Virtual NMI */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -218,5 +218,18 @@ static inline void vmexit_fill_RSB(void)
 #endif
 }
 
+static inline void indirect_branch_prediction_barrier(void)
+{
+	asm volatile(ALTERNATIVE("",
+				 "movl %[msr], %%ecx\n\t"
+				 "movl %[val], %%eax\n\t"
+				 "movl $0, %%edx\n\t"
+				 "wrmsr",
+				 X86_FEATURE_IBPB)
+		     : : [msr] "i" (MSR_IA32_PRED_CMD),
+			 [val] "i" (PRED_CMD_IBPB)
+		     : "eax", "ecx", "edx", "memory");
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __NOSPEC_BRANCH_H__ */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -263,6 +263,13 @@ retpoline_auto:
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		pr_info("Filling RSB on context switch\n");
 	}
+
+	/* Initialize Indirect Branch Prediction Barrier if supported */
+	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL) ||
+	    boot_cpu_has(X86_FEATURE_AMD_PRED_CMD)) {
+		setup_force_cpu_cap(X86_FEATURE_IBPB);
+		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+	}
 }
 
 #undef pr_fmt
@@ -292,7 +299,8 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IPBP" : "",
 		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
 }
 #endif
