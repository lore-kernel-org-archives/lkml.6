Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBQOWj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 09:22:39 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40364 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeBQOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 09:22:38 -0500
X-Google-Smtp-Source: AH8x226XFS681yPomnKx7lga79QC0Pks2QhlCKWP/tj0wQCq3h6Lc3wV4dLY6lI/Fz+CJ1lLgLIH2g==
From: Philipp Rossak <embed3d@gmail.com>
To: linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org,
        davem@davemloft.net, arnd@arndb.de, mchehab@kernel.org,
        clabbe.montjoie@gmail.com, rask@formelder.dk, krzk@kernel.org,
        sean@mess.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [RFC PATCH] ARM: configs: sunxi: Set ondemand govenor as default
Date: Sat, 17 Feb 2018 15:22:35 +0100
Message-Id: <20180217142235.28541-1-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the performance govenor is the default frequency govenor on
sunxi devices. This causes some general problems.
When the cpu is idle the cpu runs with its maximum frequency.
This causes a higher cpu temperature in the idle state. When the cpu is
now under load the cpu gets with that higher idle temperature now faster
to its thermal limits.
An other big problem of the performace govenor is the missing
thermal throttling. Some tests with cpuburn resulted in a system crash
when the soc reached its thermal limits since no thermal throttling
occurred.

With this patch we set the default frequency govenor to ondemand mode
and reduce the temperature when the cpu is idle and activate the thermal
throtteling.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index df433abfcb02..e5812851091c 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -14,6 +14,7 @@ CONFIG_CMA=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
2.11.0
