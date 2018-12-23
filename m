Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7029EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C7E21905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dSeEBJLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeLWJIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:08:42 -0500
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:27840
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbeLWJIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xS0ghcVj5WveA588PelqTXUjpu9h6xKKrKAcqLFphM=;
 b=dSeEBJLWQ8Lj3uBSB3yi1ek0NpPfNdKyOu+ZLDLylpeQmZeS3DaDbvAxnZFgPZlYlQHtzJNsTBUgLrteJkI1o5MfTnbboTnRqX7dMmLZ1UwyO53kYhFe4jGrjnphHCcCWsdGk2Jy6KepDCpB/WCfdabu6rf2p7rUgZjthgb51+c=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6002.eurprd04.prod.outlook.com (20.178.114.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 09:08:29 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:08:29 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jun Li <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] phy: freescale: Break dependency on SOC_IMX8MQ for USB
 PHY
Thread-Topic: [PATCH] phy: freescale: Break dependency on SOC_IMX8MQ for USB
 PHY
Thread-Index: AQHUmo2cgx2cbWzjsEWmInIs0QcVSaWMCOKA
Date:   Sun, 23 Dec 2018 09:08:29 +0000
Message-ID: <AM0PR04MB421121A49C53EFC8B487CA3B80BA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545548599-20534-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1545548599-20534-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6002;6:mFZfdOYTc0Rbr067NBpj+/t/950yNst4LG+pXhcRyzRzdwvrktcGQNmmhs0jm6LX2RCfoj2UO5Tw8PRUoToqkaaxU/0po6N3Eqq29FZNU/zoMrDmp4Y8HbMMgW4mRwoRUCXSqxYpH3zQY8oF2+4jRH0nSyGnQ4KCvntPAjmVZolMBMZEEZ6Yd+CmEYAMPVzCexwnNCNS6yO7sMNKvyO/33gq5Y+nzev9JWC/vLx0wvhPmYzS3fwiPeOIzONV8XyZ5VcpveNPve1YLLqWxHCPK+MZz1F24JO9p36ojSafagFWb4e28gepGyNgx53zKIQqsa4J+Xh5qM8MIK0lJ0SSR9gFZ/AN8KKH7PZSaVAK5cBmPWTbxQfBmsT/nxxBz/lY3IFwrsN5Ecw6luZJ2HIzm24k5Gi70R+7BPC6aZUugpFdQEvL4YBbOT6kqF8qF6SVpBxLI41kvoIlUSiFWy9dzw==;5:BwIV65BXH5XKObqYIOMgpP2WUgNUJXtH8I1wcK4WnJPtstCk3c13OQDgc/iV8Vg0zWXJhOTilfEJcUoNSmm+4gengM6D+Mo96QSMdleVZ7HxPvj0mbo1TCPCnM6HTfGMo3cioOppEC6F8LNHTa8MVqNHzW4pkdKHKmGfXUgSIUE=;7:29DxY5KanVaeLv+dIDg1xPJanVoq6vBZZ2/JrGCpAx3qcEOCXv1q81S5LtwU/5DIKvjQcae2N4eBQtmwEJ07FExRvF3R5hBnPc128nORX4WM+TKx53GJnl2ztYH+8dumoEpF0gshjuKTkUk5GQwY+Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5c4c399d-efda-4ac6-6e09-08d668b634bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6002;
x-ms-traffictypediagnostic: AM0PR04MB6002:
x-microsoft-antispam-prvs: <AM0PR04MB6002F9657994913B8667A58680BA0@AM0PR04MB6002.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB6002;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB6002;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(13464003)(199004)(9686003)(68736007)(53936002)(6246003)(8936002)(478600001)(55016002)(44832011)(476003)(486006)(81166006)(256004)(81156014)(2906002)(7736002)(229853002)(14454004)(305945005)(74316002)(5660300001)(106356001)(33656002)(26005)(8676002)(97736004)(186003)(7696005)(110136005)(76176011)(53546011)(6506007)(105586002)(6436002)(54906003)(66066001)(11346002)(102836004)(99286004)(446003)(4326008)(71190400001)(6116002)(71200400001)(86362001)(3846002)(25786009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6002;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tvypn9NQLNZPw4xsb9kSOjznLTqcKhC5x/XMiuEjyPfIkp++o/mFs0pIQhxu+XC4qyQ0r5fCjD8E0Rwkyaf16vWLdmC0dgRM0cUwkWZwvcIqgecqTkrlpd+fvrRSOzOUdUDi6KZ5tgvxveoi5zi9XW302RHYpI3Vw/T4KELwBI8aoj3i1ZgxNbPho2LWVi+vvRY9r31A/PwkN8C6u2uJ8uSHR/ZR8xkgwhpMQIzgb56T4R1oHl4M3wSt0J+WDM8tUcugHlHkWhhoftrIHmjUDcSoaHD8sw5ANW4O3F7z7CQuO3iEetIzODv6G5haiqkf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4c399d-efda-4ac6-6e09-08d668b634bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:08:29.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Abel Vesa
> Sent: Sunday, December 23, 2018 3:04 PM
> To: Kishon Vijay Abraham I <kishon@ti.com>; Jun Li <jun.li@nxp.com>; Luca=
s
> Stach <l.stach@pengutronix.de>
> Cc: dl-linux-imx <linux-imx@nxp.com>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Abel Vesa <abel.vesa@nxp.com>
> Subject: [PATCH] phy: freescale: Break dependency on SOC_IMX8MQ for USB
> PHY
>=20
> Since this is going to be used on more SoCs than just i.MX8MQ, make the
> dependency here more generic.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
