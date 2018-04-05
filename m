Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeDEJTY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:19:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751928AbeDEJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:19:20 -0400
Date: Thu, 5 Apr 2018 02:18:28 -0700
From: "tip-bot for Dmitry V. Levin" <tipbot@zytor.com>
Message-ID: <tip-9820e1c3376c641299624dd24646aed3167ad5b1@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        ldv@altlinux.org, torvalds@linux-foundation.org, tglx@linutronix.de,
        hpa@zytor.com, jan.kiszka@siemens.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        hpa@zytor.com, tglx@linutronix.de, jan.kiszka@siemens.com,
        ldv@altlinux.org, torvalds@linux-foundation.org
In-Reply-To: <20180405043210.GA13254@altlinux.org>
References: <20180405043210.GA13254@altlinux.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/uapi: Fix asm/bootparam.h userspace compilation
 errors
Git-Commit-ID: 9820e1c3376c641299624dd24646aed3167ad5b1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9820e1c3376c641299624dd24646aed3167ad5b1
Gitweb:     https://git.kernel.org/tip/9820e1c3376c641299624dd24646aed3167ad5b1
Author:     Dmitry V. Levin <ldv@altlinux.org>
AuthorDate: Thu, 5 Apr 2018 07:32:10 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 10:05:21 +0200

x86/uapi: Fix asm/bootparam.h userspace compilation errors

Consistently use types provided by <linux/types.h> to fix the following
asm/bootparam.h userspace compilation errors:

	/usr/include/asm/bootparam.h:140:2: error: unknown type name 'u16'
	  u16 version;
	/usr/include/asm/bootparam.h:141:2: error: unknown type name 'u16'
	  u16 compatible_version;
	/usr/include/asm/bootparam.h:142:2: error: unknown type name 'u16'
	  u16 pm_timer_address;
	/usr/include/asm/bootparam.h:143:2: error: unknown type name 'u16'
	  u16 num_cpus;
	/usr/include/asm/bootparam.h:144:2: error: unknown type name 'u64'
	  u64 pci_mmconfig_base;
	/usr/include/asm/bootparam.h:145:2: error: unknown type name 'u32'
	  u32 tsc_khz;
	/usr/include/asm/bootparam.h:146:2: error: unknown type name 'u32'
	  u32 apic_khz;
	/usr/include/asm/bootparam.h:147:2: error: unknown type name 'u8'
	  u8 standard_ioapic;
	/usr/include/asm/bootparam.h:148:2: error: unknown type name 'u8'
	  u8 cpu_ids[255];

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: <stable@vger.kernel.org> # v4.16
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 4a362601baa6 ("x86/jailhouse: Add infrastructure for running in non-root cell")
Link: http://lkml.kernel.org/r/20180405043210.GA13254@altlinux.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/uapi/asm/bootparam.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index aebf60357758..a06cbf019744 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -137,15 +137,15 @@ struct boot_e820_entry {
  * setup data structure.
  */
 struct jailhouse_setup_data {
-	u16	version;
-	u16	compatible_version;
-	u16	pm_timer_address;
-	u16	num_cpus;
-	u64	pci_mmconfig_base;
-	u32	tsc_khz;
-	u32	apic_khz;
-	u8	standard_ioapic;
-	u8	cpu_ids[255];
+	__u16	version;
+	__u16	compatible_version;
+	__u16	pm_timer_address;
+	__u16	num_cpus;
+	__u64	pci_mmconfig_base;
+	__u32	tsc_khz;
+	__u32	apic_khz;
+	__u8	standard_ioapic;
+	__u8	cpu_ids[255];
 } __attribute__((packed));
 
 /* The so-called "zeropage" */
