Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156023-2-4357616578119976452
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156023; b=NmNZVqA4rK0W60+3Flp9giONTjxgM6Ki0FjDu3BTm5xgHwGuPb
    XlDT9DDpUbjEXOGK2o1fOkm4tUDB7HHCJe17zX9+alXeqPLNOWM57lu+aKOEMFhH
    QyVLd7cZUIqW3yov8QOPRjwPlup0MCh6dVQZeGm9zgEyivdfTuHXystbMUgpR2sV
    XrXJyyOKAE3xmUsbyKRSgN1MTcYOPv7u0PV3mUh3zW67qosJ/UR9x5b8cK3XBGmu
    Q3izz2CJM8YWmcrUFDsWQ8OIKTn6UMcytkNVq+0S3BOQ6BGK4Kr2ZKhbl+4NPV+x
    4wzVmX8UWp40e8WRLrOig94SufDaMK75ZMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1527156023; bh=wS3p0Z8KgMLIDuM1HjwHAgHHP00IvGX4st6UJylqGFk=; b=m
    L/uPbYRF30DSSe8ydsClRD9z5ZlV/aLvmu17gwBdCdU8coCB6OPIti6lXal52QcZ
    PAxg9d5AUM8oe3TA7pOBJyZUUNJNEg0BmKJHYBVWsAvIrnLDtJ6n5rQQvqTeXO2b
    nRYsi2BflZLDivLxIEJaihT4wo5hId/a0J9yHxkiaZbaPYjYLoqBpBOYobvXMe+d
    8L4DDXYsGMsDBIwKGvd3ix/SfCftnqlcvAK5vkXZVOTWYmagqWxsS3qV8552g/Cv
    74C0bvozlyHa2G9AdXTwRgdirKmQdXCVYR6Oa3QIXPoo1wlG2yskxmZHHeWlSJ+o
    aTJaFwwnPeoCQ39ibdyLQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cuI6+lGO x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=pass
    smtp.mailfrom="SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org"
    smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=cuI6+lGO x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=pass
      smtp.mailfrom="SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org"
      smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD7CakzK9yOJDMyYL7QVDhmXPgpCgV0tMJYQyZzHju+kKdgT6L8S2OpqDfcQ6PFrsUaAZmdyAdXWRi3AhzSEVkbVz62mg+ay1dg8bfOhBGq40JsFf8KU
    H+lrG0q9UTfbfK+PjiCIZ2Y5UaHOgLidSFT9x5Drabchtf21x1LLdHGkn5+b+W77LwyAL78PSf9uNbrbcxrsovlEYi1pUt+A48vP+slWWZT0XHBVW0uGid9a
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=-wGGl4kPVjDBqCk0VSkA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 036/161] powerpc: Add security feature flags for Spectre/Meltdown
Date: Thu, 24 May 2018 11:37:41 +0200
Message-Id: <20180524093022.671526012@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 9a868f634349e62922c226834aa23e3d1329ae7f upstream.

This commit adds security feature flags to reflect the settings we
receive from firmware regarding Spectre/Meltdown mitigations.

The feature names reflect the names we are given by firmware on bare
metal machines. See the hostboot source for details.

Arguably these could be firmware features, but that then requires them
to be read early in boot so they're available prior to asm feature
patching, but we don't actually want to use them for patching. We may
also want to dynamically update them in future, which would be
incompatible with the way firmware features work (at the moment at
least). So for now just make them separate flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/security_features.h |   65 +++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile                 |    2 
 arch/powerpc/kernel/security.c               |   15 ++++++
 3 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/security_features.h
 create mode 100644 arch/powerpc/kernel/security.c

--- /dev/null
+++ b/arch/powerpc/include/asm/security_features.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Security related feature bit definitions.
+ *
+ * Copyright 2018, Michael Ellerman, IBM Corporation.
+ */
+
+#ifndef _ASM_POWERPC_SECURITY_FEATURES_H
+#define _ASM_POWERPC_SECURITY_FEATURES_H
+
+
+extern unsigned long powerpc_security_features;
+
+static inline void security_ftr_set(unsigned long feature)
+{
+	powerpc_security_features |= feature;
+}
+
+static inline void security_ftr_clear(unsigned long feature)
+{
+	powerpc_security_features &= ~feature;
+}
+
+static inline bool security_ftr_enabled(unsigned long feature)
+{
+	return !!(powerpc_security_features & feature);
+}
+
+
+// Features indicating support for Spectre/Meltdown mitigations
+
+// The L1-D cache can be flushed with ori r30,r30,0
+#define SEC_FTR_L1D_FLUSH_ORI30		0x0000000000000001ull
+
+// The L1-D cache can be flushed with mtspr 882,r0 (aka SPRN_TRIG2)
+#define SEC_FTR_L1D_FLUSH_TRIG2		0x0000000000000002ull
+
+// ori r31,r31,0 acts as a speculation barrier
+#define SEC_FTR_SPEC_BAR_ORI31		0x0000000000000004ull
+
+// Speculation past bctr is disabled
+#define SEC_FTR_BCCTRL_SERIALISED	0x0000000000000008ull
+
+// Entries in L1-D are private to a SMT thread
+#define SEC_FTR_L1D_THREAD_PRIV		0x0000000000000010ull
+
+// Indirect branch prediction cache disabled
+#define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
+
+
+// Features indicating need for Spectre/Meltdown mitigations
+
+// The L1-D cache should be flushed on MSR[HV] 1->0 transition (hypervisor to guest)
+#define SEC_FTR_L1D_FLUSH_HV		0x0000000000000040ull
+
+// The L1-D cache should be flushed on MSR[PR] 0->1 transition (kernel to userspace)
+#define SEC_FTR_L1D_FLUSH_PR		0x0000000000000080ull
+
+// A speculation barrier should be used for bounds checks (Spectre variant 1)
+#define SEC_FTR_BNDS_CHK_SPEC_BAR	0x0000000000000100ull
+
+// Firmware configuration indicates user favours security over performance
+#define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
+
+#endif /* _ASM_POWERPC_SECURITY_FEATURES_H */
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
--- /dev/null
+++ b/arch/powerpc/kernel/security.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Security related flags and so on.
+//
+// Copyright 2018, Michael Ellerman, IBM Corporation.
+
+#include <linux/kernel.h>
+#include <asm/security_features.h>
+
+
+unsigned long powerpc_security_features __read_mostly = \
+	SEC_FTR_L1D_FLUSH_HV | \
+	SEC_FTR_L1D_FLUSH_PR | \
+	SEC_FTR_BNDS_CHK_SPEC_BAR | \
+	SEC_FTR_FAVOUR_SECURITY;
