Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC02C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FE121784
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FE121784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeHCThK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:37:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44340 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCThK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:37:10 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fle3M-0000vD-Eq; Fri, 03 Aug 2018 13:39:52 -0400
Message-ID: <1533317992.28585.103.camel@surriel.com>
Subject: Re: [PATCH 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        luto@kernel.org, x86@kernel.org, efault@gmx.de,
        dave.hansen@intel.com
Date:   Fri, 03 Aug 2018 13:39:52 -0400
In-Reply-To: <20180803172516.GM2458@hirez.programming.kicks-ass.net>
References: <20180801100255.4278-1-riel@surriel.com>
         <20180801100255.4278-12-riel@surriel.com>
         <20180803155618.GB2494@hirez.programming.kicks-ass.net>
         <1533314448.28585.101.camel@surriel.com>
         <20180803172516.GM2458@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zzrHFJ9L2f/2GqQONPoP"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zzrHFJ9L2f/2GqQONPoP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-03 at 19:25 +0200, Peter Zijlstra wrote:
> On Fri, Aug 03, 2018 at 12:40:48PM -0400, Rik van Riel wrote:
> > On Fri, 2018-08-03 at 17:56 +0200, Peter Zijlstra wrote:
> > >=20
> > > Why can't we skip the ->active_mm swizzle and keep ->active_mm =3D=3D
> > > ->mm.
> > >=20
> > > Doing the swizzle but not the refcount just makes me itch.
> >=20
> > I am working on that now, it adds another 7-8
> > patches on top of this series.
>=20
> I thought those were taking ->active_mm out entirely, not avoiding
> the
> swizzle, but I might have missed something in the middle :-)

At this point, only the fact that ->active_mm is still
being used by a few places in the code :)

> > The big question is, do we want this optimization
> > to wait for further cleanups, or should we run with
> > code that seems to be stable right now, and put
> > additional cleanups and enhancements on top of it
> > later?
>=20
> At the very least the Changelog needs to explain why we cannot do
> away
> with the swizzle now and how doing the swizzle without the
> refcounting
> is not completely broken (I think I see, but urgh).

The changelog for patches 9 & 10 explains, I think.

What is missing from my explanation?

How would you like to see it explained?

--=20
All Rights Reversed.
--=-zzrHFJ9L2f/2GqQONPoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltkk2gACgkQznnekoTE
3oPD5Qf+MiuWUhnghz5Q5O4mfa+kl4ThWgPH5dQpaxpXfs4nvc63I0f7IaWeILa/
d1goI2hZbn2rlawcBw8oFkGgiLneKZYgifhWSokFfGJXqwEKXWeMYThJi8zx2Qej
CIu17Yr6fwPFYKqwrSvEGmaFHseOLt+sD7KCbsI9Yz56xnCC7pqsrmH3DYqw6EYh
dCFblk/35+1Iud6z5y+aFztf4Y117gn3NgFrpLmGlzEB0aMGk/eW48rF5qfDNPz9
3vkxl6wvco80nU+qbKnKLXrZ0GNAiXY4x2OUGoRe6kyAlDNBKAgEzb34obXwh8iR
U7YCvVehTqqbSqshy9aW5eeX/YBhlg==
=FuK3
-----END PGP SIGNATURE-----

--=-zzrHFJ9L2f/2GqQONPoP--

