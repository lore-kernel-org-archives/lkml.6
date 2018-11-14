Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B3BC07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D8A223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bzTjhFqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D8A223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbeKNVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:16:45 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:38348 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hWuaTT9NppFynf0O8RTjwmmX6su26GgEilNB/OQecr4=; b=bzTjhFqIrfoCrNg+2omkNxhOP
        ocDfocckt5xwMHw9bu0wTuinU3lKS09od6zmZsIMjuLuQ+Z+rI6Z2dYZlrCx3pzxYyPe6uAwEe+Zh
        uIiNokcSjYj58DgTw/zarRg4SYwaHJJFBL0/CecPiAdTZUUl9MHcLvtZiNkYY6x7EsUUo=;
Received: from [2a02:790:ff:919:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gMt7G-0007MX-Ez; Wed, 14 Nov 2018 12:13:50 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gMt7E-0001XC-Sc; Wed, 14 Nov 2018 12:13:48 +0100
Date:   Wed, 14 Nov 2018 12:13:12 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Rob Herring <robh@kernel.org>, sebastian.reichel@collabora.com,
        hns@goldelico.com, devicetree@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
Message-ID: <20181114121312.53362ad3@kemnade.info>
In-Reply-To: <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
References: <20181110232034.17277-1-andreas@kemnade.info>
        <20181111024648.7rt7rlhaqihtqecv@earth.universe>
        <20181112215812.18ebca35@aktux>
        <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
        <20181112222726.73m2oca7hankvcjs@earth.universe>
        <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
        <20181113170128.0f59ef0e@kemnade.info>
        <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jN++hbb5Xq5Z4sVt/./+FGM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jN++hbb5Xq5Z4sVt/./+FGM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Nov 2018 08:51:17 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andreas,
>=20
> >>>>> Am 12.11.2018 um 21:59 schrieb Andreas Kemnade <andreas@kemnade.inf=
o>:
> >>>>> On Sun, 11 Nov 2018 03:46:48 +0100
> >>>>> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:   =20
> >>>>>> On Sun, Nov 11, 2018 at 12:20:34AM +0100, Andreas Kemnade wrote:  =
 =20
> >>>>>>> This is a first try to be able to use h4 devices specified in
> >>>>>>> the devicetree, so you do not need to call hciattach and
> >>>>>>> it can be automatically probed.
> >>>>>>>=20
> >>>>>>> Of course, proper devicetree bindings documentation is
> >>>>>>> missing. And also you would extend that by regulator/
> >>>>>>> enable gpio settings.
> >>>>>>>=20
> >>>>>>> But before proceeding further it should be checked if the
> >>>>>>> general way of doing things is right.
> >>>>>>>=20
> >>>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>>>>>> ---   =20
> >>>>>>=20
> >>>>>> Patch looks good to me, just one note
> >>>>>>  =20
> >>>>> I found one thing myself:
> >>>>> Shouldn't we have a generic compatible string like "generic-h4".
> >>>>> ehci-platform.c has for example:
> >>>>>       { .compatible =3D "generic-ehci", },   =20
> >>>>=20
> >>>> There might be differences in h4 compatible devices (e.g. default
> >>>> baud rate) so that I would not bet there a "generic-h4" suffices
> >>>> in the long run.   =20
> >>=20
> >> It will not because that doesn't define clocks, resets, gpios,
> >> supplies, etc. and the interactions of all those.
> >>  =20
> > well, we need a simple supply being on when the device is on.
> > Nothing more.
> >  =20
> >>> My suggestion is to use this in DT:
> >>>=20
> >>> compatible =3D "wi2wi,w2cbw003-bluetooth", "<something generic>";
> >>>  =20
> > That would be my slight preference here.
> >  =20
> >>> The driver can start with supporting just the generic compatible
> >>> string. If somebody finds some incompatible differences, the driver
> >>> can add a custom handler for the wi2wi chip without breaking DT
> >>> ABI.   =20
> >>=20
> >> Any idea how many H4 devices there are? Somehow I doubt there are that
> >> many to be unmanageable.
> >>  =20
> > Well, many devices are h4 devices with some more or less important
> > vendor-specific commands. Well, "hciattach any" uses simple h4 protocol.
> >=20
> > those firmware download commands and they have their own drivers.
> > Most devices I had used bluetooth uart from the command line with, were
> > simple enough. The other question is whether those devices will run a
> > modern kernel.
> >=20
> > No strong opinion here.  =20
>=20
> doing the firmware load from user space via some magic tool is no longer =
going to work smoothly. It will be actually almost impossible with serdev. =
However I did post btuart.c driver which is pretty much just plain H:4. You=
 would still somehow define the default baudraute since just picking 115200=
 is not always going to work.
>=20
Just to avoid some misunderstandings here. With this RFC patch I have only
devices in mind where we do not know any vendor specific commands and
do not need to do any firmware download.

> Btw. I see nothing standing in the way of merging btuart.c driver and the=
n go from there. Either I dig this out and submit or someone else does.
>=20
Seems to be a good idea. So in the end I should not continue
that rtc patch?

And that thing has than a devicetree string of
"h4-generic" or a list of generic h4 devices?

Regards,
Andreas

--Sig_/jN++hbb5Xq5Z4sVt/./+FGM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvsA0gACgkQfb1qx03i
kyQJgA//WbLE2Rk6gS12sncx7Jc3iO1x7ZEq+2lJEPlPWX2q8+b+o9yPrOGuiJ3D
tp5SPGmFLd77NnwZ4zu1kHOpOvVT+pPnp1UN7sB4d8IZgWcVX//AuoA/Uedx1hZi
j3xk6t3ZGUaWTJBGJZ2OB9ZxmJdegH9WnQkeNGx26EzSYYkGJx/CvRKEJk1LbSQA
NuwV1eyrvdLsMJdO0zUSVO83t/pDhpkWVXrxJCwMnSv48j4Wtmelswl52WNZ9eyY
hfULUpinwTKv3FJOiMY/ieXQdMdPWw7DXS4yoUkUmPHtWulg4DkASoG5h2uOxqT0
Kfa518/HZFx9nUGc8Xe+Z1QFcZVZR2XOa/BKdxIm6bg/4y3WGCmXueeUhVcJaEOo
38Lnpl7EQ5/X7pcUBnTQSgxic/T2g03AnEZfaOOu4NcJljU35DvdnPs+rhx0PM4C
L4UTrDxh5mADNG5inwnPNztysh9RPTs5o1XRq5IKFX5983NYVJiIqn47kkXm2KPY
+OPF+HBe6BxKs+Ee+nVeEhw5yN568ICFI4AGy07Qc4m+K/E29zP/QYg596Y8JzWi
ZrEcgJK3mrQSmeNF7gIfZwscum5onO34S8eAP2qVjpEeGamEV6NvAPtQ2ZiZZp03
djNMXvu3mhYgufYSqdhDbIjHFiDNIsAJ+pMMgz+gnDFisfELYg8=
=w90C
-----END PGP SIGNATURE-----

--Sig_/jN++hbb5Xq5Z4sVt/./+FGM--
