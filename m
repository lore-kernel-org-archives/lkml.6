Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id smkRHBqUGlv7fAAAmS7hNA
	; Fri, 08 Jun 2018 14:35:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 60F3A607E4; Fri,  8 Jun 2018 14:35:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E1278601D2;
	Fri,  8 Jun 2018 14:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1278601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeFHOfD convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 10:35:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:35578 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeFHOe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:34:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 07:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="55793091"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2018 07:34:57 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 07:34:57 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 07:34:57 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.51]) with mapi id 14.03.0319.002;
 Fri, 8 Jun 2018 22:34:53 +0800
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
Subject: RE: [PATCH v9 04/12] perf/x86/intel/pt: add new capability for
 Intel PT
Thread-Topic: [PATCH v9 04/12] perf/x86/intel/pt: add new capability for
 Intel PT
Thread-Index: AQHT8Xi9oYPMthILhkSzx/04cBEj8qRUYT6AgAIliWA=
Date: Fri, 8 Jun 2018 14:34:53 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167FF006E@SHSMSX101.ccr.corp.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-5-git-send-email-luwei.kang@intel.com>
 <20180607134051.rwu5pqtz45cgq7ve@um.fi.intel.com>
In-Reply-To: <20180607134051.rwu5pqtz45cgq7ve@um.fi.intel.com>
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

> > CPUID(EAX=14H,ECX=0):EBX[bit 3] = 1 indicates support of output to
> > Trace Transport subsystem.
> > MSR IA32_RTIT_CTL.FabricEn[bit 6] is reserved if CPUID.(EAX=14H,
> > ECX=0):ECX[bit 3] = 0.
> 
> This should instead say:
> 
> This adds support for "output to Trace Transport subsystem" capability of
> Intel PT, as documented in IA SDM Chapter 36.x.y.z. It means that PT can
> output its trace to an MMIO address range rather than system memory
> buffer.

Yes, you are right. In KVM point of view this bit use for MSR access security check.
KVM will track MSRs access in guest, an #GP will be injected to guest if guest try to write IA32_RTIT_CTL.FabricEn[bit 6]  when "output_subsys" (CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 0) is not supported.

Thanks,
Luwei Kang

> 
> > This is use for emulate IA32_RTIT_CTL MSR read/write in KVM. KVM guest
> > write IA32_RTIT_CTL will trap to root mode and a #GP would be injected
> > to guest if set IA32_RTIT_CTL.FabricEn with CPUID.(EAX=14H,
> > ECX=0):ECX[bit 3] = 0.
> 
> I'm not sure what this means, this patch has nothing to do with KVM as far as
> I can tell.
> 
> Aside from the commit message, this is a valid patch.
> 
> Thanks,
> --
> Alex
