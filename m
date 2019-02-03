Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C785EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8702320815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dr710E++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfBCRkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:40:39 -0500
Received: from mail-eopbgr1320139.outbound.protection.outlook.com ([40.107.132.139]:2944
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfBCRki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJIYdA4J6iIrDpO07Z2H1TBpvNj0N93ugrLIxNXs9XE=;
 b=dr710E++QWt0toxaUOElExkkMkawxA+crfcUgK7L7Zo9nWsjyTvTKR6jvqbOd+shiKcefnixOkuerMu5SsW4dYqwYpKwfUt2+ehOvAJx1Rq3XGepA0RhWe7LEmxPN2wkoD+XN6IfzY/LZUJGVhoa4NC/2sGzZJweAZ+HF7ksquQ=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.3; Sun, 3 Feb 2019 17:40:34 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1622.000; Sun, 3 Feb 2019
 17:40:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kbuild test robot <lkp@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
Thread-Topic: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM
 family
Thread-Index: AQHUu84T5K6nrmtQjEilkfvm/cd9XaXOVyJA
Date:   Sun, 3 Feb 2019 17:40:34 +0000
Message-ID: <PU1P153MB0169D0DA7D2C41CDAF94153BBF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
 <201902032214.9a8kjJLO%fengguang.wu@intel.com>
In-Reply-To: <201902032214.9a8kjJLO%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-03T17:40:33.0784550Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d8c7bbe-6242-4193-a3b3-a06c873b57ea;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [73.53.115.85]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0153;6:dZh4VzdetsyYc5e9ZLb+349+xG1Y7doKmwDr8NDBcKeZx3aRYZLiChQPhkw9u5xOfQrxQY39lJVg3ZKblHfTEUgQuL6QTzO8eT8EI/TRSfl+I93IrU3IgBXjEhGbuTnkNgJc/piD3a/F7AWRyOEoOXxmIe1aMFFICoPQhIfClB1a+lK7qCKVX39MmiLFlQ9jEDX4uUTYorcQj4C/H/JBIrg7k17BYCWVdU2F8kZvIjLbtWugfTzx+/j6NM2jRhn1g3lB1Q3rsXcjxtwRhnvzA8nKwdmHKga9HwPWESvxbGp23n3a1Q4jyu2r4JkPlFcmx4QmsJ3DKaJquIGj4hLpaXaqtLBcQqyD5zTFdhbPrt8xCF2q89CwkDupN8tM4ztO0Kq5NtlTu6LULG2BXIzo0OmJnD5uCD3RoIeff38H7svypMwA88hdTCCW98bUjxj/gcI2HrjTqtBFSGakR607Fw==;5:pb21+KNP/7tbslLStRQ0SYpBP5jeRlTs3BOiliB5gtnX6rSjysPhPUWpJ6uKS1tqs94/j/1KYwdE7T5Z7M8S0xgHurPIn/nIxUPNuK5QnDCOhFJBDbe3fWj8lMfBwtSsiHlY/FPpqLrF8gr6PyksGLmUd9D96BWBtlt37Y5ia5f119tDVDnCTdi1p4Q/7RnYTOxL1UmCqAUiOevhKVpQRw==;7:rCzL9YVC+Qwra7OvHkYgtPhLLfb+vOXpP5G2seLJ1BWMx7ipiFQGUzGlIm368GolEC6AUAAJA27k23n+CoV5oQ0k2TOsr783d+hlQ/CjDM2l7cBI+9wGmu3W7rrmTSMhb6ulc3zgvbVJNtfbnNTk0w==
x-ms-office365-filtering-correlation-id: 2c54bb1a-25ef-4bba-955b-08d689feb3a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB0153A2BA17EC510517CFA371BF6C0@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(396003)(346002)(39830400003)(189003)(199004)(6246003)(74316002)(55016002)(25786009)(9686003)(4326008)(6306002)(6116002)(3846002)(6436002)(8990500004)(7696005)(76176011)(99286004)(2906002)(33656002)(53936002)(316002)(10090500001)(54906003)(110136005)(71200400001)(71190400001)(22452003)(86612001)(86362001)(97736004)(68736007)(446003)(476003)(11346002)(486006)(6346003)(26005)(186003)(6506007)(102836004)(66066001)(478600001)(106356001)(105586002)(305945005)(7736002)(229853002)(10290500003)(14454004)(8936002)(966005)(8676002)(81166006)(81156014)(256004)(5024004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AWP8pwYUFvn/0QAZ6NOLzH238WcuODl4IG+a9D03LsSgZ+FV4hZLG+406E5BhkrXqIrG46NWyVy5xXI4Jw7JpMELICpZRjUP9JdQgCYEmcPuVCBtfnYeVytBCrX4pX+YtFz104PCe5TO5elhzrgUcMcn6+Vt9HqZfcK2GX5kWy+sfObTb0hMXacbRgVzaia2q58MSmRVBt0b9FWOf71d6dU2W56uXTSSfqKqcpz44xtgEOxj6LS8qWrKX44wnKmGVxzN4/QtuoO/5diJsuTIbaBA3lXHmDtPx9/7eNoR9sPamCi+MPvJy4umGvcG5TgVigQFJD0KYy0ENcObGdgS1ClSljzfTHP4FPtkDIitqFDsdMW6xtl1zR3oMzIIFyWE8dqiVXSoQ4ey9NBxww+7lYrzYcJBsphCrxpmiebtLeQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c54bb1a-25ef-4bba-955b-08d689feb3a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 17:40:34.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: kbuild test robot <lkp@intel.com>
> Sent: Sunday, February 3, 2019 6:38 AM
>  ...
> Hi Dan,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on linux-nvdimm/libnvdimm-for-next]
> [also build test ERROR on v5.0-rc4 next-20190201]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system]
> ...
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-8 (Debian 8.2.0-14) 8.2.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/acpi/nfit/core.c: In function 'acpi_nfit_register_dimms':
> >> drivers/acpi/nfit/core.c:2003:27: error: 'NVDIMM_FAMILY_HYPERV'
> undeclared (first use in this function); did you mean 'NVDIMM_FAMILY_HPE1=
'?
>       if (nfit_mem->family =3D=3D NVDIMM_FAMILY_HYPERV)
>                               ^~~~~~~~~~~~~~~~~~~~
>                               NVDIMM_FAMILY_HPE1
>    drivers/acpi/nfit/core.c:2003:27: note: each undeclared identifier is
> reported only once for each function it appears in

This is a false alarm, too. The patch is only for
https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=3Dli=
bnvdimm-pending
where we have the dependant commit:
1194c4133195 ("nfit: Add Hyper-V NVDIMM DSM command set to white list")

Thanks,
-- Dexuan
