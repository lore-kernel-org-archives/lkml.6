Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-874968-1517912255-2-8428029393195077199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517912254; b=BsR3XPziMbVnKCFOEgSqzXVV1FZxH0ZPr1VhKled4C2kDqP
    zsE2HjBqBP3fZhbC2g9Mw9RWTk5+gJoUO/MgT7Z7LftROpcvsVs3gs+eQJqEm394
    wzSxU0qwb1ypFxaOuYXrSphjm0GcAt2nMpoWV15Yh3T0pz17YQFILvpENlCbRT4x
    qFUBEsfm+3ULambBkhGBsn5gLD3xkGi50+3q6hIT2HOyCJ+GwO5xn2JLWbIo7bpz
    ak4QQEljZdmdBe2j1rynXbUZFGBVXOcGBo+1jH2wDYZpdLOC4tcbMVlXFCas7WAZ
    OGs3yZcWpbPAQ0zvo4dA4UUD5saArubwdZnuSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517912254; bh=QOeiEYCwZ1IkqOax8xgFvqGRZv
    ZepcSvxPCtIfYYre0=; b=tgXGG0k2c0PoWnoAQCHAQG5xysdYVhgnm9/BRNLKMh
    Drg3i8Yd+VIWwdMLT8waE5A936R5TlcMUwrPEZq6ovyLGl/oCh3jUqVaAoJ5/hfk
    Tg1pfbCdnQ1EHtEo8ekjGvjEso0kbtJNKkDYdThdLVVI8x/6mLUbMpLpjX6H+rCW
    Ai73sOAltrIrK+pss+kCTgPyLZPEGXGuv7tFrvXKwzJsBJ9S35xXtRoyou1ajXB0
    kV39wirGnbubE9L77MlJLpTmkaz5UUSspXJxu6rNLgn//ceX6+hnE/ic6TI+y1SG
    p7jWsUeYymofwUbdxKauBvicQV7MS2r8cn51fqE+IqtQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeBFKQR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:16:17 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:44466 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeBFKPE (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 05:15:04 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC 0/6] Allow compile-testing NO_DMA
Date: Tue,  6 Feb 2018 11:14:46 +0100
Message-Id: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
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
This patch series:
  - Changes get_dma_ops() to return NULL instead,
  - Adds a few more dummies to enable compile-testing,
  - Removes dependencies on HAS_DMA for symbols that already have
    platform dependencies implying HAS_DMA.

Note that adding more platform dependencies and/or dependencies on
COMPILE_TEST is encouraged!

This may make life harder for UML, though, as UML usually satisfies all
other platform dependencies for HAS_DMA.  Similarly, HAS_IOMEM is even
more complicated.  Can/do we want to do something similar for
HAS_IOMEM?

This series is against my current local tree, which has a few more
"depends on HAS_DMA" than upstream.  Of course I will rebase, and split
the last patch per subsystem, if this RFC is welcomed positively.

Compile-tested with allmodconfig and allyesconfig for m68k/sun3.

Thanks for your comments!

Geert Uytterhoeven (6):
  [RFC] dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
  [RFC] dma-coherent: Add NO_DMA dummies for managed DMA API
  [RFC] usb: gadget: Add NO_DMA dummies for DMA mapping API
  [RFC] mm: Add NO_DMA dummies for DMA pool API
  [RFC] scsi: Add NO_DMA dummies for SCSI DMA mapping API
  [RFC] Treewide: Remove depends on HAS_DMA in case of platform
    dependency

 drivers/ata/Kconfig                             |  2 --
 drivers/crypto/Kconfig                          | 14 +++------
 drivers/firewire/Kconfig                        |  1 -
 drivers/fpga/Kconfig                            |  1 -
 drivers/gpu/ipu-v3/Kconfig                      |  1 -
 drivers/i2c/busses/Kconfig                      |  3 --
 drivers/iio/adc/Kconfig                         |  3 --
 drivers/iommu/Kconfig                           |  5 ++--
 drivers/lightnvm/Kconfig                        |  2 +-
 drivers/mailbox/Kconfig                         |  2 --
 drivers/media/pci/dt3155/Kconfig                |  1 -
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
 drivers/net/ethernet/socionext/Kconfig          |  4 +--
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
 include/linux/dma-mapping.h                     | 19 ++++++++----
 include/linux/dmapool.h                         | 21 +++++++++++--
 include/linux/usb/gadget.h                      | 12 ++++++++
 include/scsi/scsi_cmnd.h                        |  5 ++++
 sound/soc/bcm/Kconfig                           |  3 +-
 sound/soc/kirkwood/Kconfig                      |  1 -
 sound/soc/pxa/Kconfig                           |  1 -
 sound/soc/qcom/Kconfig                          |  6 ++--
 58 files changed, 108 insertions(+), 148 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
