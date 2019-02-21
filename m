Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A11C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXqIaIZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfBUUiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:38:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37265 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:38:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so32090399wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nL8SAESRBsMnpTfph3O5RFNDPOs2txLnwyhdhusrV8c=;
        b=nXqIaIZ5vZp9zEy6IlWx5e6VLy1zru9GfnurKe6u019pMTYFRb2Yh7HZfM+swHbacy
         Y31A04vSe6ty62KX1dalAfa4qz1+vwIGv0dC6lwEGexMa/v7Qx8MZqkDVaJIS19zsRgs
         8VTbcJHOPFq/GdRq2KeoQHWOBHZoVV1RCVgr6nBAekV/yI49aSBbWKa9VK93UteCcnb0
         yk0Xumvx+so2mG3Am9WZhByYFDrdOUhwYjVpmFR87cajEpKn30C1bwFWetxf3Km9+RO6
         7opMd6sviU2WfG4OeuqdmFZjb0H4EOb+u8dK0pJ+ZsnB0PUXL6am7/yQn5U35Rt7FwA9
         qrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nL8SAESRBsMnpTfph3O5RFNDPOs2txLnwyhdhusrV8c=;
        b=CDgNYNxUt7HPUHukKu1ZviiDSfYeG0Uu/qFGCh7Tp1VcT74aKlMeV3MoaS9jI2RRDc
         j+zY9TRw9bRB6yR3wTjzLAe0MfJRIuZZwng1oC/xhX0UgA3GqbGN3rWABDbtoQg5k3Iy
         uQsxxWFE4DBZtL9luB418v5hXLNp7GlVdRPs7+JCtJceCEDbcg1RlfatCwZ1IGoAsvmT
         ka50Tdc75EPNHv5EEngRcGr8JCC7MHaWYUu9yglBNhKbVKqbNzPVKql6Y+ZXbsfM73Xz
         FtmzhSGQnsjkB0zBrRwx1pJWtzjlZFVEp5DVUfwLhCVrL+lfkAMU7xS4lUxWaWkC/k6h
         EJcA==
X-Gm-Message-State: AHQUAuYeV7MxNaH/XiH7xaMkKkqZ9Gt3/+4LmgXxRxEhbJ8tK+K8KK+H
        hVLLpKY+hLNvc8Sp/thQXDQ=
X-Google-Smtp-Source: AHgI3Ia4kQwjUGOEFoRJbqL9JZYsc9Z2DNo+HlR6Dpc3M7OOJjYjqNujMS/N4M0steTekhGABokXag==
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr260778wrs.252.1550781479857;
        Thu, 21 Feb 2019 12:37:59 -0800 (PST)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id l129sm6056714wml.42.2019.02.21.12.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 12:37:59 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     bp@alien8.de, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, graysky@archlinux.us,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH RFC 1/1] x86: adds additional CPU options
Date:   Thu, 21 Feb 2019 21:32:09 +0100
Message-Id: <20190221203209.16224-2-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190221203209.16224-1-clabbe.montjoie@gmail.com>
References: <20190221203209.16224-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds additional CPU options to the Linux kernel.
The expanded microarchitectures include:
* AMD Improved K8-family
* AMD K10-family
* AMD Family 10h (Barcelona)
* AMD Family 14h (Bobcat)
* AMD Family 16h (Jaguar)
* AMD Family 15h (Bulldozer)
* AMD Family 15h (Piledriver)
* AMD Family 15h (Steamroller)
* AMD Family 15h (Excavator)
* AMD Family 17h (Zen)
* Intel Silvermont low-power processors
* Intel 1st Gen Core i3/i5/i7 (Nehalem)
* Intel 1.5 Gen Core i3/i5/i7 (Westmere)
* Intel 2nd Gen Core i3/i5/i7 (Sandybridge)
* Intel 3rd Gen Core i3/i5/i7 (Ivybridge)
* Intel 4th Gen Core i3/i5/i7 (Haswell)
* Intel 5th Gen Core i3/i5/i7 (Broadwell)
* Intel 6th Gen Core i3/i5/i7 (Skylake)
* Intel 6th Gen Core i7/i9 (Skylake X)
* Intel 8th Gen Core i3/i5/i7 (Cannon Lake)
* Intel 8th Gen Core i7/i9 (Ice Lake)

