Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5A1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312CA20854
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312CA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbeGNW7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:59:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46544 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbeGNW7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:59:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D05CF80544; Sun, 15 Jul 2018 00:39:07 +0200 (CEST)
Date:   Sun, 15 Jul 2018 00:39:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180714223907.GB2776@amd>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd>
 <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20180714222924.GA2776@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-07-15 00:29:25, Pavel Machek wrote:
> On Sun 2018-07-15 00:02:57, Jacek Anaszewski wrote:
> > Hi Pavel,
> >=20
> > On 07/14/2018 11:20 PM, Pavel Machek wrote:
> > >Hi!
> > >
> > >>>It also drew my attention to the issue of desired pattern sysfs
> > >>>interface semantics on uninitialized pattern. In your implementation
> > >>>user seems to be unable to determine if the pattern is activated
> > >>>or not. We should define the semantics for this use case and
> > >>>describe it in the documentation. Possibly pattern could
> > >>>return alone new line character then.
> > >
> > >Let me take a step back: we have triggers.. like LED blinking.
> > >
> > >How is that going to interact with patterns? We probably want the
> > >patterns to be ignored in that case...?
> > >
> > >Which suggest to me that we should treat patterns as a trigger. I
> > >believe we do something similar with blinking already.
> > >
> > >Then it is easy to determine if pattern is active, and pattern
> > >vs. trigger issue is solved automatically.
> >=20
> > I'm all for it. I proposed this approach during the previous
> > discussions related to possible pattern interface implementations,
> > but you seemed not to be so enthusiastic in [0].
> >=20
> > [0] https://lkml.org/lkml/2017/4/7/350
>=20
> Hmm. Reading my own email now, I can't decipher it.
>=20
> I believe I meant "changing patterns from kernel in response to events
> is probably overkill"... or something like that.

Anyway -- to clean up the confusion -- I'd like to see

echo pattern > trigger
echo "1 2 3 4 5 6 7 8" > somewhere

to activate pattern, and

echo none > trigger

to stop it.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltKe4sACgkQMOfwapXb+vLw8QCfVp+7875oW8KueBC08iu6m7E8
67YAn0WI3E8AfTf/AsXV/at5HDHp9i5g
=KhLX
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
