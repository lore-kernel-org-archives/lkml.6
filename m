Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9ACC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60152083B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ENcVfUra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbfBMAtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:49:22 -0500
Received: from ozlabs.org ([203.11.71.1]:41967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbfBMAtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:49:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zgrt4ts3z9s4Z;
        Wed, 13 Feb 2019 11:49:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550018958;
        bh=FycbA00puR5F7mGE/ZGaSiBzlOiugtGVpcnJERWfkZs=;
        h=Date:From:To:Cc:Subject:From;
        b=ENcVfUra3vX1FOpslZ4+PHconxO7ZDEwhbEbaEN7361gu2VQb9XMIF2/3hFx9BQMC
         FGLcB/OtBXkLvrZeRUCpbNGG9zc57nSwivE5kjjHozeyG6oDijdZqfkklLiFJCu49e
         ZIf7tjMdp/3XU/zS2egPUmvUbKSEG7GveJoRbFSUy2R/xXv1lv5BDCULrwFQ9e+LJQ
         y0dn6+tI2eS8wTKU5HZNvFepxzM1iML5TuCR4yEps4Rd9glmmkfKQVtICaGZsIcRQr
         hbuwxiYY3YjAe0i/kmPegOZ4FTdtbY+jfXR+1vi4BsSnNIfDsg39LHsZs7NdBOrGRf
         WEIFUDJ8xIkug==
Date:   Wed, 13 Feb 2019 11:49:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20190213114916.1a83a363@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Qr1i51w24dKLDRzBusQo9Hm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qr1i51w24dKLDRzBusQo9Hm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c: In function 'mlxs=
w_sp_port_attr_get':
drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:438:19: warning: u=
nused variable 'mlxsw_sp' [-Wunused-variable]
  struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_port->mlxsw_sp;
                   ^~~~~~~~

Introduced by commit

  1ecb195753a1 ("mlxsw: spectrum_switchdev: Remove getting PORT_BRIDGE_FLAG=
S")

--=20
Cheers,
Stephen Rothwell

--Sig_/Qr1i51w24dKLDRzBusQo9Hm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjaYwACgkQAVBC80lX
0Gxtfgf/e+HeBhwdrpTIevYtSAfXAW6b1DWClvLiRulOZT05slhwUbtjq0dPLZSJ
bkP0XnJ/slZefnKEwmieI1muaTQrK33EJZOSxgsaGYXVgWJ2xXeevjrZaXSb5VOi
uF1U4ZpkC/IemDpl3WrbJ0DjcMbT/86h5/Kl/q9TYt0K6X054TJEMK6szYqlDQ44
jPGO05ZK23Ibudj/hN18+yVlCCaySg+x0V7aa5hnYR4tF3dyvXwjMnawjr8318cf
y19Gh/jG801PSoPPpgoeyWwRllFteRjmaLLW5RT/ecJE0aMUWDqNlr+lxs5Dj0ZA
pTTsPhvlN4Sabm5ET2RRZ3xFgVSWNA==
=WBVG
-----END PGP SIGNATURE-----

--Sig_/Qr1i51w24dKLDRzBusQo9Hm--
