Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELsDpKKKq90MIqR9m/Ye9JyM7H7tXmQvJT+rdxC7SbLmpiLCGv+tijvN1TgEZ6dfVq6k1hBe
ARC-Seal: i=1; a=rsa-sha256; t=1520275008; cv=none;
        d=google.com; s=arc-20160816;
        b=KdVW6P0n0wtQgkm7cyh+5d8fwICpu+MXap8tzQj1CywluQxzXJ9oj7CAZCUUD2Ev+7
         sxvBcbJ+eLeFx/2zyZOTiyuJr2HDWZ0fNN04kp89r2aqgqDaXgk8ger1vCTHa5yGT5KB
         cbbyWgcdl65OOdWDL+Yzgf7MPYIrwF0SLENImI4QRBgIN6wCsoIT5rpOkWBaStbECqI9
         ANxOjrUSLPQV0YULbT03X51cdj2jgAR5+/rzAhQkv/fs8QZtVwJSXehR2AvFVBlJgBu6
         6B80Nr0OBWy4xBbBAClxBroWUy0ABiq8TRY3r95KAt+gMoQ5sH0s1nXdCPLTCKZPdy+i
         TnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=2ic6XS+pXr5PPVVEjxOoFt+kkql0Sa2jTA5+W/8nhIM=;
        b=N5MS7mv4+EIdhpTTfQ1vn3wY2611NU1B5MsTxy0Ub8pxgcl9QZ9jS+EDTIQLxrcTcQ
         YONNAqrvpl7S9+T5ChtqFPu+7ZY89OyeUbejNyrSMnAcNbJMdK4fz1+Vsi32U0uTEnUX
         2flSlBZOi4QRcxitaDC8POiWWX42aiwOf5flZdRhwinokjTBcLVG7ABFGeyP+fPC1Psq
         FhViTyC8hpR8bWwNTA02aS3PMgGOV/FpvJTapz3VJyCsNFPzHVwvUupOKfaSPtoj8BB1
         ScnGCw3SO+kaRNEy+vH6BOzdFEV6byqsTFD28d6WIUS3zQBf3xMTInGesfxdOKU8dG8i
         wzxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=nbTfsFLT;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=nbTfsFLT;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Mon, 5 Mar 2018 19:36:47 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Anvin <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	=?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
Message-ID: <20180305183647.GU16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org>
 <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
 <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594123887705301513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 10:23:59AM -0800, Linus Torvalds wrote:
> On Mon, Mar 5, 2018 at 5:12 AM, Joerg Roedel <joro@8bytes.org> wrote:
> >
> >> The things is, we *know* that we will restore two segment registers with the
> >> user cr3 already loaded: CS and SS get restored with the final iret.
> >
> > Yeah, I know, but the iret-exception path is fine because it will
> > deliver a SIGILL and doesn't return to the faulting iret.
> 
> That's not so much my worry, as just getting %cr3 wrong. The fact is,
> we still take the exception, and we still have to handle it, and that
> still needs to get the user<->kernel cr3 right.

Right, as I said, up to v2 of this series I thought I could avoid the
whole from-kernel-with-user-cr3 game, but that turned out to be wrong.
Now I added the necessary check and handling for it, as at least the
#DB handler needs it.

> So then the whole "restore segments early" must be wrong, because
> *that* path must get it all right too, no?
> 
> And it appears that the code *does* get it right, and you can just
> avoid this patch entirely?

Right, I will drop this patch.

> 
> > The iret-exception case is tested by the ldt_gdt selftest (the
> > do_multicpu_tests subtest). But I didn't actually tested single-stepping
> > through sysenter yet. I just re-ran the same tests I did with v2 on this
> > patch-set.
> 
> Ok. Maybe we should have a test for the "take DB on first instruction
> of sysenter".

I put a selftest for that on my list of things to look into. I'll have
no idea how difficult this will be, but I certainly find out :)


Regards,

	Joerg
