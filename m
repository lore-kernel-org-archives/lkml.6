Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C4FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053D62133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ilz7cmTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053D62133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeLEW6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:58:18 -0500
Received: from ozlabs.org ([203.11.71.1]:37859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeLEW6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:58:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439Dfc01n8z9s1c;
        Thu,  6 Dec 2018 09:58:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544050696;
        bh=7235hw7rLxli5r5+cwe3EPN8zwzUs8O2xgN66+hxBrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ilz7cmTVXz3t9+0ua1dgEaf5BtU4MwhH+uyg76GNaYatcVXIG2+SyCdEa93OvV328
         DxCkazEjokqNDhdv4fp06bczbfzKSLIEEFOWK40GBuEgBXcqxc/r5hlwledghwRziR
         uljqjs6OnbOrJfKjJGsiiLLoOcRgvxHOsse+k9oIuS7Kn6/VfYCMxY+74hUMshN09E
         szGLVFwS8FlNVadRCeBAhWhMp3McFd6vzKXzA/WKNL4YnBsaNWu4R1tlEGrp/0tz36
         Z9EVGFl2hWPy/6qVOhHQLDhGaDGS+LrZVKbYIWhH1zEOH8FPHFaW4GBvy5gxx4nVk6
         nJp0vW08Fd5mA==
Date:   Thu, 6 Dec 2018 09:58:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Guy Levi(SW)" <guyle@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Changbin Du <changbin.du@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20181206095815.6e814057@canb.auug.org.au>
In-Reply-To: <AM0PR05MB533192C82AA04E89004251A1C7A80@AM0PR05MB5331.eurprd05.prod.outlook.com>
References: <20181204114731.48b18bfc@canb.auug.org.au>
        <20181204015247.GR12288@mellanox.com>
        <AM0PR05MB533192C82AA04E89004251A1C7A80@AM0PR05MB5331.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5Ab73ZpnT+cYVFrA54Iz_/Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5Ab73ZpnT+cYVFrA54Iz_/Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guy,

On Wed, 5 Dec 2018 12:25:57 +0000 "Guy Levi(SW)" <guyle@mellanox.com> wrote:
>
> >=20
> > Huh. So apparently every compiler that tested this patch (0-day, mine,
> > the submitters) optimized this call away because is_atomic_response()
> > always returns 0: meaning mlx5_get_atomic_laddr is never callable and
> > can be deleted entirely, including the call to mlx5_get_send_wqe.
> >=20
> > Not sure what compiler setup will hit this, but it is clearly wrong
> > code.. =20
>=20
> Flag -o0  ?

No, but the kbuild tree contains a change that allows turning off of
gcc's autoinlining and the CONFIG option guarding that gets turned on
for allmodconfig builds among others.

Masahiro, should CONFIG_NO_AUTO_INLINE maybe need to be off unless
explicitly enabled (like CONFIG_DEBUG_INFO and others)?

--=20
Cheers,
Stephen Rothwell

--Sig_/5Ab73ZpnT+cYVFrA54Iz_/Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwIWAcACgkQAVBC80lX
0Gxe3Qf9HENVqAcv4gfugjd3DGVnBI8YGNjVCcY4Sr2FmgDhz6I5kEyhafsBDjIf
Na4JTAJtcpI61N4HPUnO27DRiMJRqy1NJb2PRzGw6LRzDv5qWusd8IJe/JLrUr7i
XcK55bPzwiVSfIWJqeJQ45RKOFs4P7XOaJbiShdH1ojUmCAqDSrMsqgCCM3zrFz2
SDCzoAPsY7jtTvZ+VCr1AOCHc6Cq42Yt56h5m/3dXAxClgV1fLtIVudNdumjBrD0
baW655RGtacqRiqxF03QVHhnRP8FUyzZ1qEiirJAM8GSSO1Wf/RwkGYFENEx2r6y
vV/oa2/jIF/Qf3kHsCNyGHp4mV7xRg==
=p1vQ
-----END PGP SIGNATURE-----

--Sig_/5Ab73ZpnT+cYVFrA54Iz_/Q--
