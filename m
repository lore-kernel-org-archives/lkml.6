Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A8820651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hyB0DHT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfAOKrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:47:39 -0500
Received: from ozlabs.org ([203.11.71.1]:58681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfAOKri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:47:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43f6VY4Yqmz9sCr;
        Tue, 15 Jan 2019 21:47:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547549255;
        bh=p+StA/uw56YJOXL/PPCF7Ux+AVwB+rUf1PbtVu0DdpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hyB0DHT1YH2CkVgQm0XAdmYO967hcGBSTW6PFUAExorXEiYF5VLWanYp/aWqUt/XO
         3lx5N1a2VnzqjH/Bn+D9bzoledScXCShEMO0ItT+GXNlNbxe0L5t6o6bD4sEaAWoEv
         11U1NA4X7svulpDl5pobhzi2/E7clctiJSjvyepE5IFhe/E51HzPBe7Wkc+1+9/bJt
         1HtFazHpqk2a5S+hw8w9kwPZvZN/fmhglvSwL9dR4TEz8pJOqEWTnnYkWfbmUlBWt4
         kPtVQ5TvpVruNMclGjOeMECCjhSRB2gYLY20vUIsBXQsCbXBKMa03esNbv7WJDHaZy
         wB/nsQHNQhxFw==
Date:   Tue, 15 Jan 2019 21:47:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mali-dp tree
Message-ID: <20190115214725.360798cf@canb.auug.org.au>
In-Reply-To: <20190115101219.GP20661@e110455-lin.cambridge.arm.com>
References: <20190115104619.516be4b9@canb.auug.org.au>
        <20190115101219.GP20661@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T7_6cW1XqiCljKlGz2FxoNA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T7_6cW1XqiCljKlGz2FxoNA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

On Tue, 15 Jan 2019 10:12:19 +0000 Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> That looks like the right fix, thank you for that!

Thanks for your verification.

> I will roll your patch into my tree.

You can only do that when your tree is merged with the drm tree (and
it should be part of the merge resolution).

--=20
Cheers,
Stephen Rothwell

--Sig_/T7_6cW1XqiCljKlGz2FxoNA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw9uj0ACgkQAVBC80lX
0GyXXQgApL2KNh9KEe1FdPnWvHaZyEaW4r/Q6zvws49vD7KpY/I0I6tq8iOvZPnZ
O21GbwYda0Tf6EN/XqZs1AbdtClDCfMkKajd0YbF7OJj2HIhR0yigHlkYDlLZlaB
fO60kKP9E+1dVp9ZLfz6IOv0OiTKjYeTqYY5XRdZbtNbj/qqSbQyvnVfhzgoBRKR
V4xT2hGoQsAJciQKxDZ9O1dU0ZoRYIPl5l7O6829DC7Fn8QqXKJnI6deoMe853iz
T7XLBvCMkSS6JrKwIpRV3G6rliUvSssSd3Q0E6cabSVxO7AQIDNq8/s2V1rTGjCJ
/7os4Ldp0+gzptonHR19FO0tnel2QQ==
=wIrb
-----END PGP SIGNATURE-----

--Sig_/T7_6cW1XqiCljKlGz2FxoNA--
