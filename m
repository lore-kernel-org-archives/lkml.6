Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C38E2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sngmoEFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C38E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeLDLF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbeLDLFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:05:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B502E214DE;
        Tue,  4 Dec 2018 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921523;
        bh=ovSiYiymwV3SIO1P/PFsz7QWYYVB+j6Cbk8JUUy1okY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sngmoEFuKjvhtxZxHMSCggIHdsfrZyYZpY5oPWaVJSlgEn2hP9snz6OQgFC5m+roM
         iqwTnjE0Zwr3JCchqX3csfWo36MGFl1iQRxohqmSe2L37/myng6gfFNHcXLDpuHzeG
         Gqu/dw/vaMthaPgZlJHgwkiGRv0Ao53NnD4XoV+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        kvm@vger.kernel.org, andrew.cooper3@citrix.com,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.14 069/146] x86/bugs: Add AMDs variant of SSB_NO
Date:   Tue,  4 Dec 2018 11:49:15 +0100
Message-Id: <20181204103729.615003937@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk konrad.wilk@oracle.com

commit 24809860012e0130fbafe536709e08a22b3e959e upstream

The AMD document outlining the SSBD handling
124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
mentions that the CPUID 8000_0008.EBX[26] will mean that the
speculative store bypass disable is no longer needed.

A copy of this document is available at:
    https://bugzilla.kernel.org/show_bug.cgi?id=199889

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: kvm@vger.kernel.org
Cc: andrew.cooper3@citrix.com
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180601145921.9500-2-konrad.wilk@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/kernel/cpu/common.c       |    3 ++-
 arch/x86/kvm/cpuid.c               |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -285,6 +285,7 @@
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
+#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -958,7 +958,8 @@ static void __init cpu_set_bug_bits(stru
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
-	   !(ia32_cap & ARCH_CAP_SSB_NO))
+	   !(ia32_cap & ARCH_CAP_SSB_NO) &&
+	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -367,7 +367,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD);
+		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD) | F(AMD_SSB_NO);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =


