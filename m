Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B1EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E7020862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UwavPNW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E7020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeH2Pnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:43:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54720 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeH2Pnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wJ6axHtrNrCXyZuU6mdlhC+hCiuhek14f9X70lPIuBY=; b=UwavPNW9dSCg3uJ1eug64ov6K
        9f2t2AxM0eNBhjYd38UErqrtz4xEC+9FXR5HUYWU+diQR3oYb8qxQ/7WBRCEw4QXTDNf6eXf/Lsvf
        h2L6JfWnB1zyCB8AARII9A+dq0GMnvIzWnP0FoH66imeuzZdQNCGwhRKNnYRQHxWBmt4o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fuywF-0008VY-9W; Wed, 29 Aug 2018 11:47:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D64151124859; Wed, 29 Aug 2018 12:47:05 +0100 (BST)
Date:   Wed, 29 Aug 2018 12:47:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] spi: Introduce one new field to set word delay
Message-ID: <20180829114705.GC27808@sirena.org.uk>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
 <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
X-Cookie: Not every question deserves an answer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 01:33:24PM +0200, Jan Kundr=C3=A1t wrote:
> On =C4=8Dtvrtek 16. srpna 2018 14:54:49 CEST, Baolin Wang wrote:
> > + * @word_delay: clock cycles to inter word delay after each word size
> > + *	(set by bits_per_word) transmission.

> The description can be improved because it left me wondering what "clock
> this is about. I suppose it's about the SPI clock cycles and not CPU clock
> cycles, right? I'll be hapy to patch this once Baolin confirms that that =
is
> the intended meaning.

That's certainly how I read it.

> It seems that this is only implemented in one newly added driver. I'm
> interested in supporting this in spi-orion.c, but that sounds like
> driver-specific work for something which is pretty generic. How should th=
is
> be implemented? Given that drivers for SPI masters can implement a functi=
on
> which transfers several words at once, there are not that many better
> possibilities than adding udelay()s, though. Thoughts?

Yeah, you'd need to split the transfer into words and then add a delay
between which would be rather expensive but it's about as good as we can
get I think.

> What is your plan to do with drivers which do not implement this (yet)? I=
f a
> spi_transfer gets queued which asks for a word_delay delay, it is silently
> ignored now, AFAIU.

Yes.  A generic handler would be best.

> What about userspace support, spidev and spi_ioc_transfer (that's my targ=
et,
> actually)? Is it OK to s/pad/word_delay/ in the spidev code and pass that=
 to
> the generated struct spi_transfer? In my opinion, once we support specify=
ing
> this from userspace, one has to definitely check that the SPI controller =
is
> ready to honor this request. Do we want a new bit in spi_controller.flags
> for this?

Not seeing pad in the spidev code?  A feature flag would make sense along
with a generic implementation.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluGh7kACgkQJNaLcl1U
h9BTMgf/WsVnPfRsreSpuhbtndOSz23d4L5il38ytg2aGPqBlmb0zOOL6R/O54sm
kqmLj8hmcyudwQtWslTsqqnRXEwvQnIMBXKIW0ah6eA1nPulgQMaq8rWatGqcF/f
H6Sv6tYoQk1pCBpfgoINoPelAd8RyG/kgrSmxf1W4oUGv2m4Ejkaaujah7smUed8
chJQ055evB+dBOr/j8MRc9rsguA5z6dZwVNAqnLbzZBpAlqloBtC9CfRLCWbgkgD
F+Zxp2ZK78tfxIyaPIAnhdtI239vf21j9wy2+WvjtKE0LLERCF0bc957aGDWgUAB
KaMI6qlq2ikq44ged3Dx70VgxF3o8Q==
=LMiq
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
