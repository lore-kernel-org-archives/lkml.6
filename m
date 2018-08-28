Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AF9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C5020878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C5020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeH1O3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:29:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:12889 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH1O3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:29:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 03:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="85116520"
Received: from jsakkine-mobl1.fi.intel.com (HELO localhost) ([10.237.66.39])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2018 03:38:29 -0700
Date:   Tue, 28 Aug 2018 13:38:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>, '@linux.intel.com
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)" 
        <kvm@vger.kernel.org>
Subject: Re: [PATCH v13 03/13] x86/cpufeatures: Add Intel-defined SGX leaf
 CPUID_12_EAX
Message-ID: <20180828103829.GB26494@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-4-jarkko.sakkinen@linux.intel.com>
 <20180828102140.GA31102@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828102140.GA31102@nazgul.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:21:40PM +0200, Borislav Petkov wrote:
> On Mon, Aug 27, 2018 at 09:53:24PM +0300, Jarkko Sakkinen wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index 7bb647f57d42..4af60a0fdb20 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -13,7 +13,7 @@
> >  /*
> >   * Defines x86 CPU feature bits
> >   */
> > -#define NCAPINTS			19	   /* N 32-bit words worth of info */
> > +#define NCAPINTS			20	   /* N 32-bit words worth of info */
> >  #define NBUGINTS			1	   /* N 32-bit bug flags */
> >  
> >  /*
> > @@ -349,6 +349,12 @@
> >  #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
> >  #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
> >  
> > +/* Intel SGX CPU features, CPUID level 0x000000012:0 (EAX), word 19 */
> > +#define X86_FEATURE_SGX1		(19*32+ 0) /* SGX1 leaf functions */
> > +#define X86_FEATURE_SGX2		(19*32+ 1) /* SGX2 leaf functions */
> > +#define X86_FEATURE_SGX_ENCLV		(19*32+ 5) /* SGX ENCLV instruction, leafs E[INC|DEC]VIRTCHILD, ESETCONTEXT */
> > +#define X86_FEATURE_SGX_ENCLS_C		(19*32+ 6) /* SGX ENCLS leafs ERDINFO, ETRACK, ELDBC and ELDUC */
> 
> No need to add a whole new ->x86_capability member for 4 bits - just add
> those bits to leaf 8 where the artificial virtualization flags are -
> there's some room there.
> 
> Thx.

Roger.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 

/Jarkko
