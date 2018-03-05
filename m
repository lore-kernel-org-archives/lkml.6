Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELunzyjFUAWddkZ+sXUCWVRmDZPpWEep+o0i9IfwqMEYJjBa7H4jxbQB2La+SWHN6/0LRYVX
ARC-Seal: i=1; a=rsa-sha256; t=1520285752; cv=none;
        d=google.com; s=arc-20160816;
        b=eDwZ5A3qD1623Wsuvxz+NqVizbq51vlm7zINJYuiratgrslN1zPy3jZ+2kUvNdTJAF
         1SsLQQLKIHLlDocgKF9QYHVNUMLyjLqdrNr9CRBkHaVMPCupKT6me9x8ULJ43RLoNIGs
         S/wchzgKW8phMxktcdQb7d7c7JFlmY9ppb/tHFByS26wtldRKS6PNryXKRFvKZO5OuNT
         MipDmvGEeBPhsATSD9XKntO3cZvjvDi/V/9A6laqKZlYyyJIZWV4iuvDvfRr5OQKntQe
         o8jnD1mD+4+rsW0/eJ3UKOcDka6s3TTklyKurb0iWsjzAh7EcL07ukXWp80RKPNGSYxT
         JY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YkG5o87QVFAv4DcoNh0ORrjGhd/zFyVM+rEWX6BE5v8=;
        b=TKh3f7OKpFk7ghBfAlLu5r/gqJtaL7IlnnC12D/M6NYY4NaAAPNWXzixV7vZtyK4H/
         8bDmUZrZK4DVHy/Eg98/jCuBz+qGRFBhAanjwf/vcr6tA0jIXYAP0Hy88m0s3JyV+xNL
         TL9hvb7M3VHOX/pLwKeGQ3Aa640Bk3q9yCMWxD7+lz+ldMEApu/kwMxDrpbng4eUxMjb
         gO1ml6+NjejZSdUb5ueFp3PHWeWePrYu6xYE2jW2mxhV9rTu2eHU+XCfDZHlp0xalUm7
         JFWOaRGfgWNUQD/edxmY8mnGXJbAwi9/VljCbwRqGlpxEuXlxgzXYXy7WjfWKZL9e9Uz
         78kA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=AXamb/K9;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=AXamb/K9;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Mon, 5 Mar 2018 22:35:50 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	=?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
Message-ID: <20180305213550.GV16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org>
 <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
 <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
 <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
 <CA+55aFwxiZ9bD2Zu5xV0idz_dDctPvrrWA2r54+NL4aj9oeN8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwxiZ9bD2Zu5xV0idz_dDctPvrrWA2r54+NL4aj9oeN8Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594135152408786415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 12:50:33PM -0800, Linus Torvalds wrote:
> On Mon, Mar 5, 2018 at 12:38 PM, Brian Gerst <brgerst@gmail.com> wrote:
> >
> > There already is a test: single_step_syscall.c
> 
> Ahh, good. So presumably Joerg actually did check it, just didn't even notice ;)

Yeah, sort of. I ran the test, but it didn't catch the failure case in
previous versions which was return to user with kernel-cr3 :)

I could probably add some debug instrumentation to check for that in my
future testing, as there is no NX protection in the user address-range
for the kernel-cr3.


	Joerg
