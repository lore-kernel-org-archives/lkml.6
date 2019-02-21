Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2609C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63F82070D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="be/bRuAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfBUO6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:58:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35615 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfBUO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:58:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so14408000edp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KcdUqfPKkkpFXfiYtqVBl1dsYDtnyxf4aPk2KIt6Af0=;
        b=be/bRuAPZJwTnk/PdHvWdyu702jt54ld07apKgKKWoHrAuVDHHCUUQFkepQMwgYzCr
         0DgH7cBKhcDTy9BTVuPdE0DpO44jUh7X7nSbKRJDxyUQFPZIaSFm/0ZHzzcRA9TRyvjh
         uvSkzmVuSKi6FAficmK/CjpKE2LKTxDA7/HVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KcdUqfPKkkpFXfiYtqVBl1dsYDtnyxf4aPk2KIt6Af0=;
        b=EVVyynwLbBEVcE+rOel2hOkHCrBP2WZkLuJCwwBX6ntXN3JTqm4z7/2iB9/2lD4AQV
         mNusQD+IjKJd3Yz0vd9Wvw+uxDoXw3jCRt4iqGAJAB1e9N1Yob8QUCP3WYxI5F1lQPA6
         bT564nsWzwU5xaYBCYLnTtzhbMtcBXMZI/Ew1Sl4hpMS5WbY+Y9u+5aXYy0/O2rifcym
         Pv6QaHwZNLKfj2em3eHYNysXia1KHqDAwJ8ctRasRIe/Esy32yRlebVzwiPOJ3ViKWql
         MGdslJEdR6ScVNTl/B1mhQZabdwnwHstFfRmVXATVGBiYTS4AOjiVlD4pCrmPRAZLt6B
         DPqQ==
X-Gm-Message-State: AHQUAuZ+RvtpggETtg4ZLiMhHeLA+QWL1p5v5zk9IfRXAogIgabsewG1
        rSJ9Pt8A3BhijjkEOpBVVRRV+g==
X-Google-Smtp-Source: AHgI3Iawkad6yx4qknSgZ1Hhl3bsGGx2aA+Umwfd+RIMpRfgHVz5QYEPMneUXT+CldSx57ew1WfKng==
X-Received: by 2002:aa7:d685:: with SMTP id d5mr18519406edr.203.1550761109338;
        Thu, 21 Feb 2019 06:58:29 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-117-145.cgn.fibianet.dk. [5.186.117.145])
        by smtp.gmail.com with ESMTPSA id v4sm485203ejj.4.2019.02.21.06.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 06:58:28 -0800 (PST)
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     Kees Cook <keescook@chromium.org>, "Tobin C. Harding" <me@tobin.cc>
Cc:     Jann Horn <jannh@google.com>,
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
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
 <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
 <20190221052435.GF11758@eros.localdomain>
 <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8f002798-f68b-14cd-d321-f96b653fb51d@rasmusvillemoes.dk>
Date:   Thu, 21 Feb 2019 15:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 07.02, Kees Cook wrote:

> P.S. Here's C string API Rant (I just had to get this out, please feel
> free to ignore):

I'll bite. First, it's "linux kernel string API", only some of string.h
interfaces are in std C. Sure, none of those satisfy all use cases, but
adding Yet Another One also has its costs.

> strcpy returns dest ... which is already known, so it's a meaningless
> return value.
> 
> strncpy returns dest (still meaningless)

Yeah, same for memcpy, memset. Those are classic C interfaces. It does
allow some micro-optimizations in some cases - since one is likely to
continue doing other stuff with dest, the compiler might use the fact
that it has dest in the return register instead of spilling and
reloading it. But I do wonder what the real rationale was.

> strlcpy returns strlen(src) ... the length we WOULD have copied. Why
> would we care about that? I'm operating on dest. Were there callers
> that needed to both copy part of src and learn how long it was at the
> same time?

The rationale is exactly the same as for snprintf - to allow you to
optimistically format/copy to a buffer, and know exactly how much to
realloc() in case it turned out to be too small. Of course, nobody ever
uses strlcpy like that, since just doing strdup() is much much simpler
and less error-prone. So yes, strlcpy() is often a silly interface to use.

> strscpy returns -E2BIG or non-NUL bytes copied: yay, a return about
> what actually happened from the operation!

Well, strictly speaking, strlcpy()'s return value also tells you exactly
what happened, just not in the kernel "negative errno for error
condition" style.

> ... snprintf returns what it WOULD have written, much like strlcpy
> above. At least snprintf has an excuse: it can be used to calculate an
> allocation size (called with a NULL dest and 0 size) ... but shouldn't
> "how big is this format string going to be?" be a separate function?

Why? Sure, you can make a wrapper vhowmuch(const char *fmt, va_args ap),
but its implementation would have to be "return vsnprintf(NULL, 0, fmt,
ap);", since we really must reuse the exact same logic for computing the
length as for doing the actual printf'ing (otherwise they'd get out of
sync).

> I wonder if we can kill all kernel uses of snprintf too (after
> introducing a "how big would it be?" function and switching all other
> callers over to scnprintf)...

Please no. snprintf() is standardized, has sane semantics (though one
sometimes _want_ scnprintf semantics - in which case one can and should
use that...), and, importantly, gcc understands those semantics. So we
get optimizations and diagnostics that we'd miss if we kill off explicit
snprintf and replace with non-standard howmuch+scnprintf.

> So scnprintf() does the right thing (count of non-NUL bytes copied out).

The right thing, when that's the thing you want to know. Which it is in
the "build a string in a buffer by repeated printf calls, perhaps
intermixed with a little flow control logic". But not so in a "format
this stuff to this fixed-size char buffer inside that struct, and let me
know [i.e., 'give me a way of knowing'] if it all fit".


Hello, I'm you super-fantastic-one-size-fits-all string copying API.
Please carefully fill out the following form, and I'll get back to you ASAP.

A1: destination
A2: max bytes to write
B1: source
B2: max bytes to read
C1: do you want me to nul-terminate the destination?
C2: if C1, should that be done by truncating the result if necessary?
C3: how do you want me to handle leftover space in dest, if any?
C4: should the destination be left entirely untouched in case the result
does not fit?
C5: is it an error if I do not encounter a nul byte somewhere in [B1,
B1+B2-1] ?
C6: how do you want me to report on the results of my efforts and my
discoveries?
C7: are there any special conditions I should take into account?
(overlapping buffers, allergies, ...)

Put -1 under A2 to mean "assume there's room enough". Put -1 under B2 to
mean "assume there's a nul byte before walking into lala-land".

Answering yes to C1 and C2 and writing 0 under A2 causes your CapsLock
to stay permanently on. If there's any ambiguity in your answer to C6,
the machine reboots.


Rasmus
