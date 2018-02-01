Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x224cBR3awImguRXzYDUeDRNS+6JPRIT0d8u0Cj+GcMN2eTwSOQ84Zq5WEWcO2qjzs8nsPzxD
ARC-Seal: i=1; a=rsa-sha256; t=1517494893; cv=none;
        d=google.com; s=arc-20160816;
        b=G6ji45UKhVQjZuzNfATm0S56Q+kkJ6xlvLm0yJo2dJYcfiazz5gZkkGNLxJbZ0t6lV
         ZdH/7r067s5Z9fVn1e7hiyMLRltqTjU/QaSBgHi9cdiNi1ZQFRidWWpBdlM2yR6YEjCD
         mdDIxRUO6qi4wX0o01ubUaVzlKqFhKjpQ7e3vBxEavGGaLOn2egfDhB67Ac1J3PttkHq
         X9gZ8Fb/UZeVRAckqY46q09HTHeNWL4McUAaPB/HrNAyKEYWeT4eia8jlCmDT3Zfh6JU
         jgziP/H2f5xlHzK+YoaY1KKSxG9W3wxSWeqM3Z3T22WdaW4+o7faAMDWvhQnj34qQf/5
         t/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=J57l11VPLDUhZOvWXFFVGbIEFjxpukD0H+/FWKw64/k=;
        b=BuM5m6xMs50oMMH9lWsJXuctBlQia/ea3QNb5zF+9xNDlKA3KCJhsi/FYlYDCGLPKK
         COy935PN5tk/UBFqtozbNxoSAZEms8jobt7JzCEqzjw+NxEwxdHHjIkFxOZGSMsN4ZX/
         OIdVvnVHAUu3JaLQ0IqjBoRNILpdB2wTC55iRrK5Oii58KOMisiP4nA171vtpm/lpqqv
         WQ+cNx6dYyPy0HBvIcNJQqUOWHGGZe1xtVMRI31WKJD5ayvS9uXcnxnY96QmucLqmuZn
         QhoCKjriUYXVST6YFhfv3kKNKgGmUv3E7WHmkMnf+/GAQL9NCU2VVYzeiCm16tZEj9Dn
         REsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=EG6fNM4+;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=EG6fNM4+;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 1 Feb 2018 09:19:57 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.com>
Cc: Jim Mattson <jmattson@google.com>, KarimAllah Ahmed <karahmed@amazon.de>,
        kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v5 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
Message-ID: <20180201141957.GC19621@char.us.oracle.com>
References: <1517427467-28567-1-git-send-email-karahmed@amazon.de>
 <1517427467-28567-5-git-send-email-karahmed@amazon.de>
 <CALMp9eRgc-qKS5CDTvqoUDdnAXu8xqy9ZB-rew=P9NgE5AfXWA@mail.gmail.com>
 <06cb88da-f355-41ed-380f-7daa8ddf6159@amazon.com>
 <CALMp9eS9LAJz+u3ujKZ5kLHihHMZ68LHajn3ri7sRPPEgFbHfA@mail.gmail.com>
 <a8f25ab3-0b1d-a248-9564-238e3dca3da4@amazon.com>
 <e28c13c4-4a04-8a41-2a5c-16509e1bad0e@amazon.com>
 <20180201042650.GD21751@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201042650.GD21751@char.us.oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=837
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010185
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591113692084885209?=
X-GMAIL-MSGID: =?utf-8?q?1591208724858825261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

.snip..
> > +/* Is SPEC_CTRL intercepted for the currently running vCPU? */
> > +static bool spec_ctrl_intercepted(struct kvm_vcpu *vcpu)
> > +{
> > +	unsigned long *msr_bitmap;
> > +	int f = sizeof(unsigned long);
> > +
> > +	if (!cpu_has_vmx_msr_bitmap())
> > +		return true;
> > +
> > +	msr_bitmap = is_guest_mode(vcpu) ?
> > +			to_vmx(vcpu)->nested.vmcs02.msr_bitmap :
> > +			to_vmx(vcpu)->vmcs01.msr_bitmap;
> > +
> > +	return !!test_bit(MSR_IA32_SPEC_CTRL, msr_bitmap + 0x800 / f);
> > +}
> > +
..snip..
> > @@ -3359,6 +3393,34 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  	case MSR_IA32_TSC:
> >  		kvm_write_tsc(vcpu, msr_info);
> >  		break;
> > +	case MSR_IA32_SPEC_CTRL:
> > +		if (!msr_info->host_initiated &&
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
> > +			return 1;
> > +
> > +		vmx->spec_ctrl_used = true;
> > +
> > +		/* The STIBP bit doesn't fault even if it's not advertised */
> > +		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
> > +			return 1;
> > +
> > +		vmx->spec_ctrl = data;
> > +
> > +		/*
> > +		 * When it's written (to non-zero) for the first time, pass
> > +		 * it through. This means we don't have to take the perf
> 
> .. But only if it is a nested guest (as you have && is_guest_mode).
> 
> Do you want to update the comment a bit?
> 
> > +		 * hit of saving it on vmexit for the common case of guests
> > +		 * that don't use it.
> > +		 */
> > +		if (cpu_has_vmx_msr_bitmap() && data &&
> > +		    spec_ctrl_intercepted(vcpu) &&
> > +		    is_guest_mode(vcpu))
>                     ^^^^^^^^^^^^^^^^^^ <=== here

Would it be perhaps also good to mention the complexity of how
we ought to be handling L1 and L2 guests in the commit?

We are all stressed and I am sure some of us haven't gotten much
sleep - but it can help in say three months when some unluckly new
soul is trying to understand this and gets utterly confused.

> > +			vmx_disable_intercept_for_msr(
> > +					vmx->vmcs01.msr_bitmap,
> > +					MSR_IA32_SPEC_CTRL,
> > +					MSR_TYPE_RW);
> > +		break;
> >  	case MSR_IA32_PRED_CMD:
> >  		if (!msr_info->host_initiated &&
> >  		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
