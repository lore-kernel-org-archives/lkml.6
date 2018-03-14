Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeCNPuo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:50:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeCNPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:50:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Subject: [PATCH 36/47] pwm: remobe pwm-bfin driver
Date: Wed, 14 Mar 2018 16:35:49 +0100
Message-Id: <20180314153603.3127932-37-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:pE+YNb77IA+n6khjELencU24cYXc4raks1mGqbfgvkVloZ4VbAO
 8B9tvtJ4LUDbLi44ES+4PxfN9S62nPlDDUWFF77zA7dF3YElGtNtexboRRPNtQ+IbcaGYLm
 7s/oAglXYCW0tNIjULLvJUtANY+xSuxSugfeXyt44qdbHVVo7ZCVc3zo9FGJB+QnhN1MI5I
 5V8btMrgeCnQX2mCKq4wQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:05p1Vh1f7Cg=:DqU0ZbphlkvJT5VW1Rd1lm
 I9j/xI3TmtdcY2RlvB8oXROPTL1wLwQ2vSA3tdpFt9GJ6JYEc0WiKcXec/xbEQC+fVmd0EK/k
 Q0FhRC1UuYReXyedtTVK8T2wTPTYlSf4rvd8j7Hcuqb5eqK9yGCbhcLl63rNdCgnxbT+xrj98
 5loeOzU64wAhMGIU3qsUUHsmBEek2BLpuGi1ipIKi4wFOXgR+rDPIVXDUoFz2EdGwdW50I7on
 krY2s5uoUDW5EH4Si2NmXbjMuSiqaFk6vdDft4ZBKyg0bLMg6tHe4i2K9Z8l8MpVpEV7omQpm
 zchDC9lr9qSjx/EE4ee7UI0L1Ucd7HmfDXeBbW2qn10cl5D2nHvLMbMnWe0YHYnIno4Z1D8FX
 +MZ6u4SievbGGDUP3hQpnCCO2J7YN3tPvtM9CLyOi7LoukkuyLcwFdf8zcxGsOvj7QhuYfH05
 GzKTZYlzWn9d0P9RXLh4AXBQq9sZAEBKGOs2xuZViKJHhvb0719/kkLGlKY2Cd2W5ZRGJP6o3
 Ib7hhSQMTIjCPa2FzeoVEUaodx95G/j8Hcfqp2L9zDY4K8QMhfiUsiRbeSxVIwFaM/VsmhWyd
 jox6Pbwlyu5twIXfXFvvq3pYgKckz5m9ssKCamnflKA/9stQIAGfui+p703KHSvNegzN3KX8V
 F425oFYs4ijEM9IXTADo0mPNIeuTx+i8TfEDwIyyHg90l8rVRf7PDSBlS/4AkDB6Gd8Wb+0dU
 50cpaOnQ1bBHQ73gNEBUMbqCAJSQ5MG2jJYZaw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this driver is now
obsolete as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pwm/Kconfig    |   9 ---
 drivers/pwm/Makefile   |   1 -
 drivers/pwm/pwm-bfin.c | 157 -------------------------------------------------
 3 files changed, 167 deletions(-)
 delete mode 100644 drivers/pwm/pwm-bfin.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50ea57d..5d9868d23781 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -113,15 +113,6 @@ config PWM_BERLIN
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-berlin.
 
-config PWM_BFIN
-	tristate "Blackfin PWM support"
-	depends on BFIN_GPTIMERS
-	help
-	  Generic PWM framework driver for Blackfin.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-bfin.
-
 config PWM_BRCMSTB
 	tristate "Broadcom STB PWM support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0258a745f30c..9c676a0dadf5 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
-obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
diff --git a/drivers/pwm/pwm-bfin.c b/drivers/pwm/pwm-bfin.c
deleted file mode 100644
index a9a88137f2cb..000000000000
-- 
2.9.0
