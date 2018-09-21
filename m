Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8684C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B6E21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EWCHfXP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B6E21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbeIUOpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:45:39 -0400
Received: from ozlabs.org ([203.11.71.1]:47417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389444AbeIUOpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:45:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GnYP25mbz9sC7;
        Fri, 21 Sep 2018 18:57:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537520265;
        bh=eNBTlvx1QZI1iEH0KJRTFDKC47vxA2sS2i/7cAdnMyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EWCHfXP94boz78HViG5Y6QA+BJNg+O3aGodHysBxmNxfugI/WNHuP8tfNIB2Il4ze
         bKExIAKuZXG6CkeMGYUcxgi/tMppMAyvIN1Y0mT8GnbY4CF5Y5wQlnOtchf2GTtkrD
         i4O2tk9+nnyzje7gBj2ITV3Hllt0mywQtHuiMz/msKtVux8QNeI1dJy3iYh/GCSwiO
         CMW6dv3OOjeB7M1OWWVlxihtTLGGaAv31KndFcV5TUxmRwSTu/WQsxhW08GrBeiJtU
         7D5m8scyhSevuC0W6MmfCEfC0mgC+3nqa2brmXl/wpjwq2gOoSraH4nK3GqZ8GKJeg
         LRHVF8hFg5RrQ==
Date:   Fri, 21 Sep 2018 18:57:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 8/9] signal/powerpc: Simplify _exception_pkey by
 using force_sig_pkuerr
Message-ID: <20180921185744.51105b5b@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-8-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Gp=gBr.0=l/9DCnD9GI=IhE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gp=gBr.0=l/9DCnD9GI=IhE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:49 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> Call force_sig_pkuerr directly instead of rolling it by hand
> in _exception_pkey.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

You can ignore the question in the previous email :-)

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/Gp=gBr.0=l/9DCnD9GI=IhE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluksogACgkQAVBC80lX
0Gy4mQf+OPyQPqnPYWv5mYEDXVfxZFJ5tFOjH/wU9rR4UcLXjdvcoM6fd9htStNm
S0BrF3IKqznDiTJDPm1AjvTitmaWWDcqQCQ5Y1P+wyVoGu2anESHU2auUVlIm7oU
6u/ztIKtPs19NZenAvXmJ5xQywFZgidXib8n490pofHUpk9Z4nZstvRJ1XjPL+r4
J0Ys5/jbBqEdpZXMnKU+GParLzErpH4rFbtQdHHrsPyQRVNTDkkIrAkef8PBmG1U
Xupe75sArPFbzh+Bx/CbkBMv+FCYIPxMtZN/RCT5p91rUCykwkAGoN11hyA4kJTB
rte0fsqNUdFW0Fhu+OuG6yB4+ZJ+VQ==
=rcVF
-----END PGP SIGNATURE-----

--Sig_/Gp=gBr.0=l/9DCnD9GI=IhE--
