Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeEPPwv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:52:51 -0400
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:26144
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752160AbeEPPws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:52:48 -0400
From: KY Srinivasan <kys@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
 definitions to common header
Thread-Topic: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
 definitions to common header
Thread-Index: AQHT7SmWDbZrizy7jECQPkLAHPanXqQygJ6g
Date: Wed, 16 May 2018 15:52:45 +0000
Message-ID: <MW2PR2101MB1113225D3DBAF5A62FAA990AA0920@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180516152131.30689-1-vkuznets@redhat.com>
 <20180516152131.30689-2-vkuznets@redhat.com>
In-Reply-To: <20180516152131.30689-2-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:3d8a:7a9e:6c33:968f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0892;7:VfjbhO5jtC5Rqoay81wCr8P6onwgZeYVMzII8H3oajUiJejFj2nHGrJMoJgY3m2hSNklVLW3Sc3wkTUc6OIUhl/AA59XSUpeG1H3C30r/yizqMWFRzvhm0w2CBf2blgspc8+WfBCLEJxjwqOI3TdM3k6W0p1Dioflwp8hkMRsW3VlmjdGhlYK4zcRED9T42S9JhAFkCt6vekDrHActCLn3ehF7X6GPHwzeVJ3/7VUbo375dyc6bp+y/IXKQ78w0g;20:UyUl+KvGHesvG/sytfl5jh/Y9TgyqEbWTIkvYS9etMSjBXCT5oky+FeDL8c4Z28Wra/Vu0WUBSROy9CG987F1RaiQtsmGGFIr4uYUC0m1vlrtO8o2ZXJX4jEZfE/f4eu3N7mOKPVCFw/A5H4vlcgwoKgnqz6oNe09/yHDF41BrA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:MW2PR2101MB0892;
x-ms-traffictypediagnostic: MW2PR2101MB0892:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB089248F070FA97C2CCEE6364A0920@MW2PR2101MB0892.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699015);SRVR:MW2PR2101MB0892;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0892;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(346002)(366004)(396003)(199004)(189003)(13464003)(55016002)(10090500001)(6506007)(53546011)(99286004)(8990500004)(2501003)(53936002)(229853002)(9686003)(6436002)(5250100002)(86362001)(81156014)(575784001)(8676002)(8936002)(305945005)(86612001)(81166006)(7736002)(7696005)(6116002)(14454004)(68736007)(97736004)(2900100001)(446003)(105586002)(106356001)(22452003)(33656002)(11346002)(478600001)(10290500003)(25786009)(102836004)(4326008)(59450400001)(3280700002)(3660700001)(2906002)(76176011)(186003)(6246003)(110136005)(54906003)(476003)(316002)(486006)(46003)(5660300001)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0892;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: W3g7xL0xKkLaxiDG7cRnkw100yYOn8NhwZblKt+BSppvAqEQW2WU8azd+MMlty36X1tNoM9inznjJgqvu+cFZ/qErdxgLJXoy+fvDBUQVTFezf0UMKf0YE5mKULtZm+eft1atYnXuFB2Ig/Ii1EW3CTBDeQcX62pWISaADTUdWGUXXNj1O5YwW1HC0JW7Fl6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d45a500b-d9f7-42a8-b496-08d5bb45114e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45a500b-d9f7-42a8-b496-08d5bb45114e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 15:52:45.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0892
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GFrAfs016757



> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Wednesday, May 16, 2018 8:21 AM
> To: kvm@vger.kernel.org
> Cc: x86@kernel.org; Paolo Bonzini <pbonzini@redhat.com>; Radim Krèmáø
> <rkrcmar@redhat.com>; Roman Kagan <rkagan@virtuozzo.com>; KY
> Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
> definitions to common header
> 
> Hyper-V TLB flush hypercalls definitions will be required for KVM so move
> them hyperv-tlfs.h. Structures also need to be renamed as '_pcpu' suffix is
> irrelevant for a general-purpose definition.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/mmu.c              | 40 ++++++++++----------------------------
>  arch/x86/include/asm/hyperv-tlfs.h | 20 +++++++++++++++++++
>  2 files changed, 30 insertions(+), 30 deletions(-)

Vitaly,

We should  coordinate on this; I have patches in flight that conflict with
the changes here.

Regards,

