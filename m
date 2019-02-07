Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE9EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407B1217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpasLCWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfBGAz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:55:28 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51399 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBGAz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:55:28 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so10788531ite.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 16:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Lov9nwxlOdWod6EArPtFnQFJ1E4ZIH+d/2AoOUMndM=;
        b=MpasLCWU8iEJGLfV9+tlEmLsld+KBNxur/Jp1Lwwsh6P10lvLr+HHLYdfha3rgWeGC
         tFp5f2GsKFfcPj5+fkKE4xYjezGVDMJVVMGFDb64/7f1TJFW/rga8pL5IGPtj4T/Qgqk
         ggtIDIHWXtDw0j1BWTUR01JYoacPmH8u/Q75TFlO6Q1mJzL4SSJtKq6ShU0231JJLLLz
         mlHNbv06f9gx1bNaWqhhQJIk34mfkGitawwWDCZh83JdI5eXnVyXajq0LVQtBWRCQmNQ
         x7E24Z6Wa9MLWVllYNuHslnP5WEVZ1QXHVAtTPz4pn3WeaGdBJrw8T/0d+++QyZ1U82N
         x3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Lov9nwxlOdWod6EArPtFnQFJ1E4ZIH+d/2AoOUMndM=;
        b=bA4Snp4uN+phYjN5DPIAIp/iz72bZiSEHNud4fKa/h9MUOlxhQyxYYPtdLM+QCOY73
         S383mBkF0W7OKdY3p07tL31XVrQxR2soTaGkExVNatZLIz9p8su9GvVFK6VoGzLonKiS
         Hf2qGZVLo1lfJwyfj3cqZa3/+x+I4E7u0Ex83/r/miUHF9BQxKIC6Xjgld5J1FBClQT+
         qW3HtH60STm0i0MNoJm3Qti1iDJYMuLCFad4gxJUPXgKMK+v/lmXmM7nF8YLsTFT2t1u
         Z+sZeUxzzBpj0K9vKxGJUz8V38sxrN2YLzl3mM/S+1OwzMOVlHxQ9lpxB5vo6bh3bvmj
         d6lg==
X-Gm-Message-State: AHQUAuZKQUhpuEIUtl7Gk16eKUv1oYe1qDOuorJzyQxZP+qBmoiSxBYR
        y40Zg+bySRBUw92Ud41lwgElK2ECChK5eZCYQffnVA==
X-Google-Smtp-Source: AHgI3IbxTN/2IihkIw49Uv2p+Kxl16HLKscRKb7Ve3nj3mwsFNgly+dEoGBt5xK+bpp7AeXWJ/RTo0T4JPOZDXrHjPk=
X-Received: by 2002:a02:910a:: with SMTP id a10mr7411924jag.116.1549500926579;
 Wed, 06 Feb 2019 16:55:26 -0800 (PST)
MIME-Version: 1.0
References: <1547706826-16833-1-git-send-email-yamada.masahiro@socionext.com> <CAKwvOdkzSTyiiBmpwGFj6K=1Ang6nsVVahaQstk_GkPAcyBZOg@mail.gmail.com>
In-Reply-To: <CAKwvOdkzSTyiiBmpwGFj6K=1Ang6nsVVahaQstk_GkPAcyBZOg@mail.gmail.com>
From:   Jordan Rupprecht <rupprecht@google.com>
Date:   Wed, 6 Feb 2019 16:54:58 -0800
Message-ID: <CABC7LbQSxB=WuUz22uunWW=YahNd2-By8LKxLcZYo0L17P---A@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: support llvm-ar
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000582e2b0581434cbd"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000582e2b0581434cbd
Content-Type: text/plain; charset="UTF-8"

I have a patch up for review that fixes the second case of chopping
off the directory when nesting thin archives:
https://reviews.llvm.org/D57842. I'll commit it tomorrow if there are
no more comments.

I was looking at the first case of supporting the P modifier, and
found that, as implemented (with D57842 patched in), llvm-ar now seems
to work as if P is the default in some cases, e.g. with your initial
test case:
  $ gcc -c -x c /dev/null -o foo.o
  $ mkdir a
  $ gcc -c -x c /dev/null -o a/foo.o
  $ ar rcST a/built-in.a a/foo.o
  $ rm -f built-in.a && ar rcST built-in.a a/built-in.a foo.o && cat built-in.a
!<thin>
//                                              8         `
foo.o/

/0              0           0     0     644     920       `
  $ rm -f built-in.a && llvm-ar rcST built-in.a a/built-in.a foo.o &&
cat built-in.a
!<thin>
//                                              16        `
a/foo.o/
foo.o/
/0              0           0     0     644     920       `
/9              0           0     0     644     920       `

It didn't work like that universally -- deleting archive members
doesn't work as expected -- so I'll have to do some more
investigation.
Anyway, once D57842 is committed (or if you want to patch it locally),
you *should* be able to reduce the llvm-ar special fix to just not
pass the P modifier, until we accept it.

