Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEFCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5FE216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hBiIjvIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5FE216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeHULwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:52:30 -0400
Received: from ozlabs.org ([203.11.71.1]:60351 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeHULwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:52:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41vkTP4Cdjz9s4v;
        Tue, 21 Aug 2018 18:33:13 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534840395;
        bh=4Y9BGFASycOORMikIcdDfj2giAklplwoFsC4/TyE2jA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hBiIjvIyQHksBFunvhUvb08BZ+25g1LdP6SwulSVrsOz+EsVxtX3GuN7+VE3x1NKj
         ZFfStV0IPNmfef/M6uwjsTr19Vem+vSlwsgnrs8AkPszilCtUPGipR0onCijLt8GCZ
         nKUqJ/I+9AduGmcf+sxcVU/YYOpdzjkxKgEPx5PA8J7hBA9NpGBQCfQUKfB1RvhMkH
         kM7pvIsE0sapJGAUpJDGW85zQz32eoGzz/CZM1NTjw2eYYcHFmNqvJUJSyKByCQia4
         f/jOe1BqfwTpy/XD5+RhQ3rUcJ+U0ILtpdtAznzPojyisaq2deN7d/KqSCRdgnby8Z
         lHCDTYnl8jGTA==
Date:   Tue, 21 Aug 2018 18:33:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Nikula, Jani" <jani.nikula@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        paulo.r.zanoni@intel.com
Subject: Re: linux-next: manual merge of the mfd tree with the drm-intel
 tree
Message-ID: <20180821183312.690df265@canb.auug.org.au>
In-Reply-To: <CAMuHMdXtMer6z09GV4HM++0RjYSkLWaXO9-m==SE85RkQ2xP-g@mail.gmail.com>
References: <20180726151006.345e8397@canb.auug.org.au>
        <20180816121256.0435930e@canb.auug.org.au>
        <CAMuHMdXtMer6z09GV4HM++0RjYSkLWaXO9-m==SE85RkQ2xP-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mN/pLNHOeUnbSuu_2uXBwAG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mN/pLNHOeUnbSuu_2uXBwAG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, 21 Aug 2018 10:27:48 +0200 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>=20
> FTR, it's not this one, but the similar one reported on Jul 19, which doe=
s not
> add the tc_port_type enum.

Right, sorry about that.  Linus has now merged the mfd tree so things
are probably done now.

--=20
Cheers,
Stephen Rothwell

--Sig_/mN/pLNHOeUnbSuu_2uXBwAG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt7zkgACgkQAVBC80lX
0GwumggAmMYtZ3+bsBuQAv5rMt7IvUeVl7q1oyOShdcVYns81DVI+DPRGTqedocx
e3A8bkMNXOpD6Lj4aOCoxWSxBuLnxBw+bWZyUTmYvnpi6HqU+htsNWaikvTpU8TL
wSzdJ3X3n5AJKv/C+ndtLT/Ie0F9vIfELBuYzE1DKs0YvFAhqZsXahkJbN5di0NN
RUy52qBjTJj1UIjMs0gaCo+/WFI7Eb6cr/GOjufPi2x+9zgbl29jOsU96c4pbxyM
tA/UcsCWd2ns1dKT6BnRM4SpbvdUcEGnalE1HSc7KszpLyIgcNAO0KXsYwd3yQds
Ao6gDzSgovN3B+bky87Ah9ynfy+J+g==
=pvwd
-----END PGP SIGNATURE-----

--Sig_/mN/pLNHOeUnbSuu_2uXBwAG--
