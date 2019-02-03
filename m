Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF7CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123052177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AxLH4PR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfBCWYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 17:24:23 -0500
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:37577
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfBCWYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 17:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgcXhWXTBpRHRQys0AbpDTHi07Rte/AOCkFvdt00tzA=;
 b=AxLH4PR4D2kHLRzLNku4KkLbJiT2Ec4KEyQzmbEMmsk6hV2IN0REQDEJKJfjeVYJwu0MlTQJSegyztmWlKAmYb0uhCrWdPXvOwhXc0pswUWndaBMDZM6ODcW4tkZY9nWWw6JuZvkM6dOJpEccmnVd/PuNgvXX8qyL0zBFg12jKE=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1014.namprd21.prod.outlook.com (52.132.133.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.2; Sun, 3 Feb 2019 22:24:17 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781%9]) with mapi id 15.20.1622.000; Sun, 3 Feb 2019
 22:24:17 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH V2 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Topic: [PATCH V2 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Index: AQHUuvlWYxKG3ZQG+Ua3DlU1ia1ZAaXOoU8w
Date:   Sun, 3 Feb 2019 22:24:17 +0000
Message-ID: <DM5PR2101MB09188597928747A79A8B47A1D76C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549113287-5606-3-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1549113287-5606-3-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-03T22:24:14.6996650Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff6be1de-bd4a-423c-89bd-aafefa864133;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;6:Pzky86yuu70+VxzybeCwib8RoKYsD0yRC6kCWhu/rktY0r6Oc6dEkELl/mxFUOIUqCRRESBCTMjXXgCUIQhs8sTOq1pzOOK4Jtv3VzgydS16VHRNTWqTEZtFBPkWjOS2gsPjZnEniY5bggrOepl3WFV357PrZaQ04VSQaBMW4soIjybyC25dqrNiUvzv2PQgl8ENtlc05jjlYQN9q7MPJAumjpAGoz22ZD5AvuWp/pgGUYc5N+cXhUQ243qqbmrPOzgyBf0Ywga8SlXD8UC9Z0Gwdfg1j5Lmq6kE28xFrLx1NRWXpAyPbmZ9geKCJBEuaaAQMXc4rZM3HaNpCH6VvzrfYLZrYhRdpQTBM6kGFdpRBx2lESNJDf1RU6aAJLSe2qHUUa6Khc3ExTlwe7mPzGSYPjpnNyeHyrDkcGjIUnb5s1GDhAk2POOBb0iAt2fg8L+JuL3WEcG9TpNAPliOJg==;5:bW4hAH14W+5LuKrx9lhz7eAxvA7ECs8/3Jjs1FUeEBTcCVWDW3jIH0iDcPB4OK40a3ZdQ1+Aey4pN/QgejXc1Xhdl8sQlH+aZcixUFGmyNWxkhrsj8fBnvbmYHiNX2weO234r22At5FARk8pzZ4/LhHg2NiFUdjPjBrJr6Kq7+XHtZKruRQiNCGroE1sYjspGrepoxHf6hl92xMHqewspw==;7:BWqeQuFAfY3b/1j43jIZGHJ5PwZlZvxLL2ootiHlbCm9p27iQzhY8vS66jLDIxl3y//3iBRb65YHJlkZNjxTt/QHPlmdca75rO40s/sdMe7B1pbnkVZixH1Sj77lWiFEW/N4vHcNKVMAiasQWmkOVw==
x-ms-office365-filtering-correlation-id: 6a894dfd-2f37-4c23-3983-08d68a2655d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB1014113C74EBA7376299A1C9D76C0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(39860400002)(366004)(376002)(189003)(199004)(71190400001)(8676002)(316002)(71200400001)(53936002)(106356001)(9686003)(68736007)(4326008)(74316002)(7696005)(6246003)(446003)(66066001)(2906002)(86612001)(54906003)(2501003)(6436002)(39060400002)(8990500004)(5640700003)(1411001)(7736002)(11346002)(305945005)(186003)(256004)(6346003)(6506007)(10090500001)(33656002)(486006)(14454004)(55016002)(102836004)(25786009)(229853002)(14444005)(7416002)(26005)(1361003)(86362001)(81156014)(6916009)(2351001)(97736004)(476003)(3846002)(76176011)(6116002)(22452003)(10290500003)(99286004)(105586002)(478600001)(81166006)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pkwO3gDUCQ6v5Nbc/A9F80euEMwybtE+I7Ie61973r/8ggTKbBIvMyOC8ZjEejnH8S+aJXyB4um5FVQ2lb2e9DvgD6LbH5PGNYeCK9RGN0uhqSlD60bEqyH2w1akNzvCFl+kW9cbE7joAdpT2GW024c2xvLQ7pPaGNSKftvv8/Q47IXhjF/KfFfV4xiw2/dkQ/7XDMpdIiK6XUg+49N6ARHPzlfrtegY58o8mPRcGIW6fFRWHZM2+EZgZ2Lle5vsVus1KxaWqDmVFHmCSdrS20jHzity7091J03tvolbxiXdslF4x9EZaAkBVkX90XyOMwplfDrqeKO9Ju3Qc5E+AvyzD+e8mbm5hcx5R6bOnYeo6gMMBM8vKOSthpAMG2tcvwb2oYK6p+CAcvSsjMsqne32q84mGO2t1tIyTSfgqf4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a894dfd-2f37-4c23-3983-08d68a2655d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 22:24:17.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Saturday, Feb=
ruary 2, 2019 5:15 AM

I have a couple more comments ....

>=20
> +config HYPERV_IOMMU
> +	bool "Hyper-V IRQ Remapping Support"
> +	depends on HYPERV
> +	select IOMMU_API
> +	help
> +	    Hyper-V stub IOMMU driver provides IRQ Remapping capability
> +	    to run Linux guest with X2APIC mode on Hyper-V.
> +
> +

I'm a little concerned about the terminology here.  The comments and
commit messages for these patches all say that Hyper-V guests don't
have interrupt remapping support.  And we don't really *need* interrupt
remapping support because all the interrupts that should be nicely spread
out across all vCPUs (i.e., the MSI interrupts for PCI pass-thru devices) a=
re
handled via a hypercall in pci-hyperv.c, and not via the virtual IOAPIC.  S=
o
we have this stub IOMMU driver that doesn't actually do interrupt remapping=
.
It just prevents assigning the very small number of non-performance sensiti=
ve
IOAPIC interrupts to a CPU with an APIC ID above 255.

With that background, describing this feature as "Hyper-V IRQ Remapping
Support" seems incorrect, and similarly in the "help" description.  Finding
good terminology for this situation is hard.  But how about narrowing the
focus to x2APIC handling:

	bool "Hyper-V x2APIC IRQ Handling"
	...
	help
	   Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
	   guests to run with x2APIC mode enabled


> +static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
> +				     unsigned int virq, unsigned int nr_irqs,
> +				     void *arg)
> +{
> +	struct irq_alloc_info *info =3D arg;
> +	struct irq_data *irq_data;
> +	struct irq_desc *desc;
> +	int ret =3D 0;
> +
> +	if (!info || info->type !=3D X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
> +		return -EINVAL;
> +
> +	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		return ret;
> +
> +	irq_data =3D irq_domain_get_irq_data(domain, virq);
> +	if (!irq_data) {
> +		irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +		return -EINVAL;
> +	}
> +
> +	irq_data->chip =3D &hyperv_ir_chip;
> +
> +	/*
> +	 * IOAPIC entry pointer is saved in chip_data to allow
> +	 * hyperv_irq_remappng_activate()/hyperv_ir_set_affinity() to set
> +	 * vector and dest_apicid. cfg->vector and cfg->dest_apicid are
> +	 * ignorred when IRQ remapping is enabled. See ioapic_configure_entry()=
.
> +	 */
> +	irq_data->chip_data =3D info->ioapic_entry;
> +
> +	/*
> +	 * Hypver-V IO APIC irq affinity should be in the scope of
> +	 * ioapic_max_cpumask because no irq remapping support.
> +	 */
> +	desc =3D irq_data_to_desc(irq_data);
> +	cpumask_and(desc->irq_common_data.affinity,
> +			desc->irq_common_data.affinity,
> +			&ioapic_max_cpumask);

The intent of this cpumask_and() call is to ensure that IOAPIC interrupts
are initially assigned to a CPU with APIC ID < 256.   But do we know that
the initial value of desc->irq_common_data.affinity is such that the result
of the cpumask_and() will not be the empty set?  My impression is that
these local IOAPIC interrupts are assigned an initial affinity mask with al=
l
CPUs set, in which case this will work just fine.  But I'm not sure if that
is guaranteed.

An alternative would be to set the affinity to ioapic_max_cpumask and
overwrite whatever might have been previously specified.  But I don't know
if that's really better.

> +
> +	return 0;
> +}
