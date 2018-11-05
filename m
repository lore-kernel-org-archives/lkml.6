Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF08AECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957E420827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wIDfBR3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957E420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeKEMSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:18:16 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:63454 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeKEMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:18:16 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA530lfh010732;
        Mon, 5 Nov 2018 12:00:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA530lfh010732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541386848;
        bh=l4y18zLZqDgZFI+jloFmLZDjPOoj279+eEDHAM3k6I8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wIDfBR3a+IKD4VwIawpICb6OuH3lNvagqi6cIPO9vehTf9A6NeTs48He18z50kOyo
         4nq6bPaZZ5RCKj7K0W3zpEqv8yOMG+bcB5U1Tx3DlN1MO9wC6E9YrfIwF4ycTllkaq
         KcrSyheISuznPihuX7hFd/CdpsBNfaOZghC2K749/bh6X88ELGQHaFvR2IXGpQIFYs
         3I72dYLAGOLbvURP7Cm5BsZouSLmEBOZKzGOXhDC5gVJVAryXLrZ37kXAPRvSwIL38
         2nxg3h3cRth3H6yV1l5BJKaJuZ0yhdZa27LlxQxEFNNb2d/rU2drJTBWi6Q5sRuaFz
         sAIAQzzoSYndQ==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id s9so4239669vsk.7;
        Sun, 04 Nov 2018 19:00:48 -0800 (PST)
X-Gm-Message-State: AGRZ1gJVzpIUpuY6QMrOmZ2lJs3KLzS4gqRyISRTy9l16Ca6ARFMPTvC
        FH8dalFAE/Zr7ZXC09Ci7ndtLnNWar0DM4xSXCk=
X-Google-Smtp-Source: AJdET5dCVhgXCG81MmqM2uafb7aXBUwQWwhRnYmIbp+X7J898+av+j2pDQ+38DjMXGs2PJKMDZu9I67mI124L3TcKXQ=
X-Received: by 2002:a67:385a:: with SMTP id f87mr8668695vsa.179.1541386846870;
 Sun, 04 Nov 2018 19:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20181031145907.1ee2e866@canb.auug.org.au> <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
 <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
 <20181101142946.u5luuctqav6fec6k@mail.google.com> <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
 <CAK8P3a1w8p8OC-9_0mtMUxEojvyVfXvF8Ka4J7TnoyZ=gr2Fow@mail.gmail.com>
 <CAK7LNAQp2xU_ThE_q3TmoT16cwUjKx=rB9msVB12+Y9FkaQVmw@mail.gmail.com> <20181104233857.b4ou3b7doclw2vi2@mail.google.com>
In-Reply-To: <20181104233857.b4ou3b7doclw2vi2@mail.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 5 Nov 2018 12:00:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQeHqKQr8puhr=qz9FY9L48_b2uLv5AHWW3M-98b3EunA@mail.gmail.com>
Message-ID: <CAK7LNAQeHqKQr8puhr=qz9FY9L48_b2uLv5AHWW3M-98b3EunA@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 9:54 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Sun, Nov 04, 2018 at 11:43:44AM +0900, Masahiro Yamada wrote:
> > On Sat, Nov 3, 2018 at 12:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On 11/2/18, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > > > On Thu, Nov 1, 2018 at 11:32 PM Changbin Du <changbin.du@gmail.com> wrote:
> > > >> On Thu, Nov 01, 2018 at 12:32:48PM +0900, Masahiro Yamada wrote:
> > > >
> > > > How about clang?
> > > >
> > > > For clang, -Og might be equivalent to -O1 at this moment, but I am not
> > > > sure.
> > > >
> > > > In my understanding, Clang does not inline functions marked with 'static
> > > > inline'
> > > > for -Og (or -O1) optimization level.
> > > >
> > > > Theoretically, 'inline' keyword is a just hint for the compiler, after all.
> > >
> > > I think this means that we cannot build the kernel in that configuration,
> > > at least with CONFIG_OPTIMIZE_INLINING=y. Without that option,
> > > every 'inline' becomes 'always_inline'.
> > >
> >
> > Sorry, I missed that fact.
> >
> >
> > At this moment of time, it is OK given the following:
> >
> >  - CONFIG_OPTIMIZE_INLINING is defined only for x86
> >  - Clang cannot build x86 due to missing asm-goto
> >
> >
> > However, Clang with -Og
> > does not inline even such simple code like this:
> >
> >
> > -----test code------
> > static inline int foo(int x)
> > {
> >         return x;
> > }
> >
> > int bar(int x)
> > {
> >         return foo(x);
> > }
> > -------------------
> >
> >
> >
> > $ clang -Og -c -o bar.o  bar.c
> > $ objdump -d  bar.o
> > bar.o:     file format elf64-x86-64
> >
> >
> > Disassembly of section .text:
> >
> > 0000000000000000 <bar>:
> >    0: eb 0e                jmp    10 <foo>
> >    2: 66 2e 0f 1f 84 00 00 nopw   %cs:0x0(%rax,%rax,1)
> >    9: 00 00 00
> >    c: 0f 1f 40 00          nopl   0x0(%rax)
> >
> > 0000000000000010 <foo>:
> >   10: 89 f8                mov    %edi,%eax
> >   12: c3                    retq
> >
> >
> I see. Thanks for your explanation. So I think we should disable
> CONFIG_DEBUG_EXPERIENCE for clang. Do you know how to distinguish
> different copmilers in Kconfig?
>


You can add 'depends on CC_IS_GCC'
to make sure this option is visible only when you use GCC.


config CC_OPTIMIZE_FOR_DEBUGGING
        bool "Optimize for better debugging experience (-Og)"
        depends on CC_IS_GCC
        depends on $(cc-option,-Og)
        select NO_AUTO_INLINE



--
Best Regards
Masahiro Yamada
