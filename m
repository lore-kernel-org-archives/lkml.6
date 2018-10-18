Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69966C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302E521476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Yzrf3qjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302E521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeJSAlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:41:51 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62240 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSAlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:41:51 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w9IGdwgB003597;
        Fri, 19 Oct 2018 01:39:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9IGdwgB003597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539880799;
        bh=pEqnXhckKbCXBfOtdr1rIgOoYc5/TlciIhzPLhBqPvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yzrf3qjwiri4uFX0mhCKeKIfnRxmdDweaIe8kR8Hr5Rr8tqXIE/ao7OpPVJVLvECl
         iZ2kHXTf7pVGfTr3OFeCYN3GYOy/FdAMpYgZpJPIttn6mDkPqNzymUnKmV16xWrwNq
         OvedemmL5XHDcelGjs/FF8/AehNriG7nAeM/DpXY642RTDGflwxNRj1Z8DWhIVQ0aL
         uAToWjCv7c47LMzwGtDsmgPcshk6NuYCimywwKj1hOfD4x8CbJAoxlqA3xODN807PO
         lZ0VmfxbaFZIB0EQP7If/mu4I73M5YXWeJtKi8tgwuh5rWpwlzfd2L1/wyCi1vFJVB
         4ZBym+RppO/5g==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id y195so7729054vsc.7;
        Thu, 18 Oct 2018 09:39:58 -0700 (PDT)
X-Gm-Message-State: ABuFfojnUqWKXrHKv9V2pIOgW4ZB8WVmbv8CR+9ZRt6C5Y9SchBIsclG
        wc8UurUonhMCVcrHXYq4N694BuAurMYcr1ZZGWM=
X-Google-Smtp-Source: ACcGV61y5Z8bvbptGZ1yatA34E+5p2mQXilvnEHrN15suoBek2UUjmwvin97tv2z2vQ6HU6NHAO87n5v3TsxothA7LE=
X-Received: by 2002:a67:65c3:: with SMTP id z186mr13217613vsb.54.1539880797659;
 Thu, 18 Oct 2018 09:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000809.GA21292@WindFlash> <20181017081115.GA22535@zn.tnic>
 <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
 <20181017083126.GB22535@zn.tnic> <CADvQ+rFa=XEuxLb=yPmtJE2QepBNjCVzjEY5urVzCaSF1tJBYw@mail.gmail.com>
 <20181018091606.GA20831@zn.tnic>
In-Reply-To: <20181018091606.GA20831@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 01:39:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQq7aE_2QYwqei7M9fg8Yen7-ucjz-t2E_hq2xkznKsQw@mail.gmail.com>
Message-ID: <CAK7LNAQq7aE_2QYwqei7M9fg8Yen7-ucjz-t2E_hq2xkznKsQw@mail.gmail.com>
Subject: Re: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 6:18 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 17, 2018 at 09:40:53PM -0300, Leonardo Bras wrote:
> > The idea was to put it as default and fix all the shadowing warnings.
> > What do you think?  I am open to suggestions.
>
> That's Masahiro's call. In the rest of the kernel, those warnings are beh=
ind
> the W=3D2 switch - i.e., not enabled by default.


It is not realistic to enable this warning option by default.
Even -Wshadow=3Dlocal emits tons of warnings.
(More with -Wshadow)

The problem of this flag is,
it is false positive in macro expansions.


For example, I think the following is a legitimate case.



In file included from ./arch/arm64/include/asm/cputype.h:126:0,
                 from ./arch/arm64/include/asm/cache.h:19,
                 from ./include/linux/cache.h:6,
                 from ./include/linux/printk.h:9,
                 from ./include/linux/kernel.h:14,
                 from ./include/linux/bitmap.h:10,
                 from arch/arm64/kernel/fpsimd.c:20:
arch/arm64/kernel/fpsimd.c: In function =E2=80=98sve_kernel_enable=E2=80=99=
:
./arch/arm64/include/asm/sysreg.h:707:6: warning: declaration of
=E2=80=98__val=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-loc=
al]
  u64 __val;      \
      ^
./arch/arm64/include/asm/sysreg.h:717:20: note: in definition of macro
=E2=80=98write_sysreg=E2=80=99
  u64 __val =3D (u64)(v);     \
                    ^
arch/arm64/kernel/fpsimd.c:713:15: note: in expansion of macro =E2=80=98rea=
d_sysreg=E2=80=99
  write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1);
               ^~~~~~~~~~~
./arch/arm64/include/asm/sysreg.h:717:6: note: shadowed declaration is here
  u64 __val =3D (u64)(v);     \
      ^
arch/arm64/kernel/fpsimd.c:713:2: note: in expansion of macro =E2=80=98writ=
e_sysreg=E2=80=99
  write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1);
  ^~~~~~~~~~~~




--
Best Regards
Masahiro Yamada
