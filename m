Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464256-2-13654344088566237268
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464255; b=nPTX2ocqR/7mF3aEF4cFwhm8iI4Be+KrPtKeWowg1e9tvwaMTr
    QaSQ1h8qTPcb1om6yd3RZzQFAvxVDfV7oItVfMB7augwGsl8Tr4mnjfSsKFdZjZ7
    XzeYT2Yl3S7YNiNoiUFb+7buJ2UEi1vf/3X0lIOmfV99+wHdFIspO5HB1xoGytB/
    OKTiNF2vrAEKNsJLNW72VIdyh+xFjQUtWoFtCPLvFTc0AaFfKmYPQ4oW5587S/ex
    Re6xK4zSm6piCc0hLHuYJ2XLjY6bDVtN3U0TVpcSXKBDgeLGsNdPa7l69lYUHmwh
    dXG9mDJlCVuyAZ612AIEloRMSspI7iGSfLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464255;
    bh=xQqOZKgLDhSoBs0C+m4zMJKq6HV5QvSaa9OS2Q4V8AU=; b=I7Dil9tZzKa5
    mMNJAKkz0WY1OQytzm887UeAMV1fJAO5Gp8dysR1rrXETpApOfUxwqcYhhyCcB23
    ATh6WnHxzoMsvyqvczs/MONnCAAkcs4BBHHfyUyHF98EbGWqr89nv4OKTrdmeMyi
    tFLom+vNFX/lGAhRyu8+Ra6aIur/f4Crwxvtm5UGnTbxhqzadvpfuxf4Fml8X6Y0
    gTRkkhz+cxMXDwlnitxFnYLROcuqvM++/0yX0JX5a5LwbFpSoFGITZEAsTPqCjYV
    rT0EBnOisAMAJznKxKYHXV6EjhKlfOAJUrphjfiO2R7l0jvkI0mxWx1ogrP5dSrH
    rP4Bttnijg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH5ckD/A5f4UDz0TDitOL7Kvv4CNFL+5Sw0UyZlTCJVgqWTVnEjefbKrs4txaUeZ1wKu8rn8DDM9wkBJK0vTRiSnLj+BMHVRUnrsXF3Ez0A2E0fAcp/F
    hWhJneLjP7j3tLxu0bJ+U3OUpbRH43SZhWXB8QbCoUWR+9ag9OOth2s6bL3X+LxfZQ9Gc5rZ5a+26YToFdBGb5AGBvx63sXZu0T0flzwZAX4ce15Vcwd8zkq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=o68IUVm8FYQia8jA5qgA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbeDKQYv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:24:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753707AbeDKQYs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:24:48 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:24:45 +0100
Message-ID: <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Provide a single call to allow kernel code to determine whether the system
should be locked down, thereby disallowing various accesses that might
allow the running kernel image to be changed, including:

 - /dev/mem and similar
 - Loading of unauthorised modules
 - Fiddling with MSR registers
 - Suspend to disk managed by the kernel
 - Use of device DMA

Two kernel configuration options are provided:

 (*) CONFIG_LOCK_DOWN_KERNEL

     This makes lockdown available and applies it to all the points that
     need to be locked down if the mode is set.  Lockdown mode can be
     enabled by providing:

	lockdown=1

     on the command line.

 (*) CONFIG_LOCK_DOWN_MANDATORY

     This forces lockdown on at compile time, overriding the command line
     option.

init_lockdown() is used as a hook from which lockdown can be managed in
future.  It has to be called from arch setup code before things like ACPI
are enabled.

Note that, with the other changes in this series, if lockdown mode is
enabled, the kernel will not be able to use certain drivers as the ability
to manually configure hardware parameters would then be prohibited.  This
primarily applies to ISA hardware devices.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/kernel/setup.c |    2 +
 include/linux/kernel.h  |   32 +++++++++++++++++++++++
 security/Kconfig        |   23 ++++++++++++++++-
 security/Makefile       |    3 ++
 security/lock_down.c    |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 security/lock_down.c

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6285697b6e56..566f0f447053 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -996,6 +996,8 @@ void __init setup_arch(char **cmdline_p)
 	if (efi_enabled(EFI_BOOT))
 		efi_init();
 
+	init_lockdown();
+
 	dmi_scan_machine();
 	dmi_memdev_walk();
 	dmi_set_dump_stack_arch_desc();
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4ae1dfd9bf05..7d085cca9cee 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -306,6 +306,38 @@ static inline void refcount_error_report(struct pt_regs *regs, const char *err)
 { }
 #endif
 
