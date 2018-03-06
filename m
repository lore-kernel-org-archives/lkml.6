Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753835AbeCFOWD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:22:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44040 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753680AbeCFOWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:22:01 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] x86/MCE: Cleanup and complete struct mce fields definitions
Date: Tue,  6 Mar 2018 15:21:42 +0100
Message-Id: <20180306142143.19990-3-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306142143.19990-1-bp@alien8.de>
References: <20180306142143.19990-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Struct is part of the uapi, document that fact and all fields properly
and fix formatting.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/uapi/asm/mce.h | 52 ++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 435db58a7bad..955c2a2e1cf9 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -5,32 +5,36 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
-/* Fields are zero when not available */
+/*
+ * Fields are zero when not available. Also, this struct is shared with
+ * userspace mcelog and thus must keep existing fields at current offsets.
+ * Only add new fields to the end of the structure
+ */
 struct mce {
-	__u64 status;
-	__u64 misc;
-	__u64 addr;
-	__u64 mcgstatus;
-	__u64 ip;
-	__u64 tsc;	/* cpu time stamp counter */
-	__u64 time;	/* wall time_t when error was detected */
-	__u8  cpuvendor;	/* cpu vendor as encoded in system.h */
-	__u8  inject_flags;	/* software inject flags */
-	__u8  severity;
+	__u64 status;		/* Bank's MCi_STATUS MSR */
+	__u64 misc;		/* Bank's MCi_MISC MSR */
+	__u64 addr;		/* Bank's MCi_ADDR MSR */
+	__u64 mcgstatus;	/* Machine Check Global Status MSR */
+	__u64 ip;		/* Instruction Pointer when the error happened */
+	__u64 tsc;		/* CPU time stamp counter */
+	__u64 time;		/* Wall time_t when error was detected */
+	__u8  cpuvendor;	/* Kernel's X86_VENDOR enum */
+	__u8  inject_flags;	/* Software inject flags */
+	__u8  severity;		/* Error severity */
 	__u8  pad;
-	__u32 cpuid;	/* CPUID 1 EAX */
-	__u8  cs;		/* code segment */
-	__u8  bank;	/* machine check bank */
-	__u8  cpu;	/* cpu number; obsolete; use extcpu now */
-	__u8  finished;   /* entry is valid */
-	__u32 extcpu;	/* linux cpu number that detected the error */
-	__u32 socketid;	/* CPU socket ID */
-	__u32 apicid;	/* CPU initial apic ID */
-	__u64 mcgcap;	/* MCGCAP MSR: machine check capabilities of CPU */
-	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
-	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
-	__u64 ppin;	/* Protected Processor Inventory Number */
-	__u32 microcode;/* Microcode revision */
+	__u32 cpuid;		/* CPUID 1 EAX */
+	__u8  cs;		/* Code segment */
+	__u8  bank;		/* Machine check bank reporting the error */
+	__u8  cpu;		/* CPU number; obsoleted by extcpu */
+	__u8  finished;		/* Entry is valid */
+	__u32 extcpu;		/* Linux CPU number that detected the error */
+	__u32 socketid;		/* CPU socket ID */
+	__u32 apicid;		/* CPU initial APIC ID */
+	__u64 mcgcap;		/* MCGCAP MSR: machine check capabilities of CPU */
+	__u64 synd;		/* MCA_SYND MSR: only valid on SMCA systems */
+	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
+	__u64 ppin;		/* Protected Processor Inventory Number */
+	__u32 microcode;	/* Microcode revision */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
-- 
2.13.0
