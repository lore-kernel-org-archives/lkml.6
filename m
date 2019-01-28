Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD00F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfA1GSA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:18:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:56253 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfA1GR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:17:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2019 22:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,533,1539673200"; 
   d="scan'208";a="314052464"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jan 2019 22:17:59 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 27 Jan 2019 22:17:58 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.102]) with mapi id 14.03.0415.000;
 Mon, 28 Jan 2019 14:17:57 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Thread-Topic: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Thread-Index: AQHUrvgng1TGbq88YUCMNKU8aNpvOaW/s2MAgASOSYA=
Date:   Mon, 28 Jan 2019 06:17:56 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD2616@SHSMSX101.ccr.corp.intel.com>
References: <1547793240-9157-1-git-send-email-luwei.kang@intel.com>
 <20190125163329.GA41385@Konrads-MacBook-Pro.local>
In-Reply-To: <20190125163329.GA41385@Konrads-MacBook-Pro.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDViYzZlMTctZjE0Yi00YTQ5LWJiOTgtZDEzYTk4Y2QzMGMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibWtxSThNcjlENnB5dllnY2Y1ZTh3SkYwSnJPeVZRaWx4MHZcL2NEVzErbEVPYVhFVmk1ajVWZXUzK0V5bmllQmYifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Some Posted-Interrupts from passthrough devices may be lost or
> > overwritten when the vCPU is in runnable state.
> >
> > The SN (Suppress Notification) of PID (Posted Interrupt Descriptor)
> > will be set when the vCPU is preempted (vCPU in KVM_MP_STATE_RUNNABLE
> > state but not running on physical CPU). If a posted interrupt coming
> > at this time, the irq remmaping facility will set the bit of PIR
> > (Posted Interrupt Requests) but ON (Outstanding Notification).
> 
> s/but ON/and ON is set too/?

Sorry. If the interrupt remapping facility received a interrupt from device but the current SN bit is 1, the remapping facility will not set ON and not send notification event to CPU, just set the corresponding bit of PIR.

Thanks,
Luwei Kang

> > So this interrupt can't be sync to APIC virtualization register and
> > will not be handled by Guest because ON is zero.
> >
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c index
> > f6915f1..820a03b 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6048,7 +6048,7 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
> >  	bool max_irr_updated;
> >
> >  	WARN_ON(!vcpu->arch.apicv_active);
> > -	if (pi_test_on(&vmx->pi_desc)) {
> > +	if (!bitmap_empty((unsigned long *)vmx->pi_desc.pir, NR_VECTORS)) {
> >  		pi_clear_on(&vmx->pi_desc);
> >  		/*
> >  		 * IOMMU can write to PIR.ON, so the barrier matters even on UP.
