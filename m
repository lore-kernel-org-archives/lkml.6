Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F9CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C29621780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="guMjqIzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C29621780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeKNEzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:55:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51876 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKNEzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DnVtak1nbyydFDF5nt2kRUo/xeSlY4SlRgz+EH3DTDc=; b=guMjqIzwFvedZB2XNOEO/uvx2
        VcF4n23PfyCRRwQCqv9nHBQyu9ClWXc+v4ygeysohcgQFpMPqk0M3z/IuY86Fl8XBvIgR4zskv7uD
        ZMkbkZ4L72+1+J+e+7pUf/b3+S60E3IUAQVp5Ig3hQ9RCBwyyZ5hYUFwR0jBBJ+x/Wppg=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMdqx-0002RR-Uw; Tue, 13 Nov 2018 18:56:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DF44F440078; Tue, 13 Nov 2018 18:55:53 +0000 (GMT)
Date:   Tue, 13 Nov 2018 10:55:53 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: lpspi: Add Slave Mode support for LPSPI
Message-ID: <20181113185553.GH2089@sirena.org.uk>
References: <20181112064439.28584-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline
In-Reply-To: <20181112064439.28584-1-xiaoning.wang@nxp.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 06:47:08AM +0000, Clark Wang wrote:

This looks fine so I'll apply it but it would have been easier to review
if it were split up a bit.  There's mechanical changes like:

> -static int lpspi_prepare_xfer_hardware(struct spi_master *master)
> +static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
>  {

...the conversion to controller...

> -	temp = fsl_lpspi->txfifosize >> 1 | (fsl_lpspi->rxfifosize >> 1) << 16;
> +	temp = fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;

...and this renaming which could be done separately.

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrHjcACgkQJNaLcl1U
h9CqdAf/eJJqAdJUEK87WQhfD7sBXmFhKGThuhUcgwYKb7isdl1xkibKfN5kgCvk
N12GiRmAS1BogZ+hUXthwW/VbgaZNnD86ks3gFDVtDja+2/c2naA4OUcDYPq4ufu
WGFQc0aXkIh97n4FHBITKwvSGvzh5jjwb86lK5Vs2h3aZWACxYFql4Bt82uF1oQX
0jINrdAw3Fkw3X5pUt9Nrt0RfmhGvDy+ZoD6wHIHAb6rTEfqvI+C36VGU1uq8r7G
4jVzFrRqhhPJmgnLx6u07GrpjTkYBB4tNCqLetvCcDbELXOxl/meNkgyMbAfPVri
MwKKpxO283UBVUpaAH45YPgjaQbbWw==
=X2V7
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--
