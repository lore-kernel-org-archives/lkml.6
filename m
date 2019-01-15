Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE83AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B120675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CkoXq0Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfAOPBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:01:53 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23066 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfAOPBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:01:52 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x0FF1iT9020398;
        Wed, 16 Jan 2019 00:01:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0FF1iT9020398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547564505;
        bh=ORvUJeYfdFDrcDEJahOg9VUCtLZ2xiu2Oy8mXwaaIds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CkoXq0AlQFcK1L0PN0tH0nyfP75iEVVxlzJvrfq2DzwFQd+amiOZ5uoqkKsYVubRq
         T0D9c66F6WzDaymeq7pRw64GMJY0GiU0nmPBsZgB1w3av8FeihesqQ0LIBfyrLOWKb
         0eq8z90Nud32hBdZuxEN9LrPyptjh0o1d10XE8LJ0mCXOM+ywzAB21xw1UcbzZcJLe
         hdQciUUPrmAScpxNrBSZxk/cEtZ9NPbpWQpFr3KJlyKlERzZkxKpcW6O2Q7YoQSVKN
         Dkt8sciIQ+8iCYqOEmUc+GkKGubIQsSpCzumPuAGYdCFgHKlXr7oII91VELxEjp+St
         9ZkaimboShrVA==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id d201so669939vka.0;
        Tue, 15 Jan 2019 07:01:45 -0800 (PST)
X-Gm-Message-State: AJcUukdogegZU6Sh5p3V6TqA6p/V1vyNTouyCT20RMTZKTb1pkIe1jvd
        qyoj2eZMmlU/RV92MYBCxHPde1sWphXk4rIEdeU=
X-Google-Smtp-Source: ALg8bN4YfC6UsLXiw39L4cdipSwrzdTR3i5ZeLonmxft1fWewN9xTwsZCNcM6LLWFXGv7Z5sLmjNdW33vmmneD91rKI=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr1614598vkd.74.1547564504148;
 Tue, 15 Jan 2019 07:01:44 -0800 (PST)
MIME-Version: 1.0
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com> <54f84ad6-279f-aa64-8c2c-59becd64a6ad@ozlabs.ru>
In-Reply-To: <54f84ad6-279f-aa64-8c2c-59becd64a6ad@ozlabs.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 16 Jan 2019 00:01:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8xkZCK5keS9SEdNTUsVRb+_hac4yvBG=1HebrkheAqw@mail.gmail.com>
Message-ID: <CAK7LNAS8xkZCK5keS9SEdNTUsVRb+_hac4yvBG=1HebrkheAqw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module build
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:45 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 15/01/2019 18:19, Masahiro Yamada wrote:
> > Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
> > caused kernel panic on PowerPC if an external module is used with
> > CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
> > for the external module build.
> >
> > Commit e07db28eea38 ("kbuild: fix single target build for external
> > module") turned it into a build error because the 'prepare' target is
> > now executed but the 'prepare0' target is missing for the external
> > module build.
> >
> > External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
> > also broken in the same way.
> >
> > Move 'PHONY += prepare0' to the common place. Make is fine with missing
> > rule for phony targets.
> >
> > I minimize the change so it can be easily backported to 4.20.x
> >
> > To fix v4.20 for external modules of PowerPC, please backport
> > e07db28eea38 ("kbuild: fix single target build for external module"),
> > and then this commit.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
> > Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
> > Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
> > Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
> > Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
> > Cc: linux-stable <stable@vger.kernel.org> # v4.20
> > Reported-by: Samuel Holland <samuel@sholland.org>
> > Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Thanks for fixing this! Out of curiosity - how does this work?
> arch/powerpc/Makefile's stack_protector_prepare still depends on
> prepare0 which is still defined only if KBUILD_EXTMOD=="" but somehow it
> does not bother ./Makefile? Thanks,


Missing phony targets are ignored.


I do not know if it is officially documented,
but GNU Make works like that.

Is the following test code helpful?


[Test Makefile]

prepare: prepare0
        @echo hello world

.PHONY: prepare prepare0


[Result]
$ make
hello world



-- 
Best Regards
Masahiro Yamada
