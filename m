Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6527C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D01020879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DayayaGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D01020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeLEJkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbeLEJkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:35 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3355B2084C;
        Wed,  5 Dec 2018 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002835;
        bh=xNF4Y/dm8G671nrYQjGMQa2HkkyV4iLj194d/AqBKxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DayayaGT//jPtZT1gdesF5bmsPegAeidQzwS2v+oSbES0sAsLSUfxJkmU/RhAGlNr
         LhmOV279xc/pTmOS/9noc6TfZlT6XqLTNVqd+cQ8m7WLKSjkOJxn9LPK3YBGmWJoJd
         90C2M029kfI0L2AG2ei2zoE8Sqv8cyU+lv0TF0HA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 082/123] x86/kvm/vmx: fix old-style function declaration
Date:   Wed,  5 Dec 2018 04:35:14 -0500
Message-Id: <20181205093555.5386-82-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Wang <wang.yi59@zte.com.cn>

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
index bdd46628c107..0ee696f63229 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1284,7 +1284,7 @@ static void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 					    u16 error_code);
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
-static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
@@ -5937,7 +5937,7 @@ static void free_vpid(int vpid)
 	spin_unlock(&vmx_vpid_lock);
 }
 
-static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -5975,7 +5975,7 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
 	}
 }
 
-static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
 							 u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -6013,7 +6013,7 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
 	}
 }
 
-static void __always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
 			     			      u32 msr, int type, bool value)
 {
 	if (value)
-- 
2.17.1

