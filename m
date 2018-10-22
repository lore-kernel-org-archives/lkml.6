Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08498C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9751520658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="H0UxLfqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9751520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeJVUla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:41:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53348 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+QVH748DYYVBcomGccWJHDwAsEC2687UTNdQuwQasYs=; b=H0UxLfqW9P1n6WaKF73dv2JTK
        ZaXMF3vUKoeCqRxbujhJaSsZHxRUXlDLkUNpaoDJiXj96brG0b8ZeNq+JgL6OgfObqOV/MfwldivV
        viKNpZESdNDYtD4g8QEJGtCMdXbMrju3a5AmKZZbHGDPOJ7AalVO5UzM6t6x6AUILbjLg=;
Received: from [167.98.65.38] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEZEg-0006AN-26; Mon, 22 Oct 2018 12:23:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7256F440078; Mon, 22 Oct 2018 14:23:05 +0200 (CEST)
Date:   Mon, 22 Oct 2018 13:23:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] SPI updates for the next release
Message-ID: <20181022122305.GD2103@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:

  Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v5.0

for you to fetch changes up to 7b9734dbc5b042bb8d8d930797f346b280057c4e:

  Merge remote-tracking branch 'spi/topic/of' into spi-next (2018-10-21 17:=
00:17 +0100)

----------------------------------------------------------------
spi: SPI updates for v5.0

One new core feature here, a small collection of new drivers and a bunch
of small improvements in existing drivers.

 - A new CS_WORD flag for transfers where the chip select is toggled at
   every word, with both a generic implementation and the ability for
   controllers to do this automatically (including a DaVinci one).
 - New drivers for Mediatek MT2712, Qualcomm GENI and QSPI, Spreadtrum
   SPI and ST STM32 QSPI plus new IDs for several existing ones.

----------------------------------------------------------------
A.s. Dong (1):
      spi: lpspi: add imx8qxp compatible string

Alexandre Belloni (2):
      spi: dw-mmio: add MSCC Jaguar2 support
      spi: dw-mmio: avoid hardcoded field mask

Alexey Khoroshilov (2):
      spi: pic32: remove unnecessary of_node_get()
      spi: pic32-sqi: remove unnecessary of_node_get()

Arnd Bergmann (1):
      spi: sprd: don't mark remove function as __exit

Axel Lin (1):
      spi: rb4xx: Use SPI_BPW_MASK to set bits_per_word_mask

Baolin Wang (1):
      spi: Introduce one new field to set word delay

Biju Das (2):
      dt-bindings: spi: rspi: Add r8a7744 to the compatible list
      dt-bindings: spi: sh-msiof: Add r8a7744 support

Boris Brezillon (1):
      spi: spi-mem: Add extra sanity checks on the op param

Chris Brandt (1):
      dt-bindings: spi: rspi: Add R7S9210 support

Christoph Hellwig (1):
      spi: pic32-sqi: don't pass GFP_DMA32 to dma_alloc_coherent

Chuanhua Han (1):
      spi: spi-mem: Adjust op len based on message/transfer size limitations

David Lechner (5):
      spi: add new SPI_CS_WORD flag
      spi: add software implementation for SPI_CS_WORD
      spi: spi-davinci: Add support for SPI_CS_WORD
      spi: always use software fallback for SPI_CS_WORD when using cs_gio
      spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio

Dilip Kota (2):
      dt-bindings: soc: qcom: Remove SPI controller maximum frequency bindi=
ng
      spi: soc: qcom: GENI SE SPI controller device tree binding

Douglas Anderson (2):
      soc: qcom: geni: Don't ignore clk_round_rate() errors in geni_se_clk_=
tbl_get()
      soc: qcom: geni: geni_se_clk_freq_match() should always accept multip=
les

Emil Renner Berthing (4):
      spi: rockchip: remove unneeded dma_caps
      spi: rockchip: mark use_dma as bool
      spi: rockchip: directly use direction constants
      spi: rockchip: simplify spi enable logic

Fabrizio Castro (1):
      spi: sh-msiof: Add r8a774a1 support

Florian Fainelli (2):
      MAINTAINERS: Add entry for Broadcom SPI controller
      spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs

Geert Uytterhoeven (4):
      spi: sh-msiof: Document R-Car E3 support
      spi: spidev_test: Improve decoded text part of hex dump
      spi: Do not print a message if spi_controller_{suspend,resume}() fails
      spi: spi-mem: Fix inverted logic in op sanity check

