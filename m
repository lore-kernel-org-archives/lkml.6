Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94535C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3471D2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8SrUYWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3471D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeJXGeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:34:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37786 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeJXGeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:34:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so1366817pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SSPf20lJaL3+N4Oj+pTKafdZhuntXcydrB13JUuWzZ0=;
        b=d8SrUYWHPC2LJvc+GcVtxvTNxG9qPRoP9m9FT+a7HIRMrwwIApdi4YfUwsY70/ccUG
         IdWiPIfN3Q7B68hkt8mAIr05AdJSpaWEU/x10wK7kKn7sAQrJi/fpqAPNrR9P1Be7hL/
         RVDmnzjc65rn9ecifN29lJ8mCB1j0cJeUPN5VMgARZ7OVSRl9SQ/fJ4L+qtGb8SLD5Z1
         //qZK5pf+cCU9aTfpuNVTYW0FeEmvCluR8yw1RaB1UPxWwD4ceHpTr5ySsTc4r+ZYHiR
         MNlykD2LSma22sBlFJifLNQAM2KompoLYzYiC1NZ8tt6N41swYop5DWIwB+E9YdUq4Al
         ra/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SSPf20lJaL3+N4Oj+pTKafdZhuntXcydrB13JUuWzZ0=;
        b=I1PC7dHQ4IUEy/X6pBYu8JNn/mI6+3LktNsP+FpzVIkPxn2r4/VkME86X9dIUGfj2s
         UWj6KQmt7f1YTKoRv43lLnjQzOIpCIP5impEa91g9PZUbGaCrETRRiL63r0+udYX0NBD
         iSgEBkzyC+7vGMa5I91K7PfuIAFUGLAaCcuutOyGII0HzZOK+i6Xm8vM6FbcBGVL+kbk
         VsGV4DS63OSKp815r4GAKaOGQwLylxlftdhWWz83Z3tdmNmp/Zn/Qyr/1ONA3n4C0pUW
         onTok6CFy3gYGwGDQx++LUpMUDzF/AU7d1vQB7OHDSs69zu5mK8SgZZOlV3If4gcVK53
         f17g==
X-Gm-Message-State: AGRZ1gINnfJmWn3ZVwoqnhu68Rf4u6bC6eZGvaOB2T+SYzK2RG42wzBl
        mGuL/gVlZgTsu2oyVgEHeqb44Bcm4KxinwXlWJIUow==
X-Google-Smtp-Source: AJdET5dyK//O9lXY+ofNaCWr8/U7CIOs3DntcSqMsIATGMlMdUs/iaw5GOaeCavuUzgrjsHrCgJjHOaTgvmibtFj5/E=
X-Received: by 2002:a62:d405:: with SMTP id a5-v6mr76912pfh.174.1540332544367;
 Tue, 23 Oct 2018 15:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181023003725.21463-1-natechancellor@gmail.com>
 <F3BBC06A-A9CB-4ABF-ADF4-6B0971FAE364@vmware.com> <CAKwvOdmsKbW9v9or+u-W9V7T+LrF4ODY9cgUStkjkmsbMcqJ2g@mail.gmail.com>
 <96ffedd2-a19d-95de-45fd-3a83025dd48a@zytor.com> <20181023215811.GA10771@flashbox>
In-Reply-To: <20181023215811.GA10771@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Oct 2018 15:08:53 -0700
Message-ID: <CAKwvOd=-i0cVWuZaLQt5PQ11pa+gXaJCD_c6g9OTWwf79OS9Sw@mail.gmail.com>
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

