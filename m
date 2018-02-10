Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518294180; cv=none;
        d=google.com; s=arc-20160816;
        b=OZ98xQLW+2zOqkB8J9STsf8FsSvp4YsI9wem4nnNUzAX7EzQYpJWEtD2hEkSUXtKWM
         ZU827BmUku2+5qF2TbtuU0AAkzqwe3wXUqH2mcSsTuvelQeZRpEFWsbBXKgd0cr+oj7Y
         cYOn4CgogJY7fkvjgtgAyGcZcWNfnz3hMrSo900O4h8As7hi4//hllxrqgFG9SGi0Xcd
         AlDXVKbcqqIlQxaXGDUbTnnaNtjsN2drg4Zmwvlrg5UfgPCxzq3QZmUTSUXhl179z3ry
         wYWlT9tq/3rSTEybGUHKB0nbW7a4gkY59Sd1VOYtBEb8EadDmSe72YyK0ZrB/u45cayo
         AxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=w0cot9pDkXM2p1jYbIzhxlIx02jWT2Y8Yrh82YkySQc=;
        b=Dz0BL3rA+h3IWY5kDPQ+zcXYj/pA4QouosXHtCKguGqKfT4kHwwMAMLbS0icvCE5+o
         8RDyQDItFOsepT0S9RjNj0ZjGwu5w/+ue7VWKgkvb0rfjyQVTZ2hZKep7sUnjsIenECA
         5FUhCeSdihI3f94a0tIVtk/9WnvIDr3iTCKm90ghUzf0CwKKY6cTgTvuli5WrF/plFSd
         IuJzl99AaFzhXuzRPYM8s4RXzhraAtdeLyy97CL9SEDAa1P7A0cr6qN2zOIkJvhu+mFh
         NWgYCmxdCB2JFlxI3a+upViZRSsrSsqnGlRD+Nzlnr+MmxyZd4yhx6A8nHbDzqgYd64s
         D4tA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ko3kRnOk;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ko3kRnOk;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x226l0oJTHD3CncxEv8dwThsyizZi2I3VggzAFE3SSUzhQXqiSptxKutzKWFiXDqq1QeeoCoksIjwDuYDuT6FMaw=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180210091543.ynypx4y3koz44g7y@angband.pl>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de> <20180210091543.ynypx4y3koz44g7y@angband.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Feb 2018 12:22:59 -0800
X-Google-Sender-Auth: KHy5bTWj_7ocmXxzEAaI9dvK3ws
Message-ID: <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Adam Borowski <kilobyte@angband.pl>
Cc: Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592046838599070999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 1:15 AM, Adam Borowski <kilobyte@angband.pl> wrote:
>
> Alas, we got some data:
> https://popcon.debian.org/ says 20% of x86 users have i386 as their main ABI
> (current; people with popcon installed).

One of the issues I've seen is that people often simply move a disk
(or copy an installation) when upgrading machines.

Does Debian make it easy to upgrade to a 64-bit kernel if you have a
32-bit install? Because if not, then it's entirely possible that a lot
of people started out with a 32-bit install (maybe they even had a
64-bit kernel, but they started when the 32-bit install was the
default one), and never upgraded their kernel.

It really should be easy to _just_ upgrade the kernel. But if the
distro doesn't support it, most people won't do it.

                Linus
