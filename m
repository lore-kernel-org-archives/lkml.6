Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294BDC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA9920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kCFeIv21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfAOPk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:40:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41697 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbfAOPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:40:26 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so1772168qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DkVyaPdAoK8qat/EoHKJAvan2LOc4hleJ5xRMTtVdi0=;
        b=kCFeIv21omS/bheDyIqiDE72vIYGdJxaWEhNliAoLSAhrm6fDh+JxSRtBF0aQXvVd0
         8U3ts6YSJHVw9SsB2UNfyQhYLDwhP5R1ipZPTwypaN4RgRHd7OKnOAZaDO43oLY+EVQz
         vYfa0WnpIbPHhC5jbYkGPfwrTVuVXlEMK/5fmO6S+hzke0MK9WRQUgEb9Q8QLnlDKIcX
         KDE/ViynBSX9eMEpRSUrYeExKmRockOqoTwbsWELhdrKsvWLnuRU83AqnypPkVrXqZEu
         aXTXXzo8FKvrnE9aAaeN/lNhIxXZgKamfDfzod0NNpEa3zGcW1bBKRX4Az3t2I6wGPRo
         H95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DkVyaPdAoK8qat/EoHKJAvan2LOc4hleJ5xRMTtVdi0=;
        b=S3fmCq5LWmkbfec4QLXJzMpBU4499TWCw2QLTruduGsDZulIFPUoGETLNsdYaagbEq
         bL+LCZhwJ6j/eZFJwIOJ+TKvkQ+OT66jGXUw8VGTIeRcbRFZ5f9ZlD54LVAbTffUxw30
         EKoi5ppiI1kVcgoXy3sERBgR7cxzS4qrR1yxklq3oU0CuLJAQJIWpm7xnsbntZofvS4G
         mfg7rPTwmz1eEjRhDlVdZpHEJZt0I5trPQZ8xjOQOl8RADK1H2OA/C/xfB5xNilfQnhY
         Nmwfqv4ji+eG7tEmI2ZjMOXPDuodAzvjTntOTDmDTPTo2G7jQSflUmOpHU3h/wrrSllC
         xjNg==
X-Gm-Message-State: AJcUukd3hhe7HznzJb2eyQLM/ohldstYwu1BiPn0BH1Qh+szABMMVFve
        5iQ7Rs3+X9Il5piENhrAeyQVzg==
X-Google-Smtp-Source: ALg8bN7zBreLgrv44wiGAkz/+3SxlBx1LHYUYC1CDkR5y+AtmAG56M8u5XgGG+2Ac5DPyZun3bTw+w==
X-Received: by 2002:a37:660f:: with SMTP id a15mr3124870qkc.328.1547566825925;
        Tue, 15 Jan 2019 07:40:25 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l12sm37748883qkk.40.2019.01.15.07.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 07:40:25 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     sean.j.christopherson@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] kvm: always inline vmx_vcpu_run()
Date:   Tue, 15 Jan 2019 10:40:14 -0500
Message-Id: <20190115154014.73919-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__noclone was removed from vmx_vcpu_run() in 453eafbe65f which causes a
compilation warning using GCC 8,

arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run.part.17()+0x3171:
call without frame pointer save/setup

GCC decides to splits the function into small parts for optimization
which confuses STACK_FRAME_NON_STANDARD(vmx_vcpu_run). Hence, just
inline the whole function to avoid this.

Fixes: 453eafbe65f (KVM: VMX: Move VM-Enter + VM-Exit handling to
non-inline sub-routines)
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6915f10e584..d38b275bdcc3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6362,7 +6362,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu)
 	vmx->loaded_vmcs->hv_timer_armed = false;
 }
 
-static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
+static __always_inline void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4, evmcs_rsp;
-- 
2.17.2 (Apple Git-113)

