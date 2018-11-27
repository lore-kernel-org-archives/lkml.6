Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B33C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987B721104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Oz9NuzhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987B721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeK0N0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:26:36 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:1259 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbeK0N0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:26:35 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfcac380000>; Tue, 27 Nov 2018 10:30:16 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 26 Nov 2018 18:30:16 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 26 Nov 2018 18:30:16 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 27 Nov
 2018 02:30:12 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 27 Nov
 2018 02:30:10 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (207.46.163.86)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 27 Nov 2018 02:30:10 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (20.177.125.224) by
 BYAPR12MB2822.namprd12.prod.outlook.com (20.177.229.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Tue, 27 Nov 2018 02:30:07 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::e84a:c18d:d054:a562]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::e84a:c18d:d054:a562%4]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 02:30:05 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timo Alho <talho@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Juha Tukkinen <jtukkinen@nvidia.com>
Subject: RE: [PATCH v2 0/5] Add Tegra194 Dual ARM SMMU driver
Thread-Topic: [PATCH v2 0/5] Add Tegra194 Dual ARM SMMU driver
Thread-Index: AQHUcXO4NDpX9axihU68vg8C4rw8xaVi5RMAgAAJcSA=
Date:   Tue, 27 Nov 2018 02:30:05 +0000
Message-ID: <BYAPR12MB27598D08E89D93CD8C171993B3D00@BYAPR12MB2759.namprd12.prod.outlook.com>
References: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
 <20181126235856.vnseoe5lucfryc5p@localhost>
