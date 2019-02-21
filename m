Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81935C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCDA2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MjO1GqCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfBUMrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:47:19 -0500
Received: from ozlabs.org ([203.11.71.1]:43209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfBUMrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:47:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444vPd1XRfz9s5c;
        Thu, 21 Feb 2019 23:47:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550753237;
        bh=yM4/ZKrzZTIeLRONPSyrxCwblEvM1JJVQBJii+H4zGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MjO1GqCvdo2myxXGVF52cwqLQB3eLUNMzNX/nRyXG71N1lBQ0xB4bjlQVFKNsr7oj
         kfcenEV4Wr+ntwYE4B/NFGRdFfEWLK2MfjrOyw4EPX1L/ZfQMuSqH1FT+m5oU9HG5V
         v0L5PtdsWTnJO4U44UOyIFzO5u94uh7vY2ONzQpmvoWUyDtOq3yEY+FC9WTMK+AaTV
         FsHphXVlyAXOneFO9rKlaLnY7Zs1LYNK/QM1fz8ZvDVJs//WneQ69FwM9Gk0OPypZp
         FaJRpiisPuEyaHSRAYRVukR5DYTthlnm6QxLmHyfxEwDsy6wPmnnFq6Ahwk4SSJwHM
         L7aoxCkoLKOoQ==
Date:   Thu, 21 Feb 2019 23:47:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20190221234716.2144eba3@canb.auug.org.au>
In-Reply-To: <20190213220929.GO24706@mellanox.com>
References: <20190212162003.1aa1ffbd@canb.auug.org.au>
        <20190212161528.GN12668@bombadil.infradead.org>
        <20190212162324.GU24706@mellanox.com>
        <20190213212621.GW12668@bombadil.infradead.org>
        <20190213220929.GO24706@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c_h/E.UVLxT+_wKJIoRLxXt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c_h/E.UVLxT+_wKJIoRLxXt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Wed, 13 Feb 2019 22:09:36 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> I personally think it is not good to put major logic changes in merge
> commits, so I would prefer the #2 approach for this case.

These are not difficult merge fixes or logic changes.

> Also, the general philosophy that the person doing the tree-wide
> change should do the work :)

In fact, I have done the work :-)  All you guys have to do is inform
Linus and give him my resolutions.  The change to xa_alloc_cyclic could
just be a followup patch once the air clears.

> SFR's tree is just a reference. Who ever takes care to resolve these
> conflicts has to manually do the fixing up. If you do send your tree
> early I will fix it up as part of prepping the RDMA tree PR. Otherwise
> you will have to fix it.

Neither of you need to fix it ...

> What I don't want to see is we send both trees at the same time and
> neither gives merge guidance to Linus.

Well, I have now reminded you both, so hopefully you will both tell
Linus.

--=20
Cheers,
Stephen Rothwell

--Sig_/c_h/E.UVLxT+_wKJIoRLxXt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxundQACgkQAVBC80lX
0GzB6gf/UpBD366BoU94lj2JPVdQdYryZbK1+Pt6NiSoAIcSD7JDqyjnWJmJ8/aH
v34W8q0FxDn4CSBIUuXhzkogIEau4wu7/9MeViFcFUjEl5tbDKTXaHXoAy4rKmhm
mCnT4d0fkaqh506NMi5kGVZw0yx42i9okssVej/rNYk/+y0+hAzNExBY9UYOiWnG
yvPfcgoj7c/IxysXsPo/aAMGHUxY9bkRufpm2XmqcCBO6V8zc3uSAI1pv+93SkUh
O3lwTjaTZ11iYBrNbyn8ym+yas4CxQ18d0seEPAHoixSSJU34wqH7tz9wgrcxo5/
9YIeAMyeLKSvnj4tEk0xtaNTqqOHbg==
=5mxv
-----END PGP SIGNATURE-----

--Sig_/c_h/E.UVLxT+_wKJIoRLxXt--
