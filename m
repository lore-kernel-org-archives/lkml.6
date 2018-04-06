Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754962AbeDFPFY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:05:24 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41936 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754777AbeDFNaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:30:07 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
To: pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] kvm: x86: fix a prototype warning
Date: Sat, 7 Apr 2018 05:47:32 +0800
Message-Id: <1523051252-110308-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-04-06 21:29:57,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-04-06 21:29:31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn w36DTlNJ018000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

warning: no previous prototype for ‘vmx_enable_tdp’

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f0fd50b..86681bc 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6954,7 +6954,7 @@ static void wakeup_handler(void)
 	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
 }
 
-void vmx_enable_tdp(void)
+static void vmx_enable_tdp(void)
 {
 	kvm_mmu_set_mask_ptes(VMX_EPT_READABLE_MASK,
 		enable_ept_ad_bits ? VMX_EPT_ACCESS_BIT : 0ull,
-- 
1.8.3.1
