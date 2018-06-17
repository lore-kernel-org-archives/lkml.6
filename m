Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C70C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25D6208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25D6208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934414AbeFQRDC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 13:03:02 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:48396 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934197AbeFQRC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 13:02:58 -0400
Received: from belgarion.home ([90.55.203.186])
        by mwinf5d83 with ME
        id zt2e1x00N41oiFu03t2hKr; Sun, 17 Jun 2018 19:02:56 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 17 Jun 2018 19:02:56 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Pitre <nico@fluxnic.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Date:   Sun, 17 Jun 2018 19:02:03 +0200
Message-Id: <20180617170217.24177-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I gathered almost all the required acks, this is an information only post
before queuing to the PXA tree.

The only missing part is for netdev, for which I'd like an ack from netdev
people for patches 0007 and 0008, but that won't prevent me from queuing all the
other patches (excepting the patch 0012 which can only be applied once 0007 and
0008 are queued).

Cheers.

--
Robert

Robert Jarzmik (14):
  dmaengine: pxa: use a dma slave map
  ARM: pxa: add dma slave map
  dmaengine: pxa: add a default requestor policy
  mmc: pxamci: remove the dmaengine compat need
  media: pxa_camera: remove the dmaengine compat need
  mtd: rawnand: marvell: remove the dmaengine compat need
  net: smc911x: remove the dmaengine compat need
  net: smc91x: remove the dmaengine compat need
  ASoC: pxa: remove the dmaengine compat need
  ata: pata_pxa: remove the dmaengine compat need
  dmaengine: pxa: document pxad_param
  dmaengine: pxa: make the filter function internal
  ARM: pxa: remove the DMA IO resources
  ARM: pxa: change SSP DMA channels allocation

 arch/arm/mach-pxa/devices.c           | 148 +---------------------------------
 arch/arm/mach-pxa/devices.h           |   6 +-
 arch/arm/mach-pxa/pxa25x.c            |  38 ++++++++-
 arch/arm/mach-pxa/pxa27x.c            |  39 ++++++++-
 arch/arm/mach-pxa/pxa3xx.c            |  41 +++++++++-
 arch/arm/plat-pxa/ssp.c               |  47 -----------
 drivers/ata/pata_pxa.c                |  10 +--
 drivers/dma/pxa_dma.c                 |  18 ++++-
 drivers/media/platform/pxa_camera.c   |  22 +----
 drivers/mmc/host/pxamci.c             |  29 +------
 drivers/mtd/nand/raw/marvell_nand.c   |  17 +---
 drivers/net/ethernet/smsc/smc911x.c   |  13 +--
 drivers/net/ethernet/smsc/smc91x.c    |   9 +--
 drivers/net/ethernet/smsc/smc91x.h    |   1 -
 include/linux/dma/pxa-dma.h           |  20 +++--
 include/linux/platform_data/mmp_dma.h |   4 +
 include/linux/pxa2xx_ssp.h            |   2 -
 sound/arm/pxa2xx-ac97.c               |  14 +---
 sound/arm/pxa2xx-pcm-lib.c            |   6 +-
 sound/soc/pxa/pxa-ssp.c               |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c           |  32 ++------
 sound/soc/pxa/pxa2xx-i2s.c            |   6 +-
 22 files changed, 176 insertions(+), 351 deletions(-)

-- 
2.11.0

