Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDD9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F726208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTtQNFKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F726208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965790AbeFOSp7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:45:59 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45664 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756311AbeFOSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:45:58 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so4782799pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isbARfPpBv8CH5+aOoOF+o3Yv39Hev0fpZ2QnTzNHtY=;
        b=fTtQNFKFF3xIrDpOyxhnswZdiFbPpZHyYeJEyWxMDV2KeIx9TbFHwTTRF91t1AeWgB
         x2/UEQuuF3quSH6RZ9JADqWOA2PFAytABJgb/zLtXjTxhDg6U+ZPTA7AhqTwec06uLfN
         lllkL8m+GdUDpub+/KoscsgnZZElJJ2TuOs4gA0g81PMABqfCsaM5VRjZtOlweU1FzCW
         e+7s4bA/IYyn+HY1gVPD5CUg3rklWA1K3a/9HbbEBStB5QVC2p5g23hZktEmQNd9cG/+
         FRbtm9UOIiUVSyHQpFR1UfuLVcbEhp00HxNwKTAs0l8npQ2q8Gm4Llb6Bic770I8ZPrB
         pW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isbARfPpBv8CH5+aOoOF+o3Yv39Hev0fpZ2QnTzNHtY=;
        b=ZSLJJQQ7IFr2zsfTHTh6tslwzj/y3laXs8sG6RjmFVjLX8BZ0cTpugbaJpUwqPcbND
         sOwDG0Jo4FzTV1FMWEED8v6fHHr5+rvc9O9i+8RMdO1CUVpzxdor6n36vXBkqgLhM+J6
         PaIJDv8djTasP5eQ/zjJfRZH+M9MXcXI2a2yW2dL0tEIHcOq5n0v7j7fAu7a+JCNOxgO
         xNW1OFMDv2Ajpb3HAifBH13NvWEBkUFKeNdJ0ODesRML1z6RgQq3hJnSjTFFddl8rZYJ
         e49vrcPAHlX8frB7+vD4QB9iPvG6FqkMW/smHqdosell/2RwTRvtnVEFJh37rny6TPOQ
         o1WA==
X-Gm-Message-State: APt69E2Om/FB7U7V2KVzT7A7pTyYe9gqvJuwXvZv0XMR9WcymKCThhC7
        uPfOHuJcpXI6i93rnD3wWLPQXaDkmu5QC1nBmiGqOQ==
X-Google-Smtp-Source: ADUXVKLiu8uYfVp9gdCF0nsSqpBkgWpwF1Rci4ijtKAtmq4GWH3iZ+/X5BsVJpB05A6kO+nmVBGO5h7d4U8HDXcYxcY=
X-Received: by 2002:a63:af50:: with SMTP id s16-v6mr2666565pgo.263.1529088357011;
 Fri, 15 Jun 2018 11:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174731.47588-1-mka@chromium.org> <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
 <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
 <20180615182945.GN88063@google.com> <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
In-Reply-To: <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jun 2018 11:45:45 -0700
Message-ID: <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
To:     joe@perches.com
Cc:     Matthias Kaehlcke <mka@chromium.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:40 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2018-06-15 at 11:29 -0700, Matthias Kaehlcke wrote:
> > On Fri, Jun 15, 2018 at 11:18:12AM -0700, Joe Perches wrote:
> > > On Fri, 2018-06-15 at 11:04 -0700, Nick Desaulniers wrote:
> > > > On Fri, Jun 15, 2018 at 10:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > >
> > > > > update_permission_bitmask() negates u8 bitmask values and assigns them
> > > > > to variables of type u8. Since the MSB is set in the bitmask values the
> > > > > compiler expands the negated values to int, which then are assigned to
> > > > > u8 variables. Cast the negated values back to u8.
> > > > >
> > > > > This fixes several warnings like this when building with clang:
> > > > >
> > > > > arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
> > > > >   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
> > > > >   -Wconstant-conversion]
> > > > >     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> > > > >        ~~                               ^~
> > > > >
> > > > > (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> > > > > doesn't seem to be universally enabled)
> > >
> > > Perhaps it's better to turn off the warning.
> > > There are more of these in the kernel too.
> > >
> > > At least:
> > > drivers/regulator/max8660.c:        u8 mask = (rdev_get_id(rdev) == MAX8660_V3) ? ~1 : ~4;
> > > drivers/regulator/max8660.c:        u8 mask = (rdev_get_id(rdev) == MAX8660_V6) ? ~2 : ~4;
> > > fs/ext4/resize.c:   __u16 uninit_mask = (flexbg_size > 1) ? ~EXT4_BG_BLOCK_UNINIT : ~0;
> >
> > In my experience neither clang nor gcc should promote these values to
> > int, since the MSB/sign bit is not set.
>
> Well, that is what the c90 standard requires.
>
> 6.5.3.3 Unary arithmetic operators
> Constraints
> 4 The result of the ~ operator is the bitwise complement of its (promoted) operand (that is,
> each bit in the result is set if and only if the corresponding bit in the converted operand is
> not set). The integer promotions are performed on the operand, and the result has the
> promoted type. If the promoted type is an unsigned type, the expression ~E is equivalent
> to the maximum value representable in that type minus E.
>
> > In any case I think it it preferable to fix the code over disabling
> > the warning, unless the warning is bogus or there are just too many
> > occurrences.
>
> Maybe.

Spurious warning today, actual bug tomorrow?  I prefer to not to
disable warnings wholesale.  They don't need to find actual bugs to be
useful.  Flagging code that can be further specified does not hurt.
Part of the effort to compile the kernel with different compilers is
to add warning coverage, not remove it.  That said, there may be
warnings that are never useful (or at least due to some invariant that
only affects the kernel).  I cant think of any off the top of my head,
but I'm also not sure this is one.
-- 
Thanks,
~Nick Desaulniers
