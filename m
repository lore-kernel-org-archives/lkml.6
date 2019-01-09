Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D33C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F994206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfAIOJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:09:59 -0500
Received: from shelob.surriel.com ([96.67.55.147]:40932 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfAIOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:09:59 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ghEYI-0000vK-BT; Wed, 09 Jan 2019 09:09:50 -0500
Message-ID: <a8d1cbfa03c9bf5f1eeaee7539dacc581df2dd97.camel@surriel.com>
Subject: Re: [PATCH] mm,slab,memcg: call memcg kmem put cache with same
 condition as get
From:   Rik van Riel <riel@surriel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux MM <linux-mm@kvack.org>, stable@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Date:   Wed, 09 Jan 2019 09:09:49 -0500
In-Reply-To: <CALvZod6=-kdUk23i7eOr5AO-_2Fk_BmJiL3QjSJ4S4QOs0xKkw@mail.gmail.com>
References: <20190109040107.4110-1-riel@surriel.com>
         <CALvZod6=-kdUk23i7eOr5AO-_2Fk_BmJiL3QjSJ4S4QOs0xKkw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BjQKRT72GxnNzF5sMK37"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BjQKRT72GxnNzF5sMK37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-01-08 at 21:36 -0800, Shakeel Butt wrote:
> On Tue, Jan 8, 2019 at 8:01 PM Rik van Riel <riel@surriel.com> wrote:
> >=20
> > There is an imbalance between when slab_pre_alloc_hook calls
> > memcg_kmem_get_cache and when slab_post_alloc_hook calls
> > memcg_kmem_put_cache.
> >=20
>=20
> Can you explain how there is an imbalance? If the returned kmem cache
> from memcg_kmem_get_cache() is the memcg kmem cache then the refcnt
> of
> memcg is elevated and the memcg_kmem_put_cache() will correctly
> decrement the refcnt of the memcg.

Indeed, you are right. Never mind this patch.

Back to square one on that bug.

--=20
All Rights Reversed.

--=-BjQKRT72GxnNzF5sMK37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlw2AK4ACgkQznnekoTE
3oNwFQgAobJ9soQwmXZZ20jPst6Vl7FQSysrv9t4VZcbUewwW6/5ZRB2anQinVnE
Gibkl56x1s2oZUBsrc4/Uj31f3Q4RB22cmMzHQTA2Yj2rQgcrg6bgLvFaNuQ3naN
ws1l31twrEQ8tAK7ev1J0jIrOX4zVGAc31UF+7KqQaVjm5BQB1wTlgjbJjgGOuyJ
iRuMJHC6FVyy3jEFM3QagSwx5fm5/zLgmfSecELHbfr1CLrRAZ8ZVfpxKDx8N4cw
eZ3wpjCwoaxjNWbAv4RdP8TDTyYQ539hwqQe7qhNpnd62p3V3fBKFJTv7SiPjVo/
x9W2kutLBLvyrjNoiGlSzJf0xTjj9Q==
=+tvN
-----END PGP SIGNATURE-----

--=-BjQKRT72GxnNzF5sMK37--

