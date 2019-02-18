Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FBDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B155C217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfBRPau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:30:50 -0500
Received: from shelob.surriel.com ([96.67.55.147]:54980 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731943AbfBRPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:30:49 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gvksW-00040i-Kg; Mon, 18 Feb 2019 10:30:44 -0500
Message-ID: <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com>
Subject: Re: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a
 relatively small number of objects"
From:   Rik van Riel <riel@surriel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Wolfgang Walter <linux@stwm.de>, Roman Gushchin <guro@fb.com>,
        Spock <dairinin@gmail.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Feb 2019 10:30:44 -0500
In-Reply-To: <20190218133501.533140116@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
         <20190218133501.533140116@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HrjbQvu4pfqtF7rEbfwL"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HrjbQvu4pfqtF7rEbfwL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-02-18 at 14:43 +0100, Greg Kroah-Hartman wrote:
> 4.20-stable review patch.  If anyone has any objections, please let
> me know.
>=20
> ------------------
>=20
> From: Dave Chinner <dchinner@redhat.com>
>=20
> commit a9a238e83fbb0df31c3b9b67003f8f9d1d1b6c96 upstream.
>=20
> This reverts commit 172b06c32b9497 ("mm: slowly shrink slabs with a
> relatively small number of objects").

This revert will result in the slab caches of dead
cgroups with a small number of remaining objects never
getting reclaimed, which can be a memory leak in some
configurations.

But hey, that's your tradeoff to make.

--=20
All Rights Reversed.

--=-HrjbQvu4pfqtF7rEbfwL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlxqz6QACgkQznnekoTE
3oPMPAf/aMoAo7VCI+2IA9GMcxdqerqDRe93L7Dz/CQklTNsUiBvPvY7Ybqrj7Pl
XWUTtHj08FdSIgzuCpLj4ntKr0xC6IhJfYNcfQCnwLgXt+PwPw1zPhOjgxgNfzPb
LTcLbmyy6Ilz9wSYoWddKJ5mUc69ZPat6f0mFi+T0rKkx2Dh7a4G6SG30XsBqlBM
aG4fxDdCM+RV09zhLfABIKLmOuezLvhyZhaocVp/BoRllnlob+DDqyBIVxZq4TOd
weq+cCpsI34RZCnss+5OdYDJ0No0/V+oKCGKLhmdJp8NCva49qcnzTe6DEyIabNj
jn/awLkZVJCOeYLzoS3dmHyG4BO0BQ==
=vJ0N
-----END PGP SIGNATURE-----

--=-HrjbQvu4pfqtF7rEbfwL--

