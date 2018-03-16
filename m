Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3216954-1521212048-2-14244800161959831479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521212048; b=ejQlpcEk2K3yKRJb1esLK1Pmq07050fSmIFO7XShwBaRTqc
    OaH5BGLSwNdXHJ9SZsgu74A5vHGXqSpH9OMKwIfP4HVt1T5p0HRBGOHy6pGW3LFy
    Vs/jWf2XfKX8FI2aXYoZlw51RHtF37m5AZ8RG4c3tWKPvRYnNCQKhojcReLzH/yF
    RH3hYtD8sEHWq4wIrDlnAK9b/2roMUrAP9u5p9rAKTKR0HcfQSvoX/lNZta+xY/j
    jQ1SIYuzuuMqkjxyASU/RCEU9cMlq2oCEFMF4gn9PTxwpRzlYbLkR0582AiZCh+9
    3pM3xfgAiloJfiOi2GgWS0n1mBmqswuDygYEZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521212048; bh=s
    Z55064ImsRFkSgK6JtcIwu2OowdJ/q/ny1hLL06i+E=; b=gz6g8Zy6VEjZYs/fD
    xfMRl2sB9mdzHqbWQv7UiEfzXkcdFeVp/ih/A+PaV11/1RFge5XqwtoSkQVCLKzU
    dBi9BFY+CoECS7ZWAWgkhXoc1pkgLLAejH3MnztDB6ToRKUCUPE5CEn3NEF2yEYe
    Wp+mrjRluJXxhp9/IwUnkFvkNA8UA9XdKPDri8y2Uc/Kpoi/2Uvpc5VdocpDcw72
    01S3YkJZ5U17c7qnRair0aIeHX/OdIs8NXu2GWOIOysqZn2e/9sGtg7Nz+9SeB38
    Bh23IdCGF512KbgR00KXFAjIyWZTSuInogUv9z9Zu6lB0n80pPtSWMmPqOpfPkaD
    deGVw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
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
Subject: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
Date: Fri, 16 Mar 2018 14:51:33 +0100
Message-Id: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
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
Cc: alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-serial@vger.kernel.org, linux-media@vger.kernel.org,
 linux-block@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

	Hi all,

If NO_DMA=y, get_dma_ops() returns a reference to the non-existing
symbol bad_dma_ops, thus causing a link failure if it is ever used.

The intention of this is twofold:
  1. To catch users of the DMA API on systems that do no support the DMA
     mapping API,
  2. To avoid building drivers that cannot work on such systems anyway.

However, the disadvantage is that we have to keep on adding dependencies
on HAS_DMA all over the place.

Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
already covering intention #2.  Having to add an explicit dependency on
HAS_DMA here is cumbersome, and hinders compile-testing.

