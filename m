Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F244C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF2920449
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X+lMaUVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbeLNOt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:49:27 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:48160
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbeLNOt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCiemSHDKk0GkoAZOVpZpYgFtPYm9lqs9erReTZc/do=;
 b=X+lMaUVMrxaziFBwtGZd1/mgtJNJfSreSkdUi9QTb9TN0Zl8u/ZY/nAqrvRGYqOW1GFJdexTOf0L1YwddDP8VE2zj0LNLLp5M6qO2CK3BODL7oeOw/wkrSQ34UMdDU7CFnFAVODCUCy95cPpme+uVQY1W2wUPxcDUC5aIm/zA4s=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB4673.eurprd04.prod.outlook.com (52.135.149.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 14:49:23 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%5]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 14:49:23 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>
Subject: RE: [PATCH 4/5] soc: fsl: dpio: add a device_link at
 dpaa2_io_service_register
Thread-Topic: [PATCH 4/5] soc: fsl: dpio: add a device_link at
 dpaa2_io_service_register
Thread-Index: AQHUkKhvbOKxpbVdsUixjbAsQ8NNAqV+VsYg
Date:   Fri, 14 Dec 2018 14:49:23 +0000
Message-ID: <AM0PR04MB4994FAB53691358F750D87FD94A10@AM0PR04MB4994.eurprd04.prod.outlook.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
 <1544460591-14888-5-git-send-email-ioana.ciornei@nxp.com>
 <VI1PR0402MB3485C4800D690B2A27FAF04098A10@VI1PR0402MB3485.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB3485C4800D690B2A27FAF04098A10@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4673;6:F8jDBC/7tcdsvHOMx/qv7OKu0CsblRoEM8ASrz+0+P/pQC4H3t0t2ZqOnR6HV4V5cunG9WIaisvB2/ucjOGKo/qYYOMUy5Qc89jWQkJkSpa9O+THbd0SpZ9rWIkNupt9dUVfdxdJueJJEX1rg1ADzGZ0jJNEbtOQ24iYhvttgW6UUe1gyvG0ThJC5J9zKiQkqZgTJnRzcTH4uicN7fDRj5pk/+qTDDlBHLmDamNakL/iltNsy454KbAVmJEwgCJiY6DroBHzfMrvYYSBtl6Njgqv3eEERffLpb+Sls3JXHWrN4Ap6gBFLS7lJBsVm26oglmpScnWE8DrnR1u29DKWiyDJkQON/OIIo0QuilT/MRAoFdpKbnSfCssMnRb3Z59oRsyy9JCAbRDdn8lN31t5XL33N80NQ9WBfySfHIR94htZJTs8zYmTx5jMnaW9NAWaeaq1aseDuK3L7wuWb0HDA==;5:B9X5Rf502KEGP1sFI1yR7aWepsqLbbxr5bh18C5jOe/PLgmsyXyRgutcF2fP7FQcs5uAx9mCUNE2lOu9xdwkvdj9q8zTziU2T4dfT3OIVsEOlo+dv2xZxISK62hnnVtQYdL21PwamOfuWBSjHGg6LElwZT57SbGFgYOzNkdpBgo=;7:uocZ2go59O8EJ8jNxW9Scbd74MXwN2PDNywWVm34dL3G4SoxH2EeKqXCbiSGO3OqRyOIVEe/kN51uywEAF6eDZYfkd6HcG2Ga2331C+vpUo5C0Jy9Ej8OVKDq21RnTCBGfaSlRaa+lZ2Wp2xIxuITg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c21a9d97-9f67-4ea8-88bf-08d661d3567e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4673;
x-ms-traffictypediagnostic: AM0PR04MB4673:
x-microsoft-antispam-prvs: <AM0PR04MB4673D8C25695F59BD404206994A10@AM0PR04MB4673.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4673;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4673;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(13464003)(476003)(81166006)(478600001)(8676002)(26005)(102836004)(5660300001)(6506007)(14454004)(81156014)(6116002)(110136005)(486006)(68736007)(8936002)(53546011)(71200400001)(3846002)(71190400001)(76176011)(54906003)(256004)(316002)(2501003)(2906002)(2201001)(186003)(446003)(11346002)(86362001)(97736004)(25786009)(105586002)(33656002)(55016002)(66066001)(9686003)(106356001)(6246003)(74316002)(7736002)(99286004)(305945005)(7696005)(229853002)(4326008)(6436002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4673;H:AM0PR04MB4994.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sHjQU3rfLbO+My9Rv80KSHiCN+kU7+mJjyG/uc6ZuOqOfrVvIwi6dw541XsB7BuGf+tScsBCd97GsSBGW4gHVIEzmg0yXQIWR4B7/gSOnkNgBJaCq7CkMAa4vXFFKyYnawKqKuG9lGTIvpUvIS5UOpV3G+YOwftfjMiIIJE+spAPrsPRrOS9E1ry54Aptuay/jzFr4c0GwljSjCnBTPAdUCNdzdH0gQ8wAXsEG+H+Q4ZTlXi3A8xlywpDL/kL7Aj4iGH+Xg5uNVOLLReDgH7+sOaGUXkjIPNFNQ4frMkjitfKkieKXDz4DJEINQaOVKj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21a9d97-9f67-4ea8-88bf-08d661d3567e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 14:49:23.5019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Horia Geanta
> Sent: Friday, December 14, 2018 4:45 PM
> To: Ioana Ciornei <ioana.ciornei@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> netdev@vger.kernel.org
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Roy Pledge <roy.pledge@nxp.com>
> Subject: Re: [PATCH 4/5] soc: fsl: dpio: add a device_link at
> dpaa2_io_service_register
>=20
> On 12/10/2018 6:50 PM, Ioana Ciornei wrote:
> > Automatically add a device link between the actual device requesting th=
e
> > dpaa2_io_service_register and the underlying dpaa2_io used. This link
> > will ensure that when a DPIO device, which is indirectly used by other
> > devices, is unbound any consumer devices will be also unbound from thei=
r
> > drivers.
> >
> > For example, any DPNI, bound to the dpaa2-eth driver, which is using
> > DPIO devices will be unbound before its supplier device.
> >
> > Also, add a new parameter to the dpaa2_io_service_[de]register function=
s
> > to specify the requesting device (ie the consumer).
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>

Reviewed-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Thanks,
Ioana
