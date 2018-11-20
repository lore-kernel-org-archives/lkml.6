Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF35C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A3B20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ouafSHKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A3B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbeKTLlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:41:02 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50797 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:41:02 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAK1ET1g016562;
        Tue, 20 Nov 2018 10:14:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAK1ET1g016562
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542676470;
        bh=gT6qqQJTo00TYzFc3I9+O0bQgibhkup2JsSvdWR8UTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ouafSHKRg2giMeTOAWdViRDpwg8GBbW6oSPuYQueKmRtMywAkb8HS1yhNftwNaPon
         DlWOjG7htJ9Sly5QE+ejd9FNO7iFyp/IPki+LLHFgolwqHVYJY4MYm5k8IuUp6bODX
         oGpKE2H30LkeH5UDw13SmNRQVnrdSEH+Z/w1Vibywj1a4HeHRRCqiSiDIaPEyl6GZQ
         J39U4egX7zU/gn7AAgN2HCZympB13+q6j5ees812xiG0CzK6dt/WofwQzYUetBjCT/
         mU3NgUKjx7zNkYhYskrruWjlV/2YatQ8m/fQrm43b/zJbIKjH85i8BCqwL7esJg0U9
         atCu4Y8KLAVIw==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id h78so135184vsi.6;
        Mon, 19 Nov 2018 17:14:30 -0800 (PST)
X-Gm-Message-State: AGRZ1gIT+B12xjDB2B444DQ7IBlr0MVsl/MjgeJw7i2P5OPHL4LhSZwt
        /0VPqtEG3WF7fiQ40va48M5S5Nsrn6GwOoSryz8=
X-Google-Smtp-Source: AJdET5cZHPbHKQdH/j/wbKv0BgiBufe33Mw9du1fySdHtNhmitI/v1fKpOMnQWL0OG/vm6oGqFOHeGd/7FPMmNHIdCE=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr10436241vsb.155.1542676469386;
 Mon, 19 Nov 2018 17:14:29 -0800 (PST)
MIME-Version: 1.0
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
 <1542270435-11181-5-git-send-email-yamada.masahiro@socionext.com>
 <nycvar.YSQ.7.76.1811152346510.1993@knanqh.ubzr> <CAK7LNATT7PYvH-z572MGSjXbCybAW0TcNebz9CgGM4J07aMOvw@mail.gmail.com>
 <nycvar.YSQ.7.76.1811161234160.1993@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1811161234160.1993@knanqh.ubzr>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 20 Nov 2018 10:13:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvZZa-RgLCs9hwwgwrH-frxL6H1a3=BQzHmVqX6sPhTw@mail.gmail.com>
Message-ID: <CAK7LNARvZZa-RgLCs9hwwgwrH-frxL6H1a3=BQzHmVqX6sPhTw@mail.gmail.com>
Subject: Re: [PATCH 4/8] kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,


On Sat, Nov 17, 2018 at 2:50 AM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> > > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > > index 7f3ca6e..e5ba9b1 100644
> > > > --- a/scripts/Makefile.build
> > > > +++ b/scripts/Makefile.build
> > > > @@ -254,9 +254,18 @@ objtool_dep = $(objtool_obj)                                     \
> > > >             $(wildcard include/config/orc/unwinder.h          \
> > > >                        include/config/stack/validation.h)
> > > >
> > > > +ifdef CONFIG_TRIM_UNUSED_KSYMS
> > > > +cmd_gen_ksymdeps = \
> > > > +     $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ > $(dot-target).tmp; \
> > > > +     cat $(dot-target).tmp >> $(dot-target).cmd; \
> > > > +     rm -f $(dot-target).tmp;
> > >
> > > Why don't you append to $(dot-target).cmd directly?
> >
> >
> > If scripts/gen_ksymdeps.sh fails for some reasons,
> > it will error out immediately thanks to 'set -e' flag.
> >
> > Appending incomplete portion might end up with a corrupted .*.cmd file.
> >
> > Probably, that would not happen, but I just wanted to ensure it.
>
> Well, strictly speaking, if scripts/gen_ksymdeps.sh fails and its output
> isn't appended at all to the .*.cmd file, then that .*.cmd file is
> already corrupted as it is missing necessary dependencies. Would be
> better to delete the .*.cmd file entirely in that case.


More strictly speaking, missing necessary dependencies is not a big deal.

Now, scripts/Kbuild.include specifies .DELETE_ON_ERROR

Any error in fixdep, gen_ksymdeps.sh, or whatever
will delete *.o file anyway.

So, I change the course
so that fixdep and gen_ksymdeps.sh directly write to .*.cmd files.


I wrote detailed explanation here:
https://patchwork.kernel.org/patch/10689697/




-- 
Best Regards
Masahiro Yamada
