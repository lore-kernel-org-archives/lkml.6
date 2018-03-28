Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeC1Q4a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:56:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:60698 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeC1Qzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:55:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="29654623"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 14/14] x86: Introduce CONFIG_X86_INTEL_MKTME
Date: Wed, 28 Mar 2018 19:55:40 +0300
Message-Id: <20180328165540.648-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new config option to enabled/disable Multi-Key Total Memory
Encryption support.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bf68138662c8..489674c9b2f6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1530,6 +1530,23 @@ config ARCH_USE_MEMREMAP_PROT
 	def_bool y
 	depends on AMD_MEM_ENCRYPT
 
+config X86_INTEL_MKTME
+	bool "Intel Multi-Key Total Memory Encryption"
+	select DYNAMIC_PHYSICAL_MASK
+	select PAGE_EXTENSION
+	depends on X86_64 && CPU_SUP_INTEL
+	---help---
+	  Say yes to enable support for Multi-Key Total Memory Encryption.
+	  This requires Intel processor that has support of the feature.
+
+	  Multikey Total Memory Encryption (MKTME) is a technology that allows
+	  transparent memory encryption in upcoming Intel platforms.
+
+	  MKTME is built on top of TME. TME allows encryption of the entirety
+	  of system memory using a single key. MKTME allows to have multiple
+	  encryption domains, each having own key -- different memory pages can
+	  be encrypted with different keys.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
-- 
2.16.2
