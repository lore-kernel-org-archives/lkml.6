Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A8C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DF22064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="V2uNg7CS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DF22064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeJ2BkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:40:10 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:46007 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ2BkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:40:10 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9SGsn34009985;
        Mon, 29 Oct 2018 01:54:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9SGsn34009985
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540745690;
        bh=cRrPPvaf1GZ+1Lxh56L1YkMQ2Em6HvpMNZC0LYrzlvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V2uNg7CS61CIuFEk5OXtlN8VrIM2RDgFGzRIDSuuj1IwSn7hTC3uRyZbTVKHVj+O6
         yCAJHRNytnQXrf/qOzkwM5T2KEVNSlyuYMeXwvPmBB8t29HCYLuz0zYZqRq/CakYSv
         hOxW45ZlLVi5L1323mcgNN6CpF2CF9nmaezFU1sy+Hicc+bCuhJk52xMwIj+fA0ex2
         fgzzqG28y+fI7SlHzMHDhQcs4PD4iyi1fzf3mp86yOq5HJn/5VRprF2IPrM1mPmz4J
         7HiH+bRVRyb4efc4jGC32dqSJMXioX66nF6T0n+Ih8OGcczH9mqRG1J3nz7nrv+H0r
         cI+AvbY3lD2HA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id 124so3766454vsp.12;
        Sun, 28 Oct 2018 09:54:49 -0700 (PDT)
X-Gm-Message-State: AGRZ1gI7HnZfdmr3cMjhCRezEXGt3khz/GlD6pWv81SSkFKRbVAHbCN1
        0kuKE50Wt/xpcPalvpUrtuNOTjnj4sI0vUYhjLo=
X-Google-Smtp-Source: AJdET5dN9GZ2bAlLFlg1ZCw8lfFQF0o0jrxuuWxiq+wM1Et34ZBIaUc4Irw2jN39/GJgTVpyQg55IxTRTbQMVozgbjU=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr4804635vsb.155.1540745688741;
 Sun, 28 Oct 2018 09:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000809.GA21292@WindFlash> <20181017081115.GA22535@zn.tnic>
 <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
 <20181017083126.GB22535@zn.tnic> <CADvQ+rFa=XEuxLb=yPmtJE2QepBNjCVzjEY5urVzCaSF1tJBYw@mail.gmail.com>
 <20181018091606.GA20831@zn.tnic> <CAK7LNAQq7aE_2QYwqei7M9fg8Yen7-ucjz-t2E_hq2xkznKsQw@mail.gmail.com>
 <7b87404e2a0347968013e024e52e4cb2@AcuMS.aculab.com>
In-Reply-To: <7b87404e2a0347968013e024e52e4cb2@AcuMS.aculab.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 01:54:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=wj9CW+qN4=yCgLuvsJUbyo-5Wq08BnuCkDH4Y82FwA@mail.gmail.com>
Message-ID: <CAK7LNAS=wj9CW+qN4=yCgLuvsJUbyo-5Wq08BnuCkDH4Y82FwA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     David.Laight@aculab.com
Cc:     Borislav Petkov <bp@alien8.de>,
        =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>,
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

On Fri, Oct 19, 2018 at 8:28 PM David Laight <David.Laight@aculab.com> wrot=
e:
>
> From: Masahiro Yamada
> > Sent: 18 October 2018 17:39
> >
> > On Thu, Oct 18, 2018 at 6:18 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Wed, Oct 17, 2018 at 09:40:53PM -0300, Leonardo Bras wrote:
> > > > The idea was to put it as default and fix all the shadowing warning=
s.
> > > > What do you think?  I am open to suggestions.
> > >
> > > That's Masahiro's call. In the rest of the kernel, those warnings are=
 behind
> > > the W=3D2 switch - i.e., not enabled by default.
> >
> >
> > It is not realistic to enable this warning option by default.
> > Even -Wshadow=3Dlocal emits tons of warnings.
> > (More with -Wshadow)
>
> The question is, how many of them are actual bugs.
> IMHO -Wshadow is a good idea.
>
> > The problem of this flag is,
> > it is false positive in macro expansions.
>
> Right, but macro expansions inside macro definitions could accidentally
> use the same local variable - leading to choas.


I do not think so.

The macro definitions are surrounded by { ... }
so that local variables are properly separated from
the outside world.




> > For example, I think the following is a legitimate case.
> ...
> > arch/arm64/kernel/fpsimd.c:713:2: note: in expansion of macro =E2=80=98=
write_sysreg=E2=80=99
> >   write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1)=
;
> >   ^~~~~~~~~~~~
>
> Easily fixed by using different named temporaries in the two macros.
> There probably aren't that many macro pairs where that happens.
> Especially since many are now inlined functions.

But, theoretically, any arbitrary macros could be used in pairs.

This means a new constraint where a local variable name must be unique,
it means 'local variable' is not literally 'local'.


I'd like to use short names such as 'x', 'tmp', etc. for local variables.



> It might be that a small number of changes get rid of most of the warning=
s.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)


--
Best Regards
Masahiro Yamada
