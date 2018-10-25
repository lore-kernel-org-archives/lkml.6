Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D715C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6AB2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6AB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJYOkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:40:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbeJYOko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:40:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 816D5AFD1;
        Thu, 25 Oct 2018 06:09:28 +0000 (UTC)
Subject: Re: [Xen-devel] [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE
 instructions in the helper functions
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel <xen-devel@lists.xenproject.org>
Cc:     "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-5-chang.seok.bae@intel.com>
 <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
 <0d64fe9d-0cc3-5901-0d6f-4bcb94aa9ee4@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9b0a8b86-6949-837e-8a20-a5e934ed2b63@suse.com>
Date:   Thu, 25 Oct 2018 08:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0d64fe9d-0cc3-5901-0d6f-4bcb94aa9ee4@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2018 21:41, Andrew Cooper wrote:
> On 24/10/18 20:16, Andy Lutomirski wrote:
>> On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>> The helper functions will switch on faster accesses to FSBASE and GSBASE
>>> when the FSGSBASE feature is enabled.
>>>
>>> Accessing user GSBASE needs a couple of SWAPGS operations. It is avoidable
>>> if the user GSBASE is saved at kernel entry, being updated as changes, and
>>> restored back at kernel exit. However, it seems to spend more cycles for
>>> savings and restorations. Little or no benefit was measured from
>>> experiments.
>>>
>>> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>> Cc: Any Lutomirski <luto@kernel.org>
>>> Cc: H. Peter Anvin <hpa@zytor.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> ---
>>>  arch/x86/include/asm/fsgsbase.h | 17 +++----
>>>  arch/x86/kernel/process_64.c    | 82 +++++++++++++++++++++++++++------
>>>  2 files changed, 75 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
>>> index b4d4509b786c..e500d771155f 100644
>>> --- a/arch/x86/include/asm/fsgsbase.h
>>> +++ b/arch/x86/include/asm/fsgsbase.h
>>> @@ -57,26 +57,23 @@ static __always_inline void wrgsbase(unsigned long gsbase)
>>>                         : "memory");
>>>  }
>>>
>>> +#include <asm/cpufeature.h>
>>> +
>>>  /* Helper functions for reading/writing FS/GS base */
>>>
>>>  static inline unsigned long x86_fsbase_read_cpu(void)
>>>  {
>>>         unsigned long fsbase;
>>>
>>> -       rdmsrl(MSR_FS_BASE, fsbase);
>>> +       if (static_cpu_has(X86_FEATURE_FSGSBASE))
>>> +               fsbase = rdfsbase();
>>> +       else
>>> +               rdmsrl(MSR_FS_BASE, fsbase);
>>>
>>>         return fsbase;
>>>  }
>>>
>>> -static inline unsigned long x86_gsbase_read_cpu_inactive(void)
>>> -{
>>> -       unsigned long gsbase;
>>> -
>>> -       rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
>>> -
>>> -       return gsbase;
>>> -}
>>> -
>>> +extern unsigned long x86_gsbase_read_cpu_inactive(void);
>>>  extern void x86_fsbase_write_cpu(unsigned long fsbase);
>>>  extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
>>>
>>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>>> index 31b4755369f0..fcf18046c3d6 100644
>>> --- a/arch/x86/kernel/process_64.c
>>> +++ b/arch/x86/kernel/process_64.c
>>> @@ -159,6 +159,36 @@ enum which_selector {
>>>         GS
>>>  };
>>>
>>> +/*
>>> + * Interrupts are disabled here. Out of line to be protected from kprobes.
>>> + */
>>> +static noinline __kprobes unsigned long rd_inactive_gsbase(void)
>>> +{
>>> +       unsigned long gsbase, flags;
>>> +
>>> +       local_irq_save(flags);
>>> +       native_swapgs();
>>> +       gsbase = rdgsbase();
>>> +       native_swapgs();
>>> +       local_irq_restore(flags);
>>> +
>>> +       return gsbase;
>>> +}
>> Please fold this into its only caller and make *that* noinline.
>>
>> Also, this function, and its "write" equivalent, will access the
>> *active* gsbase.  So it either needs to be fixed for Xen PV or some
>> clear comment and careful auditing needs to be added to ensure that
>> it's not used on Xen PV.  Or it needs to be renamed
>> native_x86_fsgsbase_... and add paravirt hooks, since Xen PV allows a
>> very efficient but different implementation, I think.  The latter is
>> probably the right solution.
>>
>> (Hi Xen people -- how does CR4.FSGSBASE work on Xen?  Is it always
>> set?  Never set?  Set only if the guest tries to set it?)
> 
> FML.  Seriously - whoever put this code into the hypervisor in the past
> did an atrocious job.  After some experimentation, you're going to be
> sad and I'm declaring this borderline unusable.
> 
> Looks like Xen unconditionally enabled CR4.FSGSBASE if it is available. 
> Therefore, PV guests can use the instructions, even if the bit is clear
> in vCR4.
> 
> The CPUID bits are exposed to guests by default, and Xen will emulate
> vCR4.FSGSBASE being set and cleared.
> 
> We don't however emulate swapgs (which is a cpl0 instruction).  The
> guest gets handed a #GP[0] instead.
> 
> The Linux WRMSR PVop uses the set_segment_base() hypercall in instead of
> going through the full wrmsr emulation path.
> 
> There is no equivalent get hypercall, so the only way I can see of
> getting the value is to actually read MSR_KERNEL_GS_BASE and take the
> full rdmsr emulation path.

Or shadow the value in a percpu variable.


Juergen
