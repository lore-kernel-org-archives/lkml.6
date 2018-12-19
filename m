Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAE5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3DE21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sCdXa1xO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeLSCmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 21:42:51 -0500
Received: from ozlabs.org ([203.11.71.1]:52261 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbeLSCmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 21:42:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43KK1d5G5Gz9s3Z;
        Wed, 19 Dec 2018 13:42:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545187367;
        bh=IgoIYHhU0iwM8XeotfzgR0wkaxwDHGd9Uy+oHFtveZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sCdXa1xOQYe9keSAvWQEhYOQWYT8g/0HUtXkEDq6p4BCeeW1x4YlM62iMxaFTT1sP
         0ALvXcw28Axn7+U6evNeTv41IhAe2v008ys5/jMP5JEPivIecP7oiekQGOyK948kMR
         tERV2tQguYBFU2YZuMxEZNRm+Ttw4DONH+jD2wQf7JNtpfmjvTpGVyP8gsIf+2XUO7
         1g0e9D+qa523Yo1VTfKaHyReei0HmBwA0DmSDBXwI+QxaXwvb8IqlH6QJuF+gsx5Q0
         Rbb+Qhsnsrfs39nR8A/3S9t8Xh3lz5XMKvIBjlHksnDKhnTe2GwYtn0F8uvFvpLThF
         LoVUsi6bmvmNA==
Date:   Wed, 19 Dec 2018 13:42:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Kees Cook <keescook@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20181219134243.674b80b7@canb.auug.org.au>
In-Reply-To: <20181129112428.45287471@canb.auug.org.au>
References: <20181129112428.45287471@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GaYj3LuP+JQSqFPEj+DHbQ3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GaYj3LuP+JQSqFPEj+DHbQ3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 29 Nov 2018 11:24:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the net-next tree, today's linux-next build
> (x86_64_allmodconfig) produced this warning:
>=20
> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c: In function 'run_xdp':
> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:324:3: warning: this sta=
tement may fall through [-Wimplicit-fallthrough=3D]
>    bpf_warn_invalid_xdp_action(xdp_act);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:325:2: note: here
>   case XDP_ABORTED:
>   ^~~~
> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:326:3: warning: this sta=
tement may fall through [-Wimplicit-fallthrough=3D]
>    trace_xdp_exception(priv->net_dev, xdp_prog, xdp_act);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:327:2: note: here
>   case XDP_DROP:
>   ^~~~
>=20
> Introduced by commit
>=20
>   7e273a8ebdd3 ("dpaa2-eth: Add basic XDP support")
>=20
> This due to my use of -Wimplicit-fallthrough.  This is new code.  The
> warning can be suppressed by adding a comment like /* fall through */
> at the appropriate places to indicate that the fallthrough is intended.

I am still seeing these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/GaYj3LuP+JQSqFPEj+DHbQ3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwZsCMACgkQAVBC80lX
0Gx51wf/StrZL7vewCSh+ed1scOPDKOPNMhjwt5AYHJXXLg3n2WACsds32NGP0pX
8zVkXtAa0490e119oF5fBxudAgBG6Uru+4qfFX7DNGV+hT8FDIuiX+Rh6rCO0lOG
0l+MtVzN8lLBLepAfp1QcqBfXOoWUiuDPn9uxAHMTCIDSK5xhqXJ7EXdeP8lgk8l
zXA5s1RsTuc3kid4Fe64+PizcMgEPauvF2Fhuj1kAtcSCS5FXzE1FJGwfejuhVCD
+z7BFUc+DH7XXeS033FqI+ZtSTD7ooZou61PShgZqzC5S1xId3VAhvxRK4EHzFZA
TwjweZKy+oiESmKeTzIg2Yb1V0rEqw==
=dv3k
-----END PGP SIGNATURE-----

--Sig_/GaYj3LuP+JQSqFPEj+DHbQ3--
