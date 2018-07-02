Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A622C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73C424B78
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Vv5j2/oP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73C424B78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965141AbeGBKUZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:20:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59022 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeGBKUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OD8u4vM1w5jnNgPFLNihTNs5zvtt8ynR/NYrTYjXDo8=; b=Vv5j2/oPGhtfW6g9F+XuOviTH
        A+4e5ETzI+3m9c5iqfb7Ad80qMtfaqOQi//JaiV9UOpS92mb57QzCXAa5Y8c/O/0LF8M0O4BnwDOs
        ek0XyE8LunBKOc8t3UJfESqoZXLL+b3FMsFaYFrzUBkteuNvleTOwJP6x05ehlHsDx8GQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvwU-000468-DE; Mon, 02 Jul 2018 10:20:22 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvwT-00079N-TT; Mon, 02 Jul 2018 11:20:21 +0100
Date:   Mon, 2 Jul 2018 11:20:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: es7241: add es7241 codec support
Message-ID: <20180702102021.GG18211@sirena.org.uk>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
 <20180630172241.10806-3-jbrunet@baylibre.com>
 <20180702101222.GF18211@sirena.org.uk>
 <1530526503.2900.144.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Content-Disposition: inline
In-Reply-To: <1530526503.2900.144.camel@baylibre.com>
X-Cookie: A good memory does not equal pale ink.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 02, 2018 at 12:15:03PM +0200, Jerome Brunet wrote:
> On Mon, 2018-07-02 at 11:12 +0100, Mark Brown wrote:
> > On Sat, Jun 30, 2018 at 07:22:41PM +0200, Jerome Brunet wrote:

> > > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > > +	case SND_SOC_DAIFMT_I2S:
> > > +	case SND_SOC_DAIFMT_LEFT_J:
> > > +		break;

> > These two modes are not the same so either there should be some
> > different handling to select between them or one shouldn't be supported.

> Actually, the difference is provided with some pull-up/pull-down resistor.
> There no way to set this up in SW, AFAIK.
> So the driver shall accept both and trust we are not doing anything crazy

It at least needs a comment as this is obviously dodgy code.  Ideally
there'd be a DT property saying which mode was selected on a given board
so if we ever get round to doing automatic configuration of formats the
driver will be able to cope.

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5/GUACgkQJNaLcl1U
h9Dk6Qf+KpnHKNh2NZjc91/0ZUyk0RyOmMbzKit6MK+DL2ye8d7IgPmEOdsKXr0B
s6Xsm+1UMYYj9p8MwVdhKJwMqfdk42QFW52L1zWnQ+5cRXTrzDLcJ2xy8/oHdS1F
SMNa4r7mEAwyHMJjCO9ve5b9FMVi1M70zsbPRl03a+BuRvc2omqFBCF6DWkeRNUN
fdwKj3TF7ZCs0w2XsrLP5aFsSV3KwOsctvxJCwQTRgNkYFpIS9/LtX25LZHA5t0D
7HBfBbuCj4vxiJJCn97STHbcYpNyoMa6jIIYymqgoJSLJ24oNb5h1g8n79OWJdCd
/CuLIGF69EkqgWJde9xX9/PnCu06kw==
=EDSK
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
