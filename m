Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3283753-1524780953-2-16995550816216022021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524780952; b=PMse2iaudiQiXmkl6nxsp+lSGz1RjZCCLvFuVjH3JdiysZ+3XF
    7N3AIE3Aw1E5GbSXzWFGKTq8rMo5AFLeSntmKGA+uVQ14bf9N8YHAyyp9A8DFaCQ
    tTLbUX9eD9ACjNdi5ULFxDVflQ0D3P9s+fEEBEFmYUT1mbeD+B0XYc3kw+JlQDwZ
    MYqdU4L/Lm1WPa+oPUas9WT5d7PNRG31zilOfhPnePPGgcdNjVRajte2x3vIcTZh
    E1NZPqlX5+NJ8evkVDgbgAvLtgk6EqwH15KzRHU1XHpHv2Og5JnS3tjdHii4Jxnh
    DUf6iAU/d6uM0Bb7iiavQXSqHk2Rae/5ogqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524780952; bh=qAPSP
    ekJRwDQ6OgpZtkCkYGT/kT+5z+Y2NWtN/kXmvM=; b=wOIvK77WgshKosRrEEKhQ
    GIF/Zfv69BfDdPSe2uDqDx0Lwx5tMMl35n9H80NI9mCvydV8x1hTqD7V9oB2PSNR
    GVek+UAdacJzpv2+WDwFYoE8o/fC0Kvs/eZRCDJDgciDD5vWVsxx6nfjYRHp1RYC
    iSxrsHM1gJ8BuR/IPmIDTEDQ3P9uQtcl/gkYBRewsJjs2fLtUZElNAxVZCnQx09p
    tQ4RJ49qLqcT3PORBjjcYZafy6mL9fZFR4AQNjxA67SHLkt0VjqQF3/8H29qSpOn
    NAZmTsMAjE8hC3ZqRTtp2AkwZtc3b95QLPJ/NShqWlUpXGGTG9gSXSDXeHjJHR0K
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ltEmCDhm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ltEmCDhm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNbG8PmJ30LjA1HPzx2w+kBMVXq6Qxfj/VG83p2Y89d4JTt9meR9/N1VKPVzn1eeS2JS3LAFjLl3VzMI4E59P/9INvFyN1TsnVRAubUYDSKf6vGSIg8X
    +hXdsb5luX9fuuIHhV+z2QXDZ9B95O3WZefJZ1rBk+QQaE3Tfq8iNpoVA3aQJZU6RcyCClab1fZYMVk+IsArhKRLvT8cQj3pEm2Oouw1HxM5VOWhc69xwIw6
    MXsBfWjsWFpVCO9Dp6XHsA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=_TKFW_rNyuwA:10 a=ezrDjaGQ7gEA:10
    a=P6MAjPsMllQA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8
    a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=yMhMjlubAAAA:8 a=76qzbPQOxMMDvUwUHNIA:9
    a=NlPn8Gx0kXkr3Syh:21 a=p2hMQ4aTOxYX01px:21 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
