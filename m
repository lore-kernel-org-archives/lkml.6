Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC621C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059362172E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S7HWj5qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059362172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeHCJqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:46:35 -0400
Received: from ozlabs.org ([203.11.71.1]:44459 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeHCJqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:46:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hfPW0cLhz9ryt;
        Fri,  3 Aug 2018 17:51:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533282688;
        bh=cAjmjq32HZmw6jA8kY/SuLp9ojouTqbFlXY4geRuh2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S7HWj5qz5lQgUK3Gup8HxZ7KN6JiiyJeN6IVkMMqm+FmJabCnrJdhRUxLWLiJdjw+
         lrYKmP3Zho2AxHo0xg+mb0OHY9raBwGWgeUwIDthQUHW2oVbLcdRhvv61FASAtey6F
         TERrUIQamW/dowUt54au+ikR6dLxvGNDc/bmQIsg9yL8gbVJkm59UxpGsqqCWhC6mD
         3ZzMRJBZYKNYhTczaEyFsKotLnBqV6jktSpKe2AOcPPHypuzLZumSUUf7nvgVHu69/
         m7yeIAk6lNMKo7nZp+fgLHL6xKJQK3B1YsRYNeJk9CAEg40XREWkItBTdyDfskjzuK
         cyQ2Dutta6xYg==
Date:   Fri, 3 Aug 2018 17:51:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: linux-next: manual merge of the mips tree with the kbuild tree
Message-ID: <20180803175125.5249a459@canb.auug.org.au>
In-Reply-To: <20180803071226.GA2099@lst.de>
References: <20180803092100.7d0fda13@canb.auug.org.au>
        <20180803064128.GA1715@lst.de>
        <20180803164252.5f519701@canb.auug.org.au>
        <20180803071226.GA2099@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UO__9lPXhkKTv+y5e=LNN+K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UO__9lPXhkKTv+y5e=LNN+K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, 3 Aug 2018 09:12:26 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 03, 2018 at 04:42:52PM +1000, Stephen Rothwell wrote:
> >=20
> > On Fri, 3 Aug 2018 08:41:28 +0200 Christoph Hellwig <hch@lst.de> wrote:=
 =20
> > >
> > > On Fri, Aug 03, 2018 at 09:21:00AM +1000, Stephen Rothwell wrote: =20
> > > > I fixed it up (see below)   =20
> > >=20
> > > I can't find any fixup below.. =20
> >=20
> > Sorry about that - see below. =20
>=20
> Thanks.  So just another trivial removals near additions case.

Yes, the notifications are mostly to make sure I haven't done something
stupid and (for more complex cases) to make sure people make Linus
aware when sending pull requests.

--=20
Cheers,
Stephen Rothwell

--Sig_/UO__9lPXhkKTv+y5e=LNN+K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltkCX0ACgkQAVBC80lX
0GyovAgApl5dMT60LL70pOZpqB3YZquf8e7ow2BjmJQXlbnoufEZFGWTX8x+D3BU
akR/ZGfpF/+gyAgwlV+fvIGTIrYfn+OMEWeALmgo0pGTYjBclsvKcxvCCR0VgkR3
5ImQ5Kac4odMo3NDWSZgKrmsUuIbqdRbo4lO/iQ56k1HtiHIl++gZXG4mMYqm/xT
kbT5NgZNkF97J0veaQYkWIuNifDigNNC2hneVkONbTjX2IMl4Ek27jUKG9MO09xt
ZtZU5m4/kSkfp2tvhZU2613N6+koDbJn0Oi7/RaU0wY4/dhnNzuraKfaC1J2f8Y4
pXaUZlI24mCqTWwSe0/ZsDn3LRR8RQ==
=X0ae
-----END PGP SIGNATURE-----

--Sig_/UO__9lPXhkKTv+y5e=LNN+K--
