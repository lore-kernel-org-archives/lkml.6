Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeEVC6P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:58:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:54501 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751601AbeEVC6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:58:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="201335920"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        chao.p.peng@linux.intel.com, thomas.lendacky@amd.com, bp@suse.de,
        Kan.liang@intel.com, Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v9 03/12] perf/x86/intel/pt: Add new bit definitions for Intel PT MSRs
Date: Tue, 22 May 2018 12:52:06 +0800
Message-Id: <1526964735-16566-4-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bit definitions are use for emulate MSRs read/write
for KVM. For example, IA32_RTIT_CTL.FabricEn[bit 6] is available
only when CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 1. If KVM guest
try to set this bit with CPUID.(EAX=14H, ECX=0):ECX[bit3] = 0
a #GP would be injected to KVM guest.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index afe4e13..6ae2462 100644
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
