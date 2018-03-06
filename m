Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvNX4ktQEM3Wi+r9WTIpKjSGo0e2/ame04z/gZIrvAnRvxV8XKDpF/L43UGb2bMBg3+YO0y
ARC-Seal: i=1; a=rsa-sha256; t=1520325500; cv=none;
        d=google.com; s=arc-20160816;
        b=yQuodZS+IvJfCHJoasp4jtjhDWoc83Y5ecRdo00rfPmFHvKMwSb6QcPNce9WDw2pvL
         IB3ipvcjCxrDc+PgdEce9JxGjiQnrkS711I36bJJqnMRkHb9K0yn8DwPYhJV4I2bO7EL
         AoJVz16b7L2yN/nBG5PuAH6PheyvamPkWsMeoOs4Bdm10BlKMXr9/2Uxm0xGrPy4Q+B5
         NIr+87SIeVIVaaXgRAZyiK9MpmjqdbDFITXEy17swud9t3w6hYm+/65nj9OpKym8pasB
         t4MnvH+A10b4xf3OST1Oxouzyx8rR78z/DkkgoBxFqPgigqyy9KKJU7r6k8qmJEclCFe
         xaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=s81gPEOIt+ifi6+OJ7cndyBgdihKlxUZVU0NC0GDqKY=;
        b=BmSmDyExRFyJ6uCK0ZAKKSRJaChJzpfSRtx+6gTJH30YLdkd5Xm29QNP2STOpJQUDG
         jtcvxAgZOjcSdEnl0ejTLiL9x4FDCEeJbYCvhbhj7uxza+vq2omx3KjnYQVhxpjoNSb4
         1YERzIEOYEqo7y8zupTQuM2JsaLFpqIqP/0LYr7EbKQqpCfg1ng1Kh9WuS7iCgDmBNcF
         AlHkoMsdh3w4K0F/QqIyQCfn8nlOhKqF6L89W1GrDykl9D4Cb9ddYbA2xcys+WJdmbSe
         Gl61HRvqvK/eEysumMREq3MvkPEc1dL/BWljCO8s6eAApMI/5ONY7kfCdSfEAX/aGCOC
         NSNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=gp3t3qpA;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=gp3t3qpA;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Tue, 6 Mar 2018 09:38:17 +0100
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
Message-ID: <20180306083817.GW16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org>
 <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
 <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
 <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
 <CA+55aFwxiZ9bD2Zu5xV0idz_dDctPvrrWA2r54+NL4aj9oeN8Q@mail.gmail.com>
 <20180305213550.GV16484@8bytes.org>
 <CA+55aFx2dxZmL487CnhV6rWRiqmJwZNAspyPqCD4Hwqxwncs6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx2dxZmL487CnhV6rWRiqmJwZNAspyPqCD4Hwqxwncs6Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594176831967513708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 01:58:32PM -0800, Linus Torvalds wrote:
> On Mon, Mar 5, 2018 at 1:35 PM, Joerg Roedel <joro@8bytes.org> wrote:
> > I could probably add some debug instrumentation to check for that in my
> > future testing, as there is no NX protection in the user address-range
> > for the kernel-cr3.
> 
> Does not NX work with PAE?
> 
> Oh, it looks like the NX bit is marked as "RSVD (must be 0)" in the
> PDPDT. Oh well.

I had a version of these patches running which implemented NX on the PDE
level by allocating 8k PMD pages. But that ended up needing 5 order-1
allocations for each page-table, which I got to fail pretty easily after
some time. So I abandoned this approach for now.

Maybe it can be implemented with order-0 allocations for PMD pages, the
open problem is how to link the user and kernel PMD page-pairs together
then.

Regards,

	Joerg
