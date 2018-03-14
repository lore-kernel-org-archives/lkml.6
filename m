Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeCNPlI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:41:08 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeCNPlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:41:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 13/47] pcmcia: remove m32r drivers
Date: Wed, 14 Mar 2018 16:35:26 +0100
Message-Id: <20180314153603.3127932-14-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:t6nozWEw7qaDTgtlYzrOwlpElWro/LZGrVIawMGuTvYyhVD5gSu
 LdHzPPz1bsdn0tFtcKH30qQZ7B5Wq60r1KLfAA4gdoiEQ10C8dfLmF1POZGulVVz80gDKms
 wzUkUiEPcpmTd9f40NPbT1cu7uEcF7xpnPBOBqu7aZF9USidEeWyz5JPB3SQu19ldkWVh8t
 Egx8TjowObHhqDW+GdFag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zBh6cm1YRcU=:GuPaL6NtHBalOkucxdwHTs
 kzNnxXqc+ugDUz5iq2192kT/G5Q1vmLoRGDgoRMFV3IL6Ht7SgLeBfuZuu9DUKKLzjn6Xsa2E
 sPhZ5cCVIAtkjBUGaZMirsjeHVaNktbhbKrdfC9JlFcbpEIjBuNzWZlOMP8R35fac6vjsRDCf
 GfSmnWNhsIrZ9V6UesgObqWazmQWXywC5D4Y0v5rq/XGt1olwigeYK3UWI4RTkI1zoCXDJq3L
 tkYVQsWt5oIB6jJe24cifkzKA1YeKVnaeHD9S+aDHmVZCCi22VbonxTe+SdVdmVp8ytfpjLf7
 Rw+6DtyOe+HFVjjSZy6pWSTGQaqO4AzndYylnJ+Mh1YKPwVB9IZv1KDirHupWPWJi7xgCnmMW
 JC/Fu9/nBoVQjd8ss3NHolnaZEHZJCg1DiNkAZCU9BEBHzVT/P7IfldjNVjVvRLOLynbdshLr
 38NYrs5RgJwm9h1c6wYof1vO01BLR+lLpxy4842YzmJ/qhCBOc5Bc5iEU7PYil4rAl5RpIYR4
 QSaqzMWCdpRVrrOM9mOUKZhLVrke6lGyfshpuOHkMCJ/Xv15EzRsQEyaU9GEXdaYrk6/wq9up
 Yw7H8KXk9Q1l2Y34RusMGM18F0bCI45rIhhUsr/TV5b8Fh8EMVT6HluUtVoO20X38lGMLXiEQ
 z4rQt1MUeyXWheJx6f2OCbUMRFoLflT0avpb0YBB41GgsU0jRhv9ZayCjvTGvkcfThL3cWkev
 olBHOTvhsiyOC2oRP8Ge2kN0oKgGuQ2SzAmrzA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m32r architecture is getting removed, so these drivers
are no longer needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pcmcia/Kconfig    |  19 --
 drivers/pcmcia/Makefile   |   2 -
 drivers/pcmcia/m32r_cfc.c | 786 ----------------------------------------------
 drivers/pcmcia/m32r_cfc.h |  88 ------
 drivers/pcmcia/m32r_pcc.c | 763 --------------------------------------------
 drivers/pcmcia/m32r_pcc.h |  66 ----
 6 files changed, 1724 deletions(-)
 delete mode 100644 drivers/pcmcia/m32r_cfc.c
 delete mode 100644 drivers/pcmcia/m32r_cfc.h
 delete mode 100644 drivers/pcmcia/m32r_pcc.c
 delete mode 100644 drivers/pcmcia/m32r_pcc.h

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index d3c378b4db6c..49540d13dea4 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -232,25 +232,6 @@ config PCMCIA_PROBE
 	bool
 	default y if ISA && !ARCH_SA1100 && !PARISC
 
-config M32R_PCC
-	bool "M32R PCMCIA I/F"
-	depends on M32R && CHIP_M32700 && PCMCIA
-	help
-	  Say Y here to use the M32R PCMCIA controller.
-
-config M32R_CFC
-	bool "M32R CF I/F Controller"
-	depends on M32R && (PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_MAPPI3 || PLAT_OPSPUT)
-	help
-	  Say Y here to use the M32R CompactFlash controller.
-
-config M32R_CFC_NUM
-	int "M32R CF I/F number"
-	depends on M32R_CFC
-	default "1" if PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_MAPPI3 || PLAT_OPSPUT
-	help
-	  Set the number of M32R CF slots.
-
 config PCMCIA_VRC4171
 	tristate "NEC VRC4171 Card Controllers support"
 	depends on CPU_VR41XX && ISA && PCMCIA
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index e7dae16b9a43..ca361266d055 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -28,8 +28,6 @@ obj-$(CONFIG_PCMCIA_SOC_COMMON)			+= soc_common.o
 obj-$(CONFIG_PCMCIA_SA11XX_BASE)		+= sa11xx_base.o
 obj-$(CONFIG_PCMCIA_SA1100)			+= sa1100_cs.o
 obj-$(CONFIG_PCMCIA_SA1111)			+= sa1111_cs.o
-obj-$(CONFIG_M32R_PCC)				+= m32r_pcc.o
-obj-$(CONFIG_M32R_CFC)				+= m32r_cfc.o
 obj-$(CONFIG_PCMCIA_BCM63XX)			+= bcm63xx_pcmcia.o
 obj-$(CONFIG_PCMCIA_VRC4171)			+= vrc4171_card.o
 obj-$(CONFIG_PCMCIA_VRC4173)			+= vrc4173_cardu.o
diff --git a/drivers/pcmcia/m32r_cfc.c b/drivers/pcmcia/m32r_cfc.c
deleted file mode 100644
index 9a4940e56e2f..000000000000
diff --git a/drivers/pcmcia/m32r_cfc.h b/drivers/pcmcia/m32r_cfc.h
deleted file mode 100644
index 05fec98617d0..000000000000
diff --git a/drivers/pcmcia/m32r_pcc.c b/drivers/pcmcia/m32r_pcc.c
deleted file mode 100644
index c2239a7e383a..000000000000
diff --git a/drivers/pcmcia/m32r_pcc.h b/drivers/pcmcia/m32r_pcc.h
deleted file mode 100644
index d99ad3864ff3..000000000000
-- 
2.9.0
