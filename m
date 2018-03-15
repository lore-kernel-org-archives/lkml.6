Return-Path: <kernel-hardening-return-12645-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvD5SwvsiHJjoRJuaMQaEzaTjLBnhJhzznUdP7rFTZBq2Ws0vpooRWRlsAY2uXiTNl5uUAY
ARC-Seal: i=1; a=rsa-sha256; t=1521152615; cv=none;
        d=google.com; s=arc-20160816;
        b=C849f9nVCDHPqzjct4bKK/+WdDnEZ/uZI0xQPLVNE1iQKBOYCAc4ELNPuhaNWPansL
         I93N/Qcr5iXs/s24CLVV38cdWNbqqrkru1kPhQQ/rbMuMPGQyp+mX7u6DAJbc5cOZd5G
         vq4s11ArUWwTSPQ8q5YFpRo4HChfEXlBNW3/xVcXvaen7CxwDfjOx+b8TU+BjUzYQaXy
         0AKK5GcgA0K3lmwClNHAA4NTgPrk9LIE9L4EXZhKYLuFUT1cpdMFdeOvOBtAiFsxmlR/
         tSH58tvZatOLNxHlXlH5Y01MJiXOsGkHG6ccFxVySPXmqM2JCNCiIvHlTKUNhev+/JUx
         xMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Cez1zEpreN1Vk/r9enALs7bHkg6YmExNnhFqCw7Kp8M=;
        b=pw5L4njCb0sYVht/3YViHfVnWDoQYK+UTNScKzOymcCdZUf6C9SBcMTEkLJkAw7Otn
         p2Uslc57/dyq+H7E7GQYcT01YKa+7wXA5jOHBnB+qlYwlH0EQHDukQu1clWQofnkpns/
         EwT23NuaisxjJQu0DYJNjAgXGfgD6mmvza4IbhWnLlABezpP1+phRCSgE5RFxcofPk1Z
         5knE3q3Xg21QoTOeW/DO18jDICVC8e1p7ynNJ171EtV/+XvM6XguogBypPOdm8SoXWV4
         vV/OXrsl4b0QF98Il0OiXArKpPVRrfSO5Hft0hlX0l176miIKT0h3rSm++uQJGBZY6dy
         nLuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LHW3X22s;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=a+8d8tb+;
       spf=pass (google.com: domain of kernel-hardening-return-12645-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12645-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LHW3X22s;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=a+8d8tb+;
       spf=pass (google.com: domain of kernel-hardening-return-12645-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12645-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 15:23:16 -0700
X-Google-Sender-Auth: 7a2gwQUnA_4ut7OceWLIYtPTcjc
Message-ID: <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034361293703830?=
X-GMAIL-MSGID: =?utf-8?q?1595044125766934122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 3:16 PM, Kees Cook <keescook@chromium.org> wrote:
>
> size_t __error_not_const_arg(void) \
> __compiletime_error("const_max() used with non-compile-time constant arg");
> #define const_max(x, y)                                         \
>         __builtin_choose_expr(__builtin_constant_p(x) &&        \
>                               __builtin_constant_p(y),          \
>                               (typeof(x))(x) > (typeof(y))(y) ? \
>                                         (x) : (y),              \
>                               __error_not_const_arg())
>
> Is typeof() forcing enums to int? Regardless, I'll put this through
> larger testing. How does that look?

Ok, that alleviates my worry about one class of insane behavior, but
it does raise a few other questions:

 - what drugs is gcc on where (typeof(x)(x)) makes a difference? Funky.

 - this does have the usual "what happen if you do

     const_max(-1,sizeof(x))

where the comparison will now be done in 'size_t', and -1 ends up
being a very very big unsigned integer.

Is there no way to get that type checking inserted? Maybe now is a
good point for that __builtin_types_compatible(), and add it to the
constness checking (and change the name of that error case function)?

          Linus
