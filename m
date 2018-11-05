Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12530C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B3C2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B3C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeKELWq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:22:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:7587 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeKELWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:22:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 18:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="277077943"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2018 18:05:31 -0800
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 4 Nov 2018 18:05:31 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 4 Nov 2018 18:05:31 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.102]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.117]) with mapi id 14.03.0415.000;
 Mon, 5 Nov 2018 10:05:29 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
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
        Chao Peng <chao.p.peng@linux.intel.com>,
        "luwei.k.kang@gmail.com" <luwei.k.kang@gmail.com>
Subject: RE: [Resend PATCH v13 08/12] KVM: x86: Add Intel PT context switch
 for each vcpu
Thread-Topic: [Resend PATCH v13 08/12] KVM: x86: Add Intel PT context switch
 for each vcpu
Thread-Index: AdR0rAQHUo9emJqwT66yVxiBuC3ogg==
Date:   Mon, 5 Nov 2018 02:05:28 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172BDF8D0@SHSMSX101.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWQ1YThmYWYtN2E4OS00NDRhLWEyMDMtZGRkY2EyMTM2NzY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVGJESXJqOGlRWDBQQ1JCb3VHR0x2cG9tcURZN2laWTF4SEw5TlU5emhFdG1TTTgrbGRjWnVRYlUrNnZRRDZTRiJ9
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

> >> If you "have to enable or disable anything" it means you have to
> >> override the default.  But the default in this patches is "no change
> >> compared to before the patches", leaving tracing of both host and
> >> guest entirely to the host, so I don't understand your remark.  What
> >> workflow is broken?
> >>
> >>> There already are controls in perf that enable/disable guest tracing.
> >>
> >> You are confusing "tracing guest from the host" and "the guest can
> >> trace itself".  This patchset is adding support for the latter, and
> >> that
> 
> I'm not confusing anything. In the terminology that you're using, the latter breaks the former. This cannot happen.
> 
> >> affects directly whether the tracing CPUID leaf can be added to the
> >> guest.  Therefore it's not perf that can decide whether to turn it
> >> on; KVM must know it when /dev/kvm is opened, which is why it is a
> >> module parameter.
> 
> There is a control in the perf event attribute that enables tracing the guest. If this control is enabled, the kvm needs to stay away from any
> PT related MSRs. Conversely, if kvm is using PT (or, as you say, "the guest is tracing itself"), the host should not be allowed to ask for tracing
> the guest at the same time.

I think what you mentioned "perf event attribute" is "struct perf_event_attr -> exclude_host/exclude_guest" parameter.
Parameter "exclude_host" can use for vPMU in pmc_reprogram_counter() to make the counter disabled before VM-exit; Parameter "exclude_guest" can use for PMU in host to make the counter not include the value in Guest;
For the implementation of vPMU, there have some counters on each logical CPU, and host and guest can using different counter at same time, Not make Guest "stay from" PMU. Is that right? I think this "perf event attribute" not fit for Intel PT.

Intel PT is different, there just have one serials of MSRs in each logical CPU. So this hardware just can be used by host OR guest. In Host-Guest mode, PT feature will be exposed to guest and guest detect this feature certainly can use it like native any way. 
"If this control is enabled, the kvm needs to stay away from any PT related MSRs."
If we pay for a ICL virtual machine support Intel PT from Cloud Vendor but can't be used. Cloud vendor say that Host (or other virtual machine) is using this feature so you can't use it. Why? 

Currently, Intel SDM support three mode of tracing (System-Wide Tracing, Host-Only Tracing and Guest-Only Tracing). below is copy from SDM:
System-Wide Tracing (35.5.2.1): When a host or VMM configures Intel PT to collect trace packets of the entire system, it can leave the relevant VMX controls clear to allow VMX-specific packets to provide information across VMX transitions. 
Host-Only Tracing (35.5.2.2): Trace packets in VMX non-root operation are not desired, the VMM can use the VM-entry MSR-load area to load IA32_RTIT_CTL (clearing TraceEn) to disable trace-packet generation in guests, and use the VM-exit MSR-load area to load IA32_RTIT_CTL to set TraceEn.
Guest-Only Tracing (35.5.2.3): A VMM can configure trace-packet generation while in VMX non-root operation for guests executing normally. 

In Host mode we need to disable PT before VM-entry (no matter if PT is support/enabled or not in guest) and Load Guest PT status if PT is supported in Guest. The Host-Guest mode in this patch set just combined the Host-Only mode and Guest-Only mode to Host-Guest mode because there don't have conflict in these two mode.

As for Host PT will be disable before VM-entry and Host can't aware this behavior. I think this is use case limitation of different working mode and please EXPECT this happened. PT MUST be disabled before VM-entry and switch to Guest PT status in Host-Guest mode (following the description in SDM). Or please use default System-Wide mode.

Thanks,
Luwei Kang
