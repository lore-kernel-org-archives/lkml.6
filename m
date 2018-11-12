Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F1520685
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F1520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeKMIWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:22:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56494 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeKMIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:22:40 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C1B9D263974
Received: by earth.universe (Postfix, from userid 1000)
        id BC4793C08D6; Mon, 12 Nov 2018 23:27:26 +0100 (CET)
Date:   Mon, 12 Nov 2018 23:27:26 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
Message-ID: <20181112222726.73m2oca7hankvcjs@earth.universe>
References: <20181110232034.17277-1-andreas@kemnade.info>
 <20181111024648.7rt7rlhaqihtqecv@earth.universe>
 <20181112215812.18ebca35@aktux>
 <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ze4zhyyztanyefel"
Content-Disposition: inline
In-Reply-To: <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ze4zhyyztanyefel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 12, 2018 at 10:19:02PM +0100, H. Nikolaus Schaller wrote:
> > Am 12.11.2018 um 21:59 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > On Sun, 11 Nov 2018 03:46:48 +0100
> > Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> >> On Sun, Nov 11, 2018 at 12:20:34AM +0100, Andreas Kemnade wrote:
> >>> This is a first try to be able to use h4 devices specified in
> >>> the devicetree, so you do not need to call hciattach and
> >>> it can be automatically probed.
> >>>=20
> >>> Of course, proper devicetree bindings documentation is
> >>> missing. And also you would extend that by regulator/
> >>> enable gpio settings.
> >>>=20
> >>> But before proceeding further it should be checked if the
> >>> general way of doing things is right.
> >>>=20
> >>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>> --- =20
> >>=20
> >> Patch looks good to me, just one note
> >>=20
> > I found one thing myself:
> > Shouldn't we have a generic compatible string like "generic-h4".
> > ehci-platform.c has for example:
> >        { .compatible =3D "generic-ehci", },
>=20
> There might be differences in h4 compatible devices (e.g. default
> baud rate) so that I would not bet there a "generic-h4" suffices
> in the long run.

My suggestion is to use this in DT:

compatible =3D "wi2wi,w2cbw003-bluetooth", "<something generic>";

The driver can start with supporting just the generic compatible
string. If somebody finds some incompatible differences, the driver
can add a custom handler for the wi2wi chip without breaking DT
ABI.

-- Sebastian

--ze4zhyyztanyefel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvp/ksACgkQ2O7X88g7
+poHVg/7BoyvAyCiJONVG/I/lUUFzZO05ADwRgWs1GsR4Q1HwTy5in8qptYBNgU3
MR8xJ5ou91KrarNONScppcqfhMpl3HIGi/u15OIy86lU2ZjLdU4G4tEgAthY8Fgj
B+lNyiEd4j6omKrf2Y/2yXACS3J61n8goVL8X9aOx1EtuQxkU0MFRLsabRwMWLD1
wmAHUTFkrxLC2NAGJIElUyu3MxsWyoVAlGvxdBseFJjADk2tjwwUJIvz284CJ2qn
MG30ZsEiXrhBSSBFz6tJ9x7zI5ty55Uhtgtsro/R2lEdSL2IrdNxML9QxavzA/Q1
DfMfBBaFdeEBmIVycj8eaNJriP07dKqxwVnoy81bwE9V5DQF7yeSlHTDZJoz36Y5
1qIpKcTdx4EEK2Z6TMXY7kshGlg/MB4gxsaJspTtUszgFgVxJ9uN59ZW3yca+RYL
YYxfQkA4wnCC+FqyFJKgPqzoR1Xy6l3iJiRDRIgb8EmvRFwRPqhW2ygVmLJOS3iG
Ai0AscnY9IUoOynEcpt1WD06mlpYQSHhG5TU+ZXqxG1wPMzCckRsalVfeQNUd3YF
k/9jUoipLHgTw/m085aT2N5HTFM6W3uOteADUoG8fAAuGSbELON5Og3tMhe86WSi
4uRJrN7O2ZcivXtd6+mqnfcfei3k+oAIHAe/34DmzE9YcUKZ7Hk=
=ngpR
-----END PGP SIGNATURE-----

--ze4zhyyztanyefel--
