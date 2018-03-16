Return-Path: <kernel-hardening-return-12657-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt85hEk8QpcEYacc4xxMfcyLf5pa37gtmaaU+wq/s+Ok166gFRvxBRgjDmp9CZPz7p0FVA7
ARC-Seal: i=1; a=rsa-sha256; t=1521169596; cv=none;
        d=google.com; s=arc-20160816;
        b=QxeDj5RCCaP6jIkh9PiIo92hIpwF3aslvnPGZda+zNeRGD4YaYygMztxMwf0ymqod/
         Fz1ORPl3ngcdnS0tKVBVoujPHbzM01JldC9YlgMtPFHW9rC8gDKhwJGSzYqoFFPXCvpF
         4rxs/kjbd6AA2Jmgw1ZCoY2tBgCeUfVfNX4hx4HE2vgriAUIbUyuf9cJhfSmgIKS8/8Q
         whAlSaY7CW8nDVHg7oa1hFBYC56puxHyT3KtJca5BWEw8mL0PCKqxPZOTatjTew4F5Df
         gBNJ2y2RRCRT1nEmZxBMgld8lDYmX1vm6fGjq1tYN5z+N/It37SiqMapX5pQ/7HYZlVj
         RY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=rLlwbIVv2/gQRr1IYs3KiOOlrb9zOM/F7j/LtPT9eQQ=;
        b=C8gczFOjDRUHoZsgFsBx5QdUzRybw9Bpfgp/Odz9IeI+Q8opMeUFSgrhQ3/HmDdwa5
         VH/uH/Vm3mVl9ZlZQIUt7IWKUINxUKj8fp9nw3J3Ak+kvhzDUxHtNty1GEwGvppxF54v
         ydFmBIsjhXsaStnEbTSoLxiomn5H4Nn/ODmiWjCfwObPDFb4gQnE822XwL59nIYE3ref
         /dHax1C1/zvdqMiHhV6VBNh7tZFB16j9yQBZchIhxNaH82lCl2ij0lJAO/rSXi5yyr5I
         yUFiwPhUfA48n7PlWuEWj5TENMX9zRAU+vmaf0AlGG/0i9ilMXsvkq1R1cwPDC4BNJU8
         rVsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PIm35ji4;
       spf=pass (google.com: domain of kernel-hardening-return-12657-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12657-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PIm35ji4;
       spf=pass (google.com: domain of kernel-hardening-return-12657-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12657-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+Dv_wQgHWgT=9eSoKX7AcqnumuRsNFUoZ765WWizKytw@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
 <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
 <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
 <CA+55aFzO12QMFJHe8osoWfph8jnjgp_jLUQWmgbNmth_KwPxXw@mail.gmail.com>
 <CAGXu5jLHW00UmSDyAmdLpin6L636XbP3brH=pn4qh1bN87AirA@mail.gmail.com>
 <CA+55aFyRV9KXzeQZpVYsZYVUJm-ASgu_4_1+8Y8-0KH-YT2M8Q@mail.gmail.com> <CAGXu5j+Dv_wQgHWgT=9eSoKX7AcqnumuRsNFUoZ765WWizKytw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 16 Mar 2018 04:05:55 +0100
Message-ID: <CANiq72m6OuzN_gDiEhpLXY+2=5=m=1s5U-kDe=xpJmOVyE+hSg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595061931309480379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 12:49 AM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Mar 15, 2018 at 4:46 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> What I'm *not* so much ok with is "const_max(5,sizeof(x))" erroring
>> out, or silently causing insane behavior due to hidden subtle type
>> casts..
>
> Yup! I like it as an explicit argument. Thanks!
>

What about something like this?

#define INTMAXT_MAX LLONG_MAX
typedef int64_t intmax_t;

#define const_max(x, y)                                               \
        __builtin_choose_expr(                                        \
                !__builtin_constant_p(x) || !__builtin_constant_p(y), \
                __error_not_const_arg(),                              \
                __builtin_choose_expr(                                \
                        (x) > INTMAXT_MAX || (y) > INTMAXT_MAX,       \
                        __error_too_big(),                            \
                        __builtin_choose_expr(                        \
                                (intmax_t)(x) >= (intmax_t)(y),       \
                                (x),                                  \
                                (y)                                   \
                        )                                             \
                )                                                     \
        )

Works for different types, allows to mix negatives and positives and
returns the original type, e.g.:

  const_max(-1, sizeof(char));

is of type 'long unsigned int', but:

  const_max(2, sizeof(char));

is of type 'int'. While I am not a fan that the return type depends on
the arguments, it is useful if you are going to use the expression in
something that needs expects a precise (a printk() for instance?).

The check against the INTMAXT_MAX is there to avoid complexity (if we
do not handle those cases, it is safe to use intmax_t for the
comparison; otherwise you have to have another compile time branch for
the case positive-positive using uintmax_t) and also avoids odd
warnings for some cases above LLONG_MAX about comparisons with 0 for
unsigned expressions being always true. On the positive side, it
prevents using the macro for thing like "(size_t)-1".

Cheers,
Miguel
