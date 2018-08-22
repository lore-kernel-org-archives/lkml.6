Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 22:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2BF208D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 22:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2BF208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeHWBhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:37:54 -0400
Received: from shelob.surriel.com ([96.67.55.147]:59706 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHWBhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:37:54 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fsbLD-0007vW-9Z; Wed, 22 Aug 2018 18:11:03 -0400
Message-ID: <15474e3aa44fe9f67b6fa6ddb67ff8fc0e6831ad.camel@surriel.com>
Subject: Re: [PATCH 1/4] x86/mm/tlb: Revert the recent lazy TLB patches
From:   Rik van Riel <riel@surriel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Date:   Wed, 22 Aug 2018 18:11:02 -0400
In-Reply-To: <CA+55aFw6bBFnV__JZnzh0ZCSTma5J2ijH8BnMtfK55dnjVp=dw@mail.gmail.com>
References: <20180822153012.173508681@infradead.org>
         <20180822154046.717610121@infradead.org>
         <CA+55aFw6bBFnV__JZnzh0ZCSTma5J2ijH8BnMtfK55dnjVp=dw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hz++tz2+IaVsyr5y/rZl"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hz++tz2+IaVsyr5y/rZl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-22 at 14:37 -0700, Linus Torvalds wrote:
> On Wed, Aug 22, 2018 at 8:46 AM Peter Zijlstra <peterz@infradead.org>
> wrote:
> >=20
> > Revert [..] in order to simplify the TLB invalidate fixes for x86.
> > We'll try again later.
>=20
> Rik, I assume I should take your earlier "yeah, I can try later" as
> an
> ack for this?

Yes, feel free to add my Acked-by: to all these
patches.

Patch 3/4 is not ideal, with the slow path in
tlb_remove_table sending two IPIs (one to every
CPU, one to the CPUs in the mm_cpumask), but
that is a slow path we should not be hitting
much anyway.

--=20
All Rights Reversed.

--=-hz++tz2+IaVsyr5y/rZl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlt933YACgkQznnekoTE
3oOMsAf/RJSe6V5kEnd6+uZ0fO6hjLhBKFelbSOom6tOoNv9xYtJb9aJY3dxw32J
5JBt5ihzQ2dGvSshTNYGY3okOXuq4gy46TrYGr7MS41yuHGEgBB/j8+48fWTGdAe
LzNXHGJ31Q+MACbk1MeHYAMvsWk32ri1u9sVelp3Cw3A/eACUsGaR8O0yC2zL/nJ
NZLofB9ceux/wnz+tg4wtubCE2AyirjJFmSTPjlbMhUeEEbkqp1B2UB7tBxwpKDl
buFJym74wL4KTMaxWH5dFEpVHolTSsFrdU+EdnDFSuP/LPMdJVo4CHxlGIWaUaEw
2l6Xqy7sF1U9kFT1azCKO2LzfHrdJQ==
=jSan
-----END PGP SIGNATURE-----

--=-hz++tz2+IaVsyr5y/rZl--

