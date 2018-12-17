Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B820C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3820645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545049554;
	bh=pH3CTfHYeTJZLO/EUISP3PD7oYboE1PBQjw/F9qlMsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gZlImOzZEoRpTA7dLBLCUltJN/L6iFXB9Swn4tO9wcKtZeE+RNDLZWZuA47Ru0fp7
	 FJCqd4hWF2eT5uo/giL7i1RxX689K30oh8VCsdB634lUvPBbdMVikqsqIvtaTyAdA0
	 x20tPMn5XZYTY+z2xFEZP5v6nBqwqEv3eDNSG24g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeLQMZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:25:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57648 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeLQMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3WFdU4qSO6Hgi+thGtI+oxboQAbbMHRKvsF3TNofctA=; b=lDrxR5HutxsJqK5B7E0mVqIFi
        nEeW/s+Xi+x1M/CDkHAl7hu5ZoZgGfR8j9PzN1VvjYeLqx8AFZHby/E/BjFAHhjPFZvX2M+zgUeGV
        aNvFDzR8VakeVGFWdatFs34knh/Fl904QzTYDqpKsooKDop9Lh7TrV1sGDsINAqNgjwuE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gYry3-0002Hv-9T; Mon, 17 Dec 2018 12:25:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F3C48112593B; Mon, 17 Dec 2018 12:25:50 +0000 (GMT)
Date:   Mon, 17 Dec 2018 12:25:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181217122550.GD13868@sirena.org.uk>
References: <20181215082148.26511-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20181215082148.26511-1-tiny.windzz@gmail.com>
X-Cookie: You're at the end of the road again.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 15, 2018 at 03:21:48AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

> +#ifdef CONFIG_DEBUG_FS
>  	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
>  			    &supply_map_fops);
> =20
>  	debugfs_create_file("regulator_summary", 0444, debugfs_root,
>  			    NULL, &regulator_summary_fops);
> -
> +#endif

This appears to be an unrelated change not mentioned in your changelog?

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXlc4ACgkQJNaLcl1U
h9A19gf9HJ2nFOeqMx/fw1G119rvZtsqi4Ny9r5hbJSv7AmJrt1dksg+yh22iMLb
CN+N7fgNu1lBl3lmFNzvoiWcgiHH0vT9A/U/b8Ovz9GlnNKtN+ima8I941lFOdT+
+sir7UNTouF5EJQWPYUQ12GAx2zJVa5WDQ9BILluhsSvxZcac6gzlxzpJ/mCMIkr
oP+RHV6zIJMXTMZfbBnz15o2Hez3xgK3ulgV74NbncywNR5bDIYXGkrtlCIlvow0
JRwMq3W6hPbamGgyRED9djPKcUeef1sES3/sfJlJrHjiEuq6ghE89ZtaDf8VLTmt
/I1jDyrD3h3/ckNNEm3Bfv7fd9ajaQ==
=s75o
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
