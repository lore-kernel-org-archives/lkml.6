Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3066AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD42A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD42A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbeGXKju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:39:50 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbeGXKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:39:50 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LiKeS-1gI4Sh1oz6-00cepX; Tue, 24 Jul 2018 11:33:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] arm64: fix ACPI dependencies
Date:   Tue, 24 Jul 2018 11:33:17 +0200
Message-Id: <20180724093345.1575921-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:lxUzFc7sR6yJC32kpT3pWzkuxp+Kyt5K+PKKQcF8zJ5bA6wpgPH
 YQOM/DtKd7TApN0sZvpeUx564o91EBzKfX2e0wv5xGp8sHOZmjWEgpa8WuWhfeDoYUoEemm
 iwAZwEXquUeKlmN75RjaxgrFaUzeI3dUqEsygWSWIqIX9Fnmr3jWR9r8HV1RD9k8KP1RSEQ
 UufECWIYrtqFs5d04ffpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EZq7+gkXU30=:lu94alJQnJCA9XUAxdZwxY
 3nBvpbJ3HHNauWUjem7I2PPrkeJnMWcFK0BMewO2bgldh2EML7b6OlaStlM/HS0NepNs0v7o3
 qV7nP6xkbID/S1JBMr4cereschpIW72UVeWf1xn8N/p6OL5QC3PKpf74MitoryPbifWPDg8tX
 X2tbnq0IMOlAAkSKD6jQT7rCf7JE/9JJRrKqJx/lAF/JJauSOabr9iCQkQycipfRwYmWlCtlm
 yU1+6d3N0vVbQwF7MLvbPULqXHukQaQgV6cIB/a75jqc+sTnZbSZslJA5NUZWFG6yeKKx/UvB
 KW63rnnawIXutkWH9iI55ODQN7KA+LAuNFKm3xFZxH5Ly5Ywhud/U4yyofLAUt4UbkqqIs3tQ
 EJ/s2VH7QuUhP4Al18TcVw21qW+zY3GY2CKcATbnt6ltOdhbRI/JISzxFNrwrnp70ter6tlsG
 ojFbd+JnPDrUZiIa9Ch47Te/DEXd+mKUsHD8P1EIz0+JptJr/9PEJTxr/49PD3uNk5MGpABBR
 f+zGAfrVI6+oWaLQuHiTjt7AbWCewK6wBtcZW7Es+2JRMtw1eZuu9yf/+CYjVXQH1xmsDnrzG
 Ho/OVdVZB9DEe/lOyLvlwPyWuw/eiZvDMXs8bOh7bT2SCHdFZ0CheZLlWLi15FDYGykQjEr6v
 ZS7WzyHPlk8aQI045DdeP0LVemiwQX8okul9J6CwB4ErEufcOtuOz9Wt9T1yYShmDTfw=
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

Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig   | 1 +
 drivers/acpi/Kconfig | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

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
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a8da730fabc6..0cda51c5d433 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,7 +6,7 @@
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
-	depends on IA64 || X86 || (ARM64 && EFI)
+	depends on IA64 || X86 || ARCH_SUPPORTS_ACPI
 	depends on PCI
 	select PNP
 	default y if (IA64 || X86)
@@ -41,6 +41,9 @@ menuconfig ACPI
 	  <http://www.acpi.info>
 	  <http://www.uefi.org/acpi/specs>
 
+config ARCH_SUPPORTS_ACPI
+	bool
+
 if ACPI
 
 config ACPI_LEGACY_TABLES_LOOKUP
-- 
2.18.0

