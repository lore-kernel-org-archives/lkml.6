Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB5B20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="b//6yQJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB5B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeKTFJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:09:15 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55886 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTFJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W4F/RCiToGvWpI2Bnh0DlcNycX6dK+otismK5gzKFsI=; b=b//6yQJx7LxjDTbbFtZ8RnXWt
        fFJz4mUXUofWKnMkxx7agbJBTPRQ35iYp3kEb1yrq+0FW8AzmfiyiFvv56c/rPXVngrqRwjaPm5Of
        ynJ1f8jbytdj4tnkugWmoqpsYuQZUCotsOOJTC9KndDA0Hk3WmCWlyfR81oqit/kBSO8Y=;
Received: from pd9e2f5bb.dip0.t-ipconnect.de ([217.226.245.187] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOoX1-0007pz-Gt; Mon, 19 Nov 2018 19:44:23 +0100
Date:   Mon, 19 Nov 2018 19:44:14 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [PATCH 0/5] gnss: sirf: add support for w2sg0004
 + lna
Message-ID: <20181119194414.1c7d6887@aktux>
In-Reply-To: <3487514B-E546-4F11-8C0A-F5B4A8114376@goldelico.com>
References: <20181118215801.12280-1-andreas@kemnade.info>
        <3487514B-E546-4F11-8C0A-F5B4A8114376@goldelico.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QxG88QwxSvDB+6LkeHZqApT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QxG88QwxSvDB+6LkeHZqApT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 19 Nov 2018 09:22:59 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi,
>=20
> > Am 18.11.2018 um 22:57 schrieb Andreas Kemnade <andreas@kemnade.info>:
> >=20
> > Here is another chapter of the story to get gta04 gnss power
> > management into the mainline kernel.
> > There is a w2sg0004 without wakeup line in there, so power state
> > can only be determined indirectly by looking at the serial data lines.
> > Then there as also an lna which needs to be powered for real gps
> > reception. That part needs probably more discussion, since it might
> > be an idea to have it more generalized since it has nothing todo
> > with the chip itself. =20
>=20
> On the other hand if we follow the "SoC is the spider in the net"
> way of looking at DTS hierarchy, we have the uart as a child of the
> SoC and the gnss receiver as a serdev child of the UART. The LNA
> is even one step more distantly connected to the gnss. So it makes
> sense to me to have it as a property/reference of the gnss chip's
> DTS record which is a sibling of the compatible records. So the only
> place where it can be reasonably processed is the driver.
>=20
Or the lna is a child of the gnss receiver. The whole thing
should probably not be overdesigned, but it does not make sense that
every gnss chip driver has some lna logic.
Maybe the regulator should just be stored in the struct
gnss_device and then drivers/gnss/core.c takes care.

Regards,
Andreas

--Sig_/QxG88QwxSvDB+6LkeHZqApT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvzBH4ACgkQfb1qx03i
kyTgPQ//RA8pPeqn1cTeHl9WICut+tS9Hi42qRG7/a+aR2lAz+/FiWc0cJPoF8vO
h1vTlnCR+NsGC7jT2X/I1RW50isiCmzNTAcPaEBmKj1JbjslowWL29GiG03TibID
Y7be5v6SiZiDNvCBRkuC5x1zCNAWHOf66/HsQQLsX2FABMgZSGNE9pwpPTSUDbIz
dBxCYPZl3ax6aRN3eo9kIl3UHvSVGx940VG9tdNl7rCtpWpQYOzedK2OX+ZtQjeI
b3S2kK1gcQQYsA3dLWHpVnCWujDzoT7/HzuVl2C1jCrJyuyf/cDbHjJpNRoq5gBS
waZYlTKm9Wzd9M3wFbFE6JjG6DH4JVJZqXTPJ8DJBCy4YgSFpU5NmA+20wpDF6sL
wp+MzhOS3A+fc9lMAGEC8HPZltXQmRxcilCOR91wYBCAlK0BeY4hXN+Pd5ESiLhG
Z6sW5wH/fUlUoQ69zu74IXid1NJB2qI6QWX4wtXFMUcfJvCdihja03taMW8qgzLV
7RstMW0xpWIkNX3uJSAI/gQmGhZQt1nsnZkVX3acq70ZlcIbrjPMm7i0xboesS4J
SOR804e7EwmZ86r58GmNpsJ5uXbihMlkGtTSWt8nba+hBBztPZVw/SLpsvsbqGET
Yrr6rVH8rdseHfqLZGxZWEO/woTXOvCGNGS+e1DY2eXBrlt3eCw=
=7gJ+
-----END PGP SIGNATURE-----

--Sig_/QxG88QwxSvDB+6LkeHZqApT--
