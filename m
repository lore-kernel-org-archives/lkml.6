Return-Path: <kernel-hardening-return-12677-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt+I1x3ArJpY6YT+MQARgKE7Dqzwb6dT/VLef6KdutPdV/XiMShEvAs6LosSc3sMqB3VUtl
ARC-Seal: i=1; a=rsa-sha256; t=1521231947; cv=none;
        d=google.com; s=arc-20160816;
        b=MYUrr1LkhFI9Lz220kvmmL30u1fs6++0EkFIv3cO0TtZUzCGTcXJuGCvvcpipszWdz
         1L+mj9Vu7dNiL/bQvXNpc7aJwGXz+NZwTnh9IDZIV2tFNXcfj0lF5wHOk2jNeFWpB2TQ
         xHrh5MQMWFsqXXXlYtl2nzsT65WJ4gGzfUFu17TEg+QTTr8QXahel/xAMvp6xEFJvm1x
         b+u3npU8o+MAirdUb4qFjF2a4zbyNYf/rc/sP3+BsKgMjLPxkjBikpsLrkwLzmZrNR5g
         J2CnTTq7Znfjurf/C1F0gkj2WNA7HKBLOg+79If2aiFxt/EVZThDE08uD4ZYbcZYKnl+
         aqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=B7SYsUU2KYaw3OS6eJAaEVYDxGMBq9q/5/NmUhI2ocU=;
        b=reGw9qg0qb3soH+nPRSiSmoRRyT0zrJq+PuZLc0EoGXmSE0WDkWn0Vy+1E3Ph2Xn2Y
         FT7sX2b0bcJtENfyMBBclilwajeKATXnFFO49vw48Y6tQlQsRqQa2cpEUV97d8QlGDV9
         1wMzqJ7N89Q2oDvQUBntuTUshXNsApvBZIoQKF6IePEkW4oPLOTHjjolc52B+nAY+SbP
         +b0rJLDQYyB6BiK/20JVUxx1pJn5SAE4IGCFDTCQJrVWnCcGT154+eVU9IH9IB9jNZUi
         zyGUXqXCkT4kVJW2bLndiytOk38jvoQHXcklBpN8DG9wilidpVTj+SCas6L8O2lxmTcT
         DcLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iaq6ym3/;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=WxQGLT5L;
       spf=pass (google.com: domain of kernel-hardening-return-12677-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12677-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iaq6ym3/;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=WxQGLT5L;
       spf=pass (google.com: domain of kernel-hardening-return-12677-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12677-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <a37f7b0da04f4ede9fac2c88f7079a8a@AcuMS.aculab.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <a37f7b0da04f4ede9fac2c88f7079a8a@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 13:25:26 -0700
X-Google-Sender-Auth: KAVq3SYkYefZGUKKtMf3qu7pTK4
Message-ID: <CA+55aFwzgO9w8Dj1NoCViz6JTwVLWhWabLq_cvzJ1-woEBfJMg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: David Laight <David.Laight@aculab.com>
Cc: Florian Weimer <fweimer@redhat.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Ian Abbott <abbotti@mev.co.uk>, linux-input <linux-input@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595127310862853875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 10:44 AM, David Laight <David.Laight@aculab.com> wrote:
>
> I looked at the generated code for one of the constant sized VLA that
> the compiler barfed at.
> It seemed to subtract constants from %sp separately for the VLA.
> So it looks like the compiler treats them as VLA even though it
> knows the size.
> That is probably missing optimisation.

Looking at the code is definitely an option.

In fact, instead of depending on -Wvla, we could just make 'objtool'
warn about real variable-sized stack frames.

That said, if that "sizeof()" trick of Al's actually works with older
gcc versions too (it *should*, but it's not like
__builtin_choose_expr() and __builtin_constant_p() have well-defined
rules in the standard), that may just be the solution.

And if gcc ends up generating bad code for those "constant sized vlas"
anyway, then -Wvla would effectively warn about that code generation
problem.

              Linus
