Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeECMu5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:50:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:63445 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbeECMuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:50:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38382265"
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function to
 get capability of Intel PT
Thread-Topic: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function
 to get capability of Intel PT
Thread-Index: AQHT4sefaepgQr78WUqju+HNtlv5nqQdTXEAgACIG+D//47xgIAAiXYQ//98F4CAAIcTsA==
Date: Thu, 3 May 2018 12:50:48 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167F6E0B4@SHSMSX101.ccr.corp.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-6-git-send-email-luwei.kang@intel.com>
 <20180503105032.h73n5lcrwkdbahgm@um.fi.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6DDCE@SHSMSX101.ccr.corp.intel.com>
 <20180503121301.nlbm4cotbv26tc7l@um.fi.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6DFFA@SHSMSX101.ccr.corp.intel.com>
 <349c6c61-6b6a-31b8-c8c5-24aed5716929@redhat.com>
In-Reply-To: <349c6c61-6b6a-31b8-c8c5-24aed5716929@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmQ3ZjQzM2UtMDYyYi00MGVjLWIxOWItNTYzYTdiMGI3ZjdmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJQVXBCVWxSQ0VCWDFhazRIVWpOVHZnMUlyR3p3b0MrWG9LdFVEYno4SVVjMkFyMld2RzRxeGJhZWZMU2tmMmpVIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w43Cp2L9019188

> >> Can you elaborate on this, what information do we need besides
> >> MSR_IA32_VMX_MISC[14]?
> >
> > Enable Intel PT in guest depend on SECONDARY_EXEC_PT_USE_GPA, EPT,
> > MSR_IA32_VMX_MISC[14] and the capability of " PT_CAP_topa_output" on
> > hardware. PT driver will return " -ENODEV" if hardware not support
> > "PT_CAP_topa_output".
> 
> I actually don't understand why PT_CAP_topa_output matters for the purpose of enabling PT in the guest.  However you still need
> __pt_cap_get() in the CPUID checks.

Hi Paolo,
I think we should expose Intel Processor Trace to guest that can be detected and initialized. But without "PT_CAP_topa_output" Intel PT can't work in Linux.  So I add this feature as precondition. 
About why need this check in driver I think Alexander may know the reason.

Thanks,
Luwei Kang

> 
> Paolo
