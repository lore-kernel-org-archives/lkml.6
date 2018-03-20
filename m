Return-Path: <kernel-hardening-return-12710-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELskWGTYslAecmUUKUZvgztipKeZpQj3qE13DPpj3DjhUkOKr3oVipnjfklDfYHEdtyqEi33
ARC-Seal: i=1; a=rsa-sha256; t=1521588431; cv=none;
        d=google.com; s=arc-20160816;
        b=03SHxXfhqSn2YFAo55O97W9UtXkY2CAdjbuxOQUyCxoMdT+oXgJxwpftp19bCNFg56
         Izgv9fbhqao4ed6pl+qpY+YuJZZdpERCd9Q2Xay5Bl8ZngigtHvCI6agyj1G4c3Vu3bP
         q+YJ4RcCOvcMfsDeGjJzy2gJ1tkjoInW1l3Cb9Zf4lwHmoQ6+hPccE8uqir6KmmpPY8E
         7+LiBfNx2cSM7lD44P2WRWdK15Bx441NOp6b6jynfZmghAkoC8R+E00Y5pb2FGddpWpG
         AF43Gsil9vxZkHjfWNIxk5wfUI1/wJowGrlXqpmbw4Ma7Y7qUE98ddHfp7tlT3oTcY9b
         GV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ABcLB3QxSLxQPGgAqA9/Jd3awZ7yzQ/smhUkTeOBpAE=;
        b=FeXibgjFgpG5Q/193sDoJ3gWHdnvgac2r6ij72w49ocC200LoKQJ/7/Jg7Qd6k5/9I
         6fGTKRUKOLOVoXAIL17IWDYezPdJtqA1lulNq5n0VKxI2FMroczdFduI2Ez1rS3m30lN
         1J7SAiDJwh13cHvaz187he5YlCSreWEA84H4HqvgExej11QlnEQlNNVia0kRPuu/3GC1
         tyZ5SaMO6cFw3bxstvc8MFG4sFtpzcTibw8HqXBcy7VCXo6SuKxDzuFR56H3Raw0sPeD
         /miee4VzSOEwNSKlXwuIg5MXeMIfitBOhisdQdMqyj7JSHrYAJ5zV+IjR4Z+fp3ygsP8
         t6Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p3zQCA/f;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=PTlOHqA1;
       spf=pass (google.com: domain of kernel-hardening-return-12710-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12710-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p3zQCA/f;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=PTlOHqA1;
       spf=pass (google.com: domain of kernel-hardening-return-12710-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12710-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFwxk=tUECYQkd4cog08qW4ZT=r2K7FQXzGnc-zuMc7JQA@mail.gmail.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
 <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com> <CA+55aFwxk=tUECYQkd4cog08qW4ZT=r2K7FQXzGnc-zuMc7JQA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Mar 2018 16:26:52 -0700
X-Google-Sender-Auth: Y_VzZ3LFQqYw_efetf0BlHJrEms
Message-ID: <CA+55aFwO8KZD_tZwqwL05FbzpKW4Ucd88C0tcR7LJ1utuy3WGg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595501111459010920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 4:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. So thanks to the diseased mind of Martin Uecker, there's a better
> test for "__is_constant()":
>
>   /* Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de> */
>   #define __is_constant(a) \
>         (sizeof(int) == sizeof(*(1 ? ((void*)((a) * 0l)) : (int*)1)))
>
> that is actually *specified* by the C standard to work, and doesn't
> even depend on any gcc extensions.

Well, it does depend on 'sizeof(*(void *)X)' being 1 and the compiler
not complaining about it, and that sizeof(int) is not 1.

But since we depend on those things in the kernel anyway, that's fine.

                Linus
