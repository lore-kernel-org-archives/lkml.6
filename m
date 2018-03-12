Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELv7erSwN5CshDdCG9Rn17iNvhFidS0+HVmQ8/Z99v1lgldXYKMMR9/8SiaGtNmnG6ba6hr0
ARC-Seal: i=1; a=rsa-sha256; t=1520824093; cv=none;
        d=google.com; s=arc-20160816;
        b=IZAGwy9qKE9jdP6v6nib8qE3YpPnMGuGSnR0l3xs+kmllRTzxmakKvbkvguw/Of3iI
         IeenJ3FgYW3i+JYN4zRcTj3YeXLheL4l1dA1Dz5Uhb/1qQrufSql803DrCVNDtUN4OsZ
         6FrHG9terAFYAt0juoIuFxX9cliID9UKVJIY/ILVXoELO+uS63j9uVpVVKR5Lm3rK4P/
         iyzyqqs/0ktdXoA/8XY5O+EjOjTMbPLogvDYbMcODUiGbjte+H26Qs1k+k7gBlyjxhtg
         ANbCtdr7QwQOKiBNyqnXnDx/6s+ijOHWZ90ioqL/qvrnCrZG1KaGYy//hQGumdgbpvZt
         Svqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=VBWGjT2ca1U75az5iEFNMjjevEmmug+/V5dMLiU+qK0=;
        b=tbQXQ4S6m2AikBiS6bYjsBAODjQv70sY8EaPO52xzY3hZZr23U7bK/s5YypI51SWzg
         sGyETVpPTO2wQtpQ+HSxWeBz+ogce2kSpzKH4C0jVkp57rkn7uqDbHc/trf+V6N1Ehv+
         fMvpR4Tk1ZPOMvxElMpwOsm5MPqiS1YlLkgf4iXSWrlwiXFu7ZiL4DJgsw38WTWDtKwk
         o5GPJuDuPBGURcL0CWrtcsObXALFA/3D/tGWGsFJKzHl2f1+IQeyyPCCe1imgmLwIujz
         bkc6zaZuP+PrwoUuE4G6AipdymqT7oJBkENLmlRlj/H5vo6OAYFgkZl/Flkmf3enj8j5
         t1gA==
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
 "Andy Lutomirski" <luto@amacapital.net>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gnomes@lxorguk.ukuu.org.uk,
 "Kees Cook" <keescook@google.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Rik van Riel" <riel@redhat.com>,
 "Paul Turner" <pjt@google.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.492982839@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 08/76] x86/cpufeatures: Add X86_BUG_SPECTRE_V[12]
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699630087745134?=
X-GMAIL-MSGID: =?utf-8?q?1594699644384517047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 99c6fa2511d8a683e61468be91b83f85452115fa upstream.

Add the bug bits for spectre v1/2 and force them unconditionally for all
cpus.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515239374-23361-2-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.16: assign the first available bug numbers]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h | 2 ++
 arch/x86/kernel/cpu/common.c      | 3 +++
 2 files changed, 5 insertions(+)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -242,6 +242,8 @@
 #define X86_BUG_AMD_TLB_MMATCH	X86_BUG(3) /* AMD Erratum 383 */
 #define X86_BUG_AMD_APIC_C1E	X86_BUG(4) /* AMD Erratum 400 */
 #define X86_BUG_CPU_MELTDOWN	X86_BUG(5) /* CPU is affected by meltdown attack and needs kernel page table isolation */
+#define X86_BUG_SPECTRE_V1	X86_BUG(6) /* CPU is affected by Spectre variant 1 attack with conditional branches */
+#define X86_BUG_SPECTRE_V2	X86_BUG(7) /* CPU is affected by Spectre variant 2 attack with indirect branches */
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -807,6 +807,9 @@ static void __init early_identify_cpu(st
 
 	if (c->x86_vendor != X86_VENDOR_AMD)
 		setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
+
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 }
 
 void __init early_cpu_init(void)