On Tue, Oct 23, 2018 at 2:58 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Oct 23, 2018 at 01:01:22PM -0700, H. Peter Anvin wrote:
> > On 10/23/18 11:40, Nick Desaulniers wrote:
> > > On Mon, Oct 22, 2018 at 10:11 PM Nadav Amit <namit@vmware.com> wrote:
> > >>
> > >> at 5:37 PM, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >>
> > >> Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
> > >> inline assembly code to work around asm() related GCC inlining bugs"=
)
> > >> added this flag to KBUILD_CFLAGS, where it works perfectly fine with
> > >> GCC. However, when building with Clang, all of the object files comp=
ile
> > >> fine but the build hangs indefinitely at init/main.o, right before t=
he
> > >> linking stage. Don't include this flag when building with Clang.
> > >>
> > >> The kernel builds and boots to a shell in QEMU with both GCC and Cla=
ng
> > >> with this patch applied.
> > >>
> > >> Link: https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F213&amp;data=3D02%7C01=
%7Cnamit%40vmware.com%7C871daebc2ca44947d28d08d638811fb5%7Cb39138ca3cee4b4a=
a4d6cd83d9dd62f0%7C1%7C0%7C636758524579997650&amp;sdata=3DshuxW81QRrO3TSqbg=
f462wgZYdLeAKeQEdGRxmnUX30%3D&amp;reserved=3D0
> > >> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >> ---
> > >>
> > >> The reason this patch is labeled RFC is while I can verify that this
> > >> fixes the issue, I'm not entirely sure why the '-Wa,-' works for GCC
> > >> and not Clang. I looked into what the flag means and I couldn't real=
ly
> > >> find anything so I just assume it's taking input from stdin? The iss=
ue
> > >> could stem from how GCC forks gas versus how Clang does it. If this
> > >> isn't of concern and the maintainers are happy with this patch as is=
,
> > >> feel free to take it.
> > >>
> >
> > Perhaps someone could actually, you know, time the build and see how
> > much -pipe actually matters, if at all?
> >
> >       -hpa
> >
>
> Thank you for the suggestion! With the attached diff for removing
> '-pipe' and 'make -j1' with defconfig (just to make sure any variance
> would stand out), here are my results:
>
> -pipe (GCC):
>
> real    15m55.202s
> user    14m17.748s
> sys     1m47.496s
>
> No -pipe (GCC):
>
> real    16m4.430s
> user    14m16.277s
> sys     1m46.604s
>
> -pipe (Clang):
>
> real    21m26.016s
> user    19m21.722s
> sys     2m2.606s
>
> No -pipe (Clang):
>
> real    21m27.822s
> user    19m22.092s
> sys     2m4.151s

Looks like Clang eats `-pipe`:
https://github.com/llvm-mirror/clang/blob/391667a023f79287f9c40868f34f08c16=
1555556/lib/Driver/Driver.cpp#L962
commit r110007 has the log:
    Driver: Start ripping out support for -pipe, which is worthless
and complicates
    too many other things.

>
> Certainly seems like -pipe doesn't make a ton of difference. If this is
> a better fix, I am happy to draft up a proper commit message and send
> it out for review.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 73f4831283ac..672c689c1faa 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -213,8 +213,6 @@ ifdef CONFIG_X86_64
>  KBUILD_LDFLAGS +=3D $(call ld-option, -z max-page-size=3D0x200000)
>  endif
>
> -# Speed up the build
> -KBUILD_CFLAGS +=3D -pipe
>  # Workaround for a gcc prelease that unfortunately was shipped in a suse=
 release
>  KBUILD_CFLAGS +=3D -Wno-sign-compare
>  #
> @@ -239,7 +237,7 @@ archheaders:
>  archmacros:
>         $(Q)$(MAKE) $(build)=3Darch/x86/kernel arch/x86/kernel/macros.s
>
> -ASM_MACRO_FLAGS =3D -Wa,arch/x86/kernel/macros.s -Wa,-
> +ASM_MACRO_FLAGS =3D -Wa,arch/x86/kernel/macros.s
>  export ASM_MACRO_FLAGS
>  KBUILD_CFLAGS +=3D $(ASM_MACRO_FLAGS)
>


--=20
Thanks,
~Nick Desaulniers