Signed-off-by: John graysky <graysky@archlinux.us>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/x86/Kconfig.cpu          | 172 ++++++++++++++++++++++++++++++++--
 arch/x86/Makefile             |  21 +++++
 arch/x86/Makefile_32.cpu      |  21 +++++
 arch/x86/include/asm/module.h |  42 +++++++++
 4 files changed, 250 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6adce15268bd..b6b881b5a3ce 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -172,6 +172,77 @@ config MK8
 	  Enables use of some extended instructions, and passes appropriate
 	  optimization flags to GCC.
 
+config MK8SSE3
+	bool "AMD Opteron/Athlon64/Hammer/K8 with SSE3"
+	help
+	  Select this for improved AMD Opteron or Athlon64 Hammer-family processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MK10
+	bool "AMD 61xx/7x50/PhenomX3/X4/II/K10"
+	help
+	  Select this for an AMD 61xx Eight-Core Magny-Cours, Athlon X2 7x50,
+		Phenom X3/X4/II, Athlon II X2/X3/X4, or Turion II-family processor.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MBARCELONA
+	bool "AMD Barcelona"
+	help
+	  Select this for AMD Family 10h Barcelona processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MBOBCAT
+	bool "AMD Bobcat"
+	help
+	  Select this for AMD Family 14h Bobcat processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MJAGUAR
+	bool "AMD Jaguar"
+	help
+	  Select this for AMD Family 16h Jaguar processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MBULLDOZER
+	bool "AMD Bulldozer"
+	help
+	  Select this for AMD Family 15h Bulldozer processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MPILEDRIVER
+	bool "AMD Piledriver"
+	help
+	  Select this for AMD Family 15h Piledriver processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MSTEAMROLLER
+	bool "AMD Steamroller"
+	help
+	  Select this for AMD Family 15h Steamroller processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MEXCAVATOR
+	bool "AMD Excavator"
+	help
+	  Select this for AMD Family 15h Excavator processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MZEN
+	bool "AMD Zen"
+	help
+	  Select this for AMD Family 17h Zen processors.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
 config MCRUSOE
 	bool "Crusoe"
 	depends on X86_32
@@ -280,6 +351,95 @@ config MATOM
 	  accordingly optimized code. Use a recent GCC with specific Atom
 	  support in order to fully benefit from selecting this option.
 
+config MNEHALEM
+	bool "Intel Nehalem"
+	select X86_P6_NOP
+	help
+	  Select this for 1st Gen Core processors in the Nehalem family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MWESTMERE
+	bool "Intel Westmere"
+	select X86_P6_NOP
+	help
+	  Select this for the Intel Westmere formerly Nehalem-C family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MSILVERMONT
+	bool "Intel Silvermont"
+	select X86_P6_NOP
+	help
+	  Select this for the Intel Silvermont platform.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MSANDYBRIDGE
+	bool "Intel Sandy Bridge"
+	select X86_P6_NOP
+	help
+	  Select this for 2nd Gen Core processors in the Sandy Bridge family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MIVYBRIDGE
+	bool "Intel Ivy Bridge"
+	select X86_P6_NOP
+	help
+	  Select this for 3rd Gen Core processors in the Ivy Bridge family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MHASWELL
+	bool "Intel Haswell"
+	select X86_P6_NOP
+	help
+	  Select this for 4th Gen Core processors in the Haswell family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MBROADWELL
+	bool "Intel Broadwell"
+	select X86_P6_NOP
+	help
+	  Select this for 5th Gen Core processors in the Broadwell family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MSKYLAKE
+	bool "Intel Skylake"
+	select X86_P6_NOP
+	help
+	  Select this for 6th Gen Core processors in the Skylake family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MSKYLAKEX
+	bool "Intel Skylake X"
+	select X86_P6_NOP
+	help
+	  Select this for 6th Gen Core processors in the Skylake X family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MCANNONLAKE
+	bool "Intel Cannon Lake"
+	select X86_P6_NOP
+	help
+	  Select this for 8th Gen Core processors
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
+config MICELAKE
+	bool "Intel Ice Lake"
+	select X86_P6_NOP
+	select CC_MARCH_ICELAKE if GCC_VERSION > 70000
+	help
+	  Select this for 8th Gen Core processors in the Ice Lake family.
+	  Enables use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
 config GENERIC_CPU
 	bool "Generic-x86-64"
 	depends on X86_64
