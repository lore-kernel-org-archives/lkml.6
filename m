Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29335C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488802087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488802087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeKTUv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:51:28 -0500
Received: from sauhun.de ([88.99.104.3]:52538 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbeKTUv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:51:27 -0500
Received: from localhost (p54B3346D.dip0.t-ipconnect.de [84.179.52.109])
        by pokefinder.org (Postfix) with ESMTPSA id 8BB294C0E9C;
        Tue, 20 Nov 2018 11:23:01 +0100 (CET)
Date:   Tue, 20 Nov 2018 11:23:01 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Faiz Abbas <faiz_abbas@ti.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Message-ID: <20181120102300.GA1056@kunai>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
 <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai>
 <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> That also happens to be one of the cards we deploy; However i did
> >> wonder about adding a quirk but decided against it as it was not clear
> >> to me from the specification that CACHE ON really is meant to complete
> >> within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
> >> mole games as the failure is really quite tedious (boot failure).
> >
> > I agree that we should use the more defensive variant as a default. I
> > mean there should be no performance regression since most cards will
> > respond just faster, or? The only downside I could see is that we might
> > miss a real timeout with no bounds set and might get stuck?
>=20
> Well, you have a point, but still it's kind of nice to know which
> cards are behaving well and which ones that doesn't. Hence I think I
> prefer to stick using a quirk, unless you have a strong opinion.

No strong opinion. Especially not if you say it is in the spec (although
"must be sufficient" would be better than "should be" ;)). Also, I
assume this failure is reproducible and should turn up during
development? Compared to "happens once in a while randomly"?

Yet, if we add a quirk for that, then we should probably mention it in
an error message when we hit -ETIMEDOUT for cache on ("does your card
need this quirk?")? It can be pretty time consuming to track this down
otherwise, I'd think.


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvz4IAACgkQFA3kzBSg
KbYtPRAAlmLJPEorqqLLfPi7QvqV88+05ctnsL3aV/EqztKbRgQ/DjlDHmYpXozm
WjRTG8HyRCLAlXQ6xC2TYQw+uqT0FzsOnzEVLtk8vsgfOjw0LOUhnAN5nJnc4jLl
h3w3FGD71XH7cvM3QE4mCacYaiGLPVWpSbnDbTiPP9ljHlQpNPoVMlzgUxlDz6Gi
eVNsT/r/PKboxBEdTox96bXxuGS8p0caV6p1yyFzROEf0+iyXEyQ16AjMhU4xMh8
ZwmpkUslSfzqPy9Ird5tYEvbAF7k9d5lDO1Lu0fxKa8YjxKR4kh3sNP/5jQ1lQvF
7qHYDi8UmOJG/9M+4KuqDsi4vVp9+H4apv98HRjlpHws+jeXPOBo9/iFLUthJyQ/
Uf+Yn7Hw74oH8PA3VFy/+j+eChPxJ4Fbz5dZ+d35L5Q3Q5+9nta9ZPEaXFoq3p6G
5twl0T+9v0QXdGp1zajSuquS40h7g7/vZOmded/CGHdSUiN5lI2/utGeKHK3wnVP
SyZsEETFUf+3zcAPPrH7MI6qL1lBpVOxU6kDyGtS5mu8Bg6RMbKfNXqO+3Kyn+5P
xenwy4w1ptTrsQyVsV5pSLHgTA/GmMB2fSvFZTgyJAvpv2hZvWRCeD3aX7FhB/0O
CscRQHUlYB5hitEOnb+scm6qwH5hP0cBZSVsFb7lPfkh60BftLc=
=Hkb8
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
