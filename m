Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093FC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 06:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D8B21773
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 06:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FqXdhpjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfBJGvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 01:51:42 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58726 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfBJGvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 01:51:42 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1A6pbp9026765;
        Sun, 10 Feb 2019 15:51:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1A6pbp9026765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549781498;
        bh=jaBUTe8EM0j2z7G2BJ3pV9J7ecvkolch3EL9Lsq/e68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FqXdhpjddgUe5l5lc9upP9HPdcJIJJGY5TMmYOM21t2mjowNadWTJYCcsMLs+lOAZ
         iPo+bP6CUbvRepBYLAP0F9L8TKGnMb1ykGj45MWAUus0z905GW8sI2CtjHu97XgSGk
         5xXB/2xj4QcgZhgEImd+tbCcrf3lLD93XNbJ3bXvloCGRH9KbAxzZPFY7MzJQYrcvp
         0eXYKcRXOb5zLAcea1pu+IUrzf4ufnTSTzGu+aUBLorGtV4a4KByii3ZFy0bw9Nv3r
         vUkZfMnbGVMDY2oExbJkH/Z5OS3pdrcLvQr1oKX+2M4IozKFvi8aQStqyKyPDUc7hl
         gkpQZ4442Ciow==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id 66so438489vsk.7;
        Sat, 09 Feb 2019 22:51:38 -0800 (PST)
X-Gm-Message-State: AHQUAuYilwZTHgK7/8wRz5OhvCLUgt1sLmnlM8AB6gSGxYtSvPTOZgtN
        a+H7QYVk4yZHgiFA9FQAe6TZJegKeZFYvOsun1c=
X-Google-Smtp-Source: AHgI3IYnRkeQKjvhTnogL30mPzPcakWQgI0/Og44EV0rdZjJ0HM+SLRVQNff2s9gq+/UrMs/1qig64MH4h3n7PxEJ+o=
X-Received: by 2002:a67:485:: with SMTP id 127mr12784216vse.54.1549781497006;
 Sat, 09 Feb 2019 22:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20190131115820.GF6749@zn.tnic> <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
 <20190201094217.GB31854@zn.tnic> <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic> <20190201103648.GF31854@zn.tnic>
 <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
 <20190201151139.GK31854@zn.tnic> <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
 <20190202144227.GC27822@zn.tnic> <20190206104729.GC7314@zn.tnic>
In-Reply-To: <20190206104729.GC7314@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 10 Feb 2019 15:51:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+GhbEwP7v7NWd2kqW76qbXM1mtKhc21YXkp7BUJjzKQ@mail.gmail.com>
Message-ID: <CAK7LNAT+GhbEwP7v7NWd2kqW76qbXM1mtKhc21YXkp7BUJjzKQ@mail.gmail.com>
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

On Wed, Feb 6, 2019 at 7:49 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Feb 02, 2019 at 03:42:27PM +0100, Borislav Petkov wrote:
> > On Sat, Feb 02, 2019 at 10:48:00PM +0900, Masahiro Yamada wrote:
> > > '?=' is the same as '=' here.
> >
> > Sure but if the slowdown disappears, then make does something else for
> > '?=' apparently vs for '='.

'=' and '?=' are the same in the sense that
the right-hand side is evaluated when it is used.


> Ok, let me ask a different question then: would a separate target which
> will be used to generate only clean asm for debugging purposes ala
>
> make <path-to-file>.asm

Sorry, I do not like to duplicate the code.



I do not understand why you need to test such complicated
compiler flags in order to negate CONFIG_DEBUG_INFO.


I am still wondering,
but if this is really worth doing in upstream code,
I think the following is a simpler idea.




diff --git a/Makefile b/Makefile
index 3142e67..131164a 100644
--- a/Makefile
+++ b/Makefile
@@ -729,25 +729,28 @@ KBUILD_CFLAGS     += -fomit-frame-pointer
 endif
 endif

-KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)
+DEBUG_CFLAGS    := $(call cc-option, -fno-var-tracking-assignments)

 ifdef CONFIG_DEBUG_INFO
 ifdef CONFIG_DEBUG_INFO_SPLIT
-KBUILD_CFLAGS   += $(call cc-option, -gsplit-dwarf, -g)
+DEBUG_CFLAGS    += $(call cc-option, -gsplit-dwarf, -g)
 else
-KBUILD_CFLAGS  += -g
+DEBUG_CFLAGS   += -g
 endif
 KBUILD_AFLAGS  += -Wa,-gdwarf-2
 endif
 ifdef CONFIG_DEBUG_INFO_DWARF4
-KBUILD_CFLAGS  += $(call cc-option, -gdwarf-4,)
+DEBUG_CFLAGS   += $(call cc-option, -gdwarf-4,)
 endif

 ifdef CONFIG_DEBUG_INFO_REDUCED
-KBUILD_CFLAGS  += $(call cc-option, -femit-struct-debug-baseonly) \
+DEBUG_CFLAGS   += $(call cc-option, -femit-struct-debug-baseonly) \
                   $(call cc-option,-fno-var-tracking)
 endif

+KBUILD_CFLAGS += $(DEBUG_CFLAGS)
+export DEBUG_CFLAGS
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
   # gcc 5 supports generating the mcount tables directly

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60..bc8e0ae 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -104,7 +104,7 @@ modkern_cflags =                                          \
 quiet_modtag = $(if $(part-of-module),[M],   )

 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
+cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags))
$(DISABLE_LTO) -fverbose-asm -S -o $@ $<

 $(obj)/%.s: $(src)/%.c FORCE
        $(call if_changed_dep,cc_s_c)




> or so be an acceptable approach?
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

--
Best Regards
Masahiro Yamada
