Return-Path: <kernel-hardening-return-12289-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs6s68zfE5avTLG/64a3MDwHFZAz5BjyQMgMmx22Z9+77IzrdfoB01rwwH5COK/PtVEE/Hc
ARC-Seal: i=1; a=rsa-sha256; t=1520560021; cv=none;
        d=google.com; s=arc-20160816;
        b=QZHr2Q4RZ4UOvpUbXwzrbZ3hRak9lhXznWfGwxQCkHlUwMp0l9+5burpT+M7Fd6Gz+
         GZV55C/DfoW+FZpirIcQkmAxsJ6BpwiQVbLKBzzUhW/nwkPnW90n9piMRYzlvkFkw2Ji
         gKSQVppatU58vWGuCiL+qC+4T86p4046I5hT0DLOYBiLe1L9XlHeSIcJ93cN2UgBeRwZ
         ZIpoz9g60r1AjQepmBiTzEsq5Q+jFfQ5lRjTEFtvtGK2ZUEZTVLpxY6loyi+vBcy99mP
         6JJdYV5HbSndsrZfBaZVgv0TLxHThEmjmdXsPxwdj4yIOmlPKGSZLl+xa0E/DTuZ0P32
         wI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=yFW3Mbru4HToARb5Dl9hqfSQSbvmVfS1ZGn8w9Pbb5A=;
        b=TEun9DBHMiay2JqtI1xDvSwX8m6d9uexqd0elob07t75Jd07wC/v9U8j5R7DdRttjs
         JnfpsUuwLT307Qjdk4cuA+osuDhgBsXwj3O1TxG1hLXvs7P2Qhm56GrmndAn4XQBdt7W
         FThprVpov3945E0l/wahjUQM1K2a6hWZFaLxMte10l9VD05hUKSm0uY/97zKwihCc8Wo
         GL8quVRp/KXprmhIHX0Qdb2c88zaGbKqmLZe6OBSbxpUV2Xdf8EF5SFyXgqoTUKo9qbN
         2zzmTBpBITgUVby6FKpyN37U4z6Tcl7Ms5RQJnpSx2rxHpzACD5aopsBz6ZX8UHsmhUe
         y9WA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=lCc6MX22;
       dkim=pass header.i=@chromium.org header.s=google header.b=fC4hA1yZ;
       spf=pass (google.com: domain of kernel-hardening-return-12289-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12289-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=lCc6MX22;
       dkim=pass header.i=@chromium.org header.s=google header.b=fC4hA1yZ;
       spf=pass (google.com: domain of kernel-hardening-return-12289-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12289-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFxXb8JhpELWcFJnQMYy6sTyndwdNpCLFUznA9ML7-oL_Q@mail.gmail.com>
References: <20180308214045.GA6787@beast> <CA+55aFyf-ajRzW2sUwFrrMOAu5UyuOk5L8g9xfkr4VuJeWjV9w@mail.gmail.com>
 <CAGXu5j+JiYcsdaC4V9+SmUM2SKW1yRHr18d74G5SM_sSrQm=Nw@mail.gmail.com> <CA+55aFxXb8JhpELWcFJnQMYy6sTyndwdNpCLFUznA9ML7-oL_Q@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 17:46:42 -0800
X-Google-Sender-Auth: au-k8phjW6zFhJQo9fPymaUgrzM
Message-ID: <CAGXu5jJG9JL_3=rgqS+_B-FEumwa4qZkL6YA=KKxaMe-ugz0Rg@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Skip single-eval logic on literals in min()/max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
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
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407273404510633?=
X-GMAIL-MSGID: =?utf-8?q?1594422744780595134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 5:35 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I don't want to weaken the type enforcement, and I _thought_ you had
> done that __builtin_types_compatible_p() to keep it in place.

I thought so too (that originally came from Josh), but on removal, I
was surprised that the checking was retained. :)

> But if that's not why you did it, then why was it there at all? If the
> type warning shows through even if it's in the other expression, then
> just a
>
>
> #define __min(t1, t2, x, y)                             \
>         __builtin_choose_expr(                          \
>                 __builtin_constant_p(x) &               \
>                 __builtin_constant_p(y),                \
>                 (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),  \
>                 __single_eval_min(t1, t2,               \
>    ...
>
> would seem to be sufficient?
>
> Because logically, the only thing that matters is that x and y don't
> have any side effects and can be evaluated twice, and
> "__builtin_constant_p()" is already a much stronger version of that.
>
> Hmm? The __builtin_types_compatible_p() just doesn't seem to matter
> for the only thing I thought it was there for.

Yup, agreed. I'll drop it.

-Kees

-- 
Kees Cook
Pixel Security
