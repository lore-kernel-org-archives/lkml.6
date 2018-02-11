Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AH8x2253r6X8in9eYUKYigmLZTewneALRPaqB80PBhN25pjR8hSTvOezRnVBMb1ROEBghnm9LhZy
ARC-Seal: i=1; a=rsa-sha256; t=1518391616; cv=none;
        d=google.com; s=arc-20160816;
        b=w0PNVMgaevZFZYSu0+pf1i3SD119kCJdaQSKFTpFifbz/PkTk7BbMg/wS1mpamxjbk
         Nn6bYQxh6uMjo7CuAnVBblnfC317Sjafra9JpwTFJ3Zf8vlNPdyXiqcUp1MBe07cujo1
         XmlpUUdbv6QyCbH2SfMkwQ4ABqsirGJWnsi8eD3O59aI01LYcN2+daE/IHS09G6Djyzd
         FQ6+y255HeSYmTERhmYlDnv1/Mh2jZ6qkAcigUEeo8jGuuK7nNbxTipibGFjRO7qRrvW
         7mv6LD/HaA7ma1FH4nd1QoOkOJR8FfDO/4ePHwn3Pswk+0XaTiTEWtlSQtyJulq+olM9
         O13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=m7oy4X60h1XNzDkQVKfCMtKwSz4HUz8uYIJpwLXNMiA=;
        b=PHLfWgIP7c70nYa8sB+PJgsWWzf28LtwWxlkWNf7cbmCnao9urkPo2rU2n6hKcfYCh
         9SB8LVQGjmcEKDsqas1fGzs8PK3gj5tEskiVRMQTAgZLdYD2TRwKRYufh3nwDwU8OCvW
         l4qSVUXTgRsF2Rtpz/z52gAigxAfjjqjB4vWZ+npTDH5SwR3/DC+IS2Dkt5x4DPkgi+2
         I0qAax6NtTwPWaXRNp4id/fZauiE72s+De/CvZNexBy6hJpelKoeqylHLenKXz9E+teG
         tQ106qm9A4P1ogdLnqqNr5eYvhyfYjlKDCBp1Y+d/7D/M1Y95GpyLvEr4RBAI0nlxJfW
         C9ZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Sun, 11 Feb 2018 23:25:56 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mark D Rustad <mrustad@gmail.com>, Adam Borowski <kilobyte@angband.pl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel
 <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel
 <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar
 <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        X86 ML
 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM
 <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf
 <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Peter Zijlstra
 <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Jiri Kosina
 <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian
 Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys
 Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg
 KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss
 <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>, Kees Cook
 <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long
 <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180211232556.1fdde355@alans-desktop>
In-Reply-To: <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
	<CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
	<20180209191112.55zyjf4njum75brd@suse.de>
	<20180210091543.ynypx4y3koz44g7y@angband.pl>
	<CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
	<20180211105909.53bv5q363u7jgrsc@angband.pl>
	<6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
	<0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592149007473309773?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 11 Feb 2018 11:42:47 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> On Feb 11, 2018, at 9:40 AM, Mark D Rustad <mrustad@gmail.com> wrote:
> 
> >> On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> >>   
> >>> Does Debian make it easy to upgrade to a 64-bit kernel if you have a
> >>> 32-bit install?  
> >> 
> >> Quite easy, yeah.  Crossgrading userspace is not for the faint of the heart,
> >> but changing just the kernel is fine.  
> > 
> > ISTR that iscsi doesn't work when running a 64-bit kernel with a 32-bit userspace. I remember someone offered kernel patches to fix it, but I think they were rejected. I haven't messed with that stuff in many years, so perhaps the userspace side now has accommodation for it. It might be something to check on.
> >   
> 
> At the risk of suggesting heresy, should we consider removing x86_32 support at some point?

Probably - although it's still relevant for Quark. I can't think of any
other in-production 32bit only processor at this point. Big core Intel
went 64bit 2006 or so, atoms mostly 2008 or so (with some stragglers that
are 32 or 64 bit depending if it's enabled) until 2011 (Cedartrail)

If someone stuck a fork in it just after the next long term kernel
release then by the time that expired it would probably be historical
interest only.

Does it not depend if there is someone crazy enough to maintain it
however - 68000 is doing fine 8)

Alan
