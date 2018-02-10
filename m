Return-Path: <kilobyte@angband.pl>
X-Google-Smtp-Source: AH8x226Z8AHJ+/ahUWCFwioOrnTHjSohaiPMzFmBkpySUvivSMqcdZgjUPCmxdSRrBUPWZ2rYLG4
ARC-Seal: i=1; a=rsa-sha256; t=1518254456; cv=none;
        d=google.com; s=arc-20160816;
        b=HWKRlfosD0l1v9uIZSbJoo06hRT51zXUt+JTmmQZ0y/Qmugoy/Odn8CL0cfu4pAXEA
         b8tpDk3pn8F8dh1QJg+QqDQBjaPKuKfOOwxYzQHCpvh8Tgxak8xhXAMIrjWjEJko9IEy
         O4ObvQYc/NC5Bql6mqGRbbzf098ZoD8VXN+MNFKkdYFCfkQ1UUSfvaFkdXdTZX2vZtDD
         tp/OQ2HNLpRDWimFeMy/ratiV005sUbEQV7OExyYU58vmuf7hszUWhXi7uRThjWGpuM7
         VNPuTYvCYnPqEgUGIenYW9pR+GBIWZVBfPNrIFwWuCKJyvx04GMNuJQlu+DVce8IYTys
         HIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=r1QKlq41VoCxZ9fWSggx/qDVmIerO5jJzZlmf/IlhEc=;
        b=FdjXO9SvB1FyjffusurcIZ1CUlXYd7OnHNk3qda1MMDLV5YqACMdEcvYZ+/3ebOGgs
         V1ht2zA0iyIWKULIuj15ASRTbi2/jAxiBsB+AKidJWxi8Awk0sIs7yVZnsfEw/FugLzz
         WCrFQQySflWIRpzl+CWesfKKpE+HTjFZ3lcDuKy1JRcCYbWmvWV0g1GGL4/TYZPDkllV
         HGW6xDVWzjTXJtQNcv0+82xSlv/Xq7moXPfvhu1IWuVEatXiKG6GdLHtHR17cOiJtF8N
         ZYjFo1ozHZ6+x7LnWTvcDnogr2/wXFpqxXVkRYs6+dKm8Sryh5jrEaE7MPik7fUmN9q6
         6a3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kilobyte@angband.pl designates 2a03:9300:10::8 as permitted sender) smtp.mailfrom=kilobyte@angband.pl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kilobyte@angband.pl designates 2a03:9300:10::8 as permitted sender) smtp.mailfrom=kilobyte@angband.pl
Date: Sat, 10 Feb 2018 10:15:44 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <20180210091543.ynypx4y3koz44g7y@angband.pl>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180209191112.55zyjf4njum75brd@suse.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592005184322673525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 08:11:12PM +0100, Joerg Roedel wrote:
> On Fri, Feb 09, 2018 at 05:47:43PM +0000, Andy Lutomirski wrote:
> > One thing worth noting is that performance of this whole series is
> > going to be abysmal due to the complete lack of 32-bit PCID.  Maybe
> > any kernel built with this option set that runs on a CPU that has the
> > PCID bit set in CPUID should print a big fat warning like "WARNING:
> > you are using 32-bit PTI on a 64-bit PCID-capable CPU.  Your
> > performance will increase dramatically if you switch to a 64-bit
> > kernel."
> 
> Thanks for your review. I can add this warning, but I just hope that not
> a lot of people will actually see it :)

Alas, we got some data:
https://popcon.debian.org/ says 20% of x86 users have i386 as their main ABI
(current; people with popcon installed).

Of those, 80% use 32-bit kernels: i686 881, x86_64 229, i586 14
(uname -m included in bug reports; data for 2016) -- and bug reporters tend
to have more clue than the average user.  There's no way so many folks still
use pre-2004 computers.

Thus, if you could include that big fat warning, distro developers would be
thankful.  Make it show fiery letters if you can.  Preferably, we'd want a
huge mallet reach out of the screen and bonk the user on the head, but with
that impossible, a scary message would help.

Let them use 32-bit userland, but if someone runs such a kernel on a modern
machine, some kind of verbal abuse is warranted.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ Vat kind uf sufficiently advanced technology iz dis!?
⢿⡄⠘⠷⠚⠋⠀                                 -- Genghis Ht'rok'din
⠈⠳⣄⠀⠀⠀⠀ 
