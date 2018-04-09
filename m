Return-Path: <jb@essential.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523270478; cv=none;
        d=google.com; s=arc-20160816;
        b=SVm2KYMcno+7orBiHzLyCwEQK6nCaGib9r2wtN6kKuYNy6iagDlLNZg/oJY2Ny7KIg
         Xo8Bat291iMCr1gUI4dyaGRTgYQW6jpsZ260vZPYqSizfccRABL/FHlWLcJMeDipa8qG
         cTvoUXXic/Dwq0P2Ou4Snm1QVyrKXgZQpuZHrVvlSK8TjIwCpLAY+Q4iCYy3ZAMYA2aO
         DiMdQHxpLV0q+MK4D+iD3mIZax4MSfT7r7aJ/HE4TSJNmCCTwO6zHmZXi7BrCOs5s4l9
         SLm7ATjvuvso6evwtlru9HecSlLpATeeDnOPuv6H+4IKWHS4wEPXtsjU2xOZAHJRva50
         1oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=rsERyF8R/uvwVfeqiArJtpByQe4VsOkA9/Jgt0+N7as=;
        b=D/MnBLaF430xnLg6qqXY3As21F/fEFPkYYGkpDvEBbC6u5M4OpbrjYG91Oex56vHNK
         wgN9w9yzf309+svgek3xGCA5Nldw78Egpv3+S7i1EIcpYVhmpnZhQNbaok8xemtzsrYM
         NdEtV9+goHFEMuBsy36aB6ufcFmwnC3MEM5VhUia3YrnicG8Bxj8sMhNlVkV6CblCRaj
         yRdT38z5F+w1bzXskUjfqBLKg7Vt0O87dD4I9QU8UWcxen7BzEDofTbuSdC+4b9HRG1y
         kCVRRHSqfWJpRmDhSe5/895cdK6AhpfG9e/DKPqFAjpT3VtC+C4TPwpQKL9YnjBoWR3U
         7hyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@essential-com.20150623.gappssmtp.com header.s=20150623 header.b=X0FRObaF;
       spf=pass (google.com: domain of jb@essential.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jb@essential.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@essential-com.20150623.gappssmtp.com header.s=20150623 header.b=X0FRObaF;
       spf=pass (google.com: domain of jb@essential.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jb@essential.com
X-Google-Smtp-Source: AIpwx49XlXOg5I6Sdq4TncWL94s1U7bEkPLpJbfIWkgyKXLaBLcDDCJjHOo+NQoQr1P+wl/9rQFDOg==
Date: Mon, 9 Apr 2018 19:41:11 +0900
From: Jean-Baptiste Theou <jb@essential.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg KH
 <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Dan Rue
 <dan.rue@linaro.org>, Mark Brown <mark.brown@linaro.org>, Marc Zyngier
 <marc.zyngier@arm.com>, Greg Hackmann <ghackmann@google.com>
Subject: Re: Linux 4.9.93
Message-ID: <20180409194111.16f69253@jbtheou>
In-Reply-To: <20180409100741.pwkflhaslx43slro@lakrids.cambridge.arm.com>
References: <20180409180534.1768583293d0abe207168c5a@essential.com>
	<20180409093028.GA3398@kroah.com>
	<CAKv+Gu9Ny=EatuqrVOEFbOt+h0rH5uqxxDyHFT-PLH72ZzvZiw@mail.gmail.com>
	<20180409185751.247a0ac7@jbtheou>
	<20180409100741.pwkflhaslx43slro@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597258846269332204?=
X-GMAIL-MSGID: =?utf-8?q?1597264865122942731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 9 Apr 2018 11:07:41 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Apr 09, 2018 at 06:57:51PM +0900, Jean-Baptiste Theou wrote:
> > On Mon, 9 Apr 2018 11:49:37 +0200
> > Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >   
> > > On 9 April 2018 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:  
> > > > On Mon, Apr 09, 2018 at 06:05:34PM +0900, Jean-Baptiste Theou wrote:    
> > > >> Hi,
> > > >>
> > > >> After this patchset, a kernel built with CFI fails. Disabling
> > > >> UNMAP_KERNEL_AT_EL0 fix the issue obviously.    
> > > 
> > > How does one 'build a kernel with CFI' for arm64?  
> > 
> > From Google work on Android-4.9
> > 
> > https://android.googlesource.com/kernel/common/+/00a195e7c0752ff5d65c9caadfbcc226270ca232
> > 
> > I am not sure what is the plan on their side to upstream (Greg?), but definitely
> > useful to isolate actual issues.
> >   
> > > > Is this a "clean" 4.9.93 tree or a "4.9.93 merged into
> > > > android-common-4.9?  
> > 
> > It's a "clean 4.9.93" + whatever is needed for Clang/CFI support
> > 
> > My take is that CFI doesn't like 
> > 
> >  * void __kpti_install_ng_mappings(int cpu, int num_cpus, phys_addr_t swapper)
> > 
> > and 
> > 
> > remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> > 
> > Maybe just flag this function to not use CFI? I remember that Sami Tolvanen did
> > similar changes.  
> 
> From a quick scan, it looks like CFI uses shadow memory for function
> prologues. Since we're taking the PA of a function pointer, presumably
> this no longer maps to valid shadow.
> 
> I'd expect the same to apply to uses of cpu_replace_ttbr1(), but it
> looks like the only user of that is marked as __init, and that patch
> adds __nocfi to __init functions.
> 
> So you probably need to mark kpti_install_ng_mappings() as __nocfi.
>  
> > I know it's a bit out of context since CFI support for ARM64 is not upstream yet,
> > but unfortunate that an stable patchset trigger such failures.  
> 
> This is simply the nature of out-of-tree code.
> 
> In future, it would be very helpful if you could provide context for
> out-of-tree patches in the initial report.
> 

I can pass the initial CFI failures by tagging the function with __nocfi, but still face issues down the road.
That said, it's out of tree, so my problem.

Will investigate.

Thanks a lot for the quick support.

Best regards

> Thanks,
> Mark.
