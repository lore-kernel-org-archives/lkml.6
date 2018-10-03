Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3730C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87D820835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="amGWhcWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87D820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJCNmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:42:40 -0400
Received: from ozlabs.org ([203.11.71.1]:49559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbeJCNmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:42:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Q6Gv3dldz9sB7;
        Wed,  3 Oct 2018 16:55:35 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538549735;
        bh=5K3yjm8cHzTo5QuWPNbwNeSLk1RK3Az+0UJ7XefqV+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=amGWhcWdRpc/3YluQSHUqoP0PyOt0TXgFKzKF+sq85bd1yc+pmqJnZ4wCImQ8FhYk
         hU5T/Nu+OwY+brxyHr3cYZf3RmK1eXY604gLJGZ8ncLV3TCZpKCxiP8A9pNphX2dj8
         DUTiIJjDkkDYVxw7P/B71oFEqRwRXIwh0G47b372wmbtLdXaukBzOP17wucGiywito
         Z/U2xbSCbqn8icTKkaZ5WMZbx6z7mnb1/Ty52YlVKBICg8e2GV14DMWma2FEozUlZ3
         DkbAdjNqy4AhPwdudltx9CXsXkxVBT9D5zSCmlvUJLlNK1K/erv4BkF91RVU9ileRW
         /lpn2U5ZrPKCA==
Date:   Wed, 3 Oct 2018 16:55:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: occassional build errors
Message-ID: <20181003165534.4bc87bbe@canb.auug.org.au>
In-Reply-To: <CAK7LNARD6qxX1fz4XF7yj2vWZurayhtksQnGfHBEUtCTNLmGYw@mail.gmail.com>
References: <20181003135038.24438d97@canb.auug.org.au>
        <CAK7LNARD6qxX1fz4XF7yj2vWZurayhtksQnGfHBEUtCTNLmGYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iB_/tHg=Djdt6hecZeIcLQu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iB_/tHg=Djdt6hecZeIcLQu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Wed, 3 Oct 2018 13:31:54 +0900 Masahiro Yamada <yamada.masahiro@socionex=
t.com> wrote:
>
> On Wed, Oct 3, 2018 at 12:51 PM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > I don't know if that has anything to changes in the kbuild system, but
> > since Tuesday, I have been getting random build errors that go away aft=
er
> > I remove the object directory and build again. =20
>=20
> I have no idea.

I did not expect a fast/simple answer :-)

> Is it fine if you use kbuild tree from the last week?

I did not see this in next-20180928 or before i.e. it has only happened
yesterday and today.

> I added 4 kbuild patches this week, but they look irrelevant.

Yeah, that was my feeling as well.

> >  The latest example is this:
> >
> > include/linux/kconfig.h: file not recognized: file format not recognized
> > make[2]: *** [scripts/Makefile.build:492: crypto/crypto_user.o] Error 1
> > make[1]: *** [Makefile:1057: crypto] Error 2
> > make: *** [Makefile:152: sub-make] Error 2
> > Command exited with non-zero status 2
> >
> > It is always complaining about a .h file ...
> >
> > Makefile:152 is the MAKE lien below:
> >
> > # Invoke a second make in the output directory, passing relevant variab=
les
> > sub-make:
> >         $(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=3D$(CURDIR) \
> >         -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS=
))
> >
> > Makefile:1057 is the MAKE line below:
> >
> > PHONY +=3D $(vmlinux-dirs)
> > $(vmlinux-dirs): prepare scripts
> >         $(Q)$(MAKE) $(build)=3D$@ need-builtin=3D1
> >
> > scripts/Makefile.build:492 is the if_changed line below:
> >
> > $(multi-used-m): FORCE
> >         $(call if_changed,link_multi-m)
> >         @{ echo $(@:.o=3D.ko); echo $(filter-out FORCE,$^); \
> >            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=3D.mod)
> > $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
> >
> > Not sure what else I can tell you.
>=20
> Does this happen only when building a module?

I don't know, sorry, I build with -s and -j80, so it is hard to tell
what it is currently up to.

> Can you provide a procedure
> to reproduce this?

Not really.  Each day, I merge all the trees, but between each merge I
do 3 builds (arm, powerpc and x86_64) and of the 100+ builds, yesterday
2 failed and so far today 2 have failed.  It is not even the same build
each time, or after the same merges.

The report above was from the arm build, a while later (a few merges
later) the x86_64 build failed - complaining about a different .h file.
--=20
Cheers,
Stephen Rothwell

--Sig_/iB_/tHg=Djdt6hecZeIcLQu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu0Z+YACgkQAVBC80lX
0GywDgf/SP1yD04vAfQa1S+aE3U04Xx1UFGHJZGr/XtxgNGBpNAk+BLV1JqoMxIt
iXMVtJTXw6yT2yEtwSfM6KgxZPBuUZO4HX+eShfBMIbgBg//3SDx7Y64JLL1tQCi
CYmGSt651457J/L6NjgSOeIUMYQPBkUcnVIzPtLfaybY6YYczVHSEP2Bbsgf8E6N
LUg2kXTGWckqZxIwi7Ak3FegYcvwOlfb0EoG1Jcmf5zI7wPXkI1Y/gzhOkrbZ8Ox
oJkJsc0VIBV+umd48kpHk1ba4+ZNoxNyai+LYGC94lZoYpMud8ZweM6HdgvkSqYR
jSKdQurd0s30/5nPOl8SnwrROrgpbQ==
=RTDd
-----END PGP SIGNATURE-----

--Sig_/iB_/tHg=Djdt6hecZeIcLQu--
