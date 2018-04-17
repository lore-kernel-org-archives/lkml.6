Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2397738-1523988976-2-1711035506994879884
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523988975; b=ovFa+GZDJgDDTjFLBuJECY4J04Z8IpCBFpDiYmPoeJDKtIBxQ8
    P8i73L5zYciT9N1Mxgud69ZvnvWJN5vbmG+2UlZL6eGQ3rYtmF/rDIE0Q8DjUOdV
    VoeToo7/VDaYR0oK/1FdGHJ+vD+Nyhrr10E5+JxFG9tJQ7jhDw2eY627CQspfU3z
    VljxdUL3hGa4mYpWp58VVMedlzKB+Ob/n8gxty2aelAzmU01hzy830GKefN75SU7
    LcYbbwNWedz+tMgqQxvKou2PdMjLC/Fw36jbEq2xhSD+BtIb+021rjrg+lrzTRpi
    ByW5YzKjNu4wIKgTJQ9IIK3FFoMytaCtDj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523988975; bh=9e+y0
    DxzYcE4zDHRik12JvGx9BhjfRLEBW/wErm+Krc=; b=V7JLXSuMqbusQOOfunnjB
    t+YPtXZKObS7+RHrye/Ug4ck8B/WeIKk9NDNg/rrNjsn3PiC5s3oqHGOOBoCfvQL
    /1pX/yQnz4VYcqURmumabYjgF1h6RzcO5rgp/zuG49TPPgXh9xSDJTSpLyLMROzz
    n5lYG5A4ZMhYhrq9/rdPZhoEJbNAYZfYXIgM0S4p7vmyyCkHw7SAW8UbgXG1Tgy2
    UaoeEDNYD9QqhYjSa+wU+d5kp5XIsqFgPt2re1HnsCvY1JFqJcBplLhO1Rk3JCQH
    Fgsus/q+lGSrFSoFwAYN4/QY3dnPoOHdHtMiMttBgNyyBbruYtELCHwAuKiYtCaH
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEtp16rGIMZzi1lu/K67NCFAmdzCOphL3UPpChDYd41LB3zngg469bXkhqjIfIiHickKGCNsoos33FaoDLULvOotjd5/3P5IEVXVUdb+s+YC1PLujA6Z
    lWeYoEbqGnIyYhW4h/iOzFbMbqrn1jjekfGe1SVfjh0Uc8rgchlvvN/uNSEaBbjwbZQ/R++XtyjZ4Dlw8xXjA4HXtVScafCTibU70j1afoCHWp0fKxCQTyUq
    5yK+376xTPsm4KgwN4ztQw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
    a=tBb2bbeoAAAA:8 a=DDOyTI_5AAAA:8 a=ixHuCRbDalTb3q0mBGoA:9 a=CjuIK1q_8ugA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22 a=Oj-tNtZlA1e06AYgeCfH:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
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
Subject: [PATCH v3 00/20] Allow compile-testing NO_DMA (drivers)
Date: Tue, 17 Apr 2018 19:49:00 +0200
Message-Id: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

        Hi all,

As of v4.17-rc1, patch series "[PATCH v2 0/5] Allow compile-testing
NO_DMA (core)" (https://lkml.org/lkml/2018/3/16/435) has been included
upstream, and drivers using the DMA API can be compile-tested on
platforms selecting NO_DMA.

This follow-up patch series removes dependencies on HAS_DMA for symbols
that already have platform dependencies implying HAS_DMA, which increases
compile-coverage.

Please apply to your tree if appropriate.

Changes compared to v2:
  - Add Acked-by,
  - Rebased to v4.17-rc1, dropping applied patch for scsi/hisi_sas,
  - Handle new VIDEO_RENESAS_CEU symbol,
  - Drop obsolete note about FSL_FMAN.

Changes compared to v1:
  - Add Reviewed-by, Acked-by,
  - Drop dependency of SND_SOC_LPASS_IPQ806X on HAS_DMA,
  - Drop dependency of VIDEOBUF{,2}_DMA_{CONTIG,SG} on HAS_DMA,
  - Drop new dependencies of VIDEO_IPU3_CIO2, DVB_C8SECTPFE, and
    MTD_NAND_MARVELL on HAS_DMA,
  - Split in per-subsystem patches,
  - Split-off the core part in a separate series.

This series is against v4.17-rc1. It can also be found at
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=no-dma-compile-testing-v3

It has been compile-tested with allmodconfig and allyesconfig for
m68k/sun3, and has received attention from the kbuild test robot.

Thanks for applying!

Geert Uytterhoeven (20):
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
 drivers/iommu/Kconfig                           |  5 ++-
 drivers/lightnvm/Kconfig                        |  2 +-
 drivers/mailbox/Kconfig                         |  2 --
 drivers/media/common/videobuf2/Kconfig          |  2 --
 drivers/media/pci/dt3155/Kconfig                |  1 -
 drivers/media/pci/intel/ipu3/Kconfig            |  1 -
 drivers/media/pci/solo6x10/Kconfig              |  1 -
 drivers/media/pci/sta2x11/Kconfig               |  1 -
 drivers/media/pci/tw5864/Kconfig                |  1 -
 drivers/media/pci/tw686x/Kconfig                |  1 -
 drivers/media/platform/Kconfig                  | 42 +++++++++----------------
 drivers/media/platform/am437x/Kconfig           |  2 +-
 drivers/media/platform/atmel/Kconfig            |  4 +--
 drivers/media/platform/davinci/Kconfig          |  6 ----
 drivers/media/platform/marvell-ccic/Kconfig     |  3 +-
 drivers/media/platform/rcar-vin/Kconfig         |  2 +-
 drivers/media/platform/soc_camera/Kconfig       |  3 +-
 drivers/media/platform/sti/c8sectpfe/Kconfig    |  2 +-
 drivers/media/v4l2-core/Kconfig                 |  2 --
 drivers/mmc/host/Kconfig                        | 10 ++----
 drivers/mtd/nand/raw/Kconfig                    |  8 ++---
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
 drivers/spi/Kconfig                             | 12 ++-----
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
 53 files changed, 56 insertions(+), 142 deletions(-)

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
