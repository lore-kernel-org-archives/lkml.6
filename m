Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A57C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE2F21473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p5ypRUS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE2F21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeK0JgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:36:12 -0500
Received: from ozlabs.org ([203.11.71.1]:45923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbeK0JgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:36:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 433hhF45r1z9s3C;
        Tue, 27 Nov 2018 09:40:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543272029;
        bh=OlPyh+hjeqUGXa9K4XSM4K229V5vo2j61Wn3hV97p84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p5ypRUS/ti6zegmzkKlj8BimhXY845QR+mWUdASVuuinVwwCT+WUlDHiWMYl7O7IZ
         LwzYg236U3Qbe+e5d4OWMEVx/G6W/hFeUEb0UdTi1s6ZOJDiKbr0KCTYqN5P0nkbWg
         mHs3FcpE+HhJoU10+La7ZAixl76BPL5/OMiG+YRjkCaR9DaQi79ipK6zzlYD9viMbu
         N8gtPhFwJ2fBeGVeH3vBzH6Ld6TQ6OhN1riUmb9SSf4Mo+VlqggTC64RJPFeXyULrc
         WvwgzD5lioePjimjFflkiXs+1KRXhjDg/4rUPwrALNB+n2nrcgd26wYn3jdh1VKQJh
         FSm2HFCpH8LMQ==
Date:   Tue, 27 Nov 2018 09:40:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Kees Cook <keescook@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: linux-next: build warning after merge of the f2fs tree
Message-ID: <20181127094029.68ce2322@canb.auug.org.au>
In-Reply-To: <20181126222257.GB55960@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181126111933.1b0fb324@canb.auug.org.au>
        <20181126215924.GA55960@jaegeuk-macbookpro.roam.corp.google.com>
        <20181127091747.4830d123@canb.auug.org.au>
        <20181126222257.GB55960@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Bmqd=dgIjI9Oi56n3LVdm1f"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bmqd=dgIjI9Oi56n3LVdm1f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,

On Mon, 26 Nov 2018 14:22:57 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Is this okay?

That looks great, thanks.

> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Mon, 26 Nov 2018 14:20:32 -0800
> Subject: [PATCH] f2fs: avoid build warn of fall_through
>=20
> After merging the f2fs tree, today's linux-next build
>  (x86_64_allmodconfig) produced this warning:
>=20
>  In file included from fs/f2fs/dir.c:11:
>  fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
>  fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimpli=
cit-fallthrough=3D]
>     if (set)
>        ^
>  fs/f2fs/f2fs.h:2390:2: note: here
>    case FI_DATA_EXIST:
>    ^~~~
>=20
>  Exposed by my use of -Wimplicit-fallthrough
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 26ad1de8641c..b3fe6803d4c6 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2387,6 +2387,7 @@ static inline void __mark_inode_dirty_flag(struct i=
node *inode,
>  	case FI_NEW_INODE:
>  		if (set)
>  			return;
> +		/* fall through */
>  	case FI_DATA_EXIST:
>  	case FI_INLINE_DOTS:
>  	case FI_PIN_FILE:
> --=20

--=20
Cheers,
Stephen Rothwell

--Sig_/Bmqd=dgIjI9Oi56n3LVdm1f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv8dl0ACgkQAVBC80lX
0GwTQAf+Pss4gmOFL+eTIo+EH0mGhzGP6Doi4L2gl7kKtG3jBfP1NGpsIXXMBDsj
igno02FBmI1zgX6MzUp78mEzGeq4dzOjNhpTTGlo9MNoLKjCHgTBZRVvhJ0HE9m6
hU2Ff19mTVpv88y0AH1KyfaD/OFVs/rDiM+I0JV5aP+sOuorG2FfdKiY936x9hZO
pOUrylAjwE2yjCVzdlsOeTotVlmV3IfIKcduW2rD/mVhF4krgMOsODXHvGPEW7tM
5ZLGsoNQQIkthru8hg1NhBa+akJvb9HzTMQarqNVFLbOkMyWskUVWV+e/phCXeZM
AZxxIzJPkIN64a+jHoFS7ypEbUwH8g==
=V9lz
-----END PGP SIGNATURE-----

--Sig_/Bmqd=dgIjI9Oi56n3LVdm1f--
