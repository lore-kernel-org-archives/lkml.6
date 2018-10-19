Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F082DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B548D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BvdaBSOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B548D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJTANk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:13:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeJTANj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dsLXfaLWiIOGfI/4tSeP5DQ5iEvDOCdPLCQDZb5sWN0=; b=BvdaBSOTRxbJjkSDAK5Mk6u8m
        hQUSPgGvdbaIuuiFDlV7vVu5WDTWe+2Guzg/h7oI/0dT06spD9McQlBBtj0E+eyTCyuomQbYuEpw+
        kWfYL2m8N+qtbfWfef93GKMYyJnvC6Gli2YDt0nXrFEsWvOExO2eGNB7uARr1yxIfO908=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDXI7-0000Oy-3h; Fri, 19 Oct 2018 16:06:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8FB901122548; Fri, 19 Oct 2018 17:06:22 +0100 (BST)
Date:   Fri, 19 Oct 2018 17:06:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@st.com
Subject: Re: [PATCH 1/1] ASoC: cs42l51: fix mclk support
Message-ID: <20181019160622.GO5895@sirena.org.uk>
References: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XMHqbYJb993HXwLR"
Content-Disposition: inline
In-Reply-To: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XMHqbYJb993HXwLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 05:56:35PM +0200, Olivier Moysan wrote:
> Fixes: 5e8d63a726f8 ("ASoC: cs42l51: add mclk support")
>=20
> The MCLK clock is made optional for cs42l51 codec.
> However, ASoC DAPM clock supply widget, expects the clock to be defined
> unconditionally.
> Register MCLK DAPM conditionally in codec driver,
> depending on clock presence in DT.

I've applied this but TBH I think we should be doing this in the core -
I actually thought we had handling for that but I can't see it so I'm
obviously imagining things.  It's something that can be done later
anyway.

--XMHqbYJb993HXwLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvKAP0ACgkQJNaLcl1U
h9BF3Qf5AaeJZBaqJoRHji9hqrAa33wqz4EfrAdli0y2nm4Eq4cAeBoOyP757DH8
qzrJB810WvwHfsBEvWxkalsGBYb1wrWGh/zUpg0pmoJW4GbCAUYRxytBOrT6Dmx6
BOEkGD2qLqdLbhN1H2gFSu7D9dleu2SI0P49UjC7PsSnOgH0jMopaezI/upwZ57z
u5AROw2BJtCtb+FUyepG7Igv/znfbydyGrkB34Ta3p4AZMmBih00WzKQePXxVeZr
hROu2OnEBjBi7O7rTcbJ3VhSbSGAGcr713DKPHrliwizS43L0OffKA+RvuuE3Yy8
TxnPBm7bh24YUBeEeME01Y0qurc6ng==
=wR4T
-----END PGP SIGNATURE-----

--XMHqbYJb993HXwLR--