Hence I think the time is ripe to reconsider the link failure.
Patch series "[PATCH v2 0/5] Allow compile-testing NO_DMA (core)"
(https://lkml.org/lkml/2018/3/16/435) already:
  - Changed get_dma_ops() to return NULL instead,
  - Added a few more dummies to enable compile-testing.

This patch series:
  - Removes dependencies on HAS_DMA for symbols that already have
    platform dependencies implying HAS_DMA.

To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
this (drivers) series should be applied after the previous (core)
series (but not many people may notice/care ;-)

Changes compared to v1:
  - Add Reviewed-by, Acked-by,
  - Drop dependency of SND_SOC_LPASS_IPQ806X on HAS_DMA,
  - Drop dependency of VIDEOBUF{,2}_DMA_{CONTIG,SG} on HAS_DMA,
  - Drop new dependencies of VIDEO_IPU3_CIO2, DVB_C8SECTPFE, and
    MTD_NAND_MARVELL on HAS_DMA,
  - Split in per-subsystem patches,
  - Split-off the core part in a separate series.

This series is against v4.16-rc5. It can also be found at
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=no-dma-compile-testing-v2

It has been compile-tested with allmodconfig and allyesconfig for
m68k/sun3, and has received attention from the kbuild test robot.

Thanks!

Geert Uytterhoeven (21):
  ASoC: Remove depends on HAS_DMA in case of platform dependency
  ata: Remove depends on HAS_DMA in case of platform dependency
  crypto: Remove depends on HAS_DMA in case of platform dependency
  fbdev: Remove depends on HAS_DMA in case of platform dependency
  firewire: Remove depends on HAS_DMA in case of platform dependency
  fpga: Remove depends on HAS_DMA in case of platform dependency
  i2c: Remove depends on HAS_DMA in case of platform dependency
  iio: adc: Remove depends on HAS_DMA in case of platform dependency
  iommu: Remove depends on HAS_DMA in case of platform dependency
  lightnvm: Remove depends on HAS_DMA in case of platform dependency
  mailbox: Remove depends on HAS_DMA in case of platform dependency
  media: Remove depends on HAS_DMA in case of platform dependency
  mmc: Remove depends on HAS_DMA in case of platform dependency
  mtd: Remove depends on HAS_DMA in case of platform dependency
  net: Remove depends on HAS_DMA in case of platform dependency
  remoteproc: Remove depends on HAS_DMA in case of platform dependency
  scsi: hisi_sas: Remove depends on HAS_DMA in case of platform
    dependency
  serial: Remove depends on HAS_DMA in case of platform dependency
  spi: Remove depends on HAS_DMA in case of platform dependency
  staging: vc04_services: Remove depends on HAS_DMA in case of platform
    dependency
  usb: Remove depends on HAS_DMA in case of platform dependency

 drivers/ata/Kconfig                             |  2 --
 drivers/crypto/Kconfig                          | 14 +++------
 drivers/firewire/Kconfig                        |  1 -
 drivers/fpga/Kconfig                            |  1 -
 drivers/i2c/busses/Kconfig                      |  3 --
 drivers/iio/adc/Kconfig                         |  2 --
 drivers/iommu/Kconfig                           |  5 ++--
 drivers/lightnvm/Kconfig                        |  2 +-
 drivers/mailbox/Kconfig                         |  2 --
 drivers/media/common/videobuf2/Kconfig          |  2 --
 drivers/media/pci/dt3155/Kconfig                |  1 -
 drivers/media/pci/intel/ipu3/Kconfig            |  1 -
 drivers/media/pci/solo6x10/Kconfig              |  1 -
 drivers/media/pci/sta2x11/Kconfig               |  1 -
 drivers/media/pci/tw5864/Kconfig                |  1 -
 drivers/media/pci/tw686x/Kconfig                |  1 -
 drivers/media/platform/Kconfig                  | 40 ++++++++-----------------
 drivers/media/platform/am437x/Kconfig           |  2 +-
 drivers/media/platform/atmel/Kconfig            |  4 +--
 drivers/media/platform/blackfin/Kconfig         |  1 -
 drivers/media/platform/davinci/Kconfig          |  6 ----
 drivers/media/platform/marvell-ccic/Kconfig     |  3 +-
 drivers/media/platform/rcar-vin/Kconfig         |  2 +-
 drivers/media/platform/soc_camera/Kconfig       |  3 +-
 drivers/media/platform/sti/c8sectpfe/Kconfig    |  2 +-
 drivers/media/v4l2-core/Kconfig                 |  2 --
 drivers/mmc/host/Kconfig                        | 10 ++-----
 drivers/mtd/nand/Kconfig                        |  8 ++---
 drivers/mtd/spi-nor/Kconfig                     |  2 +-
 drivers/net/ethernet/amd/Kconfig                |  2 +-
 drivers/net/ethernet/apm/xgene-v2/Kconfig       |  1 -
 drivers/net/ethernet/apm/xgene/Kconfig          |  1 -
 drivers/net/ethernet/arc/Kconfig                |  6 ++--
 drivers/net/ethernet/broadcom/Kconfig           |  2 --
 drivers/net/ethernet/calxeda/Kconfig            |  2 +-
 drivers/net/ethernet/hisilicon/Kconfig          |  2 +-
 drivers/net/ethernet/marvell/Kconfig            |  8 ++---
 drivers/net/ethernet/mellanox/mlxsw/Kconfig     |  2 +-
 drivers/net/ethernet/renesas/Kconfig            |  2 --
 drivers/net/wireless/broadcom/brcm80211/Kconfig |  1 -
 drivers/net/wireless/quantenna/qtnfmac/Kconfig  |  2 +-
 drivers/remoteproc/Kconfig                      |  1 -
 drivers/scsi/hisi_sas/Kconfig                   |  2 +-
 drivers/spi/Kconfig                             | 12 ++------
 drivers/staging/media/davinci_vpfe/Kconfig      |  1 -
 drivers/staging/media/omap4iss/Kconfig          |  1 -
 drivers/staging/vc04_services/Kconfig           |  1 -
 drivers/tty/serial/Kconfig                      |  4 ---
 drivers/usb/gadget/udc/Kconfig                  |  4 +--
 drivers/usb/mtu3/Kconfig                        |  2 +-
 drivers/video/fbdev/Kconfig                     |  3 +-
 sound/soc/bcm/Kconfig                           |  3 +-
 sound/soc/kirkwood/Kconfig                      |  1 -
 sound/soc/pxa/Kconfig                           |  1 -
 sound/soc/qcom/Kconfig                          |  7 ++---
 55 files changed, 56 insertions(+), 143 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
