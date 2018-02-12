Return-Path: <al@alarsen.net>
X-Google-Smtp-Source: AH8x226xyY6TGdDL/LUKt4YRyez59haRTiqsszNrdDswfZGKYQl3i0RGt6nykt6P/pqvQgG1stG0
ARC-Seal: i=1; a=rsa-sha256; t=1518430587; cv=none;
        d=google.com; s=arc-20160816;
        b=N6r3nSocYj5M5k/ZXy5dEJ3dHmygtfstDzq73ltk0EJ0d7XPF8KJqUKJJ0RsmTja35
         UnVO6PgGflGeOLY3A/2/SQa9uW0nCBn+6fK+C2iz4EHGDHnPGw/k7e4pA4N2+kjOT8NF
         FU+9kzth8XUph0mjmJi/M3toUwhKrbLVTSK73oLsSC6omQjMWnXr3bwWhFGEgZApTxgh
         H2M3VMacl5DpW8qNEEUIZzxc8RHBH08+JQmBL3e8ku3QZVddkQwHBBC9d2M/+wPq3qVb
         d3vCBuGaokEr3z3RhvD5iZVpslJnFtr5o9Ky34L53Brmfto72SYQEppcWEdhoF87m3Fk
         9Piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :user-agent:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=T33djTyTju/IGD5+wyNYCqL5SYdCGi+XFsueDzgmDNM=;
        b=kAFQYQmRaO0g3T96RGlGttoJMqainjeXdE02nz10YAWSAD7NEE2Gssqi4RGleKlpHh
         nx10JuE55JH22PqZkMclqGTjryv5Dqh5b5OZ+g4OJlJ3d4j4bMGtSkzAEYpPVG1U2WS6
         c2GkEriJ/nZbaPRl89tmLcE1i2unqI4TK0Yed9XuWnyp+s7ncYx63NKx9cnge3taBzBo
         d96G7CyB4o5ATvzAYp34Xbfv9dlP2nIEzV56vMOLTFZIZhTjJBZl2lazLFOQxEucTWNs
         4w5dvc9Ga0EvFDwq6JwWCNvtun6UCMwJc38eTdEkqUc+qLNgjxLXAGaQQ97MLBmCDWPM
         UXvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@alarsen.net header.s=joe header.b=Fy1J8hUW;
       spf=pass (google.com: domain of al@alarsen.net designates 144.76.18.233 as permitted sender) smtp.mailfrom=al@alarsen.net;
       dmarc=pass (p=QUARANTINE sp=REJECT dis=NONE) header.from=alarsen.net
Authentication-Results: mx.google.com;
       dkim=fail header.i=@alarsen.net header.s=joe header.b=Fy1J8hUW;
       spf=pass (google.com: domain of al@alarsen.net designates 144.76.18.233 as permitted sender) smtp.mailfrom=al@alarsen.net;
       dmarc=pass (p=QUARANTINE sp=REJECT dis=NONE) header.from=alarsen.net
From: Anders Larsen <al@alarsen.net>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Andy Lutomirski <luto@amacapital.net>, Mark D Rustad <mrustad@gmail.com>, Adam Borowski <kilobyte@angband.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <dani
 el.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Date: Mon, 12 Feb 2018 11:16:24 +0100
Message-ID: <4155513.GHlSKmbAgC@alarsen-lx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-112-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180211232556.1fdde355@alans-desktop>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org> <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net> <20180211232556.1fdde355@alans-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592189871914031033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sunday, 11 February 2018 23:25 Alan Cox wrote:
> On Sun, 11 Feb 2018 11:42:47 -0800
> 
> Andy Lutomirski <luto@amacapital.net> wrote:
> > On Feb 11, 2018, at 9:40 AM, Mark D Rustad <mrustad@gmail.com> wrote:
> > >> On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> > >>> Does Debian make it easy to upgrade to a 64-bit kernel if you have a
> > >>> 32-bit install?
> > >> 
> > >> Quite easy, yeah.  Crossgrading userspace is not for the faint of the
> > >> heart, but changing just the kernel is fine.
> > > 
> > > ISTR that iscsi doesn't work when running a 64-bit kernel with a 32-bit
> > > userspace. I remember someone offered kernel patches to fix it, but I
> > > think they were rejected. I haven't messed with that stuff in many
> > > years, so perhaps the userspace side now has accommodation for it. It
> > > might be something to check on.
> > > 
> > At the risk of suggesting heresy, should we consider removing x86_32
> > support at some point?
> 
> Probably - although it's still relevant for Quark. I can't think of any
> other in-production 32bit only processor at this point. Big core Intel
> went 64bit 2006 or so, atoms mostly 2008 or so (with some stragglers that
> are 32 or 64 bit depending if it's enabled) until 2011 (Cedartrail)

FWIW the Atom E6xx series (Tunnel Creek) is 32bit only and still in
production; my employer is using those beasts in several devices - and I'm
fighting an uphill battle to have those products ship with a recent kernel
(for certain values of recent)

> If someone stuck a fork in it just after the next long term kernel
> release then by the time that expired it would probably be historical
> interest only.
> 
> Does it not depend if there is someone crazy enough to maintain it
> however - 68000 is doing fine 8)

Cheers
Anders
