Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB938C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9E1217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TFLPgO65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfBQNwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:52:14 -0500
Received: from ozlabs.org ([203.11.71.1]:54937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfBQNwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:52:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442T2L27gLz9sDX;
        Mon, 18 Feb 2019 00:52:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550411531;
        bh=DwVrTGI0dHMfDB1KRy3KNnN1NPcweqAxrzDJM3KqUbg=;
        h=Date:From:To:Cc:Subject:From;
        b=TFLPgO653DwMNdveT5nakxVx9aD9WQCdQ5ZMhtDWhSHhrlJgaeEQwO6k5FFTIGWrJ
         cYIhdrdFbDmfykEiGtD58brqGDZ3IsuWthumbMaoeuNkkHyW/zGH7Pfd5kl7c61PLn
         5UFpZ8Kk02jK19FFHlAHvIUp/Dp16aH+C0M5Rmbq5ml2ZxvQF+HD6KLNEOE9LBJ9zo
         BQxWFbMhVqLY3t9BaKbArvQQ8s7xuUKI3PyZy2QdaiId/HLV6ewcEmcsaZbU+/0Axk
         +gUYo9V/CpAkI55wzlADNTdk5RAJE7UE2VYzai5pdNWimq7fT1QJDEsb5ZI12aP+nV
         KAjq8exc45j/w==
Date:   Mon, 18 Feb 2019 00:52:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hauke Mehrtens <hauke.mehrtens@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: linux-next: Fixes tags need some work in the net tree
Message-ID: <20190218005203.5ac3473e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VA06HLo6cQnKKBHv6kwGPJ2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VA06HLo6cQnKKBHv6kwGPJ2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a40061ea2e39 ("net: systemport: Fix reception of BPDUs")

Fixes tag

  Fixes: 4e8aedfe78c7 ("net: systemport: Turn on offloads by default")

has these problem(s):

  - Target SHA1 does not exist
    Did you mean

  Fixes: b5061778f822 ("net: systemport: Turn on offloads by default")?

In commit

  3b89ea9c5902 ("net: Fix for_each_netdev_feature on Big endian")

Fixes tag

  Fixes: fd867d51f ("net/core: generic support for disabling netdev feature=
s down stack")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/VA06HLo6cQnKKBHv6kwGPJ2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxpZwMACgkQAVBC80lX
0GxBsgf9EBROBBV550yn6EKnHtKW6p8tbXNFQU5KQJ+kyQ95gXzcRGnmKkb7n9MV
6T3IxbISKBxrJqdxXf9lKJf07JidLT+hI2eb5aCeEqwxZ1P2ZfcGcLBDHatZqrpq
ewgksDmeJRhkdsIwE8DnSz2YP03MaDIbcUCpNAgVUmMIscB3czbqKdtgj/kouRYc
GZJj2UlK7ESN05SR5Rp3zvx8qBmdqAOY32lfHyJS4uIWhr9m3TbPQg1sLXYE3kFS
nLFwsqeSYAD5tiXaBbI/sSkGJ2yrUPFbRzlCurqou60iGknasv9Dj3XIxPMIWHwX
XNv3O9czCbTQxumnSPF/us2dvGpjdw==
=saU4
-----END PGP SIGNATURE-----

--Sig_/VA06HLo6cQnKKBHv6kwGPJ2--
