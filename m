Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeCNPoT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:44:19 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33523 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:44:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Subject: [PATCH 19/47] crypto: remove blackfin CRC driver
Date: Wed, 14 Mar 2018 16:35:32 +0100
Message-Id: <20180314153603.3127932-20-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:mX+ocRm+mfG0anbZjHMjxqmoQa+Ah/yRpeti2/dHWAUPYEgpPuJ
 EmONz2oC8NsWrARkjSA8FBUFdAtDjc4zYWDMMQoImy/jBeEuh5bL1tzgyje144c5DHtDbrz
 EteP2qD4KV6AVvAIUmfJvjqNrd7rnTW1KwbSlbAHVrD78CoS+q1JV6pk6tn2L4lvMlAp8Qf
 EwGjy71xVkBtGu2DSBD0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IzKEVtOOT8o=:bmqjAUlaSUC5TlosB2/k68
 gHccoJEdALhMgya/NFy5FBuCn4ltrXYvN2g226kP/cMQwUnQeVQdkOzE5Gir9p8g+IwVs9QSC
 OmONkfHQpFVQCGXZFl7hLolYJO7Nacn3LbJI7BMaXsWJGzFlksU97PxNlp2sMu7FN+qz9mZid
 PQFAvRa+y8vSSBbN0+sI/wGp3emWydUhcB7hQQvjdtq/KRr7f0GkdxUTrNctI3zJwYJUkRPtn
 NnAgLhxsnYwYhE/b1Pw44uxBZE5z3Vhrb5Dq4DGHW0Ztr/0apjjzA4WfrFU8sfFZ8I93NxWjx
 ADYbYXOq2Zj5iSUyB39nVBUrZdsLFyAJksBjBkTPqH+X01nM/4jGTrS86TmsNxpnYfr+fvAy0
 /YoLumCVdgCsIzRKN3zQlzgdsgjkbK4tS8Tq2g/Lhqe9wF+yi6vpiVmFj78xYFBfMVcjaH7rX
 5170CPbhmVmGPOAyMy+NKb6buOAcTgxJMhC32j6iaDFjAFPQZzn7yOjNp9+14kQehzgX8y5nP
 sZEvjThKI7vNt/rSzSOOFUR+Ec9VKsZ5GbWVyNnPujtySmnr9Lvqus3z6fpeLm67A4FbS3f34
 WYd69t2+mC0E0AvRKzuuGgTB6J5460fVOnecX2raytk4btE8N26CDHrcuneVSYdiMktlJux5S
 aFg0yHTsuMMCN9iHw1BjryGz+K0SBUvjK+32SlKxIVzykvGE+Ew4l4tc7R6hD3o5uGPXicMwl
 pyqYdkf6LFE4f///9J1Xz32wqLYzYCbs8KahnQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this
driver won't be used any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/Kconfig    |   7 -
 drivers/crypto/Makefile   |   1 -
 drivers/crypto/bfin_crc.c | 753 ----------------------------------------------
 drivers/crypto/bfin_crc.h | 124 --------
 4 files changed, 885 deletions(-)
 delete mode 100644 drivers/crypto/bfin_crc.c
 delete mode 100644 drivers/crypto/bfin_crc.h

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 5c4106979cc9..d1ea1a07cecb 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -464,13 +464,6 @@ if CRYPTO_DEV_UX500
 	source "drivers/crypto/ux500/Kconfig"
 endif # if CRYPTO_DEV_UX500
 
-config CRYPTO_DEV_BFIN_CRC
-	tristate "Support for Blackfin CRC hardware"
-	depends on BF60x
-	help
-	  Newer Blackfin processors have CRC hardware. Select this if you
-	  want to use the Blackfin CRC module.
-
 config CRYPTO_DEV_ATMEL_AUTHENC
 	tristate "Support for Atmel IPSEC/SSL hw accelerator"
 	depends on HAS_DMA
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index ee5ec5c94383..7ae87b4f6c8d 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) += atmel-aes.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) += atmel-sha.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) += atmel-tdes.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_ECC) += atmel-ecc.o
-obj-$(CONFIG_CRYPTO_DEV_BFIN_CRC) += bfin_crc.o
 obj-$(CONFIG_CRYPTO_DEV_CAVIUM_ZIP) += cavium/
 obj-$(CONFIG_CRYPTO_DEV_CCP) += ccp/
 obj-$(CONFIG_CRYPTO_DEV_CCREE) += ccree/
diff --git a/drivers/crypto/bfin_crc.c b/drivers/crypto/bfin_crc.c
deleted file mode 100644
index cfc4d682d55a..000000000000
diff --git a/drivers/crypto/bfin_crc.h b/drivers/crypto/bfin_crc.h
deleted file mode 100644
index 786ef746d109..000000000000
-- 
2.9.0
