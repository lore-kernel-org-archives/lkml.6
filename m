Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CCEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728A020671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auQUjqbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728A020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeJXDFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:05:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37701 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:05:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh10-v6so1043684plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pXsCxTAkx2jrfCYySg/rQW7IAaA9rGO09Q12oVsa3SY=;
        b=auQUjqbL/lpn3x8yhozTQAp5ADEi0+DsOVu+4X6GO53U8GlGewGtyNk1VJrs7HnmDs
         AMo+1BShKXfJJTEgSfG4LsAFQSTmrCyQ2V2F4i5stWdHhfqd2C4ydzwrtog4fKdG25ja
         0IfC4YJ2bTg2IZbcu8Eqagt/HPe4Trn31oNLx/Q7SPC4dOg5hpwNkVF8KLjVa/EwP1l3
         seYJdg0cOpOUhKi9bUQiMgzKSQ4JPG2aeoBK5N4yaRV559t3KwWsisEYjNUaxhN9cE1O
         pAbjF5mAacqbEH+Z3yxuAPJc1YSKvfpl0drQ0RNCsB6oHyeF2cnXQDeXpls4TSy8REky
         aGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pXsCxTAkx2jrfCYySg/rQW7IAaA9rGO09Q12oVsa3SY=;
        b=Kr/Vbzgc2ljvuLjPfMe7jthVqD/FgasQX6Pa2Hb9kpX9T3gSi79NvsJ5woEQn1reF9
         XAnq91lyuexNeWy7+PdHJHSE+92rjG/Em6VTGug7pwmLSNLvIqmdf+pE4Kag+AZQdpCa
         XGlXqL4YIrVDoLEt2+qSfNa/gT1lOVJJ72uCny2GAf7a+nxIQ3rtEuDSdp1KtWG4YeCv
         jPkg7mC8prIbt2IyYMp8W3XaB7pg5mbSUcDd1ZhZt/ui5cpEvShd4CBHPux26Cumeq3e
         eU4pnCEzj7XrLeC4X/mDXOAKW0ooq1NY+KefSHjUUWuXRT5aaH8IAN046cMK8Q2xxd38
         U+ug==
X-Gm-Message-State: AGRZ1gJuOLb4wTdwJCmkeK7AetkSUDX4bEInBOyqctycwaM7wSOB50HT
        A3cFLpNEOvZc5emr6XIFXYxV3b13GnOXCRCBpTSVWA==
X-Google-Smtp-Source: AJdET5c9rxqFbITrWT2gGwa1y5mA/tx6/ZX3kLTN3Lm1HLUu4D5N4llmrbPqtwHel2lpXZmptxbooGNm4xlrwibOELc=
X-Received: by 2002:a17:902:b106:: with SMTP id q6-v6mr5713271plr.238.1540320048944;
 Tue, 23 Oct 2018 11:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181023003725.21463-1-natechancellor@gmail.com> <F3BBC06A-A9CB-4ABF-ADF4-6B0971FAE364@vmware.com>
In-Reply-To: <F3BBC06A-A9CB-4ABF-ADF4-6B0971FAE364@vmware.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Oct 2018 11:40:37 -0700
Message-ID: <CAKwvOdmsKbW9v9or+u-W9V7T+LrF4ODY9cgUStkjkmsbMcqJ2g@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: Don't include '-Wa,-' when building with Clang
To:     namit@vmware.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 10:11 PM Nadav Amit <namit@vmware.com> wrote:
>
> at 5:37 PM, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
> inline assembly code to work around asm() related GCC inlining bugs")
> added this flag to KBUILD_CFLAGS, where it works perfectly fine with
> GCC. However, when building with Clang, all of the object files compile
> fine but the build hangs indefinitely at init/main.o, right before the
> linking stage. Don't include this flag when building with Clang.
>
> The kernel builds and boots to a shell in QEMU with both GCC and Clang
> with this patch applied.
>
> Link: https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
github.com%2FClangBuiltLinux%2Flinux%2Fissues%2F213&amp;data=3D02%7C01%7Cna=
mit%40vmware.com%7C871daebc2ca44947d28d08d638811fb5%7Cb39138ca3cee4b4aa4d6c=
d83d9dd62f0%7C1%7C0%7C636758524579997650&amp;sdata=3DshuxW81QRrO3TSqbgf462w=
gZYdLeAKeQEdGRxmnUX30%3D&amp;reserved=3D0
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> The reason this patch is labeled RFC is while I can verify that this
> fixes the issue, I'm not entirely sure why the '-Wa,-' works for GCC
> and not Clang. I looked into what the flag means and I couldn't really
> find anything so I just assume it's taking input from stdin? The issue
> could stem from how GCC forks gas versus how Clang does it. If this
> isn't of concern and the maintainers are happy with this patch as is,
> feel free to take it.
>
> arch/x86/Makefile | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 5b562e464009..4736dcc1caec 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -239,7 +239,10 @@ archheaders:
> archmacros:
> $(Q)$(MAKE) $(build)=3Darch/x86/kernel arch/x86/kernel/macros.s
>
> -ASM_MACRO_FLAGS =3D -Wa,arch/x86/kernel/macros.s -Wa,-
> +ASM_MACRO_FLAGS =3D -Wa,arch/x86/kernel/macros.s
> +ifneq ($(cc-name),clang)
> +ASM_MACRO_FLAGS +=3D -Wa,-
> +endif
> export ASM_MACRO_FLAGS
> KBUILD_CFLAGS +=3D $(ASM_MACRO_FLAGS)
>
>
> The '-Wa,-=E2=80=98 was indeed used to take the input from stdin when the=
 =E2=80=98-pipe=E2=80=99
> option is used in GCC. Perhaps clang ignores the =E2=80=98-pipe=E2=80=99 =
flag.
>

Clang documents support for `-pipe`.
https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-=
pipe

$ clang hello_world.c -no-integrated-as -Wa,-

is simple enough to reproduce the hang (notice no `-pipe`).
`strace`'ing the above with and without `-Wa,-` shows clang hung in a
`wait4` call after spawning as, while without `-Wa,-` shows it
receiving a SIGCHLD.

I've filed a bug against Clang to investigate:
https://bugs.llvm.org/show_bug.cgi?id=3D39410

In the meantime, I think Nathan's patch is the correct way to work
around this, if it is indeed a bug in Clang.

Reviewed-and-Tested-by: Nick Desaulniers <ndesaulniers@google.com>

https://stackoverflow.com/questions/1512933/when-should-i-use-gccs-pipe-opt=
ion
has some interesting perspectives on the use of `-pipe`.
Thanks for the patch Nathan, and more info Nadav.
--=20
Thanks,
~Nick Desaulniers
