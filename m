Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BDDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C454720856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpyZ3xAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C454720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeICPAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:00:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38175 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeICPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:00:34 -0400
Received: by mail-qt0-f195.google.com with SMTP id x7-v6so105022qtk.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5hlxYhxAKpVIJe37MJrIhjSi18t9kePPhIytra1F24s=;
        b=MpyZ3xAtpOq1mrquF99VpZLP/+dfXVBkYk2J6nD9DGe422qjtc3KSyCfMvYUNKvrdz
         /JvCKSCCQTLlLLMkCRykc0J4+CrKUJ2Dv+MKlBauzEgcSf0Nb3gYcgfOD01j5nk4uy/J
         xMVzBy/FpXzGt1GIRb3Fk7SE7SOnpn4aENea2S8Xj/0UiWYvHOhiHXaDtJuYFUk66NFz
         0FwrPaNDfEdFPHl3EcDHdonAUterJFYDC0rFjk4NuIQrU+Ht9YFv0EQdsH3RsQJI4SoK
         VtSmh2RBLvVLrGQ49GbaaU/rUrXm9hUwL62HZHk8JgH5PnnuJtYh48mb3IGMVRhnh5i4
         9itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5hlxYhxAKpVIJe37MJrIhjSi18t9kePPhIytra1F24s=;
        b=rreSl9VFVXmfApn+s9w8k07Fo/RnGP2IHCfuPWGTb2DVTQgFqHi304MFymZZ/bAkwN
         y3tH8ikim9V36Z7PxbLfL1P5Mz9uyZpUahXBu+2aO30K7PMHRkh3y17aYoK4ZXwDDFPo
         lul0E6EMZRNzojf9Lr5R/V7frIEiLFJcp/xGrjjqO2fYef9Gi8AHMLfm8KeaWemfAq7R
         G2S3Ad5eekZI3qtJ9VNKwwr1bDwCwgHVtKrWB6KRKVIk3NQsymK5Hppfy+MPq7BhhMS1
         LELUexE5bgIEb+NuGQ0X73NW2nhfxh8+hWnDrq9T9lMuqrhLrwzjLhg71Z1ZZYTsyB4g
         50Hg==
X-Gm-Message-State: APzg51B/fYvjYRYt9S3YhORzpYxGfvnVMLPfHs0hw/gmzXrRZ++B+/Ks
        B+tCxDkyoju7+UIrB8X2B3lwha4gv7eqCcvluNo9JA==
X-Google-Smtp-Source: ANB0VdamA/jsuqJxRD3/9gcxDnSVtweD4+mLMYHrVYDhq/+X9mCJvGkKNpS2pW9amhQZEWDFCCbHRExm3h2Qmce4XpI=
X-Received: by 2002:a0c:87b1:: with SMTP id 46-v6mr8729629qvj.202.1535971259426;
 Mon, 03 Sep 2018 03:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:34a7:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 03:40:38 -0700 (PDT)
In-Reply-To: <CAMuHMdV2iDHTJh2PbBzzWNSYLH-hudMB5CWzEEBormGHPMegcw@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com> <0a8588f3-929a-608f-1fdc-e24b90e6b59b@rasmusvillemoes.dk>
 <CANiq72mJ+AhD0DO6xcbG5SbGmraPU48+UbWaaU5rW-p4XoO4LQ@mail.gmail.com>
 <CANiq72mDH1hPTAuB=zmX0uiVEx_mWS-3GO26YUSKXPHRREYjjA@mail.gmail.com> <CAMuHMdV2iDHTJh2PbBzzWNSYLH-hudMB5CWzEEBormGHPMegcw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 3 Sep 2018 12:40:38 +0200
Message-ID: <CANiq72m=AW_azRv+4HHoY7o-f1gSrmChB1XUfwkqz7hVJjU1cg@mail.gmail.com>
Subject: Re: [PATCH 2/7] Compiler Attributes: use the no-underscores syntax
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
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

Hi Geert,

On Mon, Sep 3, 2018 at 8:42 AM, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> Hi Miguel,
>
> On Sat, Sep 1, 2018 at 12:41 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> On Sat, Sep 1, 2018 at 12:10 AM, Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>> > arch/parisc/boot/compressed/misc.c:#define malloc       malloc_gzip
>> > include/linux/decompress/mm.h:#define malloc(a) kmalloc(a, GFP_KERNEL)
>> > lib/inflate.c:#define malloc(a) kmalloc(a, GFP_KERNEL)
>> > include/linux/compiler_types.h:#define noinline_for_stack noinline
>> > include/linux/raid/pq.h:#define noinline __attribute__((noinline))
>> > tools/include/linux/compiler.h:#define noinline
>> > arch/mips/sgi-ip27/ip27-reset.c:#define noreturn while(1);
>>
>> A better list, searching for all attributes used anywhere in the kernel:
>>
>> git grep -E '^\s*#define\s+(address_space|alias|aligned|always_inline|as=
sume_aligned|bitwise|bnd_legacy|cold|common|const|constructor|context|depre=
cated|designated_init|destructor|error|externally_visible|flatten|force|for=
mat|format|gnu_inline|hot|hotpatch|indirect_branch|latent_entropy|long_call=
|malloc|may_alias|mode|model|naked|nocast|noclone|noderef|noinline|no_instr=
ument_function|nonnull|no_randomize_layout|noreturn|no_sanitize_address|opt=
imize|packed|pure|randomize_layout|regparm|require_context|safe|section|sys=
call_linkage|target|tls_model|unused|used|user|vector_size|visibility|warni=
ng|warn_unused_result|weak)(\(|\s|$)'
>>
>> arch/mips/sgi-ip27/ip27-reset.c:#define noreturn while(1);
>>                  /* Silence gcc.  */
>> arch/parisc/boot/compressed/misc.c:#define malloc       malloc_gzip
>> arch/powerpc/xmon/ansidecl.h:#define    const
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:#define error(fmt,
>> args...) bioslog(ERROR, fmt, ##args)
>> include/linux/compiler_attributes.h:#define   noinline
>> __attribute__((noinline))
>> include/linux/decompress/mm.h:#define malloc(a) kmalloc(a, GFP_KERNEL)
>> include/linux/raid/pq.h:#define noinline __attribute__((noinline))
>> lib/inflate.c:#define malloc(a) kmalloc(a, GFP_KERNEL)
>> tools/include/linux/compiler-gcc.h:#define  noinline
>> __attribute__((noinline))
>> tools/include/linux/compiler.h:#define noinline
>> tools/testing/selftests/futex/include/logging.h:#define error(message,
>> err, args...) \
>>
>> None of these should make a problem. And it would may avoid people
>> using such common-name-macros in the future ;-)
>
> That's very fragile.
> Who knows all (current and future) attribute names by heart, and that def=
ining
> them could have such side effects?

Please see the email I sent after that one -- I clarified that this
was more about the current state and that in v3 it will be changed, if
only to avoid surprises in the future for ourselves. I agree with you
and, as Rasmus pointed out, we will use the macros anyway.

>
> At least "alias", "force", "format", "mode", "model", "optimize", "target=
" are
> names I wouldn't hesitate to use as a macro name in a driver...

A macro with a lowercase, short & common name is not the best idea in
my opinion; if only because of clarity for future readers. Unless it
really improved the code readability for some reason in a particular
case, I would avoid it. But to each his own! :-)

Thanks for reviewing!

Cheers,
Miguel
