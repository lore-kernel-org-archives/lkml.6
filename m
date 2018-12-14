Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB9C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E114214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789554;
	bh=ABbvC7f8KEGNhAMUD36PDttjiyVIXs9SvDmBT37rLEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mqTaraDo2IdgfGunbEKyIk5SG6AvwqxPTE9XhX1D2QKNmpzpdKZT/vC7QpMoYTMZ5
	 U7SNzSLZpAwHY2XaExec67rTI2rNn5HKRL5y29bW5mxzvvjqpCR2h5uzInOEzL3XIA
	 6LgR65JAmY1ocUIO7HnGBaQoK0wGrD1RJRjW1+vU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E114214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeLNMMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731938AbeLNMMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3552133F;
        Fri, 14 Dec 2018 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789548;
        bh=ABbvC7f8KEGNhAMUD36PDttjiyVIXs9SvDmBT37rLEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQ0nrAGSiTxM0U+padU/OGX2s7c6+mJfq2fL6yqK6R1sZEqmq/flMsoxjaJeh3lpK
         UtSIli99e8eyVxqbbal+KZkBGdd+r4LwqSGiYLToUFqQa2n+xp2tJcngyDH1BX0dtE
         E6eSOo8e6qHVo/DasBb4RVKcoL+PdBQeAvj41HDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 35/51] x86/kvm/vmx: fix old-style function declaration
Date:   Fri, 14 Dec 2018 13:00:37 +0100
Message-Id: <20181214115716.347474536@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1e4329ee2c52692ea42cc677fb2133519718b34a ]

The inline keyword which is not at the beginning of the function
declaration may trigger the following build warnings, so let's fix it:

arch/x86/kvm/vmx.c:1309:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
arch/x86/kvm/vmx.c:5947:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
arch/x86/kvm/vmx.c:5985:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
arch/x86/kvm/vmx.c:6023:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8888d894bf39..011050820608 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1077,7 +1077,7 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx);
 static void copy_shadow_to_vmcs12(struct vcpu_vmx *vmx);
 static int alloc_identity_pagetable(struct kvm *kvm);
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
-static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
@@ -4872,7 +4872,7 @@ static void free_vpid(int vpid)
 	spin_unlock(&vmx_vpid_lock);
 }
 
-static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -4907,7 +4907,7 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
 	}
 }
 
-static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
 							 u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -4942,7 +4942,7 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
 	}
 }
 
-static void __always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
 			     			      u32 msr, int type, bool value)
 {
 	if (value)
-- 
2.19.1



