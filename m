Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEEECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DA0214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ4CEmR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DA0214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJRBv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbeJRBv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:51:28 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7112151D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 17:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539798881;
        bh=V2RHBNJES4Csa6KWpY1VN8nn1Ru8+U0/UrnfIs3j+Y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tJ4CEmR0I+j8dBARJYuT95uN0aRPNI8J88wmIMwBKO8skFQFWJPe5g6YgCuLVm3X5
         ESBOWqbmlL1VM33qUOVfRJBx/E2kUkF90Sm0H73o/beGbB+88lXYOaobo58FUgUw4c
         VqU/cmTD2wSY04fiheo0TMgx9YZjntS1e3Db0dJs=
Received: by mail-wm1-f51.google.com with SMTP id z25-v6so125451wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:54:41 -0700 (PDT)
X-Gm-Message-State: ABuFfohtLYHTekV+AYsBp5CxH4zYqh5Lbckt+ACexOkiIu3E5aLXesyf
        iffknUvaOXkgnTcon7mzZzllrA/7CavlBVfn96QPpQ==
X-Google-Smtp-Source: ACcGV61yb9O/fqlsbq+nujcl/2eUoXqGtS41kOW9UMTHulHp8FdfzHGxz/u1lJGbb469DfzhLoRWmvX1Bp6Xe45JGko=
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr3868002wmq.14.1539798879668;
 Wed, 17 Oct 2018 10:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000834.GA21330@WindFlash> <20181017060151.GA1105@gmail.com>
In-Reply-To: <20181017060151.GA1105@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Oct 2018 10:54:28 -0700
X-Gmail-Original-Message-ID: <CALCETrXxGKAHam6Q=q949XnudEkMRZbH-jnHCp3Egfe1sNexnQ@mail.gmail.com>
Message-ID: <CALCETrXxGKAHam6Q=q949XnudEkMRZbH-jnHCp3Egfe1sNexnQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Renames variable to fix shadow warning.
To:     Ingo Molnar <mingo@kernel.org>
Cc:     leobras.c@gmail.com, lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        michal.lkml@markovi.net, LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:01 PM Ingo Molnar <mingo@kernel.org> wrote:
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

Maybe image_name and sym_name?

--Andy
