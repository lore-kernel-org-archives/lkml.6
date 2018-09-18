Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA2EECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DE121473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W9dgsVKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DE121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeIRInM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:43:12 -0400
Received: from ozlabs.org ([203.11.71.1]:54035 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbeIRInM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:43:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Dp2b04yjz9sCP;
        Tue, 18 Sep 2018 13:12:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537240361;
        bh=0z9xYhWAgxx/D2oqZTlyYD4Egu84LuJ7vvQs3L3Xfm4=;
        h=Date:From:To:Cc:Subject:From;
        b=W9dgsVKLkLELCRrx/l/ZxAsbrYqQ1AcD1UuTpveTQBKP1g0tpdl3t0/7pSKbwPOpp
         GmD0sASlNh1Pfi15gWAsI0oABw5MoDnByrvJ9L/CExYpx7LLNdM2Pht00jnJLm7Zyl
         /Otw11MvvR1TwncrAM3+QNR2z7qElifI9SHUgiHUnBMZeCQ4JJ3qbTVLW2sYKyodpn
         q7fEZdTTgE+F2hlsWuCOwUMpjNu18eb/QG8J8frsknIQa0Ejs/Khq5q6xUqowbJYxR
         DAD+5P1sytAUR6auhGg6w9dIKPJR4D9CTU/bvvcxzntHwBknZ5N6rcwAx0Uu1MxnYM
         34sStkWs1Sa8Q==
Date:   Tue, 18 Sep 2018 13:12:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
Subject: linux-next: manual merge of the staging tree with the at91 tree
Message-ID: <20180918131238.2838bedd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PVGMmhdyduetp4fvNQ4zjyq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PVGMmhdyduetp4fvNQ4zjyq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  MAINTAINERS

between commit:

  5ae2f1f30197 ("MAINTAINERS: move former ATMEL entries to proper MICROCHIP=
 locatioat91n")

from the at91 tree and commit:

  010de20412fc ("MAINTAINERS: Add entry for mcp3911 ADC driver")

from the staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 0d01245ef7b4,7f77f2c837a8..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9539,72 -9582,14 +9554,80 @@@ L:	netdev@vger.kernel.or
  S:	Maintained
  F:	drivers/net/ethernet/microchip/lan743x_*
 =20
 +MICROCHIP LCDFB DRIVER
 +M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 +L:	linux-fbdev@vger.kernel.org
 +S:	Maintained
 +F:	drivers/video/fbdev/atmel_lcdfb.c
 +F:	include/video/atmel_lcdc.h
 +
+ MICROCHIP / ATMEL MCP3911 ADC DRIVER
+ M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+ M:	Kent Gustavsson <kent@minoris.se>
+ L:	linux-iio@vger.kernel.org
+ S:	Supported
+ F:	drivers/iio/adc/mcp3911.c
+ F:	Documentation/devicetree/bindings/iio/adc/mcp3911.txt
+=20
 +MICROCHIP MMC/SD/SDIO MCI DRIVER
 +M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 +S:	Maintained
 +F:	drivers/mmc/host/atmel-mci.c
 +
 +MICROCHIP NAND DRIVER
 +M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 +L:	linux-mtd@lists.infradead.org
 +S:	Supported
 +F:	drivers/mtd/nand/raw/atmel/*
 +F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 +
 +MICROCHIP PWM DRIVER
 +M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 +L:	linux-pwm@vger.kernel.org
 +S:	Supported
 +F:	drivers/pwm/pwm-atmel.c
 +F:	Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 +
 +MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 +M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 +M:	Eugen Hristev <eugen.hristev@microchip.com>
 +L:	linux-iio@vger.kernel.org
 +S:	Supported
 +F:	drivers/iio/adc/at91-sama5d2_adc.c
 +F:	Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
 +F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
 +
 +MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
 +M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 +S:	Supported
 +F:	drivers/power/reset/at91-sama5d2_shdwc.c
 +
 +MICROCHIP SPI DRIVER
 +M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 +S:	Supported
 +F:	drivers/spi/spi-atmel.*
 +
 +MICROCHIP SSC DRIVER
 +M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 +S:	Supported
 +F:	drivers/misc/atmel-ssc.c
 +F:	include/linux/atmel-ssc.h
 +
 +MICROCHIP TIMER COUNTER (TC) AND CLOCKSOURCE DRIVERS
 +M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 +S:	Supported
 +F:	drivers/misc/atmel_tclib.c
 +F:	drivers/clocksource/tcb_clksrc.c
 +
 +MICROCHIP USBA UDC DRIVER
 +M:	Cristian Birsan <cristian.birsan@microchip.com>
 +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 +S:	Supported
 +F:	drivers/usb/gadget/udc/atmel_usba_udc.*
 +
  MICROCHIP USB251XB DRIVER
  M:	Richard Leitner <richard.leitner@skidata.com>
  L:	linux-usb@vger.kernel.org

--Sig_/PVGMmhdyduetp4fvNQ4zjyq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlugbSYACgkQAVBC80lX
0Gyjlgf9EQBmHue1/UulNgRvJjC/Ik0nAPMZ7gPR/1cc34+IQRepuISnGw94dsLN
La6Im9fnJY1Yn2OcaQV9nf7ODw7DTeNB5TZrZ1aErTrNcuUnRm2YZhucfD8auNyI
lG7Y5jm0PPBL/uVYHHpnklGB3f7vM0ptLQhfxO5dljsIWPbKfI1OcoTym3KMxNOz
2kaNR6jgaZ7YyrPvblkMEzjPpm6w/5WHjp+g+HsWLOAise/5O0e8/Y190hcLAmNp
zoEL1rniQZLtLXdGzR8HqQRPtOeDGmNojM6nY1cEgBRvPb2CVpma4E5Fxga8UQTX
vt9BM4JlIbvGOeIOhQPVp6oCpgUENQ==
=GIWb
-----END PGP SIGNATURE-----

--Sig_/PVGMmhdyduetp4fvNQ4zjyq--
