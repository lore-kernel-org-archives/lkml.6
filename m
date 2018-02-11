Return-Path: <kilobyte@angband.pl>
X-Google-Smtp-Source: AH8x226zKY1CVL0mx44S9/ddS65FcLPudNBaYaXOMJFldBr6Mp6apJyQxAqklP3cjLu1CjgDxKys
ARC-Seal: i=1; a=rsa-sha256; t=1518347031; cv=none;
        d=google.com; s=arc-20160816;
        b=Cw7H4uuuAc9gfZuXxiAFLbdBaPJxXM071jquhLmC+lZB5T/lGURcVvKVL6T9u9kFKs
         iEDapOg7fo8G7a8/6q5FncRmI8HUKI6J8RHnOqcNQLtz0zXLXSFgGA5YiyanMWAOEnpO
         xqZoe3xUt4V5QAotjHv3sopCMAoadLOCgycQvNUAp2syTshZ8zmUUdA21Vp4Yb7vrYqa
         oj6I+mTti6KmFGpQDUR2KUfwa0KAR0+9kDbc6rnCj1yhYK8kjOJ1i0GnOv6t3856M6SM
         eHlxZuQ1BU4Fnm6SwsfMnlBiVV9Rr7xDzOIQKQIFmcbUbTw0srrU+RFMTrbAZSVfuppd
         PHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=l9Hm78j0bkfydma2VpuA8qWse+mmkMWuhrP7vyu/fQ4=;
        b=QC8qn0pTfSUOaNMYnpmCsWRkCu6BqyqZQTFADoV8qOJtJfbEq5VZ158+WVqMqGYnfO
         U9dPWcQkyBsHVG/GC+cGhz1lTgIajx1HGZbBp3IRZq6c1F9Zaf1lvcSAgsNWrJnxJxoE
         3g+xADjcMZhRBNv7s4hcoayZMseD78t0GmwJHdSzL2U0JVqpi1vtU6BSVqQ5n6f23cck
         34n17ORs4dH/Sk+Oe4Jv1DrgyQXLssIZ8V3PK21F5aSboJAq2S6N+zuqHhfo5ERzLjSV
         hbzXU3x4XN1/kLO8+Cd2nwqeqAP35LR0cb7M9lIVGJgRz1lO+I413I12yg46xmrJRJNM
         pAiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kilobyte@angband.pl designates 2a03:9300:10::8 as permitted sender) smtp.mailfrom=kilobyte@angband.pl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kilobyte@angband.pl designates 2a03:9300:10::8 as permitted sender) smtp.mailfrom=kilobyte@angband.pl
Date: Sun, 11 Feb 2018 11:59:09 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180211105909.53bv5q363u7jgrsc@angband.pl>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de>
 <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592102257045392231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 12:22:59PM -0800, Linus Torvalds wrote:
> On Sat, Feb 10, 2018 at 1:15 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> >
> > Alas, we got some data:
> > https://popcon.debian.org/ says 20% of x86 users have i386 as their main ABI
> > (current; people with popcon installed).
> 
> One of the issues I've seen is that people often simply move a disk
> (or copy an installation) when upgrading machines.

Less skilled users (ie, most of them) had until recently a different hurdle:
the "32-bit" option was shown way too prominently, without an explanation.

> Does Debian make it easy to upgrade to a 64-bit kernel if you have a
> 32-bit install?

Quite easy, yeah.  Crossgrading userspace is not for the faint of the heart,
but changing just the kernel is fine.

> Because if not, then it's entirely possible that a lot
> of people started out with a 32-bit install (maybe they even had a
> 64-bit kernel, but they started when the 32-bit install was the
> default one), and never upgraded their kernel.
> 
> It really should be easy to _just_ upgrade the kernel. But if the
> distro doesn't support it, most people won't do it.

I just realized that, for people who use distro kernels, the right way is a
message during upgrade.  Ie, it's up to the packagers rather than you.

Having a dire-sounding printk, though, would still be nice.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢰⠒⠀⣿⡁ Vat kind uf sufficiently advanced technology iz dis!?
⢿⡄⠘⠷⠚⠋⠀                                 -- Genghis Ht'rok'din
⠈⠳⣄⠀⠀⠀⠀
