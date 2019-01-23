Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960A1C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D95320861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mvZnJAjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfAWMOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:14:03 -0500
Received: from ozlabs.org ([203.11.71.1]:50025 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfAWMOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:14:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43l42c1Zqvz9s9G;
        Wed, 23 Jan 2019 23:14:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548245640;
        bh=uYrzplwEPjo71egkX4LXlF8goz4H07XSgFcVu3Kv9I0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mvZnJAjnDBEHUuxaW4k27SdAO0RmGIKq8IIMwtI/gFcDBqi0xWuPKht/Dfnrr39Es
         cJx4FxAJyK+UYUY91iWiuHZUVAmNfcU1CiywX24lrcr7eaR6G7afqFDjWvXwVyuLhr
         l1+AquQpMpibT3RxRHdHbkHGOMyQxjPhYW2iCVfiaRqirea8C4k9TAOTOebiguP5HJ
         NOUGXt7T3haGGtU5y/b7lAkJBbHpPfoEUn4EPnd3OFGNEmPeol/iTM41KDNRzI7rYH
         IChrmY9XD7HIh7KJ5r6c7ccU2xAeZHt2rlsmnmEBtr09FthulMz6GNjnEi/xsg1kZ2
         OkYXoF1XfLyeg==
Date:   Wed, 23 Jan 2019 23:13:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: linux-next: Fixes tags need some work in the dma-mapping-fixes
 tree
Message-ID: <20190123231359.286ac584@canb.auug.org.au>
In-Reply-To: <20190123230915.18046ca7@canb.auug.org.au>
References: <20190123074747.7cd44f12@canb.auug.org.au>
        <20190123071933.GA24861@lst.de>
        <20190123230915.18046ca7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NR0=vs/oLSJSiJsEbEoN_CO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NR0=vs/oLSJSiJsEbEoN_CO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 23 Jan 2019 23:09:15 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 23 Jan 2019 08:19:33 +0100 Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jan 23, 2019 at 07:47:47AM +1100, Stephen Rothwell wrote: =20
> > >   - SHA1 should be at least 12 digits long   =20
> >=20
> > When did we decide on that?  As far as I know it was bumped to 10
> > a while ago.  12 basically makes the line even more unreadable. =20
>=20
> From Documentation//process/submitting-patches.rst:
>=20
> "If your patch fixes a bug in a specific commit, e.g. you found an issue =
using
> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters =
of
> the SHA-1 ID, and the one line summary."

That paragraph was added by commit

  8401aa1f59975 ("Documentation/SubmittingPatches: describe the Fixes: tag")

commited by Linus on 2014-06-07 (before it got moved to the .rst file).

--=20
Cheers,
Stephen Rothwell

--Sig_/NR0=vs/oLSJSiJsEbEoN_CO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxIWocACgkQAVBC80lX
0GxWAgf/dHViaPxy3pHznsrUeJM4vuvnMe/ZKRAZUdkpHSnxbJAD3F7jAAZH0XIY
sUprMmITVjVjW7Yr8Z8g8s08E9eojrUp4K7FmHLKmDlyoKrYtQxCAXb4Vw6G4h9t
+S8VMo2sB6GR/9z/ABfro6HVVMm97aIlCbCkAQkYeoJWuHRRRC8O0ppUG5TRdQNY
IL1smDGdYvzlGdSnHwCCjA/d8eUuJ+YQlqsIEcW1vr+g7Ynp2kyF9q8xLcTvAFMi
Mwu0k9QACS8+9fG+4l0RlxBMtacgwSB/ugnCYURcjgBbysPsQnrGv80iE3a1zvoi
XgOcZ0U7mObkZZMPlHPBVF5WWTwSPg==
=bXTq
-----END PGP SIGNATURE-----

--Sig_/NR0=vs/oLSJSiJsEbEoN_CO--
