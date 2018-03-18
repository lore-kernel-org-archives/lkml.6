Return-Path: <kernel-hardening-return-12694-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvKJ3I1pWMFfRmwLjIlXmSb9qyYM/rfCeieynXTinuC5E0Mv0F7o4xbnKVmky3A/4TMiZ8A
ARC-Seal: i=1; a=rsa-sha256; t=1521408823; cv=none;
        d=google.com; s=arc-20160816;
        b=x1V0PSTf5E5s5hC9/N47bsNbSYmw+leMyHG/iOTH6H8F6p+zd/JY4y9iR1R8tFRG/9
         OWinIlOcnUPTCBVIbyXyrcRogn6FLPrc4YfzxEdoRMr0oXgBNGWnslVJ8GonJcfoTPoA
         qSd8uCd/tIGFKPeEL5smAb8Zod6MINYhJ3V42f0bdLrd+mPfijX6B+iB1hBlIM+pQ80J
         akRv2Xt8h+VaeFLYej07TFwsB1liNgJjTQ8LoRFW9iKGuvZMEM7XHc/qx0NMHTBKOWdG
         kSzGwl1/aqmTI8Fms+nCJCCCJO1pb42N30db3tWxBrTZyfz2TwbyE626u5AM8QzMK878
         w5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=wNizOT6HONS2DW5gzlP0xlyT2p8aQEuxrrEymSWTJRY=;
        b=c5LQNYDni120WrtymFwDceHW/w07a/Y0h7y3ytcqOpmCLBxGKGRz91Rf3vAniCPhBH
         F+2igTob8qsBH4hw/KT7y4bIAaPQU3ErG7qV2rddtUoTBTfAiDg6Kqe9myectbcfWz8t
         cWCJDlO8vuLLH2XcZ+R8eQf2aDcLE7jBYNtdlkRmIxJBLbBGkC6B5vuUZ3xiqiVujgER
         Ain/oma1YcAWurqrYur5kyGpAyXHpwPIB3WdXHqmURRVjQlbiRtAGp9HxGXcFOnFMCFr
         cVN6pSBx2yin2G6JHWCqjQqBmvWA1krTbpYJRcb9iqPM7wxlWu6L784Exg0P8KDKmCrt
         zh/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fvEMTa5T;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=WfwBeNAk;
       spf=pass (google.com: domain of kernel-hardening-return-12694-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12694-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fvEMTa5T;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=WfwBeNAk;
       spf=pass (google.com: domain of kernel-hardening-return-12694-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12694-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com> <42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Mar 2018 14:33:23 -0700
X-Google-Sender-Auth: Mccg8ClxyZvlW7FTSlowcGl4-1Q
Message-ID: <CA+55aFwFoTapX2niPiaET5kg7K85qxhav1_PoDDxY0o_VRA5Ag@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Florian Weimer <fweimer@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595312778086538132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 2:13 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 2018-03-17 19:52, Linus Torvalds wrote:
>>
>> Ok, so it really looks like that same "__builtin_constant_p() doesn't
>> return a constant".
>>
>> Which is really odd, but there you have it.
>
> Not really. We do rely on builtin_constant_p not being folded too
> quickly to a 0/1 answer, so that gcc still generates good code even if
> the argument is only known to be constant at a late(r) optimization
> stage (through inlining and all).

Hmm. That makes sense. It just doesn't work for our case when we
really want to choose the expression based on side effects or not.

> So unlike types_compatible_p, which
> can obviously be answered early during parsing, builtin_constant_p is
> most of the time a yes/no/maybe/it's complicated thing.

The silly thing is, the thing we *really* want to know _is_ actually
easily accessible during the early parsing, exactly like
__builtin_compatible_p(): it's not really that we care about the
expressions being constant, as much as the "can this have side
effects" question.

We only really use __builtin_constant_p() as a (bad) approximation of
that in this case, since it's the best we can do.

So the real use would be to say "can we use the simple direct macro
that just happens to also fold into a nice integer constant
expression" for __builtin_choose_expr().

I tried to find something like that, but it really doesn't exist, even
though I would actually have expected it to be a somewhat common
concern for macro writers: write a macro that works in any arbitrary
environment.

I guess array sizes are really the only true limiting environment
(static initializers is another one).

How annoying. Odd that newer gcc's seem to do so much better (ie gcc-5
seems to be fine). So _something_ must have changed.

                 Linus
