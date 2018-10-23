Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90107C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359832075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgEwe4fP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359832075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeJXHSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:18:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42160 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:18:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id t6-v6so1275348plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7obhhqJzTRf5FOh/B8WOkn61KcEg3+XQefTrw6QpqgI=;
        b=hgEwe4fPs6/T5fahnQ+HsshKWvUZP2EvXfeYxh3at6/uS+cqm/sk6abBQVZ9nkiYyB
         ofO/BUk6LOmhTSifWbJVD/5/J5cS8b0hzRmQ6WwsvA3Vqjv//1mLehSyEr0kVOYMeYpk
         iEbC1mbHjNEnHU0v8ule3AIFONF9oA6Mr9xV2v5vsC4TxjYXg+ov9kBBTwzWW7vEQixI
         +O5Lw/ywCwhiW3HGaqlh5aaX9AUmRSzV0+durvaOowo76Aw58IilpMcpl+WVUsKjmGeA
         OzUnxzLjoQk6elqhhCXPU7ow7dhhyRZsC4j6lP7ZDY1bUJONTAA6vdcsUsCh9GORqpVO
         ykvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7obhhqJzTRf5FOh/B8WOkn61KcEg3+XQefTrw6QpqgI=;
        b=gKM7yV51pjm2w4N+I8molAqGSa/MEqFJrXPkrza96PEY1eXLjG8HoT6C/2MDPOp4WX
         U5x5CPKeJpNJDtoABiARCfJ+loHaQuSGDmnl4T69CEjNKR6xYErHC3mItDujf6nRk84q
         9+g2oSWqZ6sZOdstHCy+OgR764csXrjW+EgXpyCIMclINTH2DfoIFzdxXHwVCObbmi3p
         R7v0z3R1a9sj9JyO/UWp+mlDtenZI6C0CTDEvLuZLn3PMyXJB/nXYkbkh6Y+EaUfjDpC
         CgT7E+qxecArhyRM/Mt8rehf5Kekc7cHckIBgExjyq8w1AX+2IuFnM0VF3JqWY5SXg2a
         GWsA==
X-Gm-Message-State: AGRZ1gJqO8B5dbBbEVryNV3qWmH/nyRgHZwIFLG4TRWvOgt3xS3z6URm
        HC9uSf/AWLdf0Np3p6EhI//ovr3hk7OFucqCCeJ21A==
X-Google-Smtp-Source: AJdET5cNv//GK5SoACjRYkNtPcjbo1xDqFqsL8O9utqrfrQvTQ0mSMsttd+91EG8G6IGR2IOn5eblA0kWTCzFZufPY0=
X-Received: by 2002:a17:902:b106:: with SMTP id q6-v6mr176361plr.238.1540335201873;
 Tue, 23 Oct 2018 15:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181023003725.21463-1-natechancellor@gmail.com>
 <F3BBC06A-A9CB-4ABF-ADF4-6B0971FAE364@vmware.com> <CAKwvOdmsKbW9v9or+u-W9V7T+LrF4ODY9cgUStkjkmsbMcqJ2g@mail.gmail.com>
 <96ffedd2-a19d-95de-45fd-3a83025dd48a@zytor.com> <20181023215811.GA10771@flashbox>
 <CAKwvOd=-i0cVWuZaLQt5PQ11pa+gXaJCD_c6g9OTWwf79OS9Sw@mail.gmail.com> <20181023224435.GA7163@flashbox>
In-Reply-To: <20181023224435.GA7163@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Oct 2018 15:53:10 -0700
Message-ID: <CAKwvOd=XG00jNmhgbu15UafDNMTzBiGVarMQAQiMEsjwjPUtzA@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: Don't include '-Wa,-' when building with Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     hpa@zytor.com, namit@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 3:44 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Oct 23, 2018 at 03:08:53PM -0700, Nick Desaulniers wrote:
> > On Tue, Oct 23, 2018 at 2:58 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Tue, Oct 23, 2018 at 01:01:22PM -0700, H. Peter Anvin wrote:
> > > > On 10/23/18 11:40, Nick Desaulniers wrote:
> > > > > On Mon, Oct 22, 2018 at 10:11 PM Nadav Amit <namit@vmware.com> wr=
ote:
> > > > >>
> > > > >> at 5:37 PM, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > > >>
> > > > >> Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros =
in
> > > > >> inline assembly code to work around asm() related GCC inlining b=
ugs")
> > > > >> added this flag to KBUILD_CFLAGS, where it works perfectly fine =
with
> > > > >> GCC. However, when building with Clang, all of the object files =
compile
> > > > >> fine but the build hangs indefinitely at init/main.o, right befo=
re the
> > > > >> linking stage. Don't include this flag when building with Clang.
> > > > >>
> > > > >> The kernel builds and boots to a shell in QEMU with both GCC and=
 Clang