In-Reply-To: <20181126235856.vnseoe5lucfryc5p@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2018-11-27T02:30:04.0841189Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic;
 Sensitivity=Unrestricted
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2822;6:GPRi5Fls1UlG1DH+kEOR0MIrteUvnQe3shCEyXJKECf06D+5R9f318LueoyNtphemak50wGzPt5nDDcf0ymx89i6KmnVWUGstOwbI8ZcSazaHTVIkUDr0AeyEqU4zE0rnzRPHN/Y57UfxvfpZpnM6ERFGR6Nr9vADAXe/2A7GAiXmqWiwHToxcVphNXFAGjNMRPJT/2vqr+0dsSjfj0os5vs8bi5p1n/ppdVoAdqMR6dDpm7tIsEUYXn2VVmHUvZJZMhQu0tdRakIE4nMLW7AHb2XTLHjivzATz88NgN8+OiDVQC5BbAcaHY6vMeMWJSGlyAebg8/8tO+/lUFnf38X3i7ZE5m3ppOCw64UlH5dFDc+CdKkBaw93THgQJIsBZmdnwJoQ1ylSLH/+9Xrw0ecl4ujJ9mhUmj8XfVtnkVt/2cx98lOxNih/1wtqRnvzGUz4u2RwNVbv8DpYh1o41kg==;5:xKnJlVlfH2IHssCYsU5JwO5+CC1onIm71swJ4FaB3f7n3T46u7Fk9iUkuNx06wwrRa2qSNwjf6KekABOmS+tQN7qRZVg2dmSkf5e+sPlK2c5vH40YrEjvui8JsXKpfqF56CGqdYYGTpaveERkYn6QDBA1ETHQIz0DlgvoPbb7VU=;7:sMcUpa8MetGrI07PNgUvETbiT502n5QRTax7x3RX4mY6UzXyY/UXcVaBQrOxluHhwEKfvayfQfkCSAfQTU9Ixsshk50bJpZfj3owMIF8m489gV1uj2vnHdemXVlaKUE/MYEjSx3Jjyjvkn6Nxzmc1w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(51914003)(26005)(6506007)(316002)(561944003)(33656002)(14454004)(186003)(102836004)(54906003)(97736004)(478600001)(105586002)(106356001)(966005)(2906002)(99286004)(4326008)(76176011)(7696005)(107886003)(6116002)(6436002)(55016002)(3846002)(9686003)(6306002)(86362001)(256004)(6246003)(14444005)(229853002)(66066001)(7736002)(74316002)(11346002)(5660300001)(25786009)(446003)(217873002)(68736007)(81156014)(6916009)(476003)(81166006)(486006)(305945005)(8936002)(71190400001)(71200400001)(8676002)(53936002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2822;H:BYAPR12MB2759.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ab40dd14-54c6-43f3-b360-08d654103ddf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2822;
x-ms-traffictypediagnostic: BYAPR12MB2822:
x-microsoft-antispam-prvs: <BYAPR12MB282216391BA90E20BC202ADCB3D00@BYAPR12MB2822.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR12MB2822;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2822;
x-forefront-prvs: 086943A159
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YxkWU4pRX8sRM3FUc9eTYUKgNZBKjV9lKORR96/EZYvlzveTMM/B4HtTZpOwfRvxe0s9o9qHgyMLShFSokc2z142A0PF/dDArCWVqe+MhsahWQnx7OhMhda86tOnUkC/hUwyFNYurzBHBeUSAf6a+RW4hHnhBQdDcAODSlL5Uuk8xdEXgK1EMN40wIe7RNrtorWeOMRMpnxxE6oRFEHxncp1QIOs9S8PxPjy3LXI71UNINuVFg2vyQwPVUWtzAnoVq52E53kjEpQ637dzEZdlZ65nNSYqx/QPzlMdnp7wpnYnr8o/m15GhqwavxfcfV4dIEJocwRDrJXdrkoKR5mZXQxSBePLLWpl/RF0ftIO20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab40dd14-54c6-43f3-b360-08d654103ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 02:30:05.1909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2822
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543285816; bh=fv3JxZPgt2w5gSrMuOA9JUxDnraWTwqa87Sj5fKXcsY=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-exchange-senderadcheck:x-exchange-antispam-report-cfa-test:
         x-forefront-prvs:received-spf:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Oz9NuzhM7axbfiPa4Pmg5XcKeAsyU8ihHkuPU+FBqqCIgg/aVeuM8T8OPYeevzJ4i
         ullt/aPzMAnYaL55GBb9ZnVIWx2wZxoBJDuS2n4JOvgKMENzDcKn8ZYurCJL34MXUh
         GvLhMhkpC31sCp5aSpa8rw//lpT0QQOpN9V24KV1oYBakQ/hsrw5Yfwz+3MrihecTj
         G5LWCFWETLkz//twkUn4uKZ27jQ2j6Ng2xb68fi1gMDyUDd0nO9RjQeRxpzIhhXS+j
         KLowtcpA0LJTK/L1eLvSxsd+2x7Ap9AreHyRFBZ+vXJReH6VuozlRfqlcsy++ZqRwe
         iONc1zXBq3ZDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,
Thanks for the comments!

>>Based on what I can see, it seems that you're trying to describe two
pieces of hardware with only one device in the DT. That seems like an
odd choice.=20

T194 SOC HW is designed to use Two ARM SMMU's together like one SMMU.
The IOVA accesses from the HW controllers clients is interleaved across the=
se Two
SMMU's by Memory controller HW.
Even though,  there are two ARM SMMU's,  HW design requires SW programming
these two ARM SMMU instances identically.

>>Also, it seems like all three SMMUs share the same interrupt
line? That's somewhat suboptimal IMHO, but harder to change.

This is by HW design.  SMMU interrupts are only expected if there is an ill=
egal IOVA
access, which shouldn't happen in practical. The SMMU interrupts are only u=
sed
to log the faults and for debug purpose on T194.


>>Why not instantiate both of them and create a reference between then
such that the TLB and sync ops are done on both of them in the native
driver? I.e. two arm_smmu structs and a pointer between then (i.e. add a
"next shared smmu" pointer in the struct arm_smmu).

DMA framework supports only one SMMU driver instance per device.
SMMU driver setup iommu_ops pointer in the device struct during the boot wh=
en
the platform device is added to the bus.
There is no support to allow a platform device register with two different =
SMMU
devices.
Two different  SMMU instances is 2x page table memory and 2x map/unmap over=
head.
With SMMU driver knowing about two smmu instances, page table memory usage,=
 map/unmap
Overhead would be efficient.

>>As long as devices only references one of them, locking only that one sho=
uld
provide suitable protection as well.

Earlier proposal on creating one Master SMMU node and slave SMMU nodes with=
in isn't liked.=20
Will has proposed creating a library and reusing the code. I have made the =
patches
to share the code.
https://www.spinics.net/lists/linux-tegra/msg35539.html
https://www.spinics.net/lists/linux-tegra/msg35494.html


>>Seems like a simpler approach than adding a new layer to the driver, but =
maybe
>>I am missing some complexity here?

Programming both SMMU instances identically with existing ARM SMMU driver i=
s not
possible with multiple DT nodes.=20
In the following patch, by writel* macro override, both ARM SMMU instances =
are
programmed identically in  Tegra194 SMMU driver transparently. Only tlb syn=
c and
interrupt handling need to know about specific instance.

https://lkml.org/lkml/2018/11/1/573
+#define writel_relaxed writel_relaxed_all
+#define writeq_relaxed writeq_relaxed_all
+#define writel writel_all

-KR
