Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCNPhF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:37:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45009 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:37:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH 01/47] edac: remove tile driver
Date: Wed, 14 Mar 2018 16:35:14 +0100
Message-Id: <20180314153603.3127932-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Xsp9DdTy/dm+UBi8nV8pUztaPP1+rMKIWuA1jKoe4F2da3joOgs
 3qc1S5uZAPW+wLPL9KayJWidqFcBT2+fetlU1l8/nPoMzdOacj/+3yfHz4Xf2SMILaqdiuC
 0W5uoCIcarcPcJ5CXZ348Z6g3jMtpHjYK3cp0msQ2ySmtoCPizMkY3UsW3oS9qM1PHzhZhV
 JhLbFK++QiTWV1YhBQGVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IimNDnBZhio=:mFNkytJXfa/jSQZBZRglKv
 wzv0i9eOZUypcTVG6MfRRCkI2MGwbC0ER4cmUXbz4YWG6b0pTeNCXnPlwm6ps0o0dqWn4I383
 qpQBS1KSvfx7MccJURQ3F2hqy+eUw3DoTFohxYEwEdsy/Z8RwbsreVSIiI2YuBEaQnEnL5i6E
 cONmrd7zfUx1ykJijxdjvvVhNhNZUUAWRfoUhgk27065ZK57SljrWOdQIMJRPYFyH/5Ij/5JS
 URDb0BGwnyuxCuhGafc145Pn7/aTzesUk3YPAzBbPNyNbrmIdpRehCmE0GjPL+yrijkn3VhXB
 Mm4w5mLgltFYmx+EO8mbMaESChRwDDGOIhqngY9/W926cqXG+P8jkEvh2+Fh3TJK9F4VnT9Ho
 75tacQ5oD2Kcyk3Xb9C3O+sgiCkfyM3cQFA7sO5VKC4/HilRUAOX1z8ywV5cQioUn3CG2X0Kv
 ow26NwpX7jt2JLCRRpaN3tTneeN+BXBEOltaIXvcFhGachCrc5KE03oHTP2tzHv4e4mMkMJZf
 XR1oGmk9fY5h7vXb2KFffgrNSRHPNZxAJBcBNYfTlINoP5vYALyJFZWVmHBP40fEH3q/HgJTM
 P/lMHFwcg2gZROyTMyTzCo9miBGe1tCcu+M5/MRvCwEMHVqKWrPkqV81CjutVC25Oq7eQv7Tb
 +Q/kG2AgQU3RLxMiS7UaRx/AFzCeBVISCXhdxvUv8CsfZaqLDpObTWMdrT/IlhM9g7jYdywIa
 fADzvqe3cKb0S6gnRi+UKNyuNxz9aChtPsyYSA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tile architecture is obsolete and getting removed from the kernel,
this driver appears to only be used there, and not on the ARM based
successors (Tile-Mx, BlueField), so we should remove it as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/Kconfig     |   8 --
 drivers/edac/Makefile    |   2 -
 drivers/edac/tile_edac.c | 265 -----------------------------------------------
 3 files changed, 275 deletions(-)
 delete mode 100644 drivers/edac/tile_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index cb4ff1cc6eb4..533122aaa091 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -317,14 +317,6 @@ config EDAC_CPC925
 	  a companion chip to the PowerPC 970 family of
 	  processors.
 
-config EDAC_TILE
-	tristate "Tilera Memory Controller"
-	depends on TILE
-	default y
-	help
-	  Support for error detection and correction on the
-	  Tilera memory controller.
-
 config EDAC_HIGHBANK_MC
 	tristate "Highbank Memory Controller"
 	depends on ARCH_HIGHBANK
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index b54912eb39af..02b43a7d8c3e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -64,8 +64,6 @@ obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
 obj-$(CONFIG_EDAC_AMD8111)		+= amd8111_edac.o
 obj-$(CONFIG_EDAC_AMD8131)		+= amd8131_edac.o
 
-obj-$(CONFIG_EDAC_TILE)			+= tile_edac.o
-
 obj-$(CONFIG_EDAC_HIGHBANK_MC)		+= highbank_mc_edac.o
 obj-$(CONFIG_EDAC_HIGHBANK_L2)		+= highbank_l2_edac.o
 
diff --git a/drivers/edac/tile_edac.c b/drivers/edac/tile_edac.c
deleted file mode 100644
index 8a33a87e67f1..000000000000
-- 
2.9.0
