Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDE0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA79A20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA79A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJZHnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:43:35 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:38821 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeJZHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:43:35 -0400
X-IronPort-AV: E=Sophos;i="5.54,425,1534809600"; 
   d="scan'208";a="80986793"
Subject: Re: [Xen-devel] [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE
 instructions in the helper functions
To:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel <xen-devel@lists.xenproject.org>
CC:     "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
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
 <9b0a8b86-6949-837e-8a20-a5e934ed2b63@suse.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.cooper3@citrix.com; prefer-encrypt=mutual; keydata=
 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
 6+ahAA==
Message-ID: <9b8b66e4-6a47-7320-be00-c75fed725878@citrix.com>
Date:   Fri, 26 Oct 2018 00:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9b0a8b86-6949-837e-8a20-a5e934ed2b63@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2018 07:09, Juergen Gross wrote:
> On 24/10/2018 21:41, Andrew Cooper wrote:
>> On 24/10/18 20:16, Andy Lutomirski wrote:
>>> On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>>> The helper functions will switch on faster accesses to FSBASE and GSBASE
>>>> when the FSGSBASE feature is enabled.
>>>>
>>>> Accessing user GSBASE needs a couple of SWAPGS operations. It is avoidable
>>>> if the user GSBASE is saved at kernel entry, being updated as changes, and
>>>> restored back at kernel exit. However, it seems to spend more cycles for
>>>> savings and restorations. Little or no benefit was measured from
>>>> experiments.
>>>>
>>>> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
>>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>>> Cc: Any Lutomirski <luto@kernel.org>
>>>> Cc: H. Peter Anvin <hpa@zytor.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Ingo Molnar <mingo@kernel.org>
>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>> ---
>>>>  arch/x86/include/asm/fsgsbase.h | 17 +++----
>>>>  arch/x86/kernel/process_64.c    | 82 +++++++++++++++++++++++++++------
>>>>  2 files changed, 75 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
>>>> index b4d4509b786c..e500d771155f 100644
>>>> --- a/arch/x86/include/asm/fsgsbase.h
>>>> +++ b/arch/x86/include/asm/fsgsbase.h
>>>> @@ -57,26 +57,23 @@ static __always_inline void wrgsbase(unsigned long gsbase)
>>>>                         : "memory");
>>>>  }
>>>>
>>>> +#include <asm/cpufeature.h>
>>>> +
>>>>  /* Helper functions for reading/writing FS/GS base */
>>>>
>>>>  static inline unsigned long x86_fsbase_read_cpu(void)
>>>>  {
>>>>         unsigned long fsbase;
>>>>
>>>> -       rdmsrl(MSR_FS_BASE, fsbase);
>>>> +       if (static_cpu_has(X86_FEATURE_FSGSBASE))
>>>> +               fsbase = rdfsbase();
>>>> +       else
>>>> +               rdmsrl(MSR_FS_BASE, fsbase);
>>>>
>>>>         return fsbase;
>>>>  }
>>>>
>>>> -static inline unsigned long x86_gsbase_read_cpu_inactive(void)
>>>> -{
>>>> -       unsigned long gsbase;
>>>> -
>>>> -       rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
>>>> -
>>>> -       return gsbase;
>>>> -}
>>>> -
>>>> +extern unsigned long x86_gsbase_read_cpu_inactive(void);
>>>>  extern void x86_fsbase_write_cpu(unsigned long fsbase);
>>>>  extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
>>>>
>>>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>>>> index 31b4755369f0..fcf18046c3d6 100644
>>>> --- a/arch/x86/kernel/process_64.c
>>>> +++ b/arch/x86/kernel/process_64.c
>>>> @@ -159,6 +159,36 @@ enum which_selector {
>>>>         GS
>>>>  };
>>>>
>>>> +/*
>>>> + * Interrupts are disabled here. Out of line to be protected from kprobes.
>>>> + */
>>>> +static noinline __kprobes unsigned long rd_inactive_gsbase(void)
>>>> +{
>>>> +       unsigned long gsbase, flags;
>>>> +
>>>> +       local_irq_save(flags);
>>>> +       native_swapgs();
>>>> +       gsbase = rdgsbase();
>>>> +       native_swapgs();
>>>> +       local_irq_restore(flags);
>>>> +
>>>> +       return gsbase;
>>>> +}
>>> Please fold this into its only caller and make *that* noinline.
>>>
>>> Also, this function, and its "write" equivalent, will access the
>>> *active* gsbase.  So it either needs to be fixed for Xen PV or some
>>> clear comment and careful auditing needs to be added to ensure that
>>> it's not used on Xen PV.  Or it needs to be renamed
>>> native_x86_fsgsbase_... and add paravirt hooks, since Xen PV allows a
>>> very efficient but different implementation, I think.  The latter is
>>> probably the right solution.
>>>
>>> (Hi Xen people -- how does CR4.FSGSBASE work on Xen?  Is it always
>>> set?  Never set?  Set only if the guest tries to set it?)
>> FML.  Seriously - whoever put this code into the hypervisor in the past
>> did an atrocious job.  After some experimentation, you're going to be
>> sad and I'm declaring this borderline unusable.
>>
>> Looks like Xen unconditionally enabled CR4.FSGSBASE if it is available. 
>> Therefore, PV guests can use the instructions, even if the bit is clear
>> in vCR4.
>>
>> The CPUID bits are exposed to guests by default, and Xen will emulate
>> vCR4.FSGSBASE being set and cleared.
>>
>> We don't however emulate swapgs (which is a cpl0 instruction).  The
>> guest gets handed a #GP[0] instead.
>>
>> The Linux WRMSR PVop uses the set_segment_base() hypercall in instead of
>> going through the full wrmsr emulation path.
>>
>> There is no equivalent get hypercall, so the only way I can see of
>> getting the value is to actually read MSR_KERNEL_GS_BASE and take the
>> full rdmsr emulation path.
> Or shadow the value in a percpu variable.

Hmm true, so long as no paths try to use native_rd{fs,gs}base() to
bypass the PVop.

~Andrew
