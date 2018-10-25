Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1E9ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C60E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C60E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeJYIgm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:36:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:11452 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbeJYIgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:36:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 17:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="102242309"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2018 17:06:30 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 17:06:30 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 17:06:29 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.102]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.84]) with mapi id 14.03.0415.000;
 Thu, 25 Oct 2018 08:06:26 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "Janakarajan.Natarajan@amd.com" <Janakarajan.Natarajan@amd.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "marcorr@google.com" <marcorr@google.com>,
        "ubizjak@gmail.com" <ubizjak@gmail.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v13 08/12] KVM: x86: Add Intel PT context switch for
 each vcpu
Thread-Topic: [PATCH v13 08/12] KVM: x86: Add Intel PT context switch for
 each vcpu
Thread-Index: AQHUa3CwucpPcxWRekKi4EsgTEAw/6Utp38AgAFsRVA=
Date:   Thu, 25 Oct 2018 00:06:25 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172BD64B9@SHSMSX101.ccr.corp.intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
 <1540368316-12998-9-git-send-email-luwei.kang@intel.com>
 <87a7n37iuf.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87a7n37iuf.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTQwZjMxNTAtODdkNC00NWNjLTkxNGMtNmZiY2YxZDNhNWFhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRmZMWXc2cXpxdHpVWnEzOVRhTHl4VlpXMkFwZkVHVmNRbnZWa2Q0MUc3cTdLR29HZXJQclpEMXRtUmg1ZnIrbyJ9
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

> > +static void pt_guest_enter(struct vcpu_vmx *vmx) {
> > +	if (pt_mode == PT_MODE_SYSTEM)
> > +		return;
> > +
> > +	/* Save host state before VM entry */
> > +	rdmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
> > +
> > +	/*
> > +	 * Set guest state of MSR_IA32_RTIT_CTL MSR (PT will be disabled
> > +	 * on VM entry when it has been disabled in guest before).
> > +	 */
> > +	vmcs_write64(GUEST_IA32_RTIT_CTL, vmx->pt_desc.guest.ctl);
> > +
> > +	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
> > +		wrmsrl(MSR_IA32_RTIT_CTL, 0);
> > +		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.addr_range);
> > +		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.addr_range);
> > +	}
> > +}
> 
> From my side this is still a NAK, because [1].
> 
> [1] https://marc.info/?l=kvm&m=153847567226248&w=2
> 

This place is save the host PT status and load the guest PT status before VM-entry when working in Host-Guest mode.

Thanks,
Luwei Kang

