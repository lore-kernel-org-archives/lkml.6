Return-Path: <lorenzo@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519208837; cv=none;
        d=google.com; s=arc-20160816;
        b=yWml5kFDgc9sZU5RbXKTM1Kk6mtwOQ93yCHGNuEpzsKT/2QiczlWC+qUIf7jKvasah
         nPx55+pRwBVNhLZDMGV0IZRlY9OkJLniH6Aam8K1yZ/RhOhxYUyfxy/Qy1dVly0sIDbY
         NB+h3IIVAKgGhAlycvPC6Udoz8QChGXcCmhfulRzr8nCk6fX4sKLPLzAC45czjPqgyAV
         /IKLt9oOdQ5z+EcxAbSCdkpNzb6WFHb3cEu0uW5xMKGwPVS/uYQZzMs5v7beTKgdZabY
         OnrhL3qnKXMWA5QjcVWeikHu6htAF5s69OmK0IREWo6j17YrsxhGSQyP5iRxRxU0t3Ov
         vMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yakjMHftaJ212JGnh28tBwNpoBQjuv1WK33zBfCC3Dg=;
        b=PdXjDBbVu49RNiWNgr5DWPeLXLr4U5r7J7XWBzPu//0BqJMaDVU7E3K1Jo71HEF9Mp
         LqGw55edsPZ8HRQSNqsyUBCC8qdZRXpyHDYqivzhgQk8cpC0PdOpw+5R7UEpdAob3AWE
         Kc1lvk2WDv0nufrWwNPQxwZklP1ejfGC2J9Bkxwx384lQURH6GBtlaqiWtNI+JKmSiG1
         UhTHKQo+Kwuys6sfXCKjr+nPzi6s3KjYwTVDo3RJqTTcS5WHXKHgW0o06GBPuDVo2EqK
         rxr8bxUAitzrNf/GY9kvupkKn//tBCczaIzK7P6y7riwFMhJ9ohJ4ucqMtDIiHk7j36q
         AVVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vaHK6dEh;
       spf=pass (google.com: domain of lorenzo@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=lorenzo@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vaHK6dEh;
       spf=pass (google.com: domain of lorenzo@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=lorenzo@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x227zV6SLZifqJHwPiO75QMMtYG5m1g9rQjYgEQ3K3E9YNbr/cFpw+kq2MzEFJ7mTqOu4jzXBnJterv+A4YczNwA=
MIME-Version: 1.0
In-Reply-To: <20180214085425.GA12779@kroah.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de> <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl> <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
 <20180213085429.GB10278@kroah.com> <CA+55aFzLR2DbGnAKQwg79Ob9dpkOM1Z7bxkjyPBSp3Zdxmk5eQ@mail.gmail.com>
 <20180214085425.GA12779@kroah.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 21 Feb 2018 19:26:55 +0900
Message-ID: <CAKD1Yr2mgYZ7uFCQsQ9M5YMGX1LuhO0CQR6tLvQM=dND4RBrbQ@mail.gmail.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark D Rustad <mrustad@gmail.com>,
	Adam Borowski <kilobyte@angband.pl>, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1593005926515045996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 5:54 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > IPSEC doesn't work with a 64bit kernel and 32bit userspace right now.
> > >
> > > Back in 2015 someone started to work on that, and properly marked that
> > > the kernel could not handle this with commit 74005991b78a ("xfrm: Do not
> > > parse 32bits compiled xfrm netlink msg on 64bits host")
> > >
> > > This is starting to be hit by some Android systems that are moving
> > > (yeah, slowly) to 4.4 :(
> >
> > Does anybody have test-programs/harnesses for this?
>
> Lorenzo (now on the To: line), is the one that I think is looking into
> this, and should have some sort of test for it.  Lorenzo?

Sorry for the late reply here. The issue is that the xfrm uapi structs
don't specify padding at the end, so they're a different size on
32-bit and 64-bit archs. This by itself would be fine, as the kernel
could just ignore the (lack of) padding. But some of these structs
contain others (e.g., xfrm_userspi_info contains xfrm_usersa_info),
and in that case the whole layout after the contained struct is
different.

On another thread Florian pointed out that he once wrote a patch to
fix this - https://patchwork.ozlabs.org/patch/45855/ . Florian, think
you could revive that?
