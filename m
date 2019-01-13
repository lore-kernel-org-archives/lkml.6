Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F9C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 17:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEA4205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 17:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nzngVUsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfAMRUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 12:20:43 -0500
Received: from mail-eopbgr810114.outbound.protection.outlook.com ([40.107.81.114]:6123
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfAMRUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 12:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B318SwpE1j/FluarQ6jdTZJmXT8sb2TMDaofhmrxW3M=;
 b=nzngVUsJNvB2i7W8TNCLD+faC0N12jlYpjhFWmNQSvxuKiHYODAcApjHk7rS/VMFhmJTB24gyE/bLdb4D3YolfkEamrMFRlk7JCdcmaqFLQyDnNZ0apPPzzTX3dTKgkwxL9Iuz4WBkMOr7fQ0apDsbtxjkcPIc/KngwiPp5vYpI=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.1; Sun, 13 Jan 2019 17:20:40 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::78f4:babd:9883:58b9]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::78f4:babd:9883:58b9%4]) with mapi id 15.20.1558.000; Sun, 13 Jan 2019
 17:20:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: RE: [PATCH v2] vmbus: Switch to use new generic UUID API
Thread-Topic: [PATCH v2] vmbus: Switch to use new generic UUID API
Thread-Index: AQHUqPBgQVPZGdO3OEOBM7brhn/+7aWtdj7Q
Date:   Sun, 13 Jan 2019 17:20:40 +0000
Message-ID: <CY4PR21MB0773F6E7AA18B8E6C9023D94D7870@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20190110142532.52067-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190110142532.52067-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-13T17:20:38.3835644Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:Y+7Tdusrjmi3CIApg0u5eRo0EDHF5ql01yE1NmcNyuYHS6F3Hc71w382tswTmpR8D5F8xhQs7TF/lwT84OyjqZko1mIvSj9sgedfzlBQBDwrAfXotKacibGQWi+WP+pOcr2eNr47CWg2YWdxzjySN4stpVQwZjRgbpr0MjKmbrs55nZAU4lXXLhK4JgInsZu6GPSwb+HqxvEYTU+aD6HOhxMSxD5OTMdUuAHK3BrTUuEofPoam//y2RnzYTy+Nj8sB7e3818+LLEe0/gLUU3H5mH3xkFK12ySiuIUXU2DgpxDCya8hDU5gPdbLIGuB79/cunhktiNzaQ2S14vb7kOWNkveP38RS9MDkNGYGO66l2FRenynibdBZHZi9y2jOMJIspQXeqclon3HUIxb5JwvAaSrBIRk8lTeVRavKYkrp8KQSAtrqOE8ulOEng3ItIOIBkoHSErXcBxaTbGI7i2Q==;5:SUSMIcJmRh0FbsmZ36M+Zxn5G1EiOFt01qAjppggtA7gMpfLLfYGfL5R5DnlCC0SqJjnhAKvkjuflIubYoWuHpXvL1jSJ7KS9IDGm0vXaevv9IPmXPOeFkZO/6yZp4x0guWXCWxWXCvwpaKb/5wIH6/JA9vdQarp5ycr+qrDRoRsCwwK/IPyI42jKRXSf3jvqMU2fvnNsQzcVWdjYJD/5Q==;7:Erj92J8Qm304uT41N0ewPnHrNXykTai6YDziaOMmsGW4LVy2Vr9O0EO3KzaqiK1zbch4MyzJXUiBHiMFhVjUjjtjp4zXyR/3tJoeyPRrnQH7Oseph+SUD9plbWWT59VATUNj28OFIKCrVgyJXb7iyg==
x-ms-office365-filtering-correlation-id: 056738da-115b-413d-7a39-08d6797b7148
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149C5F000BA6232CE3E7601D7870@CY4PR21MB0149.namprd21.prod.outlook.com>
x-forefront-prvs: 0916FC3A18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(110136005)(54906003)(305945005)(476003)(25786009)(229853002)(8936002)(446003)(9686003)(11346002)(7736002)(10090500001)(10290500003)(14454004)(76176011)(8990500004)(316002)(8676002)(2501003)(186003)(74316002)(102836004)(7696005)(4326008)(26005)(105586002)(106356001)(22452003)(68736007)(256004)(81156014)(6506007)(81166006)(478600001)(55016002)(99286004)(2906002)(71190400001)(66066001)(86612001)(5660300001)(486006)(86362001)(53936002)(6246003)(33656002)(1511001)(6116002)(3846002)(4744005)(6436002)(97736004)(71200400001)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YKH/6CpYHW7JvYzXxhHWBFdJVNi1nGdbHFntG2skd1DQk/p0fqrt96PRL5uS4hXCqtX9MIMKCM1ynvw34BBFqXHJQnmaJ+dzMUFYlhKv2fQ5hUKyGIPawjmqrf1BZ66fuaziGlt6EEJHbivyph1SsGQ+7a9+UG9NGa3g5pkY4tHfkjGgVftNJo8iJrtBu6eJCbZmbB9CQys97snVUhhasl+l5KuTTQElY+/XZkgeMFuky6AyZUDzMzlrkHpevA1cje+Ow96fZKZEYF8DKquO4KpanFCyuJcWuDYQVpxrlfEUVO3PoW92+dG7u8AKo25qI2t/DjFAVCXio7jRPb+rT2SVfV5XByzYNJFCOu0VkauEXqfGGPTXK1M1q1HXUejw5izhvrdoKg5ynwpnPIq8cR46ENL2jfTs1AVP0Q0Z0m8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056738da-115b-413d-7a39-08d6797b7148
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2019 17:20:40.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> Sent: Thursday, J=
anuary 10, 2019 6:26 AM
>=20
> There are new types and helpers that are supposed to be used in new code.
>=20
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: devel@linuxdriverproject.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20
> v2:
> - leave uapi untouched (Christoph, Haiyang)
> - rebase on top of latest linux-next
>=20
>  drivers/hv/channel.c      |  4 +-
>  drivers/hv/channel_mgmt.c | 18 +++----
>  drivers/hv/hyperv_vmbus.h |  4 +-
>  drivers/hv/vmbus_drv.c    | 48 +++++++------------
>  include/linux/hyperv.h    | 98 +++++++++++++++++++--------------------
>  5 files changed, 79 insertions(+), 93 deletions(-)

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
