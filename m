Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC4ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA2B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEcRcpjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA2B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJRHKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:10:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38005 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbeJRHKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:10:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id u197-v6so22492578oif.5;
        Wed, 17 Oct 2018 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tmwi8qU5cqppcj4YsIKa0J0Z+sU/QwA7XgHI33VIUBQ=;
        b=ZEcRcpjSJF+g9rdVRwSx1+rjs++0ZYJPi0GU6/TnW8OMsKo/W7GVxlC2H57SlniE1d
         Od9WPQqyz/XgjokCNlDTmM0H2M7/JSRDVlWuUhbPze5o+VsBsXs7IN/vzhYESyRonlJV
         wTfmk4TizoMyFuHOzAX7L16qib6MARdNoijNA2YAoS0a4WB/rJP9MmCcUbRf5Rs7aU3/
         m27iAnPGcNiWnH3HJoFgYOQzewp/N+0nL15o6vsUal5BIIdICQNTtMdffZBydyQbzUHT
         +RugrnqJZNPFaox10I5pmjigfezIkUDavO5dUTCpn9k07PC5iknko1Eb3tmEMWlZ6z2m
         4TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tmwi8qU5cqppcj4YsIKa0J0Z+sU/QwA7XgHI33VIUBQ=;
        b=dcnsXbB/Mi9SRKh6+GYrEASHKmdbVtNs8Fx7bzxlB+p3GyEFzsWjkfevpyGpruCkv+
         PWOpXSmQPVckA6p0TT2y7W2d+52C3GQ7lZck2NS16Gb0Oz9KVKhWAgRw4yFFRX7uSYMR
         1swBAlfxaQS3HgtyGx/Q/7YsoBGVZRar6C4VBl8G57N6M12Zult91e96ZD2gU/9cyTU7
         BzDVLvGeGQnuJIV3l/FLp7VdXRERsNQgRv0fdnvA5WbTTojPiFExGFk/4aBHWaqg6pIM
         ySwVYpk9/NqscDpvnH/wyPT/cvzM4nJSW+ECThcglXvAVSiKSCDpjGIamSSNiZANep3T
         Ooug==
X-Gm-Message-State: ABuFfohcnT35/T6Oe7J87TTY5Z6713alWR0+IYODn5PXMpL6VGVsVcE5
        +8RsNAt5n4LT8SqeyLyikn4KElv4DrsMbytcK/8=
X-Google-Smtp-Source: ACcGV63516CehwxxjyKDwno0N89wOEZIyncWu73keDRHOwuDoUfXkSkVO5wc1SXC1LPSPpY4MueBNGRHHh5ARy6XWFA=
X-Received: by 2002:aca:ac0e:: with SMTP id v14-v6mr15495445oie.1.1539817974184;
 Wed, 17 Oct 2018 16:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000834.GA21330@WindFlash> <20181017060151.GA1105@gmail.com>
In-Reply-To: <20181017060151.GA1105@gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 17 Oct 2018 20:12:39 -0300
Message-ID: <CADvQ+rHD5kAam7kOc2UBUd9Pw6QW3dGhUjQj=es37NfgMeLcyA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Renames variable to fix shadow warning.
To:     mingo@kernel.org
Cc:     lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
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

Thanks Ingo,
On Wed, Oct 17, 2018 at 3:01 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Leonardo Br=C3=A1s <leobras.c@gmail.com> wrote:
>
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
> >
> >               for (k =3D 0; k < NSYMS; k++) {
> > -                     if (!strcmp(name, required_syms[k].name)) {
> > +                     if (!strcmp(name2, required_syms[k].name)) {
> >                               if (syms[k]) {
> >                                       fail("duplicate symbol %s\n",
> >                                            required_syms[k].name);
>
> NAK.
>
> Please read and understand the code and rename both variables to
> meaningful names, not just a mindless name/name2 ...
>

It's changed! This change will be available on v2.

> Thanks,
>
>         Ingo

Regards,
Leonardo
