Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeFEQ7S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:59:18 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:62368
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751786AbeFEQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:59:16 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [RFC Patch 1/3] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Topic: [RFC Patch 1/3] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Index: AQHT++PSJN1Pnr7LskeW1RYFL4KhNqRR3L4g
Date: Tue, 5 Jun 2018 16:59:11 +0000
Message-ID: <SN6PR2101MB11204AF2E43FF4C91B326FFDDC660@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
 <20180604090749.489-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180604090749.489-2-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-05T16:59:10.3252875Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB0910;7:gHZ1sMZbsvdZYWA7ShqfZMDiZwgckAQEOUrT/Hbducz1KPcj3P+gtrNRtURBJIUxtF2m1YhSb6HhGoBWo602PCmSS0P8f6IZQH/6uWuJ2Wb3uMxAAdeUpy2QtOVqkwx5WxTBWABFOLZROvXnz4nUJ3OcY6C4CILbk7CMGaAuzjx77429U+oxnDO1uvH1WZfSNRKH0mSoGXOMdGYig0SlgWLhN0H6Yqp1+S05Xe9/z49QDOuLcPAAdn00xy4B3JPU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:SN6PR2101MB0910;
x-ms-traffictypediagnostic: SN6PR2101MB0910:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <SN6PR2101MB0910F2C91FFACF99B7BF5CB7DC660@SN6PR2101MB0910.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB0910;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0910;
x-forefront-prvs: 0694C54398
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(39380400002)(376002)(39860400002)(366004)(396003)(346002)(13464003)(189003)(199004)(6436002)(1511001)(74316002)(55016002)(99286004)(3846002)(478600001)(68736007)(8676002)(72206003)(54906003)(8990500004)(14454004)(575784001)(102836004)(105586002)(10290500003)(316002)(8936002)(5250100002)(305945005)(76176011)(59450400001)(22452003)(6116002)(106356001)(53936002)(446003)(5660300001)(25786009)(11346002)(3280700002)(33656002)(2906002)(6862004)(26005)(476003)(81156014)(6506007)(6246003)(4326008)(3660700001)(10090500001)(6636002)(486006)(81166006)(2900100001)(97736004)(7736002)(86362001)(66066001)(7416002)(229853002)(9686003)(7696005)(86612001)(49343001)(213903007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0910;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mmrS/hNQZ4kThW1N+ttNIW8keKADHZPBgf7+Z67pJjU53TjBRrgN02nxA8n0dzretEl+qmHDfK0kVWoE/eWGsygwkhOuRd5Ms1pMWjzLaXAbkRwrn1KOo9WyVl9PLIqfxEa23noJzdNs07zubA1XvnFkn760MWQqcIUGsmiJ9E9MOJ33/sdVd9fOufrSGTV2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a761f136-c8fa-4ac1-e807-08d5cb05a972
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a761f136-c8fa-4ac1-e807-08d5cb05a972
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2018 16:59:11.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0910
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55GxOXB028109

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
> Of Tianyu Lan
> Sent: Monday, June 4, 2018 2:08 AM
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org;
> pbonzini@redhat.com; rkrcmar@redhat.com; devel@linuxdriverproject.org; linux-
> kernel@vger.kernel.org; kvm@vger.kernel.org; vkuznets@redhat.com
> Subject: [RFC Patch 1/3] X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
> support
> 
> Hyper-V provides a pv hypercall HvFlushGuestPhysicalAddressSpace to flush
> nested VM address space mapping in l1 hypervisor and it's to reduce overhead
> of flushing ept tlb among vcpus. This patch is to implement it.
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
> new file mode 100644
> index 000000000000..17f7c288eccc
> --- /dev/null
> +++ b/arch/x86/hyperv/nested.c
> +#include <linux/types.h>
> +#include <asm/hyperv-tlfs.h>
> +#include <asm/mshyperv.h>
> +#include <asm/tlbflush.h>
> +
> +int hyperv_flush_guest_mapping(u64 as)
> +{
> +	struct hv_guest_mapping_flush **flush_pcpu;
> +	struct hv_guest_mapping_flush *flush;
> +	u64 status = U64_MAX;

Initializing status to U64_MAX doesn't seem necessary.

> +	unsigned long flags;
> +	int ret = -EFAULT;
> +
> +	if (!hv_hypercall_pg)
> +		goto fault;
> +
> +	local_irq_save(flags);
> +
> +	flush_pcpu = (struct hv_guest_mapping_flush **)
> +		this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	flush = *flush_pcpu;
> +
> +	if (unlikely(!flush)) {
> +		local_irq_restore(flags);
> +		goto fault;
> +	}
> +
> +	flush->address_space = as;
> +	flush->flags = 0;
> +
> +	status = hv_do_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE,
> +				 flush, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!(status & HV_HYPERCALL_RESULT_MASK))
> +		ret = 0;
> +
> +fault:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index b8c89265baf0..53bbeb08faea 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -309,6 +309,7 @@ struct ms_hyperv_tsc_page {
>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
> 
>  /* Nested features (CPUID 0x4000000A) EAX */
> +#define HV_X64_NESTED_GUSET_MAPPING_FLUSH	BIT(18)

The #define name is misspelled.  "_GUSET_" should be "_GUEST_".
And the matching usage in patch 3/3 will need to be updated as well.

Michael
