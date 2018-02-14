Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeBNG0I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 01:26:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28796 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754399AbeBNG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 01:26:07 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37044459"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@kernel.org>, <ebiederm@xmission.com>,
        <bhe@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/apic: Make setup_local_APIC() static
Date: Wed, 14 Feb 2018 14:25:54 +0800
Message-ID: <20180214062554.21020-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 37C3248AE921.A0E93
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function isn't used outside of apic.c, so let's mark it static.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/apic.h | 1 -
 arch/x86/kernel/apic/apic.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 98722773391d..09d1c6ed2408 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -138,7 +138,6 @@ extern void lapic_shutdown(void);
 extern void sync_Arb_IDs(void);
 extern void init_bsp_APIC(void);
 extern void apic_intr_mode_init(void);
-extern void setup_local_APIC(void);
 extern void init_apic_mappings(void);
 void register_lapic_address(unsigned long address);
 extern void setup_boot_APIC_clock(void);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6f59ac2238ab..3fda9734db25 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1464,7 +1464,7 @@ static void apic_pending_intr_clear(void)
  * Used to setup local APIC while initializing BSP or bringing up APs.
  * Always called with preemption disabled.
  */
-void setup_local_APIC(void)
+static void setup_local_APIC(void)
 {
 	int cpu = smp_processor_id();
 	unsigned int value;
-- 
2.14.3
