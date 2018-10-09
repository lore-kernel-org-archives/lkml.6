Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B195CC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CE1213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CE1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJIPIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:08:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42943 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbeJIPIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:08:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B0B3A20717; Tue,  9 Oct 2018 09:52:30 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 58A91206A2;
        Tue,  9 Oct 2018 09:52:30 +0200 (CEST)
Date:   Tue, 9 Oct 2018 09:52:30 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        quentin.schulz@free-electrons.com, ulf.hansson@linaro.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        shawn.lin@rock-chips.com, adrian.hunter@intel.com,
        baolin.wang@linaro.org, thomas.petazzoni@free-electrons.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devel@driverdev.osuosl.org, icenowy@aosc.xyz, wens@csie.org
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
Message-ID: <20181009075230.aaxne3z247yc3lu6@qschulz>
References: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
 <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
 <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
 <20180927081452.a2xw25sdoqtadntu@flea>
 <85c2baea-8dbb-ef1b-93d2-7749c5a100e6@exceet.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b73hh3tje6cerlim"
Content-Disposition: inline
In-Reply-To: <85c2baea-8dbb-ef1b-93d2-7749c5a100e6@exceet.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b73hh3tje6cerlim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frieder,

On Mon, Oct 08, 2018 at 11:53:21AM +0200, Frieder Schrempf wrote:
> Hi,
>=20
> On 27.09.2018 10:14, Maxime Ripard wrote:
> > On Wed, Sep 26, 2018 at 10:19:22PM +0200, Hans de Goede wrote:
> > > On 26-09-18 16:44, Frieder Schrempf wrote:
> > > > Hi,
> > > >=20
> > > > On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
> > > > > [...]
> > > > >=20
> > > > > > > > I'd like to know if any progress has been made on that prob=
lem
> > > > (I may
> > > > > > > > have missed patches).
> > > > > > > > Had you had the time to look at the issue?
> > > > > > >=20
> > > > > > > I have looked at the issue, but not manage to cook some patch=
es
> > > > for it.
> > > > > > >=20
> > > > > > > However, it's on my top of my TODO list for mmc. No promises,=
 but
> > > > > > > perhaps and hopefully I manage to get something posted during=
 the
> > > > > > > coming release cycle.
> > > >=20
> > > > I would be interested in a ESP8089 driver in mainline and that's wh=
y I want to pick up this discussion.
> > > >=20
> > > > What is the current status of the "mmc_reprobe_device" implementati=
on, that Hans was explaining and Ulf wanted to provide some months ago?
> > >=20
> > > Ulf did eventually write a new way to deal with this and then Quentin
> > > did manage to get the esp8089 driver to work with it, the new function
> > > to use for this is added by this commit:
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/drivers/mmc/core?id=3D1433269c4d2461be1f36db5dbb453976b38996ff
> > >=20
> > > I'm not sure what the status of upstreaming the ep8089 driver is now
> > > that we've this in place.
> > >=20
> > > Quentin, do you have a version of the esp8089 driver somewhere
> > > which will work correctly with the new mmc_sw_reset() function?
> > >=20
> > > Also what is the status of adding this driver to say staging?
> >=20
> > IIRC, we tried to get it into staging, and we got told that it was too
> > nice for staging at this point. So we're basically stuck somewhere
> > between staging and !staging, with the driver being too nice for the
> > former, and not nice enough for the latter :)
>=20
> Ok, and is there someone willing to continue upstreaming the driver? Maybe
> someone can rebase and resend the latest approach?
>=20
> After all it looks like a lot of work has already been done.
>=20

There's clean up to do. It's time consuming but shouldn't be too hard to
do.

Then, we stressed the driver with an iperf test and it crashes very
often so we first need to identify if it happened with the "original"
driver before Icenowy's, Hans's and my clean-up. If it happened, since
we don't have a datasheet, it might be not that easy to fix. If it
didn't happen, then we have to find out where I cleaned up too much :D

I'm not currently working on this topic so anyone willing to take over
the work is free to do so.

Thanks,
Quentin

--b73hh3tje6cerlim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu8Xj4ACgkQhLiadT7g
8aNI9Q//a+3v1NSnCqMMIauD3fxKWyKhJ2ZYTCJHXSj7kI+HRlyo0Io6q0ry+GVO
NY73Wij9/hTphmxB1CHGhEkyLj9k/ej+N7nzfOaYyaAlFzthCgolfp0aK6/6vQ99
EOdFQeogYZ2avoIeHnJeZNY8mHoZZOggIEcMbZ+pjw7vxFSlm2Z8xDEmbeyI6Nrd
wMDgsDY/SG7napGAotOFFrzhuU4mzvTeg6zbK2dKOQg3OafJi65pBcDUlzqxvZNt
5AiqFmh4bk0Heyo+Gr4eY9lZKAANcKddpA9uwLnmt/yXGZpKjfcvl6MammdWN+Fx
vGObA/adtD2fIDEZ3gCelYPuKG7DQNgUTfjV0Z1o4zESvVeQPF36TdHJE+p0tBmo
2Mf0P41bERyAZlV0oQGsGlTomBrR1BjgSCe4wBGCu5hlJK1850/GX+yBPbiagcrC
4gdcN0BjBZDwgmyEo/Soj/A0GO1cy+CQmm0h9Q4IiQHBCkJJ0BjhujSk5UO3p7NN
zZ7s8e/TZ9248JyQdPYnCvdlBd2hrEtWKIu/7jG7DSncPwiLd9f9GLmwcKmKKRx0
c6skwuNoU8ijfvvmIuKcjOP4UZ3fKiaxPJ6p0k3TSMQsHPuU4OW4+l8f9IsnLDYw
U3k0GFlnVrHquSb/3kqW7QkAEF8VNdFDeDWNOiOMQLzV8TMGDn4=
=re/Y
-----END PGP SIGNATURE-----

--b73hh3tje6cerlim--
