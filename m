Return-Path: <kernel-hardening-return-12646-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu8iFVFp8PZu4H+BidgznNnu4MQH5XvbyAn5qmZ96GiPS6s7z8EoSe18GmA2Jv1+LvV0a+6
ARC-Seal: i=1; a=rsa-sha256; t=1521154001; cv=none;
        d=google.com; s=arc-20160816;
        b=jk777efjucz/7bUSQl2J5w/lqjaXaER6Fgsw46wCjjLbAc+EPEJTlBJtWfwOR2cfwZ
         oJipG0cxng8nxOzEb7M6zND5u/7n2qSx0mvBxGp7IXryI7Ey71g7QdlokRXKp7GXVTME
         bfGp2HCWHELH+OosVpIoo3u+5tkJP1nvaxR7RjKItt1WsOmwtcTfYaO1Zx3YSZUUJVb2
         wqDlyHzL3sS/JDjebPjiqCJO8D/wvi5d7xLdYs9+JIkvlAYRLs34qcLIte025yeIDkfJ
         T/Nd3UTD87GcgFm7NO+6Q0hWsaVx/3a6WE6InL4P7Rd03kklyHcquJTPTOk0b6q3aOH1
         oiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=stQyrmotWiOD8n8XDEvVIZwJGN3jZW9lSK8XliOTdaU=;
        b=gBl+1dhGiR8veQi8d7xWJHokam/P8mX10/Mjue43zo+2SFlW+MgitvaMWEzdUJ33ms
         p/SyvjtCB8AtzDucxrv6Sa5Qq0nmSqRXdVc9xafZs3PutrUW9uIxUiLSFlBzhUMBDfxn
         4A3fojKnJOR+fv3hECTvO4gTpdGWPI6XL/xDMDXjrmC0zsShNIPJvgYm8NKBqpWUVd87
         Rio6clh27bVrzJK7XBVjyRmzmMoJSKi3jIjzf+WYNb35J4VdQM0U3Oy156AUPnUwYgFZ
         KkwGU1MEhfCEWaqmw7OgOXs7QEMu3PkA/tAucZnsOHIMaCJFowneWQ/EmAdmYqRs3l9r
         WHTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=EdkmPqE2;
       dkim=pass header.i=@chromium.org header.s=google header.b=fIbi+nSr;
       spf=pass (google.com: domain of kernel-hardening-return-12646-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12646-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=EdkmPqE2;
       dkim=pass header.i=@chromium.org header.s=google header.b=fIbi+nSr;
       spf=pass (google.com: domain of kernel-hardening-return-12646-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12646-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com> <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Mar 2018 15:46:21 -0700
X-Google-Sender-Auth: DXGlTpE7D59Ksf-bvhmjc70zqVg
Message-ID: <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Linus Torvalds <torvalds@linux-foundation.org>
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
X-GMAIL-MSGID: =?utf-8?q?1595045577729399948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 3:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Mar 15, 2018 at 3:16 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>> size_t __error_not_const_arg(void) \
>> __compiletime_error("const_max() used with non-compile-time constant arg");
>> #define const_max(x, y)                                         \
>>         __builtin_choose_expr(__builtin_constant_p(x) &&        \
>>                               __builtin_constant_p(y),          \
>>                               (typeof(x))(x) > (typeof(y))(y) ? \
>>                                         (x) : (y),              \
>>                               __error_not_const_arg())
>>
>> Is typeof() forcing enums to int? Regardless, I'll put this through
>> larger testing. How does that look?
>
> Ok, that alleviates my worry about one class of insane behavior, but
> it does raise a few other questions:
>
>  - what drugs is gcc on where (typeof(x)(x)) makes a difference? Funky.

Yeah, that's why I didn't even try that originally. But in looking
back at max() again, it seemed to be the only thing missing that would
handle the enum evaluation, which turned out to be true.

>  - this does have the usual "what happen if you do
>
>      const_max(-1,sizeof(x))
>
> where the comparison will now be done in 'size_t', and -1 ends up
> being a very very big unsigned integer.
>
> Is there no way to get that type checking inserted? Maybe now is a
> good point for that __builtin_types_compatible(), and add it to the
> constness checking (and change the name of that error case function)?

So, AIUI, I can either get strict type checking, in which case, this
is rejected (which I assume there is still a desire to have):

int foo[const_max(6, sizeof(whatever))];

due to __builtin_types_compatible_p() rejecting it, or I can construct
a "positive arguments only" test, in which the above is accepted, but
this is rejected:

int foo[const_max(-1, sizeof(whatever))];

By using this eye-bleed:

size_t __error_not_const_arg(void) \
__compiletime_error("const_max() used with non-compile-time constant arg");
size_t __error_not_positive_arg(void) \
__compiletime_error("const_max() used with negative arg");
#define const_max(x, y)                                                 \
        __builtin_choose_expr(__builtin_constant_p(x) &&                \
                              __builtin_constant_p(y),                  \
                __builtin_choose_expr((x) >= 0 && (y) >= 0,             \
                                      (typeof(x))(x) > (typeof(y))(y) ? \
                                        (x) : (y),                      \
                                      __error_not_positive_arg()),      \
                __error_not_const_arg())

-Kees

-- 
Kees Cook
Pixel Security
