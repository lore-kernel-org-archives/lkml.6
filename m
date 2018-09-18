Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F303C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491E6206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BpbgFiO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491E6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbeIRWEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:04:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48990 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbeIRWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sURuNf7o8jwtArH6Wejpqput1UpQqnxdl9Auao8Dr7U=; b=BpbgFiO+q1Ge1fs+V9ylKosOk
        ILjmoUUEg1YGvO4LZSrV++/rwZMcCnMTBE0NFvZqJhyBjLuT1FVBbvvdsi9e0PHMCDPXPyBEKDuNK
        Xt3GvEu8TdHTkqVu1EoQPIA1jJh8vJunKzP8MX0GhnoKH9vMNHbL3YN86Ei8QjUtZu5JY=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2Itm-0003R8-Np; Tue, 18 Sep 2018 16:30:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7CA10440078; Tue, 18 Sep 2018 17:30:48 +0100 (BST)
Date:   Tue, 18 Sep 2018 09:30:48 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yt.shen@mediatek.com
Subject: Re: [PATCH v3 2/3] spis: mediatek: add spi slave for Mediatek MT2712
Message-ID: <20180918163048.GN2471@sirena.org.uk>
References: <1537150762-7072-1-git-send-email-leilk.liu@mediatek.com>
 <1537150762-7072-3-git-send-email-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline
In-Reply-To: <1537150762-7072-3-git-send-email-leilk.liu@mediatek.com>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 10:19:21AM +0800, Leilk Liu wrote:

This looks overall pretty good, a few smallish comments below:

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

>  if SPI_SLAVE
> +config SPI_SLAVE_MT27XX
> +	tristate "MediaTek SPI slave device"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  This selects the MediaTek(R) SPI slave device driver.
> +	  If you want to use MediaTek(R) SPI slave interface,
> +	  say Y or M here.If you are not sure, say N.
> +	  SPI slave drivers for Mediatek MT27XX series ARM SoCs.
> =20
>  config SPI_SLAVE_TIME

This is a driver not a slave implementation, it should be with the other
drivers in the Kconfig.  The slave implementations are for the
functionality that uses the drivers, not the drivers themselves.

> +	/* set the tx/rx endian */
> +#ifdef __LITTLE_ENDIAN
> +	reg_val &=3D ~SPIS_TX_ENDIAN;
> +	reg_val &=3D ~SPIS_RX_ENDIAN;
> +#else
> +	reg_val |=3D SPIS_TX_ENDIAN;
> +	reg_val |=3D SPIS_RX_ENDIAN;
> +#endif
> +	writel(reg_val, mdata->base + SPIS_CFG_REG);

This seems weird - it looks like it's changing the endianess of the
protocol based on the endianness the processor is running in.  What's
going on here?  I'd expect the driver to be just treating everything as
a byte stream and letting the protocol driver handle the endianness
issues, otherwise we might end up with double converions.

> +		xfer->tx_dma =3D dma_map_single(dev, (void *)xfer->tx_buf,
> +					      xfer->len, DMA_TO_DEVICE);

Why is there a cast to void here?  That's usually a sign that there's a
type safety issue, the whole point with void is that it's compatible
with any other pointer.

> +static irqreturn_t mtk_spi_slave_interrupt(int irq, void *dev_id)
> +{
> +	struct spi_controller *ctlr =3D dev_id;
> +	struct mtk_spi_slave *mdata =3D spi_controller_get_devdata(ctlr);
> +	struct spi_transfer *trans =3D mdata->cur_transfer;
> +	u32 int_status, reg_val, cnt, remainder;
> +
> +	int_status =3D readl(mdata->base + SPIS_IRQ_ST_REG);
> +	writel(int_status, mdata->base + SPIS_IRQ_CLR_REG);
> +
> +	if (!trans)
> +		return IRQ_HANDLED;

Are you sure that this is the right thing to do if we get a spurious
interrupt - the normal thing would be to return IRQ_NONE, possibly
logging a warning as well?

> +	if (int_status & CMD_INVALID_ST)
> +		dev_err(&ctlr->dev, "cmd invalid\n");

If there's an interrupt that doesn't have any of the interrupt status
flags set I'd expect to see a warning and probably IRQ_NONE being
returned.  That way if the interrupt line is shared we work correctly
and if something goes wrong and the interrupt gets stuck on then the
core interrupt code's error handling can kick in.

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhKDcACgkQJNaLcl1U
h9CQEAf8C+HMOrV3AB7YV2i/5k6xdvpMbOqH1q+eUO4Ct6kJZ9L2EsVgx12Iir3o
ujpI8qL4DKvYs8RgPjmDc/ktxYyFfeAUaz5AzJUyuGNUgaYhJjXbPtJkBcjpZ9c3
6He4fx1RWgkol/a4XLc2JBcVv8zqh9ayctLykKujLlOLUKwAvUdqSRH5tzJu7sr0
evNsuDeuGVHsOSOu1LCPO/MbWql85YL0iEHRZm2PfmYYaVf1TwMQjRjUkiUC7K8R
+4PwwLGJTNgcaePGK9r8apszvbcZwRlO6h0YClZLRp+h1TJpml9OMgXx/Y5roUxV
CVVo/lYIq+e/4M7oVePEVB0cwGv+ew==
=aBM1
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--
