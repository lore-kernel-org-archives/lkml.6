Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6608EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350E62086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lKUrrYP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfBUMsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:48:05 -0500
Received: from ozlabs.org ([203.11.71.1]:49975 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfBUMsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:48:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444vQV4DGtz9s5c;
        Thu, 21 Feb 2019 23:48:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550753282;
        bh=yGmKxeIvkJz59ljij7s5skDoPxBQo+OQra0bfvzarW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lKUrrYP7OlUxlot8FumDIdIdUsVo5v6aLwrjZUBFxDPjuLGVtSLCdcN1gRtwvVNFw
         XCwWfC4vGvjIBF6cSUKPZmu4nDUh4fPSUSNKu8ADUnmY2qFq6xEkhzsOyT376Dpbix
         n9QiC93Gy8MYh02rzrZyP6nft7EXg56OJVdqPT5i7jQjRSIjx0DPka27ZpU6+SLdeB
         KrHpzQwXNpk/4dzhYz+L2N2s02V2KETEE6aYqdWQFnSoyAwZviz+NzEkAmOaBNCUCJ
         KkkBGS2W0qP4jFWbW9H8/s2DUqrbehDQ/DO2YrV3LW0mLAoKh4dY7sfcH5HAgHkXhL
         9y79F4ZTbI4HQ==
Date:   Thu, 21 Feb 2019 23:48:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20190221234801.7cc07a7c@canb.auug.org.au>
In-Reply-To: <20190221123440.GD17501@mtr-leonro.mtl.com>
References: <20190221171332.262cf619@canb.auug.org.au>
        <20190221123440.GD17501@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4qEQyI/Ct9cA4FzFKbxChaT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4qEQyI/Ct9cA4FzFKbxChaT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Thu, 21 Feb 2019 12:34:42 +0000 Leon Romanovsky <leonro@mellanox.com> wr=
ote:
>
> Matthew, really? change of API in -rc7? And it after you pushed us to
> base our -next on -rc5 after another API change? What should we do now?

The xarray API changes (to xa_alloc and __xa_alloc) have been in
linux-next for about 2 weeks ...

> Can you please ensure that you are sending your pull request to Linus,
> after RDMA pull request will be successfully merged?

It doesn't matter which goes in first, but whoever goes in last should
inform Linus about these (now 2) API change fixups.  In fact you should
probably both let him know as he sometimes batches up similar groups of
merge requests (like fs or net) and doesn't do them in the order they
are submitted.

--=20
Cheers,
Stephen Rothwell

--Sig_/4qEQyI/Ct9cA4FzFKbxChaT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxungEACgkQAVBC80lX
0Gx+qgf/WgG2af6v7Uj/9yAi77ru8hksQ908hYuaD8Ri67KkGMvzZkT2RyJpdY2U
JYAaX56sND9Pq+h+W4NgIgVbu1aSW6NcG7nITqXePw77CDleOTEkimGhMzSJKhqr
tBkkMb/+wmrPNYaJjJm6UyXgfp5jSizikcGU972bUVQO3FklHg3CHjPmkmc8jXa/
HBGdm7tIu2u7yzxtV287cSwYTSGcURtm4CoqPpXzAvvl2JE95zmu1W8yVHRra9l1
XscL2vJCD02VsND9cVxvZYIsCtFptHbwGzNOgiB1M8zGbW0OoKft+KQiT1NCuL8i
zPC/DPUwpDjucqcNdjeuSpZe8PsVbA==
=72YZ
-----END PGP SIGNATURE-----

--Sig_/4qEQyI/Ct9cA4FzFKbxChaT--
