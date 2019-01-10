Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E356C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49769214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbAwB3Fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfAJOj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:39:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36214 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfAJOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:39:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so9925363ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WuYCM+bg8v7s+It3Uxisn9zlO+LxIvMEwMgZHCfrL0=;
        b=NbAwB3FgPA9A/qZXjInp7TWn1mvMckyMOBY5Qc0iNSMfvzZlp+yBhpNzCU6+cuN+dr
         DyyfBrGw6iFpMoVux+HgfdzPeIxTaJwTmkUXLWVoOhMVIc/Iyf7PpE8LkpXs1j4CaYle
         4orsLQRKK+63j1RXRppOdxhnAUhUg6H2Fevt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WuYCM+bg8v7s+It3Uxisn9zlO+LxIvMEwMgZHCfrL0=;
        b=Mk01HJOWPP8uobD6K1NVRTFWRwVB0XKn5+TyLYDwG+phAyaUeW8Noq42FuCtfKp5l8
         1nIbD1Fgtt4Trvf1sovN2VRJHCwXzwz77e4Ggr5TzdgfRNl95Vtt+DzD8eqLyXrgnCdt
         o/ckT4mN9jIZTehKb7sMMPOOC0Wlw83RIfiyZdCw1M8FTd0t/JU45pYgI/8VF9BNYXbQ
         g5VhhNe7nUCU33eqQIJLaJc/z7UfPi0FMTwSNQzPmiOgV7ErHOciJbDoTIfbG+1AeN+Y
         DXFIdiR+71SJ6PeIqZ4eEnp/sHn8BtuFg79DXun/yuAzH3ZZj+vF4jgGvMH7cTwU0o8e
         V1ew==
X-Gm-Message-State: AJcUukfNdwqYfz2jJeHMGE75GkmTIo+XBtR6rN7by08lrIsUdnGuOrOi
        KIGRRYHbEQijHswfOeHGl2o8yZVpFkQ=
X-Google-Smtp-Source: ALg8bN5CDrSsPrlcb1hGntCUaMwOpXXwy6hFc8cK6zuXLyuDR3xW6wM74Gq4Dn5xOUL4lxmqw/sLzQ==
X-Received: by 2002:a2e:449b:: with SMTP id b27-v6mr5887374ljf.47.1547131163351;
        Thu, 10 Jan 2019 06:39:23 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v5-v6sm15457931lje.78.2019.01.10.06.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:39:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.linux@gmail.com>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] ARM: config: Update SPEAr 3xx defconfig
Date:   Thu, 10 Jan 2019 15:39:16 +0100
Message-Id: <20190110143917.9054-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This config is updates to the latest structure of the
Kconfig menus so we can apply DRM driver changes on top.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/spear3xx_defconfig | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 2c5e8df33191..6753b373bee8 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -1,21 +1,21 @@
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR3XX=y
 CONFIG_MACH_SPEAR300=y
 CONFIG_MACH_SPEAR310=y
 CONFIG_MACH_SPEAR320=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSMC=y
@@ -32,8 +32,6 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_SMSC is not set
 CONFIG_STMMAC_ETH=y
 # CONFIG_WLAN is not set
-CONFIG_INPUT_FF_MEMLESS=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_SPEAR=y
 # CONFIG_INPUT_MOUSE is not set
@@ -78,8 +76,8 @@ CONFIG_JFFS2_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_INFO=y
-- 
2.19.2

