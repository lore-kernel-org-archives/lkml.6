Return-Path: <kernel-hardening-return-12673-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv1255Ic4RF9etXhPJlQ5iCBrCpo80xHXKnSXVkrlRJaM941nOPWtrvkOhL/dYSdirKz9+K
ARC-Seal: i=1; a=rsa-sha256; t=1521231278; cv=none;
        d=google.com; s=arc-20160816;
        b=pQOV4Cmq94YBE5cWndnOAPIhA2NRFaguY7dYhnXwMePyT1cWnAt29HXH1kUg4LrG//
         0TL4z93GmIutn/IKDxqRTwPGK+OLuwo+ikywgbYdSmhUYhLDYrRO72QUx8w7Lb6jcHRc
         YcGw5RcY/dgSroixBEzGEGyQg11Bmvk6ZJ2coGJ1fCXnQl5jEm76rtY8nxdPieTu9nxH
         poOe0Msz1dy6QEMrCTZRwkjROWZXpVcduiAd884rcbndnauiagM3aMWEctn/BX28RABy
         W/2P+UqH+dY8ppEy6jgQ87Tt828o08iv3oHrFL6XIL6Fd6jZ3r/YUXZoK97/Df9IZIHA
         gI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=As8eiw4kovL4HNRmBHdKkuGnMhwwoR7O+JB2wfSt6yo=;
        b=grX609awdIo5ycLeSu7LqLkDj+wUW4oRlb6osyB5p41SFeQfGdsNrdXhwnJywpkl6l
         POG+Xyq18CaIRPGPduDkS0udSvQJ5+WF4dysFqex+3g5OioebFKMniFZ8UU9l3V5U9YL
         oIL9Gl/o4zq38xoujezHc2IZH2/ZKM48jW1eDw3RQeyXTlL5hL8/bCeLTqq8xCRUQNd/
         qgmZrNTJbfJsMzAhH3vjJkFVLgElcr4iMRZCWyuUFHlExWNSgpKJRil2olSWAZ0LLhHm
         F4al0NTX+WCt/JGtxW9jUjdBFBza0+tff1P+Tf92M0i+HwfMcTARoyT2VJIzmk3lmSBb
         C65A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o3nHz0kg;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=HSqt69sp;
       spf=pass (google.com: domain of kernel-hardening-return-12673-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12673-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o3nHz0kg;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=HSqt69sp;
       spf=pass (google.com: domain of kernel-hardening-return-12673-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12673-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CANiq72mjDQWsPG60JqfuLSY-6SDzB4goP4n35XZxc8bfFx1NDg@mail.gmail.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CANiq72mjDQWsPG60JqfuLSY-6SDzB4goP4n35XZxc8bfFx1NDg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 13:14:17 -0700
X-Google-Sender-Auth: Z1uPz-FhmbMhOGr5gmegDqT8tDI
Message-ID: <CA+55aFxLpdfyfTqhkHQoedQuqTcLRw3bYOgyz1s0eRW6cBmFTA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595126608765522677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 1:03 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Kees - is there some online "gcc-4.4 checker" somewhere? This does
>> seem to work with my gcc. I actually tested some of those files you
>> pointed at now.
>
> I use this one:
>
>   https://godbolt.org/

Well, my *test* code works on that one and -Wvla -Werror.

It does not work with gcc-4.1.x, but works with gcc-4.4.x.

I can't seem to see the errors any way, I wonder if
__builtin_choose_expr() simply didn't exist back then.

Odd that you can't view warnings/errors with it.

But it's possible that it fails on more complex stuff in the kernel.

I've done a "allmodconfig" build with that patch, and the only issue
it found was that (real) type issue in tpm_tis_core.h.

                Linus
