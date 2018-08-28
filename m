Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8ACC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D912087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RoeBIxlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D912087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeH2Bj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:39:27 -0400
Received: from ozlabs.org ([203.11.71.1]:36509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbeH2Bj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:39:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 420Mkj21b8z9s3x;
        Wed, 29 Aug 2018 07:45:49 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535492749;
        bh=puvH6e4Pj30nQwnHZib3rwgFn9qk5e/D2Yhohkb3K78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RoeBIxlbCyuij93KfshyvUp3MfRYRK2sa26Az/u9bncnPEhSUNbTpElj7cGZuqAYv
         lk2Tk3bLY9/hq1t2eTeK1UQYXIyk+6nWv4XWarOf7FU6tU70C+MIfsHAec9OyRBr9i
         dPBSOJ/Uw4c1DVYaRvp+2Tt6w36ugiRF3gfeKtpWIdpoHh6BWFVmVqX6OdGVQqYOaI
         8OQIH92yQYpRwdTmHMWCrCisNQFtpox0lcdiS5DKatrHFKhNe7/EJsz4Db+E0qkdDV
         xqFILoDA4M8/BhPQO7uu88nrxxT0+jfYudBOY1stsuyNGCuac4LiEE8wExklzPv4Rv
         ukRAsCv4pXO/A==
Date:   Wed, 29 Aug 2018 07:45:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        rf@opensource.cirrus.com,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the mfd tree with Linus' tree
Message-ID: <20180829074523.13dfcc82@canb.auug.org.au>
In-Reply-To: <CAMuHMdU2dK10m2c2b3w6+-6KDr-L5MejJbvo6Y2urj1j-TA7+w@mail.gmail.com>
References: <20180817103913.52544928@canb.auug.org.au>
        <CAMuHMdUQcoMxb=0_i1PYyymUpQ1VBOub+EgDbRJWmrq8_xJ-uQ@mail.gmail.com>
        <20180821183012.3b9bc4f3@canb.auug.org.au>
        <CAMuHMdU2dK10m2c2b3w6+-6KDr-L5MejJbvo6Y2urj1j-TA7+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/O5Rz7Ta5+p2YlxFQ1M6zJbU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O5Rz7Ta5+p2YlxFQ1M6zJbU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, 28 Aug 2018 15:34:38 +0200 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> On Tue, Aug 21, 2018 at 10:31 AM Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> > On Tue, 21 Aug 2018 10:08:54 +0200 Geert Uytterhoeven <geert@linux-m68k=
.org> wrote: =20
> > > To obey sorting rules, the CIRRUS LOGIC entry should be before the CL=
ANG
> > > entry.
> > > Upon closer look, it should be inserted before the CISCO entries, too=
 (in
> > > the mfd tree). =20
> >
> > Thanks for noticing.  Unfortunately it is badly ordered in Linus' tree
> > now as well.  Feel like sending him a patch? =20
>=20
> Your wish is my command; sent.

:-)

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/O5Rz7Ta5+p2YlxFQ1M6zJbU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluFwnMACgkQAVBC80lX
0GzuQAf+KKfiWsSwj/G6A8DDlOuyqtguGEFEJnkPB0ILpqGIxXTu2nos+wBK+VOH
Uri6KHje1gvPfi1vVzradc56tAvgsENprAh9ftHiEBiCnfpym8hAhxNe5DqunNiE
UlC+9tRxMME96xZtLOyfa0mubfmti/g4GMVrQFNxBRHghuIvUTq2KvukXKP9KkpX
rey/3KjSWzMiaAvGsaIk93b0bNBgIkKh1MmOoMvWQKNb38JYi0FpRXSG8bKzC7Aa
5CzoVwoDqmDEqa9m1lndY8/p9gAa5qy1iu5VfRy2rEBvsZKbPjLXiJVCQkD2/dUX
8gk9JyI2eZV1KrcuRrPaaxxvJLifkw==
=0Wbt
-----END PGP SIGNATURE-----

--Sig_/O5Rz7Ta5+p2YlxFQ1M6zJbU--
