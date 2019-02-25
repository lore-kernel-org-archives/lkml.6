Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B37820652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dQ8LzOSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfBYPlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:41:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37765 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfBYPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:41:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id a17so7804556ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VhsyAoVHdYBlUHGBZ+3CvAdqBwtWnCM3YOuJlgJl7rU=;
        b=dQ8LzOSSq80RzB7B7C1KC7Hg+bGM+2Xnda8MKZ/k/s4JvkVrR69VvqZoTlNdwkHxK5
         vG/Y6IY4XSroRFHu0TFexC6TzTPQAwamg3DMbK2+oxfFnkwcT9jH7OW3qFuXPOxtV7Pv
         cmktc4VRDPa1qzk4PImwKMG7d0sfdF0Gy+sfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VhsyAoVHdYBlUHGBZ+3CvAdqBwtWnCM3YOuJlgJl7rU=;
        b=e75GJLUJYuqMHtpWH0FM+Nk2c94WDT6pxcNWOx/Jny+jVhPoMI4Cwh56YG5fpe/MUA
         9kKWoP+xljc8iphJ+gzOvTvfEuGLry+HB1KOXE3VSVZrYatFcfUoZmIv1PEtxEWtPadW
         4uap+kDGY5QuDv9lwVw7ZskQEFEDrw4t0vk7Xw0Dhln69FShUbpf0DtG8u1H44q1M/yI
         DnDCEb6tmYdXWX6aej1TWCN9juz2kovek2DfHqhDB2ZhuihLUgGHbC4zeMixDM26paoe
         t5TNQDTz4Ckheie/Izroj3lMmud4DrJ+q5H4hXruEZTj9qjivDCNpr9h+KkskdSSSYxL
         kgmg==
X-Gm-Message-State: AHQUAuYKCY4BAo4cjUVSne29XUK+1mWwS+vuRAX6fFEOgNb7KcP9Q5YL
        Brp8E1/YKGraD/R7Gv67/aFuHw==
X-Google-Smtp-Source: AHgI3IayZ64rB7Qp5uWLlU0Ow7Bd5D9H3OUnsEhnakIyvtX32c7cIbZEyZn1bpLfSzmsOxWF1dbCNw==
X-Received: by 2002:a2e:890b:: with SMTP id d11mr10998771lji.174.1551109276736;
        Mon, 25 Feb 2019 07:41:16 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h26sm2410855ljf.5.2019.02.25.07.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:41:16 -0800 (PST)
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
 <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
 <20190221052435.GF11758@eros.localdomain>
 <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
 <8f002798-f68b-14cd-d321-f96b653fb51d@rasmusvillemoes.dk>
 <CAGXu5j+4ia0OLHop81D8D4eSJV6765hr-m=3LPeL2490ER++Hg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <39f5b81f-16b3-19d6-86b5-cc2ab6bc45ea@rasmusvillemoes.dk>
Date:   Mon, 25 Feb 2019 16:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+4ia0OLHop81D8D4eSJV6765hr-m=3LPeL2490ER++Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2019 00.03, Kees Cook wrote:
> On Thu, Feb 21, 2019 at 6:58 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 21/02/2019 07.02, Kees Cook wrote:
>>
> 
>>> ... snprintf returns what it WOULD have written, much like strlcpy
>>> above. At least snprintf has an excuse: it can be used to calculate an
>>> allocation size (called with a NULL dest and 0 size) ... but shouldn't
>>> "how big is this format string going to be?" be a separate function?
>>
>> Why? Sure, you can make a wrapper vhowmuch(const char *fmt, va_args ap),
>> but its implementation would have to be "return vsnprintf(NULL, 0, fmt,
>> ap);", since we really must reuse the exact same logic for computing the
>> length as for doing the actual printf'ing (otherwise they'd get out of
>> sync).
> 
> Well, I'd likely go the opposite directly: make snprintf() a wrapper
> and call vhowmuch(), etc, convert until snprintf could be removed.But
> really the best might be removal of snprintf first, then refactor it
> with vhowmuch() etc. Lots of ways to solve it, I suppose.

I'd really like to see how vsprintf.c would look in a world where the
workhorse (which is vsnprintf() and its tree of helpers) would not
format and measure at the same time.

But dropping
> the unfriendly API would be nice.
> 
>> Please no. snprintf() is standardized, has sane semantics (though one
> 
> No, it doesn't -- it has well-defined semantics, 

We'll just have to disagree on what sane means.

> but using it
> correctly is too hard. It's a regular source of bugs. (Not *nearly* as
> bad as strncpy, so let's stick to dropping one bad API at a time...)
> 
>> sometimes _want_ scnprintf semantics - in which case one can and should
>> use that...), and, importantly, gcc understands those semantics. So we
>> get optimizations and diagnostics that we'd miss if we kill off explicit
>> snprintf and replace with non-standard howmuch+scnprintf.
> 
> Those diagnostics can be had with the __printf() markings already...

No. You're thinking of the type-checking things. Those are important, of
course, but have nothing at all to do with the s or n parts of snprintf
- what I'm thinking of is the fact that gcc knows that buf is a
char-buffer of length len into which snprintf() may/will write, so we
have the Wformat-truncation and Warray-bounds kind of warnings. And the
optimization part is where gcc can replace a snprintf() with a simpler
string op (e.g. a memcpy), or know that an overflow check can be elided
because "%d" does fit in the buf[16], or...

One thing I've had on my wishlist for a long time is a
buffer_size(ptrarg, expr, r/w/rw) attribute that would say that the
function treats the pointer argument ptrarg as a buffer of size given by
the expr (in bytes), and accesses it according to the third parameter.
Then the compiler could automatically check with its builtin_objsize
machinery for mismatched buffer size computations (e.g., using sizeof()
when the interface expects ARRAY_SIZE()) violations or uninitialized
reads, or any number of optional run-time instrumentations in caller or
callee... So

memcpy(void *dst, const void *src, size_t len) __buffer_size(dst, len,
"w") __buffer_size(src, len, "r")

or

int poll(struct pollfd *fds, nfds_t nfds, int timeout)
__buffer_size(fds, nfds*sizeof(struct pollfd), "rw")

the latter being an example of where an arbitrary expression in terms of
the formal parameters is needed - but I don't think gcc's attribute
machinery supports this syntax at all.

Bonus points if one could attach buffer_size to a struct definition as
well, saying that the ->foo member points to ->bar*4  of storage.


Rasmus
