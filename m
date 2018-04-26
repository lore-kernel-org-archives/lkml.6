Return-Path: <Michael.H.Kelley@microsoft.com>
X-Google-Smtp-Source: AIpwx4+/PWDLi8yykSjMokdH9Vk9mA/VHfKJ5Wbl/BnV6EQlg/V8xeAc9a3r+UmCCJRi8BQuf13M
ARC-Seal: i=1; a=rsa-sha256; t=1524783273; cv=none;
        d=google.com; s=arc-20160816;
        b=weIjju7yDqhUfAGYfl0n/d0HiL5rvH5tgQil1WkU6ck3kQkLiStvByOxDimPFMJCNP
         bt1Yot6RgeSh2ROlmJPdegYbpz75efjbUQNxEWN3RPWYrSTlR5Gmz4A82pZV/JpryFB/
         CjhR+j62I6CDfdwfwEx6e/1rDqTXx2Uykz5lneGeIfL2JYMgZJ1Mu/z3O2JvoEDpwCoX
         M49PwjBZRNBr0yYa+PLSYh2lWCLyppjqlMduGZZR/brmQ1j6t+yyLv1wkga9qZ5bgH3g
         wRhoIyLGw0gep+aqrEtCYqS+zRMEY/9HwtS/wxD7mZ4AakyVjnXtY67vx5hHfIgmSuQu
         eCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:to:from:dkim-signature:arc-authentication-results;
        bh=Lx8lCbzvdNA9fHb5L63kH0izSbuezVjrlW0xoj6z+9w=;
        b=phOd6+5ACzBhNxaBgdhOLczgvjd+ZVZSZU6RaoVHQtfBpt+kdA097xHrk2baNiR3zE
         xpNzv2yDr0qR37WU2FZK593pkQVJLmhYvZS5hdelOtSrMPhJdUFaJ6IzszM+5s2hKnI/
         r0rEdIDWVf5jH3n8v84jx0f2lftV0TtHPwRPlCWH2SCFXOaYqm3FyroG+EhQQyz4eLWK
         dcFrkPhq4MVCRtLnJt+SAL57kKhUyuqbOBBekJ6qXlUrJMFsw17NuiWm4z+SQ8ndGtdY
         +6yZuIpSnxHZ2FHlqmy6iWunq5SNLb7LFqPAN6KFp/wOrx5h25xFjmntR37OrQ2VCp1j
         5ZLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LN/pizN3;
       spf=pass (google.com: domain of michael.h.kelley@microsoft.com designates 104.47.32.105 as permitted sender) smtp.mailfrom=Michael.H.Kelley@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LN/pizN3;
       spf=pass (google.com: domain of michael.h.kelley@microsoft.com designates 104.47.32.105 as permitted sender) smtp.mailfrom=Michael.H.Kelley@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, Stephen Hemminger
	<sthemmin@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Topic: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Index: AQHT3MEu5vdHmDTCukequAKOswrwiKQTnt+w
