Return-Path: <kernel-hardening-return-12650-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtJteoUY/U7h5y6IaK47Kp+t+MIaxSqQwEjTB0+pEHdv2nMRw+Ihl9hCnjmAl141bmmczAa
ARC-Seal: i=1; a=rsa-sha256; t=1521155908; cv=none;
        d=google.com; s=arc-20160816;
        b=omUaFPe1IheIPJVEAhhmwiqyISXRPpxUFqGv8AT3cQeMxIXWFyA1wPq5F1eivsDLQs
         brKnBM6dza0E4Pc3f36Hc5zaJpKtttbuMBf6YsP8hhen8guXcrrj7/23FJuXCWBgWYld
         uk3WmneaOpWPA5OsNxkXK7uYxrNrPaW2piO/CXJ/pANOZWZGXydEsSt6F5Pi1QaNznMu
         tS/KfhXCSjt3suELFthu1rUQonRB/Aj/NIqSYiqzIXhJOFC8UDBr8qkkmIZXDt1SCUPr
         fFZ6gPMw3ShlImzAUdvlSd90dctm/O1m2qYbj5h58NyzOYo9ZqtUjLof7bl6DmlVlqOp
         ZwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=QyZoRbVQDKxP8OtaWjO1VRiFaCrA99s9Dko/z5x4Uw4=;
        b=P3x4/MGPds85RGfI1Vv6EZIHqhlKrR0ZjxZZ0X/Go3pmgU4pAg1VT+dfmOHVw0L4PQ
         w/TV++ZIWNbG+0/F5Z/SDhtffG0l+N8pQFGj10vJoVLWfoqS7i1pYfY9A4/danD0I1Yh
         yUScUMkTP4Kr23Cxw4uZLrE3lJrJhBX7GnfeNtBtEbHI0x1uPhLeB44YzpTXnKykhsvC
         nAsbXwkQhmkWUxV5V2F60sk8YyMnAdGFMvt+rZwAT4px6zjQ4fXKOLP2uKdP6XhWigMf
         HWden5EtPqlwhcz4fsMzzITfrtXPB1bCNJQzhb4X3clROoEsJ2+7bntBC0viTwVs4T2m
         ZuPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mcQVRvrQ;
       spf=pass (google.com: domain of kernel-hardening-return-12650-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12650-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mcQVRvrQ;
       spf=pass (google.com: domain of kernel-hardening-return-12650-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12650-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CANiq72nEsno3JH=c_Xaf9gn1pJdM=ni6Z0ZUDqcEF07FT+SBSw@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
 <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
 <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
 <CANiq72k4qvXBy-VbFc5uOh-wAMx0yui5JokzX=NXtgZJ6F_NEg@mail.gmail.com> <CANiq72nEsno3JH=c_Xaf9gn1pJdM=ni6Z0ZUDqcEF07FT+SBSw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 16 Mar 2018 00:17:50 +0100
Message-ID: <CANiq72m7GEZS=Wkzg5KLkTnzW8vYz8X90OwVs4r5vcCCAp1-Pg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-input <linux-input@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034361293703830?=
X-GMAIL-MSGID: =?utf-8?q?1595047577715476459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 12:08 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Thu, Mar 15, 2018 at 11:58 PM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> On Thu, Mar 15, 2018 at 11:46 PM, Kees Cook <keescook@chromium.org> wrote:
>>>
>>> By using this eye-bleed:
>>>
>>> size_t __error_not_const_arg(void) \
>>> __compiletime_error("const_max() used with non-compile-time constant arg");
>>> size_t __error_not_positive_arg(void) \
>>> __compiletime_error("const_max() used with negative arg");
>>> #define const_max(x, y)                                                 \
>>>         __builtin_choose_expr(__builtin_constant_p(x) &&                \
>>>                               __builtin_constant_p(y),                  \
>>>                 __builtin_choose_expr((x) >= 0 && (y) >= 0,             \
>>>                                       (typeof(x))(x) > (typeof(y))(y) ? \
>>>                                         (x) : (y),                      \
>>>                                       __error_not_positive_arg()),      \
>>>                 __error_not_const_arg())
>>>
>>
>> I was writing it like this:
>>
>> #define const_max(a, b) \
>>     ({ \
>>         if ((a) < 0) \
>>             __const_max_called_with_negative_value(); \
>>         if ((b) < 0) \
>>             __const_max_called_with_negative_value(); \
>>         if (!__builtin_types_compatible_p(typeof(a), typeof(b))) \
>>             __const_max_called_with_incompatible_types(); \
>>         __builtin_choose_expr((a) > (b), (a), (b)); \
>> })
>
> The full one, using your naming convention:
>
> #define const_max(x, y)                                          \
>     ({                                                           \
>         if (!__builtin_constant_p(x))                            \
>             __error_not_const_arg();                             \
>         if (!__builtin_constant_p(y))                            \
>             __error_not_const_arg();                             \
>         if (!__builtin_types_compatible_p(typeof(x), typeof(y))) \
>             __error_incompatible_types();                        \
>         if ((x) < 0)                                             \
>             __error_not_positive_arg();                          \
>         if ((y) < 0)                                             \
>             __error_not_positive_arg();                          \
>         __builtin_choose_expr((x) > (y), (x), (y));              \
>     })
>

Nevermind... gcc doesn't take that as a constant expr, even if it
compiles as one at -O0.
