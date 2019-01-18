Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB90C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952A22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M5qk2ajm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfARDTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:19:16 -0500
Received: from ozlabs.org ([203.11.71.1]:52483 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfARDTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:19:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gmPs2vy0z9sCh;
        Fri, 18 Jan 2019 14:19:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547781553;
        bh=KJ9pq35X/bdaof89tBtGUjxhVz4J/mSyqdMP1vJdJgE=;
        h=Date:From:To:Cc:Subject:From;
        b=M5qk2ajmBpkNrnpVCyJz0i2BzCiPrt2U5WiFGlvtWwNiF4fDX6cd0MJN/Dfco+0PY
         Sv6zaNbb0YMi0EhDn7ivvuNsqvBt2vBcERz/HAfEfnBV/XG+Ku7n4cVIZH+YibG8Ub
         ZMvhHDLrQdOoiu2GPUsYmHKVL7QllutzBxltgSTLcDlbkQui88Ms3Xja/m7D02Wzeo
         T4CqIneC0dpOLNOx4yBakpW1j7eB2izi7jAWkxDQzNsi+VIiNowwPh8MJLvAJlwkrU
         hQBi8MVUloxCZ18Vl7FP6h+njJDcTcBXPzFS3/0J+zIffDae78zELDiOFs04eL4kik
         4Rn6jFxTHdV1g==
Date:   Fri, 18 Jan 2019 14:19:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: linux-next: build failure after merge of the imx-drm tree
Message-ID: <20190118141912.69d2a6e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kgLjQTJpQJ8ImKpYAaGd6aF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kgLjQTJpQJ8ImKpYAaGd6aF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

After merging the imx-drm tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpu/drm/imx/imx-tve.c: At top level:
drivers/gpu/drm/imx/imx-tve.c:437:29: error: storage size of 'clk_tve_di_op=
s' isn't known
 static const struct clk_ops clk_tve_di_ops =3D {
                             ^~~~~~~~~~~~~~

Exposed by commit

  97144d12df00 ("drm/imx: Allow building under COMPILE_TEST")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kgLjQTJpQJ8ImKpYAaGd6aF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxBRbAACgkQAVBC80lX
0Gzt4Qf+MDCFQoARVpv1DSUrUl2bgftqfbHkPUQfsItRIOllKlKDkw1llEkA04A/
t9awX3P8kI+ZIOrU3FuQLC6OGuQ7eGqXaTQcJcavpkQxVAHvtxbp0HjBzkunXeoi
Tdu461Xk6yWkwFXu72BOV3lZFjosvIvINLo2J+p/aPKBW+M8o4si4NRerLChZ2kD
I9t9LOwU62lqSslLDiBDEdyhIF9F41md/2Bad6aOdVK5tu11zLzx26bSa5Anhc1L
AN0eTcT/5oXJQVAjnE8vHCP7vCmtmEvmBipcymJK8Te/OcgOI/suMZYNAuUqfkUm
BiJL0be14cYgTxv6jivKBbvHyB1XHA==
=5wGe
-----END PGP SIGNATURE-----

--Sig_/kgLjQTJpQJ8ImKpYAaGd6aF--
