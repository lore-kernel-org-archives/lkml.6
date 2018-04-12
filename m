Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeDLR5p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:57:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:17629 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbeDLR5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:57:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="36795347"
Date: Thu, 12 Apr 2018 10:57:42 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, hpa@zytor.com,
        jmattson@google.com, mingo@redhat.com, rkrcmar@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH 06/10] KVM/nVMX: Use kvm_vcpu_map when mapping the
 virtual APIC page
Message-ID: <20180412175742.GA14534@linux.intel.com>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
 <1519235241-6500-7-git-send-email-karahmed@amazon.de>
 <bdb99bea-9e5e-951e-3016-4acd162c619e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb99bea-9e5e-951e-3016-4acd162c619e@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 04:38:39PM +0200, Paolo Bonzini wrote:
> On 21/02/2018 18:47, KarimAllah Ahmed wrote:
> > +
> > +		if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map))
> > +			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, gfn_to_gpa(map->pfn));
> 
> This should in principle be pfn_to_hpa.  However, pfn_to_hpa is unused;
> let's just remove it and do "<< PAGE_SHIFT".  Unlike gfn_to_gpa, where
> in principle the shift could be different, pfn_to_hpa is *by definition*
> a shift left by PAGE_SHIFT.

Any reason not to use PFN_PHYS instead of the handcoded shift?
 
> Paolo
