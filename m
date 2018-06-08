Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sA1gOmKYGlsjLAAAmS7hNA
	; Fri, 08 Jun 2018 14:57:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 20C0F607E4; Fri,  8 Jun 2018 14:57:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6CB9B60290;
	Fri,  8 Jun 2018 14:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CB9B60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeFHO5E convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 10:57:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:39451 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeFHO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:57:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 07:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="235813907"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2018 07:57:01 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 07:57:01 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 07:57:01 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.70]) with mapi id 14.03.0319.002;
 Fri, 8 Jun 2018 22:56:59 +0800
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "bp@suse.de" <bp@suse.de>, "Liang, Kan" <kan.liang@intel.com>,
        "Janakarajan.Natarajan@amd.com" <Janakarajan.Natarajan@amd.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsd@redhat.com" <bsd@redhat.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v9 09/12] KVM: x86: Introduce a function to initialize
 the PT configuration
Thread-Topic: [PATCH v9 09/12] KVM: x86: Introduce a function to initialize
 the PT configuration
Thread-Index: AQHT8XjSLLwXysx4vEGD1TmP05zIF6RUZbMAgAIkH6A=
Date: Fri, 8 Jun 2018 14:56:58 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167FF0140@SHSMSX101.ccr.corp.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-10-git-send-email-luwei.kang@intel.com>
 <20180607135648.mkciyfrd2wgvdxze@um.fi.intel.com>
In-Reply-To: <20180607135648.mkciyfrd2wgvdxze@um.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 22, 2018 at 12:52:12PM +0800, Luwei Kang wrote:
> > Initialize the Intel PT configuration when cpuid update.
> 
> Is it the CPUID configuration? Is it the MSR configuration? Is it both?
> Kind of looks like both. Not sure what is the cpuid update, though.
> 
> > Include cpuid inforamtion, rtit_ctl bit mask and the number of address
> > ranges.
> >
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > ---
> >  arch/x86/kvm/vmx.c | 70
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c index
> > 11fb90a..952ddf4 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -10411,6 +10411,72 @@ static void
> > nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)  #undef
> > cr4_fixed1_update  }
> >
> > +static void update_intel_pt_cfg(struct kvm_vcpu *vcpu) {
> > +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > +	struct kvm_cpuid_entry2 *best = NULL;
> > +	int i;
> > +
> > +	for (i = 0; i < PT_CPUID_LEAVES; i++) {
> > +		best = kvm_find_cpuid_entry(vcpu, 0x14, i);
> > +		if (!best)
> > +			return;
> > +		vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM]
> = best->eax;
> > +		vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM]
> = best->ebx;
> > +		vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM]
> = best->ecx;
> > +		vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM]
> = best->edx;
> > +	}
> > +
> > +	/* Get the number of configurable Address Ranges for filtering */
> > +	vmx->pt_desc.addr_range = pt_cap_decode(vmx->pt_desc.caps,
> > +
> 	PT_CAP_num_address_ranges);
> > +
> > +	/* Initialize and clear the no dependency bits */
> > +	vmx->pt_desc.ctl_bitmask = ~0ULL;
> 
> This looks redundant, doesn't it?

This is a bit mask for RTIT_CTL MSR and it will make & with the value of RTIT_CLT from guest.
The reserved bits will be 1 in this bit mask and the setable  bits are 0.

> 
> > +	vmx->pt_desc.ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
> > +			RTIT_CTL_USR | RTIT_CTL_TSC_EN |
> RTIT_CTL_DISRETC);
> > +
> > +	/* If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set */
> 
> This comment makes it less clear than it would have been otherwise.

What about like this?
/* If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set otherwise will inject an #GP */

> 
> > +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
> > +		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_CR3EN;
> > +
> > +	/*
> > +	 * If CPUID.(EAX=14H,ECX=0):EBX[1]=1 CYCEn, CycThresh and
> > +	 * PSBFreq can be set
> > +	 */
> > +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_psb_cyc))
> > +		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_CYCLEACC |
> > +			RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
> > +
> > +	/*
> > +	 * If CPUID.(EAX=14H,ECX=0):EBX[3]=1 MTCEn BranchEn and
> > +	 * MTCFreq can be set
> > +	 */
> > +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_mtc))
> > +		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
> > +			RTIT_CTL_BRANCH_EN | RTIT_CTL_MTC_RANGE);
> > +
> > +	/* If CPUID.(EAX=14H,ECX=0):EBX[4]=1 FUPonPTW and PTWEn can
> be set */
> > +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_ptwrite))
> > +		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
> > +						RTIT_CTL_PTW_EN);
> > +
> > +	/* If CPUID.(EAX=14H,ECX=0):EBX[5]=1 PwrEvEn can be set */
> > +	if (pt_cap_decode(vmx->pt_desc.caps,
> PT_CAP_power_event_trace))
> > +		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
> > +
> > +	/* If CPUID.(EAX=14H,ECX=0):ECX[0]=1 ToPA can be set */
> > +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_topa_output))
> > +		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;
> 
> If you want to be thorough, there's also PT_CAP_single_range_output,
> which tells us if RTIT_CTL_TOPA can be *unset*. Otherwise it's required.

Following the description in SDM, the default value of this bit (RTIT_CTL.ToPA) is 0. So I think we don't need to touch this bit when TOPA is not supported.

> 
> > +	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabircEn can be set */
> > +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_output_subsys))
> > +		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;
> 
> Are we sure we want to virtualize this and that it's safe?

It depend on the CPUID information virtualization in guest. I think it can works (e.g. we can pass through the PCI card to guest and stream the trace to a MMIO address).

> 
> > +
> > +	/* unmask address range configure area */
> > +	for (i = 0; i < vmx->pt_desc.addr_range; i++)
> > +		vmx->pt_desc.ctl_bitmask &= ~(0xf << (32 + i * 4));
> 
> So, the ctl_bitmask is all the bits that are not allowed?

Yes, you are right.

Thanks,
Luwei Kang
