Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1DA20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhVWqKU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1DA20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeIACuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:50:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44835 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeIACuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:50:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id d131-v6so2428475qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ysT38iRd7Xjc2D+93950208mkURZP2Ef+Z769S1Muwo=;
        b=UhVWqKU0ZJZLcREbE0I7m3yc6LhPxBPq/biMlf+ykGQp1DdeSoLn0zpNXjdEDOT1l3
         brqMjz2zBfNaY0CNYwwnOWlFfxYB5p63dZain9sLvQEe96fcRkW6Jz8viTYOEM+jkMzR
         bO8ve7kB0btrJpDHA8YZ/ztzmggU7zF9dPXF58M3J8G7JflBVUoVDJEaei37gwb8lgui
         +g2Jx0QY34aGBWC4XhMEx7LYeHQxFfbh+44up87oAgVHZCl8H953RzfJ2ivllvrppl1A
         ZfubHgC0SAM8BjCPG1xeb0Qaes14328lVucGspLJI9PjNpYodTpODUwmyrurCz+XtEIA
         GWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ysT38iRd7Xjc2D+93950208mkURZP2Ef+Z769S1Muwo=;
        b=JlXXXwNVoge1k0sZP1l8r3BLcVC8u3nJkOMb9iM1c80kKV5/EE93whvB0J5Kgueteu
         AvJNQtELYr0U5A1aONvZ3bjBd6q9EzFBEqt9RPP8XxpsEC/QB+JPz/lixYwz+dUVG+Hw
         7TDBPA84ln7kKuoWrwj1CNN9gMuAKppDQ3Rm1MqwPmgjyHN1vaaE536KaV4YlYapGOY4
         oPSIYEciDwGSRvjQIBZGqH5pTBzyGyOukW0swFwjjTF9oHlV0vOGSGUojGBBPYUSh2ZF
         1BfyHze7mkkvx9c+K2lR6sMDBXHJbkckcqowjSmmrFvqKm3MPlhFgUyBz/kyigssM+H2
         wANQ==
X-Gm-Message-State: APzg51B8mHRsQUdaXkSXvovfqSgkg0HQA+1NYuhOKjdYs+Vr4Ud9QtTt
        suttvu+FajvAjiVoNALkbDS+W3dDzBmXjjSkbRU=
X-Google-Smtp-Source: ANB0VdagG9ID8Q3XeUitQsyiqiXBA9IerMcGS4HU86XOt8usrsWElMnuktDX0aOWvvR1yFKqq6PDhJmG3ElxxgmuBsc=
X-Received: by 2002:ae9:e118:: with SMTP id g24-v6mr2568879qkm.306.1535755274571;
 Fri, 31 Aug 2018 15:41:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 15:40:54
 -0700 (PDT)
In-Reply-To: <CANiq72mJ+AhD0DO6xcbG5SbGmraPU48+UbWaaU5rW-p4XoO4LQ@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com> <0a8588f3-929a-608f-1fdc-e24b90e6b59b@rasmusvillemoes.dk>
 <CANiq72mJ+AhD0DO6xcbG5SbGmraPU48+UbWaaU5rW-p4XoO4LQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Sep 2018 00:40:54 +0200
Message-ID: <CANiq72mDH1hPTAuB=zmX0uiVEx_mWS-3GO26YUSKXPHRREYjjA@mail.gmail.com>
Subject: Re: [PATCH 2/7] Compiler Attributes: use the no-underscores syntax
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 12:10 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> arch/parisc/boot/compressed/misc.c:#define malloc       malloc_gzip
> include/linux/decompress/mm.h:#define malloc(a) kmalloc(a, GFP_KERNEL)
> lib/inflate.c:#define malloc(a) kmalloc(a, GFP_KERNEL)
> include/linux/compiler_types.h:#define noinline_for_stack noinline
> include/linux/raid/pq.h:#define noinline __attribute__((noinline))
> tools/include/linux/compiler.h:#define noinline
> arch/mips/sgi-ip27/ip27-reset.c:#define noreturn while(1);

A better list, searching for all attributes used anywhere in the kernel:

git grep -E '^\s*#define\s+(address_space|alias|aligned|always_inline|assum=
e_aligned|bitwise|bnd_legacy|cold|common|const|constructor|context|deprecat=
ed|designated_init|destructor|error|externally_visible|flatten|force|format=
|format|gnu_inline|hot|hotpatch|indirect_branch|latent_entropy|long_call|ma=
lloc|may_alias|mode|model|naked|nocast|noclone|noderef|noinline|no_instrume=
nt_function|nonnull|no_randomize_layout|noreturn|no_sanitize_address|optimi=
ze|packed|pure|randomize_layout|regparm|require_context|safe|section|syscal=
l_linkage|target|tls_model|unused|used|user|vector_size|visibility|warning|=
warn_unused_result|weak)(\(|\s|$)'

arch/mips/sgi-ip27/ip27-reset.c:#define noreturn while(1);
                 /* Silence gcc.  */
arch/parisc/boot/compressed/misc.c:#define malloc       malloc_gzip
arch/powerpc/xmon/ansidecl.h:#define    const
drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:#define error(fmt,
args...) bioslog(ERROR, fmt, ##args)
include/linux/compiler_attributes.h:#define   noinline
__attribute__((noinline))
include/linux/decompress/mm.h:#define malloc(a) kmalloc(a, GFP_KERNEL)
include/linux/raid/pq.h:#define noinline __attribute__((noinline))
lib/inflate.c:#define malloc(a) kmalloc(a, GFP_KERNEL)
tools/include/linux/compiler-gcc.h:#define  noinline
__attribute__((noinline))
tools/include/linux/compiler.h:#define noinline
tools/testing/selftests/futex/include/logging.h:#define error(message,
err, args...) \

None of these should make a problem. And it would may avoid people
using such common-name-macros in the future ;-)

Cheers,
Miguel
