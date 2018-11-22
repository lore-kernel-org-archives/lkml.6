Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F020684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KPrYRujg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2F020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391829AbeKVNkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:40:16 -0500
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:57888
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729872AbeKVNkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2VbNX2HZ8e1h78WmvCJMmfuMkgylkq4dJYE2kHa+co=;
 b=KPrYRujgC1e0ksbrex1E29p3lZPpyuyv3ElUtIoRfyjZTHrmJYaODNXt+PNLot/IdzRbWtP4HK2j5lGUrPKMGsib/eHLFk8PpvCuqdKlvP0jnWYf049B9Fq0hBXDYPrsD2jwli1Lp59QhEwd7pPJPyFAoY5nfDJaqXAGeYAEAa4=
Received: from SN4PR2101MB0815.namprd21.prod.outlook.com (10.167.151.157) by
 SN4PR2101MB0814.namprd21.prod.outlook.com (10.167.151.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.2; Thu, 22 Nov 2018 03:02:55 +0000
Received: from SN4PR2101MB0815.namprd21.prod.outlook.com
 ([fe80::e5f0:373d:dc4a:c451]) by SN4PR2101MB0815.namprd21.prod.outlook.com
 ([fe80::e5f0:373d:dc4a:c451%5]) with mapi id 15.20.1382.007; Thu, 22 Nov 2018
 03:02:55 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 0/4] Hyper-V: Enable Linux guests on Hyper-V on ARM64 
