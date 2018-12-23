Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF2DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057F321905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ptz/Nk6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeLWJHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:07:50 -0500
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:8016
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbeLWJHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTeb2nXVi2gEEQW94hCED8JApkg/R7VXw9g8tBmtkU4=;
 b=ptz/Nk6YR0WOZPa5jL/BJ8VapR1yBgAD56b0+j1TYfXWUuK3mgaG4xOcnpdjmeS7LbKohPix8C6mFMpoV4x0NHf5NbPYEPvU+4U/muKsV4Wd1C+gobuLERH/OFfkCG1un19HudsA4ANiRNEyEABIbbtv0nRawPEUPdAxEXSiCbk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6002.eurprd04.prod.outlook.com (20.178.114.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 09:07:45 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:07:45 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: freescale: Break dependency on SOC_IMX8MQ for
 i.MX8MQ
Thread-Topic: [PATCH] pinctrl: freescale: Break dependency on SOC_IMX8MQ for
 i.MX8MQ
Thread-Index: AQHUmo5PK/Tz1O1SH0SGzdYOjnerF6WMCIMg
Date:   Sun, 23 Dec 2018 09:07:45 +0000
Message-ID: <AM0PR04MB421177E54921ED4BB6B59EB580BA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545548891-24671-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1545548891-24671-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6002;6:9fKW4sSaFkI6D7nwoG0Jw5QKQAn/5wt7LC6cMggRx+4+K8igT5yTttt1eOmvNdrqQSlRdo8btjtSOTU9DLmtEHklDxwveiB4j1CYUsahTudxlf4ueE3zsS9MZ381LuuYAdIMmbNsryW9Tt+iG49ZcyZsivIjuZ5lECQLQtDUd/r/p2/j0bygiY5es/gnaRAnKOgDHEjM3W6eeBvcCYn/kzJWlTgEo+AxWd/ha3ZuY8Jlt0aswT2xO4IM8JpOJ4F2jqRm70TPNWBuGZyBPjFBuqorMWD8A87UNyHyoJBd7btDiY1sf7EFbLQiJG0NzVeAfd/QRx482jq5LD356k3F5JRXkKj5Qk/C8KUPjRH9n7rc/jrl5PImeVflGs+k6Ve4n8exCi6U2iQ6UsUrLTMebWUqmin6/m+dCaRO15o2gijI9SS7rwCtvm0e18/46aWxpITykoFxqzLpr+wZicU9PA==;5:qhyYRrFfzjPa/9W7GUZLZUsCxlnri9QM23IoZ7x5dw+jOKLwsIq0zv3rpCakNgiXs7uEbbp1u40naQN0KO3XCfconnx0mhAr+C4LTZXPFHCsVFBsHzL5GquE75EAoZY6hNvTKS516NJnpgRI7B4huqWCEW40CJ8Qgc1PQexJvEM=;7:NlyWwM05Wq/PhH7Hf6+FPc1yJbFmKoRyfecbgNDrOsAVsSYR4rP2bgBKunTzTJzyctBonbuV1yoT4xhDic/iYki5j8jtam1V6v7u/NEI85VIZoNFkuO/FezHVWt69B9rgfTo5AUxmK6y2xkW8b7KaQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 43871b43-663b-4350-9397-08d668b61a72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6002;
x-ms-traffictypediagnostic: AM0PR04MB6002:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB600215BD6773B7FBB52F225180BA0@AM0PR04MB6002.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB6002;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB6002;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(13464003)(199004)(9686003)(68736007)(53936002)(6246003)(8936002)(478600001)(55016002)(44832011)(476003)(486006)(81166006)(256004)(81156014)(2906002)(7736002)(229853002)(14454004)(305945005)(74316002)(5660300001)(106356001)(33656002)(26005)(8676002)(97736004)(186003)(7696005)(110136005)(76176011)(6506007)(105586002)(6436002)(54906003)(558084003)(66066001)(11346002)(102836004)(99286004)(446003)(4326008)(71190400001)(6116002)(71200400001)(86362001)(3846002)(25786009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6002;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tK/R+L5OKHlwdg2kjKvm2paSqIpeJSWF6tBZuThfN3Ia+MyMSIEcCsT0V1CfL9nDQ3m6p7roa38t+pYY6DCgzt5iLOn1iBKI7h3pPKG/BBxmjCst8/UR3zpNcQGCTxq0GO6dQCWCy3BkUTy3wU3tpjrVsbEOARsl/TarLGYFDJFCodrbobrauNh0zXXRVEcjTcBWNETHzeyvgNdmBNbLu4SS+gk5L05bycIRovns+LVzD95XhZSmVtWAxoD68+Rw/oW9uVHm/N6xsVNHD6ODXRixLESATx86nAwli8ySSmVGGdoMHtra1UPhGBhnPQns
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43871b43-663b-4350-9397-08d668b61a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:07:45.5966
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
> Sent: Sunday, December 23, 2018 3:09 PM
>=20
> The CONFIG_SOC_IMX8MQ will go away, so the dependency can be based on
> ARCH_MXC && ARM64.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
