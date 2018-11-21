Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7018C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 02:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CFF21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 02:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HSyDRyVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CFF21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeKUNUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:20:23 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:39528 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKUNUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:20:23 -0500
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAL2ludb009582;
        Wed, 21 Nov 2018 11:47:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAL2ludb009582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542768477;
        bh=l5a+aW6BpQ54bHtcdpO+NgEUoHC/Oayvxin+NjW35ZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HSyDRyVFx75JKCh1kgrphauLwY7wOmjsWIHlbmO/aiIckWcshoZluQ7Gr2/D3GgZ5
         W3YHuTM4pgnXMTo3XMIg4RiMoxAH7GGhNW4sSx6sVrHAfTD1haJhX48K9W/nPWKOjT
         bjMQjfeAv/y2/aYxtisp/EFiYPDTJkHlP34elfoKZhXIAbffcAgOXoO1wHmlWeqTSN
         FLbUJUcXrAA2lQ8VtdhlIixr5OjLH+g9Hh6Mf6CzpfA2CpzyrizYFKHnWw6buNZsQh
         4iZhJ1tmwTxPsDFe78vF0hzZR5twLvn1c7+s48ihzkuX77Wndy4+qJV9HDY9xDHG/O
         b7+Y9Fmui/VqQ==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id j3so1423021uap.3;
        Tue, 20 Nov 2018 18:47:56 -0800 (PST)
X-Gm-Message-State: AA+aEWZyAoQ0bILVPkFmFoOIJjBJo8endiJgSXlDVV/AeqpAoYJabS+V
        kPO7e6YcFb8JEYRrdPLHuhI6DoZ67GPGznaVulM=
X-Google-Smtp-Source: AFSGD/WNdbkD1ykskXvHK2uggSnsB1iZSbiDwgLflffKYZsz5UfzA7ilCeICvM2EFIaxYib6pIupSHYhHIHZ1kZBuJM=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr2072623uap.6.1542768475630;
 Tue, 20 Nov 2018 18:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20181114204309.18645-1-namit@vmware.com> <20181114204309.18645-2-namit@vmware.com>
 <CAK7LNAREF_Pcejq1LJ=3K7h0M4o4oSRLfbeJc73O+8HV420Ziw@mail.gmail.com>
 <1C316B94-8F27-439C-B049-9947DC329780@vmware.com> <CAK7LNATFVHnPXh-uEA+T9QNw3OnSvkLLKMuJ_tF1v8bEveStSg@mail.gmail.com>
 <1F17E69E-06E8-4A5A-A434-1DCD6C6F0259@vmware.com>
In-Reply-To: <1F17E69E-06E8-4A5A-A434-1DCD6C6F0259@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Nov 2018 11:47:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCmMTTEZUBhSVawVM_+r6KsuYnBCdxX_p3GqbKBH3DEw@mail.gmail.com>
Message-ID: <CAK7LNATCmMTTEZUBhSVawVM_+r6KsuYnBCdxX_p3GqbKBH3DEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86 macros
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 2:21 AM Nadav Amit <namit@vmware.com> wrote:
>
> at 8:20 PM, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > On Sat, Nov 17, 2018 at 6:02 AM Nadav Amit <namit@vmware.com> wrote:
> >> From: Masahiro Yamada
> >> Sent: November 16, 2018 at 7:45:45 AM GMT
> >>> To: Nadav Amit <namit@vmware.com>
> >>> Cc: Ingo Molnar <mingo@redhat.com>, Michal Marek <michal.lkml@markovi=
.net>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>=
, H. Peter Anvin <hpa@zytor.com>, X86 ML <x86@kernel.org>, Linux Kbuild mai=
ling list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-=
kernel@vger.kernel.org>
> >>> Subject: Re: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86=
 macros
> >>>
> >>>
> >>> On Thu, Nov 15, 2018 at 1:01 PM Nadav Amit <namit@vmware.com> wrote:
> >>>> Introducing the use of asm macros in c-code broke distcc, since it o=
nly
> >>>> sends the preprocessed source file. The solution is to break the
> >>>> compilation into two separate phases of compilation and assembly, an=
d
> >>>> between the two concatenate the assembly macros and the compiled (ye=
t
> >>>> not assembled) source file. Since this is less efficient, this
> >>>> compilation mode is only used when distcc or icecc are used.
> >>>>
> >>>> Note that the assembly stage should also be distributed, if distcc i=
s
> >>>> configured using "CFLAGS=3D-DENABLE_REMOTE_ASSEMBLE".
> >>>>
> >>>> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> >>>> Signed-off-by: Nadav Amit <namit@vmware.com>
> >>>
> >>>
> >>> Wow, this is so ugly.
> >>
> >> Indeed, it is not pretty from the Makefile system point of view.
> >>
> >> But it does have merits when it comes to the actual use (by developers=
). If
> >> you look on x86, there are a lot of duplicated implementation for C an=
d Asm
> >> and crazy C macros, for example for PV function call or the alternativ=
e
> >> mechanism. The code is also less readable in its current form.
> >>
> >>> I realized how much I hated this by now.
> >>>
> >>> My question is, how long do we need to carry this?
> >>
> >> If it is purely about performance, I am not sure it would make sense t=
o
> >> put it in, as it will indeed be (eventually) solved by the compiler, a=
nd
> >> the penalty is not too great.
> >
> >
> > It is unfortunate to mess up the code
> > by having two different ways to achieve the same goal.
>
> Indeed, but I fail to see how this statement fits with the next sentence.

I am not tracking the progress on GCC side.
I just did not sure if the 'asm inline' work was on the right track.


> > When GCC with asm inline support is shipped,
> > would you revert 77b0bf55 ?
>
> This patch and the following ones were not written to be reverted, i.e.,
> reverting them later may not be easy since they remove redundant C inline
> assembly chunks.
>
> Since gcc will solve the inline assembly issues, the value of these patch=
es
> is in unifying the assembly that is used in .c and .S files. Due to the l=
ack
> of m4-like preprocessor in the Linux make-system, the solution is a bit
> =E2=80=9Chacky=E2=80=9D (in other words, I don=E2=80=99t see a reasonable=
 alternative solution).
>
> So there is a downside in the form of performance degradation of distcc, =
and
> hacky (not too hacky?) Makefile changes. On the upside, except addressing
> the gcc statement cost computation (inline) issue, the patch removes
> redundant code, and improves assembly code readability.

It is true that the assembly part itself is readable
but the readability as a whole is worse IMHO.

Each macro implementation was split into "asm volatile" (in C) +
".macro" (in ASM) parts.


> In addition, it
> provides the option to make assembly manipulations after compilation, whi=
ch
> HPA and others (me) look into.
>
>  Anyhow, if after all, the downside is considered greater than the upside=
,
> it is best to remove the patches sooner than later, as a revert later wil=
l
> be more painful.

Then, I'd be happier with the revert now.



--
Best Regards
Masahiro Yamada
