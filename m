Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3946214-1519035398-5-15110349991032543522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035398; b=BaoufWaDHqyKdcQey869snfqBhOsg6y+xlPtauF9iPESMyg
    W5AoUmMwck/x3onI5QGPf6b2GTNNRa5GSf0Eh/9mryW9yOdCGnkPRWl0cmoo98Xm
    5fvAJaG5rSe0vQkTz8xy2BeHaZGX3U724HieLqb6VEt/FLlQQywzgIefhmN6HZ9X
    D8aQcdY2FfmkUkNybUmqTT6vuyW8QHsTKxvBCcC65hICo5+yWwOsQrbLXHXz4m/Q
    qmFHNYnl12CvzV3foLcMy0nJQtfActw2h3YLJmHsA+mhbMWuMLhXrxNGzyHmnvPX
    FEDp12yjssNDiyR/PnEhJl4KM1vMEj9j6j+H5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519035398;
    bh=nr/V/84qE3Z7Whwe/1sJ5eyuP/Dt1mMoL21+CP2eVVk=; b=LCWxFYS+NPnK
    TEHa5P6KKy1hLqVD+785SIOaQWXCd/wR9FrAam5ZZ22ROeEqrFl93efts8u5QitV
    ORXAW937g7lysiDqnHZogVp5jvtO+yPfofbHDQp0DLHu3ka/YMCU17p6uHIvz6Ew
    Q4c5launtaJzrNv8MSyQ2NLjse0yZpGCtdadfuoIvsm9scAWfD2SbpCw4JkWxtOL
    aqclJrbPetITUcSo4+D/XmA6kNtl56V3hZgBXckUu9aJTVu7spsowAkdAclvk1Jv
    33D08a0DluY0z/t1GGtBU+/nq6Jg4oIjsoaRdBh2nodMiI8kchPoanbXt6dCGNUZ
    g7DdWFmkgg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeBSKOl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:14:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:53127 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752474AbeBSKOj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Feb 2018 05:14:39 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, x86@kernel.org
Cc: rafael.j.wysocki@intel.com, lenb@kernel.org,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 2/3] x86/acpi: add a new x86_init_acpi structure to x86_init_ops
Date: Mon, 19 Feb 2018 11:09:05 +0100
Message-Id: <20180219100906.14265-3-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180219100906.14265-1-jgross@suse.com>
References: <20180219100906.14265-1-jgross@suse.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a new struct x86_init_acpi to x86_init_ops. For now it contains
only one init function to get the RSDP table address.

Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/acpi.h     | 7 +++++++
 arch/x86/include/asm/x86_init.h | 9 +++++++++
 arch/x86/kernel/x86_init.c      | 5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 11881726ed37..6609dd7289b5 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -31,6 +31,7 @@
 #include <asm/mmu.h>
 #include <asm/mpspec.h>
 #include <asm/realmode.h>
+#include <asm/x86_init.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -133,6 +134,12 @@ static inline bool acpi_has_cpu_in_madt(void)
 	return !!acpi_lapic;
 }
 
+#define ACPI_HAVE_ARCH_GET_ROOT_POINTER
+static inline u64 acpi_arch_get_root_pointer(void)
+{
+	return x86_init.acpi.get_root_pointer();
+}
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index fc2f082ac635..2e2c34d2bb00 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -131,6 +131,14 @@ struct x86_hyper_init {
 };
 
 /**
+ * struct x86_init_acpi - x86 ACPI init functions
+ * @get_root_pointer:		get RSDP address
+ */
+struct x86_init_acpi {
+	u64 (*get_root_pointer)(void);
+};
+
+/**
  * struct x86_init_ops - functions for platform specific setup
  *
  */
@@ -144,6 +152,7 @@ struct x86_init_ops {
 	struct x86_init_iommu		iommu;
 	struct x86_init_pci		pci;
 	struct x86_hyper_init		hyper;
+	struct x86_init_acpi		acpi;
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1151ccd72ce9..9e4e994a4836 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -30,6 +30,7 @@ int __init iommu_init_noop(void) { return 0; }
 void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
+u64 u64_x86_init_noop(void) { return 0; }
 
 /*
  * The platform setup functions are preset with the default functions
@@ -91,6 +92,10 @@ struct x86_init_ops x86_init __initdata = {
 		.x2apic_available	= bool_x86_init_noop,
 		.init_mem_mapping	= x86_init_noop,
 	},
+
+	.acpi = {
+		.get_root_pointer	= u64_x86_init_noop,
+	},
 };
 
 struct x86_cpuinit_ops x86_cpuinit = {
-- 
2.13.6
