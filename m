Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ECEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D331520859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S/ytjhhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfAGKat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:30:49 -0500
Received: from ozlabs.org ([203.11.71.1]:46477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfAGKat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:30:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43YBVs12Q5z9rxp;
        Mon,  7 Jan 2019 21:30:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546857047;
        bh=ANmjcN1j87S2IZkYnumRUwbRyY5ghqw4j3/oJ0NNCxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S/ytjhhrSTgIXm7LojAxZliT7gc6/lYwQj9EZNy0Axs/xIhrA378cBQ11Pk2bZGLJ
         RVy2aHUae2Q++SWm/xejlV2ZEqo/490zn71P+YLG/MmPgOp11fgbXnCZ+iLN+oRlCo
         AJiGbkYL1Mtp4lyE8KMDl42XXFPUGebBC+qw/CiZ+rsGfCcJIl1eKY1t9goW7ExPyG
         wKIQFNPrrWgVNl2ghSyEGIf8GUkKJK/DTDeAmp3C9uof+gcfJeynzy6ar3c2BLfcMu
         Ju4d31TElwHYfHCOILVfUAfbQKHLVJRK/+glVM+M+KcXNhFgmD99jsmvfqfXzTiiug
         0nrTt+OY/B78w==
Date:   Mon, 7 Jan 2019 21:30:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guo Ren <ren_guo@c-sky.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the csky tree with Linus' tree
Message-ID: <20190107213012.5c20154a@canb.auug.org.au>
In-Reply-To: <20190107065344.GA11989@lst.de>
References: <20190107102727.0c67e3d7@canb.auug.org.au>
        <20190107065344.GA11989@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VZMUNJFKtfIf3MqQHBArbg0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VZMUNJFKtfIf3MqQHBArbg0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Mon, 7 Jan 2019 07:53:44 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jan 07, 2019 at 10:27:27AM +1100, Stephen Rothwell wrote:
> > You want to add "select ARCH_NO_SG_CHAIN" to your Kconfig somewhere
> > (see the commit from Linus' tree above). =20
>=20
> No, csky should not select it.  There is no code directly poking
> into scatterlists internals in csky, so it can safely enable chained
> sglists.

Thanks, good to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/VZMUNJFKtfIf3MqQHBArbg0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwzKjQACgkQAVBC80lX
0GzLFQf/VfwgGcXlHVXFXnPjXNf6YrY9PhU0wEirAgPN6IIXPRKRGGM9BzjgNagX
3YHtzcn6jvDQvbNJmp+VLXeFOFPTB5HW99CI2dL+N+0MQ6FJ1hw78owjr2yZHmsI
4mL4Fja5EC/wxQ4DZbwcT9kiyJGcjnw0nloq0c6iaAdqus8zihRwPrGx5DeFLJIP
5+EaC82H0VTn0FzTXB3ZLfFH/9uAapUezt9tRXQX7K38EASC/55go5w4gDprV77Q
NjU8fDZX1fXGM0hhx1Mt8JN1p+D5JrTk/1TrW5JNwnvcvfRXiUffRNW5hzG++ljC
kRx3XcKKXbgfkwbLDimM5q9T1zABUg==
=OvRC
-----END PGP SIGNATURE-----

--Sig_/VZMUNJFKtfIf3MqQHBArbg0--
