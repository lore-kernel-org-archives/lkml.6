Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeBZUlf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:41:35 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:34047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeBZUlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:41:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sean Young <sean@mess.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2: set CONFIG_LIRC=y in defconfig
Date: Mon, 26 Feb 2018 21:40:52 +0100
Message-Id: <20180226204105.2858838-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:me5E9OUG2ADndgL/BrF3govmVlUcuMzBoP76tfxJ+kN1EUd8WMH
 YkwwjOX2idgaEvASKqMhiuwh6XmTbajYOzb9L7YO/4CnMrjxrsCGPdHt1o0MS8UnLKsznQk
 IVAT4kl5gHWGtB3DtwyU9ZJqZ1cPPjm/FSD49aIDwwooSIMAXYkwuJis+qg+kJIoB6IX2wo
 Ynwd1VFOE8A1UODaeOoYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WCaiqOM3EvU=:e5L0FjUkV49xDFTpsrh9Pa
 YClbcSSRCzAi0URGXhNq4CcasAwVBLnJc1fEOrrhbGgUBeNEI7t0S5ddA0xJe/TGv62ka8osY
 NoIwJvXimVSHt0wJel7hKlWNM7Fmx43pfNJ8V8AcVUnhyMfCuQUmWKHFJPeYNJQUmTfH5yEbm
 v9k4VzK+aRhHLZltz90+poPSmwpYT7BFBWLyn2RzsW+DEBFgCDe9/cvVtzXPFSxngI+gM904p
 WfH8cRyKaagsdTeGAKpAhK3X6hkqsOdguUE2E74fy47WS9ilLC9Fmjed/+gf0zG81kU5kq6ng
 0H7I7Bn7oa20WyaYDN3ewC/p70ZI1Lp+QDtfmkbJfbOUjgtkaASxBitgh50QFYM++1KRCVM5L
 YqqZOx2Fb/p/XYWMpC39dDXwlXSfZx0fiq2K6g7nv/ixYA+kxsYDeQiQoHdGW5Wk+kReXkINQ
 3N1Fb7uy9U7kN4KMKeEcs3t2XfJjANd55t1hZ81ZP+97LygaHGUkt5KVb8F5nRrf6GTc7g7Op
 OFOEPfCHsjcgxHMwiVSiTf3vpjLWdTtpOW0pPDBNdnjVg6/oi2rWwJs/08sAUU8U5b/lQG5xM
 /fCQv++cveLYcIg2044GBieeFQXJedA3Ud+CdG6Roe0BcZMrAlaMXOXRbhHbqlAoRtwmm2sMT
 Vi5LAIii8bz0/+NUaR97HJKj3JHQu3JdzdWL9DsYtzJpClZWHyUyfej6RvmeNfepKriN7wx3C
 r7DpLekr+bUSynOCE9PCFaxYsrmqwSsjWI6ONw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_LIRC symbol has changed from 'tristate' to 'bool, so we now
get a warning for omap2plus_defconfig:

arch/arm/configs/omap2plus_defconfig:322:warning: symbol value 'm' invalid for LIRC

This changes the file to mark the symbol as built-in to get rid of the
warning.

Fixes: a60d64b15c20 ("media: lirc: lirc interface should not be a raw decoder")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/omap2plus_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 2f145c4af93a..92674f247a12 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -319,7 +319,7 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_RC_CORE=m
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
-CONFIG_LIRC=m
+CONFIG_LIRC=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_RX51=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
-- 
2.9.0
