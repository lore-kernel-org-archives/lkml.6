Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeECKPH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:15:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:44391 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbeECKOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:14:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38109753"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 03/13] perf/x86/intel/pt: Add new bit definitions for Intel PT MSRs
Date: Thu,  3 May 2018 20:08:33 +0800
Message-Id: <1525349323-9938-4-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These new bit definitions are use for emulate MSRs read/write
for KVM. For example, IA32_RTIT_CTL.FabricEn[bit 6] is available
only when CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 1. If KVM guest
try to set this bit with CPUID.(EAX=14H, ECX=0):ECX[bit3] = 0
a #GP would be injected to KVM guest.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c168e26..cc9e681 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -112,6 +112,7 @@
 #define RTIT_CTL_USR			BIT(3)
 #define RTIT_CTL_PWR_EVT_EN		BIT(4)
 #define RTIT_CTL_FUP_ON_PTW		BIT(5)
+#define RTIT_CTL_FABRIC_EN		BIT(6)
 #define RTIT_CTL_CR3EN			BIT(7)
 #define RTIT_CTL_TOPA			BIT(8)
 #define RTIT_CTL_MTC_EN			BIT(9)
@@ -140,6 +141,8 @@
 #define RTIT_STATUS_BUFFOVF		BIT(3)
 #define RTIT_STATUS_ERROR		BIT(4)
 #define RTIT_STATUS_STOPPED		BIT(5)
+#define RTIT_STATUS_BYTECNT_OFFSET	32
+#define RTIT_STATUS_BYTECNT		(0x1ffffull << RTIT_STATUS_BYTECNT_OFFSET)
 #define MSR_IA32_RTIT_ADDR0_A		0x00000580
 #define MSR_IA32_RTIT_ADDR0_B		0x00000581
 #define MSR_IA32_RTIT_ADDR1_A		0x00000582
-- 
1.8.3.1
