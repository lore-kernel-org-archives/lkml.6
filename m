Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeCUSTC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:19:02 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39531 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbeCUSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:18:59 -0400
X-Google-Smtp-Source: AG47ELvjBjyg7TTPAhzNlrEAa0N836bQiVI3w4dxGVedFlpzRfM39ZgKLVJIVZeCmSfnPL0zFW1Q1g==
Date: Wed, 21 Mar 2018 11:18:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?utf-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 4.4 29/63] watchdog: hpwdt: fix unused variable warning
Message-ID: <20180321181856.GA7890@roeck-us.net>
References: <20180316152259.964532775@linuxfoundation.org>
 <20180316152303.262268098@linuxfoundation.org>
 <20180316225537.GA5989@anatevka.americas.hpqcorp.net>
 <20180318101416.GD13276@kroah.com>
 <1521587979.23626.117.camel@codethink.co.uk>
 <CAD9gYJLVS2UVUgqsaJynNjeUcg9oDxhPX26narY6eXW_2kwPAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD9gYJLVS2UVUgqsaJynNjeUcg9oDxhPX26narY6eXW_2kwPAA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 12:11:10PM +0100, 王金浦 wrote:
> 2018-03-21 0:19 GMT+01:00 Ben Hutchings <ben.hutchings@codethink.co.uk>:
> > On Sun, 2018-03-18 at 11:14 +0100, Greg Kroah-Hartman wrote:
> >> On Fri, Mar 16, 2018 at 04:55:37PM -0600, Jerry Hoemann wrote:
> >> >
> >> > Greg,
> >> >
> >> > Sorry, if I'm missing something, but I see 3 patches for
> >> > hpwdt queued up for 4.4:
> >> >
> >> >     queue-4.4/watchdog-hpwdt-fix-unused-variable-warning.patch
> >> >     queue-4.4/watchdog-hpwdt-smbios-check.patch
> >> >     queue-4.4/watchdog-hpwdt-check-source-of-nmi.patch
> >> >
> >> >
> >> > Shouldn't there also be a 4.4 patch for
> >> >
> >> >     commit 2b3d89b402b085b08498e896c65267a145bed486
> >> >     watchdog: hpwdt: Remove legacy NMI sourcing.
> >> >
> >> > As there was for 4.15, 4.14, and 4.9?
> >>
> >> It does not apply to the 4.4.y kernel branch.  If you feel it should be
> >> there, please provide a working backport.
> >>
> >> > commit 2b3d89b40 is the Spectre related patch.
> >>
> >> If you look closely, not many Spectre-related patches are merged into
> >> 4.4.y as no one has taken the time to do the backporting.  I thought
> >> someone was working on this, but odds are they just moved to 4.9.y or
> >> 4.14.y as everyone really should if they care about these issues with
> >> their platforms.
> >>
> >> So if you care about Spectre, I strongly recommend using 4.14.y or
> >> newer.
> >
> > I think you have most of the Spectre stuff aside from microcode
> > supported fixes.  These are still missing on the 4.4 branch though:
> >
> > 8fa80c503b48 nospec: Move array_index_nospec() parameter checking into separate macro
> > 1d91c1d2c80c nospec: Kill array_index_nospec_mask_check()
> >
> > I think there may also be some extra uaccess functions that didn't get
> > the nospec treatment.
> >
> > I'll probably look into backporting the microcode stuff to the older
> > branches (4.4, then 3.16 and 3.2) at some point.
> >
> > Ben.
> >
> > --
> > Ben Hutchings
> > Software Developer, Codethink Ltd.
> >
> Hi, Ben,
> 
> It will be great, if you can backport spectre fixes into 4.4, I'm
> happy to test your port.
> The patch list I gathered when I did porting to 4.4:

If you completed the port to v4.4 already, can you make it available
for others ?

Thanks,
Guenter

> d3eba77440 x86/cpufeatures: Add CPUID_7_EDX CPUID leaf
> 40532f65cc x86/cpufeatures: Add Intel feature bits for Speculatio
> c26a6bea26 x86/cpufeatures: Add AMD feature bits for Speculation
>  Control
> af57d43c908 x86/msr: Add definitions for new speculation control
> a8799fd14d x86/pti: Do not enable PTI on CPUs which are not
>  vulnerable to Meltdown
> 6c5e49150a x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early
>  Spectre v2 microcodes
> 31fd9eda7f6 x86/speculation: Add basic IBPB (Indirect Branch
>  Prediction Barrier) support
> 77b3b3ee238 x86/cpufeatures: Clean up Spectre v2 related CPUID
>  flags
> 77d1424d2fb x86/retpoline: Simplify vmexit_fill_RSB()
> d7f8d17406d x86/entry/64: Remove the SYSCALL64 fast path
> 572e509178 x86/entry/64: Push extra regs right away
> e06d7bfb223 x86: Introduce __uaccess_begin_nospec() and
>  uaccess_try_nospec
> ae75f83e79 x86/usercopy: Replace open coded stac/clac with
>  __uaccess_{begin, end}
> 065eae4be83 x86/uaccess: Use __uaccess_begin_nospec() and
>  uaccess_try_nospec
> cda6b6074cc6f9 x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature
>  bits on Intel
> 4b234a253e52 x86/pti: Mark constant arrays as __initconst
> b7649e1776706 KVM: nVMX: mark vmcs12 pages dirty on L2 exit
> 46e24dfc2df KVM: nVMX: Eliminate vmcs02 pool
> ff546f9d83d3 KVM: VMX: introduce alloc_loaded_vmcs
> 6236b782eba37 KVM: VMX: make MSR bitmaps per-VCPU
> 7013129a403 KVM/x86: Add IBPB support
> 755502f810c6 KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
> e5a83419c957 KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
> fc00dde96099a1 KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL
> 
> commit id is from linux-4.9.y
> 
> Might be more due to dependency.
> 
> Thanks,
> Jack Wang
