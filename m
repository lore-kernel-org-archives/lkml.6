Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4BBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BCB217B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mD77WctR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BCB217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeHMMod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:44:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36900 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbeHMMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bJY8+7cDyeo7ssQn/oQmT5ymWLP1sHRNGUGOE2WcgmY=; b=mD77WctRbQzeAkttsamnvIlq1
        hpBZoWal0Vs2NGJNscwj5ywCRCcoF/sPs5gs+0Yz81/3nD9fotfchtd8FGNn09+RV+81Xn1Zp+5u9
        mJ3W1M3cBCzUfSUCL6CmaOM2cnW6xCCIgexyr5T9zb24UT17xEgsnrHUR08Y1zflLSnYA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fp9gg-0007sG-9j; Mon, 13 Aug 2018 10:02:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E6827112441C; Mon, 13 Aug 2018 11:02:57 +0100 (BST)
Date:   Mon, 13 Aug 2018 11:02:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL] SPI updates for v4.19
Message-ID: <20180813100257.GD6757@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
X-Cookie: Many a family tree needs trimming.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v4.19

for you to fetch changes up to c1acb21b32a3bb601453764c9eac9fc8fbb3a81d:

  Merge branch 'spi-4.19' into spi-next (2018-08-10 17:51:52 +0100)

----------------------------------------------------------------
spi: Updates for v4.19

Quite an active release for the SPI subsystem, lots of small updates and
fixes scattered about with highlights including:

 - 3 wire support in the GPIO driver.
 - Support for setting a custom memory name in the memory mapped flash
   drivers.
 - Support for extended mode in the Freescale DSPI controller.
 - Support for the non-standard integration with the Microsemi Ocelot
   platform in the DesignWare driver.
 - New driver for the SocioNext UniPhier.

----------------------------------------------------------------
Alexandre Belloni (5):
      spi: dw: fix possible race condition
      spi: dw: allow providing own set_cs callback
      spi: dw: export dw_spi_set_cs
      spi: dw-mmio: add MSCC Ocelot support
      spi: dw: document Microsemi integration

Andrey Smirnov (1):
      spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer

Bartosz Golaszewski (1):
      spi: davinci: fix a NULL pointer dereference

Boris Brezillon (1):
      spi: spi-mem: Constify spi_mem->name

Colin Ian King (1):
      spi: omap2-mcspi: remove several redundant variables

Corentin Labbe (1):
      spi: remove unused adi_spi3.h header

David Lechner (1):
      spi: spi-bitbang: change flags from u8 to u16

Esben Haabendal (12):
      spi: spi-fsl-dspi: Drop unreachable else if statement
      spi: spi-fsl-dspi: Drop unneeded use of dataflags bits
      spi: spi-fsl-dspi: Fix per transfer cs_change handling
      spi: spi-fsl-dspi: Simplify transfer counter handling
      spi: spi-fsl-dspi: Support 4 to 16 bits per word transfers
      spi: spi-fsl-dspi: Fix MCR register handling
      spi: spi-fsl-dspi: Fixup regmap configuration
      spi: spi-fsl-dspi: Add support for XSPI mode registers
      spi: spi-fsl-dspi: Framesize control for XSPI mode
      spi: spi-fsl-dspi: XSPI FIFO handling (in TCFQ mode)
      spi: spi-fsl-dspi: Advertise 32 bit for XSPI mode
      spi: spi-fsl-dspi: Enable extended SPI mode

Fabio Estevam (1):
      spi: spi-fsl-dspi: Switch to SPDX identifier

Frieder Schrempf (3):
      spi: spi-mem: Fix a typo in the documentation of struct spi_mem
      spi: spi-mem: Extend the SPI mem interface to set a custom memory name
      mtd: m25p80: Call spi_mem_get_name() to let controller set a custom n=
ame

Geert Uytterhoeven (1):
      spi: sh-msiof: Make sure all DMA operations have completed

Gustavo A. R. Silva (1):
      spi: spi-fsl-dspi: Fix copy-paste error in dspi_probe

Ionela Voinescu (1):
      spi: img-spfi: Set device select bits for SPFI port state

Jan Kundr=E1t (1):
      spi: orion: fix CS GPIO handling again

Janek Kotas (1):
      spi: cadence: Change usleep_range() to udelay(), for atomic context

Keiji Hayashibara (2):
      spi: add SPI controller driver for UniPhier SoC
      spi: uniphier: remove unnecessary include headers

