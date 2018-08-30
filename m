Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A723205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A723205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeH3QF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:05:29 -0400
Received: from sauhun.de ([88.99.104.3]:53500 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeH3QF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:05:29 -0400
Received: from localhost (p54B33850.dip0.t-ipconnect.de [84.179.56.80])
        by pokefinder.org (Postfix) with ESMTPSA id 80AE23478CC;
        Thu, 30 Aug 2018 14:03:38 +0200 (CEST)
Date:   Thu, 30 Aug 2018 14:03:38 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] mmc: tmio: refactor CLK_CTL bit calculation
Message-ID: <20180830120338.b3i5evddpto64hnl@ninjato>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
 <20180829084913.fgdrigpeu3vi7vqs@ninjato>
 <CAPDyKFq6wX9jP0c5688fWVAmnZja9OZXbECwoKbKBXuM2r5cbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nvmyjxpegcuc3rti"
Content-Disposition: inline
In-Reply-To: <CAPDyKFq6wX9jP0c5688fWVAmnZja9OZXbECwoKbKBXuM2r5cbg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nvmyjxpegcuc3rti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 01:51:49PM +0200, Ulf Hansson wrote:
> On 29 August 2018 at 10:49, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> +     if (divisor <=3D 1) {
> >> +             clk_sel =3D 1;
> >> +             clk =3D 0;
> >> +     } else {
> >> +             clk_sel =3D 0;
> >> +             /* bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/=
2 */
> >> +             clk =3D roundup_pow_of_two(divisor) >> 2;
> >> +     }
> >
> > What about
> >
> >         clk_sel =3D (divisor <=3D 1);
> >         clk =3D clk_sel ? 0 : (roundup_pow_of_two(divisor) >> 2)
> >
> > More concise, but I think still readable. I don't mind super much,
> > though.
>=20
> Right. So, may I apply Yamada-san's original patch (adding your
> tested/reviewed-by tag) and the above as a code-cleanup for you to
> address on top?

I can resend this as a proper patch if you prefer it to be handled
incrementally.


--nvmyjxpegcuc3rti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluH3RYACgkQFA3kzBSg
KbZX7w/9Eot2j1D4ss4e2VBSXVqE8eq1tCZsB2OZ0396w9xHkJpUMhroaayrWw+R
lTvbHe86k5iAuLxY5dVALjnv8wfER4+3irzzBEJN5wtnIzBUlXQS8uqFF5w204BD
zaJuh2iwq61p5pWI8XCIwAPys7XJHRiS2trNSEap7IMVv68KfG128IDfA5VHOC5h
cemJcHTgbppIyzc1GkYM8IrqE+NzZRbXGJquWESuTWl7jxNEkigjS7h2pgXC/m3S
VClTJIuaghPISdTnTYL/wO93x5ZM7r38KU4XRb12XbAv+aplWDwEWnhLvveetbPu
WuWKNumKvIiV1fJr+5HXnv/EcFsYf9DmXRvHSzZLfbw5PJPPWwnBh1MENleMFL8L
pd1yIM1cBEwgMibLrfwTaEQ+IQo3ffFAXu0aCVHzY/QgrVaL5OyL2j4ZWN3ht2ja
qS1Nb6kirej0aV+ifeUFZQ4j9fwRQDlnvJn0WOnHhZzlLfhhCxhyCDnhs3uJFscp
wR3nTW86OsO87RAGq/MzKOdrbBTKz6TLchYe24r2yEJaAHFxkzF2HzPAAzDFx/Xc
n3IeqOYgoAMHBOOzwi5SRlxdFvMO+GScJO9Rj5d1hk3pPeOUGIhw906YNxr7Cd7h
OAYSA48OLfSEeI3YxwIDbK52GGfxF0NkoxV2Dy+FS4DQutzeDco=
=oBOz
-----END PGP SIGNATURE-----

--nvmyjxpegcuc3rti--