@@ -311,7 +471,7 @@ config X86_INTERNODE_CACHE_SHIFT
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || MPSC
-	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
+	default "6" if MK7 || MK8 || MK8SSE3 || MK10 || MBARCELONA || MBOBCAT || MBULLDOZER || MPILEDRIVER || MSTEAMROLLER || MEXCAVATOR || MZEN || MJAGUAR || MPENTIUMM || MCORE2 || MNEHALEM || MWESTMERE || MSILVERMONT || MSANDYBRIDGE || MIVYBRIDGE || MHASWELL || MBROADWELL || MSKYLAKE || MSKYLAKEX || MCANNONLAKE || MICELAKE || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
 	default "4" if MELAN || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
@@ -329,11 +489,11 @@ config X86_ALIGNMENT_16
 
 config X86_INTEL_USERCOPY
 	def_bool y
-	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2
+	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK8SSE3 || MK7 || MEFFICEON || MCORE2 || MK10 || MBARCELONA || MNEHALEM || MWESTMERE || MSILVERMONT || MSANDYBRIDGE || MIVYBRIDGE || MHASWELL || MBROADWELL || MSKYLAKE || MSKYLAKEX || MCANNONLAKE || MICELAKE
 
 config X86_USE_PPRO_CHECKSUM
 	def_bool y
-	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM
+	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MK10 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MK8SSE3 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MNEHALEM || MWESTMERE || MSILVERMONT || MSANDYBRIDGE || MIVYBRIDGE || MHASWELL || MBROADWELL || MSKYLAKE || MSKYLAKEX || MCANNONLAKE || MICELAKE || MATOM
 
 config X86_USE_3DNOW
 	def_bool y
@@ -353,11 +513,11 @@ config X86_USE_3DNOW
 config X86_P6_NOP
 	def_bool y
 	depends on X86_64
-	depends on (MCORE2 || MPENTIUM4 || MPSC)
+	depends on (MCORE2 || MPENTIUM4 || MPSC || MNEHALEM || MWESTMERE || MSILVERMONT  || MSANDYBRIDGE || MIVYBRIDGE || MHASWELL || MBROADWELL || MSKYLAKE || MSKYLAKEX || MCANNONLAKE || MICELAKE)
 
 config X86_TSC
 	def_bool y
-	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64
+	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MK8SSE3 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MNEHALEM || MWESTMERE || MSILVERMONT || MSANDYBRIDGE || MIVYBRIDGE || MHASWELL || MBROADWELL || MSKYLAKE || MSKYLAKEX || MCANNONLAKE || MICELAKE || MATOM) || X86_64
 
 config X86_CMPXCHG64
 	def_bool y
@@ -367,7 +527,7 @@ config X86_CMPXCHG64
 # generates cmov.
 config X86_CMOV
 	def_bool y
