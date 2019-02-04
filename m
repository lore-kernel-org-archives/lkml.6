Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41786C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA4E2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mFPRGD8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfBDEc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 23:32:58 -0500
Received: from ozlabs.org ([203.11.71.1]:54927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbfBDEc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 23:32:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43tFF311PKz9sCh;
        Mon,  4 Feb 2019 15:32:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549254775;
        bh=tLFqj2QWtQhNeGW8FhaQWSAFSjdsCpVxbHYs33lLIGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mFPRGD8pbXaGcJycEJx8YI2BKvckXRrwNMeMKTk8ohIUTMBlz7hPii3JIn+XHYwgb
         JdMHDqFyYvbMFHly2idadmTDcoB9vX9UnFcw3HxmYJ+TU/JyutKch+jU5SEl6KPm56
         ZHe6lE2iuOp3mk+gr7LoH57gSdg1B1GTqYHRoJRcQVnUJxIU75YB04qsgAr+LVG8Ll
         hT2Q3qzD9OeLblll8HtRqwAA3thjuE7oUzbSrPA8s+1LSkY2OEg203RsQtoXm5nORR
         IKahrXnL68Oh9Of9WAHx+9NuF0sVs+D628Gd+J3W4bQVlag6OTSB1BbIaFnm9mN20N
         OONLpVebHx5kw==
Date:   Mon, 4 Feb 2019 15:32:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, deepa.kernel@gmail.com,
        gustavo@embeddedor.com, keescook@chromium.org
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20190204153254.78c4be0e@canb.auug.org.au>
In-Reply-To: <20190203.202606.1052226767975507689.davem@davemloft.net>
References: <20190204104427.0c0da12d@canb.auug.org.au>
        <20190203.202606.1052226767975507689.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m=qz5rF8O7JV5Nu.bpNzkcs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m=qz5rF8O7JV5Nu.bpNzkcs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sun, 03 Feb 2019 20:26:06 -0800 (PST) David Miller <davem@davemloft.net>=
 wrote:
>
> Thanks, I just pushed the following:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [PATCH] net: Fix fall through warning in y2038 tstamp changes.
>=20
> net/core/sock.c: In function 'sock_setsockopt':
> net/core/sock.c:914:3: warning: this statement may fall through [-Wimplic=
it-fallthrough=3D]
>    sock_set_flag(sk, SOCK_TSTAMP_NEW);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/core/sock.c:915:2: note: here
>   case SO_TIMESTAMPING_OLD:
>   ^~~~
>=20
> Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  net/core/sock.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index a8904ae40713..71ded4d8025c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -912,6 +912,7 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
> =20
>  	case SO_TIMESTAMPING_NEW:
>  		sock_set_flag(sk, SOCK_TSTAMP_NEW);
> +		/* fall through */
>  	case SO_TIMESTAMPING_OLD:
>  		if (val & ~SOF_TIMESTAMPING_MASK) {
>  			ret =3D -EINVAL;

Looks good, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/m=qz5rF8O7JV5Nu.bpNzkcs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxXwHYACgkQAVBC80lX
0GyUOQf/S+6wsCBMEa5p7LrVjgNrMtBCFvStxozA0593II7hsmGHAEw/kmgzB3mG
4+UeSW9wiCp+fhWNXtsI6YderQQ+lmCgv9wetMR00+0uyBndfvXh3slYBo4zKEdC
hRpb5RxF7+6zKcwBYgYXCO/RLVafq0jKvNr4sh4Rj2oE9bru9rolfGgWEcA1alLB
qsqklV008rsBVJHq8kh/LlRijLc59oMr59w88Kfv8w1YRWVdw9Fa5XVppfmQ2a9m
jRrzhAtlbawHmArZ4wMeSv5RgQ0qyb7PSsMmCXMYYBvTkjKweeIT+sElZ0MFzaco
ZQsKQaI8Os9hjKJnlH4+K6aum2P1VA==
=phMT
-----END PGP SIGNATURE-----

--Sig_/m=qz5rF8O7JV5Nu.bpNzkcs--
