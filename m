Return-Path: <kernel-hardening-return-12651-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELta/j5NJshFRN8hAtfUhhWFl0hkYieKVtbNOaRK0j8d5qqcNz3S5tCKg/M9GGF2TuF8C8og
ARC-Seal: i=1; a=rsa-sha256; t=1521156741; cv=none;
        d=google.com; s=arc-20160816;
        b=BAT4zLCSirLAwjaZPPo0HwmzlPbMZ0aZNDSgzbbK2Gq9NPu74hfWM2BTlSaWHMUGjq
         jLu5SwVxxUPILPqWKcZ+a2fEZ8WuJ2XLSOls7l57xTdB+6YJP3WDcF/VuBPDPoS2ByHK
         4iECJLGvGJrITHbPoWfZG84BTKmnVNM1kPvKs0QI/PrUmgNdFtbQN8WdqQyfB+VpCy+Z
         9pKz5XA+e4Aiao5nzQFcqEWwYB31Q7WA3wuByBbMb6OO8GSk6YBBCU3vzo0oKFm1SZV2
         wrcXfrJv6VZoii99v67qvh8pEh92brAQCA4iZ/MiLM+qR8hmeHnHM6CyYcYCZjGmK91Z
         CAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=0/jBFNCPDppjY2eX8ERo2+/prGR50DjnicclgfR6ZaM=;
        b=E43XDBHAApc5KkFt+6qKQCKv0OYpqVEbkm/V8UK1s/N1Cj9Qlm4dIjfbRpTn+Z/iZQ
         xlsU8TRwJsKHnD/c7X7BtjwhPCW5TxbmQUrFpeAtz+XQjnMwaVa8+VxI9a99+ZlgHivF
         BLtf2TDzBLFFLH2dM6GERuNyQuAYR11uWIpGYbk6woffj/Ls3Kei7Nqb8jJyizPJHDwC
         rcRNCwd2vasTEPRqUSVXVk8LfgLR4aFFA+LFF7b73SpqHZsOnryCghPVvWx/ap9hZVg4
         fieVvYqbI2lwWQotrrs8Lq9LckId86Aky93FWWc4Dkhh6lOgBTwFlLuiBwcKanjz4HER
         kshw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=U7AMv40A;
       dkim=pass header.i=@chromium.org header.s=google header.b=TeS2vHSl;
       spf=pass (google.com: domain of kernel-hardening-return-12651-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12651-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=U7AMv40A;
       dkim=pass header.i=@chromium.org header.s=google header.b=TeS2vHSl;
       spf=pass (google.com: domain of kernel-hardening-return-12651-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12651-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CANiq72m7GEZS=Wkzg5KLkTnzW8vYz8X90OwVs4r5vcCCAp1-Pg@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
 <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
 <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
 <CANiq72k4qvXBy-VbFc5uOh-wAMx0yui5JokzX=NXtgZJ6F_NEg@mail.gmail.com>
 <CANiq72nEsno3JH=c_Xaf9gn1pJdM=ni6Z0ZUDqcEF07FT+SBSw@mail.gmail.com> <CANiq72m7GEZS=Wkzg5KLkTnzW8vYz8X90OwVs4r5vcCCAp1-Pg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Mar 2018 16:31:59 -0700
X-Google-Sender-Auth: q5aZ2kWBW2H6qujztmSVvBEuZtY
Message-ID: <CAGXu5j+T2v1R8monUJMdCYtU5hqB2mqxm_a1737bRQVAzwuC4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595048451461088973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 4:17 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>> The full one, using your naming convention:
>>
>> #define const_max(x, y)                                          \
>>     ({                                                           \
>>         if (!__builtin_constant_p(x))                            \
>>             __error_not_const_arg();                             \
>>         if (!__builtin_constant_p(y))                            \
>>             __error_not_const_arg();                             \
>>         if (!__builtin_types_compatible_p(typeof(x), typeof(y))) \
>>             __error_incompatible_types();                        \
>>         if ((x) < 0)                                             \
>>             __error_not_positive_arg();                          \
>>         if ((y) < 0)                                             \
>>             __error_not_positive_arg();                          \
>>         __builtin_choose_expr((x) > (y), (x), (y));              \
>>     })
>>
>
> Nevermind... gcc doesn't take that as a constant expr, even if it
> compiles as one at -O0.

Yeah, unfortunately. :(

-Kees

-- 
Kees Cook
Pixel Security
