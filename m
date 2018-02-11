Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518380064; cv=none;
        d=google.com; s=arc-20160816;
        b=RPiEL1UrASl+WRC5pojamBkPz34pZTRozSn1IHveWuqIpOxdWCC1h8WE8nYlOhJKon
         pZzd7CXm/e18cPwdy2AnTiRKMpjwaMjRYnbPB72wWNw3ybnnmLkfgtS0+OJVx/QmhkHq
         /3BLW2T3WJBj6qgsH++/m6PzP73gBbUJurwf6L+AOOoKiJJoPsSndn2we5ZIql1rvul5
         j6fcO6l+Crt24zS7kifjUNv8rahi3XgVdwwLG+fr7FDSelbVOi60fHC9NCjdSyvGgpdy
         zz/v170EtkzuZTHEMZR5KS94mvUHG/6NivtcsiloMlt9opgG4tg6NY8/3DbqgeeBBNq5
         oRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=FTuV1a7JoeCk9MdOTeLV5r0TQ5UzGbmpMlVkT0eI2OA=;
        b=QZb6eUitnUAS3zn/0F/Ju7Y8DSYiUKC6op25SC+Xy2wzI2uhn8/2h1VJ2mV3LzQJTu
         97U/DlEljxTi4RLDlmsP5JPq+GJVVV/3T27nYqi0Jlt3okUxzexd6xNAtw791Fa1ZSBs
         1dw5AVpv3CnoYuIKJ/hAKqZUKIUW7ZKv6WHhoR+uY0aYFX/cl2FEEu//aajC1HhGsjcf
         goe0PhMhAFlkIlsxIr/JoF+8J4c6OYX8N2lOCB0kuyVGEtZsliObimLbGu8HNsJ5Udwx
         IDtQCCR5KmnfMNi/vB7S1bY6tJAuYfwfgL6k+gVQL6Wk277mqlbFwDR2cL4GJjNx6Ubq
         a1fw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JS/GwV1E;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JS/GwV1E;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225dZHOzIDis9nLhC68v83T3TewdpWZhmB8XRYbdNIFTuVj8DjGeNiVGHomd2f4rLnVfwKTZcoZTNoRLCKu0Qb0=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de> <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl> <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
 <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 12:14:23 -0800
X-Google-Sender-Auth: Fkv9y54CeqHo1OlVSkZxEUXZEFg
Message-ID: <CA+55aFxU4ui1tbV56x7wjzn8+OyMpNe53qoE0H-xHZiFBMFDsg@mail.gmail.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mark D Rustad <mrustad@gmail.com>, Adam Borowski <kilobyte@angband.pl>,
	Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1592136893925553022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 11:42 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
> At the risk of suggesting heresy, should we consider removing x86_32 support at some point?

Maybe in five or ten years. Not in the near future, I'm afraid.

We removed support for the 80386 back at the end of 2012. At that
point it just became too painful to support at all.

In contrast, we could continue supporting 32-bit for a long time. Even
if it might be in some degraded form (ie no PTI at all, or only a slow
one).

It's not really a lot of pain for people who don't care.

                Linus
