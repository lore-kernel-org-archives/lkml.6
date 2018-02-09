Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AH8x225R2b96S9j5jHeWZcwKBnyQ/OdmkWK+gYvaWaiPXNHxNZTchC3GtsrQhVo9HjHDGNQTnvzg
ARC-Seal: i=1; a=rsa-sha256; t=1518198485; cv=none;
        d=google.com; s=arc-20160816;
        b=kUjL9TV0Z+S7lL4qxSkjqQcn4n3tGgdwHkJE6foC121sJC6NCI6lwftbkQCqOPFZqp
         JKd33M3FUA+X56WaBoMzrVZ+HMEGGjCM3oRkxLONz1k0ONv1G9jCv/VEUlEbEnCquUPN
         9rBMaJqBwSwr5VpKUKrlPznnkWpekmpv3NN/VCqwMgNfpnvS18PNk4nj+TgtNV2so0OW
         3paj7DAg1dCbLFgeVtW4T/ZxY8T1avp2OwQi7amlcstwoJrG3CUKO8gAKt33gMIP1O3x
         Id+qtj+6U9NEXdWY3wctGMEB487/M2shq7QJcoK8/BLh5wLzTfJO5aWiTDtdpcX3H0DY
         hOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=Jp02DY9Ua833tCIgfbeK9FnMXZHm+7uGrP5YA1AaxHg=;
        b=F0HxLyt5HIIlr0CI7AD3fTeeBFaVuVmmFnOXOPYmbgY24APESsuXXPA6HrqEu0tla8
         DlilTkO4iVI1doCF8PHmoeIirnJ6ZkkkQ6clYuXbNNH8pW4pD6kvXHrFzcWW2Bf0n4Rn
         EIIhd2uZPfisKC21ZRJ+CPoE2yAcuBIlXC/h7YvfRULOJZ7tkeV9mOcBAdAPEqm8ANEB
         OVG/eM3OXGzxhZcBbyJgMpDuiANr3bGnobE+hJoA3pIT37EdLuEpTfEbp+nwdcHl4PQX
         nLKsZbsWo/ierjEtCHD9XRZmXK/RYoQBlt/8DYbvGSUfQdM3GTgH323f6B5/RWNtuOIJ
         MMeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A5B217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 9 Feb 2018 17:47:43 +0000
X-Gmail-Original-Message-ID: <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
Message-ID: <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1591946494654213614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 9:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
> Hi,
>
> here is the second version of my PTI implementation for
> x86_32, based on tip/x86-pti-for-linus. It took a lot longer
> than I had hoped, but there have been a number of obstacles
> on the way. It also isn't the small patch-set anymore that v1
> was, but compared to it this one actually works :)

One thing worth noting is that performance of this whole series is
going to be abysmal due to the complete lack of 32-bit PCID.  Maybe
any kernel built with this option set that runs on a CPU that has the
PCID bit set in CPUID should print a big fat warning like "WARNING:
you are using 32-bit PTI on a 64-bit PCID-capable CPU.  Your
performance will increase dramatically if you switch to a 64-bit
kernel."
