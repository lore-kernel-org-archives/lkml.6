Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099C6C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA62B21928
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kv/OBBi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfBGRE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:04:59 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55673 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:04:58 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so1434087ith.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UungPTGvNyXucoF8vGb02MG0uot3poQft8jVKChgKA=;
        b=Kv/OBBi8WLCbPKXTO32dfKZ+CeQh7Um1B/LmLHcz5YZcFmJaF4hxn53RjsprzUlORo
         7V31blyjal2dqJmC2srAEqdbzuXEuK2Dh9A5pOtzO0tIaPn8C6ySP0CUyfryxXBfPuIj
         uRWM3y4PNBOh8MKmfZ+cqOS9XCjjLFRV3bOAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UungPTGvNyXucoF8vGb02MG0uot3poQft8jVKChgKA=;
        b=E7R08gUgO/snmD/ac4udqR6A/J19c3uDyZjW1tA8GhhAYqBB1WJaCxPdrfHGHWxXM3
         xpxSUPyod/gDqvZf0xyZs+lWg3JkAFiPqGMfN1+l7StLus3cV7l3zpjecDNOLuLqPXHh
         67A4HSVzHPGEwg99eftdpJuDR7NAg9yJZ4DdVUyqatzhndPZLiuMQeMIw2zQQiGz/6E+
         v2o2XgxoQF/q8369cEL5vJH8+crqbyKCywn9rlAGdv9z8ZinYG96zG248o8oedf3upqM
         /+CgNMQaC63jD3KIBevQnSydZID4hGGDRQBXDtgEivMvgkp9AYoNtSDuueHTuJ6LYZX5
         PzmQ==
X-Gm-Message-State: AHQUAubQ9Xr79SuiJj6Z4rj2YcSlNCwTXIdZBqOqgmCTBGFC+k82I23D
        B37mFmI73BYAFwlDF7P4WOXp2fd5pqE=
X-Google-Smtp-Source: AHgI3IbCtCkM1JxxNnJufsLLHn0013xxqW3qMfgQ6cscqq04eyZ4cmj1xhPCSDbGIB5eOinIlHnE/A==
X-Received: by 2002:a6b:c386:: with SMTP id t128mr9035108iof.304.1549559098125;
        Thu, 07 Feb 2019 09:04:58 -0800 (PST)
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id 197sm5802364itx.21.2019.02.07.09.04.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 09:04:56 -0800 (PST)
Received: by mail-it1-f178.google.com with SMTP id h193so1434067ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:04:56 -0800 (PST)
X-Received: by 2002:a24:3987:: with SMTP id l129mr5488578ita.45.1549559096311;
 Thu, 07 Feb 2019 09:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-3-thgarnie@chromium.org>
 <20190207121729.GE2414@zn.tnic>
In-Reply-To: <20190207121729.GE2414@zn.tnic>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Thu, 7 Feb 2019 09:04:45 -0800
X-Gmail-Original-Message-ID: <CAJcbSZFe+Cn9+gEa4iv56sZE+WXXiHjeR8Mcte9s_HYr8QBrsw@mail.gmail.com>
Message-ID: <CAJcbSZFe+Cn9+gEa4iv56sZE+WXXiHjeR8Mcte9s_HYr8QBrsw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] x86: Use symbol name in jump table for PIE support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 4:17 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 31, 2019 at 11:24:09AM -0800, Thomas Garnier wrote:
> > Replace the %c constraint with %P. The %c is incompatible with PIE
> > because it implies an immediate value whereas %P reference a symbol.
>
> How so?
>
> AFAIK, %c requires a constant operand and if %P is used to print a
> constant, it simply drops syntax-specific prefixes and does a bare
> constant.
>
> I guess that here
>
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers
>
> is not entirely correct as it should not say "If used for a constant"
> for %P but say "symbol or constant".
>
> But before/after asm doesn't show any difference. So what gives?

I assume that's an optimisation done by gcc later. The P modifier in
the documentation does state that it is used to generate PIC code.

>
> before:
> # 39 "./arch/x86/include/asm/jump_label.h" 1
>         1:
>         .byte 0xe9
>          .long .L241 - 2f       #
>         2:
>         .pushsection __jump_table,  "aw"
>          .balign 8
>         .long 1b - ., .L241 - .         #
>          .quad __use_tsc + 1 - .        #,
>         .popsection
>
> after:
> # 39 "./arch/x86/include/asm/jump_label.h" 1
>         1:
>         .byte 0xe9
>          .long .L241 - 2f       #
>         2:
>         .pushsection __jump_table,  "aw"
>          .balign 8
>         .long 1b - ., .L241 - .         #
>          .quad __use_tsc+1 - .  #
>         .popsection
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
