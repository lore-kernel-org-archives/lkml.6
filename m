Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAECFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FDE20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FDE20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeINNbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:31:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57239 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeINNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:31:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C3489806FD; Fri, 14 Sep 2018 10:18:23 +0200 (CEST)
Date:   Fri, 14 Sep 2018 10:18:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20180914081822.GA21830@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
 <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> How do I politely explain that the original implementation was wrong f=
or certain devices?
> >=20
> > Implementation? Device tree is hardware description.
>=20
> Yes this hardware description is incorrect.  The hardware description is
> describing a MFD but this LED driver (and a couple others) only perform
> 1 function and that is to drive a LED string.

So what? Does not seem incorrect to me. Maybe the description should
not be in MFD directory, but other than that...

> >> Isn't code and documentation supposed to be pushed in stages
> >> together?
> >=20
> > Device tree is _not_ documentation. And yes, it is normally pushed
> > together. But that did not happen here, and bindings are already in.
>=20
> Hmm..  Its not documentation but it is in the Documentation folder.
> And just because the bindings are in does not mean they cannot be
> changed.

You may want to learn more about device tree and/or talk to the device
tree maintainers. This is an old article. https://lwn.net/Articles/561462/

NAK on this patch. I see that this binding has problems, but
introducing different binding for subset of devices is _not_ a fix.

> > What about the multi function devices? They should have same binding.
>=20
> The MFD devices defined are not in contention here only the SFD.

I'd like to see common solutions for SFD and MFD, as the hardware is
similar, and that includes the code. Having code that is easier to
maintain is important, and having many drivers are harder to maintain
than one driver.

Milo's code looks better than yours in that regard. I disagree about
Milo's code being "nightmare" to modify, and care about "easy to
maintain" more than "binary size".

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlubbs4ACgkQMOfwapXb+vJfLwCgvrCeYUwH6P2phaE9NTvBq/k1
GCIAni/x5JZngbu8vHWGo+wRWYQJu+6x
=8OgQ
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
