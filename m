Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2367869-1523987426-2-17840727304739270656
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523987425; b=aAgfw8OG5vixpmSm39P27PjRE98Tcj4KoOPcxjiQ+H8sTGqQ1T
    LNJirrrGnbfjFzX7lPOxQkJzHs98aCqkdzBKPEUXZnwkFunNS6RO4/pYaHYor/Qw
    71CTzr4fauNj1HKAv8GDnTZGNTPCyKNLAOlqrM9fdiPeWpNXMV+deeAhmvPqxKb4
    t8Z02bKVTJJarFANSyH75BIU8PYdWbX1wJ7Kd96UfUlJMP6rTVDm1jleSCGWWSQK
    Cb5BCm38ULQe4DkzmtwrQWs2UZxTAKgxVHwwPrqOWCItcTDgLDFcRkGvsoaC5YzH
    OaLN7AIIy4ggzW+Ev4EKDGOLDrExFEKLsVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523987425; bh=T6vmV
    K+1NKbe9Z+nCgwFUAsrJ3CQDCP6gUJyjlhn+Mo=; b=KSt+G0qjo1vlETzBVeudO
    4UPFMWOoOcY+LwFpbRBv6u4iDxZw48FwltqMh0FlZGpY9MeoKYkkzwr5onC2qEaR
    2OSJiWMlfxzzHSz7iT4MhnOCOrl1MT50jlkZyokgtjVeIW7nAsXEfYdzWT7xkSVP
    5Bh5pXH5qTuUbTpVGJtN1rK2p+WYi5CcnpWGagnKrGERgchw4F+ruki7oK6K5mXE
    TB+w46cOrcXKwmuv/PPFS8ysXxIxRGa4ZXfPZI8zNccfqcX6NWQxkIRykZyMH1av
    9arQ7tYWb2g/nmJiOfRf5RMnlN8fdWVHR6+35ZtE2aZpa8L7KcDgYoeuJc3kn9DB
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGfc6ndAagrDSqs3DkO1URBC+BRwrp5chlcd1FK2PE4Xn5ctrZYXVlWjolhiapWFewxSNN9uD2DM2Q8V5cGZlcSm0GiFKsQZft4fpDIp8V2+lp5rEbvM
    ZhZCX++MzU0rqwGslFQ3/tT0yk+QP+Q2qBkc8BTjNWxembR2Oo6FUreA1dGj8lX60O3JSq0a7bGPj3SbcdnaqPZd0UFUIDce8sXIz1DWkO7jbbTsvExGvsaQ
    GNtDyr2kyIdfqmQbMeSfTg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=FNyBlpCuAAAA:8 a=DDOyTI_5AAAA:8 a=d5QUEaZ_3_V5qvzpo28A:9
    a=CjuIK1q_8ugA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=RlW-AWeGUCXs_Nkyno-6:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 03/20] crypto: Remove depends on HAS_DMA in case of
 platform dependency
Date: Tue, 17 Apr 2018 19:49:03 +0200
Message-Id: <1523987360-18760-4-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 linux-media@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-remoteproc@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
In most cases this other symbol is an architecture or platform specific
symbol, or PCI.

Generic symbols and drivers without platform dependencies keep their
dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
cannot work anyway.

This simplifies the dependencies, and allows to improve compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
v3:
  - Add Acked-by,
  - Rebase to v4.17-rc1,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/crypto/Kconfig | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index d1ea1a07cecbb36c..3dbc47528667b77c 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -419,7 +419,7 @@ config CRYPTO_DEV_EXYNOS_RNG
 config CRYPTO_DEV_S5P
 	tristate "Support for Samsung S5PV210/Exynos crypto accelerator"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-	depends on HAS_IOMEM && HAS_DMA
+	depends on HAS_IOMEM
 	select CRYPTO_AES
 	select CRYPTO_BLKCIPHER
 	help
@@ -466,7 +466,6 @@ endif # if CRYPTO_DEV_UX500
 
 config CRYPTO_DEV_ATMEL_AUTHENC
 	tristate "Support for Atmel IPSEC/SSL hw accelerator"
-	depends on HAS_DMA
 	depends on ARCH_AT91 || COMPILE_TEST
 	select CRYPTO_AUTHENC
 	select CRYPTO_DEV_ATMEL_AES
@@ -479,7 +478,6 @@ config CRYPTO_DEV_ATMEL_AUTHENC
 
 config CRYPTO_DEV_ATMEL_AES
 	tristate "Support for Atmel AES hw accelerator"
-	depends on HAS_DMA
 	depends on ARCH_AT91 || COMPILE_TEST
 	select CRYPTO_AES
 	select CRYPTO_AEAD
@@ -494,7 +492,6 @@ config CRYPTO_DEV_ATMEL_AES
 
 config CRYPTO_DEV_ATMEL_TDES
 	tristate "Support for Atmel DES/TDES hw accelerator"
-	depends on HAS_DMA
 	depends on ARCH_AT91 || COMPILE_TEST
 	select CRYPTO_DES
 	select CRYPTO_BLKCIPHER
@@ -508,7 +505,6 @@ config CRYPTO_DEV_ATMEL_TDES
 
 config CRYPTO_DEV_ATMEL_SHA
 	tristate "Support for Atmel SHA hw accelerator"
-	depends on HAS_DMA
 	depends on ARCH_AT91 || COMPILE_TEST
 	select CRYPTO_HASH
 	help
@@ -574,7 +570,8 @@ config CRYPTO_DEV_CAVIUM_ZIP
 
 config CRYPTO_DEV_QCE
 	tristate "Qualcomm crypto engine accelerator"
-	depends on (ARCH_QCOM || COMPILE_TEST) && HAS_DMA && HAS_IOMEM
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on HAS_IOMEM
 	select CRYPTO_AES
 	select CRYPTO_DES
 	select CRYPTO_ECB
@@ -598,7 +595,6 @@ source "drivers/crypto/vmx/Kconfig"
 config CRYPTO_DEV_IMGTEC_HASH
 	tristate "Imagination Technologies hardware hash accelerator"
 	depends on MIPS || COMPILE_TEST
-	depends on HAS_DMA
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
@@ -650,7 +646,6 @@ config CRYPTO_DEV_ROCKCHIP
 
 config CRYPTO_DEV_MEDIATEK
 	tristate "MediaTek's EIP97 Cryptographic Engine driver"
-	depends on HAS_DMA
 	depends on (ARM && ARCH_MEDIATEK) || COMPILE_TEST
 	select CRYPTO_AES
 	select CRYPTO_AEAD
@@ -688,7 +683,7 @@ source "drivers/crypto/stm32/Kconfig"
 
 config CRYPTO_DEV_SAFEXCEL
 	tristate "Inside Secure's SafeXcel cryptographic engine driver"
-	depends on HAS_DMA && OF
+	depends on OF
 	depends on (ARM64 && ARCH_MVEBU) || (COMPILE_TEST && 64BIT)
 	select CRYPTO_AES
 	select CRYPTO_BLKCIPHER
@@ -706,7 +701,6 @@ config CRYPTO_DEV_SAFEXCEL
 config CRYPTO_DEV_ARTPEC6
 	tristate "Support for Axis ARTPEC-6/7 hardware crypto acceleration."
 	depends on ARM && (ARCH_ARTPEC || COMPILE_TEST)
-	depends on HAS_DMA
 	depends on OF
 	select CRYPTO_AEAD
 	select CRYPTO_AES
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