Thread-Topic: [PATCH 0/4] Hyper-V: Enable Linux guests on Hyper-V on ARM64 
Thread-Index: AQHUgg5Z5cqBHZNo7EqbMwQ9zGVns6VbGy5w
Date:   Thu, 22 Nov 2018 03:02:55 +0000
Message-ID: <SN4PR2101MB08153E5BF002C1F88BC294FEA0DB0@SN4PR2101MB0815.namprd21.prod.outlook.com>
References: <20181122025051.15886-1-kys@linuxonhyperv.com>
In-Reply-To: <20181122025051.15886-1-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:e851:5dd9:1039:49f6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0814;6:RzXTOGiaP3PC45lQsjmrftV9Na1eRwT8Oj/trW79ogAlVaLEQTyXbk+sUkEIz31/8MnvFjWkOzeoTHCi7xWW8zOGWBgFo6DR8vs+40S8vn27cf4GAg7JMq5FJIbRBVnx2ArjFFNBK4dJB7pVrKm1udbyzM5HOWIAL1wf5a2HQZoFtw8TPzc3SvtlkZkflbG4amJ3dqWcQOKSUQUJAoOjyJRChTJ+5WtfODI5pnzIDsV1rxpIFKupl0zm6YTE5aeMOBrH4xgdq3QWaxWpnlUfgIVBBzQRMZzB82+5HPRKQuSB0KSjjYfayVn5AgL/W8GmtI4humK644KnBwAPjHoDwXeNTX7/V7bTiLDfjul43I27osBab466rXIi2bGwChEagF68dVJSWCcOSgEQiapna5d/4PFvqEREUdKCawziWDXrEm/UqC2KDnETdaa3Qz53d9lrjs1T7r23970u2vD7Ew==;5:wrQsQT/2xYkaWHxButw7CkYvdYVOO1tx2LQdaRPo+b6ugaQ+lXUlBntz3eLcwDC1CCiIeKFnUJYWbzFylsBTymk+IIuDXBddVFekgnILbhRo7Ydyq6BPjJvzD+0HcFBNA014maYTD1WN/tSlQ2J/IYAsEIyeL6SICHaQjO45awA=;7:BXBVEp/w5M8RrA9lFFdQOqIMHfhCzYqeVcuuUzhTisnatols2k5XmrPNxKVXOfaKz/+wT3kdJP6h53LYueC00oWP3laWg8fIatDQ7V7H3cc8x5HDIqJRWHSV0OZz93eJ1fOXuc7CeLLKu4DPU9HJJQ==
x-ms-office365-filtering-correlation-id: 6402cf5d-c642-4f44-7f9c-08d65027005c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN4PR2101MB0814;
x-ms-traffictypediagnostic: SN4PR2101MB0814:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN4PR2101MB0814D72A153B12F55673B911A0DB0@SN4PR2101MB0814.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501421)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN4PR2101MB0814;BCL:0;PCL:0;RULEID:;SRVR:SN4PR2101MB0814;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(13464003)(9686003)(305945005)(106356001)(6436002)(1511001)(6116002)(105586002)(55016002)(74316002)(5660300001)(478600001)(8936002)(81156014)(8676002)(81166006)(14444005)(4743002)(256004)(71190400001)(71200400001)(53936002)(7736002)(86362001)(6246003)(97736004)(33656002)(6506007)(53546011)(102836004)(2501003)(186003)(68736007)(2201001)(8990500004)(2906002)(76176011)(99286004)(7696005)(2900100001)(10090500001)(14454004)(229853002)(10290500003)(316002)(22452003)(11346002)(446003)(486006)(86612001)(25786009)(476003)(110136005)(46003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0814;H:SN4PR2101MB0815.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: byemJWjfn8tL9FXJXBaofKpFKOtVac72Cv8JlVCzO1/+/xySJInXhw1hxqyEUhOf7R7mJdsW6pj5qrVu2XIzfQkTGhDZOBgAoIl6Xf/SfJvDVtaSt5wrqBZuWWUcs3VmqW8c7I1Z51j4Z9ThAORlJ/xe56QO16EA7PcEs5KfvZLE956hoeGb1aClyT80gNxLov2JBhJ8ynIIn1H9sXdQ/6GK/6ggEKhhJJu+tVtNTerI/skVMPnwAPWwC8aJGoRV3SX3YGnAN03QIA9yexLb7w669LVTmRVOQh+rx8J0+IgVtUpVVrV9PLrrOlOwKVFrvVCLJd4q0HWxwKtx5IzkwiFFZw6BEHTY27KxDLRLrnE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6402cf5d-c642-4f44-7f9c-08d65027005c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 03:02:55.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> Sent: Wednesday, November 21, 2018 6:51 PM
> To: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
> Michael Kelley <mikelley@microsoft.com>; vkuznets
> <vkuznets@redhat.com>
> Cc: KY Srinivasan <kys@microsoft.com>
> Subject: [PATCH 0/4] Hyper-V: Enable Linux guests on Hyper-V on ARM64
>=20
> From: "K. Y. Srinivasan" <kys@microsoft.com>
>=20
> This series enables Linux guests running on Hyper-V on ARM64
> hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> Hyper-V, including its synthetic clocks and hypercall mechanism.
> Existing architecture independent drivers for Hyper-V's VMbus and
> synthetic devices just work when built for ARM64. Hyper-V code is
> built and included in the image and modules only if CONFIG_HYPERV
> is enabled.
>=20
> The four patches are organized as follows:
> 1) Add include files that define the Hyper-V interface as
>    described in the Hyper-V Top Level Functional Spec (TLFS), plus
>    additional definitions specific to Linux running on Hyper-V.
>=20
> 2) Add core Hyper-V support on ARM64, including hypercalls,
>    synthetic clock initialization, and interrupt handlers.
>=20
> 3) Update the existing VMbus driver to generalize interrupt
>    management across x86/x64 and ARM64.
>=20
> 4) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.
>=20
> Some areas of Linux guests on Hyper-V on ARM64 are a work-
> in-progress, primarily due to work still being done in Hyper-V:
>=20
> * Hyper-V on ARM64 currently runs with a 4 Kbyte page size, and only
>   supports guests with a 4 Kbyte page size. Because Hyper-V uses
>   shared pages to communicate between the guest and the hypervisor,
>   there are open design decisions on the page size to use when
>   the guest is using 16K/64K pages.  Once those issues are
>   resolved and Hyper-V fully supports 16K/64K guest pages, changes
>   may be needed in the Linux drivers for Hyper-V synthetic devices.
>=20
> * Hyper-V on ARM64 does not currently support mapping PCI devices
>   into the guest address space. The Hyper-V PCI driver at
>   drivers/pci/host/pci-hyperv.c has x86/x64-specific code and is
>   not being built for ARM64.
>=20
> In a few cases, terminology from the x86/x64 world has been carried
> over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
> x86/x64 terminology and has not replaced it with something more
> generic, so the code uses the Hyper-V terminology.  This will be
> fixed when Hyper-V updates the usage in the TLFS.
>=20
>=20
> Michael Kelley (4):
>   arm64: hyperv: Add core Hyper-V include files
>   arm64: hyperv: Add support for Hyper-V as a hypervisor
>   Drivers: hv: vmbus: Add hooks for per-CPU IRQ
>   Drivers: hv: Enable CONFIG_HYPERV on ARM64
>=20
>  MAINTAINERS                          |   4 +
>  arch/arm64/Makefile                  |   1 +
>  arch/arm64/hyperv/Makefile           |   2 +
>  arch/arm64/hyperv/hv_hvc.S           |  54 ++++
>  arch/arm64/hyperv/hv_init.c          | 441 +++++++++++++++++++++++++++
>  arch/arm64/hyperv/mshyperv.c         | 178 +++++++++++
>  arch/arm64/include/asm/hyperv-tlfs.h | 338 ++++++++++++++++++++
>  arch/arm64/include/asm/mshyperv.h    | 116 +++++++
>  arch/x86/include/asm/mshyperv.h      |   4 +
>  drivers/hv/Kconfig                   |   3 +-
>  drivers/hv/hv.c                      |   2 +
>  include/asm-generic/mshyperv.h       | 240 +++++++++++++++
>  12 files changed, 1382 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/hyperv/Makefile
>  create mode 100644 arch/arm64/hyperv/hv_hvc.S
>  create mode 100644 arch/arm64/hyperv/hv_init.c
>  create mode 100644 arch/arm64/hyperv/mshyperv.c
>  create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
>  create mode 100644 arch/arm64/include/asm/mshyperv.h
>  create mode 100644 include/asm-generic/mshyperv.h
>=20

Greg,

Please drop this. I will be resending shortly.

K. Y
> --
> 2.19.1

