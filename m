Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01160C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA96F20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5MpKHpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA96F20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeG3WvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:51:09 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:39054 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbeG3WvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:51:09 -0400
Received: by mail-io0-f202.google.com with SMTP id x5-v6so9680196ioa.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/0hkxAivsGfnU3lVjRwytYufrvDVZs6l4S68uAcAuAs=;
        b=Y5MpKHplwvgYi1BVD6lNder0AJDcjevtFkmOUNbZFfIOX1F1XD4Vf3DaUzXkyD8d8B
         2nqPIEEvSyYFAKAmNjkCVgTj7ti3j6pAmqa42rE11VSoRqH7HxLMu4iRbz9ZQiDJzqgo
         Gn6Kp8Xlu72lSs20PRUIAkPLiVWVd/iAQx4vMS3goz18ePkO8aODzLmqjpPP5mWY2Dkr
         ZfNqSI67plCFL4I0hZbteh8J6CW4shC7REgVFTl7Bz0dzw5bVB8NWo8Xkyr9yd3m3sUW
         b0o2A9L+FbwGMRiyKVE2DHncvwzeEYqZP89jOHUhD/rEhO0Xj0TMfAhjjnecxTrFSnwW
         HbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/0hkxAivsGfnU3lVjRwytYufrvDVZs6l4S68uAcAuAs=;
        b=Ttfi4WOXacvmPw+VecSES6UTO/IYM9JHYFfzRDbIXcx6OJCpsiKSBIVL0XVT6j1UFM
         6x8vjKKTx46gxIwSybmiX8BT3mhx0r1wpof19mBiih7W11w0o9W80Ncfi0Xo2Vj2IhBI
         tC7OSM/qhxHGCoBzP6pu6L3gfcrIItD1lbTPcxXWVisWIZxj0w3c7UfcmWQs8lESfOY1
         +v0QAhctwkOTts4DxQDa6aZ6DWapXeF1LlW+ikX4xf+AGmB4xiGfWd3MUVSsI/gvFCMa
         AjqcfYsWWqbtOa8/AEdX12vj48uXv22kiVoPJR4wg9BBZ+d6867BSh9JM9WIgnlNN5gs
         aiJg==
X-Gm-Message-State: AOUpUlHzl8YLcX3RYsNd9xOeKI1EZ+LS9Hn9V2UgSU1JMGUPrezcCKCZ
        ztFoY5/xgKr72RxEAsdYqQz0G/m+FzU=
X-Google-Smtp-Source: AAOMgpez0vx/xSepc8TOiW8ppJRRiPDQqINu0VUZeIJv9oTrnG4N++o4bYWUxCJt2Hlc5gAu1lD5lTelHGQ=
X-Received: by 2002:a6b:9189:: with SMTP id t131-v6mr7318445iod.41.1532985258947;
 Mon, 30 Jul 2018 14:14:18 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:12:54 -0700
Message-Id: <20180730211254.173686-1-pshier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] proc: added ept_ad flag to /proc/cpuinfo
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

The Intel Haswell architecture has an EPT feature whereby the access &
dirty bits in EPT entries are updated without taking a guest exit.
This patch adds the "ept_ad" flag to /proc/cpuinfo if this feature is
available.

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