+#ifdef CONFIG_LOCK_DOWN_KERNEL
+extern void __init init_lockdown(void);
+extern bool __kernel_is_locked_down(const char *what, bool first);
+
+#ifndef CONFIG_LOCK_DOWN_MANDATORY
+#define kernel_is_locked_down(what)					\
+	({								\
+		static bool message_given;				\
+		bool locked_down = __kernel_is_locked_down(what, !message_given); \
+		message_given = true;					\
+		locked_down;						\
+	})
+#else
+#define kernel_is_locked_down(what)					\
+	({								\
+		static bool message_given;				\
+		__kernel_is_locked_down(what, !message_given);		\
+		message_given = true;					\
+		true;							\
+	})
+#endif
+#else
+static inline void __init init_lockdown(void)
+{
+}
+static inline bool __kernel_is_locked_down(const char *what, bool first)
+{
+	return false;
+}
+#define kernel_is_locked_down(what) ({ false; })
+#endif
+
 /* Internal, do not use. */
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
diff --git a/security/Kconfig b/security/Kconfig
index c4302067a3ad..a68e5bdebad5 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -231,6 +231,28 @@ config STATIC_USERMODEHELPER_PATH
 	  If you wish for all usermode helper programs to be disabled,
 	  specify an empty string here (i.e. "").
 
+config LOCK_DOWN_KERNEL
+	bool "Allow the kernel to be 'locked down'"
+	help
+	  Allow the kernel to be locked down.  Locking down the kernel turns
+	  off various features that might otherwise allow access to the kernel
+	  image (eg. setting MSR registers).
+
+	  Note, however, that locking down your kernel will prevent some
+	  drivers from functioning because allowing manual configuration of
+	  hardware parameters is forbidden, lest a device be used to access the
+	  kernel by DMA.  This mostly applies to ISA devices.
+
+	  The kernel lockdown can be triggered by adding lockdown=1 to the
+	  kernel command line.
+
+config LOCK_DOWN_MANDATORY
+	bool "Make kernel lockdown mandatory"
+	depends on LOCK_DOWN_KERNEL
+	help
+	  Makes the lockdown non-negotiable.  It is always on and cannot be
+	  disabled.
+
 source security/selinux/Kconfig
 source security/smack/Kconfig
 source security/tomoyo/Kconfig
@@ -278,4 +300,3 @@ config DEFAULT_SECURITY
 	default "" if DEFAULT_SECURITY_DAC
 
 endmenu
-
diff --git a/security/Makefile b/security/Makefile
index 4d2d3782ddef..507ac8c520ce 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -30,3 +30,6 @@ obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
 obj-$(CONFIG_INTEGRITY)			+= integrity/
+
+# Allow the kernel to be locked down
+obj-$(CONFIG_LOCK_DOWN_KERNEL)		+= lock_down.o
diff --git a/security/lock_down.c b/security/lock_down.c
new file mode 100644
index 000000000000..f35ffdd096ad
--- /dev/null
+++ b/security/lock_down.c
@@ -0,0 +1,65 @@
+/* Lock down the kernel
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/export.h>
+#include <linux/sched.h>
+
+#ifndef CONFIG_LOCK_DOWN_MANDATORY
+static __ro_after_init bool kernel_locked_down;
+#else
+#define kernel_locked_down true
+#endif
+
+/*
+ * Put the kernel into lock-down mode.
+ */
+static void __init lock_kernel_down(const char *where)
+{
+#ifndef CONFIG_LOCK_DOWN_MANDATORY
+	if (!kernel_locked_down) {
+		kernel_locked_down = true;
+		pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
+			  where);
+	}
+#endif
+}
+
+static int __init lockdown_param(char *ignored)
+{
+	lock_kernel_down("command line");
+	return 0;
+}
+
+early_param("lockdown", lockdown_param);
+
+/*
+ * Lock the kernel down from very early in the arch setup.  This must happen
+ * prior to things like ACPI being initialised.
+ */
+void __init init_lockdown(void)
+{
+#ifdef CONFIG_LOCK_DOWN_MANDATORY
+	pr_notice("Kernel is locked down from config; see man kernel_lockdown.7\n");
+#endif
+}
+
+/**
+ * kernel_is_locked_down - Find out if the kernel is locked down
+ * @what: Tag to use in notice generated if lockdown is in effect
+ */
+bool __kernel_is_locked_down(const char *what, bool first)
+{
+	if (what && first && kernel_locked_down)
+		pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
+			  current->comm, what);
+	return kernel_locked_down;
+}
+EXPORT_SYMBOL(__kernel_is_locked_down);

