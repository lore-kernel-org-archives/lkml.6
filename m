Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeECMav convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:30:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:23848 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbeECMas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:30:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38378396"
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function to
 get capability of Intel PT
Thread-Topic: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function
 to get capability of Intel PT
Thread-Index: AQHT4sefaepgQr78WUqju+HNtlv5nqQdTXEAgACIG+D//47xgIAAiXYQ
Date: Thu, 3 May 2018 12:30:44 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167F6DFFA@SHSMSX101.ccr.corp.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-6-git-send-email-luwei.kang@intel.com>
 <20180503105032.h73n5lcrwkdbahgm@um.fi.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6DDCE@SHSMSX101.ccr.corp.intel.com>
 <20180503121301.nlbm4cotbv26tc7l@um.fi.intel.com>
In-Reply-To: <20180503121301.nlbm4cotbv26tc7l@um.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTcwOTI5ZmUtODgwZC00ZjhkLWFkMzItMTAyNDJhNDNjNDdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJyUVZjdWVQcmNyeXBJZUhZY1BSTzVXSk0zdU5EN0lzMzVPeStuOWg0Nld0bTM4XC9kZ3lkWmw5b2RYRWc3TmpZcCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > New function __pt_cap_get() will be invoked in KVM to check if a
> > > > specific capability is availiable in KVM guest.
> > > > Another function pt_cap_get() can only check the hardware
> > > > capabilities but this may different with KVM guest because some
> > > > features may not be exposed to guest.
> > >
> > > Do we really need both in KVM?
> >
> > Yes, KVM need get host capability to estimate if can expose this
> > feature to guest
> 
> Can you elaborate on this, what information do we need besides MSR_IA32_VMX_MISC[14]?

Enable Intel PT in guest depend on SECONDARY_EXEC_PT_USE_GPA, EPT, MSR_IA32_VMX_MISC[14] and the capability of " PT_CAP_topa_output" on hardware. PT driver will return " -ENODEV" if hardware not support "PT_CAP_topa_output".

Thanks,
Luwei Kang

> 
> Thanks,
> --
> Alex
