Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753701AbeDAQ5n (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 12:57:43 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:11566 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753633AbeDAQ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 12:57:41 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
To: pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] kvm: x86 : fix a compile warning
Date: Mon, 2 Apr 2018 09:15:32 +0800
Message-Id: <1522631732-3881-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-04-02 00:57:45,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-04-02 00:57:30,
        Serialize complete at 2018-04-02 00:57:30
X-MAIL: mse01.zte.com.cn w31GvV4g017894
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a "warning: no previous prototype".

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 18b5ca7..6621319 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7754,7 +7754,7 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 }
 EXPORT_SYMBOL_GPL(kvm_task_switch);
 
-int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+static int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
 	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG)) {
 		/*
-- 
1.8.3.1
