Return-Path: <kernel-hardening-return-12680-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtB02lshK6GWD9SXkvmgDoA9H69KXW8yqrcJ1ALOUr32dxwUWS+ZC03SY3SlnwOsZ7eVt6i
ARC-Seal: i=1; a=rsa-sha256; t=1521247726; cv=none;
        d=google.com; s=arc-20160816;
        b=UJfZ866p/GYRCtclpUDvTkTJd5j6nykpydhbfMe9HOc9MmWQpsn7tn7IZuFeA6xivQ
         yU5FpfHsOOeG5RE3c7QphyiRfntpjFQjq/7EvxD9AOZyCzre6wE6IsaBCvj8hPb9C++6
         bCkShdNVrYfdsAk+R7ufSZRpiEjasSamqMuwh2sgdNkUe7zDvK3Oj6Je4Lv4lQyyPDBO
         ztyLFp6tIrYMoJj7hrB+ZRK1+NA58XlzWEWvVSKpd8D7kJ6xjQaOqcGLv5UA5bxTFI4O
         WdHrIMW4Wu2OQfwOsULmKtRzbxdhft2RdXDJpFNqAeQkM2TiuT40gnZDq2aOw8iI1Xlm
         3bDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=FNXxVz8HITPSkdQG8OZkLKmfVCMmkkgM4lS/J/+JvRE=;
        b=kEKIZga7YygyBSUXSqWzMSjOiK0mogCzONW/OraOh4D9VQeoK8s21c4G+YeydoeDKd
         J4sa3bXBIB1HKwp7WIN46Nr2ubH13HsvNiIKOcMFG5Hz++zQyv2tRgTR48P5w2RaeupO
         tP9OhQNAzWl/KjK9ZbM3+M92xOQ4YWrJBsIkhsCkkIdYGZkSyA6VZx+kj7bvX5rRGOBK
         MhZxRf2LToDtvg1CUj7rAKy9ZcJQwEMqBtzvyrc4clavAEM3VSWeON5C4s6OpxuOSGlp
         M4zVMZ7P2zQzjeMbzausttp2SFwyU4EDECQzfMfctHU79eYyKTo46rRgI1wfkSgYHpsJ
         oMBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=m2X3T9I+;
       spf=pass (google.com: domain of kernel-hardening-return-12680-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12680-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=m2X3T9I+;
       spf=pass (google.com: domain of kernel-hardening-return-12680-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12680-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CA+55aFxLpdfyfTqhkHQoedQuqTcLRw3bYOgyz1s0eRW6cBmFTA@mail.gmail.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CANiq72mjDQWsPG60JqfuLSY-6SDzB4goP4n35XZxc8bfFx1NDg@mail.gmail.com> <CA+55aFxLpdfyfTqhkHQoedQuqTcLRw3bYOgyz1s0eRW6cBmFTA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 17 Mar 2018 01:48:06 +0100
Message-ID: <CANiq72k0ufFfEqaYFW0EeFcg_N_F6_1z2=88z1M-nce=oTkghQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595143856438282582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 9:14 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 16, 2018 at 1:03 PM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>
>>> Kees - is there some online "gcc-4.4 checker" somewhere? This does
>>> seem to work with my gcc. I actually tested some of those files you
>>> pointed at now.
>>
>> I use this one:
>>
>>   https://godbolt.org/
>
> Well, my *test* code works on that one and -Wvla -Werror.
>
> It does not work with gcc-4.1.x, but works with gcc-4.4.x.
>
> I can't seem to see the errors any way, I wonder if
> __builtin_choose_expr() simply didn't exist back then.
>
> Odd that you can't view warnings/errors with it.

Just click on the button left/bottom of the compilation window.

Cheers,
Miguel
