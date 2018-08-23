Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA91C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC12152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JC5+Veg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CC12152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeHWVWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:22:19 -0400
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:23056
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbeHWVWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCF25gJfMjtdQ2rslxWpjF8oI3wRyeAXEBfGGInnV9I=;
 b=JC5+Veg+z5U5Wm4sX5Ns7d9+EfGcRFGB1ckwwFQ5E0gIP0y0H3wNubscj/uREbwehH/Y69aKqwSg/0q+rcHsi3G+4nSPSJmoMoLeAFlkkGeFTk5TqBUgMdEfioHfFKecLQtRSS0xuxxIrENvJqxsaiImD6gdNcR0KKxkFQT6HMU=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.176.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Thu, 23 Aug 2018 17:51:25 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::60a7:5c31:8fd7:825d]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::60a7:5c31:8fd7:825d%4]) with mapi id 15.20.1059.023; Thu, 23 Aug 2018
 17:51:25 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Michael Jin <mikhail.jin@gmail.com>, Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] EDAC, amd64: Add Family 17h Model 10h support.
Thread-Topic: [PATCH v3] EDAC, amd64: Add Family 17h Model 10h support.
Thread-Index: AQHUNZdhp8+dIOBXj0S9UogVExIizqTNqIhA
Date:   Thu, 23 Aug 2018 17:51:25 +0000
Message-ID: <BN7PR12MB2593EA63572DBF05D75CC5CFF8370@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180816192840.31166-1-mikhail.jin@gmail.com>
In-Reply-To: <20180816192840.31166-1-mikhail.jin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2610;20:Cq343d282pu6scUga19kjdaXDh1QVoaTh9pc0arl/r0X1riNW66gWS0pxQBarNkG6oBtEB/aC8XK9QD+nb5tJ1spnVZUSMAO4l8TltJhJqE5OVQpVriLo3oFoZ1UDDjuUCE6LfcN5sfvukyBO6WDEo/EdQa0/CoGl5k5wVRaBFS0oU8/7YGDYtKzFhGUkClt0XL8OXjr6H7BMl3oRIA98F//0t9MsiO4UH0rAMfURuHvPSKVypL7HIZHtL8Xf3qr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bbca8022-86d2-4237-2a7f-08d609210bc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2610;
x-ms-traffictypediagnostic: BN7PR12MB2610:
x-microsoft-antispam-prvs: <BN7PR12MB2610CB5EC9D8E5AF4017A672F8370@BN7PR12MB2610.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BN7PR12MB2610;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2610;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(13464003)(81156014)(81166006)(2900100001)(8936002)(25786009)(53936002)(72206003)(6436002)(478600001)(305945005)(316002)(14454004)(7736002)(5250100002)(8676002)(55016002)(6306002)(74316002)(9686003)(4326008)(6246003)(39060400002)(105586002)(966005)(86362001)(33656002)(106356001)(6116002)(186003)(2906002)(14444005)(5660300001)(6506007)(54906003)(46003)(68736007)(476003)(446003)(11346002)(229853002)(97736004)(99286004)(110136005)(53546011)(486006)(76176011)(7696005)(102836004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2610;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wVQBDjquI957RZenF7KSDmvIkEiaVUQqHjcLSN+qDcURP+G7VM5pcsuvx9ux/pgSXrkSyRMCXL4xpmbOkCjriqbDw0bl1sMVKR6Qt0uw6ggPjln7dZH005HaKnPwjYRxzarsR4WyN2HWaC+H7ByJkNXM49nqfeuk+nNsB+7axfsiT07+NO67pJxyiLscCC5R2liW4bz64fslREcCF+LfbhZIy4cOHIfTs8S7V2gnb7GCwUHirHSzJyHkSCqKmEBEmznwchjHggCyRzCaWisLdDk7cWXENbNtN+R+zapYkbozBqtmnj7pGCAO60c6aU8Ia85EGfpR1MlsGymdz7XIFdH/7YaBtPJX6z67jSvK1Sw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbca8022-86d2-4237-2a7f-08d609210bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 17:51:25.3499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michael Jin <mikhail.jin@gmail.com>
> Sent: Thursday, August 16, 2018 2:29 PM
> To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
> <Yazen.Ghannam@amd.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Jin
> <mikhail.jin@gmail.com>; stable@vger.kernel.org
> Subject: [PATCH v3] EDAC, amd64: Add Family 17h Model 10h support.
>=20
> Add new device IDs for family 17h models 10h-2fh.
>=20
> This is required by amd64_edac_mod in order to properly detect PCI
> device functions 0 and 6.
>=20
> Link: https://lkml.kernel.org/r/20180815114107.29797-1-
> mikhail.jin@gmail.com
> Cc: <stable@vger.kernel.org> # 4.10.x
> Signed-off-by: Michael Jin <mikhail.jin@gmail.com>

Looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
