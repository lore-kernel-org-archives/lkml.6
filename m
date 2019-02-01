Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AF8C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E15720870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zInPD5g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfBADHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:07:03 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:27153 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfBADHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:07:00 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1136oqn027942;
        Fri, 1 Feb 2019 12:06:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1136oqn027942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548990411;
        bh=uUabJopDMZ0umDD/d/sY35FMMsNvxR1JmvvVWrUXa1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zInPD5g7fg8XPQtJGrR4/dvQqT5ndqYklBSOJ3BRaxYZ48v7E/AEUBKvnXxXo5Jj8
         pWrKSKd60f/wBUcIXGIL8X040+pliRqZp94AsNXosMXUo04QrdF3T/kqlxP8FhfxbB
         oB7CZ58akUMZWs0SrTFDveFFHKpbJStuDohtc7lHVtro4Q4CGsY9hArQrfrw8vfhkS
         U4ItDDOvcp7sILcxy2bQ5fmxH3Uyygoaxcsp2hhQPwyE2hnfqAV2pbM5vNaz7FXJ57
         try8TnuJuH9W5U7Hvb8DypM9b7ZWF9g4jufw5gUvK+B3gdexCx/gDQev9xZtW5EHx4
         4uH2by0vmTgFQ==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id j3so1793844uap.3;
        Thu, 31 Jan 2019 19:06:50 -0800 (PST)
X-Gm-Message-State: AJcUukfeEoXOvb32+hG+31HVWNPQXYoPfmt/3dVhCmrGRL8ja8rUbFj5
        VPfiybFJ5VNIbTdc+2DHz7fcYwVVwzXGzTNX69A=
X-Google-Smtp-Source: ALg8bN5W3ykQh3u1U7LDjDfcOv87F0g8Abx/fHHXttUpu5K0W3yAB9diIjhLCwPSnQ2YkRqkH/5tAYvQZnl8iE+WTbQ=
X-Received: by 2002:ab0:849:: with SMTP id b9mr15580684uaf.93.1548990409489;
 Thu, 31 Jan 2019 19:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20190121095338.8565-1-bp@alien8.de> <20190131115820.GF6749@zn.tnic>
In-Reply-To: <20190131115820.GF6749@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Feb 2019 12:06:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
Message-ID: <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 8:58 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Ping?
>
> On Mon, Jan 21, 2019 at 10:53:38AM +0100, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> >
> > Modern gcc adds view assignments, reset assertion checking in .loc
> > directives and a couple more additional debug markers, which clutters
> > the asm output unnecessarily:
> >
> > For example:
> >
> >   bsp_resume:
> >   .LFB3466:
> >           .loc 1 1868 1 is_stmt 1 view -0
> >           .cfi_startproc
> >           .loc 1 1869 2 view .LVU73
> >   # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
> >           .loc 1 1869 14 is_stmt 0 view .LVU74
> >           movq    this_cpu(%rip), %rax    # this_cpu, this_cpu
> >           movq    64(%rax), %rax  # this_cpu.94_1->c_bsp_resume, _2
> >   # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
> >           .loc 1 1869 5 view .LVU75
> >           testq   %rax, %rax      # _2
> >           je      .L8     #,
> >           .loc 1 1870 3 is_stmt 1 view .LVU76
> >           movq    $boot_cpu_data, %rdi    #,
> >           jmp     __x86_indirect_thunk_rax
> >
> > or
> >       .loc 2 57 9 view .LVU478
> >       .loc 2 57 9 view .LVU479
> >       .loc 2 57 9 view .LVU480
> >       .loc 2 57 9 view .LVU481
> >   .LBB1385:
> >   .LBB1383:
> >   .LBB1379:
> >   .LBB1377:
> >   .LBB1375:
> >       .loc 2 57 9 view .LVU482
> >       .loc 2 57 9 view .LVU483
> >       movl    %edi, %edx      # cpu, cpu
> >   .LVL87:
> >       .loc 2 57 9 is_stmt 0 view .LVU484
> >
> > That MOV in there is drowned in debugging information and latter makes
> > it hard to follow the asm. And that DWARF info is not really needed for
> > asm output staring.
> >
> > Disable the debug information generation which clutters the asm output
> > unnecessarily:
> >
> >   bsp_resume:
> >   .LFB3466:
> >           .loc 1 1868 1
> >   # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
> >           .loc 1 1869 14
> >           movq    this_cpu(%rip), %rax    # this_cpu, this_cpu
> >           movq    64(%rax), %rax  # this_cpu.94_1->c_bsp_resume, _2
> >   # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
> >           .loc 1 1869 5
> >           testq   %rax, %rax      # _2
> >           je      .L8     #,
> >   # arch/x86/kernel/cpu/common.c:1870:            this_cpu->c_bsp_resume(&boot_cpu_data);
> >           .loc 1 1870 3
> >           movq    $boot_cpu_data, %rdi    #,
> >           jmp     __x86_indirect_thunk_rax
> >
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: linux-kbuild@vger.kernel.org
> > ---
> >  scripts/Makefile.build | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index fd03d60f6c5a..4f33fdab89d2 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -103,8 +103,12 @@ modkern_cflags =                                          \
> >               $(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
> >  quiet_modtag = $(if $(part-of-module),[M],   )
> >
> > +disable_extra_cc_dbg := $(call cc-option,-gno-as-locview-support)
> > +disable_extra_cc_dbg += $(call cc-option,-fno-dwarf2-cfi-asm)
> > +disable_extra_cc_dbg += $(call cc-option,-feliminate-unused-debug-symbols)
> > +disable_extra_cc_dbg += $(call cc-option,-gno-statement-frontiers)


This would make the build speed slower
because the compiler is invoked to check those flags in every directory.


I tested this patch with x86_64_defconfig and GCC 8.2
(on ubuntu 18.10 in docker)
but I saw no effect of this patch.

CONFIG_DEBUG_INFO adds dwarf info, and clutters asm output.

Did you enable CONFIG_DEBUG_INFO
when you were debugging asm files?


-- 
Best Regards
Masahiro Yamada