-	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
+	depends on (MK8 || MK8SSE3 || MK10 || MBARCELONA || MBOBCAT || MBULLDOZER || MPILEDRIVER || MSTEAMROLLER || MEXCAVATOR || MZEN || MJAGUAR || MK7 || MCORE2 || MNEHALEM || MWESTMERE || MSILVERMONT || MSANDYBRIDGE || MIVYBRIDGE || MHASWELL || MBROADWELL || MSKYLAKE || MSKYLAKEX || MCANNONLAKE || MICELAKE || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
 
 config X86_MINIMUM_CPU_FAMILY
 	int
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 76bc4dc03d5e..c0ac60f7e0a2 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -119,12 +119,33 @@ else
 
         # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
         cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
+        cflags-$(CONFIG_MK8SSE3) += $(call cc-option,-march=k8-sse3,-mtune=k8)
+        cflags-$(CONFIG_MK10) += $(call cc-option,-march=amdfam10)
+        cflags-$(CONFIG_MBARCELONA) += $(call cc-option,-march=barcelona)
+        cflags-$(CONFIG_MBOBCAT) += $(call cc-option,-march=btver1)
+        cflags-$(CONFIG_MJAGUAR) += $(call cc-option,-march=btver2)
+        cflags-$(CONFIG_MBULLDOZER) += $(call cc-option,-march=bdver1)
+        cflags-$(CONFIG_MPILEDRIVER) += $(call cc-option,-march=bdver2)
+        cflags-$(CONFIG_MSTEAMROLLER) += $(call cc-option,-march=bdver3)
+        cflags-$(CONFIG_MEXCAVATOR) += $(call cc-option,-march=bdver4)
+        cflags-$(CONFIG_MZEN) += $(call cc-option,-march=znver1)
         cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
 
         cflags-$(CONFIG_MCORE2) += \
                 $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
 	cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
 		$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
+        cflags-$(CONFIG_MNEHALEM) += $(call cc-option,-march=nehalem,$(call cc-option,-mtune=nehalem))
+        cflags-$(CONFIG_MWESTMERE) += $(call cc-option,-march=westmere,$(call cc-option,-mtune=westmere))
+        cflags-$(CONFIG_MSILVERMONT) += $(call cc-option,-march=silvermont,$(call cc-option,-mtune=silvermont))
+        cflags-$(CONFIG_MSANDYBRIDGE) += $(call cc-option,-march=sandybridge,$(call cc-option,-mtune=sandybridge))
+        cflags-$(CONFIG_MIVYBRIDGE) += $(call cc-option,-march=ivybridge,$(call cc-option,-mtune=ivybridge))
+        cflags-$(CONFIG_MHASWELL) += $(call cc-option,-march=haswell,$(call cc-option,-mtune=haswell))
+        cflags-$(CONFIG_MBROADWELL) += $(call cc-option,-march=broadwell,$(call cc-option,-mtune=broadwell))
+        cflags-$(CONFIG_MSKYLAKE) += $(call cc-option,-march=skylake,$(call cc-option,-mtune=skylake))
+        cflags-$(CONFIG_MSKYLAKEX) += $(call cc-option,-march=skylake-avx512,$(call cc-option,-mtune=skylake-avx512))
+        cflags-$(CONFIG_MCANNONLAKE) += $(call cc-option,-march=cannonlake,$(call cc-option,-mtune=cannonlake))
+        cflags-$(CONFIG_MICELAKE) += $(call cc-option,-march=icelake,$(call cc-option,-mtune=icelake))
         cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
         KBUILD_CFLAGS += $(cflags-y)
 
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index 1f5faf8606b4..fb13e6a131d5 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -24,6 +24,16 @@ cflags-$(CONFIG_MK6)		+= -march=k6
 # They make zero difference whatsosever to performance at this time.
 cflags-$(CONFIG_MK7)		+= -march=athlon
 cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,-march=athlon)
+cflags-$(CONFIG_MK8SSE3)		+= $(call cc-option,-march=k8-sse3,-march=athlon)
+cflags-$(CONFIG_MK10)	+= $(call cc-option,-march=amdfam10,-march=athlon)
+cflags-$(CONFIG_MBARCELONA)	+= $(call cc-option,-march=barcelona,-march=athlon)
+cflags-$(CONFIG_MBOBCAT)	+= $(call cc-option,-march=btver1,-march=athlon)
+cflags-$(CONFIG_MJAGUAR)	+= $(call cc-option,-march=btver2,-march=athlon)
+cflags-$(CONFIG_MBULLDOZER)	+= $(call cc-option,-march=bdver1,-march=athlon)
+cflags-$(CONFIG_MPILEDRIVER)	+= $(call cc-option,-march=bdver2,-march=athlon)
+cflags-$(CONFIG_MSTEAMROLLER)	+= $(call cc-option,-march=bdver3,-march=athlon)
+cflags-$(CONFIG_MEXCAVATOR)	+= $(call cc-option,-march=bdver4,-march=athlon)
+cflags-$(CONFIG_MZEN)		+= $(call cc-option,-march=znver1,-march=athlon)
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 -falign-functions=0 -falign-jumps=0 -falign-loops=0
 cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call tune,pentium3) -falign-functions=0 -falign-jumps=0 -falign-loops=0
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
@@ -34,6 +44,17 @@ cflags-$(CONFIG_MVIAC7)		+= -march=i686
 cflags-$(CONFIG_MCORE2)		+= -march=i686 $(call tune,core2)
 cflags-$(CONFIG_MATOM)		+= $(call cc-option,-march=atom,$(call cc-option,-march=core2,-march=i686)) \
 	$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
