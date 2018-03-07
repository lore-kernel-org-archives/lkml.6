Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934005AbeCGQYy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:24:54 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCGQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:24:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: npcm: add CONFIG_ARCH_MULTI_V7 dependency
Date: Wed,  7 Mar 2018 17:24:12 +0100
Message-Id: <20180307162430.2664523-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:gF4p6j0gPbam+NfziKqkjnu+VOTwdO/aps9Yi7frysR07No0cTc
 +Po/5P481l8d7yS9r96L4/klx2J3ocLNVc7/w7kp5nCQe3TXikv8SKOUVlKDua+V6hGuxBp
 OK4rAwYg6PzT05Tyd7+MXuflbZPHeP8SjtmlNx+fDkQdN/3q5Ie+L2bW9qMHsN9cvOVHqcL
 tNbygrzwVPwpVy3KWKMVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mb02ZiVoKV8=:arGViqzyvhucD5vgZUNCtN
 lc+15LHb63Z/Z1Ew5HFqXiSlMMeccCFZkFIpZ4b8qJg8a2aMmrP4E7nU7vDC6lBxoksLMhyNI
 opz2iLMRg5iSX27PMI6rgy0nDy/0vLzV2KMn47J7cK1bPRREDdYwdCNBUbl38UWZV7lyWd+3v
 xIh2PlLI2yMo/Xkecatosy0Bz32xUyUxk4+DK3FihuYlzaQT+atbRatmWwKwYMPO+EZ9D+x2j
 8PBmUt2h2Z9R2k8ZgZZtYLkerMfyTYOGjVytPzsqebQEO3SOcRSzETFMdxm7Oy8/HvWIYl3vG
 PiHjSsyPcmrbNaGmJTUKQMJUvfe71Ufm7fO9nh660wcv8GShHqY1IqVd/PmfHWHM8XV0M6gO6
 wJzOMbvVWFr3JcZblmr1aHQE+ITxaXaOajMqccj02HyO5PGDdhzCuCi+Kb9AN4nr5poWH174s
 Gp+9Qgzv33gwpVGzpEn0iF4QYaaQEbN43GXv/YDBlYFkgeURUP2jq08HGcCuzzxEJhvP/rNfN
 fqT9EkbXgw+Q4QuCNYrQEelPT/Cbsq67oxZO8uJIKE7XcL1siJ643JUT8Gz8r38ec6epTjA6h
 iuyAmhaeB3zUXXx1xxWRBgusz4V/yZmk6Gei15SHvc1F6wx2NfFs6FrYBXCNT6BG96a/bQKSx
 24rFlhsMPcWzBkiZQAByzUf82u5NV2fcx4ayKYYPP/JmjlJd3UvFoTNeL35w54gwhoUVed6eW
 GXtXeYAyTb38YiaYDkToDpJn9oneVvSzpz1MEg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top-level CONFIG_ARCH_NPCM symbol is not guarded with a
dependency, and can be selected for builds of traditional
(non-multiplatform) builds as well, where it causes a build
failure:

arch/arm/boot/Makefile:17: arch/arm/mach-npcm//Makefile.boot: No such file or directory

This moves the dependency to avoid that particular condition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-npcm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
index 6ff9df2636be..2bc6697c8d97 100644
--- a/arch/arm/mach-npcm/Kconfig
+++ b/arch/arm/mach-npcm/Kconfig
@@ -1,5 +1,5 @@
 menuconfig ARCH_NPCM
-	bool "Nuvoton NPCM Architecture"
+	bool "Nuvoton NPCM Architecture" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select USE_OF
 	select PINCTRL
@@ -10,7 +10,7 @@ if ARCH_NPCM
 comment "NPCM7XX CPU type"
 
 config ARCH_NPCM750
-	depends on ARCH_NPCM && ARCH_MULTI_V7
+	depends on ARCH_NPCM
 	bool "Support for NPCM750 BMC CPU (Poleg)"
 	select CACHE_L2X0
 	select CPU_V7
-- 
2.9.0
