Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843D6FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4642A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeINNhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:37:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57383 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeINNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:37:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 47BBB806F9; Fri, 14 Sep 2018 10:23:59 +0200 (CEST)
Date:   Fri, 14 Sep 2018 10:23:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20180914082358.GB21830@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
 <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> All be it the analog side of these devices may be the same but the digita=
l side for each chip is different.
> The register maps are not the same, the number of supported LED strings a=
re not
> the same, there are features not supported by this driver and will
> be a pain to add.

Digital side looks similar enough that Milo was able to share code
between them.

Yes, obviously register map will be different.

> Adding features will be a complete night mare especially for the LM3632 w=
hich also support Torch and Flash.
>=20
>=20
> Here are where a single driver will start getting messy and support diffi=
cult
> LM3533 has ALS and an ADC for an ALS analog sensor
> LM3631 has no ALS functionality
> LM3632 has strobe/torch functionality and no ramp support
> LM3633 has lvled support coupled with the hvled support
> LM3695 does not even appear to be available publicly
> LM3697 is the only device that that this driver could be used for as is.

We already been through this once. More than one of these has ramp
support, and more than one has overvoltage protection. (Plus, all of
them are LED drivers).

Surely non-ugly design can be done where the code is shared?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlubcB4ACgkQMOfwapXb+vIx/ACdGLXPOdVkAMSp7NmhmCy2KVeL
cRUAoIQy7E5m6AYFpZEe0fo4ejivKwqL
=XvZc
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
