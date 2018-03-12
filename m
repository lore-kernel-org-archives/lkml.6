Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvnPthHgyoURd3wrBPAWBK71rJ/AeihVLEmmczpTjG2ZYvS8MejT5VeNJgTfTgneS7W4AeQ
ARC-Seal: i=1; a=rsa-sha256; t=1520824062; cv=none;
        d=google.com; s=arc-20160816;
        b=DeoHvgo9y8+L8MJ8o4mmKPEYKslxBudrj+EGdLqEde8r2PvHMll3tRFmpMBU4VAPFK
         yrV50eM4hcjCSStJDZ+ASg4s6iTR0nPySiSpIAQbtuHlLEAwzmupv7FLwhNRSFSHyrQG
         kEHxrQrgB1sbPPDD6ubQ9LLqypI6EJYgLoXKHYKE5QIIp5sVVou2gQ6eQWfryP4hWOIj
         A7qbQepeQ7oOeqfRaCHE+uhzQcuZY4NfvZBP3Ijb4eZF7FHtqlJSTxjcEpJ0to93fD8J
         4ut48iJqhsIVZqMovDCW0TxvyTPfYcqIfD9awS/xZaZwb3B42wSoHybwoVttytFB3rfh
         vV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=jSnjZo8qW+JK9U4MyemzH+fyXk3+rxMacAc21WP96Gk=;
        b=0gNRpAFBO8SyY+CLpEBMateKwSPx4KKGuYGB2glywWnegE9FflYgdYPODe8XlxNobd
         QHoCj5YoUdH1T0nT86VrNS8Tx0sWLdvRDtcgFemvUSwTv8OLuVF691wqJ7pMaCfIWp4t
         tnd6mCDyhzANafQbLdNJwzzQkdv47ARCBeMLsW2JdR7T1E7FmA5iN/2zzEttDMCVJeWr
         1bswij7rdIcaujAw/+MZ/ybVJBfrJPe3tbRiVwVwIPAQl/wOI79ooeYeX30iA+bAXvrw
         3/8jQwTNIFAzA6lvQ4OXTG/WplMbwBkY59XzWKrFfjLijAr7fDkZI7MpeKhJuPOYq37c
         CwTw==
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
 "Will Deacon" <will.deacon@arm.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Linus Torvalds" <torvalds@linuxfoundation.org>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
 "Borislav Petkov" <bp@alien8.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.610579380@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 047/104] x86/cpu: Implement CPU vulnerabilites sysfs
 functions
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699612019782137?=
X-GMAIL-MSGID: =?utf-8?q?1594699612019782137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 61dc0f555b5c761cdafb0ba5bd41ecf22d68a4c4 upstream.

Implement the CPU vulnerabilty show functions for meltdown, spectre_v1 and
spectre_v2.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180107214913.177414879@linutronix.de
[bwh: Backported to 3.2:
 - Meltdown mitigation feature flag is KAISER
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/kernel/cpu/bugs.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,6 +75,7 @@ config X86
 	select HAVE_BPF_JIT if (X86_64 && NET)
 	select CLKEVT_I8253
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select GENERIC_CPU_VULNERABILITIES
 	select ARCH_SUPPORTS_ATOMIC_RMW
 
 config INSTRUCTION_DECODER
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -9,6 +9,7 @@
  */
 #include <linux/init.h>
 #include <linux/utsname.h>
+#include <linux/cpu.h>
 #include <asm/bugs.h>
 #include <asm/processor.h>
 #include <asm/processor-flags.h>
@@ -202,3 +203,31 @@ void __init check_bugs(void)
 		set_memory_4k((unsigned long)__va(0), 1);
 #endif
 }
+
+#ifdef CONFIG_SYSFS
+ssize_t cpu_show_meltdown(struct sysdev_class *dev,
+			  struct sysdev_class_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+		return sprintf(buf, "Not affected\n");
+	if (boot_cpu_has(X86_FEATURE_KAISER))
+		return sprintf(buf, "Mitigation: PTI\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+
+ssize_t cpu_show_spectre_v1(struct sysdev_class *dev,
+			    struct sysdev_class_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
+		return sprintf(buf, "Not affected\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct sysdev_class *dev,
+			    struct sysdev_class_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		return sprintf(buf, "Not affected\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+#endif
