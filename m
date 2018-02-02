Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x225bT59R2sy/qc6XZeafFEyIs2IOz2xLhu6/ny4syk8UBhWWXpGBNScC51brN7WgN90acTd4
ARC-Seal: i=1; a=rsa-sha256; t=1517593810; cv=none;
        d=google.com; s=arc-20160816;
        b=l5FBjPW70HdwgWqdqqYSwVSMIA1l+W1iRNnNHyl0KBwrhM5eBuwAWMQo9ff+hb0h6M
         iojyF08p2ugPxwSSYmEP6+J2WZRG9PvCc9XBzGZw9e81uHBO1jEyxQf38wx7tA6LvJYi
         grX0BYOcI8adkAY1l9mRiI8mlw1Q6twVbiN4h2yaapN2Fu6VcKvAioG6p1kpRQjoWGtt
         gMiC8BYmshF4hpr4FiCcbRpQ7ZxivS+umDj0qbHFOqReLYCz5+pnZteuxKTjLqfnb3P3
         XyOZ2dp3JHpwvoIwAqqg2O7OzI0MV/nFGr1aAEUDNEkapTueMsQ8KC5B9F/9/EiaU1A6
         4T1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=cPxk20a4h7guAjMfgyCSItslKIEZgRwyPaeCHrsHUwk=;
        b=YhMlyJ6kFUde6MeJrQ04y8Vh4geoPSa8d3v+qOe3jA3fC/KXDpeSsIZ3lgTx+MbC6L
         pX1h+pP+Qmp/pfvV42LUHIwsDmXURuc6dd1qUsoq3jBEzgvLeJjn3azqUQ4xgAErhd0h
         IHy/KC3wMAef9VNbeB1H/2V6JJRwGKvNuRnTmuMszW8N5nnfrIRJ/CHT0xefs6nL7uPU
         65toigTuC03q4Yvb6GK+iTfC+TZZKwL+KhnVgqumtOG+K691VB72d7GDTKDGV2x9QH73
         z1RxfbgzZWyKlmPC8lGDdXbczHQx1SArJ6LYuf9S8jMPlhScRIqzBLzxN6Vp+Z5ZOJMo
         0DLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=hi/hlihH;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=hi/hlihH;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 12:49:32 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
Message-ID: <20180202174932.GR28192@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517522386-18410-3-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020216
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1591312447694912142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:59:43PM +0100, KarimAllah Ahmed wrote:
> From: Ashok Raj <ashok.raj@intel.com>
> 
> The Indirect Branch Predictor Barrier (IBPB) is an indirect branch
> control mechanism. It keeps earlier branches from influencing
> later ones.
> 
> Unlike IBRS and STIBP, IBPB does not define a new mode of operation.
> It's a command that ensures predicted branch targets aren't used after
> the barrier. Although IBRS and IBPB are enumerated by the same CPUID
> enumeration, IBPB is very different.
> 
> IBPB helps mitigate against three potential attacks:
> 
> * Mitigate guests from being attacked by other guests.
>   - This is addressed by issing IBPB when we do a guest switch.
> 
> * Mitigate attacks from guest/ring3->host/ring3.
>   These would require a IBPB during context switch in host, or after
>   VMEXIT. The host process has two ways to mitigate
>   - Either it can be compiled with retpoline
>   - If its going through context switch, and has set !dumpable then
>     there is a IBPB in that path.
>     (Tim's patch: https://patchwork.kernel.org/patch/10192871)
>   - The case where after a VMEXIT you return back to Qemu might make
>     Qemu attackable from guest when Qemu isn't compiled with retpoline.
>   There are issues reported when doing IBPB on every VMEXIT that resulted
>   in some tsc calibration woes in guest.
> 
> * Mitigate guest/ring0->host/ring0 attacks.
>   When host kernel is using retpoline it is safe against these attacks.
>   If host kernel isn't using retpoline we might need to do a IBPB flush on
>   every VMEXIT.
> 
> Even when using retpoline for indirect calls, in certain conditions 'ret'
> can use the BTB on Skylake-era CPUs. There are other mitigations
> available like RSB stuffing/clearing.
> 
> * IBPB is issued only for SVM during svm_free_vcpu().
>   VMX has a vmclear and SVM doesn't.  Follow discussion here:
>   https://lkml.org/lkml/2018/1/15/146
> 
> Please refer to the following spec for more details on the enumeration
> and control.
> 
> Refer here to get documentation about mitigations.
> 
> https://software.intel.com/en-us/side-channel-security-support
> 
> [peterz: rebase and changelog rewrite]
> [karahmed: - rebase
>            - vmx: expose PRED_CMD if guest has it in CPUID
>            - svm: only pass through IBPB if guest has it in CPUID
>            - vmx: support !cpu_has_vmx_msr_bitmap()]
>            - vmx: support nested]
> [dwmw2: Expose CPUID bit too (AMD IBPB only for now as we lack IBRS)
>         PRED_CMD is a write-only MSR]
> 
> Cc: Asit Mallick <asit.k.mallick@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/1515720739-43819-6-git-send-email-ashok.raj@intel.com
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

with some small nits.
> ---
> v6:
> - introduce msr_write_intercepted_l01
> 
> v5:
> - Use MSR_TYPE_W instead of MSR_TYPE_R for the MSR.
> - Always merge the bitmaps unconditionally.
> - Add PRED_CMD to direct_access_msrs.
> - Also check for X86_FEATURE_SPEC_CTRL for the msr reads/writes
> - rewrite the commit message (from ashok.raj@)
> ---
>  arch/x86/kvm/cpuid.c | 11 +++++++-
>  arch/x86/kvm/svm.c   | 28 ++++++++++++++++++
>  arch/x86/kvm/vmx.c   | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 116 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index c0eb337..033004d 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -365,6 +365,10 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
>  		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
>  
> +	/* cpuid 0x80000008.ebx */
> +	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
> +		F(IBPB);
> +
>  	/* cpuid 0xC0000001.edx */
>  	const u32 kvm_cpuid_C000_0001_edx_x86_features =
>  		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
> @@ -625,7 +629,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		if (!g_phys_as)
>  			g_phys_as = phys_as;
>  		entry->eax = g_phys_as | (virt_as << 8);
> -		entry->ebx = entry->edx = 0;
> +		entry->edx = 0;
> +		/* IBPB isn't necessarily present in hardware cpuid */

It is with x86/pti nowadays. I think you can remove that comment.

..snip..
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index d46a61b..263eb1f 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -592,6 +592,7 @@ struct vcpu_vmx {
>  	u64 		      msr_host_kernel_gs_base;
>  	u64 		      msr_guest_kernel_gs_base;
>  #endif
> +

Spurious..
