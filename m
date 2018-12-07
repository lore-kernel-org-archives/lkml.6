Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9792C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AA220989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fjMIP67h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AA220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLGGq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:46:29 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:14915 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:46:29 -0500
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="23951627"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Dec 2018 23:46:28 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 6 Dec 2018 23:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1C500gJwq5Et1c6nieBiS5s+2oxfilPaaZHneY3Vys=;
 b=fjMIP67hGyqvVljzpPYsI9BPOk3iy4tQIPAZ1m+BrdkkF4G+4H9PqEKYtZOOk1nByKeyiJyMi2GtqbEF9IV97odfmB+dxINhCEQlRpN8G5ojkNx8HO+BdTZ4+y3+ZSXzrmLxTysAmN6eqXKb7H+BdmW5WwQPHc2nui8cwiUNtx0=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2257.namprd11.prod.outlook.com (10.174.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 06:46:24 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 06:46:24 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v3 0/2] add SAMA5D2 PIOBU GPIO driver
Thread-Topic: [PATCH v3 0/2] add SAMA5D2 PIOBU GPIO driver
Thread-Index: AQHUjfiSwk/aspLsDU6sd9aFqLWriQ==
Date:   Fri, 7 Dec 2018 06:46:24 +0000
Message-ID: <1544165160-13653-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:802:2::46) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2257;6:yyo4xMCeH83wD9zX/PLxyhjjC6aqRKzlRkMcR3RYm4bVFsd//+vy2c4XvXKmyTxKe8ilZ8su1UzhCgAQxrZuMx6ou07a1naTtfD6y9DMCwYQMOYnV/l4Oi5L8DZBOGKHfY/VSFHH7GXfMQ6xAq6GwcoU5wEDRVWcXlZWsUDKnS0B/YSFPR5AiHxomnrjspuFB9nJNVmFVNq/wUU8Daop15GtZflwtWWwWxW2w/CBNcVC5AdXMEQpXNtE8YVXWmklOIEoyezIeF7GJELrQ/6MCe2IvQL8gMWOmpl58vM3pxdUhrDLk9xyev+sbUPt7MS5yakAm52L8iXa7Q/YLZMwPmpKvxD/lupeaKxgy8h1l2oRa63uzQCyO1pKnL5pHPaEihK11xlko8YnHpzn8s5sa3qCSao4I9ROs/sEcDAEoDsH4qs88/7ufkDNEuP1Jy/thfFBi6ACel6aTNANxVTlgQ==;5:wcoAHNdKRZgKT2nXI6FqxPiR+Ag9w4bc6cgfWFtSzxCOLMdbBWQu04TqAubwjjv8tpObRbL+wKIBjcsgMRrkc2SMgGSAYyaE3buSMLqp2aKizY3E0+y3b1p3HXc7+q6ChjGZNa/PAICF6FidVqEQPVvl+WB41D/+zrux4aqBVug=;7:3heyx/N4VVfCTdj9UXaXeUWQZ9GBhSaFa5Gc20DLw3V/SAhX65m/R8QsTGx/5/fm+mA3QrNhVDTV3QS0oG4tQF1FgTl2159nDHzqEsBAIbpXev8rXwGahasTqJrlCr3++GPKXnKEloYHLIzGXGjiaA==
x-ms-office365-filtering-correlation-id: 5f032112-b8b7-4678-845f-08d65c0fb499
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2257;
x-ms-traffictypediagnostic: BN6PR1101MB2257:
x-microsoft-antispam-prvs: <BN6PR1101MB2257089074B4849EBCA2BC33EDAA0@BN6PR1101MB2257.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2257;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2257;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(6512007)(54906003)(110136005)(7736002)(66066001)(99286004)(102836004)(6506007)(386003)(107886003)(25786009)(52116002)(186003)(26005)(72206003)(53936002)(478600001)(4326008)(2501003)(36756003)(14454004)(305945005)(316002)(97736004)(5660300001)(486006)(86362001)(105586002)(6486002)(68736007)(8676002)(476003)(8936002)(2616005)(2906002)(14444005)(6116002)(256004)(71190400001)(71200400001)(3846002)(217873002)(81156014)(81166006)(106356001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2257;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kda8LFuF3kTf5SOYpjGsVZDcifd8E9YYiGvFYTQAjMv8xEUdpZyp6F/X3bS0zYMHoFxzllM/WLtp94/TFO7DjYOwWjDvEE75XvxsNuWIVjXLG5uNzqp+nzYzKwvxQvLVM7PkKpb44AQVkTh0nPVZR/20e1FSut1Qw4zSgi8xridNcaPSj7s/Y3UWQ0qiRPHdjdyZ54pY/EaP8QC6BelNpCwE5bufhwt0iU/f9F1RExclt0mUo2wP2IYBGDrJCVH+l196ZI4GbwPhIttuhjRw5mM6+mz2AwavxdrfTcrhfofxci0h66NK6AY5baSKxdlaOBe5BjbrsoWSQLqqjxrgxwpj780AdJlVRoCL0A6Q7d0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f032112-b8b7-4678-845f-08d65c0fb499
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 06:46:24.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2257
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SAMA5D2 SoC the PIOBU pins do not lose their
voltage during Backup/Self-refresh mode. This can
be useful, for example, when the voltage must remain
positive for a peripheral during Backup/Self-refresh
mode (suspend-to ram is the Linux equivalent state).

v3:
- change driver's compatible to atmel,sama5d2-secumod
- get syscon using syscon_node_to_regmap(pdev->dev.of_node)
- document how to use SECUMOD as a gpio-controller

v2:
- make driver be a subnode of the syscon node
- change Kconfig to depend on MFD_SYSCON and select GPIO_SYSCON
- change include header from linux/gpio.h to linux/gpio/driver.h
- include linux/bits.h header
- change intrusion in comment to tamper
- fix kerneldoc of functions
- replace GPIOF_DIR_* flags with 0/1
- replace ?: statement with if-else
- remove the use of sama5d2_piobu_template_chip
- retrieve syscon via syscon_node_to_regmap(pdev->dev.parent->of_node);

Note that PIOBU_REG_SIZE is used to determine the register to write to
with regmap:
	reg =3D PIOBU_BASE + pin * PIOBU_REG_SIZE;

Also, no irq capability implemented.

Andrei Stefanescu (2):
  dt-bindings: arm: atmel: describe SECUMOD usage as a GPIO controller
  gpio: add driver for SAMA5D2 PIOBU pins

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  12 +-
 MAINTAINERS                                        |   6 +
 drivers/gpio/gpio-sama5d2-piobu.c                  | 253 +++++++++++++++++=
++++
 3 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-sama5d2-piobu.c

--=20
2.7.4

