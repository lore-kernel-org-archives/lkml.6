Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEOI6u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:58:50 -0400
Received: from sauhun.de ([88.99.104.3]:33102 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbeEOI6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:58:35 -0400
Date: Tue, 15 May 2018 10:58:33 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: Wenwen Wang <wang6495@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
Message-ID: <20180515085833.4z4cvsxoqqbny53q@ninjato>
References: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
 <20180510111658.sxf3mvye5q6ihxa7@ninjato>
 <8f728c2d-b463-507e-2c36-fad22fd99dff@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jzt5abwbfk6alqil"
Content-Disposition: inline
In-Reply-To: <8f728c2d-b463-507e-2c36-fad22fd99dff@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jzt5abwbfk6alqil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

> >> In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
> >> transfer i2c messages. The number of actual transferred messages is
> >> returned and saved to 'status'. If 'status' is negative, that means an
> >> error occurred during the transfer process. In that case, the value of
> >> 'status' is an error code to indicate the reason of the transfer failu=
re.
> >> In most cases, i2c_transfer() can transfer 'num' messages with no erro=
r.
> >> And so 'status' =3D=3D 'num'. However, due to unexpected errors, it is=
 probable
> >> that only partial messages are transferred by i2c_transfer(). As a res=
ult,
> >> 'status' !=3D 'num'. This special case is not checked after the invoca=
tion of
> >> i2c_transfer() and can potentially lead to unexpected issues in the
> >> following execution since it is expected that 'status' =3D=3D 'num'.
> >>
> >> This patch checks the return value of i2c_transfer() and returns an er=
ror
> >> code -EIO if the number of actual transferred messages 'status' is not
> >> equal to 'num'.
> >>
> >> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> >=20
> > Applied to for-current, thanks!
> >=20
>=20
> I meant to comment here but got side-tracked and never got around to it.
> But see e.g. [1] and [2] for drivers that will not be happy with this
> change. Maybe there are more of those? I did a scan of the drivers in
> algos/ and busses/, but there are drivers all over the tree that
> implements .master_xfer that I have not audited. Who knows what further
> problems this patch will reveal? So, maybe we should be a bit
> conservative and only WARN as a first step?

I came to the conclusion: yes and no.

I think this patch is correct, so it is good to have. But true, it will
expose if other drivers have implemented the return value wrongly. So, I
removed this patch from for-current and plan to include it in for-next
instead if we can agree on that being a good way forward. That will
allow for one full cycle of testing and fixing the issues found. And
hopefully I have time to write a small coccinelle rule to find if
constant values are returned in a function declared as master_xfer.

> PS. Also busses/i2c-rcar.c seems like it might return a short "success"
> for some sequence of events. But I'm not sure about that one...

What do you mean with "short success for some sequence" here?

Thanks,

   Wolfram


--jzt5abwbfk6alqil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr6oTUACgkQFA3kzBSg
KbZ2Tw//cC+5y9aMfkjUiOYYBeX3rm9XqzBmxWIX72eTybh+KE9flHQrIWqsnv6y
mFqQSsc9wkynQS+9FyztJBz/2EnrLsWxc+3huVlvS400MGX0T5isB9OTBxYcOlFd
zwAhWozr8B4yosw0wgr5i1DClFCGbs2No5ZBdg9iBDIG53O8NNvKfSQaEbnZmdvJ
Mssli6btOZYHQRwf88csuYsAm62PHsf4PmCL1vsYteNBe5wo1pZDLWBoPTvhsj4S
HmHhC04+wN41X3dBQUlG/4pCpVvvPB7B1KIn05ZwttgslYlb7PODKKFkZ80SrV7K
G/qyGUpjdO4WSfq/GttLGf2WiJH4B9cDBmcpUlemhVVGsZpojJeOPv5CkJS3CPSl
5Ffp3Y0B09AIJ8YTMM5/KAJWQlplqK4Yh042HjUB0tPZ/tjeT7LbyQSVEfBxfinU
SdeJ673hd4hMzG8Drh1ekTchrvtWaEZunNAEQ0WJ79eCGF4UT0MycxW97kcuCRWe
DjLDMXpifEuKpWpSm0QtWOdMuDY4OTDBHdOsDKfJ6KHxP1yD1sDZTagly95oBGZp
gduDKuCdqUeMY9X7T8g+i76trUAGWt4AO53ZnycONbf/GOcozWWHOOfdQO4X+o4D
WteL712JDJ1RtoTinnx/pRfdctLGNny/1K+dyKg7aeVS4KABV6E=
=vsxh
-----END PGP SIGNATURE-----

--jzt5abwbfk6alqil--
