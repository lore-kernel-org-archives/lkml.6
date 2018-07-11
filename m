Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD6AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD20E20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD20E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbeGKObn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:31:43 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:40288 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388121AbeGKObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:31:43 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 9SSz1y00L3XaVaC01SSzYJ; Wed, 11 Jul 2018 16:27:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fdG55-0000l9-9j; Wed, 11 Jul 2018 16:26:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fdG55-0001CE-85; Wed, 11 Jul 2018 16:26:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: defconfig: Set CONFIG_LOCALVERSION in multi v4t/v5/v7 defconfigs
Date:   Wed, 11 Jul 2018 16:26:49 +0200
Message-Id: <20180711142649.4556-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to derive the kernel flavor from the kernel version at
runtime.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Handle "new" multi_v4t_defconfig.
---
 arch/arm/configs/multi_v4t_defconfig | 1 +
 arch/arm/configs/multi_v5_defconfig  | 1 +
 arch/arm/configs/multi_v7_defconfig  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 9a6390c172d6b676..9bbb76e8260611df 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-multi_v4t"
 CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 7c41bee284630d14..5797c8b40c763b55 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-multi_v5"
 CONFIG_SYSVIPC=y
 CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4c71fcb03bccfb8d..155d1eb10c6580fe 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-multi_v7"
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
2.17.1

