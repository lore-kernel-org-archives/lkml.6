Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224CRmhD3d6jsY/w6iHQ4zCTbsDE8lyOyQgbWpfE9IWyxzHY4HtGKhZhpuJdlch7OyvsHBud
ARC-Seal: i=1; a=rsa-sha256; t=1517855109; cv=none;
        d=google.com; s=arc-20160816;
        b=k6zt2iNkhTkyiuWgIE4HDnXetbf8ivReIvDobN9KbKdirN4JRnWHAZ4kE1bDS2H9/b
         sA7PcG4qHXqL2XAyOS+kKpFMMYZDrSJYCuqzEZKbmxzC7BE5K6IBRVDP6CfEiSuKCu+p
         uJX8hPepo9lLLmNGxnpR4Us4yTfM0Jof4lPQYs9iKGUNY/hO9Pq+kdiQ1eWK4Lo+1XIk
         Q6Z7+b2/MzyEAU0RyYiOVDqupxGteAn9zp2rZa7pYMiXtTFuCYft5DDZajCoKpOKj3DS
         yqsVPMp1UnpYLt8SYPMBM086ipc9ynPTotfjdDeSndnfSytzt0jXzNZ+SAtJJfuuyo9X
         eeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aTYL96qcPpF/Bl/fYkuhDMcduWAxIUQF3PrsC/SbLRI=;
        b=J6T9j6lsSsvqLLUcJpl5iqPzp+HK+4YLJuJVoWFx6l83cAgOYWS05zG0OupfsjYABn
         ULqt1ZJAFyA2GMHji7l+11xSnM2ZboaR7WOhijl+pOAAMrgkHtRVfz8R6axEQkTnNPy9
         F58p8m9aQkOo47xv5W2HHw8SYW58ZYBXGd6sErl3crArgmhBQZ43/6kihgxDUQJcDZm9
         0GCSJQxZvJisDBaDcvmd1HiYRXhK11cOPe2H1VSp5XSnaC9JwzFameqx6OOMlmergxnF
         cjDsrGLlHmv4WrF2v2MjK++vjMmckCXogterROgx1AWokzelrhe0A1BxooFvP8/5vuZ/
         GG0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@intel.com>,
	gnomes@lxorguk.ukuu.org.uk,
	ak@linux.intel.com,
	ashok.raj@intel.com,
	karahmed@amazon.de,
	arjan@linux.intel.com,
	torvalds@linux-foundation.org,
	peterz@infradead.org,
	bp@alien8.de,
	pbonzini@redhat.com,
	tim.c.chen@linux.intel.com,
	gregkh@linux-foundation.org
Subject: [PATCH 4.15 08/60] x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown
Date: Mon,  5 Feb 2018 10:22:41 -0800
Message-Id: <20180205182214.261733948@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586334764895819?=
X-GMAIL-MSGID: =?utf-8?q?1591586439122027728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit fec9434a12f38d3aeafeb75711b71d8a1fdef621

Also, for CPUs which don't speculate at all, don't report that they're
vulnerable to the Spectre variants either.

Leave the cpu_no_meltdown[] match table with just X86_VENDOR_AMD in it
for now, even though that could be done with a simple comparison, on the
assumption that we'll have more to add.

Based on suggestions from Dave Hansen and Alan Cox.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-6-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/common.c |   48 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -47,6 +47,8 @@
 #include <asm/pat.h>
 #include <asm/microcode.h>
 #include <asm/microcode_intel.h>
+#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/uv/uv.h>
@@ -877,6 +879,41 @@ static void identify_cpu_without_cpuid(s
 #endif
 }
 
+static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PENWELL,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PINEVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_CENTAUR,	5 },
+	{ X86_VENDOR_INTEL,	5 },
+	{ X86_VENDOR_NSC,	5 },
+	{ X86_VENDOR_ANY,	4 },
+	{}
+};
+
+static const __initdata struct x86_cpu_id cpu_no_meltdown[] = {
+	{ X86_VENDOR_AMD },
+	{}
+};
+
+static bool __init cpu_vulnerable_to_meltdown(struct cpuinfo_x86 *c)
+{
+	u64 ia32_cap = 0;
+
+	if (x86_match_cpu(cpu_no_meltdown))
+		return false;
+
+	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+	/* Rogue Data Cache Load? No! */
+	if (ia32_cap & ARCH_CAP_RDCL_NO)
+		return false;
+
+	return true;
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -924,11 +961,12 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
-	if (c->x86_vendor != X86_VENDOR_AMD)
-		setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
-
-	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
-	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+	if (!x86_match_cpu(cpu_no_speculation)) {
+		if (cpu_vulnerable_to_meltdown(c))
+			setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+	}
 
 	fpu__init_system(c);
 