+cflags-$(CONFIG_MNEHALEM)	+= -march=i686 $(call tune,nehalem)
+cflags-$(CONFIG_MWESTMERE)	+= -march=i686 $(call tune,westmere)
+cflags-$(CONFIG_MSILVERMONT)	+= -march=i686 $(call tune,silvermont)
+cflags-$(CONFIG_MSANDYBRIDGE)	+= -march=i686 $(call tune,sandybridge)
+cflags-$(CONFIG_MIVYBRIDGE)	+= -march=i686 $(call tune,ivybridge)
+cflags-$(CONFIG_MHASWELL)	+= -march=i686 $(call tune,haswell)
+cflags-$(CONFIG_MBROADWELL)	+= -march=i686 $(call tune,broadwell)
+cflags-$(CONFIG_MSKYLAKE)	+= -march=i686 $(call tune,skylake)
+cflags-$(CONFIG_MSKYLAKEX)	+= -march=i686 $(call tune,skylake-avx512)
+cflags-$(CONFIG_MCANNONLAKE)	+= -march=i686 $(call tune,cannonlake)
+cflags-$(CONFIG_MICELAKE)	+= -march=i686 $(call tune,icelake)
 
 # AMD Elan support
 cflags-$(CONFIG_MELAN)		+= -march=i486
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 7948a17febb4..dc7be6f7df78 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -25,6 +25,28 @@ struct mod_arch_specific {
 #define MODULE_PROC_FAMILY "586MMX "
 #elif defined CONFIG_MCORE2
 #define MODULE_PROC_FAMILY "CORE2 "
+#elif defined CONFIG_MNEHALEM
+#define MODULE_PROC_FAMILY "NEHALEM "
+#elif defined CONFIG_MWESTMERE
+#define MODULE_PROC_FAMILY "WESTMERE "
+#elif defined CONFIG_MSILVERMONT
+#define MODULE_PROC_FAMILY "SILVERMONT "
+#elif defined CONFIG_MSANDYBRIDGE
+#define MODULE_PROC_FAMILY "SANDYBRIDGE "
+#elif defined CONFIG_MIVYBRIDGE
+#define MODULE_PROC_FAMILY "IVYBRIDGE "
+#elif defined CONFIG_MHASWELL
+#define MODULE_PROC_FAMILY "HASWELL "
+#elif defined CONFIG_MBROADWELL
+#define MODULE_PROC_FAMILY "BROADWELL "
+#elif defined CONFIG_MSKYLAKE
+#define MODULE_PROC_FAMILY "SKYLAKE "
+#elif defined CONFIG_MSKYLAKEX
+#define MODULE_PROC_FAMILY "SKYLAKEX "
+#elif defined CONFIG_MCANNONLAKE
+#define MODULE_PROC_FAMILY "CANNONLAKE "
+#elif defined CONFIG_MICELAKE
+#define MODULE_PROC_FAMILY "ICELAKE "
 #elif defined CONFIG_MATOM
 #define MODULE_PROC_FAMILY "ATOM "
 #elif defined CONFIG_M686
@@ -43,6 +65,26 @@ struct mod_arch_specific {
 #define MODULE_PROC_FAMILY "K7 "
 #elif defined CONFIG_MK8
 #define MODULE_PROC_FAMILY "K8 "
+#elif defined CONFIG_MK8SSE3
+#define MODULE_PROC_FAMILY "K8SSE3 "
+#elif defined CONFIG_MK10
+#define MODULE_PROC_FAMILY "K10 "
+#elif defined CONFIG_MBARCELONA
+#define MODULE_PROC_FAMILY "BARCELONA "
+#elif defined CONFIG_MBOBCAT
+#define MODULE_PROC_FAMILY "BOBCAT "
+#elif defined CONFIG_MBULLDOZER
+#define MODULE_PROC_FAMILY "BULLDOZER "
+#elif defined CONFIG_MPILEDRIVER
+#define MODULE_PROC_FAMILY "PILEDRIVER "
+#elif defined CONFIG_MSTEAMROLLER
+#define MODULE_PROC_FAMILY "STEAMROLLER "
+#elif defined CONFIG_MJAGUAR
+#define MODULE_PROC_FAMILY "JAGUAR "
+#elif defined CONFIG_MEXCAVATOR
+#define MODULE_PROC_FAMILY "EXCAVATOR "
+#elif defined CONFIG_MZEN
+#define MODULE_PROC_FAMILY "ZEN "
 #elif defined CONFIG_MELAN
 #define MODULE_PROC_FAMILY "ELAN "
 #elif defined CONFIG_MCRUSOE
-- 
2.19.2

