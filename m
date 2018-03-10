Return-Path: <kernel-hardening-return-12360-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvGnFKafubz1CLFGMD3VJARMc3GLbigRzd+HtFmIiuklXi8lbCSMNjKUTwy6Amj9ozJZO4+
ARC-Seal: i=1; a=rsa-sha256; t=1520649488; cv=none;
        d=google.com; s=arc-20160816;
        b=qEtMSS324pQCHXFLhs+D/odk1eio2rYh2jDUYFj/tVClh8STDJPi7BH6pgWjRA0rqq
         Og+Acv0PTFpjhNIVXWL1tK7Q8O4YP7JZNtudISd9e+9xTIGqp8nZT3gh5E8V64Amw+rH
         LytjjwN4tJQUfVrHUxUgkOIod/NkSR42JASDhOgA7TIicwmFYjlm0ZNQh3O9k4+ceklw
         x2G4A744PnK/WD0Azfk5IEZSWwknTucKjIcSuniNnKF9uHr9p5JtuhgQ0idMTw2hFW04
         sjO6DSV8ejx+bnmdHd0kVa+Pg9A7LxtyT5goyW+sZUIZCMi443ezf27CmzNB5PE751Fq
         lSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=HG+i0L+KBW3svfcURKDhhtUwO6jWOLpHdHIACTUPj+4=;
        b=ZLGQDiYPO/vn4dsRtj1ICRBB98ff/iNun/LCzMbVIUc4Xcly6gi1lRpYbcXevl5lXx
         j5IX9WMyuRiXRZCxzxyxU18D7LGxgdH052lz3x+ndDuaA/+zkA5pjWIBm/8hPNuSAYaB
         nHynrIek7NH0B2rMT9jGiOTgLiVUfOgc5QD+nWU1UdMUG4voq2+TooZucAo08ze8z4Ax
         8GbeyF6tnmv0Tw5b0rOOZooKni1qAE7t8wPnXlkgBPRHRgRgZQhWB1UXUNCLzMNK4iTU
         RzYKWweGx6/SGbYVYjNTFZ/WayjQhl/dOQziWRsoHbKghQYL1xKf+S5loVpTx/pv7EbA
         kGOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J4Vr6s4r;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=GmtuY202;
       spf=pass (google.com: domain of kernel-hardening-return-12360-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12360-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J4Vr6s4r;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=GmtuY202;
       spf=pass (google.com: domain of kernel-hardening-return-12360-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12360-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5j+4_2vZF9uPy_agcGymbHbVqohSqApKZZxwcTz4OC_Skg@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
 <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
 <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
 <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com> <CAGXu5j+4_2vZF9uPy_agcGymbHbVqohSqApKZZxwcTz4OC_Skg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 18:37:48 -0800
X-Google-Sender-Auth: aoAfBMO4kSL_JuZe1R69EeGCu3k
Message-ID: <CA+55aFyzPJQ41hq4nC24xwwOW6ZiQ=AMEDA1fZzDH5XbcGGzpg@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Kees Cook <keescook@chromium.org>
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
X-GMAIL-MSGID: =?utf-8?q?1594516558214112247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 5:31 PM, Kees Cook <keescook@chromium.org> wrote:
>
> WTF, gmail just blasted HTML into my explicitly plain-text email?! Apologies...

There's more now in your email, I think maybe it's triggered by your
signature file and some gmail web interface bug. Or it just tries to
force quote using html.

There's some html email disease inside google, where some parts of the
company seems to think that html email is _good_.

The official gmail Android app is a big pain, int hat it doesn't
*have* a plain-text mode, even though it knows how to format the
plain-text part of the email.

You might want to be on the lookout for some bad drugs at the office.
Because the world would thank you if you took them away from the gmail
app people.

             Linus
