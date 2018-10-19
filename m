Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F85EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C86E21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jeJdb+Mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C86E21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJSOKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:10:04 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:48608 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeJSOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:10:04 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9J64xVE024994;
        Fri, 19 Oct 2018 15:04:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9J64xVE024994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539929100;
        bh=NebpCWCqr7DQIEPUYzqhx5zvCquykSJJqugc2tXqqGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jeJdb+MpZdcAkZndTyNa45RYkPe/oFMUWsTpPBi6fW2c34eFkGHs59OFcFmDdpV2W
         8SvRvo5CRPdK2ehXz8ugsIXc9kh4Hv9GzYFvuuGrsVYG5MdGyBkA7f8MU4kAqQ+M1f
         ygBWKygDPGWP+hC6IL2sp7u9Wgmhkm4WFmJh3mD8GY4OTwJbWZHG/Id5p3EBwYd5nG
         pVGjHlVFKow5n5hh4iXYNMoJnlYbA4lgtCFCiet+HOiKTXMe/xfh0k8UoyTJ625keJ
         /xNyxhf4gRKWioSCjSnkAlj8oUYUnr4mB+AjXEwlfyLWcMwru7e3KOazZL0NEulUGa
         3iicWNVQh/FVw==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id i30so5555645uae.11;
        Thu, 18 Oct 2018 23:04:59 -0700 (PDT)
X-Gm-Message-State: ABuFfojUzgM8rFKMy9g1gBgJ0APp3y1zn5af0QAGK1ggRBqbqlAEFBB0
        boURJkmF17rD19zLFMYQbApaL7OveUmSFDkec3Q=
X-Google-Smtp-Source: ACcGV63I/HGsVjvW14jA0Ld7t6IFv8J3pCcOgGCe+5rDwyFDcEVMIM/4gjAzfNyb3DtfDcyMFYYcU+HuhzjaTtWz4oQ=
X-Received: by 2002:ab0:4e8b:: with SMTP id l11mr15285884uah.93.1539929098620;
 Thu, 18 Oct 2018 23:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
 <1539681053-24388-3-git-send-email-yamada.masahiro@socionext.com>
 <20181016142540.pxlwu3ft6n2b4pgj@treble> <CAK7LNARLW4NmeY0Rq19Bj_5kOFbp6YDtsUDhNaAfVXjL85cAMg@mail.gmail.com>
 <20181016161536.pnek3dnyem6mspwr@treble>
In-Reply-To: <20181016161536.pnek3dnyem6mspwr@treble>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 15:04:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjcmdHx-ZYuGQBV7WckVPS-3Rp7gmjx5r7yyp3bOc_Sw@mail.gmail.com>
Message-ID: <CAK7LNASjcmdHx-ZYuGQBV7WckVPS-3Rp7gmjx5r7yyp3bOc_Sw@mail.gmail.com>
Subject: Re: [PATCH 2/3] objtool: move libelf check out of top Makefile
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,


On Wed, Oct 17, 2018 at 1:16 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Oct 17, 2018 at 12:51:40AM +0900, Masahiro Yamada wrote:
> > > ifdef CONFIG_UNWINDER_ORC
> > >
> > > chk_unwinder_orc = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
> > > msg_unwinder_orc = "Cannot build objtool to generate ORC metadata for CONFIG_UNWINDER_ORC=y.  " \
> > >                        "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> > > toolcheck-$(CONFIG_UNWINDER_ORC) += unwinder_orc
> > >
> > > else
> > >
> > > chk_stack_validation = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
> > > msg_stack_validation = "Cannot build objtool for CONFIG_STACK_VALIDATION=y.  " \
> > >                        "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> > > toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation
> > >
> > > endif
> > >
> > >
> > > What do you think?
> >
> >
> > It is ugly.
> >
> > Do you need such detailed information like ORC metadata stuff here?
> >
> > This Makefile aims to error out, showing why the build failed.
> > That's it.
>
> Yeah, it is kind of ugly.  But the "showing why the build failed" part
> is important.  I was trying to give the user a clear error message,
> similar to what we have today.
>
> Without context, the user won't know what objtool is, or why it needs to
> be built.
>
> If we have just a single error message for all cases, it should at least
> mention the config option.  Like
>
>    "Cannot build objtool for CONFIG_STACK_VALIDATION."
>
> But then, most users will only have that enabled because of ORC.  So an
> ORC-specific message would be more appropriate in most cases.
>
> So maybe it can just be something more vague:
>
> msg_stack_validation = "Cannot build objtool for CONFIG_UNWINDER_ORC and/or CONFIG_STACK_VALIDATION.  " \
>                        "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
>
> That would probably be good enough.  Then we could drop the ugly ifdef.


Fair point, but I am confused by the current
STACK_VALIDATION / UNWINDER_ORC logic.

In my understanding, objtool is
an all-in-one object check/manipulation tool.

STACK_VALIDATION and UNWINDER_ORC
is a selection of a sub-command, 'check' or 'orc generate'.

(Correct me if am wrong.)


However, STACK_VALIDATION is still used to
decide whether or not to compile the objtool.


Adding a new symbol OBJTOOL would clarify the logic.



config OBJTOOL
        bool

config STACK_VALIDATION
        bool "Compile-time stack metadata validation"
        depends on HAVE_STACK_VALIDATION
        select OBJTOOL
        ...


config UNWINDER_ORC
        bool "ORC unwinder"
        depends on X86_64
        select OBJTOOL
        ...




-- 
Best Regards
Masahiro Yamada
