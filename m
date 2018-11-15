Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E321DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37F621582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FY0M0kH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37F621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeKPFfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:35:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51654 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeKPFfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3mO5Dd8UQNU8zL+LkfXnveXCHNR8AdDRE5SR1EvOE3g=; b=FY0M0kH7HyZrUZDBzTA6lCsOa
        AUdKfyyjjQfLegrTtXD/u8edE7rkNzVjybvKNsr115XryAv4rOIgh2KmqTkZq1t81xR488D6+vEQW
        AP5odErbNJsUcrlSw0pvLLaFIT7VTOizp6CeNDPAupa4ktwl6JwcA/r+UX5Tyz02PqQkI=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNNHh-0006DU-HU; Thu, 15 Nov 2018 19:26:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BDA62440078; Thu, 15 Nov 2018 19:26:31 +0000 (GMT)
Date:   Thu, 15 Nov 2018 11:26:31 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the spi tree
Message-ID: <20181115192631.GN2089@sirena.org.uk>
References: <20181114131844.57c4cdc7@canb.auug.org.au>
 <CAP6Zq1gp+hmNkvk8D2uv8FUqTXE4+ZMPhMB7A7vLMaM6swHy4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Is40wmw6z7H9MUbF"
Content-Disposition: inline
In-Reply-To: <CAP6Zq1gp+hmNkvk8D2uv8FUqTXE4+ZMPhMB7A7vLMaM6swHy4g@mail.gmail.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Is40wmw6z7H9MUbF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 05:56:19PM +0200, Tomer Maimon wrote:
> Hi Mark and Stephen,
>=20
> I saw the warning from the kbuilt, in this matter the ioread() function
> will call every time (and the val parameter will used) because rsize can =
be
> 1 or 2.
>=20
> rsize =3D min(bytes_per_word(priv->bits_per_word), priv->rx_bytes);
> bytes_per_word(priv->bits_per_word)function return 1 or 2.
> npcm_pspi_recv()function will called only if parameter priv->rx_bytes is
> not 0.
>=20
> please let me know if you think that I still need to modify the npcm_pspi=
_recv
> to fix kbuilt warning.

Please, it's going to create noise for people working on the kernel if
they get a spurious warning.

--Is40wmw6z7H9MUbF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvtyGYACgkQJNaLcl1U
h9B2Ugf+KfiAeQh/AfrlCM6c7MGPjhJIFE5rf1lfbyZUZjyvPW7X6Y8uERPTR8E+
D/bM4oAtrredlxKjH0qXnHU/EIa5CQBBcg6B32dBMHoRCNJxkbf2Vkhnbyybo4h0
a+NnBAnMSq3JbzuCmiQApamTKzfL11Ap9ZD4A/k0R02s41aYEF2tnPo8fuKBrzxu
Q2K2a02vfOgHFgldYUp1l+v6BN1amRvJI0ILnR2FxlUAs3ditlKZcsSdWE1f3GHa
TpoSvi8f94+SfY2HJkgaENHxpsI9J/qO+sRDYaJg/qG7kDUzCXjdkz4DEQY4+xPb
CBzAqM9YXOQWm1N9B0Be2XB1UeBp6A==
=v4i6
-----END PGP SIGNATURE-----

--Is40wmw6z7H9MUbF--
