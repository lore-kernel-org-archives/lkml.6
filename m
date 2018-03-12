Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvHxOeu+IYtS7Auz6hwOGlUPLkHh8ndxyo5dfpRhtT8fAOLjczyYGj+Iz1NixwQlJIQqjCM
ARC-Seal: i=1; a=rsa-sha256; t=1520824101; cv=none;
        d=google.com; s=arc-20160816;
        b=0xgS6k+v58qGIY9krSOFZmVBzhC9yonu2nvkY0naaR1cpko2paLcHY9mJ2JoqNSDJ8
         FWq9e94vgirYjuuQIJn5YzJtekPtbYiiKNnMPtqSE5Mp9Sfanh1Hfbun41GxEX9IMvJK
         vSuf4mhDo6OmDwuoY4nV+YgBCdNXfGYwlURAc4UteqppXvhFC0pKqj6nmS09lasC3yx7
         vO4APioi+vxg05LeWBM6OcBP/nyzs9kwByn5ejtj6QckzDqTEODnJGmxxQuUuo79tG1q
         MNPMkItr/tZE/ls+1j/izwrG58LHQLmly8JEzMpotNWedftv9fsbFRFe+mj2lBZ4vAlq
         F/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ZNXJ3824HxNxX4g5V/eDZ5vVDXFiiEZOeYGApDgBhtE=;
        b=TQaS/XS6JpNIeOfjCJbiDB2clKZMXun06JJOhG7jNH+pevoHYv2gdL9SlXEzTTkHhw
         +DcycSOFPTonyWw8BF2r3dQg7nKc+MBGVsdlmpWLIam0h0Zx9zpEdnzXa2XiS1Q5mrgv
         jPUCG4qxZhQs0b5FEvHFNy8gAfq1NLpOv/KrbYRlSdIsl3VuaRv4JcW9Fgjsj1Wx3B6h
         623t6OXRkhysxwJmcv3k07GpgvJsOXcDnWqe/oCy/1s8yf9s9Q5AI7namqV/9aF39dLH
         d3UCC2XD16PSWlugawlRgcZnuuHu9JLYFncV9AmGTStTqNuovVy3oqRE8VgTwn8AjuNR
         Favg==
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
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Alan Cox" <gnomes@lxorguk.ukuu.org.uk>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andi Lutomirski" <luto@amacapital.net>,
 "Greg KH" <gregkh@linux-foundation.org>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Jiri Koshina" <jikos@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.467382311@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 07/76] x86/pti: Rename BUG_CPU_INSECURE to
 BUG_CPU_MELTDOWN
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699653185874182?=
X-GMAIL-MSGID: =?utf-8?q?1594699653185874182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit de791821c295cc61419a06fe5562288417d1bc58 upstream.

Use the name associated with the particular attack which needs page table
isolation for mitigation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jiri Koshina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Lutomirski  <luto@amacapital.net>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Greg KH <gregkh@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801051525300.1724@nanos
[bwh: Backported to 3.16: bug number is different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -241,7 +241,7 @@
 #define X86_BUG_COMA		X86_BUG(2) /* Cyrix 6x86 coma */
 #define X86_BUG_AMD_TLB_MMATCH	X86_BUG(3) /* AMD Erratum 383 */
 #define X86_BUG_AMD_APIC_C1E	X86_BUG(4) /* AMD Erratum 400 */
-#define X86_BUG_CPU_INSECURE	X86_BUG(5) /* CPU is insecure and needs kernel page table isolation */
+#define X86_BUG_CPU_MELTDOWN	X86_BUG(5) /* CPU is affected by meltdown attack and needs kernel page table isolation */
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -806,7 +806,7 @@ static void __init early_identify_cpu(st
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
 	if (c->x86_vendor != X86_VENDOR_AMD)
-		setup_force_cpu_bug(X86_BUG_CPU_INSECURE);
+		setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
 }
 
 void __init early_cpu_init(void)
