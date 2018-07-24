Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A5FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1D820875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1D820875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbeGXK4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:56:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41720 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGXK4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:56:36 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MbtgI-1fOZqu1l6U-00JH3X; Tue, 24 Jul 2018 11:50:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Will Deacon <will.deacon@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] [SUBMITTED 20180724] arm64: fix ACPI dependencies
Date:   Tue, 24 Jul 2018 11:48:45 +0200
Message-Id: <20180724094957.1967541-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:yfLeV5ksPZGStHZPAZnTLlx/uNVqewNHwK+Q0iYxCKPZallPThV
 7GacXVPYOVy1Ck+ef4m7MgnZ/VllpZrdugDgFWgGHjL60uOBci0p3RbDkfUjvqwJ+Sk23nD
 2r4uVYTIBtGrC2nu1VLeK88ynJ58c+JT9fnUsx+bE+DuJuE5rI2WXG20h/V8rFPP1cSZ/bK
 hymY+8fSIn8oLJv9vEUiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nWCLyOBv998=:n4eks7N3+ELf/E9vKhWJW5
 2YuMQj0uyPrqWBn7nj3Huis5RFuc+nAcEA2nbaoSnVa2amYK0oc2RPD1fQKVP+9AOOEknOwQ0
 EqIAULhkYVKjNlqDPdIhowPyvwGOiZYJX+llaZBhaceFtIEOjsUZFgXbuzFnj7HNNkPX4VfxN
 pBDGEYA3HhjYJBhB8FhERFENXeQ3cTOplJoa76h2rViQtOdXpMtBEL+fqDxXsdLOK525Z3iW1
 GTGD657Bz8hrufJngRnlL18C9kCxOQ0Cn5M4dXLFwCniGwe6Nd4Veb/tFEcF5X+Wt2bCJnGGc
 E7LVz2K+34g5IztomsDzIvG47tQD5OmTZ+r72WR5S29/8h2QLRhAWOJKjkG9GsdcZEVFbCbyl
 pOWSBeXaJ7CBC7cg8ECNSOdEEXg13FSakbAZDMjExCgzwOuxqpbRCrTaQOCLdRE9gsR7Q9Wod
 AjOCO0lLW1Sgx0aIEI/QOFQ4QYK2ZjXvKPAAqrFotWmohom6YeRGLVLFSoad3QiJzM0UuNlqN
 FkJoPr/CNzCA3KOovZ0gHC8fY/3yNs5+MLA1LWPWNh0sNuQ+xPErqzjtoj8PHBQm0J4ky3Cn2
 8tzM5As8JZGBA7BLGpSSNWrg/ZPOVO9Mdsh/6pPgNGlEnZEBF3p2FH/SHlja6y9/mt007f3Ix
 6hDmkvT4CckpXp+Pt8C9v89exq4cNIBYnGvK9/jpy7nni4jyPIkH06wBkqvmG7okkd8Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig reports a warning on x86 builds after the ARM64 dependency
was added.

drivers/acpi/Kconfig:6:error: recursive dependency detected!
drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI

This rephrases the dependency to keep the ARM64 details out of the
shared Kconfig file, so Kconfig no longer gets confused by it.

For consistency, all three architectures that support ACPI now
select ARCH_SUPPORTS_ACPI in exactly the configuration in which
they allow it. We still need the 'default x86', as each one
wants a different default: default-y on x86, default-n on arm64,
and always-y on ia64.

Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use 'select ARCH_SUPPORTS_ACPI' for all three.
---
 arch/arm64/Kconfig   | 1 +
 arch/ia64/Kconfig    | 1 +
 arch/x86/Kconfig     | 1 +
 drivers/acpi/Kconfig | 8 +++++---
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cdcaa6a798b2..2f987a938405 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1267,6 +1267,7 @@ config EFI
 	bool "UEFI runtime support"
 	depends on OF && !CPU_BIG_ENDIAN
 	depends on KERNEL_MODE_NEON
+	select ARCH_SUPPORTS_ACPI
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index ff861420b8f5..02eb68d5d1c0 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -16,6 +16,7 @@ config IA64
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select PCI if (!IA64_HP_SIM)
 	select ACPI if (!IA64_HP_SIM)
+	select ARCH_SUPPORTS_ACPI if (!IA64_HP_SIM)
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 088b719bc5d1..442575220708 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -76,6 +76,7 @@ config X86
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a8da730fabc6..1edca05ee0ae 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -5,11 +5,10 @@
 
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
-	depends on !IA64_HP_SIM
-	depends on IA64 || X86 || (ARM64 && EFI)
+	depends on ARCH_SUPPORTS_ACPI
 	depends on PCI
 	select PNP
-	default y if (IA64 || X86)
+	default y if X86
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
 	  Linux requires an ACPI-compliant platform (hardware/firmware),
@@ -41,6 +40,9 @@ menuconfig ACPI
 	  <http://www.acpi.info>
 	  <http://www.uefi.org/acpi/specs>
 
+config ARCH_SUPPORTS_ACPI
+	bool
+
 if ACPI
 
 config ACPI_LEGACY_TABLES_LOOKUP
-- 
2.18.0

