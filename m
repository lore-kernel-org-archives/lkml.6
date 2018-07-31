Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D493C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0344320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0344320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbeGaQIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:08:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49114 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732222AbeGaQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:08:06 -0400
Received: from nctu-wireless-nat219.nctu.edu.tw ([140.113.136.219] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fkVcH-00012x-7R; Tue, 31 Jul 2018 15:27:13 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fkVc9-0006It-P3; Tue, 31 Jul 2018 22:27:05 +0800
Message-ID: <cfe5b20413c26e82cde9881f43054b709420d208.camel@decadent.org.uk>
Subject: Re: [RFC PATCH 0/4] file: export functions for binder module
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arve@android.com, tkjos@android.com,
        maco@android.com, rlove@google.com
Date:   Tue, 31 Jul 2018 22:27:01 +0800
In-Reply-To: <20180730163452.GE27761@infradead.org>
References: <20180730143710.14413-1-christian@brauner.io>
         <20180730163452.GE27761@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-tfUwb+k0cM6qiBuLL/Vd"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 140.113.136.219
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tfUwb+k0cM6qiBuLL/Vd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-30 at 09:34 -0700, Christoph Hellwig wrote:
> On Mon, Jul 30, 2018 at 04:37:06PM +0200, Christian Brauner wrote:
> > Hey,
> >=20
> > We currently plan on turning the Android binder and ashmem driver into =
a
> > module. We have seen more and more requests by users to be able to use
> > the binder and ashmem features without wanting to convince each distro
> > to enable it by default in their kernel. Debian already started to carr=
y
> > patches for turning them into modules.
>=20
> Yikes.  I really wish Debian would stick more to upstream rather than
> picking random crap like this up.

My hope is that this is a temporary bodge.

The way this happened was:

1. Anbox was proposed as an addition to Debian, including the ashmem
and binder drivers as out-of-tree modules.
2. It was objected that these drivers were already part of the linux
package (though not currently built), and it was bad practice to add a
second copy that would need separate security updates.
3. The kernel team was requested to enable these drivers.
4. I agreed to enable them as modules (like most other drivers).
5. I then discovered that they couldn't be built as modules without
patching, due to these missing exports.

(So how does Anbox build them as modules?  Well, you're really not
going to like this:
https://github.com/anbox/anbox-modules/blob/master/binder/deps.c )

Ben.

--=20
Ben Hutchings
[W]e found...that it wasn't as easy to get programs right as we had
thought. I realized that a large part of my life from then on was going
to be spent in finding mistakes in my own programs.
                                                 - Maurice Wilkes, 1949

--=-tfUwb+k0cM6qiBuLL/Vd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAltgcbUACgkQ57/I7JWG
EQmACBAAtZBmjfLT0MJgb+Mz5SRH2v/SF73n/xn0cBG+G530aAwBXZuufhNMYgCE
yvW2XiDveLTnKzYgNF5ZOr0gDYMhPre0RTzGtuy51DQTjKGYFM2v2/rcxJX1dEjR
4zIvM6b+fZOf47qmybo4MRET3BVUsKBX+uN2DaEua5UyliZ1q71VB/0T2dN6BTQl
Y5+N0IA8GxOCETgLUl1RnKknDc6oNTmHyiPHBShW0uL1BS+msRqSuQ6rZvGqngYS
O15e4nzG2dwVlbHkPN93RpscZOUfYi2pcgYMPz2Zxeyr9XfLsZDGiXEP7KzFfh0a
Iv/wzFFJS4b8jmTJiJWyFUNisMlaCG/kmIOlCndW0M9vryyI8g6GkC+t7ONV5yM6
BXTDjNClFd5bx0Qhi/qUNQimARXLOSAofVXlW8AurEJZ2Dp0Urf6E35COF2NlMP6
1xRyBKrY60Zd1Wk+pKaYvd/82wPeCn+lCxTfxxhjniHWkBBvDfy0QXuaBp67DRwN
krT/kq7VKtsO2YyPAWIoWAlhlSAPC5ZIHQJZEFXIz2wa6CkdA9C7LV9w/YNliXTw
QrGnJKBVgV9MDaz42ocPv7+k/zFgBRg7/8vYIbUUWjXH2KiS45bZJZhXRwj/NTUk
kD3OYn9EiJJH03t3NblWq0n8uKAyyzhFgbj8bxJBgtBxcx7gjqc=
=GYXz
-----END PGP SIGNATURE-----

--=-tfUwb+k0cM6qiBuLL/Vd--