Date: Thu, 26 Apr 2018 22:54:31 +0000
Message-ID: <DM5PR2101MB1030AB156060230FB7A8BFCADC8E0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-2-kys@linuxonhyperv.com>
In-Reply-To: <20180425181250.8740-2-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-26T22:54:29.6394216Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:EJjKO6nxulKELc8tK4wcKjHphpZofxLBtVkP7nNB9AoKblDOSHAfDVfzLo/bjCY8NBAGTLzqi3L14iGgpDGSSAe+niEJpwFSHsGPJ4Fmt7xonCxLqYp+JPSrmY6FHC5B5CsOj/JCcDLqEr6s92OY/nnXbHl1uWyJl4+NCuB3ki47wWD+W4Yxj9dirtAcy5Pu9iG48VEneMiaQnxSVJLYp3fbUKr6GpAtLux3YzNz1hrcB7mqnKGh3FWbQ88W4b4y;20:shNByod/Aj5lQ0gJCnjvoQKIXgJFmZmIHhOTUM6l81rpzzLLLZk37l+5SW53N9nnWWCfMjq2xU/e7vgW2nCFVMGztBca1BvJNsG0g1x+5GAFx3yViNxZxwxHTbXnjkSEhxz00fa9RPUk1mElbmx0h4sZKPRn7HCbx56h98bKK2Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936B863940223FCA5D71E5CDC8E0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(13464003)(81166006)(72206003)(66066001)(5250100002)(81156014)(33656002)(10290500003)(14454004)(76176011)(102836004)(3660700001)(1511001)(59450400001)(26005)(9686003)(106356001)(2201001)(53936002)(11346002)(446003)(3280700002)(575784001)(486006)(476003)(478600001)(86362001)(99286004)(97736004)(53546011)(2906002)(6246003)(68736007)(25786009)(6506007)(229853002)(110136005)(105586002)(2900100001)(6436002)(3846002)(74316002)(55016002)(86612001)(10090500001)(6116002)(7416002)(2501003)(7696005)(8936002)(316002)(22452003)(8990500004)(305945005)(8676002)(5660300001)(7736002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WdT8QrG6EyfSzOwPDSTfbOmTgTpnRmzBU8LxNlyaGcHRMMVWhXOvNV/fKGXhXivK0vwB/K4r4js2U3tWEi7gMCrw0ECzljtA9jdwAJTAVSdDxo+jbWHLw1PwOFQj11jtx+xE83ch64rx2QYboYXuKgwroQTfHYV0cfHygneUO70wATgc8ZjPpEWFQnnu3r0s
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8051a582-1840-4622-a104-08d5abc8ac29
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8051a582-1840-4622-a104-08d5abc8ac29
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 22:54:31.1136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598742891291551096?=
X-GMAIL-MSGID: =?utf-8?q?1598851146162570610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> Sent: Wednesday, April 25, 2018 11:13 AM
> To: x86@kernel.org; gregkh@linuxfoundation.org; linux-kernel@vger.kernel.=
org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com; jasowang=
@redhat.com;
> tglx@linutronix.de; hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.=
com>;
> Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.c=
om
> Cc: KY Srinivasan <kys@microsoft.com>
> Subject: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
>=20
> From: "K. Y. Srinivasan" <kys@microsoft.com>
>=20
> Hyper-V supports hypercalls to implement IPI; use them.
>=20
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c          | 125 +++++++++++++++++++++++++++++++=
++++++
>  arch/x86/hyperv/hv_init.c          |  17 +++++
>  arch/x86/include/asm/hyperv-tlfs.h |   9 +++
>  arch/x86/include/asm/mshyperv.h    |   1 +
>  4 files changed, 152 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index e0a5b36208fc..7f3322ecfb01 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -30,6 +30,14 @@
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
>=20
> +struct ipi_arg_non_ex {
> +	u32 vector;
> +	u32 reserved;
> +	u64 cpu_mask;
> +};

I think we'd like to put structures like this, which are defined in the
Hyper-V Top Level Functional Spec, in hyperv-tlfs.h.  Also, the 5.0b
version of the TLFS, which is latest, shows this structure on page 100:

	u32 vector;
	u8  targetvtl;
	u8  reserved[3];
	u64 cpu_mask;

> +
> +static struct apic orig_apic;
> +
>  static u64 hv_apic_icr_read(void)
>  {
>  	u64 reg_val;
> @@ -85,8 +93,125 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
>  	wrmsr(HV_X64_MSR_EOI, val, 0);
>  }
>=20
> +/*
> + * IPI implementation on Hyper-V.
> + */
> +
> +static int __send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	int cur_cpu, vcpu;
> +	struct ipi_arg_non_ex **arg;
> +	struct ipi_arg_non_ex *ipi_arg;
> +	int ret =3D 1;
> +	unsigned long flags;
> +
> +	if (cpumask_empty(mask))
> +		return 0;
> +
> +	if (!hv_hypercall_pg)
> +		return ret;
> +
> +	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> +		return ret;
> +
> +	local_irq_save(flags);
> +	arg =3D (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	ipi_arg =3D *arg;
> +	if (unlikely(!ipi_arg))
> +		goto ipi_mask_done;
> +
> +
> +	ipi_arg->vector =3D vector;
> +	ipi_arg->reserved =3D 0;
> +	ipi_arg->cpu_mask =3D 0;
> +
> +	for_each_cpu(cur_cpu, mask) {
> +		vcpu =3D hv_cpu_number_to_vp_number(cur_cpu);
> +		if (vcpu >=3D 64)
> +			goto ipi_mask_done;
> +
> +		__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
> +	}
> +
> +	ret =3D hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
> +
> +ipi_mask_done:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
> +static int __send_ipi_one(int cpu, int vector)
> +{
> +	struct cpumask mask =3D CPU_MASK_NONE;
> +
> +	cpumask_set_cpu(cpu, &mask);
> +	return __send_ipi_mask(&mask, vector);
> +}
> +
> +static void hv_send_ipi(int cpu, int vector)
> +{
> +	if (__send_ipi_one(cpu, vector))
> +		orig_apic.send_IPI(cpu, vector);
> +}
> +
> +static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	if (__send_ipi_mask(mask, vector))
> +		orig_apic.send_IPI_mask(mask, vector);
> +}
> +
> +static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int =
vector)
> +{
> +	unsigned int this_cpu =3D smp_processor_id();
> +	struct cpumask new_mask;
> +	const struct cpumask *local_mask;
> +
> +	cpumask_copy(&new_mask, mask);
> +	cpumask_clear_cpu(this_cpu, &new_mask);
> +	local_mask =3D &new_mask;
> +	if (__send_ipi_mask(local_mask, vector))
> +		orig_apic.send_IPI_mask_allbutself(mask, vector);
> +}
> +
> +static void hv_send_ipi_allbutself(int vector)
> +{
> +	hv_send_ipi_mask_allbutself(cpu_online_mask, vector);
> +}
> +
> +static void hv_send_ipi_all(int vector)
> +{
> +	if (__send_ipi_mask(cpu_online_mask, vector))
> +		orig_apic.send_IPI_all(vector);
> +}
> +
> +static void hv_send_ipi_self(int vector)
> +{
> +	if (__send_ipi_one(smp_processor_id(), vector))
> +		orig_apic.send_IPI_self(vector);
> +}
> +
>  void __init hv_apic_init(void)
>  {
> +	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
> +		if (hyperv_pcpu_input_arg =3D=3D NULL)
> +			goto msr_based_access;
> +
> +		pr_info("Hyper-V: Using IPI hypercalls\n");
> +		/*
> +		 * Set the IPI entry points.
> +		 */
> +		orig_apic =3D *apic;
> +
> +		apic->send_IPI =3D hv_send_ipi;
> +		apic->send_IPI_mask =3D hv_send_ipi_mask;
> +		apic->send_IPI_mask_allbutself =3D hv_send_ipi_mask_allbutself;
> +		apic->send_IPI_allbutself =3D hv_send_ipi_allbutself;
> +		apic->send_IPI_all =3D hv_send_ipi_all;
> +		apic->send_IPI_self =3D hv_send_ipi_self;
> +	}
> +
> +msr_based_access:
>  	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
>  		pr_info("Hyper-V: Using MSR ased APIC access\n");
>  		apic_set_eoi_write(hv_apic_eoi_write);
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 71e50fc2b7ef..a895662b6b4c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -91,12 +91,19 @@ EXPORT_SYMBOL_GPL(hv_vp_index);
>  struct hv_vp_assist_page **hv_vp_assist_page;
>  EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>=20
> +void  __percpu **hyperv_pcpu_input_arg;
> +EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
> +
>  u32 hv_max_vp_index;
>=20
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	u64 msr_vp_index;
>  	struct hv_vp_assist_page **hvp =3D &hv_vp_assist_page[smp_processor_id(=
)];
> +	void **input_arg;
> +
> +	input_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	*input_arg =3D page_address(alloc_page(GFP_ATOMIC));
>=20
>  	hv_get_vp_index(msr_vp_index);
>=20
> @@ -217,6 +224,10 @@ static int hv_cpu_die(unsigned int cpu)
>  {
>  	struct hv_reenlightenment_control re_ctrl;
>  	unsigned int new_cpu;
> +	void **input_arg;
> +
> +	input_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	free_page((unsigned long)*input_arg);
>=20
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -260,6 +271,12 @@ void __init hyperv_init(void)
>  	if ((ms_hyperv.features & required_msrs) !=3D required_msrs)
>  		return;
>=20
> +	/* Allocate the per-CPU state for the hypercall input arg */
> +	hyperv_pcpu_input_arg =3D alloc_percpu(void  *);
> +
> +	if (hyperv_pcpu_input_arg =3D=3D NULL)
> +		return;
> +
>  	/* Allocate percpu VP index */
>  	hv_vp_index =3D kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index)=
,
>  				    GFP_KERNEL);
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 416cb0e0c496..646cf2ca2aaa 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -164,6 +164,11 @@
>   */
>  #define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
>=20
> +/*
> + * Recommend using cluster IPI hypercalls.
> + */
> +#define HV_X64_CLUSTER_IPI_RECOMMENDED         (1 << 10)
> +
>  /* Recommend using the newer ExProcessorMasks interface */
>  #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
>=20
> @@ -329,10 +334,14 @@ struct hv_tsc_emulation_status {
>  #define HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK	\
>  		(~((1ull << HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_SHIFT) - 1))
>=20
> +#define HV_IPI_LOW_VECTOR	0x10
> +#define HV_IPI_HIGH_VECTOR	0xff
> +
>  /* Declare the various hypercall operations. */
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
> +#define HVCALL_SEND_IPI				0x000b
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX  0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX   0x0014
>  #define HVCALL_POST_MESSAGE			0x005c
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index bcced50037c1..f6045f3611de 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -122,6 +122,7 @@ static inline void hv_disable_stimer0_percpu_irq(int =
irq) {}
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern struct clocksource *hyperv_cs;
>  extern void *hv_hypercall_pg;
> +extern void  __percpu  **hyperv_pcpu_input_arg;
>=20
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output=
)
>  {
> --
> 2.15.1
