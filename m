Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242DAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6225222B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pSC9/9XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391702AbfBKPJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:09:44 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:22599 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391683AbfBKPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:09:41 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1BF9KG4001234
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:09:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1BF9KG4001234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549897761;
        bh=/XhCE3VogiuHNt2DqEx5z/cfH95er5zV7kmbxkIGdTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pSC9/9XJllHV+s3VJ+wPSzes5DBdB4i5hONJsqGfWPHEhW22A19cDl59F7EtXM5DN
         lBTbbTgZ8oe2LxUCZdOjkMUCK25r/ZtsRObqKt9m+8lN1DeSfdUTI1IbrP08VI43Jz
         Uw0dqmMlU78WPX6ODEcg+uG/vgo2EjZjbub/uZ29VoBgU55tb48hdPX0nhz0ri2+3q
         AGWOe/oyuzjrjFzS1fKAYq8oYDtbmL0Hcg9DoKlq4pWqVAUU7KdxWRCtiMA30vdo6S
         oCXvPJULKJ1S+cbvNKZuGHcOD9TV+aeESwTjicWyaK2/w+pnjQJajqSpn7cJ91SSEq
         jdfO382whHgCA==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id y14so2533622vkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:09:21 -0800 (PST)
X-Gm-Message-State: AHQUAuYwvUEi4QzWwlpgV9g+Ktmnr8v1VhNoobqDOAFO9oza+0+OABPz
        D1AhuZpsONnnn//e0I/VPII7rd4rrWJ9OyoAKpg=
X-Google-Smtp-Source: AHgI3IbE4vX/k+zx30uaQewm08v/gh+XyEI4JRBzwJD8CudqXOWPwAGiCntkEX/ztf66IgQYrUkARx+n9AJm4gR3ick=
X-Received: by 2002:a1f:27d7:: with SMTP id n206mr15189618vkn.0.1549897759853;
 Mon, 11 Feb 2019 07:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <563751355.221.1549587440037.JavaMail.zimbra@efficios.com> <20190208054147.GB9647@archlinux-ryzen>
In-Reply-To: <20190208054147.GB9647@archlinux-ryzen>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Feb 2019 00:08:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=hcVtG952t4bNyJMx1_byAeaFHj06P6KmFvTjh4ZQxA@mail.gmail.com>
Message-ID: <CAK7LNAS=hcVtG952t4bNyJMx1_byAeaFHj06P6KmFvTjh4ZQxA@mail.gmail.com>
Subject: Re: [PATCH 1/4] init/Kconfig: add config support for detecting linker
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 2:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Feb 07, 2019 at 07:57:20PM -0500, Mathieu Desnoyers wrote:
> >
> > ----- ndesaulniers@google.com wrote:
> > > Similar to how we differentiate between CONFIG_CC_IS_GCC and
> > > CONFIG_CC_IS_CLANG, add CONFIG_LD_IS_BFD, CONFIG_LD_IS_GOLD, and
> > > CONFIG_LD_IS_LLD.
> > >
> > > This simiplifies patches to Makefiles that need to do different things
> > > for different linkers.
> >
>
> Hi Mathieu,
>
> > What guarantees that the linker used for e.g. make defconfig is the same linker used for make ?
> >
> > Is it required with this patch ?
> >
>
> The build system ensures that the compiler (and after this patch, the
> linker) config values are correct before compiling (and prompting the
> user for the new choices that are available to them in that case).
>
> For example:
>
> $ make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- defconfig
> ...
>
> $ rg "CONFIG_CC_IS|CONFIG_LD_IS" .config
> 10:CONFIG_CC_IS_CLANG=y
> 12:CONFIG_LD_IS_BFD=y
>
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LD=ld.lld
> scripts/kconfig/conf  --syncconfig Kconfig
> *
> * Restart config...
> *
> *
> * General architecture-dependent options
> *
> Kprobes (KPROBES) [N/y/?] n
> Optimize very unlikely/likely branches (JUMP_LABEL) [N/y/?] (NEW)
> Stack Protector buffer overflow detection (STACKPROTECTOR) [Y/n/?] y
>   Strong Stack Protector (STACKPROTECTOR_STRONG) [Y/n/?] y
> Use a virtually-mapped stack (VMAP_STACK) [Y/n/?] y
> Perform full reference count validation at the expense of speed (REFCOUNT_FULL) [Y/?] y
> *
> * GCC plugins
> *
> GCC plugins (GCC_PLUGINS) [N/y/?] (NEW)
> ...
>
> $ rg "CONFIG_CC_IS|CONFIG_LD_IS" .config
> 9:CONFIG_CC_IS_GCC=y
> 13:CONFIG_LD_IS_LLD=y
>
> > How does it work in a cross compile environment ?
> >
>
> Since $(LD) is defined based on $(CROSS_COMPILE), it should work fine.
> I tested it with both arm64 and x86_64 and CONFIG_LD_IS_BFD gets
> set by default and I can see CONFIG_LD_IS_GOLD get set with both
> LD=aarch64-linux-gnu-ld.gold and LD=ld.gold.
>
> If I misunderstood the questions or my explanation wasn't correct,
> please let me know!




With this patch,

include/config/auto.conf.cmd will include the following:

ifneq "$(LD)" "ld"
include/config/auto.conf: FORCE
endif


When $(LD) is changed, Kconfig will be re-run.






--
Best Regards
Masahiro Yamada
