Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2F0ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7BB2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkG325KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7BB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJRHJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:09:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35695 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeJRHJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:09:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id 14so23952286oth.2;
        Wed, 17 Oct 2018 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9BDvSY048GN7d+7lYH/dmV+sc0UMWzZ0Ep2qtlKMfu8=;
        b=OkG325KNR5XS79/vhwrGgMXAuvbu/gsBRgSwAccmsTpORsFdsJH7Du4ubEnki0Fs44
         rchdYTf7tBJ9iz7wWEHXh+lke9Rn8Hx6tChJbMTBYQ7EDBR7sb9yd9vOi9JrsHXWp3Eu
         SvtdzGNsm0OKw7qZ/W3FmNbJo9pzGu+fP2DpHrlNxJNg7trZxDdkKgZcwW3fJv8HG+ou
         rAVmgQteUYuDkm13HFC0b6R7XDFPg1ddqPg/f0fPPtIwvVrLMG3kvroC2B+PFpIYfyoW
         N9TuGyeV17qEcea3F+DCUnmJjuidkagSFcVKDpzePwpS54Mp2sSW7KaZRuMEB30qjjFP
         V7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9BDvSY048GN7d+7lYH/dmV+sc0UMWzZ0Ep2qtlKMfu8=;
        b=JXZ5037m6dxtC+UBtYNpaIaTgWu0bQp56zatHLz9o7Ki0WsYlgpo9MAWnjQnJin6G7
         y7rUPBzBvs5K0tb4s0WRbS7eicyeDmFEBWr21o/fr+LhUwpPXIY7AQ59sQpszhT8Mlki
         myE9fMpqcB/VmBpkLwW93MvKCt+yV0NeWFg+glCKNW/bYto6yz+eFdkChZxv1bTfgc41
         EniSBQvroKlt7906CJ4oOoVxpGdxPHjmeoAsVVg1+6Oz6b/v0xw/1GA8a4V6ho/UutBq
         ZaywhF5gmgZYmG//t04zjbx+6WGqMXB6PBQlfsSCidQp6ZvoZtELggIIW9Jq8fxCMF94
         Wu+Q==
X-Gm-Message-State: ABuFfohp1N5OosVogIqu/UUhmNgWy13RNk1IWKtDKsYEJLq74Eu1Uivn
        oKyF+f/Fuk6lblKY/IkjEBlpp2o/G9NvzhtV3x8=
X-Google-Smtp-Source: ACcGV63Fz+UMHJOMqZS6Gb6Fg6/OOHEE/lw+YvL+alqH2YlaQ3Smy9peiWcR6A/Ni9WQjT7iX3YBlZKTha8ptR569P0=
X-Received: by 2002:a9d:948:: with SMTP id 66mr18392857otp.178.1539817862758;
 Wed, 17 Oct 2018 16:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000834.GA21330@WindFlash> <b17297ec-9044-d0c4-ee0e-664b53713020@koikeco.de>
In-Reply-To: <b17297ec-9044-d0c4-ee0e-664b53713020@koikeco.de>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 17 Oct 2018 20:10:50 -0300
Message-ID: <CADvQ+rH5FTzgQN==EwQn_MogDeGR1hnScd=pyuRqHXB=QKYo_Q@mail.gmail.com>
Subject: Re: [Lkcamp] [PATCH 2/4] Renames variable to fix shadow warning.
To:     helen@koikeco.de
Cc:     lkcamp@lists.libreplanetbr.org, x86@kernel.org,
        linux-kbuild@vger.kernel.org, Matthew Wilcox <willy6545@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Helen,
Thanks for the suggestions!

On Tue, Oct 16, 2018 at 11:57 PM Helen Koike <helen@koikeco.de> wrote:
>
> Hi Leonardo,
>
> Thanks for the patch, just some small comments below.
>
> Please, check previous log messages with git log
> arch/x86/entry/vdso/vdso2c.h, you will see that most patches had the
> prefix "x86/vdso:" in the commit message.
Ok, added! This change will be available on v2.

>
> On 10/16/18 9:08 PM, Leonardo Br=C3=A1s wrote:
> > Renames the char variable to avoid shadowing a variable previously
> > declared on this function.
> >
> > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
> >  arch/x86/entry/vdso/vdso2c.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.=
h
> > index fa847a620f40..9466998d0f28 100644
> > --- a/arch/x86/entry/vdso/vdso2c.h
> > +++ b/arch/x86/entry/vdso/vdso2c.h
> > @@ -93,11 +93,11 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw=
_len,
> >               int k;
> >               ELF(Sym) *sym =3D raw_addr + GET_LE(&symtab_hdr->sh_offse=
t) +
> >                       GET_LE(&symtab_hdr->sh_entsize) * i;
> > -             const char *name =3D raw_addr + GET_LE(&strtab_hdr->sh_of=
fset) +
> > +             const char *name2 =3D raw_addr + GET_LE(&strtab_hdr->sh_o=
ffset) +
> >                       GET_LE(&sym->st_name);
>
> Could you please use a more meaningful name instead of name2 please? I
> believe sym_name should be fine.

Ok, I renamed as you suggested.
Also, I renamed the "name" variable to "image_name" as Andy suggested.
This change will be available on v2.

>
> >
> >               for (k =3D 0; k < NSYMS; k++) {
> > -                     if (!strcmp(name, required_syms[k].name)) {
> > +                     if (!strcmp(name2, required_syms[k].name)) {
> >                               if (syms[k]) {
> >                                       fail("duplicate symbol %s\n",
> >                                            required_syms[k].name);
> >
>
> Regards
> Helen

Regards,
Leonardo Bras
