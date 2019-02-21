Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038462083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CdqlAYUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfBUXIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:08:50 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36158 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUXIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:08:49 -0500
Received: by mail-ua1-f68.google.com with SMTP id j3so313929uap.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oIzNwYH6CwexwuQyYEKHzsIwSVhd2rIeuRF/WvpgdU=;
        b=CdqlAYUQiwqBjO4VxbS22Sg0NPa6Y8onyILijOuPeisceu9hmBSF8BBOtswVWbx2WO
         MUrbsCBS5Ifgn/qULZ14X0LVKTZri5erhSDbKorz2NDE4krBKI77qzVCLtLhRJStP+Ay
         vMQ/roWGGsnXhYmVqwXLUbUlSEmBtEKvmsb/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oIzNwYH6CwexwuQyYEKHzsIwSVhd2rIeuRF/WvpgdU=;
        b=V5wkeKmR+fau6htxfTUqQUe7G+WL86G2r2Wg6noPXUOdylEDEJs52fkiOJ4d5bjNDC
         B6iDdds7xNtKv/2qw49QHN9RwTH/8cnME0b70h0iB1xcBoz1JeRLkMjONMI+wzWIlLqC
         gCNE462XBFOI8Ec3TyAcGfbFLu154EtAOq9AB5yoRu6LtWwv7cVok7ffVYlpvy2pIYdF
         d6FxVmhrA7qit8iP7NH09GZ3F5elL2GgxtuSjsUfWG6hzvQTEPo8gzcQtK9mMuoToPpt
         AaxRyi+ZXWislEf+sSaZzk+u+88yxMpU5+BD49V8hFT8iS69PpPaBKnszf7+zA2BWOnh
         sNdQ==
X-Gm-Message-State: AHQUAubk+LLvB/YSsq2LzNMsCaVBGO73nw1ysxHzCJCGoDRu4hA6CsYx
        gldU2cnRYmeomfE504N/liAdu+e64Ug=
X-Google-Smtp-Source: AHgI3IZCCpB68OZCSshwLhZutT3Xe8F/28YWvusTu8H97g9C4cWEOxMPH7bkJoytBgp6MZKndF1DyQ==
X-Received: by 2002:a67:fd81:: with SMTP id k1mr590594vsq.91.1550790527865;
        Thu, 21 Feb 2019 15:08:47 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 68sm451976vko.9.2019.02.21.15.08.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 15:08:47 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id q17so330412uam.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:08:47 -0800 (PST)
X-Received: by 2002:a67:ec81:: with SMTP id h1mr587235vsp.188.1550790208621;
 Thu, 21 Feb 2019 15:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
 <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
 <20190221052435.GF11758@eros.localdomain> <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
 <8f002798-f68b-14cd-d321-f96b653fb51d@rasmusvillemoes.dk>
In-Reply-To: <8f002798-f68b-14cd-d321-f96b653fb51d@rasmusvillemoes.dk>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 15:03:16 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+4ia0OLHop81D8D4eSJV6765hr-m=3LPeL2490ER++Hg@mail.gmail.com>
Message-ID: <CAGXu5j+4ia0OLHop81D8D4eSJV6765hr-m=3LPeL2490ER++Hg@mail.gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jann Horn <jannh@google.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 6:58 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 21/02/2019 07.02, Kees Cook wrote:
>
> > P.S. Here's C string API Rant (I just had to get this out, please feel
> > free to ignore):
>
> I'll bite. First, it's "linux kernel string API", only some of string.h
> interfaces are in std C. Sure, none of those satisfy all use cases, but
> adding Yet Another One also has its costs.

Well, yes, strscpy and scnprintf appear to be only in the kernel (did
the originate externally somewhere I'm not aware of?)

> > strcpy returns dest ... which is already known, so it's a meaningless
> > return value.
> >
> > strncpy returns dest (still meaningless)
>
> Yeah, same for memcpy, memset. Those are classic C interfaces. It does
> allow some micro-optimizations in some cases - since one is likely to

Right, yes, but this level of optimization is best left to the
compiler. There's much more interesting results a caller should care
about. :)

> > strlcpy returns strlen(src) ... the length we WOULD have copied. Why
> > would we care about that? I'm operating on dest. Were there callers
> > that needed to both copy part of src and learn how long it was at the
> > same time?
>
> The rationale is exactly the same as for snprintf - to allow you to

Okay, but there's as separate function for that: strlen().

> > strscpy returns -E2BIG or non-NUL bytes copied: yay, a return about
> > what actually happened from the operation!
>
> Well, strictly speaking, strlcpy()'s return value also tells you exactly
> what happened, just not in the kernel "negative errno for error
> condition" style.

True, yes, but it's unfriendly: it requires careful math, just like
snprintf, which depends on rechecking the args, making sure you're not
doing an off-by-one from the NUL, etc etc.

> > ... snprintf returns what it WOULD have written, much like strlcpy
> > above. At least snprintf has an excuse: it can be used to calculate an
> > allocation size (called with a NULL dest and 0 size) ... but shouldn't
> > "how big is this format string going to be?" be a separate function?
>
> Why? Sure, you can make a wrapper vhowmuch(const char *fmt, va_args ap),
> but its implementation would have to be "return vsnprintf(NULL, 0, fmt,
> ap);", since we really must reuse the exact same logic for computing the
> length as for doing the actual printf'ing (otherwise they'd get out of
> sync).

Well, I'd likely go the opposite directly: make snprintf() a wrapper
and call vhowmuch(), etc, convert until snprintf could be removed. But
really the best might be removal of snprintf first, then refactor it
with vhowmuch() etc. Lots of ways to solve it, I suppose. But dropping
the unfriendly API would be nice.

> Please no. snprintf() is standardized, has sane semantics (though one

No, it doesn't -- it has well-defined semantics, but using it
correctly is too hard. It's a regular source of bugs. (Not *nearly* as
bad as strncpy, so let's stick to dropping one bad API at a time...)

> sometimes _want_ scnprintf semantics - in which case one can and should
> use that...), and, importantly, gcc understands those semantics. So we
> get optimizations and diagnostics that we'd miss if we kill off explicit
> snprintf and replace with non-standard howmuch+scnprintf.

Those diagnostics can be had with the __printf() markings already...

> > So scnprintf() does the right thing (count of non-NUL bytes copied out).
>
> The right thing, when that's the thing you want to know. Which it is in
> the "build a string in a buffer by repeated printf calls, perhaps
> intermixed with a little flow control logic". But not so in a "format
> this stuff to this fixed-size char buffer inside that struct, and let me
> know [i.e., 'give me a way of knowing'] if it all fit".

Do we need ssprintf() to get the -E2BIG result like strscpy()?

> Hello, I'm you super-fantastic-one-size-fits-all string copying API.
> Please carefully fill out the following form, and I'll get back to you ASAP.

I mean, this is kinda what we have already. We just keep exposing too
many knobs. :)

-- 
Kees Cook
