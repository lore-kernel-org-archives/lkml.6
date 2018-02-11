Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x227TsATy+CVtDABPAvz9oNk0RRBniS1mw4JeJnN/kllT1UbMumfT9wCVnARGFFu276sabOvJ
ARC-Seal: i=1; a=rsa-sha256; t=1518388461; cv=none;
        d=google.com; s=arc-20160816;
        b=WO6ToHk3afCRA0ySF07Nuke4xszILC8S1bdwH+w/ahzIcVFe5juHQq7rlF/nl/92Er
         GfKHoe5jsRXRaLUBttfInpfAaqMCJ685yQCD0zaQQSm0AkIVm70pWKxPwjAapXIM2k/P
         aIu9kxY0PHywC80R8vE30w7B6QmHBNG9v6BAZ/uDwhFuKxU/K5C0SAVHG+fyguWf9g+h
         2pnQDBDMpPfH2OrYrEHh5OJ+SYayVpikBbPdszHqnJTKoGNw53i+ENYyW/XHGMYGMC7v
         0MVImYKAEn51iqJ4wd/szTpcSwNtiNH8NS0YTpYIX7bJUQ0i34U1UxRD2kSypZP489vw
         Ywfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=M0HjyEd+eqLXcWSYVgYIFaeG1hxwhQNj3nMgfzKUnXo=;
        b=l0nXWub0+inpspoU8zyb0BNLm4WzBX1NM3Wrh6mS5hXBjFWovJLmv6vpRr0z253aQP
         82nX7R45Dc21g9cWFP0WigKmQq522nlinayWBGCK1vCGb9b4BEalwgJBJdlP2lGYM1on
         14XbQt9QIUH2pNqXMwzQrRo+LFG/8yO5Ws+HxRkPCzggu3NBY8QA/0s9QdCUz8Ae40BT
         xqREU9A+S2tmDYOdDzfdlJQBnQEuvPpchua9CWqhjkYX8RP4UlbS7PLo3X8B2iXGHiFa
         sRrOcAQriiPrTAPSCRUOMupXQ2mNOeNo3QPbZx7mmLpd/bg35bgkgICAG5F0Nq0pw/Yp
         dE0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Sun, 11 Feb 2018 23:34:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mark D Rustad <mrustad@gmail.com>, Adam Borowski <kilobyte@angband.pl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
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
	Waiman Long <llong@redhat.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180211223416.GA3762@localhost>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de>
 <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl>
 <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
 <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592145699758755881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun 2018-02-11 11:42:47, Andy Lutomirski wrote:
>=20
>=20
> On Feb 11, 2018, at 9:40 AM, Mark D Rustad <mrustad@gmail.com> wrote:
>=20
> >> On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> >>=20
> >>> Does Debian make it easy to upgrade to a 64-bit kernel if you have a
> >>> 32-bit install?
> >>=20
> >> Quite easy, yeah.  Crossgrading userspace is not for the faint of the =
heart,
> >> but changing just the kernel is fine.
> >=20
> > ISTR that iscsi doesn't work when running a 64-bit kernel with a 32-bit=
 userspace. I remember someone offered kernel patches to fix it, but I thin=
k they were rejected. I haven't messed with that stuff in many years, so pe=
rhaps the userspace side now has accommodation for it. It might be somethin=
g to check on.
> >=20

It might make sense to retry those patches... if we want people to
move to 64bit kernels, it makes sense to provide complete emulation
for 32bit distros...

> At the risk of suggesting heresy, should we consider removing x86_32
> support at some point?

Heresy!

We still support 486s. I don't know if anyone really uses them, but
T40p is an acceptable machine to ssh from. X60 is still the machine I
prefer for traveling. Fast enough if you don't compile, and nicer
keyboard/screen than X220...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
