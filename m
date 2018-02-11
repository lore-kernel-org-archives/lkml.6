Return-Path: <luto@amacapital.net>
ARC-Seal: i=1; a=rsa-sha256; t=1518378801; cv=none;
        d=google.com; s=arc-20160816;
        b=MOnujLaglj62qIIanIrRzFPoqpLZkZnAEzypU4fFRK7IYrNrMx8n+OOXC8QH0Rq1MV
         nz1xLjcqTAPyf68AoTbPrnSBXJ8U8cnbhq/xN/MEsWS6p51psXiKLq9MVNjf1uMNnXP9
         yB5eZTbkIOdD4WMV9/rjfYVOWqvoh/17gUq1vO/zLqJi2ryH+IETpjOM008sbyB4i1P0
         tGLZbAETlIfn/+XIlSQgr8MxgYMyTJIrQLyfpHyWir9HYVqITDIkiqd7sWJ/uJrjKatE
         zCtigHypvY73gdLLOGax0Fs6tOH7FmEgYVb4S/DXB4aHxEZMqA7C/mouIoEpWCD2T8EZ
         Zv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:dkim-signature
         :arc-authentication-results;
        bh=/n/veN2jEjUKLzwbjvaqWlYGOJnaRIJYq9ACXsAMqPQ=;
        b=gdIwMN4P+xpn/efGO2AX8L1iY6Y654nEBIKWet+sDAd+zfey84kkycg4hsgnSwm2m5
         mv73t7rspliVor2aU5tPuXurKB9j43+GDgf32P2H8e5TLoapwqrOsWbAC+o4k0hv+kRm
         FvrB89P+yirBpR/IL/iY/wgPW8EKIp3tQVVffiGHVhF16Dmd1p944vxbqraMVROvizrd
         Kxq7/XMTnxD6gET0k8djbmFXerax/TRQSdWuWYe9nG5Y37D7ss36DPcGznUJNfJhbdbz
         sD2W11d0Yoxmtwghec9B8w5akBJJasVjYUcymfiTTteryZ5LAGWo2DAThVvL830SRdfh
         FeqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=kQR2Bv3/;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=kQR2Bv3/;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
X-Google-Smtp-Source: AH8x226mr1r5HeKA9pvit6wvhfs41ZQ0y2/nfgnVmbZOEbI9LIWEj9SOaLMulQbH3chQJUytrOKCBw==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Date: Sun, 11 Feb 2018 11:42:47 -0800
Message-Id: <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org> <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com> <20180209191112.55zyjf4njum75brd@suse.de> <20180210091543.ynypx4y3koz44g7y@angband.pl> <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com> <20180211105909.53bv5q363u7jgrsc@angband.pl> <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
Cc: Adam Borowski <kilobyte@angband.pl>,
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
In-Reply-To: <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
To: Mark D Rustad <mrustad@gmail.com>
X-Mailer: iPhone Mail (15D60)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592135570093200731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Feb 11, 2018, at 9:40 AM, Mark D Rustad <mrustad@gmail.com> wrote:

>> On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl> wrote:
>>=20
>>> Does Debian make it easy to upgrade to a 64-bit kernel if you have a
>>> 32-bit install?
>>=20
>> Quite easy, yeah.  Crossgrading userspace is not for the faint of the hea=
rt,
>> but changing just the kernel is fine.
>=20
> ISTR that iscsi doesn't work when running a 64-bit kernel with a 32-bit us=
erspace. I remember someone offered kernel patches to fix it, but I think th=
ey were rejected. I haven't messed with that stuff in many years, so perhaps=
 the userspace side now has accommodation for it. It might be something to c=
heck on.
>=20

At the risk of suggesting heresy, should we consider removing x86_32 support=
 at some point?=
