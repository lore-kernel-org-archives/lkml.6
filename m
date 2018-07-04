Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26074C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8D921CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8D921CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeGDR0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:26:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:54235 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752197AbeGDR0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:26:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 10:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="72262352"
Received: from saamir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.242])
  by orsmga002.jf.intel.com with ESMTP; 04 Jul 2018 10:26:31 -0700
Date:   Wed, 4 Jul 2018 20:26:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 03/13] x86/sgx: add SGX definitions to msr-index.h
Message-ID: <20180704172629.GF6724@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-4-jarkko.sakkinen@linux.intel.com>
 <alpine.DEB.2.21.1807032049270.1816@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807032049270.1816@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:51:23PM +0200, Thomas Gleixner wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> 
> x86/msr: Add ....
> 
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > ENCLS and ENCLU are usable if and only if SGX_ENABLE is set and After
> > SGX is activated the IA32_SGXLEPUBKEYHASHn MSRs are writable if
> > SGX_LC_WR is set and the feature control is locked.
> > 
> > SGX related bits in IA32_FEATURE_CONTROL cannot be set before SGX is
> > activated by the pre-boot firmware. SGX activation is triggered by
> > setting bit 0 in the MSR 0x7a. Until SGX is activated, the LE hash MSRs
> > are writable to allow pre-boot firmware to lock down the LE root key
> > with a non-Intel value.
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Co-developed-by: Haim Cohen <haim.cohen@intel.com>
> 
> Lacks SOB
> 
> > ---
> >  arch/x86/include/asm/msr-index.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index fda2114197b3..a7355fb7344f 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -479,6 +479,8 @@
> >  #define FEATURE_CONTROL_LOCKED				(1<<0)
> >  #define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
> >  #define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
> > +#define FEATURE_CONTROL_SGX_ENABLE                      (1<<18)
> 
> Tabs not spaces please. checkpatch.pl would have told you
> 
> > +#define FEATURE_CONTROL_SGX_LE_WR			(1<<17)
> 
> Thanks,
> 
> 	tglx

Thanks, will refine!

/Jarkko
