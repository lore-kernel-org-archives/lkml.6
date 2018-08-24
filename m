Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B512DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086282098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="YZKc4MHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086282098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeHYC1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:27:13 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:51160 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeHYC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:27:13 -0400
Received: from localhost (ip-89-102-14-88.net.upcbroadband.cz [89.102.14.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id E122A400069;
        Sat, 25 Aug 2018 00:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1535151034;
        bh=6MQrJ6+AdV0SzHM8cZIJz2Fai7LVf22B8AlucImA9i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YZKc4MHEqtiuHgTY7szmcjwBZyI7Z8LAvh/m3DKrJkcNwYAoABWW4mXWRjFJVE98O
         iBi27Kt9F2BCcCHdTrVri32O0JwBqXcQRNflzj1dfY6aK3qkTbcg/QsDTxfl53PZAN
         IkIJsYa4pQ0ACDF3DeKM4P8uuwY+uDtqTRBMccoE=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Kosta Zertsekel <zertsekel@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: Re: [PATCH v4] spi: orion: cosmetics - alias long =?iso-8859-1?Q?direct=5Faccess_variables?=
Date:   Sat, 25 Aug 2018 00:50:33 +0200
MIME-Version: 1.0
Message-ID: <6db77ac3-dd15-4b29-8097-06fe66c17645@cesnet.cz>
In-Reply-To: <20180815190449.23738-1-zertsekel@gmail.com>
References: <20180815190449.23738-1-zertsekel@gmail.com>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On st=C5=99eda 15. srpna 2018 21:04:49 CEST, Kosta Zertsekel wrote:
> This change increases the source code readability.
> Instead of using `spi->child[cs].direct_access.XXX` use `dir_acc->XXX`.
> Instead of using `orion_spi->child[cs].direct_access.vaddr` use `vaddr`.
>
> Signed-off-by: Kosta Zertsekel <zertsekel@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/spi/spi-orion.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index d01a6adc726e..184ba91abeee 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -430,6 +430,7 @@ orion_spi_write_read(struct spi_device=20
> *spi, struct spi_transfer *xfer)
>  =09int word_len;
>  =09struct orion_spi *orion_spi;
>  =09int cs =3D spi->chip_select;
> +=09void __iomem *vaddr;
> =20
>  =09word_len =3D spi->bits_per_word;
>  =09count =3D xfer->len;
> @@ -440,8 +441,9 @@ orion_spi_write_read(struct spi_device=20
> *spi, struct spi_transfer *xfer)
>  =09 * Use SPI direct write mode if base address is available. Otherwise
>  =09 * fall back to PIO mode for this transfer.
>  =09 */
> -=09if ((orion_spi->child[cs].direct_access.vaddr) && (xfer->tx_buf) &&
> -=09    (word_len =3D=3D 8)) {
> +=09vaddr =3D orion_spi->child[cs].direct_access.vaddr;
> +
> +=09if (vaddr && xfer->tx_buf && word_len =3D=3D 8) {
>  =09=09unsigned int cnt =3D count / 4;
>  =09=09unsigned int rem =3D count % 4;
> =20
> @@ -449,13 +451,11 @@ orion_spi_write_read(struct spi_device=20
> *spi, struct spi_transfer *xfer)
>  =09=09 * Send the TX-data to the SPI device via the direct
>  =09=09 * mapped address window
>  =09=09 */
> -=09=09iowrite32_rep(orion_spi->child[cs].direct_access.vaddr,
> -=09=09=09      xfer->tx_buf, cnt);
> +=09=09iowrite32_rep(vaddr, xfer->tx_buf, cnt);
>  =09=09if (rem) {
>  =09=09=09u32 *buf =3D (u32 *)xfer->tx_buf;
> =20
> -=09=09=09iowrite8_rep(orion_spi->child[cs].direct_access.vaddr,
> -=09=09=09=09     &buf[cnt], rem);
> +=09=09=09iowrite8_rep(vaddr, &buf[cnt], rem);
>  =09=09}
> =20
>  =09=09return count;
> @@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev=
)
> =20
>  =09/* Scan all SPI devices of this controller for direct mapped devices */=

>  =09for_each_available_child_of_node(pdev->dev.of_node, np) {
> +=09=09struct orion_direct_acc *dir_acc;
>  =09=09u32 cs;
> =20
>  =09=09/* Get chip-select number from the "reg" property */
> @@ -711,14 +712,13 @@ static int orion_spi_probe(struct=20
> platform_device *pdev)
>  =09=09 * This needs to get extended for the direct SPI-NOR / SPI-NAND
>  =09=09 * support, once this gets implemented.
>  =09=09 */
> -=09=09spi->child[cs].direct_access.vaddr =3D devm_ioremap(&pdev->dev,
> -=09=09=09=09=09=09=09    r->start,
> -=09=09=09=09=09=09=09    PAGE_SIZE);
> -=09=09if (!spi->child[cs].direct_access.vaddr) {
> +=09=09dir_acc =3D &spi->child[cs].direct_access;
> +=09=09dir_acc->vaddr =3D devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
> +=09=09if (!dir_acc->vaddr) {
>  =09=09=09status =3D -ENOMEM;
>  =09=09=09goto out_rel_axi_clk;
>  =09=09}
> -=09=09spi->child[cs].direct_access.size =3D PAGE_SIZE;
> +=09=09dir_acc->size =3D PAGE_SIZE;
> =20
>  =09=09dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
>  =09}

Reviewed-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
