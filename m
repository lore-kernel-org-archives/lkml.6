Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC76C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC1621532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC1621532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeIWCwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:52:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47612 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbeIWCwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:52:34 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3oy9-0003zd-Sb; Sat, 22 Sep 2018 21:57:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3oy4-0005IG-JB; Sat, 22 Sep 2018 21:57:32 +0100
Message-ID: <9017f05c55d2dd39f76f0a0e43c8ccbccdfaf9b4.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 51/63] xfs: catch inode allocation state mismatch
 corruption
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Carlos Maiolino <cmaiolino@redhat.com>
Date:   Sat, 22 Sep 2018 21:57:27 +0100
In-Reply-To: <20180922052544.GB19103@rh>
References: <lsq.1537575341.194909669@decadent.org.uk>
         <lsq.1537575342.261199041@decadent.org.uk> <20180922052544.GB19103@rh>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-2cthv6C9qjk+h7PUJsZi"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2cthv6C9qjk+h7PUJsZi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-09-22 at 15:25 +1000, Dave Chinner wrote:
> On Sat, Sep 22, 2018 at 01:15:42AM +0100, Ben Hutchings wrote:
> > 3.16.58-rc1 review patch.  If anyone has any objections, please let
> > me know.
> >=20
> > ------------------
> >=20
> > From: Dave Chinner <dchinner@redhat.com>
> >=20
> > commit ee457001ed6c6f31ddad69c24c1da8f377d8472d upstream.
> >=20
> > We recently came across a V4 filesystem causing memory corruption
> > due to a newly allocated inode being setup twice and being added to
> > the superblock inode list twice. From code inspection, the only way
> > this could happen is if a newly allocated inode was not marked as
> > free on disk (i.e. di_mode wasn't zero).
>=20
> ....
> > Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> > Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> > Tested-by: Carlos Maiolino <cmaiolino@redhat.com>
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > [bwh: Backported to 3.16:
> >  - Look up mode in XFS inode, not VFS inode
> >  - Use positive error codes, and EIO instead of EFSCORRUPTED]
>=20
> Why EIO?

I believe EIO was the usual error code used for filesystem errors
before EFSCORRUPTED was added.  But now I see xfs had its own private
definition of EFSCORRUPTED.  I'll change this back.

Ben.

--=20
Ben Hutchings
Any sufficiently advanced bug is indistinguishable from a feature.



--=-2cthv6C9qjk+h7PUJsZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlumrLcACgkQ57/I7JWG
EQkhyg//anS3OVI11ZgyM9UU41HCGh+Qy7MSSiCjslz8QsqWnzChtE3N2goxNz4w
VgGugw36b1RePqSyz24+TCpJSHmNVIJ4HXX57WpNAS650qSIosm1LIagRHfCAB+w
yBLNoI3bXjtpKTAWi/YsBLGm4WNU/lMYBZu5MET59MqJH3pJbMyrklTQq+dV/pG+
bBP18mX5t5dtDB9/CPd2o7CpJxPhFOjyo9PuCV/lUJr4Fkt3jKzh5NIK3Ldv+SLj
jmXsu47lqksRSBLSpT3m9CPOE1oDWfrSHf8dIb/BkifSSeso4tbiI67AXmet0iJg
VyO/l8a/QIhoxVG7CzBky/zM+37CTSaAulKLNcopxQJFwcYAzSp0y6+Ujo3zTnGN
yreKUSWny0ePqyscaMMja56AI/isgXrsma/Cs/g/MUkLZpB3V0Dtd4zFjKpuypoq
WiUS7ltX49quvnw81N46pWLrMKl7hpRYppEg0yaquI3YzzIJ6s7PUyYgAekiI/Wi
abLJIgcaslpkE+J7IHs3rrF5OXqShJ3HEp0ZSdv4CHLpcUA1YYCqZmJ9rjqeowQT
P3wqn1YSBQZcZCB9WZ9T64OwI/SJ6fyAAtbD6WEbFVYdHVUM08Ob1qLuNBQxjibv
14+5D1BpqxjRc+lR3faxC/i5gJk1381yCoF0faie08EwzwpgUEw=
=mK0Q
-----END PGP SIGNATURE-----

--=-2cthv6C9qjk+h7PUJsZi--
