Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x226fszuMN5CjFu5B8KSb1ZESNigW4gE05oPYDPUtJfolvPwpRXUQ/MYlev+CobwIYPGum+20
ARC-Seal: i=1; a=rsa-sha256; t=1518183308; cv=none;
        d=google.com; s=arc-20160816;
        b=PJMmpsFxawxMbhY8e76h66CmPLmCQHXVNdxpGguPE6uWnIocv3RPs5+xeOH5xrxHER
         0qSKpj8Lnq6MPTiCinPM6f/4wXlHd9gX4bbIeIcuHOUyjHUr1cfDq9Mh18rsCG7UVRBd
         enGG2IhN39UwyYRWHCi3anzGDcO1nW0NGhFNQDtJ6cuxi0M9vZ2FKwKARPv3W5sblv/T
         WuUojg2ZJzjb0FtOEOnHU9v5VeYo8BZndEyRTauQ8dUoH7wEjIHUa1+uhrstxA+yJC33
         NfMvBfbzhd+/pqPaDLDDXSLAANxKbFdcCHtKw01myiEuav23/sD1Wc/pMqZ7jBUAojuI
         IYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=qcqKNoyd5djny+kaoYTMLjCAsRnB8p3C+jm90w4kPl0=;
        b=Lfezueuw8bJHpLmlJpfqNjFgyoP16yO7UG2pCHuH0I8y21bY1ArLdXtRyZklKe6LRH
         xyKqlx8IcRTuil47E9D3DRqCDXEluMjHS9AT6wiM7YSLfB2agQFjNT1LAKUGSQ/5GPkf
         lRWf06RiyhN3NFC11JS6y5hv6s6dl8YDvQqfz+aDiSVUtMkRRRxFoPJybSa4JBJ1/WQk
         dQ49zHf7RCwttMAoJTIz7lH3DwN/S4eQIYrpB2coMScGbp3EVLlEg4HlBw/LOtoIyLV1
         q9417/1+JcFZf5aiQWww+ny8xQdVM23CdILQLZDQo94nHSwkkWVk4xvzH1SQ9Qf0lsbX
         ofFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=nVQQq6Px;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=nVQQq6Px;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Fri, 9 Feb 2018 14:35:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180209133507.GD16484@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <35f19c79-7277-3ad8-50bf-8def929377b6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f19c79-7277-3ad8-50bf-8def929377b6@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1591930580926429751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Juergen,

On Fri, Feb 09, 2018 at 01:11:42PM +0100, Juergen Gross wrote:
> On 09/02/18 10:25, Joerg Roedel wrote:
> > XENPV is also untested from my side, but I added checks to
> > not do the stack switches in the entry-code when XENPV is
> > enabled, so hopefully it works. But someone should test it,
> > of course.
> 
> That's unfortunate. 32 bit XENPV kernel is vulnerable to Meltdown, too.
> I'll have a look whether 32 bit XENPV is still working, though.
> 
> Adding support for KPTI with Xen PV should probably be done later. :-)

Not sure how much is missing to make it work there, one point is
certainly to write the right stack into tss.sp0 for xenpv on 32bit. This
write has a check to only happen for !xenpv.

But let's first test the code as-is on XENPV and see if it still boots
:)


Thanks,

	Joerg
