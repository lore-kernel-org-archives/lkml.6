Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82087C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0CA2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547838731;
	bh=OlbwiYNH5rDIXXiez5bIwPddtjsFVLPd/UkGBdo/cGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EjXSeSxZkGEKb049XVU5gOjmLsYWXcBOY0ZEcozWtTdfcj37HkOHfW3lKIh3FNuMz
	 0+g6vS+q+5LCMrv3A+UC8tpFmXdGbuzXXTbV5KImF287Fel5HA9wALmGER2aHJTpWu
	 9DRCdlh3M2lQzYowJOrIIwYhBWeYWY8clgAS9wMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfARTMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:12:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbfARTMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iTfN4IZcke/gzOJ1Ua6kwNvEgiE6Jf880CODCiJIqDc=; b=qn6Fc6he6I6Xu6gKHw6ISt2ou
        iKfVa0KkOLy+eWiA+z+y9sCV+BtiA5d//191cgG9MvzfGNkP4OH+zuP5fzguN/bzBhz6cMSrpC58I
        t5K0WoenlGVBrV6eABTSN3vbvchF1trkGS0UY8qlUzAJK2hK8I2ETYSvIu7Y7viIxjPCA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkZYh-0005XH-FC; Fri, 18 Jan 2019 19:12:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 09C7A11276E7; Fri, 18 Jan 2019 19:12:03 +0000 (GMT)
Date:   Fri, 18 Jan 2019 19:12:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     kernel@martin.sperl.org
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Message-ID: <20190118191202.GG6260@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
 <20190115212539.GK5522@sirena.org.uk>
 <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 06:11:31PM +0100, kernel@martin.sperl.org wrote:

> Does something like this looks acceptable?

> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index ec210286567c..677fc5025033 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -288,6 +288,21 @@ static inline void spi_unregister_driver(struct spi_=
driver *sdrv)
>  	module_driver(__spi_driver, spi_register_driver, \
>  			spi_unregister_driver)
>=20
> +/* define SPI Controller states in the state machine */
> +enum spi_controller_state {
> +	SPI_CONTROLLER_STATE_SHUTDOWN		=3D 0,
> +	SPI_CONTROLLER_STATE_IDLE		=3D 1,
> +	SPI_CONTROLLER_STATE_IN_PROCESS		=3D 2,
> +	SPI_CONTROLLER_STATE_IN_TRANSFER	=3D 3,
> +};

Yes, it does!

> SPI_CONTROLLER_MODE_EXCLUSIVE could replace the bus_lock_flag.
> I am also not sure of the =E2=80=9Cconvention=E2=80=9D of memory mode (i.e
> using mem_ops). Is it maybe implicitly spi_bus_locked - i.e
> typically only a single device?

Yes, it does - we're basically handing over the entire SPI bus to
another bit of hardware that will do memory mapped flash access so we
can't really have anything else trying to do SPI operations at the same
time.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCJQIACgkQJNaLcl1U
h9CDdQf+I7iveblkgIuqYYemfISQk+f97Jh7CYalr7//EB65ABrPeVKbeWdEWNEd
O3lQckS5I1XBelmk78Kw1keMvy7yev5LKvadKyXMIS/HPOaCaC8GnuVQ039Zk0iX
tIeK/uCe2Its32BjZ5b0WbDt68JInIEpf7iuqTQs7hVDmvmx2TovvbXdSkoaqkpU
qx8wkH0+sxeLLqBelfzvsy7J3ETSRd+c6Je3gCH9Jk15qYO8x+XdY6PRL+3Pz5zs
U3gVWY8cwTD4v7tORNPNi0W8oB01KoXcrk7cvCUteYS3nSVn2h5GKO05IDrDlhAO
+5qJMOnCzhhWFsctQcfxD0kQI+tBCA==
=0ySs
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
