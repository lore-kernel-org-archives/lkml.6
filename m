Return-Path: <James.Bottomley@hansenpartnership.com>
X-Google-Smtp-Source: AH8x225iDfAsgK0nwycULls9AnBVyMEBf4OCVGgWCLGFFzTk8+q4OhhFGoe35n5EJloLOe3Yjo2+
ARC-Seal: i=1; a=rsa-sha256; t=1518387165; cv=none;
        d=google.com; s=arc-20160816;
        b=YDGbwlKwPUVrxEL4p3kKszoLim7kM78RCxoHD43J+ijtolrWMMbWqqeL2ZUjADjgcp
         ihHZQ8EZ1KET/CTgcd/yT/zTL24DTjVO2h+uqiNYhJk62auj5ZaRhgsDhVWIv5f/GifP
         8iKwIM8ngBO0l7iR4YXqyGNUPCgBUjZdWhNzDISIY3/AiFPWJJarQ2F0P4oYXLLhAhM0
         pUc8z6DwswOTGfCT6d6c8cIdTkcLvdZTGfYEc1k8uNRXB1Li/xCnDzfBvolmbKVHQjQ5
         14LzYWx/95tRWsVFMi4GNekPNLbbQWlFKtIrRrp3b4s2e0feRYLSig2+ot5MpnfezZo1
         TDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=dBKEizNKPrxb8y62y7/OWynKpgQZ/inRBEp+HotNpAo=;
        b=SVtQSdyA06FY9rHntf7B8WcRfsNJaarmQ0yNKiGQvry86YNq5OQRlbT0BioKpP/FiW
         mHpqpsveufMsPPzmuokVn5zBI42FeQUmOaK563qr4zX8AnzXHo5wY52fhR5y8nVRObI0
         Not1Yw8bhLDKiYgCnPSvrf0HGfv0t5/kcJo8Cw4vYsz7YgtE/NokUarvGF38De/FwxeH
         atJC9Dqjysg+HeaE7pE8Deqn1pC3CeF3p5wKLzqf6Lwey3nHjTafjZ+h6qmAH8+Dnzmm
         Bd4lb6VQvuf0dZ90lo7OepDO6TykK+9VzjNHuF5kxXpSJvfrs9y/lFlwok+rIzbA3qxu
         luTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@hansenpartnership.com header.s=20151216 header.b=hXCL6kBA;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@hansenpartnership.com header.s=20151216 header.b=hXCL6kBA;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Message-ID: <1518387160.3979.10.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andy Lutomirski <luto@amacapital.net>, Mark D Rustad <mrustad@gmail.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Linus Torvalds
 <torvalds@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, Andy
 Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Thomas
 Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Dave Hansen
 <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen
 Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Borislav
 Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>, David Laight
 <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>, Eduardo
 Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>, Will
 Deacon <will.deacon@arm.com>,  "Liguori, Anthony" <aliguori@amazon.com>,
 Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins
 <hughd@google.com>, Kees Cook <keescook@google.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek
 <pavel@ucw.cz>
Date: Sun, 11 Feb 2018 14:12:40 -0800
In-Reply-To: <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
	 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
	 <20180209191112.55zyjf4njum75brd@suse.de>
	 <20180210091543.ynypx4y3koz44g7y@angband.pl>
	 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
	 <20180211105909.53bv5q363u7jgrsc@angband.pl>
	 <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
	 <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592144339622110628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-02-11 at 11:42 -0800, Andy Lutomirski wrote:
> 
> On Feb 11, 2018, at 9:40 AM, Mark D Rustad <mrustad@gmail.com> wrote:
> 
> > 
> > > 
> > > On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl>
> > > wrote:
> > > 
> > > > 
> > > > Does Debian make it easy to upgrade to a 64-bit kernel if you
> > > > have a
> > > > 32-bit install?
> > > 
> > > Quite easy, yeah.  Crossgrading userspace is not for the faint of
> > > the heart,
> > > but changing just the kernel is fine.
> > 
> > ISTR that iscsi doesn't work when running a 64-bit kernel with a
> > 32-bit userspace. I remember someone offered kernel patches to fix
> > it, but I think they were rejected. I haven't messed with that
> > stuff in many years, so perhaps the userspace side now has
> > accommodation for it. It might be something to check on.
> > 
> 
> At the risk of suggesting heresy, should we consider removing x86_32
> support at some point?

Hey, my cloud server is 32 bit:

bedivere:~# cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 9
microcode	: 0x2e
cpu MHz		: 2813.464
[...]

I suspect a lot of people are in the same position: grandfathered in on
an old hosting plan, but not really willing to switch to a new 64 bit
box because the monthly cost about doubles and nothing it does is
currently anywhere up to (let alone over) the capacity of the single
686 processor.

The thing which is making me consider it is actually getting a TPM to
protect the private keys, but doubling the monthly cost is still a huge
disincentive.

James
