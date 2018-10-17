Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8426EECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F86821476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKMdH3qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F86821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJRHO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:14:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33012 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:14:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id q50so27992472otd.0;
        Wed, 17 Oct 2018 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pwuBYpPORalsYGLaBcqAoK/4jYhOO4G8Wlc7dwprejI=;
        b=jKMdH3qdQPGUSXrjwN74WUTUBtx7Rr/SRsbEccpZumsxknWE9CSVJugn1hNSCEH2rZ
         omlLFlWcWExgq0ONMB2ThE324MGViwBZCWmUSpBohhQx+W9Hbf5rPxQTak9Ph+lgKWNM
         lnA4OB2fOx/CZDQndhYwuromVcbw6dydv43v2yevGqJdk9UqEAtc/tSj50Gugo043u74
         wTbWj+r0ldhB9mAZurOg6WddcIESHPolrDMCBWiSpCj/Oxhf0mbtoPkKHj+DW11uOkPe
         zMrgBIDvHHfD8E/cMqiXfImuHdNkd9TevAb523nA5D7ygCcNz2lcjpdD9APnQmJzjo0z
         c2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pwuBYpPORalsYGLaBcqAoK/4jYhOO4G8Wlc7dwprejI=;
        b=l4j9LVhWZADZuz5wW+WnBK4M/ubwc9uJXbosOpn8OEuyQFEE261zGe6ceswc+N/NxL
         F7hECV2teFQGtAVXLbVRIbBpeiKrIXDNj+N90zRaIkC1iboJ4GahvQF9UlrDskIYFEv+
         uUvNY4QqdoPCCq4MsForyuUkvMpHTCWga8Mw8VezXmXDPC6zXZe8nJElnknjNPap6sZo
         r/ZmwxhXp2f4i3dJ/lPeOQ8Gd9CkPrt5LDaaVQa2PFBIGsAduuIa5b9NGrHX13VIvUxw
         c0/u1Gah1lVDM6ZGgk9yh0f8Ro74HkYMhtJzyUPJVD1b7sfpPElmGD1L/4svpsxaYATF
         6VzA==
X-Gm-Message-State: ABuFfogzcFDFn2MNzFHwtoH9SV2dkrt45aT8Rw9Ay6Y226iY501I3hDS
        O9YIJPAmuhuts1s9UrAoxGNVSobNe0IF/JBhEBk=
X-Google-Smtp-Source: ACcGV62NRWu2jcPD0d3SGfc9qkN0fJn0FhrCMfuFPkbJTpu1xi+JHHi6HdA9NeRxix48xGfHW77ID7ScyiX+/qxmdyU=
X-Received: by 2002:a9d:2568:: with SMTP id j37mr18928115otd.263.1539818186263;
 Wed, 17 Oct 2018 16:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000834.GA21330@WindFlash> <20181017060151.GA1105@gmail.com>
 <CALCETrXxGKAHam6Q=q949XnudEkMRZbH-jnHCp3Egfe1sNexnQ@mail.gmail.com>
In-Reply-To: <CALCETrXxGKAHam6Q=q949XnudEkMRZbH-jnHCp3Egfe1sNexnQ@mail.gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 17 Oct 2018 20:16:14 -0300
Message-ID: <CADvQ+rFBeyhxLp21SON5h4BP1T-rW6FMCyU-JZ_d_0EKOHQgdw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Renames variable to fix shadow warning.
To:     Andy Lutomirski <luto@kernel.org>
Cc:     mingo@kernel.org, lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,
Thanks for the suggestion.
I renamed them as suggested and it will be available on v2.

Regards,

Leonardo

On Wed, Oct 17, 2018 at 2:54 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Oct 16, 2018 at 11:01 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Leonardo Br=C3=A1s <leobras.c@gmail.com> wrote:
> >
> > > Renames the char variable to avoid shadowing a variable previously
> > > declared on this function.
> > >
> > > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > > ---
> > >  arch/x86/entry/vdso/vdso2c.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2=
c.h
> > > index fa847a620f40..9466998d0f28 100644
> > > --- a/arch/x86/entry/vdso/vdso2c.h
> > > +++ b/arch/x86/entry/vdso/vdso2c.h
> > > @@ -93,11 +93,11 @@ static void BITSFUNC(go)(void *raw_addr, size_t r=
aw_len,
> > >               int k;
> > >               ELF(Sym) *sym =3D raw_addr + GET_LE(&symtab_hdr->sh_off=
set) +
> > >                       GET_LE(&symtab_hdr->sh_entsize) * i;
> > > -             const char *name =3D raw_addr + GET_LE(&strtab_hdr->sh_=
offset) +
> > > +             const char *name2 =3D raw_addr + GET_LE(&strtab_hdr->sh=
_offset) +
> > >                       GET_LE(&sym->st_name);
> > >
> > >               for (k =3D 0; k < NSYMS; k++) {
> > > -                     if (!strcmp(name, required_syms[k].name)) {
> > > +                     if (!strcmp(name2, required_syms[k].name)) {
> > >                               if (syms[k]) {
> > >                                       fail("duplicate symbol %s\n",
> > >                                            required_syms[k].name);
> >
> > NAK.
> >
> > Please read and understand the code and rename both variables to
> > meaningful names, not just a mindless name/name2 ...
> >
>
> Maybe image_name and sym_name?
>
> --Andy
