Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6f17Da+UGluhBwAAmS7hNA
	; Fri, 08 Jun 2018 14:37:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A61CE607A4; Fri,  8 Jun 2018 14:37:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2DAD1606FA;
	Fri,  8 Jun 2018 14:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DAD1606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeFHOhp convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 10:37:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:4761 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeFHOho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:37:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 07:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="235810298"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2018 07:37:43 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 07:37:43 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 07:37:42 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.87]) with mapi id 14.03.0319.002;
 Fri, 8 Jun 2018 22:37:41 +0800
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsd@redhat.com" <bsd@redhat.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v9 04/12] perf/x86/intel/pt: add new capability for
 Intel PT
Thread-Topic: [PATCH v9 04/12] perf/x86/intel/pt: add new capability for
 Intel PT
Thread-Index: AQHT8Xi9oYPMthILhkSzx/04cBEj8qRUYT6AgAAC2oCAAiTusA==
Date: Fri, 8 Jun 2018 14:37:41 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167FF0091@SHSMSX101.ccr.corp.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-5-git-send-email-luwei.kang@intel.com>
 <20180607134051.rwu5pqtz45cgq7ve@um.fi.intel.com>
 <20180607135103.GN12198@hirez.programming.kicks-ass.net>
In-Reply-To: <20180607135103.GN12198@hirez.programming.kicks-ass.net>
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

> > On Tue, May 22, 2018 at 12:52:07PM +0800, Luwei Kang wrote:
> > > CPUID(EAX=14H,ECX=0):EBX[bit 3] = 1 indicates support of output to
> > > Trace Transport subsystem.
> > > MSR IA32_RTIT_CTL.FabricEn[bit 6] is reserved if CPUID.(EAX=14H,
> > > ECX=0):ECX[bit 3] = 0.
> >
> > This should instead say:
> >
> > This adds support for "output to Trace Transport subsystem" capability
> > of Intel PT, as documented in IA SDM Chapter 36.x.y.z. It means that
> > PT can output its trace to an MMIO address range rather than system
> > memory buffer.
> 
> The $subject also needs attention.

A little don't understand. What is "$subject" mean?

Thanks,
Luwei Kang
