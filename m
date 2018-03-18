Return-Path: <kernel-hardening-return-12696-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsE2q/GGmMR8mKhZXPAk6wPM4WJh0FHGnRTuZQlA47vLEpNR2w83VA8/4PZif2jUOYVvUdV
ARC-Seal: i=1; a=rsa-sha256; t=1521416195; cv=none;
        d=google.com; s=arc-20160816;
        b=Jd7/NULCe9R+wDclC/pRFMiwfOkhB+qt3aUqbL6zo/YmPsYblH5kVHu5MFgHWKpaw2
         BumfE1FfIjZ8AKBgXBOi5y6ViVM9VkAymbMCpqvfpXfzlmmsX6rCTcZbrEOvhXnvYO2L
         9xo7WMevxhrZ+SZGReyiv1s1es0wRNvzyg0WezMCGEPZyWge2oDyGX/HTHAm4Q0UDV7Q
         xfmPra2lMd3zUHWyoq8OLm215m6f7DgfHZPk0BBMbae69JSy4DwMnTylgy7t9n2bbjtZ
         h3HkVqdV70IXcOzMA7apes+qq0pH4C0M0sZNW3z8RP+CUurwi+BSxPwjzV4iDqWb4+3O
         dSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=xMfObH6kvqBornuqqgH3WB9THwyft1+NriJ3DeIluog=;
        b=K567Xk+M/336t73LL5Nvro4vLHT1Wol+YBmEWYF7cjFH4/fhPl/lIdn3Ekt6H2CRcP
         DFw3u7ij4o1R+zwdzmRj7a2/N1vZ75HFF8jJYocjiLkk5f3sT1PrX66yu/I2UG81EmGw
         /9jcVfsX4CKfTLsoasKTz16EeVAibHumg0wWXaqXQwg7LPqIW6kKyAM0lbs1AoLi0Vkz
         3sZCkJqtV9tjcyVesnOngHfMnLRgcTc9C5T9RqDh9EZ7wLnOwVZRL2+OpC+tVHPwxoFD
         l33A74KkVPgOaGnsXHpskrlidmPKe5Dt45NdDokBXM6OvYZWS6TdprZh3wwiKDPQSHj5
         WVTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ACecg4ps;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=h4Iubc94;
       spf=pass (google.com: domain of kernel-hardening-return-12696-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12696-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ACecg4ps;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=h4Iubc94;
       spf=pass (google.com: domain of kernel-hardening-return-12696-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12696-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <38b6da49-1138-017e-7307-f39ff067d6d2@rasmusvillemoes.dk>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
 <42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk> <CA+55aFwFoTapX2niPiaET5kg7K85qxhav1_PoDDxY0o_VRA5Ag@mail.gmail.com>
 <38b6da49-1138-017e-7307-f39ff067d6d2@rasmusvillemoes.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Mar 2018 16:36:13 -0700
X-Google-Sender-Auth: WrBXlyLoOgHyL-34FBnr7MB5Dqg
Message-ID: <CA+55aFw0WC+S3TTE6x_vkLbRV6YLeR4-1S9LsBXhE+E2KZqBuA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595320509097555889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 3:59 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> OK, I missed where this was made about side effects of x and y

We never made it explicit, since all we really cared about in the end
is the constantness.

But yes:

> but I suppose the idea was to use
>
>   no_side_effects(x) && no_side_effects(y) ? trivial_max(x, y) :
> old_max(x, y)

Exactly. Except with __builtin_choose_expr(), because we need the end
result to be seen as a integer constant expression, so that we can
then use it as an array size. So it needs that early parse-time
resolution.

>> We only really use __builtin_constant_p() as a (bad) approximation of
>> that in this case, since it's the best we can do.
>
> I don't think you should parenthesize bad, rather capitalize it. ({x++;
> 0;}) is constant in the eyes of __builtin_constant_p, but not
> side-effect free.

Hmm. Yeah, but probably don't much care for the kernel.

For example, we do things like this:

   #define __swab64(x)                             \
        (__builtin_constant_p((__u64)(x)) ?     \
        ___constant_swab64(x) :                 \
        __fswab64(x))

where that "___constant_swab64()" very much uses the same argument
over and over.

And we do that for related reasons - we really want to do the constant
folding at build time for some cases, and this was the only sane way
to do it. Eg code like

        return (addr & htonl(0xff000000)) == htonl(0x7f000000);

wants to do the right thing, and long ago gcc didn't have builtins for
byte swapping, so we had to just do nasty horribly macros that DTRT
for constants.

But since the kernel is standalone, we don't need to really worry
about the *generic* case, we just need to worry about our own macros,
and if somebody does that example you show I guess we'll just have to
shun them ;)

Of course, our own macros are often macros from hell, exactly because
they often contain a lot of type-checking and/or type-(size)-based
polymorphism. But then we actually *want* gcc to simplify things, and
avoid side effects, just have potentially very complex expressions.

But we basically never have that kind of intentionally evil macros, so
we are willing to live with a bad substitute.

But yes, it would be better to have some more control over things, and
actually have a way to say "if X is a constant integer expression, do
transformation Y, otherwise call function y()".

Actually sparse started out with the idea in the background that it
could become not just a checker, but a "transformation tool". Partly
because of long gone historical issues (ie gcc people used to be very
anti-plugin due to licensing issues).

Of course, a more integrated and powerful preprocessor language is
almost always what we *really* wanted, but traditionally "powerful
preprocessor" has always meant "completely incomprehensible and badly
integrated preprocessor".

"cpp" may be a horrid language, but it's there and it's fast (when
integrated with the front-end, like everybody does now)

But sadly, cpp is really bad for the above kind of "if argument is
constant" kind of tricks. I suspect we'd use it a lot otherwise.

>> So the real use would be to say "can we use the simple direct macro
>> that just happens to also fold into a nice integer constant
>> expression" for __builtin_choose_expr().
>>
>> I tried to find something like that, but it really doesn't exist, even
>> though I would actually have expected it to be a somewhat common
>> concern for macro writers: write a macro that works in any arbitrary
>> environment.
>
> Yeah, I think the closest is a five year old suggestion
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=57612) to add a
> __builtin_assert_no_side_effects, that could be used in macros that for
> some reason cannot be implemented without evaluating some argument
> multiple times. It would be more useful to have the predicate version,
> which one could always turn into a build bug version. But we have
> neither, unfortunately.

Yeah, and since we're in the situation that *new* gcc versions work
for us anyway, and we only have issues with older gcc's (that sadly
people still use), even if there was a new cool feature we couldn't
use it.

Oh well. Thanks for the background.

            Linus
