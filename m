Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbeCHVfu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:35:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34232 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbeCHVfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:35:48 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] arm64: defconfig: enable Rockchip io-domain driver
Date: Thu,  8 Mar 2018 22:35:40 +0100
Message-Id: <20180308213540.4309-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Stübner justified pretty well the change in commit e330eb86ba0
'ARM: multi_v7_defconfig: enable Rockchip io-domain driver'. This change
is also needed for arm64 rockchip boards, so, do the same for arm64.

The io-domain driver is necessary to notify the soc about voltages
changes happening on supplying regulators. Probably the most important
user right now is the mmc tuning code, where the soc needs to get
notified when the voltage is dropped to the 1.8V point.

As this option is necessary to successfully tune UHS cards etc, it
should get built in. Otherwise, tunning will fail with,

   dwmmc_rockchip fe320000.dwmmc: All phases bad!
   mmc0: tuning execution failed: -5

Cc: Heiko Stübner <heiko@sntech.de>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ba859709c2d4..d65d53b1ff77 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -313,6 +313,8 @@ CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
+CONFIG_POWER_AVS=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.16.1
