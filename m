Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA70C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023520856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RK/aL2d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D023520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeJDHa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:30:26 -0400
Received: from ozlabs.org ([203.11.71.1]:58577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeJDHa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:30:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42QYtg1ZpRz9s55;
        Thu,  4 Oct 2018 10:39:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538613579;
        bh=eeLJAAAb7tepMxmAbSspo14nXCGVPTl8hi/G0WkYsiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RK/aL2d6wb2MSbTRpvTM0zcEybx4bmeM5y+O46zvUsjWNZewGazKBYtkcrG83i36L
         EoV+A+ccjRvw5L1zZwyrEQq8DxanFxfLyTMcip7b7PUvYRxLQ78C1T/LQkPtS9q7j5
         s/OOZ5c8bw7z99zA8jq+/yjInsX2U/qM4DRGVgp6FO7aia/dBTqFwSapClnCXgDu9N
         BF3/HQfmakigPPU7ptYMzP/k1IptYYUJ+nt1oo2SwYcwILLWzPexIGROxntur3U8pn
         VTqEGB3fjWafoHulpDds+YmetkpkeXBkM/UkOnHfgYcNSlUMVsiwnaOeXCu/vODI0O
         ulzyt13ActtWA==
Date:   Thu, 4 Oct 2018 10:39:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: occassional build errors
Message-ID: <20181004103937.5601c02a@canb.auug.org.au>
In-Reply-To: <20181003165534.4bc87bbe@canb.auug.org.au>
References: <20181003135038.24438d97@canb.auug.org.au>
        <CAK7LNARD6qxX1fz4XF7yj2vWZurayhtksQnGfHBEUtCTNLmGYw@mail.gmail.com>
        <20181003165534.4bc87bbe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/osMduPzi7M=VrluA4pQBPoJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/osMduPzi7M=VrluA4pQBPoJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Wed, 3 Oct 2018 16:55:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> > >  The latest example is this:
> > >
> > > include/linux/kconfig.h: file not recognized: file format not recogni=
zed
> > > make[2]: *** [scripts/Makefile.build:492: crypto/crypto_user.o] Error=
 1
> > > make[1]: *** [Makefile:1057: crypto] Error 2
> > > make: *** [Makefile:152: sub-make] Error 2
> > > Command exited with non-zero status 2
> > >
> > > It is always complaining about a .h file ...
> > >
> > > Makefile:152 is the MAKE lien below:
> > >
> > > # Invoke a second make in the output directory, passing relevant vari=
ables
> > > sub-make:
> > >         $(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=3D$(CURDIR) \
> > >         -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOA=
LS))
> > >
> > > Makefile:1057 is the MAKE line below:
> > >
> > > PHONY +=3D $(vmlinux-dirs)
> > > $(vmlinux-dirs): prepare scripts
> > >         $(Q)$(MAKE) $(build)=3D$@ need-builtin=3D1
> > >
> > > scripts/Makefile.build:492 is the if_changed line below:
> > >
> > > $(multi-used-m): FORCE
> > >         $(call if_changed,link_multi-m)
> > >         @{ echo $(@:.o=3D.ko); echo $(filter-out FORCE,$^); \
> > >            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=3D.mod)
> > > $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
> > >
> > > Not sure what else I can tell you. =20
> >=20
> > Does this happen only when building a module? =20
>=20
> I don't know, sorry, I build with -s and -j80, so it is hard to tell
> what it is currently up to.

Today, I got this from the x86_64 allmodconfig build after merging the hid =
tree:

x86_64-linux-gnu-ld: include/config/acpi.h: file not recognized: file trunc=
ated
make[4]: *** [/home/sfr/next/next/scripts/Makefile.build:492: drivers/hid/i=
2c-hid/i2c-hid.o] Error 1
make[3]: *** [/home/sfr/next/next/scripts/Makefile.build:520: drivers/hid/i=
2c-hid] Error 2
make[2]: *** [/home/sfr/next/next/scripts/Makefile.build:520: drivers/hid] =
Error 2
make[1]: *** [/home/sfr/next/next/Makefile:1057: drivers] Error 2
make: *** [Makefile:152: sub-make] Error 2

--=20
Cheers,
Stephen Rothwell

--Sig_/osMduPzi7M=VrluA4pQBPoJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu1YUkACgkQAVBC80lX
0GzJnQf/c+E25vr62535EJOHRGKQzYJXrQ7cPo64xLdpitBOwgM0ABbzUlNcGgje
hxj1+lQ2UuBowdvJQLh9r1wGujPNiTpD7SNqeMljzUzdHPicUC8fQGIjHnPw8RsS
yHNIakNBxSQy7aXzBMNBfTk2dWK34PjAK3AyjpAspZtY4A1OSfM+rBG+uadXZ6y8
tNl7PGfxJ65m5J6GcjWSDZARe95tsT0UDYQghHIktcdEmLXazyl+IwLs0vEInb05
Px4NvUkn8WVfrWDIpYTOismbzR9TCNgtZUjfaDfdwXhvFHbVy5NbDCPGE5AgKTO/
hLTnQPnKyi9l38Sss4MegZSHeI1iBw==
=5Kil
-----END PGP SIGNATURE-----

--Sig_/osMduPzi7M=VrluA4pQBPoJ--
