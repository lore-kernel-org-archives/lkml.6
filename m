Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD4C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F54920652
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PRtjCS6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F54920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeI2XOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:14:21 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:48813 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbeI2XOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:14:21 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8TGiwxX001452;
        Sun, 30 Sep 2018 01:44:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8TGiwxX001452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538239499;
        bh=ig9LKiYDmTW5QutbS75zDikc1vzjPEA/JyZEboxoBP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PRtjCS6A3pU6z4nEQuf0wyYAXCW63TwUw0FXNRUwFWGeqsuXbDjFKYRhrbV2wI2FE
         8hXcKFb1XD30TQAJhpLVJFub3JXs1/TgDa+OfS96TdQqPTHpPqVsAz4a6LgJrnjI+L
         or5bEiHwnglwo0NiBXBtKXV3K/QNuI2XR2oA8pUYjT6yGsetHWCjEEWlWNIOxmULiN
         8KrSLbFBFm2Z3ALYzmtSm04W1fwH94nHesaZ2wotO+zlxxDjwkihYxRIr61MSqLuJn
         Dj+1LubOD3WOUl8FUbgW8Lt6X/C3D2Ui08Ot86cm2dZHiM9F5LBxQmsLShG+TQ7hwV
         YmU9jstPAhOBg==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id v18-v6so5297098vsl.11;
        Sat, 29 Sep 2018 09:44:58 -0700 (PDT)
X-Gm-Message-State: ABuFfojmXZbgOEe0G5wN1eqXrmjg3TEoPFBi+m7cKdxRpeafOzBhYDXp
        UgpSIdpzkTMQsG7LBccwiIZQp84yqvrDstPrs7Y=
X-Google-Smtp-Source: ACcGV62j9AuYRIJZsp/qzUtQ494xWyyczbS1f4sQcqr28janJk21WtlG4IkqXQC3qOxQRTDNcFKxtvjv1g8PVFiQ9I8=
X-Received: by 2002:a67:5f85:: with SMTP id t127-v6mr1369725vsb.155.1538239497681;
 Sat, 29 Sep 2018 09:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <1538115715-10078-1-git-send-email-yamada.masahiro@socionext.com> <87bm8giy9l.fsf@rustcorp.com.au>
In-Reply-To: <87bm8giy9l.fsf@rustcorp.com.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 30 Sep 2018 01:44:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR1PvP9UXFve9Fx=bwzy3azt3bT0eBFtMo1CvrqHvAzdQ@mail.gmail.com>
Message-ID: <CAK7LNAR1PvP9UXFve9Fx=bwzy3azt3bT0eBFtMo1CvrqHvAzdQ@mail.gmail.com>
Subject: Re: [PATCH] modpost: remove leftover symbol prefix handling for
 module device table
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B49=E6=9C=8829=E6=97=A5(=E5=9C=9F) 16:01 Rusty Russell <rusty@ru=
stcorp.com.au>:
>
> Please send this to the module maintainer (CC'd).


I just sent this to Kbuild ML
since scripts/mod/ is listed in the Kbuild part.

Next time, I will try my best to remember
to CC the module maintainer.

Reviewed-by tags are appreciated.



KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
M:      Masahiro Yamada <yamada.masahiro@socionext.com>
M:      Michal Marek <michal.lkml@markovi.net>
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-k=
build.git
L:      linux-kbuild@vger.kernel.org
S:      Maintained
F:      Documentation/kbuild/
F:      Makefile
F:      scripts/Kbuild*
F:      scripts/Makefile*
F:      scripts/basic/
F:      scripts/mk*
F:      scripts/mod/
F:      scripts/package/






> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > Blackfin and metag were the only architectures that prefix symbols with
> > an underscore.  They were removed by commit 4ba66a976072 ("arch: remove
> > blackfin port"), commit bb6fb6dfcc17 ("metag: Remove arch/metag/"),
> > respectively.
> >
> > It is no longer necessary to handle <prefix> part of module device
> > table symbols.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  scripts/mod/file2alias.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > index 7be4369..ba4ebc4 100644
> > --- a/scripts/mod/file2alias.c
> > +++ b/scripts/mod/file2alias.c
> > @@ -1415,11 +1415,10 @@ void handle_moddevtable(struct module *mod, str=
uct elf_info *info,
> >       if (ELF_ST_TYPE(sym->st_info) !=3D STT_OBJECT)
> >               return;
> >
> > -     /* All our symbols are of form <prefix>__mod_<name>__<identifier>=
_device_table. */
> > -     name =3D strstr(symname, "__mod_");
> > -     if (!name)
> > +     /* All our symbols are of form __mod_<name>__<identifier>_device_=
table. */
> > +     if (strncmp(symname, "__mod_", strlen("__mod_")))
> >               return;
> > -     name +=3D strlen("__mod_");
> > +     name =3D symname + strlen("__mod_");
> >       namelen =3D strlen(name);
> >       if (namelen < strlen("_device_table"))
> >               return;
> > --
> > 2.7.4



--=20
Best Regards
Masahiro Yamada
