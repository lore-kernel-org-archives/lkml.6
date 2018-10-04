Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A10CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EBB2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CH8gr28S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EBB2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJDKc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:32:57 -0400
Received: from ozlabs.org ([203.11.71.1]:55705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeJDKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:32:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Qdwj6lstz9s55;
        Thu,  4 Oct 2018 13:41:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538624502;
        bh=4qRredfQoy8QLbBcBBCrm9urN4fYHvEBmF/XVrFzq5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CH8gr28SLpqwQDp4VcuNfOeriAhRbzGyPmflEo0ga3gCixhxk2VwAa0zEYFqsNyjZ
         Ir9OGd+T3VaxtuGlLhUwxpavr3odVEASHsaCqopOJbW5mLJ7OTbwRNR2Eopn8JAtPC
         SWztml8DfABuTlYjMJSY4RxQ8jba6mg5BxGhuXPlbPxDKmIcdsZjgqC8RZzb42iOsF
         CD32aBISS1WyCFXqqW112/0OzCVtrJ/WHy4ByzxsULG2mNdKa2P4zFOPX29j7rTrIM
         2BM8/3QN1fTAPzjK1xkpzAj1YMZ1vaJkfm9C3j1qBEsq9p6JH8O9A7/gEwawbs8oEA
         ngC2qkTKWIP/Q==
Date:   Thu, 4 Oct 2018 13:41:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: occassional build errors
Message-ID: <20181004134141.1840d8ea@canb.auug.org.au>
In-Reply-To: <CAK7LNAQsvtyU_2Lm4gPSU=q9KeAwjPCfQiwUeOjw=JjUpks_Pw@mail.gmail.com>
References: <20181003135038.24438d97@canb.auug.org.au>
        <CAK7LNARD6qxX1fz4XF7yj2vWZurayhtksQnGfHBEUtCTNLmGYw@mail.gmail.com>
        <20181003165534.4bc87bbe@canb.auug.org.au>
        <20181004103937.5601c02a@canb.auug.org.au>
        <20181004115653.6a97e131@canb.auug.org.au>
        <CAK7LNAQsvtyU_2Lm4gPSU=q9KeAwjPCfQiwUeOjw=JjUpks_Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xbCOWcAoriy8X5JP_b__m7K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xbCOWcAoriy8X5JP_b__m7K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Thu, 4 Oct 2018 12:09:54 +0900 Masahiro Yamada <yamada.masahiro@socionex=
t.com> wrote:
>
> OK, confirmed.
>=20
>=20
> This is a regression of
>=20
> commit bb5de5d28f730eeec0aa1ced51a6f11327cd1201
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Thu Sep 13 17:20:41 2018 +0900
>=20
>     kbuild: remove unneeded link_multi_deps
>=20
>=20
>=20
> I will fix like follows for tomorrow's linux-next.  Thanks!

I am glad that there was a good reason :-)

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/xbCOWcAoriy8X5JP_b__m7K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu1i/UACgkQAVBC80lX
0Gy8yAf/fzfpewbLuZLZ5hY3AVnwEEdWvsSj4rothZ5xcCwjNu8QDkPrAvqCaMv3
NYXbu3QHlKgWMPbGqWweinA6TmyM4IPd/rWVg5sFk79QibPx3UgQRxgIbx02YHI5
cJ0riKrAbG8o0X/yWzIxvf4DeTC8dkgYlC0YJb4lTPO52YYjsOuhBYNlo7Y/PXp5
QTQAhfxSiE+c1RlJ135gFX41EAqycsNJhXSiR8c/n04hGvkoRRMYsmTONPEmtSuD
9Ja8XnPJhD0uroxKnU7UuM/fH2YccTndS98gPHhycHITgHUK58yN6KR8daiyEmyO
iP3hnV5/tGqAlRoWC67NxWTU/d90/w==
=v26Y
-----END PGP SIGNATURE-----

--Sig_/xbCOWcAoriy8X5JP_b__m7K--
