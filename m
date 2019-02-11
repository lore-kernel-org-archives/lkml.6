Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B587FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87574218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OX5z4OD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbfBKUTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:19:15 -0500
Received: from ozlabs.org ([203.11.71.1]:59113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfBKUTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:19:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yxvh1WM5z9s7h;
        Tue, 12 Feb 2019 07:19:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549916352;
        bh=qTIa6rasE/P487XUOpRxQuf27IKU49oS/tixF06IFPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OX5z4OD/coKNOQ7djOQZgki9GL1R+NXmKWfBML0IfsXrQvjOoY7jTKdwLYj6beTwh
         uHNcXsE5GSYm+u4PK78OYyqR/fnYh+eHRRx84AsBjaxrLgEoIQh+LItNzSu027W0Nn
         Q2JqbNWLwYaR20J4H9NJrKaym0CmGJYFHMlyxG8PGyxzQORt6Nkp4nlH9GtO+dtyiO
         e/fLFPR9NQyb3bq5TV+CCOk6DrzkojpjA+F4cfsaP/95dA6DK/yYTnoQs0O0L82sZp
         a4FdA7ymBZ+HI6DsnNG00UoWS5sXI3wjMGMttH5xtYcgMKb0YB236qP/2YXE7lxxd/
         RN0bYfpnm2cTQ==
Date:   Tue, 12 Feb 2019 07:18:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 081/352] f2fs: avoid build warn of fall_through
Message-ID: <20190212071858.1a6a43c4@canb.auug.org.au>
In-Reply-To: <20190211141851.175526205@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
        <20190211141851.175526205@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UO4lzIyFLO0fEJ_yV8qfr1="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UO4lzIyFLO0fEJ_yV8qfr1=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 11 Feb 2019 15:15:08 +0100 Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org> wrote:
>
> 4.20-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> [ Upstream commit f5d5510e7389fa264337fb524346bac9eb93adc8 ]
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

Does the 4.20 stable tree use -Wimplicit-fallthrough?  I assume not
(since v4.20 doesn't), so this warning does not happen in that tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/UO4lzIyFLO0fEJ_yV8qfr1=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxh2LIACgkQAVBC80lX
0Gwjlgf/ZkViUA6N9NOj11cEp/+ji/zMBm7WXvhpntX8fYgWO1AO3AZAO1AVgizB
pqsHqD69UdCFjPhr4rhnZrUY1GjoCvgrx9lFPtcSyfUwuoFI0O6QrM/VGJXXZEN6
IeiGVFkuHxZxDRSIHoYgRVZgA651tj3Z2F2xNoDKZNgrbZxBBTutMg2jD+Kjqs9S
XN5rGJYIHV9l1D4ULZlZvS5si8SiURbF1g25MTiKoBH0ghtdOs4fqAAJ7/CFrRqo
pfbFCfFy4hUxITM5E92zYfQtqJB+gVf/DqJbsd3+sTv++C0uttYgdxIDMlqqKEgt
Asgj6b4mkFoap06BTzQ4VwvLOz5FPQ==
=FK7G
-----END PGP SIGNATURE-----

--Sig_/UO4lzIyFLO0fEJ_yV8qfr1=--