Krzysztof Kozlowski (1):
      spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe

Kunihiko Hayashi (1):
      spi: add DT bindings for UniPhier SPI controller

Liang Chen (1):
      spi: rockchip: add description for px30

Lorenzo Bianconi (2):
      spi: add flags parameter to txrx_word function pointers
      spi: spi-gpio: add SPI_3WIRE support

Mark Brown (4):
      Merge branch 'spi-4.18' into spi-4.19 for DSPI dep
      Merge tag 'spi-dw-set-cs' of https://git.kernel.org/.../broonie/spi i=
nto spi-4.19
      Merge branch 'spi-4.18' into spi-linus
      Merge branch 'spi-4.19' into spi-next

Maxime Chevallier (5):
      spi: imx: Remove duplicate variable assignments
      spi: imx: Use dynamic bursts only when bits_per_word is 8, 16 or 32
      spi: imx: Use correct number of bytes per words
      spi: imx: remove unnecessary check in spi_imx_can_dma
      spi: imx: Use the longuest possible burst size when in dynamic_burst

Mika Westerberg (1):
      spi: pxa2xx: Add support for Intel Ice Lake

Tiago Brusamarello (1):
      spi: spi-fsl-espi: Log fifo counters on error

Wei Yongjun (1):
      spi: cadence: Fix missing clk_disable_unprepare() on error in cnds_ru=
ntime_resume()

 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    |   6 +-
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 .../devicetree/bindings/spi/spi-uniphier.txt       |  22 +
 drivers/mtd/devices/m25p80.c                       |   3 +
 drivers/spi/Kconfig                                |  13 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-ath79.c                            |   2 +-
 drivers/spi/spi-bitbang.c                          |  50 +-
 drivers/spi/spi-butterfly.c                        |   4 +-
 drivers/spi/spi-cadence.c                          |   4 +-
 drivers/spi/spi-davinci.c                          |   2 +-
 drivers/spi/spi-dw-mmio.c                          |  90 ++++
 drivers/spi/spi-dw.c                               |   9 +-
 drivers/spi/spi-dw.h                               |   2 +
 drivers/spi/spi-fsl-dspi.c                         | 505 +++++++++++------=
---
 drivers/spi/spi-fsl-espi.c                         |   5 +-
 drivers/spi/spi-gpio.c                             |  49 +-
 drivers/spi/spi-img-spfi.c                         |   3 +
 drivers/spi/spi-imx.c                              | 162 ++++---
 drivers/spi/spi-lm70llp.c                          |   5 +-
 drivers/spi/spi-mem.c                              |  28 ++
 drivers/spi/spi-omap2-mcspi.c                      |   9 -
 drivers/spi/spi-orion.c                            |  77 +--
 drivers/spi/spi-pxa2xx.c                           |   4 +
 drivers/spi/spi-sh-msiof.c                         |  53 ++-
 drivers/spi/spi-sh-sci.c                           |  20 +-
 drivers/spi/spi-uniphier.c                         | 523 +++++++++++++++++=
++++
 drivers/spi/spi-xtensa-xtfpga.c                    |   2 +-
 include/linux/spi/adi_spi3.h                       | 254 ----------
 include/linux/spi/spi-mem.h                        |  14 +-
 include/linux/spi/spi_bitbang.h                    |   5 +-
 31 files changed, 1253 insertions(+), 674 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
 create mode 100644 drivers/spi/spi-uniphier.c
 delete mode 100644 include/linux/spi/adi_spi3.h

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltxV1EACgkQJNaLcl1U
h9DebQf/f5F8Wt+ZnXmy7xb2tZMMWp+6mA2yLYOZF7UJ4yi+a2SsQM+wFhPQ5rqS
YsqhOfOyRusbfyVLRanZmiwN0rPJgliCbmPYHwZfqYvJNdjoOQGsVIwYxi6nsgeu
U8x87ltUCxNKUVn4c/boBLzud1uGaEDdYX6DnBbwb6pyeMREtnCcibkKS8v9j5EE
CS+CleqKu1Q6Rql4iMpfKUG89cmdsoJpbMOzHm1rqqX+JkkfCtoH8sTBh8+k6q5T
5yb4JpniqNGtQwQtYILHVUOZizPkNrIB6bDtf7EvvQXugOn0VWc0bIQLm/KW64nh
WLKtmdMmQxuSWUykmCpVcqVg479TUQ==
=tPEr
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
