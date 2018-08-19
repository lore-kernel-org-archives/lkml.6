Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DAC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A47320C0B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AhCFqJsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A47320C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHTByD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 21:54:03 -0400
Received: from ozlabs.org ([203.11.71.1]:59213 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeHTByD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 21:54:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41tsNS0dghz9s4s;
        Mon, 20 Aug 2018 08:40:56 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534718456;
        bh=vBKWPGLm3l+GfUHVwbSV7GJNBSWFxcx7Yp/SV34q+tY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AhCFqJsWtTdpcyXAJLKmlTdf2w5zNN/WpBxCqo2RyuHURjQw93JlRoDJPYbH4BfPR
         2i7YFQ1XUkSZQyuEJCTgkYR5z4WzqKaFmRSQTQdnROSyAPFb4WdxNh/11aLbVVc2cX
         5yICL4JvvZS/lLteH8koDm60OOSCuL29xqqBFtX2GV1j31pyTmL9tP+xPUfERTWkBv
         IjkRv665jj2EvkrM6FyrRJmEHh6k8DEe+KBgD7pe55+sPTqBfZQWb2sokRGP08L2je
         IzKwEmVdwC0Jq86RpYtpoGVvp4he57Ugy3KJjTN3h60rUT/cK8MA309BPxgJsS7Q1h
         OUhUKwId1bNiQ==
Date:   Mon, 20 Aug 2018 08:40:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from Linus' tree
Message-ID: <20180820084055.1bdb876f@canb.auug.org.au>
In-Reply-To: <20180820081618.1338cd47@canb.auug.org.au>
References: <20180820081323.23a47af3@canb.auug.org.au>
        <20180820081618.1338cd47@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ftry/BxirO/GiNb9rQD5g.V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ftry/BxirO/GiNb9rQD5g.V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Aug 2018 08:16:18 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 20 Aug 2018 08:13:23 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next build (powerpc ppc64_defconfig) produced these
> > warnings:
> >  =20
> ...
> >=20
> > Presumably caused by my update to gcc 8.2.0. =20
>=20
> And this from the x86_64 allmodconfig build:
>=20
> scripts/unifdef.c: In function 'Mpass':
> scripts/unifdef.c:453:28: warning: 'strncpy' output truncated before term=
inating nul copying 4 bytes from a string of the same length [-Wstringop-tr=
uncation]
>  static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
>                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Note that I only upgraded my (host) powerpc compiler.

--=20
Cheers,
Stephen Rothwell

--Sig_/ftry/BxirO/GiNb9rQD5g.V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt58fcACgkQAVBC80lX
0GxDIwf/UyKYDkaRq2olbQxw2Jqpvqu6EjrNTJ+8MZwUQs0hjyVGCkRK7fhZcezf
otvFdJrGl+T5NPsp0BNGF1OTpzxLhW7XZRPGTOWnCdScUr6aSLOq1pLXO5XSv0Zz
5zwa02KdCzotypwFDye2sKTehoaCZmT7WczsNhDsYUfPelTVXqn04wn1EnYfLuve
0h7fVHFAAtZOczLyFLcTrecnv6hpeUzwLcK9Y+I+XcdOIaa/bLSy6ZPrkXmgIw+B
6/hJnukU7vxKachAb4YKCSZcMIPVlhpY/AdvH/eK/k5hedm+b2JNVhK2CoB0ANEe
riWf134YuC6xi2c3E0YWO/i1F8GEMg==
=rfm2
-----END PGP SIGNATURE-----

--Sig_/ftry/BxirO/GiNb9rQD5g.V--
