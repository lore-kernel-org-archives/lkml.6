Return-Path: <James.Bottomley@hansenpartnership.com>
X-Google-Smtp-Source: AH8x227qs3oNfIEVAUSkJKGozpS2KcJJQ4V4p3AT4OH++93ur8HXiQdMHw4ArRgzmOb6EH065c21
ARC-Seal: i=1; a=rsa-sha256; t=1518392841; cv=none;
        d=google.com; s=arc-20160816;
        b=jS/idmJczmjbWvEe3FGqboPc0HgP+P1w2klT/f/dIQpsjXjPMd/I0BeM/MiHGjW2AI
         r8ZTNNi8W3JpkIyQOd17GbmKD+stVgjhMl5cEdSEAoa3lR3MOliw4d/cb/6uK3Ixri/I
         kkKrapJTFOHR/QzMWkYgA+HMjuowqDYxtKTg0dP+iunvoXsQ6C3yPKTTOI7DPZk+qIdM
         U51xhH3gVDDx05qT7r91lfe69lmyDbSUFUKAvq0DuuNdUV5wpXeZOTLrcgQgAStDnyc2
         dL3dJbx3dtkA6U2bFk7Fa63/ZblMLxqA6lnwrHSNqk/GOYb08dyy8yIjCFJMHG+Dmf3f
         8yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=2mttT2XvBij6B+0wlRO1/dAD7X6o/Gs9myjhCwiXCj0=;
        b=iKp7yOthnstT3vQPzb40GmAAesOWdzK5YC/PncuFdeZNKtc/Z2aUcIRvQUsth4q83V
         YzKLiUlhdAzSx9Y8L7lSoYVExmAceNb32O3EurPqrELTKZcAaRlnkgbT/2t8ErkURiUg
         Ms76XapmejgsNt1ojCfOxjafEd9FE/+IYg+uA/EOZjYPgckO5cpMM+RtA6Tsq5Lb/6gH
         xOxF/Tdvj+DVa0bKLmZuO+WIZ8j9i4NtX4qt4FGH0POgwNONNyeEJ2s5MSGPdYbcb4wu
         UpFP/9UR1DecsE8jdAkgLvKfcc/cMGgBHcvo99boV4qd9ar0XvhGevQW/JlW59EvIqOo
         EOXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@hansenpartnership.com header.s=20151216 header.b=jdLGyCEw;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@hansenpartnership.com header.s=20151216 header.b=jdLGyCEw;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Message-ID: <1518392837.3979.14.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mark D Rustad <mrustad@gmail.com>, Adam Borowski <kilobyte@angband.pl>,
 Linus Torvalds <torvalds@linux-foundation.org>, Joerg Roedel
 <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,  Joerg Roedel
 <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML
 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,  Linux-MM
 <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra
 <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina
 <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian
 Gerst <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>, Denys
 Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>, Greg
 KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss
 <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>, Kees Cook
 <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Waiman Long
 <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Date: Sun, 11 Feb 2018 15:47:17 -0800
In-Reply-To: <F7FB13AC-EB26-48DE-BDB4-909D19DEAE7C@amacapital.net>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
	 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
	 <20180209191112.55zyjf4njum75brd@suse.de>
	 <20180210091543.ynypx4y3koz44g7y@angband.pl>
	 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
	 <20180211105909.53bv5q363u7jgrsc@angband.pl>
	 <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
	 <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
	 <1518387160.3979.10.camel@HansenPartnership.com>
	 <F7FB13AC-EB26-48DE-BDB4-909D19DEAE7C@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592150292197940124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-02-11 at 14:30 -0800, Andy Lutomirski wrote:
> 
> > 
> > On Feb 11, 2018, at 2:12 PM, James Bottomley <James.Bottomley@Hanse
> > nPartnership.com> wrote:
> > 
> > > 
> > > On Sun, 2018-02-11 at 11:42 -0800, Andy Lutomirski wrote:
> > > 
> > > > 
> > > > On Feb 11, 2018, at 9:40 AM, Mark D Rustad <mrustad@gmail.com>
> > > > wrote:
> > > > 
> > > > 
> > > > > 
> > > > > 
> > > > > On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.
> > > > > pl>
> > > > > wrote:
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > Does Debian make it easy to upgrade to a 64-bit kernel if
> > > > > > you
> > > > > > have a
> > > > > > 32-bit install?
> > > > > 
> > > > > Quite easy, yeah.  Crossgrading userspace is not for the
> > > > > faint of the heart, but changing just the kernel is fine.
> > > > 
> > > > ISTR that iscsi doesn't work when running a 64-bit kernel with
> > > > a 32-bit userspace. I remember someone offered kernel patches
> > > > to fix it, but I think they were rejected. I haven't messed
> > > > with that stuff in many years, so perhaps the userspace side
> > > > now has accommodation for it. It might be something to check
> > > > on.
> > > > 
> > > 
> > > At the risk of suggesting heresy, should we consider removing
> > > x86_32 support at some point?
> > 
> > Hey, my cloud server is 32 bit:
> > 
> > bedivere:~# cat /proc/cpuinfo 
> > processor    : 0
> > vendor_id    : GenuineIntel
> > cpu family    : 15
> > model        : 2
> > model name    : Intel(R) Pentium(R) 4 CPU 2.80GHz
> > stepping    : 9
> > microcode    : 0x2e
> > cpu MHz        : 2813.464
> > [...]
> > 
> > I suspect a lot of people are in the same position: grandfathered
> > in on an old hosting plan, but not really willing to switch to a
> > new 64 bit box because the monthly cost about doubles and nothing
> > it does is currently anywhere up to (let alone over) the capacity
> > of the single 686 processor.
> > 
> > The thing which is making me consider it is actually getting a TPM
> > to protect the private keys, but doubling the monthly cost is still
> > a huge disincentive.
> 
> Where are they hosting this?  Last I checked, replacing a P4 and
> motherboard with something new paid for itself in about a year in
> power savings.

It's a rented server not a co-lo cage.  I don't doubt it's costing the
hosting provider, but they're keeping my rates low.

James
