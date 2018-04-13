Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeDMGzz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 02:55:55 -0400
Received: from mail-pu1apc01on0118.outbound.protection.outlook.com ([104.47.126.118]:61076
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751083AbeDMGzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 02:55:52 -0400
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support
Thread-Topic: [PATCH] KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support
Thread-Index: AQHT0nJ5hDCIaHNNgkG2z+OtDy6uT6P+Q/OA
Date: Fri, 13 Apr 2018 06:55:44 +0000
Message-ID: <f05d0850-06ee-c5d9-4e37-bf6fe26d1fd1@microsoft.com>
References: <20180412152508.27617-1-vkuznets@redhat.com>
In-Reply-To: <20180412152508.27617-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0055;7:9nRUh7PZ2Ld33ASgSfWtJ6cJJNRtOjDuCts6FHu1jU1g5O3zGo2QVpTUKC9Tf4AiBosNTylP8zNvceoS+fiWllNhkFxOew0qwhde3NVONlzjqzMaZRmVfKO6jv2pwi+I5bOymnrd+D+pAPoJjI6E/rmTYPQnwtWmoVtdDKWAtZHjg3Jp2S/L/ifHw9O+g4V3LHA3bG0n427t2CA64bs3Oj3NSVF899iMGmVrrwV13Des0m6sm7uJtftfz7w5UE4K;20:fXjsGWPhtt60KzTnVtqQyhGWjRgSEm1hyfWtSJ0hgYTG020JfaPqiwS1NVPhWsq+DdchlhtGApeMfIJAhykMDnn3bBBniJPi59TXe6Xfe1qePL2GMJpzZvTvIywT0YZIVrMME/4rFrDLhdcSYyOwZ6WDvHgxpqceAlJ4isJem/0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:KL1P15301MB0055;
x-ms-traffictypediagnostic: KL1P15301MB0055:
x-microsoft-antispam-prvs: <KL1P15301MB00558EDA589B3003C56C0F2792B30@KL1P15301MB0055.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:KL1P15301MB0055;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0055;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(199004)(189003)(8676002)(486006)(186003)(86362001)(110136005)(2501003)(7736002)(305945005)(478600001)(476003)(2616005)(72206003)(31696002)(97736004)(10090500001)(575784001)(316002)(3846002)(22452003)(25786009)(6116002)(10290500003)(36756003)(53936002)(2900100001)(6246003)(31686004)(6486002)(53546011)(8936002)(2906002)(76176011)(6436002)(66066001)(6512007)(106356001)(229853002)(81156014)(3280700002)(68736007)(86612001)(3660700001)(105586002)(102836004)(77096007)(4326008)(14454004)(11346002)(6506007)(5660300001)(446003)(81166006)(26005)(99286004)(54906003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0055;H:KL1P15301MB0072.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <54D4E496E46B4D459D5F9CDE7AE88C73@APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d671fafd-9708-4141-87c6-08d5a10b9453
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d671fafd-9708-4141-87c6-08d5a10b9453
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 06:55:44.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0055
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3D6txxX011345

On 4/12/2018 11:25 PM, Vitaly Kuznetsov wrote:
> Enlightened MSR-Bitmap is a natural extension of Enlightened VMCS:
> Hyper-V Top Level Functional Specification states:
> 
> "The L1 hypervisor may collaborate with the L0 hypervisor to make MSR
> accesses more efficient. It can enable enlightened MSR bitmaps by setting
> the corresponding field in the enlightened VMCS to 1. When enabled, the L0
> hypervisor does not monitor the MSR bitmaps for changes. Instead, the L1
> hypervisor must invalidate the corresponding clean field after making
> changes to one of the MSR bitmaps."
> 
> I reached out to Hyper-V team for additional details and I got the
> following information
> 
> "Current Hyper-V implementation works as following.
> 
> If the enlightened MSR bitmap is not enabled:
> - All MSR accesses of L2 guests cause physical VM-Exits
> 
> If the enlightened MSR bitmap is enabled:
> - Physical VM-Exits for L2 accesses to certain MSRs (currently FS_BASE,
>    GS_BASE and KERNEL_GS_BASE) are avoided, thus making these MSR accesses
>    faster."
> 
> I tested my series with a custom kernel module doing tight rdmsrl loop,
> for KERNEL_GS_BASE the results are:
> 
> Without Enlightened MSR-Bitmap: 1300 cycles/read
> With Enlightened MSR-Bitmap: 120 cycles/read

Tested-by: Lan Tianyu <Tianyu.Lan@microsoft.com>

> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/include/asm/hyperv-tlfs.h |  9 ++++++++-
>   arch/x86/kvm/vmx.c                 | 34 +++++++++++++++++++++++++++++++++-
>   2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 1c602ad4bda8..26e7e2240066 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -300,6 +300,9 @@ struct ms_hyperv_tsc_page {
>   /* TSC emulation after migration */
>   #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
>   
> +/* Nested features (CPUID 0x4000000A) EAX */
> +#define HV_X64_NESTED_MSR_BITMAP		BIT(19)
> +
>   struct hv_reenlightenment_control {
>   	__u64 vector:8;
>   	__u64 reserved1:8;
> @@ -665,7 +668,11 @@ struct hv_enlightened_vmcs {
>   	u32 hv_clean_fields;
>   	u32 hv_padding_32;
>   	u32 hv_synthetic_controls;
> -	u32 hv_enlightenments_control;
> +	struct {
> +		u32 nested_flush_hypercall:1;
> +		u32 msr_bitmap:1;
> +		u32 reserved:30;
> +	} hv_enlightenments_control;
>   	u32 hv_vp_id;
>   
>   	u64 hv_vm_id;
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index b2f8a700aeef..c80a48cffc52 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -1014,6 +1014,7 @@ static const u32 vmx_msr_index[] = {
>   };
>   
>   DEFINE_STATIC_KEY_FALSE(enable_evmcs);
> +DEFINE_STATIC_KEY_FALSE(enable_emsr_bitmap);
>   
>   #define current_evmcs ((struct hv_enlightened_vmcs *)this_cpu_read(current_vmcs))
>   
> @@ -1090,6 +1091,15 @@ static inline u16 evmcs_read16(unsigned long field)
>   	return *(u16 *)((char *)current_evmcs + offset);
>   }
>   
> +static inline void evmcs_touch_msr_bitmap(void)
> +{
> +	if (unlikely(!current_evmcs))
> +		return;
> +
> +	current_evmcs->hv_clean_fields &=
> +		~HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP;
> +}
> +
>   static void evmcs_load(u64 phys_addr)
>   {
>   	struct hv_vp_assist_page *vp_ap =
> @@ -1174,6 +1184,7 @@ static inline u32 evmcs_read32(unsigned long field) { return 0; }
>   static inline u16 evmcs_read16(unsigned long field) { return 0; }
>   static inline void evmcs_load(u64 phys_addr) {}
>   static inline void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
> +static inline void evmcs_touch_msr_bitmap(void) {}
>   #endif /* IS_ENABLED(CONFIG_HYPERV) */
>   
>   static inline bool is_exception_n(u32 intr_info, u8 vector)
> @@ -4218,6 +4229,13 @@ static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
>   		if (!loaded_vmcs->msr_bitmap)
>   			goto out_vmcs;
>   		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
> +
> +		if (static_branch_unlikely(&enable_emsr_bitmap)) {
> +			struct hv_enlightened_vmcs *evmcs =
> +				(struct hv_enlightened_vmcs *)loaded_vmcs->vmcs;
> +
> +			evmcs->hv_enlightenments_control.msr_bitmap = 1;
> +		}
>   	}
>   	return 0;
>   
> @@ -5335,6 +5353,9 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
>   	if (!cpu_has_vmx_msr_bitmap())
>   		return;
>   
> +	if (static_branch_unlikely(&enable_emsr_bitmap))
> +		evmcs_touch_msr_bitmap();
> +
>   	/*
>   	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
>   	 * have the write-low and read-high bitmap offsets the wrong way round.
> @@ -5370,6 +5391,9 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
>   	if (!cpu_has_vmx_msr_bitmap())
>   		return;
>   
> +	if (static_branch_unlikely(&enable_emsr_bitmap))
> +		evmcs_touch_msr_bitmap();
> +
>   	/*
>   	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
>   	 * have the write-low and read-high bitmap offsets the wrong way round.
> @@ -12790,8 +12814,16 @@ static int __init vmx_init(void)
>   		}
>   
>   		if (enlightened_vmcs) {
> -			pr_info("KVM: vmx: using Hyper-V Enlightened VMCS\n");
>   			static_branch_enable(&enable_evmcs);
> +
> +			/* Nested MSR-Bitmap */
> +			if (ms_hyperv.nested_features &
> +			    HV_X64_NESTED_MSR_BITMAP)
> +				static_branch_enable(&enable_emsr_bitmap);
> +
> +			pr_info("KVM: vmx: using Hyper-V Enlightened VMCS %s\n",
> +				!static_branch_likely(&enable_emsr_bitmap) ? ""
> +				: "with MSR-Bitmap");
>   		}
>   	} else {
>   		enlightened_vmcs = false;
> 
