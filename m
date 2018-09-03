Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DBCC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4081F20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4081F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeICLBY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:01:24 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44948 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeICLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:01:23 -0400
Received: by mail-ua1-f67.google.com with SMTP id m11-v6so12360819uao.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 23:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U2PHNA4yBROlC284LF56lKhFIU0/CuTbGPBSC8JbQSo=;
        b=OOzQljUbkMjMdzkAufJDnumUUEym+Z58945dL9C8N7uHCXMH5mbwnTa6wLCb9TbMyl
         Luj3dRGZUYU3l7yV7xTzaNyNpHsdnMQMfyjAKq9JMWrC1Ga4D8Vv6OisELnb7nr8mrQ4
         IdkRXdDWFTPhykTeuf//HJ5j4Nh1Sv2cg1hXu38gK77msJfteHj4y2N93vzo9e8ECmBa
         bQVHVuDu8u5yHAPSqINYpwJDYk9rKDf4BcnIfDWps0Xlv6ouG2A6ASEwz34BIWGByXr/
         XBKq6mMCNiIUc27gDS+GIzJlFtBBT7UdZt5RPRn1hi+7duuoWRMok8YTbYHcevbj+89E
         +xcA==
X-Gm-Message-State: APzg51DeF4U3STbup1FVQb9+y42PUEbVxvZfC4NJ4+5TxSs2nhGERbqs
        d80HDX0TIg9qbbmX+/fE2WLEggvQRBGRTHxia58=
X-Google-Smtp-Source: ANB0VdYnpQxoOyoxVE03Sct8uHtSi7fnoL2tNLKZLm3d4kht3vm+JX9gdV/WpEYH4HAu+T6q2r2q7uzTT8oau0Mt77M=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr15141808uae.47.1535956958633;
 Sun, 02 Sep 2018 23:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com> <0a8588f3-929a-608f-1fdc-e24b90e6b59b@rasmusvillemoes.dk>
 <CANiq72mJ+AhD0DO6xcbG5SbGmraPU48+UbWaaU5rW-p4XoO4LQ@mail.gmail.com> <CANiq72mDH1hPTAuB=zmX0uiVEx_mWS-3GO26YUSKXPHRREYjjA@mail.gmail.com>
In-Reply-To: <CANiq72mDH1hPTAuB=zmX0uiVEx_mWS-3GO26YUSKXPHRREYjjA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Sep 2018 08:42:26 +0200
Message-ID: <CAMuHMdV2iDHTJh2PbBzzWNSYLH-hudMB5CWzEEBormGHPMegcw@mail.gmail.com>
Subject: Re: [PATCH 2/7] Compiler Attributes: use the no-underscores syntax
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efriedma@codeaurora.org, Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>, asmadeus@codewreck.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Sat, Sep 1, 2018 at 12:41 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Sat, Sep 1, 2018 at 12:10 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > arch/parisc/boot/compressed/misc.c:#define malloc       malloc_gzip
> > include/linux/decompress/mm.h:#define malloc(a) kmalloc(a, GFP_KERNEL)
> > lib/inflate.c:#define malloc(a) kmalloc(a, GFP_KERNEL)
> > include/linux/compiler_types.h:#define noinline_for_stack noinline
> > include/linux/raid/pq.h:#define noinline __attribute__((noinline))
> > tools/include/linux/compiler.h:#define noinline
> > arch/mips/sgi-ip27/ip27-reset.c:#define noreturn while(1);
>
> A better list, searching for all attributes used anywhere in the kernel:
>
> git grep -E '^\s*#define\s+(address_space|alias|aligned|always_inline|assume_aligned|bitwise|bnd_legacy|cold|common|const|constructor|context|deprecated|designated_init|destructor|error|externally_visible|flatten|force|format|format|gnu_inline|hot|hotpatch|indirect_branch|latent_entropy|long_call|malloc|may_alias|mode|model|naked|nocast|noclone|noderef|noinline|no_instrument_function|nonnull|no_randomize_layout|noreturn|no_sanitize_address|optimize|packed|pure|randomize_layout|regparm|require_context|safe|section|syscall_linkage|target|tls_model|unused|used|user|vector_size|visibility|warning|warn_unused_result|weak)(\(|\s|$)'
>
> arch/mips/sgi-ip27/ip27-reset.c:#define noreturn while(1);
>                  /* Silence gcc.  */
> arch/parisc/boot/compressed/misc.c:#define malloc       malloc_gzip
> arch/powerpc/xmon/ansidecl.h:#define    const
> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:#define error(fmt,
> args...) bioslog(ERROR, fmt, ##args)
> include/linux/compiler_attributes.h:#define   noinline
> __attribute__((noinline))
> include/linux/decompress/mm.h:#define malloc(a) kmalloc(a, GFP_KERNEL)
> include/linux/raid/pq.h:#define noinline __attribute__((noinline))
> lib/inflate.c:#define malloc(a) kmalloc(a, GFP_KERNEL)
> tools/include/linux/compiler-gcc.h:#define  noinline
> __attribute__((noinline))
> tools/include/linux/compiler.h:#define noinline
> tools/testing/selftests/futex/include/logging.h:#define error(message,
> err, args...) \
>
> None of these should make a problem. And it would may avoid people
> using such common-name-macros in the future ;-)

That's very fragile.
Who knows all (current and future) attribute names by heart, and that defining
them could have such side effects?

At least "alias", "force", "format", "mode", "model", "optimize", "target" are
names I wouldn't hesitate to use as a macro name in a driver...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
