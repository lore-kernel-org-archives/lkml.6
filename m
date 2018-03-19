Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755343AbeCSHby (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:31:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:27246 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754511AbeCSHbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:31:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="scan'208";a="209408537"
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 11/11] KVM: x86: Disable Intel Processor Trace when
 VMXON in L1 guest
Thread-Topic: [PATCH v5 11/11] KVM: x86: Disable Intel Processor Trace when
 VMXON in L1 guest
Thread-Index: AQHTtCVPU0oo6wiRS0av5olULCWX0aPSqpoAgASTjnA=
Date: Mon, 19 Mar 2018 07:31:49 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167EFC16F@SHSMSX101.ccr.corp.intel.com>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
 <1520165241-15819-12-git-send-email-luwei.kang@intel.com>
 <a8686725-ce27-8000-dee5-5a39d3629dd8@redhat.com>
In-Reply-To: <a8686725-ce27-8000-dee5-5a39d3629dd8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTU2MzY0ZGEtYmJkNC00NjBiLWE1ZmUtNTBjOWY2YzViNGM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJrVXNTT1FTUmxaVTdWZnZjbGgyalpOQk5hSnFiWUc3aGd5RHYyS1hSTVpBQkZ0UjVQXC9uSjVqYmtYUGNXK1IxZiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2J7W1o4022218

> > +	if (pt_mode == PT_MODE_HOST_GUEST) {
> 
> This would be vmx_pt_supported(), but I think it's better to remove that function and just test pt_mode ==
> PT_MODE_HOST_GUEST everywhere (or !=).

Hi Paolo,
    There have so many vmx_pt_supported() invoked in MSRs read/write (patch 9) patch and I think it can be replaced by  pt_mode check.
    But I think this function need to be reserved in patch 5(cpuid emulation). What is your opinion?

Thanks,
Luwei Kang

> 
> Paolo
> 
> > +		vmx->pt_desc.guest.ctl = 0;
> > +		vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
> > +		pt_set_intercept_for_msr(vmx, 1);
> > +	}
> > +
