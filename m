Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294302190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391600AbfBOI4H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:56:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:23364 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfBOI4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:56:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 00:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="143712436"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga002.fm.intel.com with ESMTP; 15 Feb 2019 00:56:05 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 15 Feb 2019 00:56:05 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 15 Feb 2019 00:56:05 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.207]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.102]) with mapi id 14.03.0415.000;
 Fri, 15 Feb 2019 16:56:03 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     'Andi Kleen' <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
        "jmattson@google.com" <jmattson@google.com>
Subject: RE: [PATCH v5 12/12] KVM/VMX/vPMU: support to report
 GLOBAL_STATUS_LBRS_FROZEN
Thread-Topic: [PATCH v5 12/12] KVM/VMX/vPMU: support to report
 GLOBAL_STATUS_LBRS_FROZEN
Thread-Index: AQHUxEm+n+zGVNvLLUW1jEFYo+dja6Xe9t6AgAE6N1A=
Date:   Fri, 15 Feb 2019 08:56:02 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DF71ED6@shsmsx102.ccr.corp.intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
 <1550135174-5423-13-git-send-email-wei.w.wang@intel.com>
 <20190214163147.GL16922@tassilo.jf.intel.com>
In-Reply-To: <20190214163147.GL16922@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGRhNmU0OTYtNDVmOS00OGE4LWI0YjItZTlmM2NiMjY2N2RkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidlMrbEoyem9HYWJwaFdHUm5XMFMySk9EcVNKanRCSVVxak1kclh2RWV2cW5uZjZ5UHp0WUxuQ3lRZmI2eDhsVCJ9
x-ctpclassification: CTP_NT
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

On Friday, February 15, 2019 12:32 AM, Andi Kleen wrote:
> 
> > +static void intel_pmu_get_global_status(struct kvm_pmu *pmu,
> > +					struct msr_data *msr_info)
> > +{
> > +	u64 guest_debugctl, freeze_lbr_bits =
> DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |
> > +					      DEBUGCTLMSR_LBR;
> > +
> > +	if (!pmu->global_status) {
> > +		msr_info->data = 0;
> > +		return;
> > +	}
> > +
> > +	msr_info->data = pmu->global_status;
> > +	if (pmu->version >= 4) {
> > +		guest_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
> > +		if ((guest_debugctl & freeze_lbr_bits) == freeze_lbr_bits)
> 
> It should only check for the freeze bit, the freeze bit can be set even when
> LBRs are disabled.
> 
> Also you seem to set the bit unconditionally?
> That doesn't seem right. It should only be set after an overflow.
> 
> So the PMI injection needs to set it.

OK. The freeze bits need to be cleared by IA32_PERF_GLOBAL_STATUS_RESET, which seems not supported by the perf code yet (thus guest won't clear them). Would handle_irq_v4 also need to be changed to support that?

Best,
Wei
