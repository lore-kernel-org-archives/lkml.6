Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeFDHTj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:19:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:30120 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeFDHTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:19:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,475,1520924400";
   d="scan'208";a="45055422"
From: "Liu, Jingqi" <jingqi.liu@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH RESEND] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Thread-Topic: [PATCH RESEND] KVM: x86: Expose CLDEMOTE CPU feature to guest
 VM
Thread-Index: AQHT8NR70GIu/Mhwtki8WsXXAcQNGqRPwing
Date: Mon, 4 Jun 2018 07:19:31 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D352728A00@SHSMSX103.ccr.corp.intel.com>
References: <1526979687-1262-1-git-send-email-jingqi.liu@intel.com>
In-Reply-To: <1526979687-1262-1-git-send-email-jingqi.liu@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWI3ZDVkNmItODZiNC00N2I2LTliNjUtMDhiZDViMTEwNTZjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiclV1SGc5MFloSmtYNEo0QVpiXC9cL3hNUlVpdnFRTUtuYTlFNm1OTnBPaXVyQnRCdjdybGRQNXYybkMybWFqcWVqIn0=
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

Hi Paolo,

I had changed the Signed-off-by chain.
Could you help to review?
Thanks.

On 5/22/2018 5:01 PM, Liu, Jingqi wrote:

> 
> The CLDEMOTE instruction hints to hardware that the cache line that contains
> the linear address should be moved("demoted") from the cache(s) closest to the
> processor core to a level more distant from the processor core. This may
> accelerate subsequent accesses to the line by other cores in the same coherence
> domain, especially if the line was written by the core that demotes the line.
> 
> This patch exposes the cldemote feature to the guest.
> 
> The release document ref below link:
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
> This patch has a dependency on https://lkml.org/lkml/2018/4/23/928
> 
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c index
> 82055b9..72d8c49 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -403,7 +403,8 @@ static inline int __do_cpuid_ent(struct
> kvm_cpuid_entry2 *entry, u32 function,
>  	const u32 kvm_cpuid_7_0_ecx_x86_features =
>  		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
>  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI)
> |
> -		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) |
> F(AVX512_BITALG);
> +		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) |
> F(AVX512_BITALG) |
> +		F(CLDEMOTE);
> 
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =
> --
> 1.8.3.1
