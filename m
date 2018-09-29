Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E8C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E2F20880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E2F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeI2WQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:16:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56385 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbeI2WQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:16:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E37C420734; Sat, 29 Sep 2018 17:47:54 +0200 (CEST)
Received: from localhost (unknown [212.145.226.70])
        by mail.bootlin.com (Postfix) with ESMTPSA id 97A15206A7;
        Sat, 29 Sep 2018 17:47:54 +0200 (CEST)
Date:   Sat, 29 Sep 2018 17:47:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rodrigo =?utf-8?B?RXh0ZXJja8O2dHRlciBUasOkZGVy?= 
        <rodrigo@tjader.xyz>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
Message-ID: <20180929154754.abz3byvrufvnf4dq@flea>
References: <20180919141815.18737-1-rodrigo@tjader.xyz>
 <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea>
 <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea>
 <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgswahgbsrhmlk2r"
Content-Disposition: inline
In-Reply-To: <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mgswahgbsrhmlk2r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 11:49:20AM -0300, Rodrigo Exterck=F6tter Tj=E4der w=
rote:
> On Thu, Sep 27, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Tue, Sep 25, 2018 at 02:47:59PM -0300, Rodrigo Exterck=F6tter Tj=E4d=
er wrote:
> > > On Tue, Sep 25, 2018 at 6:01 AM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > > We can't really do that, unfortunately. If the device tree name was=
 to
> > > > change for a given board, we'd break all the build systems, boot
> > > > scripts and distros out there.
> > >
> > > What if we keep the device tree for the version without WiFi and eMMC
> > > with the current name and create new device trees for the other two
> > > versions?
> >
> > Wifi and Bluetooth should be dealt with with overlays in this case,
> > and since the eMMC is already enabled, then there's nothing to do, I
> > guess.
>=20
> It's WiFi that is already enabled, not eMMC. Only one of the three
> variants has WiFi.

Ah, right, sorry. In the board that doesn't have an emmc, are the pins
usable for something else?

> We can't even remove a node from a device tree? Removing the WiFi node
> from the current tree would make it correspond to the variant with the
> least features.

Not really. How pissed would you be if you were a user, had wifi
running on your board, you upgrade your kernel, and then it's just
gone? :)

> About device tree overlays, I read overlay-notes.txt, but I went
> looking for an example with "git grep /plugin/ arch" and it came
> empty. Is this approach not used for other boards?

It is, it's simply not stored in the kernel, but through other third
party repos.

> Does the overlay approach make the device available at boot time? That
> is important for a storage device such as eMMC.
>=20
> I went with the separate dts approach because that's what I saw was
> done for other similar cases, like Pine64 and Pine64+, OLinuXino-LIME2
> and its variant with eMMC, among others.

Yeah, but in all these cases, it was done from day one, not after the
facts.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mgswahgbsrhmlk2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluvnqkACgkQ0rTAlCFN
r3RX6w/+IqyREh6KVQvgVbNdXP8BEG4F0cdooVJRHaF/D463kTMkm/F6GAel+AQi
7yY9NRdfrypX3U5ua1n+fdGkgX1vrB05frX9h2RuV05GzT34wPK3J6dAk4G93nSQ
gp5nvnbJqZsvjq26DRG79QL6GVLLC7eN/K9YyieGIAZx/vP+R+MWFHlNXw/HBU4k
P7ef9+2Ll9g5AiFsWMu3SLxHeSOVX08H4TbWAVG7k7U4jHhJ8bCPf5J+5TsJR2t5
Q8X0L87Q4Y0XilKFrH7ObqNcbb0a8GY/0nim2seF0V5+Cp5HdQwoeu9FSz27CE3g
3PPVCXQHbgreB4knBbiVCDHRuJAgNEhPQ5cE9LPfNlvkravCVmabZjogOdJxKt5O
8z7GKeXI7IThzV5KyXuKEoVVOpxO9UAn9NQKztLgoF6lQqy/un0diDtGLTNzr7uM
pI/mKOvxFHbI1l/8oUIp2sQnMApbyFve+K++zwBxjdpk8mEcHHJLwz/rCp8MEUdl
NIjSUSbxgld0k3wmc/TrU/Qsmj5qZO8Bgv7ix9RZQvCNpocg40NhQJ/PQkTUemqs
jWtiUtfBWh6YSi0jYpdDzkv+w0E9w2VB5GB1iBR1PJXSWBI3UjrGXlW/BFFRKEwU
ifJEGdcMyeuyCN22dvAF8u3pP0zojX4HkCc8Gq+xPOSYnQTVGUE=
=3kOj
-----END PGP SIGNATURE-----

--mgswahgbsrhmlk2r--
