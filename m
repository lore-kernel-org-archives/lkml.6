Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeCONtQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:49:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:25962 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbeCONtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:49:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="211825916"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] x86/mm: Fix comment in detect_tme() regarding x86_phys_bits
Date: Thu, 15 Mar 2018 16:49:06 +0300
Message-Id: <20180315134907.9311-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180315134907.9311-1-kirill.shutemov@linux.intel.com>
References: <20180315134907.9311-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Kai pointed, we adjust x86_phys_bits not only to communicate
available physical address space to virtual machines, but mainly to
reflect the fact that the address space is reduced.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Kai Huang <kai.huang@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f0481b85c39d..fd379358c58d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -619,11 +619,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
 #endif
 
 	/*
-	 * Exclude KeyID bits from physical address bits.
-	 *
-	 * We have to do this even if we are not going to use KeyID bits
-	 * ourself. VM guests still have to know that these bits are not usable
-	 * for physical address.
+	 * KeyID bits effectively lower number of physical address bits.
+	 * Let's update cpuinfo_x86::x86_phys_bits to reflect the fact.
 	 */
 	c->x86_phys_bits -= keyid_bits;
 }
-- 
2.16.1
