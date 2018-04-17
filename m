Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2548850-1523991491-2-2166895735669306128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523991490; b=K21VqtWCVMUCrujbsrw7XlPE07pAQg0U+HeDi4ktxVTTgRRseJ
    O9qnVe7wuy7GA2tpUN19sSkDHKwAUExlgVzRWlYDfvi1+sU3KWFGAXR+hLavPvgJ
    Q/+vYErCg1TEbjUrskb28WDP0jb/Xgr9GIRcccM7D5AuwjTEh0SSQrNNMVIb0klq
    Box8Zxl01x7/KZphoSHn5uVfa1lYjNVZYJhIFJ0vKegqf48iasZXDvgxQv6tc7cu
    M6R955+3GffZMHUU/VRs5WwwmeWVtpJ3/DdcU2CJxQDCnl56RTVFWHPNN+R5l6GC
    SbtvlMqUqaiWOa2Z8kuRdeK46jZVSRCdvfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523991490; bh=
    8jT+WjD7w8QphxQZMc9bHAXLo+oQFXxh0VJJsg/LN+U=; b=k6gOeG9kc6dqJ5mS
    giYIoyFvnTaca5IEkdXOw9q1JRV2WItw0LJ/GYsyKKSOxyKQZ3V1xciy48igwRsw
    SGUn5t9u/LAT78Yo4HsPZADsysJKJmacuss5kSkb1FAk5cuchPmecsif/4osGUT3
    CIyciIdhsPoXtJgrgiBN26y96RfGefFCAevtC1hkimUMPinjg+wIa2VXu9BuTLVD
    cyTJ7B4iOlsgQ3gYRr+9zxyzyOrR7q+x83shTvwmOZ3L2ft2R/v6+FPGz1ecY/Bt
    hAx+ZMftOQ5Dkgh3tygIbPL1P1hFlcreaIQicAIXJsUKrpTJhN5gHgoL5siYwOQA
    +h9JGw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMZRFOeTvCxaT/mRTEjwrNODQ9fnq3Pn4TvAcKy4y+T2t0XmriVtbvLURBPbMx7rFvEqkJE1LdrQfwJVO3ZGdSqcehHGfZYTYt9OD2qWPzFEO/v5pvlm
    pMFCyoLkVvw5iGc+rMb/Jgjrond3Pvnb1JabYcPQrGP6GdHtaA/lMbhMB8bIgUQLckIryffNw2I98FLGHovvjMY487/BBoLM+z7IAR4f2kcs0aAy/DWFIELT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=tBb2bbeoAAAA:8
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=d5QUEaZ_3_V5qvzpo28A:9
    a=x8gzFH9gYPwA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDQS6G (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 14:58:06 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:41550 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbeDQS6E (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Apr 2018 14:58:04 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Matias Bjorling <mb@lightnvm.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-ide@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-block@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 13/20] mmc: Remove depends on HAS_DMA in case of platform dependency
Date: Tue, 17 Apr 2018 19:49:13 +0200
Message-Id: <1523987360-18760-14-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
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
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v3:
  - Add Acked-by,
  - Rebase to v4.17-rc1,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/mmc/host/Kconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9589f9c9046f14b1..3978d0418958bf6b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -358,7 +358,6 @@ config MMC_MESON_MX_SDIO
 	tristate "Amlogic Meson6/Meson8/Meson8b SD/MMC Host Controller support"
 	depends on ARCH_MESON || COMPILE_TEST
 	depends on COMMON_CLK
-	depends on HAS_DMA
 	depends on OF
 	help
 	  This selects support for the SD/MMC Host Controller on
@@ -401,7 +400,6 @@ config MMC_OMAP
 
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
-	depends on HAS_DMA
 	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
@@ -511,7 +509,6 @@ config MMC_DAVINCI
 
 config MMC_GOLDFISH
 	tristate "goldfish qemu Multimedia Card Interface support"
-	depends on HAS_DMA
 	depends on GOLDFISH || COMPILE_TEST
 	help
 	  This selects the Goldfish Multimedia card Interface emulation
@@ -605,7 +602,7 @@ config MMC_SDHI
 
 config MMC_SDHI_SYS_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
-	depends on MMC_SDHI && HAS_DMA
+	depends on MMC_SDHI
 	default MMC_SDHI if (SUPERH || ARM)
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
@@ -615,7 +612,7 @@ config MMC_SDHI_SYS_DMAC
 config MMC_SDHI_INTERNAL_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
 	depends on ARM64 || COMPILE_TEST
-	depends on MMC_SDHI && HAS_DMA
+	depends on MMC_SDHI
 	default MMC_SDHI if ARM64
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
@@ -669,7 +666,6 @@ config MMC_CAVIUM_THUNDERX
 
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
-	depends on HAS_DMA
 	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
@@ -748,7 +744,6 @@ config MMC_DW_ZX
 
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
-	depends on HAS_DMA
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	help
 	  This selects the MMC Host Interface controller (MMCIF) found in various
@@ -868,7 +863,6 @@ config MMC_TOSHIBA_PCI
 config MMC_BCM2835
 	tristate "Broadcom BCM2835 SDHOST MMC Controller support"
 	depends on ARCH_BCM2835 || COMPILE_TEST
-	depends on HAS_DMA
 	help
 	  This selects the BCM2835 SDHOST MMC controller. If you have
 	  a BCM2835 platform with SD or MMC devices, say Y or M here.
-- 
2.7.4

