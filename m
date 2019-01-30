Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2344DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C600B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Iyne4iso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfA3ASv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:18:51 -0500
Received: from ozlabs.org ([203.11.71.1]:52071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfA3ASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:18:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43q3r71JcNz9sBn;
        Wed, 30 Jan 2019 11:18:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548807527;
        bh=YSvnUeRjBQGH+9eWKfgECOS+R/n/283iId+jL1vmRFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iyne4isolPvQETc2U8aA/mBOguz69McPzQvkbk82uavYFDTrlduLqWnnI+Du8Q7LB
         hr4oAZpmkjwcqKaet6On6YOtZuy1LlIVfkyBm0p72f5uEeBdAFta7hjcolZ4oP2I10
         Zjs5FRQsAJF5Rqd+uvL5lNXG+E/GCXtBo6RauKlaMWHc3FNGHz3ueC1r0c06HA7J80
         IS4cTF0ZzeaviIzfgmW+rUGAf4r5C5+xpwYS6Hu3P5gER/JJOpGPz9MZUmFQLyEwQy
         24OdSoY950RQeCfHADK57D4mSVgK2bxRTtqXAguqUt4Q5BvdUseY1aOE24nlbQ2QQq
         vmttxKAtawEOQ==
Date:   Wed, 30 Jan 2019 11:18:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/process: hardcoded core.abbrev considered
 harmful!
Message-ID: <20190130111846.0a6b8e2c@canb.auug.org.au>
In-Reply-To: <20181220000112.24891-1-avarab@gmail.com>
References: <1396949135-27122-1-git-send-email-jeffrey.t.kirsher@intel.com>
        <20181220000112.24891-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dJChQe94zNa2C9bkubqiTY_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dJChQe94zNa2C9bkubqiTY_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 20 Dec 2018 01:01:12 +0100 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
>
> Stop recommending that core.abbrev=3D12 be hardcoded when referring to
> kernel commits, and instead rely on the git's default abbreviation.
>=20
> Hardcoding this at "12" was done in
> 8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes:
> tag", 2014-06-06), back then Linus's git/git@e6c587c733 ("abbrev: auto
> size the default abbreviation", 2016-09-30) had not yet landed, and
> the default abbreviation was "7".
>=20
> At the time linux.git had around 3.5 million objects, so if the auto
> sizing had been in effect "11" would have been picked. Now "12" is
> what we pick by default anyway.
>=20
> More importantly, we'll roll over to "13" at around 16 million
> objects, which given the growth rate isn't that far off. At that point
> this documentation will be worse than the default.
>=20
> Let's just stop doing this. Git versions as of 2.11 released over 2
> years ago use the auto-sizing, and it seems like a fair assumption
> that kernel developers use a fairly recent git version.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

Since I have been checking Fixes: tags, it has become obvious that some
kernel developers have core.abbrev set to 7, 9 or 10 (or maybe they are
running very old versions of git).  Hopefully this will encourage them
to remove that setting (and upgrade).

Can someone (Jon?) please apply this patch?
--=20
Cheers,
Stephen Rothwell

--Sig_/dJChQe94zNa2C9bkubqiTY_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxQ7WYACgkQAVBC80lX
0Gz2EAgAnycT6wdRhJ5VkqzmzKI5gRqrTx+1y2qHLnQrfBylQiI0NW1+uBlV1weM
MncyaDfJwIukx4+0d7EpZtqWn/l6XjdTXGudBmnU+jRNA4Vil/M9rzYQ5PXb7Ym6
v9J8r1kQMzr1O4vpBH+srnoOBVf4xPBwnL7ZbpUQrpBbPbQwo97h1ku5KrovcWgF
phS97o4+8e5tACUfZ0Dh2W1S6WQ4BWxUCWLFFc00HXloB4ct/Q4jzG3D2/ASGg+b
qKwCN5ivXu3s5LF2sGlbjVq/E32KN9e24rS+OXxHDkCKWIULR4y/RQFK3TVaVCrs
r+WOOy0n3UoZ6a5HKf4hUTVaxuRUWw==
=Yv9u
-----END PGP SIGNATURE-----

--Sig_/dJChQe94zNa2C9bkubqiTY_--
