Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A18DC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A9321AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mrSgLl2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A9321AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbeHILyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:54:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeHILyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AaSlNBZm+TFgZWk3lufoKPhOiKQKmiEstGl+dQj3Afs=; b=mrSgLl2b3twgM1PIakbUsEDyp
        6uPD/vcC/ObWszbSRUgQ2ewAZ6ltL11L3yhGaS+uroINkYlwCyxJp/igO0foTnVR0ag/t1TkgyIDd
        KrJ4TKA6n4q8XKniLLrEdWFev32c8iAZj9qDf9XOVsCleOVqCQ/nJgMPgiU4Zb/zagXaw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnhGe-00039a-3X; Thu, 09 Aug 2018 09:30:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CB2981124340; Thu,  9 Aug 2018 10:30:02 +0100 (BST)
Date:   Thu, 9 Aug 2018 10:30:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: adav80x: mark expected switch fall-through
Message-ID: <20180809093002.GB6132@sirena.org.uk>
References: <20180808191933.GA27767@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20180808191933.GA27767@embeddedor.com>
X-Cookie: UNIX enhancements aren't.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 02:19:33PM -0500, Gustavo A. R. Silva wrote:

> @@ -648,6 +648,7 @@ static int adav80x_set_pll(struct snd_soc_component *component, int pll_id,
>  			pll_ctrl1 |= ADAV80X_PLL_CTRL1_PLLDIV;
>  			break;
>  		}
> +		/* fall through */
>  	default:
>  		return -EINVAL;
>  	}

Are you *positive* this is a deliberate fall through?

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltsCZoACgkQJNaLcl1U
h9C9NAf+NiXGG9NS4z0R9rZFEvMmWRi3tYsX6bswoVYZbhBDgLOYe01p6zCXU3ux
LojkPzgFito3pK90mPFD7vabdeN1qdppD9RaIDkpuc1wEzM1brtq5SJulUbFlnhh
qh2FtJUr78urfSEWlCyX3e96QzKLrbm2fubjhtUwMHy8NM29ZAGl0EfIomGbaIeO
ZdxXEOLhV2uvO2CzuPBHJpNXsl7lfEWwWE7nOjqt/NUIt9SHJwUV5iKTajE0emOy
QgJY0Fx6Ylobr693u5VyQ/14Ol/6DlJ24c9/qKZoDbfghGzG1ato/e8TI6nF6Kh9
OzdBYHOTC7kOLiw//5PW+Z0axlwJgw==
=lL8b
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
