Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8aAwOv+PGltxTwAAmS7hNA
	; Fri, 08 Jun 2018 14:19:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 003CF607A4; Fri,  8 Jun 2018 14:19:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7109D601C3;
	Fri,  8 Jun 2018 14:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7109D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeFHOTP convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 10:19:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:20232 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751485AbeFHOTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:19:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 07:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="57624678"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2018 07:19:12 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 07:19:12 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 07:19:11 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.51]) with mapi id 14.03.0319.002;
 Fri, 8 Jun 2018 22:19:10 +0800
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
Subject: RE: [PATCH v9 06/12] KVM: x86: Add Intel Processor Trace
 virtualization mode
Thread-Topic: [PATCH v9 06/12] KVM: x86: Add Intel Processor Trace
 virtualization mode
Thread-Index: AQHT8XjJo6LEi6JP4kSBus/OADmacqRUXUUAgAIgrNA=
Date: Fri, 8 Jun 2018 14:19:09 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167FEFF92@SHSMSX101.ccr.corp.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-7-git-send-email-luwei.kang@intel.com>
 <20180607132638.snnnt5ecwisfgkmy@um.fi.intel.com>
In-Reply-To: <20180607132638.snnnt5ecwisfgkmy@um.fi.intel.com>
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

> > From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> > Intel PT virtualization can be work in one of 2 possible modes:
> > a. system-wide: trace both host and guest and output to host buffer;
> > b. host-guest: trace host/guest simultaneous and output to their
> >    respective buffer.
> 
> I think we discussed this before. That's not the choice that the user needs to
> make. The only choice that I see is what happens if the guest wants to use PT
> while it's already in use by the host. Otherwise, each of them gets to use PT
> as they would.
> 

Hi,
    Thanks for your reply first. If guest want to use PT that we need to expose this feature to guest and guest will save these trace packets to guest buffer. Host will can't get the trace which are made by KVM guest. This is Host_Guest mode.
On the other hand,  host may also want to trace hypervisor and KVM guest execution trace and output these trace in native. This is SYSTEM mode. PT can't be exposed to guest in this mode or KVM guest trace will be lost in native buffer.
These are two different use case and can't coexist.

Thanks,
Luwei Kang
