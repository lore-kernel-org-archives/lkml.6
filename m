Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3925C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFA821899
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IihY+6Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFA821899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeGGMDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 08:03:45 -0400
Received: from ozlabs.org ([203.11.71.1]:40893 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753889AbeGGMDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 08:03:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41N9H04mWxz9s01;
        Sat,  7 Jul 2018 22:03:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530965021;
        bh=FZWIjHcQNa2kHM8eqezQP5rlYZ++NAun5rsz+1OzhjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IihY+6NwiiMg12MS+ih34jUBe+jJnuzqMIRbkWdgkDIj5n3FPLSmrKkBS9w4kV69h
         xmV251oLbsduKe7jix317+6Yk8P93V2k5SNJ0rHbN2RzIuewNnGvBcl5je5NA/f8Dg
         xnC/YGU+vQhbvkbizy+krniYShmFR3aQBHq4WdiA2lPlE1w/PMpgIA6VaytYHk/ZlE
         MRwQn3/jjRUkIjkHNmj9Y6g5/Ju1n2JdTOgy3affKa8BPiUzFD04jneis3PkNrYMA9
         ah7+cwTz+DzLsB9mXnrnBYpp5XILNXeISaN9rFLllSQO598ne1aLruzEBWRp6oi0P8
         H9BzVjM6lwUjw==
Date:   Sat, 7 Jul 2018 22:03:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, moshe@mellanox.com,
        jiri@mellanox.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20180707220339.3f90340a@canb.auug.org.au>
In-Reply-To: <20180707.203016.623173685153821356.davem@davemloft.net>
References: <20180706095633.676b0229@canb.auug.org.au>
        <20180707.203016.623173685153821356.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2nIqRkEDViUg+WKQ9WiTLaV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2nIqRkEDViUg+WKQ9WiTLaV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sat, 07 Jul 2018 20:30:16 +0900 (KST) David Miller <davem@davemloft.net>=
 wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 6 Jul 2018 09:56:33 +1000
>=20
> > After merging the net-next tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >=20
> > In file included from include/net/dsa.h:24:0,
> >                  from include/linux/platform_data/b53.h:23,
> >                  from drivers/net/dsa/b53/b53_spi.c:25:
> > include/net/devlink.h: In function 'devlink_param_value_changed':
> > include/net/devlink.h:771:9: warning: 'return' with a value, in functio=
n returning void
> >   return -EOPNOTSUPP;
> >          ^
> > include/net/devlink.h:769:1: note: declared here
> >  devlink_param_value_changed(struct devlink *devlink, u32 param_id) =20
>  ...
> > Introduced by commit
> >=20
> >   ea601e170988 ("devlink: Add devlink notifications support for params"=
) =20
>=20
> Thanks Stephen, this should be fixes now.

Great, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/2nIqRkEDViUg+WKQ9WiTLaV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltArBsACgkQAVBC80lX
0Gyo8gf/VQEldn53O3rgoG3/uS5Wdw0FvvEsITaEGsVEHRjsUTbyaQj1qGvHwOYX
2LnorbAbWnyQj3dfewNXUi5LToDc9zg4b12mGZfLRKocetZpxqUjTQyrMrnI2EXs
ea9YsGfEvJdscOh+8cuQUxMm50rKRTg0mlek6ZitkDV4kU6AOoY+ZTHlXedutHcs
o0+9KGJL5utTnWCQfOGxQ0gANeDqXazVL96Rwk+bRO8red+FLW2SjdFMes9MaI0e
lLy1c9WMHTQ9b0VajgxfdOowOMD+qDdBf4CKqKfFhWzZMmkIqpIF7OieLmpTARsg
oSROm/GYUPfhIdFvtafeTkat7IzQ4g==
=9qyb
-----END PGP SIGNATURE-----

--Sig_/2nIqRkEDViUg+WKQ9WiTLaV--
