Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C29C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6449420861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o825X0Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfAWJtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:49:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34990 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfAWJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:49:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so1636516wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WanBfBzvP4zWYdNvWYtJpyZTLa6UIN3ia9lgab3lo+4=;
        b=o825X0Mkf1+UK/QgoNZokfbqzrFaT4DLFB87qdEEw4TD3cQQbChk4nTHGZhHy2awxS
         5SpDkZSpUAb+E0OAzCDkmSM5XPq/d6Yalvbv5fmQX+mC4TJ2DRqDThs7eh0fcdEBxwjo
         NSm2gPvzbOWrMmaupuye6aQyAcRF+436gwS0EzmJ40gLgeAszKpTshULjH+503wVK0oO
         vf9GSmG0hzqLt7knEdVqmKoOxfsesqm/FhEC0kHzKdo66kHpHAPCq4Fr4kHc/GvkB4H+
         M0gFRnWPIZL8Dw97qJrJ5bv70L5YrpbuwiU42fNJs7kDWQOY6RzFhV4/SPIrMWv1As+b
         eHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WanBfBzvP4zWYdNvWYtJpyZTLa6UIN3ia9lgab3lo+4=;
        b=QMqiUde1k/EE6XkbgV8JrIgTxGMBLrm2kpYnD6Z5VaVWFaidezaFDHA59lsVJAQXQk
         DplctScZrQjAFfw2nl8hH3weAS0N7bX7y0Rutrs6tXpEuyDjiaSaBA+RFaXc25emTAAF
         U1AaAnNKy8f/GhjsHv5uGhpbKXBT+mS/2UPy1tDj6Snq3OyH/tDMXLL6q4sjRvNETSSH
         Pg0zO84ND6crottgWcS06N+185PZvnV9BvDy4ImeeiraWyAH0BNHwZvWFWTWpBmRa93+
         CranLgLl35Z99MQe/QbBN7fy4nnbuXcMzyCW62aFzRmk19rPX4JeA562QVsTFQzQoWZx
         MRJw==
X-Gm-Message-State: AJcUukfaSPE891NpTM4arw9T2cCN31I8/CeC7e5cq5ibIX8TY9lMYfr1
        K/JAZ7sNWe12stb6M3s37iTWg7vPXl4=
X-Google-Smtp-Source: ALg8bN7OGyg9Z5eCDIWoPZdkADz6KswGU60vCTeZvrikGj8F0IAlf3W/1fwjQLJ5VlS0gw/UDaeWQA==
X-Received: by 2002:adf:9542:: with SMTP id 60mr1831558wrs.60.1548236977475;
        Wed, 23 Jan 2019 01:49:37 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x186sm73019120wmg.41.2019.01.23.01.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 01:49:36 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com, mark.rutland@arm.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] xtensa: rename BUILTIN_DTB to BUILTIN_DTB_SOURCE
Date:   Wed, 23 Jan 2019 09:49:18 +0000
Message-Id: <1548236958-17565-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building some xtensa config, I hit the following warning:
drivers/staging/mt7621-dts/Kconfig:4:warning: 'BUILTIN_DTB' has wrong type. 'select' only accept arguments of bool and tristate type

It is due to some arch use BUILTIN_DTB as a flag for the need to builtin
dtb but xtensa use it as a string for which dtb to bulltin.
But for this (which dtb to build), it is better to use
BUILTIN_DTB_SOURCE like other arch do.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/xtensa/Kconfig                         | 2 +-
 arch/xtensa/boot/dts/Makefile               | 6 +++---
 arch/xtensa/configs/audio_kc705_defconfig   | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig   | 2 +-
 arch/xtensa/configs/generic_kc705_defconfig | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig   | 2 +-
 arch/xtensa/configs/smp_lx200_defconfig     | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 48906ac5fd25..ce91682770cb 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -451,7 +451,7 @@ config USE_OF
 	help
 	  Include support for flattened device tree machine descriptions.
 
-config BUILTIN_DTB
+config BUILTIN_DTB_SOURCE
 	string "DTB to build into the kernel image"
 	depends on OF
 
diff --git a/arch/xtensa/boot/dts/Makefile b/arch/xtensa/boot/dts/Makefile
index f8052ba5aea8..0b8d00cdae7c 100644
--- a/arch/xtensa/boot/dts/Makefile
+++ b/arch/xtensa/boot/dts/Makefile
@@ -7,9 +7,9 @@
 #
 #
 
-BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_BUILTIN_DTB)).dtb.o
-ifneq ($(CONFIG_BUILTIN_DTB),"")
-obj-$(CONFIG_OF) += $(BUILTIN_DTB)
+BUILTIN_DTB_SOURCE := $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
+ifneq ($(CONFIG_BUILTIN_DTB_SOURCE),"")
+obj-$(CONFIG_OF) += $(BUILTIN_DTB_SOURCE)
 endif
 
 # for CONFIG_OF_ALL_DTBS test
diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index 2bf964df37ba..f378e56f9ce6 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -34,7 +34,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x38000000@0"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB="kc705"
+CONFIG_BUILTIN_DTB_SOURCE="kc705"
 # CONFIG_COMPACTION is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 3221b7053fa3..62f32a902568 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -38,7 +38,7 @@ CONFIG_HIGHMEM=y
 # CONFIG_PCI is not set
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB="csp"
+CONFIG_BUILTIN_DTB_SOURCE="csp"
 # CONFIG_COMPACTION is not set
 CONFIG_XTFPGA_LCD=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index 985fa8546e4e..8bebe07f1060 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -33,7 +33,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x38000000@0"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB="kc705"
+CONFIG_BUILTIN_DTB_SOURCE="kc705"
 # CONFIG_COMPACTION is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index f3fc4f970ca8..933ab2adf434 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -39,7 +39,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0x9d050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=256M@0x60000000"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB="kc705_nommu"
+CONFIG_BUILTIN_DTB_SOURCE="kc705_nommu"
 CONFIG_BINFMT_FLAT=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 11fed6c06a7c..af9c774502f8 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -37,7 +37,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=96M@0"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB="lx200mx"
+CONFIG_BUILTIN_DTB_SOURCE="lx200mx"
 # CONFIG_COMPACTION is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
-- 
2.19.2

