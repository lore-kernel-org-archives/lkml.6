Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD31F2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LvtPjW60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD31F2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJQQy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:54:29 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60035 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQQy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:54:28 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9H8xdwh024558;
        Wed, 17 Oct 2018 17:59:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9H8xdwh024558
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539766780;
        bh=pg4rCzw7+zwVahgcmGmpzx2jiW/Tlo9LDhAeQWQSaes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LvtPjW60I89QgOnM5C0k9exaeyfGvBpRMUxkA3TGkksUF98kVR46H4bZ4niOP+RwT
         JR4rmR/GD1YvivAnNN9offv5ymQCi2FkjQJfeEnr0e/aqVyaZouMVwOHfQUcBh46eu
         g6p9ezoNOu6ebbCUwbJKl2Ltom5nRppR+a6YfiNhkXfhUowGlQiqTJq9x7NCwo+xwI
         WVR+FKoOCmuOkAbZwEwUsw1naFOXFGoaMlCufJqbms0V04/EWeQWwUc9McJmN5jg0J
         6kAAtiVb3fE8ViCVLuRTRSdBQtLkObtFrCuuGgUIO4BMZowTv/ahlv4/Xa6H2DtO/6
         41h/AwVafEiew==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id e206so20307481vsd.0;
        Wed, 17 Oct 2018 01:59:40 -0700 (PDT)
X-Gm-Message-State: ABuFfojSVy2Lu6AoQPiVmOTUYvQjeZtotvdQdzhwYWNYwsCb1Ic9JWuA
        yQbXz+dwMs1KjXzlu5gZZnA78P+uMEoI3LYoACk=
X-Google-Smtp-Source: ACcGV60JFGDHebpmRBUJubLWgDn5s0oXLz9EWUUnrr/qpiIjWzo3TWd1UvlAQ2IDKqW9ZnZWF6Rvr8N4G0stQZyv/4w=
X-Received: by 2002:a67:3793:: with SMTP id j19mr9858863vsi.215.1539766779085;
 Wed, 17 Oct 2018 01:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
 <1539681053-24388-4-git-send-email-yamada.masahiro@socionext.com> <20181016195420.GE27990@zn.tnic>
In-Reply-To: <20181016195420.GE27990@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Oct 2018 17:59:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7wzJ+L-2kC2fyi9Ta9qq1jiM0-UOAisGL2CZuSEoE7w@mail.gmail.com>
Message-ID: <CAK7LNAS7wzJ+L-2kC2fyi9Ta9qq1jiM0-UOAisGL2CZuSEoE7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: check the presence of lzo and lz4 tools when necessary
To:     Borislav Petkov <bp@suse.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 4:56 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Tue, Oct 16, 2018 at 06:10:53PM +0900, Masahiro Yamada wrote:
> > If CONFIG_KERNEL_LZ4 is enabled without lz4 tool installed on the
> > system, the build fails at the very last stage (reported by
> > Borislav Petkov [1]).
> >
> >   LZO     arch/x86/boot/compressed/vmlinux.bin.lzo
> > /bin/sh: 1: lzop: not found
> > arch/x86/boot/compressed/Makefile:141: recipe for target 'arch/x86/boot/compressed/vmlinux.bin.lzo' failed
> > make[2]: *** [arch/x86/boot/compressed/vmlinux.bin.lzo] Error 1
> > arch/x86/boot/Makefile:112: recipe for target 'arch/x86/boot/compressed/vmlinux' failed
> > make[1]: *** [arch/x86/boot/compressed/vmlinux] Error 2
> > arch/x86/Makefile:284: recipe for target 'bzImage' failed
> > make: *** [bzImage] Error 2
> >
> > Check the tools in scripts/Makefile.toolcheck to fail the build
> > earlier with a more readable message.
> >
> > [1] https://patchwork.kernel.org/patch/10635381/
> >
> > Suggested-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  scripts/Makefile.toolcheck | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/scripts/Makefile.toolcheck b/scripts/Makefile.toolcheck
> > index bc26fc0..5e336e4 100644
> > --- a/scripts/Makefile.toolcheck
> > +++ b/scripts/Makefile.toolcheck
> > @@ -17,6 +17,14 @@ msg_stack_validation = "libelf is necessary for building the objtool." \
> >                      "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> >  toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation
> >
> > +chk_lzo = command -v lzop
> > +msg_lzo = "lzo tool not found. Please install it."
> > +toolcheck-$(CONFIG_KERNEL_LZO) += lzo
> > +
> > +chk_lz4 = command -v lz4c
> > +msg_lz4 = "lz4 tool not found. Please install it."
> > +toolcheck-$(CONFIG_KERNEL_LZ4) += lz4
> > +
> >  PHONY += $(toolcheck-y)
> >  __toolcheck: $(toolcheck-y)
> >
> > --
>
> Cool, thanks for doing that!
>
> However, I applied all three, cleaned up the tree properly:
>
> $ git clean -dqfx
>
> and then used my .config (attached) which selects CONFIG_KERNEL_LZ4.
>
> And I built it twice just to make sure I'm seeing correctly but the
> error still happens at the end:
>
>   DESCEND  objtool
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   Building modules, stage 2.
>   CC      arch/x86/boot/compressed/misc.o
>   LZ4     arch/x86/boot/compressed/vmlinux.bin.lz4
> /bin/sh: 1: lz4c: not found
> make[2]: *** [arch/x86/boot/compressed/Makefile:143: arch/x86/boot/compressed/vmlinux.bin.lz4] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
> make: *** [arch/x86/Makefile:290: bzImage] Error 2
> make: *** Waiting for unfinished jobs....
>   MODPOST 956 modules
>
> What am I missing?


I have no idea.

With liblz4-tool package installed on my machine,
I can build x86 kernel with CONFIG_KERNEL_LZ4.




-- 
Best Regards
Masahiro Yamada
