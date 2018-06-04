Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeFDTYw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:24:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:40503 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeFDTYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:24:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="64240693"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] x86/msr: write_rdtscp_aux() to use wrmsr_safe()
Date: Mon,  4 Jun 2018 12:24:28 -0700
Message-Id: <1528140269-26205-6-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
References: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using wrmsr_safe() can make code a bit simpler by removing
some condition check

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/msr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 04addd6..09bec62 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -317,7 +317,7 @@ static inline int wrmsrl_safe(u32 msr, u64 val)
 
 #define write_tsc(low, high) wrmsr(MSR_IA32_TSC, (low), (high))
 
-#define write_rdtscp_aux(val) wrmsr(MSR_TSC_AUX, (val), 0)
+#define write_rdtscp_aux(val) wrmsr_safe(MSR_TSC_AUX, (val), 0)
 
 struct msr *msrs_alloc(void);
 void msrs_free(struct msr *msrs);
-- 
2.7.4
