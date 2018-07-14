Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D038EECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 21:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CAC20854
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 21:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CAC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeGNVk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 17:40:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45126 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731213AbeGNVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 17:40:57 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3A4C180551; Sat, 14 Jul 2018 23:20:34 +0200 (CEST)
Date:   Sat, 14 Jul 2018 23:20:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180714212033.GA31950@amd>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > It also drew my attention to the issue of desired pattern sysfs
> > interface semantics on uninitialized pattern. In your implementation
> > user seems to be unable to determine if the pattern is activated
> > or not. We should define the semantics for this use case and
> > describe it in the documentation. Possibly pattern could
> > return alone new line character then.

Let me take a step back: we have triggers.. like LED blinking.

How is that going to interact with patterns? We probably want the
patterns to be ignored in that case...?

Which suggest to me that we should treat patterns as a trigger. I
believe we do something similar with blinking already.

Then it is easy to determine if pattern is active, and pattern
vs. trigger issue is solved automatically.

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltKaSEACgkQMOfwapXb+vKJGwCdEF3ulFFXbcvA4gYX9fRI9HwR
u4sAoJO/HWV9eFgalZ/ymHT3IN5s5VSR
=f5Gu
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
