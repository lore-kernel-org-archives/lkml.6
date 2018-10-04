Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820A82098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TO7RNBGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820A82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeJDRZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:25:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gGPiU8MwCannIy8crpa0wcSAS1sw/TYGmX5DDWzpca4=; b=TO7RNBGIlB0g8zTUScv0cQrFe
        ox/0uMuATvFjahSRTaZ8EroIW1/wPL1KScR0yUlTMY2ap5XjoZu5UoINDWv/OwotpLb3Esx6cSPIP
        Ko4yVxScjk4BWnAhh36hMaBibwnWIluEmpIeE8OMHYe3Rg/Api90QcMYhSkJyvYrpYyOw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g80w3-0008HR-KB; Thu, 04 Oct 2018 10:32:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3CF8E1122286; Thu,  4 Oct 2018 11:32:47 +0100 (BST)
Date:   Thu, 4 Oct 2018 11:32:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Message-ID: <20181004103247.GC6412@sirena.org.uk>
References: <20181004023926.15847-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <20181004023926.15847-1-natechancellor@gmail.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 07:39:26PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
>=20
> drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration

Please remember to CC driver maintainers and authors on patch
submissions so they can review things, copying in Hartley and Mika.

> type 'enum dma_data_direction' [-Wenum-conversion]
>         nents =3D dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir=
);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> 'dma_map_sg'
> \#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
>                                ~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir=
);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> 3 warnings generated.
>=20
> dma_{,un}map_sg expects an enum of type dma_data_direction but this
> driver uses dma_transfer_direction for everything. Converting to
> dma_data_direction would be desirable but there are a few shared
> structures that expect dma_transfer_direction so it is just simpler to
> change the parameter here. dma_transfer_direction and dma_data_direction
> are different sizes but this driver only uses the 1 and 2 values which
> mean the same thing so this change is safe.
>=20
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/spi/spi-ep93xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index f1526757aaf6..189fc2225b69 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -256,8 +256,7 @@ static int ep93xx_spi_read_write(struct spi_master *m=
aster)
>   * in case of failure.
>   */
>  static struct dma_async_tx_descriptor *
> -ep93xx_spi_dma_prepare(struct spi_master *master,
> -		       enum dma_transfer_direction dir)
> +ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
>  {
>  	struct ep93xx_spi *espi =3D spi_master_get_devdata(master);
>  	struct spi_transfer *xfer =3D master->cur_msg->state;
> @@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
>   * Function finishes with the DMA transfer. After this, the DMA buffer is
>   * unmapped.
>   */
> -static void ep93xx_spi_dma_finish(struct spi_master *master,
> -				  enum dma_transfer_direction dir)
> +static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
>  {
>  	struct ep93xx_spi *espi =3D spi_master_get_devdata(master);
>  	struct dma_chan *chan;
> --=20
> 2.19.0
>=20

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu17E4ACgkQJNaLcl1U
h9BaGAf/fV+/e0h6rs2itGWzMcx4OzEXDa6d3Whxpc9ruajYoMwZK0hkzvnNBCQZ
gz8L4JJSqds/ycFS8JHiDL93Gs9j7tQb9WoCAAReY0SjUoUak/bawG4VrtRq0qlx
w8lfCmhGMYSOJuXrA3RosGo3MgoImRk2xtE/545LXDE4a7rhfv5Q2JMHiME9r6jI
Jzmu9UlajUQahpTGiGgwyYJ0e4pJ5eqtbgtSu3dqW8TXaVLH29DnfDf7dSTCX3fs
v9Yw4OwvtwwXRoaEBp3+M/jwoyF53ncPxgD2kYI6i2V0w2kEVsdZLcVuwTUyJ+Zb
EpmKELAeQlaD5q4CFbezTAalgurhKw==
=bvKK
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
