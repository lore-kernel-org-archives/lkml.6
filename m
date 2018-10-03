Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27015C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3287206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="19xdkTGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3287206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeJCLTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 07:19:21 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:46322 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeJCLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 07:19:21 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w934WVVe010728;
        Wed, 3 Oct 2018 13:32:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w934WVVe010728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538541152;
        bh=HjJ/VYhP+Ocnl4Gt/mPklRRARb1IpMgfasNKE+3qMkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=19xdkTGcZj/b0/yb/6YGKlHtJlxCdT9Tex43i/tXSvCJBscQXiTe2RtDafEOp8fCL
         SME3Sjqhiv1nQ8tjGHsgJKXAiKDrPHzCFUGRZ9uEZJZm7aQ8Qm56nCNnAX3JBqKFgt
         XYP8kCWVtUrQwyzK/Sdh9jfPPiliP6eDUJR8Fl5+AExT3SDxv5EP2RZ/MVESkrmiWy
         Ror8cLsPDG1/5P2D9QJVX3fUZmxXhjxXP+VkvQOvW9etbcf+Mraa8ioZrSwj+tDsJX
         PnKrqTaFiEBcMut2FnVJXsFkJdQbEYpuBXVDX/oOc8xYNTmmDIjsLqUMou6+c2JgqH
         PLonqKWTqeGiA==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id y11-v6so2442909vso.5;
        Tue, 02 Oct 2018 21:32:31 -0700 (PDT)
X-Gm-Message-State: ABuFfoi0EHcY2t8I4O7uC2xdZpytqx3TQ9P1gR0oBgzQ7aE+Ke2i7nmY
        3PrOz5xPz1FNwtvleJ+6PwC47KzYukO9LVZAKHk=
X-Google-Smtp-Source: ACcGV60MX7cdwTP74QA2FznUvhgofL7GoH8Z12VAe8FAOneU6ALsmhDzTxuZ3KY6gznQFEuLusn2iupVKiD1+WVU5j0=
X-Received: by 2002:a67:6146:: with SMTP id v67-v6mr6996558vsb.179.1538541150737;
 Tue, 02 Oct 2018 21:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181003135038.24438d97@canb.auug.org.au>
In-Reply-To: <20181003135038.24438d97@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Oct 2018 13:31:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARD6qxX1fz4XF7yj2vWZurayhtksQnGfHBEUtCTNLmGYw@mail.gmail.com>
Message-ID: <CAK7LNARD6qxX1fz4XF7yj2vWZurayhtksQnGfHBEUtCTNLmGYw@mail.gmail.com>
Subject: Re: linux-next: occassional build errors
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Oct 3, 2018 at 12:51 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Masahiro,
>
> I don't know if that has anything to changes in the kbuild system, but
> since Tuesday, I have been getting random build errors that go away after
> I remove the object directory and build again.


I have no idea.

Is it fine if you use kbuild tree from the last week?


I added 4 kbuild patches this week, but they look irrelevant.

masahiro@pug:~/ref/linux-next$ git log  --oneline
next-20180928..next-20181002  | grep kbuild
4712eca8 Merge remote-tracking branch 'kbuild/for-next'
ae5c311 Merge remote-tracking branch 'kbuild-current/fixes'
7163c4d Merge branch 'kbuild' into for-next
7c59867 kbuild: simplify command line creation in scripts/mkmakefile
23d86e8 kbuild: do not pass $(objtree) to scripts/mkmakefile
166011a kbuild: remove user ID check in scripts/mkmakefile
e4db0f7 kbuild: remove VERSION and PATCHLEVEL from $(objtree)/Makefile



>  The latest example is this:
>
> include/linux/kconfig.h: file not recognized: file format not recognized
> make[2]: *** [scripts/Makefile.build:492: crypto/crypto_user.o] Error 1
> make[1]: *** [Makefile:1057: crypto] Error 2
> make: *** [Makefile:152: sub-make] Error 2
> Command exited with non-zero status 2
>
> It is always complaining about a .h file ...
>
> Makefile:152 is the MAKE lien below:
>
> # Invoke a second make in the output directory, passing relevant variables
> sub-make:
>         $(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR) \
>         -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
>
> Makefile:1057 is the MAKE line below:
>
> PHONY += $(vmlinux-dirs)
> $(vmlinux-dirs): prepare scripts
>         $(Q)$(MAKE) $(build)=$@ need-builtin=1
>
> scripts/Makefile.build:492 is the if_changed line below:
>
> $(multi-used-m): FORCE
>         $(call if_changed,link_multi-m)
>         @{ echo $(@:.o=.ko); echo $(filter-out FORCE,$^); \
>            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
> $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
>
> Not sure what else I can tell you.
>


Does this happen only when building a module?

Can you provide a procedure
to reproduce this?



-- 
Best Regards
Masahiro Yamada
