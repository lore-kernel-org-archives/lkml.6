Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeEHCDV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:03:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:49855 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753529AbeEHCDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:03:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,376,1520924400";
   d="scan'208";a="54004172"
From: "Liu, Jingqi" <jingqi.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Thread-Topic: [PATCH] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Thread-Index: AQHT4oTLVZ7bVXQVyEOX5Fg+CwVuNaQj9i6AgAElKfA=
Date: Tue, 8 May 2018 02:03:14 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D35269A68D@SHSMSX103.ccr.corp.intel.com>
References: <1525406146-54791-1-git-send-email-jingqi.liu@intel.com>
 <a799d2b8-9d75-0969-a98f-be5d96314dbb@redhat.com>
In-Reply-To: <a799d2b8-9d75-0969-a98f-be5d96314dbb@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTQ1MTUwYTYtOGU4OS00ZmFiLWEzZWYtMTNjNjA5MmE0NzU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJvUndWTmNoVEJHRE01bjZrelFRSnk2cHEwM2dNenFtTlpMb0w3cE5oTm9wWXJNeWhIQXdcL0h2cjI0dFFLc1luQiJ9
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4823Pj2006539

Hi Paolo,
Thanks. 
Will you help to modify the Signed-off-by chain ?
Or do I need to submit the second version after modifying the Signed-off-by chain ?

Thanks,
Jingqi Liu
-----Original Message-----
From: Paolo Bonzini [mailto:pbonzini@redhat.com] 
Sent: Tuesday, May 8, 2018 12:30 AM
To: Liu, Jingqi <jingqi.liu@intel.com>; kvm@vger.kernel.org
Cc: rkrcmar@redhat.com; tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org; linux-kernel@vger.kernel.org; Wang, Wei W <wei.w.wang@intel.com>
Subject: Re: [PATCH] KVM: x86: Expose CLDEMOTE CPU feature to guest VM

On 04/05/2018 05:55, Jingqi Liu wrote:
> The CLDEMOTE instruction hints to hardware that the cache line that 
> contains the linear address should be moved("demoted") from the 
> cache(s) closest to the processor core to a level more distant from 
> the processor core. This may accelerate subsequent accesses to the 
> line by other cores in the same coherence domain, especially if the 
> line was written by the core that demotes the line.
> 
> This patch exposes the cldemote feature to the guest.
> 
> The release document ref below link:
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
> This patch has a dependency on https://lkml.org/lkml/2018/4/23/928
> 
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Thanks.  Note that the Signed-off-by chain for the patch looks strange, the submitter should be the last (because it is a chain).

In the meanwhile, Ingo, Thomas, would it be possible to get a topic branch for that patch ("[PATCH] x86/cpufeatures: Enumerate cldemote instruction")?

Thanks,

Paolo


> ---
>  arch/x86/kvm/cpuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c index 
> 82055b9..72d8c49 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -403,7 +403,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  	const u32 kvm_cpuid_7_0_ecx_x86_features =
>  		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
>  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
> -		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG);
> +		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
> +		F(CLDEMOTE);
>  
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =
> 