> > > > >> with this patch applied.
> > > > >>
> > > > >> Link: https://na01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F213&amp;data=3D02%=
7C01%7Cnamit%40vmware.com%7C871daebc2ca44947d28d08d638811fb5%7Cb39138ca3cee=
4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636758524579997650&amp;sdata=3DshuxW81QRrO3T=
Sqbgf462wgZYdLeAKeQEdGRxmnUX30%3D&amp;reserved=3D0
> > > > >> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > >> ---
> > > > >>
> > > > >> The reason this patch is labeled RFC is while I can verify that =
this
> > > > >> fixes the issue, I'm not entirely sure why the '-Wa,-' works for=
 GCC
> > > > >> and not Clang. I looked into what the flag means and I couldn't =
really
> > > > >> find anything so I just assume it's taking input from stdin? The=
 issue
> > > > >> could stem from how GCC forks gas versus how Clang does it. If t=
his
> > > > >> isn't of concern and the maintainers are happy with this patch a=
s is,
> > > > >> feel free to take it.
> > > > >>
> > > >
> > > > Perhaps someone could actually, you know, time the build and see ho=
w
> > > > much -pipe actually matters, if at all?
> > > >
> > > >       -hpa
> > > >
> > >
> > > Thank you for the suggestion! With the attached diff for removing
> > > '-pipe' and 'make -j1' with defconfig (just to make sure any variance
> > > would stand out), here are my results:
> > >
> > > -pipe (GCC):
> > >
> > > real    15m55.202s
> > > user    14m17.748s
> > > sys     1m47.496s
> > >
> > > No -pipe (GCC):
> > >
> > > real    16m4.430s
> > > user    14m16.277s
> > > sys     1m46.604s
> > >
> > > -pipe (Clang):
> > >
> > > real    21m26.016s
> > > user    19m21.722s
> > > sys     2m2.606s
> > >
> > > No -pipe (Clang):
> > >
> > > real    21m27.822s
> > > user    19m22.092s
> > > sys     2m4.151s
> >
> > Looks like Clang eats `-pipe`:
> > https://github.com/llvm-mirror/clang/blob/391667a023f79287f9c40868f34f0=
8c161555556/lib/Driver/Driver.cpp#L962
> > commit r110007 has the log:
> >     Driver: Start ripping out support for -pipe, which is worthless
> > and complicates
> >     too many other things.
> >
>
> In that case, we can either keep this change (I'll resend with the
> explanation that Clang doesn't respect -pipe) or we can just rip out
> -pipe for GCC too. Here are three separate results for GCC with my
> normal jobs flag:
>
> -pipe (GCC):
>
> real    3m40.813s
> real    3m44.449s
> real    3m39.648s
>
> No -pipe (GCC):
>
> real    3m38.492s
> real    3m38.335s
> real    3m38.975s
>
> Practically no variance.

Thanks for these measurements.  With these in mind I agree with HPA
that `-pipe -Wa,-` doesn't buy us anything, and would be simpler to
remove it for compatibility with Clang.

>
> Thanks,
> Nathan
>
> > >
> > > Certainly seems like -pipe doesn't make a ton of difference. If this =
is
> > > a better fix, I am happy to draft up a proper commit message and send
> > > it out for review.
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >
> > > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > > index 73f4831283ac..672c689c1faa 100644
> > > --- a/arch/x86/Makefile
> > > +++ b/arch/x86/Makefile
> > > @@ -213,8 +213,6 @@ ifdef CONFIG_X86_64
> > >  KBUILD_LDFLAGS +=3D $(call ld-option, -z max-page-size=3D0x200000)
> > >  endif
> > >
> > > -# Speed up the build
> > > -KBUILD_CFLAGS +=3D -pipe
> > >  # Workaround for a gcc prelease that unfortunately was shipped in a =
suse release
> > >  KBUILD_CFLAGS +=3D -Wno-sign-compare
> > >  #
> > > @@ -239,7 +237,7 @@ archheaders:
> > >  archmacros:
> > >         $(Q)$(MAKE) $(build)=3Darch/x86/kernel arch/x86/kernel/macros=
.s
> > >
> > > -ASM_MACRO_FLAGS =3D -Wa,arch/x86/kernel/macros.s -Wa,-
> > > +ASM_MACRO_FLAGS =3D -Wa,arch/x86/kernel/macros.s
> > >  export ASM_MACRO_FLAGS
> > >  KBUILD_CFLAGS +=3D $(ASM_MACRO_FLAGS)
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
