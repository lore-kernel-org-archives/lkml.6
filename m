Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0A12084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a2/mvdXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfBUNYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:24:00 -0500
Received: from ozlabs.org ([203.11.71.1]:59925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBUNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:24:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444wCx2lfcz9s6w;
        Fri, 22 Feb 2019 00:23:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550755437;
        bh=QOOgBasyKcc7aHGvJ/OG465XBrnN0pcPbGhLTGe6gTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a2/mvdXci3BOamhUCUmt98xZFy4zcWnMva54RrUKXTEIOg8mJzTl9s/obtlOLHgCm
         HaieUYgygz/PVZRD3J43XV457LK/4kfVKc3vvZzzF/8m5KR450B2pi7klFv+LZsBwn
         1HyRcZ1X6ABE4CzPiOnCaGCgkTxjzHI8qdTVX8TsloShXCFL5ZCb2xZ3Ef+73Z1aFf
         f9fLaTvv3K2QksmcZu8nV1aQuPw5DfO5w6nytAIJVTCPMT2/+eYqHG7ZGcTdH8mbB+
         as5Msw70J8iEgdjPYG6uGHj5oV9H412ARphVqmjh6J88vBtIyHz+dY0c2I2sg9cFPp
         jqq47FqCCPkyQ==
Date:   Fri, 22 Feb 2019 00:23:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20190222002356.269ec801@canb.auug.org.au>
In-Reply-To: <20190221131628.GA23561@mtr-leonro.mtl.com>
References: <20190221171332.262cf619@canb.auug.org.au>
        <20190221123440.GD17501@mtr-leonro.mtl.com>
        <20190221234801.7cc07a7c@canb.auug.org.au>
        <20190221131628.GA23561@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CHoKaR6d.48P86L+2vNrJNs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CHoKaR6d.48P86L+2vNrJNs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Thu, 21 Feb 2019 13:16:31 +0000 Leon Romanovsky <leonro@mellanox.com> wr=
ote:
>
> > The xarray API changes (to xa_alloc and __xa_alloc) have been in
> > linux-next for about 2 weeks ... =20
>=20
> I looked on the latest update of pulled branch
> http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xa=
rray

Yeah, there were 3 commits added today, but the API changing commit is olde=
r.

> > It doesn't matter which goes in first, but whoever goes in last should
> > inform Linus about these (now 2) API change fixups.  In fact you should
> > probably both let him know as he sometimes batches up similar groups of
> > merge requests (like fs or net) and doesn't do them in the order they
> > are submitted. =20
>=20
> OK, we will do.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/CHoKaR6d.48P86L+2vNrJNs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxupmwACgkQAVBC80lX
0Gx14gf+LbqFhLHErbrJQrAMrlzbTjS+QDO3ubfnVwIc5MIZg3LsRpLx6DabeHk7
Y1g+r/Db2CbN0Ncc2YeS7ivfxJ2/xd3rFOx6qCti2IM1fpYYL91sMjx2JcxoFt5x
yw1jknRgeIEJIpV4/E7I5Y/CsdtNZKRzq6eNOutjt91oHIIswOfvOpebEMjd+Ntv
E5FUFHQGo5wUeIm74dRBF1GscF+FLQ8ctlrSJYfkABZ9TshHS1v2hIl/oTZvc4ag
m3jL4+Zx61szBV67CEexG6XDRNYgsVqJ5RVKVCkb4LtSb3F0Ysd1CzSt0vHd32LC
1dAWQs/uAQxUlwrNlm+NIY7/1+8pDg==
=MgXk
-----END PGP SIGNATURE-----

--Sig_/CHoKaR6d.48P86L+2vNrJNs--
