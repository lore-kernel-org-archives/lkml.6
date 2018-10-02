Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B62C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF16D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OX0dpSa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF16D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJBNHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:07:30 -0400
Received: from ozlabs.org ([203.11.71.1]:39087 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeJBNH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:07:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PTg36RCyz9sCD;
        Tue,  2 Oct 2018 16:25:51 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538461551;
        bh=duXmp+4wyr/LVaIkTUJ9q7axtDsFTaKMv/gWxwQs8DQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OX0dpSa6EWiKs2YwBDxjuiHfggb//NBxtgEfqrpRQgeFA/peq9PU+ThDNSB+e4fmU
         6sC7z8gmcyHxxx6kmAc6p9w4FpJDClibktw2mn3Mnlgs8fr8JLuru6SoSbMNLUnWNy
         ONR1EkO2zyLQoTymWAAcNWyO7SjMvBvTJ4raF/K84iJsWV5cKpFOOj5xYbOC/Lkpux
         SWxDF3TAfrs8EkfH6IDK+XLhTXspruhm/X2UHgTzy2BCh4wcMhkFyTuFRODNzcKfEG
         p4kFpPwKL+Y0Pzrg3RIhAeqUO8eqL0mg8K7J+1NLO1+DcKq15LBXR3wJA/Q1jG7N/f
         wUvgRNdoycJhA==
Date:   Tue, 2 Oct 2018 16:25:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the regulator tree
Message-ID: <20181002162551.29b8c977@canb.auug.org.au>
In-Reply-To: <20181002061644.GC9389@localhost.localdomain>
References: <20181002130748.61e33ad1@canb.auug.org.au>
        <20181002061644.GC9389@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OKcjSmwS72v=RSZLJnSlLC6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OKcjSmwS72v=RSZLJnSlLC6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On Tue, 2 Oct 2018 09:16:44 +0300 Matti Vaittinen <matti.vaittinen@fi.rohme=
urope.com> wrote:
>
> On Tue, Oct 02, 2018 at 01:07:48PM +1000, Stephen Rothwell wrote:
> > After merging the regulator tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> >=20
> > drivers/mfd/rohm-bd718x7.c: In function 'bd718xx_i2c_probe':
> > drivers/mfd/rohm-bd718x7.c:101:23: warning: cast from pointer to intege=
r of different size [-Wpointer-to-int-cast]
> >   bd718xx->chip_type =3D (unsigned int) =20
>=20
> I am pretty sure the last patch version corrected this to
> +       bd71837->chip_type =3D (unsigned int)(uintptr_t)
> +                               of_device_get_match_data(&i2c->dev);
>=20
> is it possible one of the earlier versions has accidentally been
> applied? Should I create patch on top of the last regulator tree or what
> is the simplest way fix this?

Sorry, this came from commit

  dd2be639f4a9 ("regulator/mfd: bd718xx: rename bd71837/bd71847 common inst=
ances")

which is later than the commit I noted.  In this later commit, this happens:

-	bd71837->chip_irq =3D i2c->irq;
-	bd71837->chip_type =3D (unsigned int)(uintptr_t)
+	bd718xx->chip_irq =3D i2c->irq;
+	bd718xx->chip_type =3D (unsigned int)
 				of_device_get_match_data(&i2c->dev);

--=20
Cheers,
Stephen Rothwell

--Sig_/OKcjSmwS72v=RSZLJnSlLC6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzD28ACgkQAVBC80lX
0GyhAgf+K1pac+QoUVty7V2wpdLYm7VaF4WzxKE9iea6baz2mOCQFfclTPCCTw9N
RUXNHjxqlG+Z8mBXDzhbr949EB2CM4YPyUR5g24Jr/aG65VEoV5vJ+RWIn8PE9be
Q6LjJE0GJu3QVq5c1QYxz2SKKreidLiaC8kYHCxmgr/z42N3qyXREfPGxWX/rOT8
R58Y5JDLx+NgHagahOqQKDpmNwZKFqTueDlZ90afN9gs6cpiGVJo6rQIx7LAEpVk
Yopa15LsjjLFTt8JAkpdF1Ep+G8OCB/qBEsvDgbI5QGNWGKSSrsK6Jd9upD+Da3h
H/KaeOfSmM1FOGuPAywA44yzTyEqig==
=pqAU
-----END PGP SIGNATURE-----

--Sig_/OKcjSmwS72v=RSZLJnSlLC6--
