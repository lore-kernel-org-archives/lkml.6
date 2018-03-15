Return-Path: <kernel-hardening-return-12647-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvlrmBCsrpeEjCfAXW83axG5/myNc7BGxmnOtWh8lOSyY2g7eRwpoGFeIpudm5B9adGhJIs
ARC-Seal: i=1; a=rsa-sha256; t=1521154731; cv=none;
        d=google.com; s=arc-20160816;
        b=Kq71zAIX0LxEU/7uVSXDZthVa9ergI4tRz574U9oQhlEQQlud4ioVDorLTJ46pKJK8
         qhrLJZYmZ42F+Mh+YGCLVg7Iysdl49lNyugHaq0q6EpDmSyffmXyObMB3PjvJflfQtuG
         9oYbbhz/+VvIgGi80HoOcjJEc9K4akoqDeYGb+G4ESIj2+fFprMv9Fk07KszOyS/p2li
         zXt5urVBpZmAZKg1weR3CpMCgR0Cyh8qyuy66VDIXddJ/EgNylkuS2o9wl0K0co8xZc6
         N6qbp8EMRuy5x3UVuUQBxrnZg9aOPEPiPzffbvZagxnxmqj2W8DloHCnPylJUZAaMYaX
         uY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=t5z3JOTzjsvEx0C1JfaHqEpOzxfVM3bJ0I0tusW5yQM=;
        b=ADJwCxAGpDwhVzUkz/7xeypsHFiNXbGzG0L1PJCPtH8Y1D1AuBPofONYQVBv48WY6S
         F9A2W9YskZIYs3T0KibNqPddUMseqIy5ocf0xGsf3XxCXx1QsVw7uSud6KIOiH62W+ji
         ipB+vURLGCI7OUDPFTX3eYF+v0rXrVYmfzXrwVnSAqE6IrMWXjZe5Xq7svbVRFU+cULy
         9QAYkOQXRnWgjpxFBdRrYuiysaWbeFJLYugOpHxPIsNQtAziOGgJ7GubYy+SoCYmRIWM
         x8ZaPN+JQutRr1KNxVqHGYA+Hdqq9ASBgoHegIooF1FX/zknyLKK+Y0Dr0b/y33BX0gO
         YZPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T15f9P9V;
       spf=pass (google.com: domain of kernel-hardening-return-12647-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12647-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T15f9P9V;
       spf=pass (google.com: domain of kernel-hardening-return-12647-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12647-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
 <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com> <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Mar 2018 23:58:10 +0100
Message-ID: <CANiq72k4qvXBy-VbFc5uOh-wAMx0yui5JokzX=NXtgZJ6F_NEg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595046344264822815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:46 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Mar 15, 2018 at 3:23 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Thu, Mar 15, 2018 at 3:16 PM, Kees Cook <keescook@chromium.org> wrote:
>>>
>>> size_t __error_not_const_arg(void) \
>>> __compiletime_error("const_max() used with non-compile-time constant arg");
>>> #define const_max(x, y)                                         \
>>>         __builtin_choose_expr(__builtin_constant_p(x) &&        \
>>>                               __builtin_constant_p(y),          \
>>>                               (typeof(x))(x) > (typeof(y))(y) ? \
>>>                                         (x) : (y),              \
>>>                               __error_not_const_arg())
>>>
>>> Is typeof() forcing enums to int? Regardless, I'll put this through
>>> larger testing. How does that look?
>>
>> Ok, that alleviates my worry about one class of insane behavior, but
>> it does raise a few other questions:
>>
>>  - what drugs is gcc on where (typeof(x)(x)) makes a difference? Funky.
>
> Yeah, that's why I didn't even try that originally. But in looking
> back at max() again, it seemed to be the only thing missing that would
> handle the enum evaluation, which turned out to be true.
>
>>  - this does have the usual "what happen if you do
>>
>>      const_max(-1,sizeof(x))
>>
>> where the comparison will now be done in 'size_t', and -1 ends up
>> being a very very big unsigned integer.
>>
>> Is there no way to get that type checking inserted? Maybe now is a
>> good point for that __builtin_types_compatible(), and add it to the
>> constness checking (and change the name of that error case function)?
>
> So, AIUI, I can either get strict type checking, in which case, this
> is rejected (which I assume there is still a desire to have):
>
> int foo[const_max(6, sizeof(whatever))];

Is it that bad to just call it with (size_t)6?

>
> due to __builtin_types_compatible_p() rejecting it, or I can construct
> a "positive arguments only" test, in which the above is accepted, but
> this is rejected:
>
> int foo[const_max(-1, sizeof(whatever))];

Do we need this case?

>
> By using this eye-bleed:
>
> size_t __error_not_const_arg(void) \
> __compiletime_error("const_max() used with non-compile-time constant arg");
> size_t __error_not_positive_arg(void) \
> __compiletime_error("const_max() used with negative arg");
> #define const_max(x, y)                                                 \
>         __builtin_choose_expr(__builtin_constant_p(x) &&                \
>                               __builtin_constant_p(y),                  \
>                 __builtin_choose_expr((x) >= 0 && (y) >= 0,             \
>                                       (typeof(x))(x) > (typeof(y))(y) ? \
>                                         (x) : (y),                      \
>                                       __error_not_positive_arg()),      \
>                 __error_not_const_arg())
>

I was writing it like this:

#define const_max(a, b) \
    ({ \
        if ((a) < 0) \
            __const_max_called_with_negative_value(); \
        if ((b) < 0) \
            __const_max_called_with_negative_value(); \
        if (!__builtin_types_compatible_p(typeof(a), typeof(b))) \
            __const_max_called_with_incompatible_types(); \
        __builtin_choose_expr((a) > (b), (a), (b)); \
})

Cheers,
Miguel


> -Kees
>
> --
> Kees Cook
> Pixel Security
