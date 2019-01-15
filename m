Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76A4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64817205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pMaiJjSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfAOVG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:06:26 -0500
Received: from ozlabs.org ([203.11.71.1]:42135 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732826AbfAOVGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:06:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fNDY2Q3fz9s9G;
        Wed, 16 Jan 2019 08:06:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547586382;
        bh=7X6bpVmYy0XZwk1EkDvweYXFdQZQhxulKUObaJugykg=;
        h=Date:From:To:Cc:Subject:From;
        b=pMaiJjSfUT6hp1LlkwC0GvGdKgusfcg1VSK0ERmrpletX/GKOc7xAg0wpwZ37aiXg
         5EjqJU5JYLev3MO0eALp8O0eZQsrDzJi744DFEI6rTCIC3jfS2Iip5KivI25rhDaFE
         gcgOSzctnrvSr0huet8wa2R8RBwKHObDTEZupwwdvgKdUJaANsWlD3J7N2C3dZZWBF
         IOXQT1YQ+1o/HCjyFH+xapX+8pMBKNTYGlbGfISK2XBrC238s9i01GNnoqeaStvVbj
         DTD0r1dHH051UKWkkDnqjp9ijrCupJK22ZPEgZT8ht9eGsoKOOEupLBlk5J1SZatpz
         QhKunpdJ9X2pg==
Date:   Wed, 16 Jan 2019 08:06:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: linux-next: Fixes tag needs work in the xen-tip tree
Message-ID: <20190116080620.4c2c143f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4IYe9d_Dvvr_jnwqXDMiwhV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4IYe9d_Dvvr_jnwqXDMiwhV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  786e1048e7f4 ("pvcalls-front: fix potential null dereference")

has a malformed Fixes tag:

  Fixes: 9f51c05dc41a ("pvcalls-front: Avoid get_free_pages(GFP_KERNEL)
  under spinlock")

It should not be split over 2 lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/4IYe9d_Dvvr_jnwqXDMiwhV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+S0wACgkQAVBC80lX
0GxqOwf/UnZo2vpgBTaU3aSs7Iv6kCTE67ggBAJ/mNpcWALc7y/C0aOYcbzKxgYu
0999RqxHy6nxkVlJiAsYtR0ctAF2JH2y8pY5TJB5w9mGlmlMW2dkRN40BE6h6IbD
gqXUYz+5t/C2hNrrx9C7pGeAk3larJztaQvoNG6wa8US90h6nFNe7Pgzr9rJn17j
18vw44Ai6sGNdVTgccT3BNUb9PdYAeqQ/TdYPvEdXHmuLQ1AjSa7zgE4Mlvj0ue3
IDZml9hyCyjcLbyIuXrCXVUJp5V5ZNv7byDpvT8tE2JBHf1qW9Ea1NAV+RRNgBsB
f5x2snqafEUTcUlBKRGH18Qha1zzjg==
=J/wc
-----END PGP SIGNATURE-----

--Sig_/4IYe9d_Dvvr_jnwqXDMiwhV--
