Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JiPCBvOcGlt2RgAAmS7hNA
	; Fri, 08 Jun 2018 15:12:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 08F71607DC; Fri,  8 Jun 2018 15:12:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 672DC60590;
	Fri,  8 Jun 2018 15:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 672DC60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFHPMs convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 11:12:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:64709 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeFHPMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:12:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 08:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="55218462"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2018 08:12:39 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 08:12:39 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 08:12:39 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.70]) with mapi id 14.03.0319.002;
 Fri, 8 Jun 2018 23:12:37 +0800
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
Subject: RE: [PATCH v9 10/12] KVM: x86: Implement Intel Processor Trace MSRs
 read/write emulation
Thread-Topic: [PATCH v9 10/12] KVM: x86: Implement Intel Processor Trace
 MSRs read/write emulation
Thread-Index: AQHT8Xjuc+0JlWHb50GknN3XJGWnwKRUah6AgAIoYzA=
Date: Fri, 8 Jun 2018 15:12:36 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167FF01F6@SHSMSX101.ccr.corp.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-11-git-send-email-luwei.kang@intel.com>
 <20180607141237.ruhg44wuepkf4nhz@um.fi.intel.com>
In-Reply-To: <20180607141237.ruhg44wuepkf4nhz@um.fi.intel.com>
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

> > +	/*
> > +	 * Any MSR write that attempts to change bits marked reserved will
> > +	 * case a #GP fault.
> > +	 */
> > +	if (data & vmx->pt_desc.ctl_bitmask)
> > +		return 1;
> > +
> > +	/*
> > +	 * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
> > +	 * result in a #GP unless the same write also clears TraceEn.
> > +	 */
> > +	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
> > +		((vmx->pt_desc.guest.ctl ^ data) & ~RTIT_CTL_TRACEEN))
> > +		return 1;
> > +
> > +	/*
> > +	 * WRMSR to IA32_RTIT_CTL that sets TraceEn but clears this bit
> > +	 * and FabricEn would cause #GP, if
> > +	 * CPUID.(EAX=14H, ECX=0):ECX.SNGLRGNOUT[bit 2] = 0
> > +	 */
> > +	if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
> > +		!(data & RTIT_CTL_FABRIC_EN) &&
> > +		!pt_cap_decode(vmx->pt_desc.caps,
> PT_CAP_single_range_output))
> > +		return 1;
> 
> Ah, I see. But afaict this is still wrong: PT_CAP_single_range_output is only  about allowing !RTIT_CTL_TOPA, 

This is follow the description in SDM (35.2.7.2 IA32_RTIT_CTL MSR   -> ToPA -> Note:...)

> FABRIC_EN should be checked separately against the new capability that you added in 4/12.

Yes, it have has been handled in patch 9.
+       /* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabircEn can be set */
+       if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_output_subsys))
+               vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;

Thanks,
Luwei Kang