Girish Mahadevan (3):
      spi: Qualcomm Quad SPI(QSPI) documentation
      spi: Introduce new driver for Qualcomm QuadSPI controller
      spi: spi-geni-qcom: Add SPI driver support for GENI based QUP

Gustavo A. R. Silva (2):
      spi: slave: Fix missing break in switch
      spi: pxa2xx: Rewrite switch code block in interrupt_transfer

Hieu Tran Dang (1):
      spi: fsl-lpspi: Prevent FIFO under/overrun by default

Huibin Hong (2):
      spi: rockchip: initialize dma_slave_config properly
      spi: rockchip: adjust dma watermark and burstlen

Jonas Gorski (1):
      spi/bcm63xx-hsspi: keep pll clk enabled

Kosta Zertsekel (1):
      spi: orion: cosmetics - alias long direct_access variables

Lanqing Liu (2):
      spi: Add Spreadtrum SPI controller documentation
      spi: sprd: Add SPI driver for Spreadtrum SC9860

Leilk Liu (2):
      spi: mediatek: add bindings for Mediatek MT2712 soc platform
      spi: mediatek: add spi slave for Mediatek MT2712

Linus Walleij (2):
      spi: gpio: No MISO does not imply no RX
      spi: davinci: Remove chip select GPIO pdata

Lubomir Rintel (5):
      spi: pxa2xx: Remove the shutdown callback
      spi: pxa2xx: Use an enum for type
      spi: pxa2xx: Add devicetree support
      spi/spi-pxa2xx: add PXA2xx SSP SPI Controller
      PCI: Provide pci_match_id() with CONFIG_PCI=3Dn

Ludovic Barre (2):
      dt-bindings: spi: add stm32 qspi controller
      spi: spi-mem: add stm32 qspi controller

Lukasz Majewski (1):
      spidev: Enable the Liebherr's BK4 board to work with spidev driver

Marco Felsch (2):
      spi: switch to SPDX license identifier
      spi: make OF helper available for others

Mark Brown (5):
      Merge tag 'spi-cs-word' into spi-4.20
      Merge tag 'qcom-geni-immutable-for-mark-brown' of git://git.kernel.or=
g/.../agross/linux into spi-4.20
      Merge branch 'spi-4.19' into spi-linus
      Merge branch 'spi-4.20' into spi-next
      Merge remote-tracking branch 'spi/topic/of' into spi-next

Nathan Chancellor (2):
      spi: pic32: Use proper enum in dmaengine_prep_slave_rg
      spi: spi-ep93xx: Use dma_data_direction for ep93xx_spi_dma_{finish,pr=
epare}

Peter Shih (1):
      spi: mediatek: Don't modify spi_transfer when transfer.

Phil Elwell (1):
      spi: Make GPIO CSs honour the SPI_NO_CS flag

Rafa=C5=82 Mi=C5=82ecki (2):
      spi: bcm-qspi: fix calculation of address length
      spi: bcm-qspi: switch back to reading flash using smaller chunks

Robin Gong (3):
      spi: imx: move wml setting to later than setup_transfer
      spi: imx: correct wml as the last sg length
      spi: imx: use PIO mode if size is small

Sergei Shtylyov (2):
      spi: sh-msiof: fix deferred probing
      spi: sh-msiof: document R8A779{7|8}0 bindings

Simon Goldschmidt (1):
      spi: dw: support 4-16 bits per word

Stephen Boyd (1):
      soc: qcom: geni: Make version macros simpler

Talel Shenhar (2):
      spi: dw: add compatible for Amazon's Alpine spi controller
      dw: spi: add support for Amazon's Alpine spi controller

Trent Piepho (2):
      spi: Add driver_override SPI device attribute
      spi: spidev: Fix OF tree warning logic

Ulrich Hecht (1):
      spi: sh-msiof: Document R-Car D3 support

Vignesh R (3):
      spi: omap2-mcspi: Switch to readl_poll_timeout()
      spi: omap2-mcspi: Set FIFO DMA trigger level to word length
      spi: omap2-mcspi: Add slave mode support

Wolfram Sang (1):
      spi: use SPDX identifier for Renesas drivers