K. Y
> 
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 56c9ebac946f..528a1f34df96 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -13,32 +13,12 @@
>  #define CREATE_TRACE_POINTS
>  #include <asm/trace/hyperv.h>
> 
> -/* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
> -struct hv_flush_pcpu {
> -	u64 address_space;
> -	u64 flags;
> -	u64 processor_mask;
> -	u64 gva_list[];
> -};
> -
> -/* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls */
> -struct hv_flush_pcpu_ex {
> -	u64 address_space;
> -	u64 flags;
> -	struct {
> -		u64 format;
> -		u64 valid_bank_mask;
> -		u64 bank_contents[];
> -	} hv_vp_set;
> -	u64 gva_list[];
> -};
> -
>  /* Each gva in gva_list encodes up to 4096 pages to flush */
>  #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
> 
> -static struct hv_flush_pcpu __percpu **pcpu_flush;
> +static struct hv_tlb_flush * __percpu *pcpu_flush;
> 
> -static struct hv_flush_pcpu_ex __percpu **pcpu_flush_ex;
> +static struct hv_tlb_flush_ex * __percpu *pcpu_flush_ex;
> 
>  /*
>   * Fills in gva_list starting from offset. Returns the number of items added.
> @@ -71,7 +51,7 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
>  }
> 
>  /* Return the number of banks in the resulting vp_set */
> -static inline int cpumask_to_vp_set(struct hv_flush_pcpu_ex *flush,
> +static inline int cpumask_to_vp_set(struct hv_tlb_flush_ex *flush,
>  				    const struct cpumask *cpus)
>  {
>  	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
> @@ -81,7 +61,7 @@ static inline int cpumask_to_vp_set(struct
> hv_flush_pcpu_ex *flush,
>  		return 0;
> 
>  	/*
> -	 * Clear all banks up to the maximum possible bank as
> hv_flush_pcpu_ex
> +	 * Clear all banks up to the maximum possible bank as
> hv_tlb_flush_ex
>  	 * structs are not cleared between calls, we risk flushing unneeded
>  	 * vCPUs otherwise.
>  	 */
> @@ -109,8 +89,8 @@ static void hyperv_flush_tlb_others(const struct
> cpumask *cpus,
>  				    const struct flush_tlb_info *info)
>  {
>  	int cpu, vcpu, gva_n, max_gvas;
> -	struct hv_flush_pcpu **flush_pcpu;
> -	struct hv_flush_pcpu *flush;
> +	struct hv_tlb_flush **flush_pcpu;
> +	struct hv_tlb_flush *flush;
>  	u64 status = U64_MAX;
>  	unsigned long flags;
> 
> @@ -196,8 +176,8 @@ static void hyperv_flush_tlb_others_ex(const struct
> cpumask *cpus,
>  				       const struct flush_tlb_info *info)
>  {
>  	int nr_bank = 0, max_gvas, gva_n;
> -	struct hv_flush_pcpu_ex **flush_pcpu;
> -	struct hv_flush_pcpu_ex *flush;
> +	struct hv_tlb_flush_ex **flush_pcpu;
> +	struct hv_tlb_flush_ex *flush;
>  	u64 status = U64_MAX;
>  	unsigned long flags;
> 
> @@ -303,7 +283,7 @@ void hyper_alloc_mmu(void)
>  		return;
> 
>  	if (!(ms_hyperv.hints &
> HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
> -		pcpu_flush = alloc_percpu(struct hv_flush_pcpu *);
> +		pcpu_flush = alloc_percpu(struct hv_tlb_flush *);
>  	else
> -		pcpu_flush_ex = alloc_percpu(struct hv_flush_pcpu_ex *);
> +		pcpu_flush_ex = alloc_percpu(struct hv_tlb_flush_ex *);
>  }
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> b/arch/x86/include/asm/hyperv-tlfs.h
> index a8897615354e..3d4ce3935a62 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -713,4 +713,24 @@ struct hv_enlightened_vmcs {
>  #define HV_STIMER_AUTOENABLE		(1ULL << 3)
>  #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) &
> 0x0F)
> 
> +/* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
> +struct hv_tlb_flush {
> +	u64 address_space;
> +	u64 flags;
> +	u64 processor_mask;
> +	u64 gva_list[];
> +};
> +
> +/* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls
> */
> +struct hv_tlb_flush_ex {
> +	u64 address_space;
> +	u64 flags;
> +	struct {
> +		u64 format;
> +		u64 valid_bank_mask;
> +		u64 bank_contents[];
> +	} hv_vp_set;
> +	u64 gva_list[];
> +};
> +
>  #endif
> --
> 2.14.3
