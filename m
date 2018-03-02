Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936347AbeCBMDJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:03:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35164 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936177AbeCBMDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:03:06 -0500
Date: Fri, 2 Mar 2018 13:03:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: [PATCH] x86/MCE: Cleanup and complete struct mce fields definitions
Message-ID: <20180302120259.GB7406@pd.tnic>
References: <20180301233449.24311-1-tony.luck@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7B388EF7@ORSMSX110.amr.corp.intel.com>
 <20180302114523.GA7406@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180302114523.GA7406@pd.tnic>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ontop:

---
From: Borislav Petkov <bp@suse.de>

Struct is part of the uapi, document all fields properly and fix
formatting.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/uapi/asm/mce.h | 46 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 435db58a7bad..15ba7802531b 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -7,30 +7,30 @@
 
 /* Fields are zero when not available */
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
+	__u64 ip;		/* Instruction Pointer when the error happened. */
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


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
