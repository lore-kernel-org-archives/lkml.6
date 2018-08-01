Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740712083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkpqX5x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740712083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbeHATx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:53:57 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:47732 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732588AbeHATx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:53:56 -0400
Received: by mail-io0-f202.google.com with SMTP id z9-v6so14501130iom.14
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TyeHqtwY9V727My3XN86N70c6SNSXqhK1Y2bmZ/eF+g=;
        b=MkpqX5x4pArQtjCnhe8H5jNpA0QsEOvEgF2FVHMvdwdF40lp122eTmN2nhEb/3T6Sy
         074CXuYWKaSGxxxjwNCkuGsAOprXJd/xyq2r65MkI9K8w7vScKbddaYNxx2xhlvRXk1a
         6nWLFE9redC+UkZAplHu4MOnZuM5KYzJUHYc/7V0pHSVBJNPqbPJUjBamXcZxj9n1Pyn
         2VAoUOZlcHFDJQlqVS4JsFW83gSAtRQaEJfei3yWF3MgiaENq0PiVbBu7l8Sd+QEU7Rh
         zldS2YqvFqNUJpT4Yd8pGgrzOy+pQtWbIjkJxrCfVgWQNeT0cAtoek7S5PlER2kSieNL
         o0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TyeHqtwY9V727My3XN86N70c6SNSXqhK1Y2bmZ/eF+g=;
        b=LYRJGvHojbzLEaT0X+t8dPDJVyXV2uxXOcSWoKcJ/nNEi2dCxkilwYJpXyThcS5Amr
         QMnM2h649LkWOiL/ybOvrEDDSdiJVtXOVOWEwo/6ROhNFv34xC2+YDnhK2BJjUPfPLV4
         Sh/kK/vFXL2ivaEOIxxQJKEEN7LL3LgKFSsDKILCBibDXV5wBpFJHoO7LN+agVamHPG3
         Z+5nXjNoYAMxXP6M2ftOSsyizs1Ki2r9tWTApumd+b0cljpnxoK2bAT1/tpkeSOScPCp
         NYqH2WfDLRCtB9JAMN2sVsHB8rl6eSWB6s+Ss06SieXque5zKO/smQzqn8yEHDWb0R79
         N7/A==
X-Gm-Message-State: AOUpUlGMlT/GAtdZwtqERjUMC8UR3bk1FuRVVR1evHs5f4DjP524IXo6
        GPfcMgYt7GrXsoYioS0qbyt11wY8Adw=
X-Google-Smtp-Source: AAOMgpdAGqtPx5QOaJUWK0mfp6CZPJevhBh5ECYR7nKjqTXzQp2u15p2TmE2a+Ha55S6evvKwtEcEvuIvAw=
X-Received: by 2002:a6b:ab81:: with SMTP id u123-v6mr10361546ioe.102.1533146821611;
 Wed, 01 Aug 2018 11:07:01 -0700 (PDT)
Date:   Wed,  1 Aug 2018 11:06:57 -0700
Message-Id: <20180801180657.138051-1-pshier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] x86/cpufeatures: Add EPT_AD feature bit
From:   Peter Shier <pshier@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Feiner <pfeiner@google.com>

Some Intel processors have an EPT feature whereby the accessed & dirty bits
in EPT entries can be updated by HW. MSR IA32_VMX_EPT_VPID_CAP exposes the
presence of this capability.

This bit will also expose "ept_ad" in /proc/cpuinfo/$proc/flags if feature
is present.

Signed-off-by: Peter Feiner <pfeiner@google.com>
Signed-off-by: Peter Shier <pshier@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/cpu/intel.c        | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5701f5cecd312..7fff98fa58558 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -229,7 +229,7 @@
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
-
+#define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index eb75564f2d257..c050cd6066af0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -465,14 +465,17 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 #define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
 #define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
 #define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
+#define x86_VMX_FEATURE_EPT_CAP_AD		0x00200000
 
 	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
+	u32 msr_vpid_cap, msr_ept_cap;
 
 	clear_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
 	clear_cpu_cap(c, X86_FEATURE_VNMI);
 	clear_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
 	clear_cpu_cap(c, X86_FEATURE_EPT);
 	clear_cpu_cap(c, X86_FEATURE_VPID);
+	clear_cpu_cap(c, X86_FEATURE_EPT_AD);
 
 	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
 	msr_ctl = vmx_msr_high | vmx_msr_low;
@@ -487,8 +490,13 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
 		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
 			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT) {
 			set_cpu_cap(c, X86_FEATURE_EPT);
+			rdmsr(MSR_IA32_VMX_EPT_VPID_CAP,
+			      msr_ept_cap, msr_vpid_cap);
+			if (msr_ept_cap & x86_VMX_FEATURE_EPT_CAP_AD)
+				set_cpu_cap(c, X86_FEATURE_EPT_AD);
+		}
 		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
 			set_cpu_cap(c, X86_FEATURE_VPID);
 	}
-- 
2.18.0.233.g985f88cf7e-goog
