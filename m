Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBADC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D2F243E6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HEmPvvNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D2F243E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933604AbeFVOnr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:43:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49644 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932752AbeFVOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yVsXhlmaw5nNWNh/i8zsPZu5iSO7+FFoWqchtuq6SVM=; b=HEmPvvNRkTkwCZAnDHWM1lfh2
        HpQB5jBkdIckhD0HnLhZTN8/6gwX4x52kuY0XqmQkz2Q4+QCQnT8fglqsrh5QBaBEtD5h0Lj+PI/P
        oNhagZrTCHb+33136kKXxJvGv294w7lpi13FGORQkHvPClAuY9l9rY6HLWlaupzsvlUIY=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fWNHm-0003u0-Kl; Fri, 22 Jun 2018 14:43:38 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fWNHl-0002FS-PA; Fri, 22 Jun 2018 15:43:37 +0100
Date:   Fri, 22 Jun 2018 15:43:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: ac97: add codecs devicetree binding
Message-ID: <20180622144337.GB15386@sirena.org.uk>
References: <20180621154356.5438-1-robert.jarzmik@free.fr>
 <20180621154356.5438-2-robert.jarzmik@free.fr>
 <s5ha7rnditx.wl-tiwai@suse.de>
 <874lhvnlx1.fsf@belgarion.home>
 <s5h8t77hz8y.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <s5h8t77hz8y.wl-tiwai@suse.de>
X-Cookie: Kiss your keyboard goodbye!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2018 at 12:49:49PM +0200, Takashi Iwai wrote:

> Hm, some of these users (e.g. drivers/usb/core/*) do call
> of_node_put() properly at releasing, but some look leaking to me.
> I don't think we have the common code in the driver core to release
> dev->of_node, at least.

> If any, this should be done in ac97_codec_release(), I suppose.

Yeah, I'd expect this to be handled in each bus.

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlstCxkACgkQJNaLcl1U
h9Bbdwf/TnACvLBod1Z4z6L39QVRhG7Gud/6osipDCfZHAgnSaNdm9uGXovl16FB
LfjKnlRib6KOmA6yzImHzyZpFxYCbRYBWCxC7ZSDl7Pi60EZOuaxPflBF4h7Ywzs
UQmbrnAl+ihLp+bLWy8k1frZ19z0e+J7UkZvNJrFf2FQP1c6dY+ugG4cGZvl95rj
ezI+rUamPBjwvZ123qSqXsvdp2j8iHYcRYv32M0Jm5t5+jyrDR0lo4MXxPKj/lR4
mYLtL0tF9HdkgD3B+Xvg4aJ3716XY4TKnnj6XCyAyvCNwTNZMOXHZ6tMLLltdOrO
lA1LJiSK/9/l9Jk0Day9uFNUPD2uCg==
=x2fN
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
