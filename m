Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2367869-1523987422-2-16497825080212690160
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523987421; b=kCNF/3W1YibMb9nFLOO56gmSDPz4g+qMz7iJf4koNXaH0OIZMh
    XyYVIMLH3uvmif5amfxvwSxIujJeWUHkNujDCI7mon/p9AQ/cXpSVid/b5LUUnv2
    V8G6dqreo6ztlWWq3Sww7EGwj4nMyXXDHHlHL/whL54TiJiDoGmNaolsR9+bK/Yk
    OJVLfDeIJJpcwTrrAuOm/mIliVCqAqQ25OQTbt35owV1lav/cMWyDcKg9QBvLSwT
    34ygFG6lRMLX47wdbbGO9Fau9XJ9BjRpGwg0kGkDpgkOPJjjEzpCLmjdGSOA6DJE
    9sKsQ6PXbyZzFjc527ijyuIhMtH3XdL05K7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523987421; bh=
    qbiTciux4u7NhHFJuQxJeXvCbsvWRs+R/BL7KPVtIvg=; b=OMjPDy9uoIZSU7yB
    9rXPTzYX2TWjd1bCHHVHKOpJc76L6XblvX/jnT8Lf4J4zfJyyHA3+ndWN8ngGKvt
    z2W+NUjVK9LAy2OUPBxQJnJim78T994iQBI0FSIzYBhLQl3VZXwuhpx6e1xTiLPa
    1XQPssxNCpbR9qdATGRrFcvOXBuFGOMMf2CM96AfI2fH4uGmA4UeAMiVE8m/gGO1
    vRsDHJItVJWTENQ53QdLP88sxAr+hDY150hQB2h72JzwOoJMl7tOBtMksE1xL6SW
    0bOLivYYBLVCYJ8dZCwGQKTYXpqpo+eBoFAkVpB5hOd8pGfwU2ylmFsWgm+d7uXb
    YDhebw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
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
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLToGkYvLRzJhnw94hht1VxUzZQzbrSz2W/6YXUErUjnA6LYYKejmObzIepr+jDOtLBWMOR3UxDKWdEmVcP+J8hdrQYylrpOLWYGGFeet4mi3BF5K2x7
    1ASKG0zAItvHX4jv0SPDQObE//clrI1jrjFGeVbq31LcsQxhbjQzv9nbUa7iSJQIAefSTj8MyZErEW+UUUceC0zCaO2LC7kLs3dHhvRD4Kf9giEm6RrFyoK3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=tBb2bbeoAAAA:8
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=i0EeH86SAAAA:8 a=XNYVfk6J6KFTGUcfqe8A:9
    a=x8gzFH9gYPwA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeDQRuP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 13:50:15 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:59114 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeDQRuM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 17 Apr 2018 13:50:12 -0400
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
Subject: [PATCH v3 08/20] iio: adc: Remove depends on HAS_DMA in case of platform dependency
Date: Tue, 17 Apr 2018 19:49:08 +0200
Message-Id: <1523987360-18760-9-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
  - Add Acked-by,
  - Rebase to v4.17-rc1,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/iio/adc/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 15606f237480dacb..88bbcd0e98632273 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -157,7 +157,6 @@ config AT91_SAMA5D2_ADC
 	tristate "Atmel AT91 SAMA5D2 ADC"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on HAS_IOMEM
-	depends on HAS_DMA
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
@@ -646,7 +645,6 @@ config SD_ADC_MODULATOR
 config STM32_ADC_CORE
 	tristate "STMicroelectronics STM32 adc core"
 	depends on ARCH_STM32 || COMPILE_TEST
-	depends on HAS_DMA
 	depends on OF
 	depends on REGULATOR
 	select IIO_BUFFER
-- 
2.7.4

