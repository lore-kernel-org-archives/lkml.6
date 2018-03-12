Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELu8iKzas7WKzG3ZJuecZb4WPL+orkmAS8ZVjy42z3HAA1Hyiqts9d0hFV6XVPAbxRUU5Rrh
ARC-Seal: i=1; a=rsa-sha256; t=1520824076; cv=none;
        d=google.com; s=arc-20160816;
        b=ADKJ/K/grZO9O21hmAEOVmGIlYAWb5YPkSpO9DBYXFPtWysHOZkASuecs6APvnR7Uu
         AT79cKzT+JQo6KFhTO3lM6kzrFrPioI54lavlsE/GzoY+Ypwmr2IC8lMvLQvnRteeQIK
         63/f3s/cI2c5qOAnR6+OpPB3Twrm+wcMEan/JDT9cSs8ShodidaEBoOZbJdS0pdeDiLJ
         Dz8biRS2OOUHzhqsA9SDhyDgCh6MMqxN+AScQL2ubv8uCJDRlE2bNgA+3BRZOT51xWN7
         EHFkBXwf/HiKy6jvB9nEDhwB58F97tIYaPmtC+GYqATcK3sfbnTxOZ1fVBj8Y4myPFTj
         EQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=tdWKdc6dM019pKI8nOnRF/sUuV4BICjFt8ewQf+44K8=;
        b=RBKDqvrB+qVV7WmlNQkM2REX51cp0FTj44dHygLod8L4BFH5lY8qGkwIKrIV71xYOS
         hH+8akXEP4KUgwP3WKhpN3zmfEcbrsFw2EhPUdwm5ege17NPL8DOJJOc/uWwjEsAGpE0
         9340GsXkFZFHWVr1rcB+toTlRoCgx0b2UubOkQijJemKPg2r0ezbsb5093sfjIxQ/UG/
         37GENyaCNf+QLClkGwLpXAcg6vmPtnit+fpu7I9pp/wXVuKDtsklD5F7C7/8JKZSRukM
         qYrUeduOgsv9tgeF3stmuKb5ckPTT1X6B5oZvWh77R8kAQMQme0ykP3YRz4bNC10N79x
         CNJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Reviewed-by: Borislav Petkov" <bp@suse.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.961478180@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 053/104] x86/cpu/AMD: Make LFENCE a serializing
 instruction
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699640489456261?=
X-GMAIL-MSGID: =?utf-8?q?1594699626323312955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit e4d0e84e490790798691aaa0f2e598637f1867ec upstream.

To aid in speculation control, make LFENCE a serializing instruction
since it has less overhead than MFENCE.  This is done by setting bit 1
of MSR 0xc0011029 (DE_CFG).  Some families that support LFENCE do not
have this MSR.  For these families, the LFENCE instruction is already
serializing.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/20180108220921.12580.71694.stgit@tlendack-t1.amdoffice.net
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/msr-index.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -150,6 +150,8 @@
 #define FAM10H_MMIO_CONF_BASE_MASK	0xfffffffULL
 #define FAM10H_MMIO_CONF_BASE_SHIFT	20
 #define MSR_FAM10H_NODE_ID		0xc001100c
+#define MSR_F10H_DECFG			0xc0011029
+#define MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT	1
 
 /* K8 MSRs */
 #define MSR_K8_TOP_MEM1			0xc001001a
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -641,6 +641,16 @@ static void __cpuinit init_amd(struct cp
 		set_cpu_cap(c, X86_FEATURE_K8);
 
 	if (cpu_has_xmm2) {
+		/*
+		 * A serializing LFENCE has less overhead than MFENCE, so
+		 * use it for execution serialization.  On families which
+		 * don't have that MSR, LFENCE is already serializing.
+		 * msr_set_bit() uses the safe accessors, too, even if the MSR
+		 * is not present.
+		 */
+		msr_set_bit(MSR_F10H_DECFG,
+			    MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT);
+
 		/* MFENCE stops RDTSC speculation */
 		set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
 	}