On Thu, Jan 17, 2019 at 1:55 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jan 16, 2019 at 10:34 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > I want to avoid applying this patch because this patch is ugly, and
> > people are trying to fix llvm-ar. I tried the latest llvm-ar, and I
> > saw some improvement, but still cannot build the kernel with it.
> >
> > The main reason of this post is for the record, and suggest how llvm-ar
> > should work.
> >
> > As you may have noticed, there are two issues:
> >
> >  [1] llvm-ar does not recognize the 'P' option
> >  [2] llvm-ar does not flatten thin archives (not fixed yet)
> >
> > Let me explain each of them.
> >
> > [1] Why is 'P' option needed for GNU ar?
> >
> > It may not be so clear the reason of commit 9a6cfca4f413 ("kbuild:
> > thin archives use P option to ar").
> >
> > If two objects from different directories have the same file name,
> > GNU ar may drop the one when flattening thin archives.
> >
> > Here is a simple test case:
> >
> >   $ gcc -c -x c /dev/null -o foo.o
> >   $ mkdir a
> >   $ gcc -c -x c /dev/null -o a/foo.o
> >   $ ar rcST a/built-in.a a/foo.o
> >   $ ar rcST built-in.a a/built-in.a foo.o
> >   $ cat built-in.a
> >   !<thin>
> >   //                                              8         `
> >   foo.o/
> >
> >   /0              0           0     0     644     944       `
> >
> > We expect built-in.a contains both a/foo.o and foo.o, but the former
> > is lost. The 'P' option solves this.
> >
> >   $ rm -f built-in.a
> >   $ ar rcSTP built-in.a a/built-in.a foo.o
> >   $ cat built-in.a
> >   !<thin>
> >   //                                              16        `
> >   a/foo.o/
> >   foo.o/
> >   /0              0           0     0     644     944       `
> >   /9              0           0     0     644     944       `
> >
> > Interestingly, GNU ar works as expected without 'P' when the order of
> > a/built-in.a and foo.o are opposite:
> >
> >   $ rm built-in.a
> >   $ ar rcST built-in.a foo.o a/built-in.a
> >   $ cat built-in.a
> >   !<thin>
> >   //                                              16        `
> >   foo.o/
> >   a/foo.o/
> >   /0              0           0     0     644     944       `
> >   /7              0           0     0     644     944       `
> >
> > Anyway, even the latest GNU toolchain works like that, so
> > Kbuild does need the 'P' option.
> >
> > The real world example is sh.
> >
> >   arch/sh/kernel/cpu/fpu.c
> >   arch/sh/kernel/cpu/sh2a/fpu.c
> >   arch/sh/kernel/cpu/sh4/fpu.c
> >   arch/sh/kernel/cpu/sh5/fpu.c
> >
> > [2] flattening thin archives
> >
> > llvm-ar cannot flatten archives.
> >
> > This issue was filed in the following:
> >   https://bugs.llvm.org/show_bug.cgi?id=37530
> >
> > Its status was marked as "RESOLVED FIXED", but actually not fixed
> > as of writing (Jan 17, 2019).
> >
> > The older version of llvm-ar worked like this:
> >
> >   $ rm -f built-in.a a/built-in.a
> >   $ llvm-ar rcST a/built-in.a a/foo.o
> >   $ llvm-ar rcST built-in.a a/built-in.a
> >   $ cat built-in.a !<thin>
> >   //                                              14        `
> >   a/built-in.a/
> >   /0              0           0     0     644     136       `
> >
> > Recently, two commits were pushed to the trunk.
> >   [llvm-ar] Flatten thin archives.
> >   [llvm-ar] Resubmit recursive thin archive test with fix for full path names and better error messages
> >
> > As far as I tested, the latest llvm-ar works as follows:
> >
> >   $ llvm-ar rcST a/built-in.a a/foo.o
> >   $ llvm-ar rcST built-in.a a/built-in.a
> >   $ cat built-in.a
> >   !<thin>
> >   //                                              8         `
> >   foo.o/
> >
> >   /0              0           0     0     644     800       `
> >
> > OK, it flattens the thin archive, but the problem is it rips off
> > the directory path.
> >
> > GNU ar works as follows:
> >
> >   $ ar rcST   a/built-in.a   a/foo.o
> >   $ ar rcST    built-in.a a/built-in.a
> >   $ cat built-in.a
> >   !<thin>
> >   //                                              10        `
> >   a/foo.o/
> >
> >   /0              0           0     0     644     800       `
> >
> > If you use the latest llvm-ar for building the kernel, you will see
> > a mysterious 'llvm-ar: error: No such file or directory.' error.
> > (I think the error message could be improved because it is unclear
> > what is missing.)
> >
> > [Workaround in this patch]
> >
> > Currently, llvm-ar cannot flatten thin archives correctly. So, Kbuild
> > uses '$(AR) t' to expand thin archives from subdirectories, then repack
> > all objects into the current directory built-in.a.
> >
> > The 'P' for cmd_link_l_target is unneeded because Kbuild does not
> > support subdir objects for lib-y in the first place.
> >
> > [How to use]
> >
> > Pass AR=llvm-ar in the configuration and build command:
> >
> >  $ make AR=llvm-ar defconfig
> >  $ make AR=llvm-ar
> >
> > Or, simply in one line:
> >
> >  $ make AR=llvm-ar defconfig all
>
> Thank you Masahiro for the excellent feedback on what's missing with
> llvm-ar.  I will work with Jordan (cc'ed) to sort out these remaining
> issues.  I think we should do our best to fix these in llvm-ar to the
> extent possible, before modifying Kbuild to support it.
>
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> For the above reason;
> Nacked-by: Nick Desaulniers <ndesaulniers@google.com>
> to prevent this from going in before we've had time to address the
> feedback from this patch in llvm-ar.  There's no rush to support
> llvm-ar, so I'd like to not burden the kernel with these changes.  But
> we will keep this patch in our backpocket should we determine that we
> cannot meet compatibility with binutils ar.
>
> > ---
> >
> > This patch can be cleanly applied to Linux 5.0-rc2 + the following:
> > https://patchwork.kernel.org/patch/10761625/
> > https://patchwork.kernel.org/patch/10767193/
> > https://patchwork.kernel.org/patch/10767195/
> > https://patchwork.kernel.org/patch/10767503/
> > https://patchwork.kernel.org/patch/10767509/
> >
> >
> >  init/Kconfig           | 3 +++
> >  scripts/Makefile.build | 8 +++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 513fa54..185274ac 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -23,6 +23,9 @@ config CLANG_VERSION
> >         int
> >         default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
> >
> > +config AR_IS_LLVM
> > +       def_bool $(success,$(AR) --version | head -n 1 | grep -q LLVM)
> > +
> >  config CC_HAS_ASM_GOTO
> >         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index f8e2794..b866bb5 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -399,7 +399,13 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
> >  ifdef builtin-target
> >
> >  quiet_cmd_ar_builtin = AR      $@
> > +ifdef CONFIG_AR_IS_LLVM
> > +      cmd_ar_builtin = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS) $@ \
> > +                      $(foreach f, $(real-prereqs), \
> > +                      $(if $(filter $(subdir-obj-y), $(f)), $(shell $(AR) t $(f)), $(f)))
> > +else
> >        cmd_ar_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> > +endif
> >
> >  $(builtin-target): $(real-obj-y) FORCE
> >         $(call if_changed,ar_builtin)
> > @@ -427,7 +433,7 @@ ifdef lib-target
> >  quiet_cmd_link_l_target = AR      $@
> >
> >  # lib target archives do get a symbol table and index
> > -cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> > +cmd_link_l_target = rm -f $@; $(AR) rcsT$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> >
> >  $(lib-target): $(lib-y) FORCE
> >         $(call if_changed,link_l_target)
> > --
> > 2.7.4
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers

--000000000000582e2b0581434cbd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7QYJKoZIhvcNAQcCoIIS3jCCEtoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBTMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
QAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWlt
ZWNhMS5jcnQwHQYDVR0OBBYEFEzRyLdWAOnD/r5t2oxq71oqZrNuMB8GA1UdIwQYMBaAFMs4ErDH
mcB4koyzIZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQBJgcZICXH9
7aPN8CWWfdcTGvINItDpd2QzUxJ1QgRSypCd0qXBevDhmEyJiSe2yK3G9ZTjxdY3jweCFpmNoaSG
exz1OSbBBkqR4yVvoaU7vTGg/h7aE0B38UdyLSQpjMaaj/m62h1uZPDFLpzm0W3ZHXvVgcElmR6P
2E3v71/17oqehAv6tOyHq4qpghOkAWbGTS0lArjiRSkP5AtKQHaDqmrUSekn4bO1sx4GcS8C+oWP
tcQ9TZC94SbqpVBmGV0lm58buObjoGy/YDIuffcRzv2edbQRwJ7iFlfGatsbgalYzfRTRNS56BOm
GpqFnR+eKUmZe66ThjUoY1QtIKVjMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIM
Z45BjBNFrislm5V5MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDzESkY0Ugd723j
OGEj5g/PQevCiUzpubgXodaq4kB8ETAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xOTAyMDcwMDU1MjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALA/DtgpB0vhz15PjVU5H/s39mUWkRYCK
zgOioSgKbclKqDkal4BG/i2kNLtg7g/+qVWZI/56/gzFxzKuE8rtNdI86irqds0yVtbISKSwG1Wm
r9MdzliT6yfDr9WS8Xc6XuLc+FDCrtzmhmGHPHpGoVQNxvInn3Qnv1JyggxHe/aI7d3DL8kFwjWn
60KM4cFoviv4c5oGVliw1NdUg8Yenz34pc1tOSeCdwPUZLtGU5L1Is8frIGjoL0KzgzcxVHM6GpZ
ZNddx1TUsmK083dHXwrkVeP0PQbiEq5B6J1/ZHi26Moc+KtgMOkkEqlqN4oqR86cwMyFq9XGw/hV
gjEuGw==
--000000000000582e2b0581434cbd--
