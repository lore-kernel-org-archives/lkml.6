Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05704C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73B1208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73B1208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeH0Szk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:55:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45198 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0Szk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:55:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 03EAB20739; Mon, 27 Aug 2018 17:08:38 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id CA8CF206A6;
        Mon, 27 Aug 2018 17:08:37 +0200 (CEST)
Date:   Mon, 27 Aug 2018 17:08:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>, khilman@baylibre.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        skannan@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
Message-ID: <20180827150836.shl7einpuvuw42p7@flea>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
 <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tlmv2cpuyt6qe6ep"
Content-Disposition: inline
In-Reply-To: <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tlmv2cpuyt6qe6ep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri, Aug 24, 2018 at 05:51:37PM +0300, Georgi Djakov wrote:
> Hi Maxime,
>=20
> On 08/20/2018 06:32 PM, Maxime Ripard wrote:
> > Hi Georgi,
> >=20
> > On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> >>> There is also a patch series from Maxime Ripard that's addressing the
> >>> same general area. See "dt-bindings: Add a dma-parent property". We
> >>> don't need multiple ways to address describing the device to memory
> >>> paths, so you all had better work out a common solution.
> >>
> >> Looks like this fits exactly into the interconnect API concept. I see
> >> MBUS as interconnect provider and display/camera as consumers, that
> >> report their bandwidth needs. I am also planning to add support for
> >> priority.
> >=20
> > Thanks for working on this. After looking at your serie, the one thing
> > I'm a bit uncertain about (and the most important one to us) is how we
> > would be able to tell through which interconnect the DMA are done.
> >=20
> > This is important to us since our topology is actually quite simple as
> > you've seen, but the RAM is not mapped on that bus and on the CPU's,
> > so we need to apply an offset to each buffer being DMA'd.
>=20
> Ok, i see - your problem is not about bandwidth scaling but about using
> different memory ranges by the driver to access the same location.

Well, it turns out that the problem we are bitten by at the moment is
the memory range one, but the controller it goes through also provides
bandwidth scaling, priorities and so on, so it's not too far off.

> So this is not really the same and your problem is different. Also
> the interconnect bindings are describing a path and
> endpoints. However i am open to any ideas.

It's describing a path and endpoints, but it can describe multiple of
them for the same device, right? If so, we'd need to provide
additional information to distinguish which path is used for DMA.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tlmv2cpuyt6qe6ep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluEE/QACgkQ0rTAlCFN
r3TDkRAAj4uNEPLFjyHIix2x+VjZqXaBDLhJZaZz8qwSZ1xWQqcYwJnqS1V65QdW
o4VI5AuIymA8yMjKjkOHceEYCrod2tNUiBh7SvQG38tQJD/zMsu5m8xM2JswURjj
JfTtDLthBottb8p3lzq6dyUNrrAO92sZXTHjqn4RuxOhNtHDzPrY7Cg91ZQUxg79
NeJHEyUHRJ8i/KGRXXu0lsBEQHmoqLchIEUz2X5tSazdpVnHlcipdMg10jQkf6xQ
jbGcj7KCW1tGf1YA1TJ4E5t1GqZorUFAVQh1Ja9BVny0uYqiRK5Z73kz1n7gh2MU
LmKqFfLv//MivaHV5GMbcEYUfZbc3/EXZ9gPXXkShNtWIQT6dOQmGSd7rKnqS/up
1RnEVHLnvPBPZXMKptvxZaqXVnl5X+z82w6ucH3vCXtX+Hj96VYZDGHDgY5MVrsn
5tcBLMNBHxrlBRN+sBR123Ao0J1cMpol69kqqkRe72RY++gvRehXdueBjoOK4pKR
YXtUxuyx2h7Jf0qcusdQhntsPfKCC3/bT7955qwmYeAvU00VQqzEYY3oqz/SvUK2
mYQ30V5IpO0LysFXROko5UTVO6m861RjELJFES5/NpqZFh+c4i0kTaKDg0zkyvug
4RZ9w1crO5XQxArKc4DahgYPyvSROOK6Aibs1Cave8e+F8Whb1A=
=M/QC
-----END PGP SIGNATURE-----

--tlmv2cpuyt6qe6ep--
