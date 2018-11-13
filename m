Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EE4C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC29216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ZANlDEpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC29216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbeKNCAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:00:54 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:36058 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbeKNCAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VQssOANATFsGw4L5A82QdDx12Yme6rB94QmRny/G5r8=; b=ZANlDEpCGjujNvIeGMJ0TGSvp
        nylB94BoFVB1pV/Tsft8fJ8TxpWvSTzj349NgJGfwVgm0P9A+HPrVUF0wX4RKD2T7ZBaKpz18s52b
        mwurMeJcfMLls1JjnwOytgMwz3srs+LFtS3rwFs1kCPtTqloxdW3KJR3KVsFeOiDL7CrU=;
Received: from x590fecab.dyn.telefonica.de ([89.15.236.171] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gMb8h-0001Pb-0g; Tue, 13 Nov 2018 17:02:07 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gMb8d-0001y2-R7; Tue, 13 Nov 2018 17:02:03 +0100
Date:   Tue, 13 Nov 2018 17:01:28 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Rob Herring <robh@kernel.org>
Cc:     sebastian.reichel@collabora.com, hns@goldelico.com,
        devicetree@vger.kernel.org, johan.hedberg@gmail.com,
        marcel@holtmann.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
Message-ID: <20181113170128.0f59ef0e@kemnade.info>
In-Reply-To: <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
References: <20181110232034.17277-1-andreas@kemnade.info>
        <20181111024648.7rt7rlhaqihtqecv@earth.universe>
        <20181112215812.18ebca35@aktux>
        <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
        <20181112222726.73m2oca7hankvcjs@earth.universe>
        <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j5HQM3BtDpk6Uv4sir_Rhdt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j5HQM3BtDpk6Uv4sir_Rhdt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Nov 2018 18:17:38 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Nov 12, 2018 at 4:27 PM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > On Mon, Nov 12, 2018 at 10:19:02PM +0100, H. Nikolaus Schaller wrote: =
=20
> > > > Am 12.11.2018 um 21:59 schrieb Andreas Kemnade <andreas@kemnade.inf=
o>:
> > > > On Sun, 11 Nov 2018 03:46:48 +0100
> > > > Sebastian Reichel <sebastian.reichel@collabora.com> wrote: =20
> > > >> On Sun, Nov 11, 2018 at 12:20:34AM +0100, Andreas Kemnade wrote: =
=20
> > > >>> This is a first try to be able to use h4 devices specified in
> > > >>> the devicetree, so you do not need to call hciattach and
> > > >>> it can be automatically probed.
> > > >>>
> > > >>> Of course, proper devicetree bindings documentation is
> > > >>> missing. And also you would extend that by regulator/
> > > >>> enable gpio settings.
> > > >>>
> > > >>> But before proceeding further it should be checked if the
> > > >>> general way of doing things is right.
> > > >>>
> > > >>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > >>> --- =20
> > > >>
> > > >> Patch looks good to me, just one note
> > > >> =20
> > > > I found one thing myself:
> > > > Shouldn't we have a generic compatible string like "generic-h4".
> > > > ehci-platform.c has for example:
> > > >        { .compatible =3D "generic-ehci", }, =20
> > >
> > > There might be differences in h4 compatible devices (e.g. default
> > > baud rate) so that I would not bet there a "generic-h4" suffices
> > > in the long run. =20
>=20
> It will not because that doesn't define clocks, resets, gpios,
> supplies, etc. and the interactions of all those.
>=20
well, we need a simple supply being on when the device is on.
Nothing more.

> > My suggestion is to use this in DT:
> >
> > compatible =3D "wi2wi,w2cbw003-bluetooth", "<something generic>";
> >
That would be my slight preference here.

> > The driver can start with supporting just the generic compatible
> > string. If somebody finds some incompatible differences, the driver
> > can add a custom handler for the wi2wi chip without breaking DT
> > ABI. =20
>=20
> Any idea how many H4 devices there are? Somehow I doubt there are that
> many to be unmanageable.
>=20
Well, many devices are h4 devices with some more or less important
vendor-specific commands. Well, "hciattach any" uses simple h4 protocol.

those firmware download commands and they have their own drivers.
Most devices I had used bluetooth uart from the command line with, were
simple enough. The other question is whether those devices will run a
modern kernel.

No strong opinion here.=20

Regards,
Andreas

--Sig_/j5HQM3BtDpk6Uv4sir_Rhdt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvq9VgACgkQfb1qx03i
kyS5nBAAxlvnsfTEFAxI0BcKanS38HpbBcXP8k1/aPlkYpgHeVPGgZeyd8Cj1aGn
e8gdITUsT2IA3Jlph2V2+W+QuHynUaW+pZgsvVJ8EwgxHoUqhcw4EgghkerHHnLf
/ykN/hNS9Pz+PeDJz4mmVl6bqjD0T494GVfR63Z1iQXmvaK3QgsbKC5N+q8kZqgx
JMdbS2ZRrF7gvoyfNtzP390hmqcZ+UpN3p5Dx6Lm6pM/SzI9Gt+3z8qYwnw3Qg4r
EWlg/Hmj6xDQnS1J8rPCBA2VCFOLP2EgEc+kr+HpND/mXrpfw5gClBXVKd+X9XWO
I2ZubzUTy5mE7xHpAhJT0e8B66CfZ1Kb/hmnLY941N24nqoB5ynu1/JZiXsn304r
6HHMwdsY5+Dsxrc7zvA4s8g322vIMR5Zx0FDD4n+1mryBRPJL/b4iiComnyTgBxQ
rJA5nYKc8GRN8QsOGpFGL2r2YphSAGnwa8H/616jxvZhzqH0CO6D0OAY6wP6tF71
C96bnoXS8XXbpID8jbFMbPjil4AEGiNX3plUNUe0viFqhz6x4kYqI0FYKuZW+8qA
7jwYVkQy9QXVw91COg0KAUkGXfYhQAapeTKPhHtI75Xpq9xoAXTRKHw77+HreZjs
zdafAAz9IhXG0cilaGbNxtEUU5iRAhAQkfe7rYrITcw0Nn/472c=
=/9mK
-----END PGP SIGNATURE-----

--Sig_/j5HQM3BtDpk6Uv4sir_Rhdt--
