Return-Path: <kernel-hardening-return-12274-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvLS+v2Df5FjbtZcpFev/IR31UawPaJjZGyVgLQdEkxaZMj6EtAXvoiZIRrDDqMFY3rvZV8
ARC-Seal: i=1; a=rsa-sha256; t=1520547685; cv=none;
        d=google.com; s=arc-20160816;
        b=pWhzTG39fVHA/shkh71Ekkwbo9UDVK6QYgrHT/UTl3h1j9VwD+JtL2nLlctKeyVyu7
         OYf722bmthOhInIWCu/RyBCRqmU+wWJziA+XijwIw1OuQvH5Zg292MZG4xcYq1+WROu2
         7JEIdHcwGA9jeicNB9/EM+WKC8QAWRWybtt6WzaA0st4R0LH74RJnxPpsTcgrRKTAlRP
         u5iX2l2Te/+sjAmaSFz43knlFIONFTjlRmBY4TuNPnEEFPBwO2X5gYk1tCHtL5ddpE0u
         N316DgldqrfLdK9jPPvbSEHr+b3+xOaK8TILKX1CBQrpva8g7/OAB1LvQBubepqFBjyE
         DdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=e1yME9x7OsFAUgT8AyayCgez1vOQ7g9j8M0mRgltoco=;
        b=yW+vHT9cjpZOxqW0bukmP+qLsBA5/NLGDJFFusPqsK4SkakGB34DgnSTl+12SFMO+0
         mdrsUfovRWvcNrNh2sJ6Uxyu2TYice2MfilkehCMvwq5pY4kXDoNd7aJkDHJdu8FsoWG
         MWAVMHc5Don5aAU6DAqffbaIxsFsmur5IF0LBkHcio5tAUm7sIj5lh3+Q7QHi1zm5O2a
         CEQl6IKVbdxRZJUg+0y/Sbr1t7AMJPFax4KeOiEcHat4IdS1j2VPeF1AnkqGpR5dBiGd
         bbuhHfHVGNaC35VKkjA/+oxSWYwlYIUAk+0sckMs2/Mcb2Xt/TOF80b5zHSQ8MYNeOb6
         pORg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=TGkpDriz;
       spf=pass (google.com: domain of kernel-hardening-return-12274-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12274-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=TGkpDriz;
       spf=pass (google.com: domain of kernel-hardening-return-12274-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12274-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKgDOezBGrYXCcy_UwM88rnT6pEpt9F062Q2qjf63KXBA@mail.gmail.com>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
 <20180308150236.5tysfbm3xdouii5n@treble> <78428dec-270e-5d74-0160-83feb5c0ff02@rasmusvillemoes.dk>
 <CAGXu5jKgDOezBGrYXCcy_UwM88rnT6pEpt9F062Q2qjf63KXBA@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 8 Mar 2018 23:12:10 +0100
Message-ID: <CAKwiHFhmc7FybX4pUg+Ozd6TC_W5BWtf-ztGUObZKW=BWgfi2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Remove accidental VLA usage
To: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	"Tobin C. Harding" <me@tobin.cc>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338745857869070?=
X-GMAIL-MSGID: =?utf-8?q?1594409809988701479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 8 March 2018 at 21:39, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Mar 8, 2018 at 11:57 AM, Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> On 2018-03-08 16:02, Josh Poimboeuf wrote:
>>> On Wed, Mar 07, 2018 at 07:30:44PM -0800, Kees Cook wrote:
>>> +extern long __error_incompatible_types_in_min_macro;
>>> +extern long __error_incompatible_types_in_max_macro;
>>> +
>>> +#define __min(t1, t2, x, y)                                          \
>>> +     __builtin_choose_expr(__builtin_types_compatible_p(t1, t2),     \
>>> +                           (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),    \
>>> +                           (t1)__error_incompatible_types_in_min_macro)
>>>
>>>  /**
>>>   * min - return minimum of two values of the same or compatible types
>>>   * @x: first value
>>>   * @y: second value
>>>   */
>>> -#define min(x, y)                                    \
>>> -     __min(typeof(x), typeof(y),                     \
>>> -           __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),   \
>>> -           x, y)
>>> +#define min(x, y) __min(typeof(x), typeof(y), x, y)                  \
>>>
>>
>> But this introduces the the-chosen-one-of-x-and-y-gets-evaluated-twice
>> problem. Maybe we don't care? But until we get a
>> __builtin_assert_this_has_no_side_effects() I think that's a little
>> dangerous.
>
> Eek, yes, we can't do the double-eval. The proposed change breaks
> things badly. :)
>
> a:   20
> b:   40
> max(a++, b++): 40
> a:   21
> b:   41
>
> a:   20
> b:   40
> new_max(a++, b++): 41
> a:   21
> b:   42
>
> However, this works for me:
>
> #define __new_max(t1, t2, max1, max2, x, y)                    \
>        __builtin_choose_expr(__builtin_constant_p(x) && \
>                              __builtin_constant_p(y) && \
>                              __builtin_types_compatible_p(t1, t2),     \
>                              (t1)(x) > (t2)(y) ? (t1)(x) : (t2)(y),    \
>                              __max(t1, t2, max1, max2, x, y))
>
> #define new_max(x, y) \
>         __new_max(typeof(x), typeof(y),                 \
>               __UNIQUE_ID(max1_), __UNIQUE_ID(max2_),   \
>               x, y)

Yes, that would seem to do the trick.

Thinking out loud: do we really want or need the
__builtin_types_compatible condition when x and y are compile-time
constants? I think it would be nice to be able to use max(16,
sizeof(bla)) without having to cast either the literal or the sizeof.
Just omitting the type compatibility check might be dangerous, but
perhaps it could be relaxed to a check that both values are
representable in their common promoted type. Something like

(type_signed(t1) == type_signed(t2)) || ((t1)x >= 0 && (t2)y >= 0)

should be safe (if the types have same signedness, or the value of
signed type is positive), though it doesn't allow a few corner cases
(e.g. short vs. unsigned char is always ok due to promotion to int,
and also if the signed type is strictly wider than the unsigned type).

Rasmus
