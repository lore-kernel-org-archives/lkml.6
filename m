Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81EFC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09F8208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09F8208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeGaFlP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:41:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:27069 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbeGaFlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:41:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 21:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="58452662"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2018 21:03:02 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 30 Jul 2018 21:03:01 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.242]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.221]) with mapi id 14.03.0319.002;
 Mon, 30 Jul 2018 21:03:01 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH V2] x86/speculation: Support Enhanced IBRS on future CPUs
Thread-Topic: [PATCH V2] x86/speculation: Support Enhanced IBRS on future
 CPUs
Thread-Index: AQHUKDpXeyPtJ37V00Gaz4M9pA51zKSotaGA///0qMA=
Date:   Tue, 31 Jul 2018 04:03:01 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4757790C@ORSMSX114.amr.corp.intel.com>
References: <1532978396-2197-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <alpine.DEB.2.21.1807302153570.1725@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807302153570.1725@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGYwYTY4ZTQtZTRhNS00OWQxLWIyM2YtZGU5ZDkyYjA4MWZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVXpTUSs5dEw1NzBubWI3TEt5TW8zeWtnYXRMUUVya2JlSHRsWWRoTWh0THNjRU9WM1FCTE1Qa0xHMFdZYXI2XC8ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no reason not to use indentation and quotation marks in a changelog.
> Squeezing it into square brackets does not really improve readability.
> 
>  From the specification [1]:
> 
>   "With enhanced IBRS, the predicted targets of indirect branches executed
>    cannot be controlled by software that was executed in a less privileged
>    ....
>    to entering a sleep state such as MWAIT or HLT."
> 
> Hmm?

Yes, this looks good. I have changed commit message in V3 accordingly.

> > x86_spec_ctrl_set_guest() before entering guest and
> > x86_spec_ctrl_restore_host() after leaving guest. So, the guest view
> > of SPEC_CTRL MSR is restored before entering guest and the host view
> > of SPEC_CTRL MSR is restored before entering host and hence IBRS will
> > be set after VMEXIT.
> 
> What you are trying to say here is:
> 
>  If Enhanced IBRS is selected as mitigation mechanism the IBRS bit is set  once at
> boot time and never cleared. This also has to be ensured after a  VMEXIT
> because the guest might have cleared the bit. This is already  covered by the
> existing x86_spec_ctrl_set_guest() and
>  x86_spec_ctrl_restore_host() speculation control functions.
> 
> Hmm?

Yes, that's correct. It's simple and concise. I have updated commit message as suggested.

> 
> > Intel's white paper on Retpoline [2] says that "Retpoline is known to
> > be an effective branch target injection (Spectre variant 2) mitigation
> > on Intel processors belonging to family 6 (enumerated by the CPUID
> > instruction) that do not have support for enhanced IBRS. On processors
> > that support enhanced IBRS, it should be used for mitigation instead
> > of retpoline."
> >
> > This means, Intel recommends using Enhanced IBRS over Retpoline where
> > available and it also means that retpoline provides less mitigation on
> > processors with enhanced IBRS compared to those without.
> 
> The cited part of the white paper does not say that its a broader mitigation than
> what Retpoline covers. It merely recommends to use enhanced IBRS without
> providing a reason.
> 
> But chapter 4.3 contains the real reason for using Emhanced IBRS: The
> processors which support it also support CET and CET does not work well with
> Retpoline.
> 
> Please provide facts and not interpretations.

Sorry! got it.

> If you have additional knowledge
> about a broader mitigation scope, then clearly say so:
>

Hmm.. no.. not really. I just learned it from Dave.

> > Hence, on processors that support Enhanced IBRS, this patch makes
> > Enhanced IBRS as
> 
> Please search Documentation/process/submitting-patches.rst for 'This patch' ....
> 

Yes, got it. Will refrain myself from using 'This patch' further.

>  The reason why 'Enhanced IBRS is the recommended mitigation on processors
> which support it is that these processors also support CET which provides  a
> defense against ROP attacks. Retpoline is very similar to ROP techniques  and
> might trigger false positives in the CET defense.
> 
>  Enhanced IBRS still requires IBPB for full mitigation.
> 
> See? You might have noticed that aside of restructuring and enhancing the
> information I also got rid of all 'we' instances. Using 'we' is a form of
> impersonation which IMO blurs the technicality of a changelog.

Makes sense. Will stop using 'we' further.

> 
> 
> > [1]
> > https://software.intel.com/sites/default/files/managed/c5/63/336996-Sp
> > eculative-Execution-Side-Channel-Mitigations.pdf
> > [2]
> > https://software.intel.com/sites/default/files/managed/1d/46/Retpoline
> > -A-Branch-Target-Injection-Mitigation.pdf
> 
> These links are not really useful as sooner than later they are going to be invalid.
> We recently started to put copies of such documents into the kernel.org bugzilla
> and I'm pretty sure we have at least one of them already in one of the
> speculation mess related BZs. Could you please track that down and make sure
> that both files are available there in the latest version. Then provide links to the
> BZ entry which are more likely to survive than content on a corporate website.
>

Sure! Makes sense.
I have updated Bugzilla link that has these documents and also updated commit message in V3.

> > @@ -219,6 +219,7 @@
> >  #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch
> Prediction Barrier */
> >  #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect
> Branch Predictors */
> >  #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD
> family 0x17 (Zen) */
> > +#define X86_FEATURE_IBRS_ENHANCED		( 7*32+29) /*
> "ibrs_enhanced" Use Enhanced IBRS in kernel */
> 
> That "ibrs_enhanced" part is not needed.

Just wanted to confirm with you before removing it, 
Presently, on platforms that support features like arch_capabilities, stibp, ibrs and ibpb 
/proc/cpuinfo does show them. Do you think we should really skip showing 
Enhanced IBRS capability?

> And 'Use' is also wrong. The feature
> merily reflects the availability of Enhanced IBRS and not its usage.
> 

Makes sense. Updated comment in V3.

> > +	/*
> > +	 * As we don't use IBRS in kernel, nobody should have set
> > +	 * SPEC_CTRL_IBRS until now. Shout loud if somebody did enable
> > +	 * SPEC_CTRL_IBRS before us.
> > +	 */
> 
> This comment does not make sense. What prevents the BIOS/bootloader or the
> hypervisor from setting it?
>

Makes sense. Removed it from V3.

> > +	WARN_ON_ONCE(x86_spec_ctrl_base & SPEC_CTRL_IBRS);
> > +
> > +	/* Ensure SPEC_CTRL_IBRS is set after VMEXIT from a guest */
> > +	x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
> 
> And what exactly writes the MSR?
>

While booting, x86_spec_ctrl_setup_ap() does that and after VMEXIT 
x86_spec_ctrl_restore_host().

As x86_spec_ctrl_setup_ap() does wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base), 
I thought writing here would be redundant.

Did I answer your question or did I get it wrong?

Regards,
Sai