YueHaibing (4):
      spi: davinci: remove set but not used variable 'pdata'
      spi: spi-gpio: Remove set but not used variable 'pdata'
      spi: pl022: Remove set but not used variable 'chip'
      spi: davinci: remove set but not used variable 'pdata'

 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  29 +-
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt |  39 ++
 .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt |  36 +
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   8 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    |   2 +-
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      |   1 +
 .../devicetree/bindings/spi/spi-pxa2xx.txt         |  24 +
 Documentation/devicetree/bindings/spi/spi-rspi.txt |   4 +-
 .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |  32 +
 Documentation/devicetree/bindings/spi/spi-sprd.txt |  26 +
 .../devicetree/bindings/spi/spi-stm32-qspi.txt     |  44 ++
 MAINTAINERS                                        |   9 +
 drivers/soc/qcom/qcom-geni-se.c                    |  41 +-
 drivers/spi/Kconfig                                |  45 +-
 drivers/spi/Makefile                               |   5 +
 drivers/spi/spi-atmel.c                            |  10 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |  20 +-
 drivers/spi/spi-davinci.c                          |  19 +-
 drivers/spi/spi-dw-mmio.c                          |  38 +-
 drivers/spi/spi-dw.c                               |  28 +-
 drivers/spi/spi-dw.h                               |   2 +
 drivers/spi/spi-ep93xx.c                           |  36 +-
 drivers/spi/spi-fsl-espi.c                         |   4 +-
 drivers/spi/spi-fsl-lpspi.c                        |   2 +-
 drivers/spi/spi-geni-qcom.c                        | 703 +++++++++++++++++=
++
 drivers/spi/spi-gpio.c                             |  12 +-
 drivers/spi/spi-imx.c                              |  53 +-
 drivers/spi/spi-mem.c                              |  69 +-
 drivers/spi/spi-mt65xx.c                           |  37 +-
 drivers/spi/spi-omap2-mcspi.c                      | 177 +++--
 drivers/spi/spi-orion.c                            |  22 +-
 drivers/spi/spi-pic32-sqi.c                        |   4 +-
 drivers/spi/spi-pic32.c                            |   6 +-
 drivers/spi/spi-pl022.c                            |  10 +-
 drivers/spi/spi-pxa2xx.c                           | 100 +--
 drivers/spi/spi-qcom-qspi.c                        | 581 ++++++++++++++++
 drivers/spi/spi-rb4xx.c                            |   2 +-
 drivers/spi/spi-rockchip.c                         |  62 +-
 drivers/spi/spi-rspi.c                             |  10 +-
 drivers/spi/spi-sh-hspi.c                          |  12 +-
 drivers/spi/spi-sh-msiof.c                         |  10 +-
 drivers/spi/spi-sh.c                               |  12 +-
 drivers/spi/spi-slave-mt27xx.c                     | 554 +++++++++++++++
 drivers/spi/spi-slave-system-control.c             |   1 +
 drivers/spi/spi-sprd.c                             | 745 +++++++++++++++++=
++++
 drivers/spi/spi-stm32-qspi.c                       | 512 ++++++++++++++
 drivers/spi/spi.c                                  | 106 ++-
 drivers/spi/spidev.c                               |   9 +-
 include/linux/pci.h                                |   4 +
 include/linux/platform_data/spi-davinci.h          |   4 -
 include/linux/pxa2xx_ssp.h                         |   3 +-
 include/linux/qcom-geni-se.h                       |  13 +-
 include/linux/spi/spi.h                            |  36 +-
 tools/spi/spidev_test.c                            |   6 +-
 55 files changed, 3979 insertions(+), 404 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qco=
m.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qsp=
i.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.=
txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
 create mode 100644 drivers/spi/spi-geni-qcom.c
 create mode 100644 drivers/spi/spi-qcom-qspi.c
 create mode 100644 drivers/spi/spi-slave-mt27xx.c
 create mode 100644 drivers/spi/spi-sprd.c
 create mode 100644 drivers/spi/spi-stm32-qspi.c

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvNwSgACgkQJNaLcl1U
h9Buzgf7B/o/5vI0NUxnxTuz7v7VhheZdUYfnCEpBs20F0MsQ9z7rfplaD5WQdlx
IPY+pMxxq3gK1cS6GtdFC7Vntge7hI5HTNiiHl8x25EY3WQ0BA0CL0bnXvNIlZm3
HeFHHbHNce5vkyczDJlstrGc3JwcqnlvsRHH2gcLDOJqaWnBhVu0rU3IT0y8eo3e
uJup/quprzhTXbuuyrLZ4cxYjqc4/hMDvqcjmSZzO6PDaLF88TaENxtMBAfAywYd
KyK0bDNXXIPgcwJwRT5GNxQ37yo7rjMnhFiDThN7t3qdwDTIrgzNJ1jH3iu+c16W
d9vvy1YmPjd+DDrF6WSixXIAw0Ec+A==
=pbtj
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
