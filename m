Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517823750; cv=none;
        d=google.com; s=arc-20160816;
        b=vHldG08FnAHn7T8CsDBWXA/KfJc9oGaPDwqfiqWLRf+8rH6tGRgCzrbbhu3RN60wW7
         cpWvXmOs7MLCavd58cNqojFhd1EjI/TB0MDeZyTkv/69LxEvemS/8gIirIXd3tVeHa+y
         xV9nye/iyRN9j+MaVzsEYEdOlVFrU8aHKh/xgXqJMGAsnrzSryzZoinJ46uxKm8oydWR
         RZShaZ7DeVH7eFdsfcFaQEY6gzHXAs0QeQNvCy3aZ9swbR6YJbr24DqoZOAb7sxhuDHj
         nClolnA4fIOJCHUOkzzNM2twgw77EdLpQOOe6KPX0eK0rex6K6E/G5q3GCqTLNX3ZtDt
         bQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kHH35qE0HVtBmXl+q7LIaTkjyNtrTAdKLEuWgOVFuDk=;
        b=CY8o8/gg6iaKhszGl+an0wtbrubsSX2xOEhDVHnScurPjiYUnx4MrqzAmLHeGCi5qk
         Q6Z3rxUzqxvQ/1w9f8SPsCAUmbr4kdUUQpYmnMM7XqgqNFQPbwr+NDTo2XbyrMRDaCec
         O3v+rgRSf0xuRND8qsNoUH0GGknrw9F0GA0lIrAaPG7fiMhCswT2mxWGm2DXTtpKSYig
         pgbObtvdDpzg01IQiaHJGQghLru3iXz9UmizCoQ2M0urOiCRBbZPZ0pT7aP9AXa4PkJQ
         AoZvEEtXOIP7I5KbNVHftzTKQhRYGyj1xYHTu5ByWzL9cb5CEkOEOusSae3xWyfTdJQ0
         XZcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=A1bkFfda;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=A1bkFfda;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x224k/TQUslh7bGHwBFzUggO4XgxtS5vorz6jpRxaIUTv+n5kis1jzRvLqW45Dj6dn/WouRQWpgt6hKfvGIT0MwA=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802051023540.3292@hadrien>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
 <CA+55aFztiKehjo7OQQFboAEfe_BrxJQG_5wxak2a_GdNBEFiMw@mail.gmail.com>
 <CA+55aFzhp2QW9JeMwV6=W4skf0CW6E+Zg4K90n3Bo+yZmz485Q@mail.gmail.com>
 <CACRpkdZGABVtdF1HWHfx-5JPyaEhtt+Q_sjM=bkJu6cZ5WfPCA@mail.gmail.com> <alpine.DEB.2.20.1802051023540.3292@hadrien>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Feb 2018 10:42:29 +0100
Message-ID: <CACRpkdb0P38+cvVeSw7imzehb5VM51fmxOBWJWgzdnuEP9ryDQ@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591553556845961928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 10:27 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Mon, 5 Feb 2018, Linus Walleij wrote:

>> We definitely need some better tooling to find these things,
>> using Ingo's head and your occasional frustration is not going to
>> scale.
>>
>> Julia: do you have ideas on tooling that can loosen #include
>> deps and advise on when to replace #includes with forward
>> declarations of structs (etc) to bring down rebuild-triggering
>> dependencies?
>
> Could you explain more?  Is the point that you want to remove an include
> but it has one declaration that you need, and so you want to bring it down
> into the .c file?  Would the need for that actually indicate that the
> include file is designed incorrectly?
>
> Can one assume that each include is self contained, ie it includes the
> things that it needs and does not rely on the .c file having included
> other things beforehand?

Usually (in my limited experience, le's see what Ingo and Torvalds
say) the problem manifests mainly in include files including other
include files.

So say <linux/foo.h>:

#include <linux/bar.h>

struct foo {
   struct bar *barp;
};

Since this is only putting a pointer inside its struct and doesn't
need the information on the whole structs, as the size of a pointer
is well known we can reduce it to:

struct bar;

struct foo {
   struct bar *barp;
};

And thus as <linux/bar.h> is not even included, it can change
all it wants, our foo.h include file is not affected, neither will
any driver just casually #including <linux/foo.h> need to be
rebuilt.

This type of case (and variations on this theme) is the reason
we put a bunch of forward-declarations in kernel .h-files
just to break dependencies to stuff just referenced by pointer.

There is a counter-pattern saying "files should #include the
headers prototypes, structs (etc) it uses" that drives a truck
through this approach. But IMO when done properly, this
forward-declaring approach is quite readable.

I have very limited idea of where, whether in the preprocessor
or the compiler itself, the decision to treat struct bar *barp
as "just some pointer" happens, but it is a real neat trick, the
dependency chain is broken in CPP AFAICT anyways, and cuts
down the rebuilds.

Yours,
Linus Walleij
