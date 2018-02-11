Return-Path: <luto@amacapital.net>
ARC-Seal: i=1; a=rsa-sha256; t=1518391380; cv=none;
        d=google.com; s=arc-20160816;
        b=0FPxqyOwwhSYgZmgRiw6DEKV4MvmaAasIX0mVeSOh5MkO80LT+cxzP2GbKLFFFsAB1
         EHh13p6A6SlKV+5BZX8T1VfCTtZqd9t6i7ZuNyvmTsjKDnYMdc0KuMd8Lac+3AL3x5au
         lYveViMTthuSHslPDMsLjXNwhEOrssYSJDP9mNmZCl+ul5iP1QhrFLqfm/lu6QB2gBhE
         WK20yFj5pJ5Zb2JHw+Q0XHouarF0UPzFvzVi0PDX9HpAUBHsZRddbIruJnp3gJ4itEKW
         F+Hi0V3XHOWlRA1dEaAcPW9r9yqRGPLSEfxd+Eesm/oJuUfPSvQMnlTItBYZXPKK9wHJ
         JI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:dkim-signature
         :arc-authentication-results;
        bh=JeqfHkJv3Lnd7GRL594OWFf2hOrya7nrjbKh9pZqTVs=;
        b=WDU/gusJaprx+YX6NI8VtqIiSVlMySvJxTyGpmAuNzSYQwdqx4vpsVrqHFFJ8Roon9
         z/4VUIp8nNFp0PqO0ZHCrR+aXmt/yGcW+tKBkW5fqIvX/ISWonIQHNkWLf6Hhnkuvpnk
         rEjrWlWMqxRWxCHv7pgatojyKQmQNzjxx1BaGJv2R1Wrg4gZLBMDEFmJDa2L+jt7/r8T
         iSxar7iW/K8leFQlz4aJ/1rCjGVXU2buApAL68frXJmveyY1WyUHyHr3SaYHyPGCFYSi
         iMWLmneHEgtnjfr4VDA8OXA6uKrXZ1xsQXwBywzmtR2PtgknIBLzcg88OLXGPOpzfQyD
         TffQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=idbrwVNP;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=idbrwVNP;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
X-Google-Smtp-Source: AH8x227ew5yhgFJAEVOLz0nukuw7csKnKhy29aoiXTo/Hcbg061hRd67v4ng5buBmk9zfeuldcSplg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Date: Sun, 11 Feb 2018 14:30:15 -0800
Message-Id: <F7FB13AC-EB26-48DE-BDB4-909D19DEAE7C@amacapital.net>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org> <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com> <20180209191112.55zyjf4njum75brd@suse.de> <20180210091543.ynypx4y3koz44g7y@angband.pl> <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com> <20180211105909.53bv5q363u7jgrsc@angband.pl> <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com> <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net> <1518387160.3979.10.camel@HansenPartnership.com>
Cc: Mark D Rustad <mrustad@gmail.com>, Adam Borowski <kilobyte@angband.pl>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Jiri Kosina <jkosina@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Brian Gerst <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
 Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 "Liguori, Anthony" <aliguori@amazon.com>,
 Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
 Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>,
 Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1518387160.3979.10.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: iPhone Mail (15D60)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592148760079235196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On Feb 11, 2018, at 2:12 PM, James Bottomley <James.Bottomley@HansenPartne=
rship.com> wrote:
>=20
>> On Sun, 2018-02-11 at 11:42 -0800, Andy Lutomirski wrote:
>>=20
>>> On Feb 11, 2018, at 9:40 AM, Mark D Rustad <mrustad@gmail.com> wrote:
>>>=20
>>>=20
>>>>=20
>>>> On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl>
>>>> wrote:
>>>>=20
>>>>>=20
>>>>> Does Debian make it easy to upgrade to a 64-bit kernel if you
>>>>> have a
>>>>> 32-bit install?
>>>>=20
>>>> Quite easy, yeah.  Crossgrading userspace is not for the faint of
>>>> the heart,
>>>> but changing just the kernel is fine.
>>>=20
>>> ISTR that iscsi doesn't work when running a 64-bit kernel with a
>>> 32-bit userspace. I remember someone offered kernel patches to fix
>>> it, but I think they were rejected. I haven't messed with that
>>> stuff in many years, so perhaps the userspace side now has
>>> accommodation for it. It might be something to check on.
>>>=20
>>=20
>> At the risk of suggesting heresy, should we consider removing x86_32
>> support at some point?
>=20
> Hey, my cloud server is 32 bit:
>=20
> bedivere:~# cat /proc/cpuinfo=20
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 15
> model        : 2
> model name    : Intel(R) Pentium(R) 4 CPU 2.80GHz
> stepping    : 9
> microcode    : 0x2e
> cpu MHz        : 2813.464
> [...]
>=20
> I suspect a lot of people are in the same position: grandfathered in on
> an old hosting plan, but not really willing to switch to a new 64 bit
> box because the monthly cost about doubles and nothing it does is
> currently anywhere up to (let alone over) the capacity of the single
> 686 processor.
>=20
> The thing which is making me consider it is actually getting a TPM to
> protect the private keys, but doubling the monthly cost is still a huge
> disincentive.

Where are they hosting this?  Last I checked, replacing a P4 and motherboard=
 with something new paid for itself in about a year in power savings.

>=20
> James
>=20
