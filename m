Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520824471-2-14916809989745035873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824470; b=R7fllFO1s7JTd740szHzWkZLHhSJFOZg2lvCXyyoGwIOqzv
    zmRikV0+WVUjij8S8gKGlfOqL0sIQDBzUkJEDLZ56xlWvGk9Ml7jxX2cfnQX8ALv
    I8Zgi/51XeJgqdpLEq4tM7gpMRks7JUmuOT80J0a5WbDis3fhUKvSUxmIf32w4mL
    IvOJ8ym8eMC26io1arRV1wJju8T98F6Ks58pnKYWRskG6D1ia0JYHwiCM090VVMq
    ddJpnp8/5qdYjaw58g0RNbXZHxbYQxg9lQwzeBLSB2cZdHKwodqYNz2SJHtZuEH9
    3KHgdYvU5fmIaSnQltWD7Fk+mP4yV0RSAM+pREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824470; bh=rrL+Fn03QefKMHjXnCw
    RJfrguR06MaXajNE2wehs5JU=; b=IEsBUQ1vBbXfPKGFCOsRvlIkFz4e/E9aeh5
    I3aKkscvtxOwto6m/O4lytLJmEm68Wt4s03Bb1fSew8vvKmeunGHNL5Eyc872vAb
    RkSuiZaadkMEmZANVvMPr2bUzkW6QzoPTq/NMrb1N9nuG19uMbs7fo+lK2u3hTDx
    a03COPdacH/iPtB7/O/2yIgOX7ls2ClRYMNsXx/jO1MoOvSjuZKG8oe9CVdGhOzC
    K/86JTiYajZ0LWuqe4WbLXiWKDUzOl1krX331XS2ML0PHncSo4dtPjviqqGZMWs6
    LmASj2TFCQ0PTsVt/h6mYP9Tk/DWRTsqAVjmN/MwcPfhych2MUA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932988AbeCLDNL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:13:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41526 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932795AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Will Deacon" <will.deacon@arm.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linuxfoundation.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Dave Hansen" <dave.hansen@intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.385995810@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 11/76] x86/cpu: Implement CPU vulnerabilites sysfs
 functions
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16:
 - Meltdown mitigation feature flag is KAISER
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/kernel/cpu/bugs.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -130,6 +130,7 @@ config X86
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK if X86_64
 	select HAVE_CC_STACKPROTECTOR
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_VULNERABILITIES
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 
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
@@ -122,3 +123,31 @@ void __init check_bugs(void)
 		set_memory_4k((unsigned long)__va(0), 1);
 #endif
 }
+
+#ifdef CONFIG_SYSFS
+ssize_t cpu_show_meltdown(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+		return sprintf(buf, "Not affected\n");
+	if (boot_cpu_has(X86_FEATURE_KAISER))
+		return sprintf(buf, "Mitigation: PTI\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+
+ssize_t cpu_show_spectre_v1(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
+		return sprintf(buf, "Not affected\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		return sprintf(buf, "Not affected\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+#endif
