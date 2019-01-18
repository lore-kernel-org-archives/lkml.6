Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB99DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A137520850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfARH4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:56:41 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:45324 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfARH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:56:40 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 1D2963A677E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:48:43 +0100 (CET)
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1A6C2FF807;
        Fri, 18 Jan 2019 07:48:38 +0000 (UTC)
Date:   Fri, 18 Jan 2019 08:48:37 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Hartman <ghartman@google.com>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Alistair Strachan <strachan@google.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190118074837.GA6288@hle-laptop.local>
References: <20190117224135.GC8100@hle-laptop.local>
 <20190118071752.GG11050@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20190118071752.GG11050@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

> > introduce wait_event_freezable_hrtimeout, an interruptible and freezable
> > version of wait_event_hrtimeout.
> >=20
> > simplify handle_vsoc_cond_wait (drivers/staging/android/vsoc.c) using t=
his
> > newly added helper and remove useless includes.
> >=20
> > Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> > ---
> >  drivers/staging/android/vsoc.c | 69 +++++-----------------------------
> >  include/linux/wait.h           | 25 ++++++++++--
>=20
> code in drivers/staging/ should be self-contained, and not, if at all
> possible, ever force additional changes on "core" kernel code.
>=20
> Are you sure that the vsoc code can't use one of the current wait
> macros?

As far as I know there is no macro implementing freezable wait with high
resolution timeout.

> Why is it so special and unique that no one else in the kernel
> has ever needed this before it came along?

many wait_event_X() (_exclusive, _interruptible, _timeout) functions have a
freezable counterpart. wait_event_hrtimeout() doesn't, probably because it
is relatively new (and seemingly quite unused).

If there is a wait_event_hrtimeout() function, it makes sense to me to have
wait_event_freezable_hrtimeout().

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxBhMsACgkQZYVUZx9w
0DQaCwf9FZoalsr7SE0nvxKs/14uvlBjDEcKthGwUW69WZAuX89ky3QAAgiyxidi
Xj2cHGyFD5EKpAEsed2SSrlCpH5tmES/GfzX3DR1Y24z9NVTr7ZDZFXke8kvxxJH
tPN2pCdKyrsfNscdIURc1MzpdGM6FbvJc6H1IpznnrvQ+eBs95F75QTH+dz1qDlU
mL/lpGIgrGShZO/0hsfV1e3bAfb/lnQgzMJi25VlHNJJTIhHG2hO2z7MC9DlNnFp
jjgMbF98b5cfXVPvHAbM4OcttK22bKFrKAcyCeyrF+UFt5g+yd0OOiflK92LKS8V
8skLd5Byvz1Oqbm7WFC3zQTeOJerng==
=cxkH
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
