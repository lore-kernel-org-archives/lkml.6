Return-Path: <kernel-hardening-return-12358-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs5iNS7EG/Pyt2NaX3r8YmcUaoK6hjMdz6XS7DDTHOg8lKDH3XcIca4g/brcL6BnOhNjmaV
ARC-Seal: i=1; a=rsa-sha256; t=1520645436; cv=none;
        d=google.com; s=arc-20160816;
        b=lO+puhNYR8jDzM+rMSAMKG580SSUKdiXH1c8s8zjlKCmo3D49PcdOu9YYf296bqrOs
         VrQ+TmZ0KzIaSRO9WO3Pcr7kD/A48Y1lkAHTotIhonYdysC8vBTFLBSMJsL7e53fQlgL
         MUh6AGvNSledgwx6RDtn2jAK03kC8YS0p5rGvm3qz93zGeoaoi5gchSLgt5QUhCaudHv
         8ryGctmRetUbr0cdNcVZjfLGrtD/OqtdNDE47XsafFHbRlNbuoug4v1AZw1w7SD7lC8P
         74hrSr/n4mUYHEUQIfihnn7dECADM2btdvVfCriu4kAfx67agRR+RehySQy5HsZh05Vv
         3+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=AmOeoAC0rE/G4gIImUKQq+faDW7g5ndYY2O+WZ0I/i8=;
        b=BUcjJq5+9ad1NMSVXCnuNA2r2tE4Ego3KYBKIgiqJ0oCGspqHVj8CVdKcIwZWOwcOM
         H3xMw/ZfOepecR1aU4y+6aYifWxWVuilyJ8tMCIsjNH6NWaaYirQDzMtLE6HKEZqpaA4
         IWgEgHN6GPGAx9C2kdCUck+a3/beGsFOtyr7C4J02s6DdOc2iCK3JWe7huw4b/xrPRvd
         hQzrcEjeoOllIxXhLS0FU9QYrEa3U8z66u/TYcOSKylQauemmFRCXVgLGwVlW3cYqL4R
         t+Dn1bsOkOt2k22WwdPXMgYU0Ct4kM+yFYoVD8znFzVMl2gwSaqwsNOajW+2x+Vj05+X
         sgAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cdoa4YdY;
       dkim=pass header.i=@chromium.org header.s=google header.b=V/F4s5GW;
       spf=pass (google.com: domain of kernel-hardening-return-12358-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12358-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cdoa4YdY;
       dkim=pass header.i=@chromium.org header.s=google header.b=V/F4s5GW;
       spf=pass (google.com: domain of kernel-hardening-return-12358-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12358-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
 <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org> <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Mar 2018 17:30:15 -0800
X-Google-Sender-Auth: BbL4QPv1eseGmgx7nJa7Su4SukI
Message-ID: <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594512309341814386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 4:38 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 9, 2018 at 4:32 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> I wonder which gcc versions actually accept Kees's addition.

Ah, my old nemesis, gcc 4.4.4. *sob*

> Note that we already do have this pattern, as seen by:
>
>   git grep -2  __builtin_choose_expr | grep -2 __builtin_constant_p
>
> which show drivers/pinctrl/intel/pinctrl-intel.h, so the pattern
> already exists current kernels and _works_ - it apparently just
> doesn't work in slightly more complicated cases.

Fun. Yeah, so all the PIN_GROUP() callers have either a literal or an
array name for that argument, so the argument to
__builtin_constant_p() isn't complex.

git grep '\bPIN_GROUP\b' | egrep -v '(1|2|3|true|false)\)'

> It's one reason why I wondered if simplifying the expression to have
> just that single __builtin_constant_p() might not end up working..

Yeah, it seems like it doesn't bail out as "false" for complex
expressions given to __builtin_constant_p().

If no magic solution, then which of these?

- go back to my original "multi-eval max only for constants" macro (meh)
- add gcc version checks around this and similarly for -Wvla in the future (eww)
- raise gcc version (yikes)

-Kees

-- 
Kees Cook
Pixel Security<div class="gmail_extra"><br><div class="gmail_quote">On
Fri, Mar 9, 2018 at 4:38 PM, Linus Torvalds <span dir="ltr">&lt;<a
href="mailto:torvalds@linux-foundation.org"
target="_blank">torvalds@linux-foundation.org</a>&gt;</span>
wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class="">On
Fri, Mar 9, 2018 at 4:32 PM, Andrew Morton &lt;<a
href="mailto:akpm@linux-foundation.org">akpm@linux-foundation.org</a>&gt;
wrote:<br>
&gt;<br>
&gt; I wonder which gcc versions actually accept Kees's addition.<br>
<br>
</span>Note that we already do have this pattern, as seen by:<br>
<br>
&nbsp; git grep -2&nbsp; __builtin_choose_expr | grep -2
__builtin_constant_p<br>
<br>
which show drivers/pinctrl/intel/pinctrl-<wbr>intel.h, so the pattern<br>
already exists current kernels and _works_ - it apparently just<br>
doesn't work in slightly more complicated cases.<br>
<br>
It's one reason why I wondered if simplifying the expression to have<br>
just that single __builtin_constant_p() might not end up working..<br>
<span class="HOEnZb"><font color="#888888"><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Linus<br>
</font></span></blockquote></div><br><br clear="all"><div><br></div>--
<br><div class="gmail_signature" data-smartmail="gmail_signature">Kees
Cook<br>Pixel Security</div>
</div>