Thread-Topic: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
Thread-Index: AQHT3MEtyTg14b6f+k6LXXaM8ySPxaQTm/sQ
Date: Thu, 26 Apr 2018 22:15:37 +0000
Message-ID: <DM5PR2101MB1030CCA0F5568CDED2695C58DC8E0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
In-Reply-To: <20180425181250.8740-1-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-26T22:15:35.8029946Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1030;
 7:Q6ZClaCTVOI/Y3uUQDg7HbfbpzuwzsMYw2TwnK08eFQpv1ireLFKwCwhJeyOLHCiW1o76npguHijuWGvs9Ca/46a3HcPXMjo55M8bPFc8ehdwOJ8lGQubQzhsN/eF3CgqA9hLeBIRI1ulyIoPvj9a+IQFtw6P7AR4rHenlRmcvlWNccnBK4l6M9EmtRSQurJPPNFmm9Mpd0rMU/gvsIAx4hXHI01tZlkefHcdTXV8N+UObBSQJAtJDutMJ0djNsF;
 20:aYlNcfAfgAmQGrJRbAefm9aPPgUlkigmGZzesxVkzeeL5zxW516uUZ4ORcr2okLyhohHGjn2mESFdWQXqtclMPRog6yMosrY+f9Qvy5Sc7CVsf0xM70WUoL7isvlo4IMOW4p01jYCGiEgI4fT09Ia9an2jB7qZmPmhIT+oVUGQE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030F708F363A3BD583D3E6BDC8E0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1030; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39380400002)(346002)(39860400002)(376002)(199004)(189003)(13464003)(97736004)(3280700002)(476003)(575784001)(86362001)(486006)(11346002)(446003)(3660700001)(2501003)(5250100002)(81166006)(8676002)(2906002)(110136005)(8990500004)(316002)(22452003)(106356001)(305945005)(478600001)(8936002)(14454004)(229853002)(72206003)(6436002)(81156014)(26005)(102836004)(105586002)(74316002)(2201001)(25786009)(7736002)(66066001)(9686003)(5660300001)(33656002)(59450400001)(99286004)(7416002)(1511001)(53546011)(6506007)(55016002)(53936002)(2900100001)(10290500003)(6246003)(6116002)(3846002)(10090500001)(68736007)(86612001)(76176011)(7696005)(921003)(2004002)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1030;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: OyTJKEE0oP+VGW9QLw1mY1Wp+OVQ6kj6JnQbXdvZDyCDZ9ZtkXlOFw1GMgmaKijuxJNlaayhat9o3ctCa9FMilb0FLdqMbynINGJr/sV4oitAFiwohBBaY5ZAs2FfRneGBjfxiYuIPQ7y9WVhH5rGTNxoSwHG7j4dlVSuorT3mLaJZwZhhjzUh+U8N1XKi3X
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 28d9cd14-c590-4955-103c-08d5abc33cfd
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d9cd14-c590-4955-103c-08d5abc33cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 22:15:37.1108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> Sent: Wednesday, April 25, 2018 11:13 AM
> To: x86@kernel.org; gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com;
> tglx@linutronix.de; hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>;
> Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Cc: KY Srinivasan <kys@microsoft.com>
> Subject: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
> 
> From: "K. Y. Srinivasan" <kys@microsoft.com>
> 
> Hyper-V supports MSR based APIC access; implement
> the enlightenment.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  arch/x86/hyperv/Makefile        |  2 +-
>  arch/x86/hyperv/hv_apic.c       | 98 +++++++++++++++++++++++++++++++++++++++++
>  arch/x86/hyperv/hv_init.c       |  5 ++-
>  arch/x86/include/asm/mshyperv.h |  6 ++-
>  4 files changed, 107 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/hyperv/hv_apic.c
> 
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 367a8203cfcf..00ce4df01a09 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1 +1 @@
> -obj-y		:= hv_init.o mmu.o
> +obj-y		:= hv_init.o mmu.o hv_apic.o
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> new file mode 100644
> index 000000000000..e0a5b36208fc
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V specific APIC code.
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : K. Y. Srinivasan <kys@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +#include <linux/version.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/clockchips.h>
> +#include <linux/hyperv.h>
> +#include <linux/slab.h>
> +#include <linux/cpuhotplug.h>
> +
> +static u64 hv_apic_icr_read(void)
> +{
> +	u64 reg_val;
> +
> +	rdmsrl(HV_X64_MSR_ICR, reg_val);
> +	return reg_val;
> +}
> +
> +static void hv_apic_icr_write(u32 low, u32 id)
> +{
> +	u64 reg_val;
> +
> +	reg_val = SET_APIC_DEST_FIELD(id);
> +	reg_val = reg_val << 32;
> +	reg_val |= low;
> +
> +	wrmsrl(HV_X64_MSR_ICR, reg_val);
> +}
> +
> +static u32 hv_apic_read(u32 reg)
> +{
> +	u32 reg_val, hi;
> +
> +	switch (reg) {
> +	case APIC_EOI:
> +		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
> +		return reg_val;
> +	case APIC_TASKPRI:
> +		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
> +		return reg_val;
> +
> +	default:
> +		return native_apic_mem_read(reg);
> +	}
> +}
> +
> +static void hv_apic_write(u32 reg, u32 val)
> +{
> +	switch (reg) {
> +	case APIC_EOI:
> +		wrmsr(HV_X64_MSR_EOI, val, 0);
> +		break;
> +	case APIC_TASKPRI:
> +		wrmsr(HV_X64_MSR_TPR, val, 0);
> +		break;
> +	default:
> +		native_apic_mem_write(reg, val);
> +	}
> +}
> +
> +static void hv_apic_eoi_write(u32 reg, u32 val)
> +{
> +	wrmsr(HV_X64_MSR_EOI, val, 0);
> +}
> +
> +void __init hv_apic_init(void)
> +{
> +	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
> +		pr_info("Hyper-V: Using MSR ased APIC access\n");

Typo here.  "ased" should be "based".

> +		apic_set_eoi_write(hv_apic_eoi_write);
> +		apic->read      = hv_apic_read;
> +		apic->write     = hv_apic_write;
> +		apic->icr_write = hv_apic_icr_write;
> +		apic->icr_read  = hv_apic_icr_read;
> +	}
> +}
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index cfecc2272f2d..71e50fc2b7ef 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -242,8 +242,9 @@ static int hv_cpu_die(unsigned int cpu)
>   *
>   * 1. Setup the hypercall page.
>   * 2. Register Hyper-V specific clocksource.
> + * 3. Setup Hyper-V specific APIC entry points.
>   */
> -void hyperv_init(void)
> +void __init hyperv_init(void)
>  {
>  	u64 guest_id, required_msrs;
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
> @@ -298,6 +299,8 @@ void hyperv_init(void)
> 
>  	hyper_alloc_mmu();
> 
> +	hv_apic_init();
> +
>  	/*
>  	 * Register Hyper-V specific clocksource.
>  	 */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index b90e79610cf7..bcced50037c1 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -258,7 +258,7 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
>  	return hv_vp_index[cpu_number];
>  }
> 
> -void hyperv_init(void);
> +void __init hyperv_init(void);
>  void hyperv_setup_mmu_ops(void);
>  void hyper_alloc_mmu(void);
>  void hyperv_report_panic(struct pt_regs *regs, long err);
> @@ -269,14 +269,16 @@ void hyperv_reenlightenment_intr(struct pt_regs *regs);
>  void set_hv_tscchange_cb(void (*cb)(void));
>  void clear_hv_tscchange_cb(void);
>  void hyperv_stop_tsc_emulation(void);
> +void hv_apic_init(void);
>  #else /* CONFIG_HYPERV */
> -static inline void hyperv_init(void) {}
> +static __init  inline void hyperv_init(void) {}
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline void hyperv_cleanup(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
>  static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
>  static inline void clear_hv_tscchange_cb(void) {}
>  static inline void hyperv_stop_tsc_emulation(void) {};
> +static inline void hv_apic_init(void) {}
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>  {
>  	return NULL;
> --
> 2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
