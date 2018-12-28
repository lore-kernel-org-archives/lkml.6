Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800FA208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeL1H6V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:58:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:11379 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbeL1H6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:58:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 23:58:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,408,1539673200"; 
   d="scan'208";a="112576441"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2018 23:58:19 -0800
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 27 Dec 2018 23:58:19 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 27 Dec 2018 23:58:19 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.196]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.45]) with mapi id 14.03.0415.000;
 Fri, 28 Dec 2018 15:58:07 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] KVM: x86: Fix bit shifting in update_intel_pt_cfg
Thread-Topic: [PATCH][next] KVM: x86: Fix bit shifting in update_intel_pt_cfg
Thread-Index: AQHUnVtXgb861OIeZkyh/KHRAVgCWaWTys8Q
Date:   Fri, 28 Dec 2018 07:58:06 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CA5EC6@SHSMSX101.ccr.corp.intel.com>
References: <20181226204059.GA11391@embeddedor>
In-Reply-To: <20181226204059.GA11391@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjEwYWQ5YTEtNWYxOS00YzE3LThiN2ItZWFiMmNiODk4NmVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNmsyTUc2V3BlVGV6UTZzSUFjbGtLeTh3UU1CSXdMNElWdGlyS2tRMUJPN20wa2toZXdXRjNVT2dUTStSTEp2cCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com]
> Sent: Thursday, December 27, 2018 4:41 AM
> To: Kang, Luwei <luwei.kang@intel.com>; Paolo Bonzini <pbonzini@redhat.com>; Radim Krèmáø <rkrcmar@redhat.com>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H. Peter Anvin <hpa@zytor.com>;
> x86@kernel.org
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
> Subject: [PATCH][next] KVM: x86: Fix bit shifting in update_intel_pt_cfg
> 
> ctl_bitmask in pt_desc is of type u64. When an integer like 0xf is being left shifted more than 32 bits, the behavior is undefined.
> 
> Fix this by adding suffix ULL to integer 0xf.
> 
> Addresses-Coverity-ID: 1476095 ("Bad bit shift operation")
> Fixes: 6c0f0bba85a0 ("KVM: x86: Introduce a function to initialize the PT configuration")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c index cbd55e7aeae5..251c68a74bbe 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7012,7 +7012,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> 
>  	/* unmask address range configure area */
>  	for (i = 0; i < vmx->pt_desc.addr_range; i++)
> -		vmx->pt_desc.ctl_bitmask &= ~(0xf << (32 + i * 4));
> +		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
>  }

Looks good to me, thanks.

Reviewed-by: Luwei Kang <luwei.kang@intel.com>

> 
>  static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
> --
> 2.20.1

