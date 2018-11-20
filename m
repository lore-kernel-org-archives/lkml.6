Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F82C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31BE208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3n7pzjPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31BE208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeKTSg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:36:27 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:14376 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeKTSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:36:26 -0500
X-IronPort-AV: E=Sophos;i="5.56,256,1539673200"; 
   d="scan'208";a="24316639"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Nov 2018 01:08:36 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 20 Nov 2018 01:08:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2l6WyiwQrSFdJu8XcVys1lIMotATewEPRhuIR2+n78=;
 b=3n7pzjPqS97P7g6i8n4RAGQi+g8cDGOXDKIpguPCWtjNFxFNRoe6FHavzizCGNUVTDT5qKvy9ZvFgqO2ymn7iVsOXAt7S+irHcWw0X3DmrRmFZpdTWo/Aip0gIowweaOblVXpGGtC/f+O52qMhYaO+7VXApEKi8G08JSDMnzDBw=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2260.namprd11.prod.outlook.com (10.174.113.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 08:08:33 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 08:08:33 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v2 0/2] add SAMA5D2 PIOBU GPIO driver
Thread-Topic: [PATCH v2 0/2] add SAMA5D2 PIOBU GPIO driver
Thread-Index: AQHUgKg7sO1BpubaAkeUG9saI/UVLg==
Date:   Tue, 20 Nov 2018 08:08:33 +0000
Message-ID: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0183.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::31) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2260;6:rWS0fHGH3BkwcdNjFKYvFdusjyti6EKwaCzCnj13B7BhnY2JPnf0pzoeAenpY3QzqH7t1RU4XezU4SjjoCcerky896tK0kkvFXI4ukx5e+DOrm0MAbbNNIIfC4k6Q/MoTadHuiTYVYsEAzadmGaSN37BaUpUYpv2l2qRdnzgwB+5c/G2E3eeGwKLyf5+bMYR6yMcsBL+iNitaVsqY51iGLROqAOmGrJSNKe6zYK7CZSuvrJe6IB4DOtXXlhbbtVYaTF6Z2EOPvwd8/nPxcdYvsO51JcEB27OAm00eS24OinvBFZrgqVjv32/Dr/UhQD4gIN+uwciljUvj1JDVqAD3MXXH53tiYKn3jbY91GnIB8aHT8OMswBxy5jn3Qbhumpl9Tr6WF2IlWvKekYLS9pjU8QR7tJLSvsEM9/sob199criVRaZme95hA1Gv9ynGjmLp/rfoQkFr1/xuE3Tuu6aA==;5:eBEbnUmvqVM1UhLjjgQ+wJGVvUIaSuPvJdhBHm1CVeeR8pMuiGFzwQ23EEXrMQsZkoiXjYCASmz9Czr66GKnEH7RDQo5PES8Rkc5PnvtqdZCNiPhQNZg75QBk2jbwgGmMpwD3Z3LqI8NzkRBgIjxrZrmdBWuaE7ohnmyLSkx2Yk=;7:XlXW2D2l27Tp81BOz6VvN2hsfw7cWTrL14kG5h6todGHtq10lefOmExM8+F7rbk2MuWxolzk8+SJEc64td0VenhW0Xo+BlgbLTNMq/M8t1S78vaEwQAjQ09/3Th/vzw5xMb1tXDLhAW5qKQrC8vkMg==
x-ms-office365-filtering-correlation-id: e08dbd18-33dc-46f9-62db-08d64ebf5d37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2260;
x-ms-traffictypediagnostic: BN6PR1101MB2260:
x-microsoft-antispam-prvs: <BN6PR1101MB22607637CE958E1F4C1BAAE6EDD90@BN6PR1101MB2260.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2260;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2260;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(6486002)(14454004)(53936002)(2616005)(476003)(2900100001)(2501003)(6512007)(86362001)(106356001)(2906002)(36756003)(316002)(486006)(8676002)(72206003)(81166006)(81156014)(478600001)(105586002)(6116002)(3846002)(71190400001)(71200400001)(256004)(14444005)(217873002)(68736007)(6436002)(97736004)(102836004)(4326008)(386003)(6506007)(186003)(7736002)(305945005)(5660300001)(25786009)(99286004)(26005)(8936002)(66066001)(110136005)(52116002)(107886003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2260;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y4s3ilm3BWK3ztBdIpg02zd4AlTDIoaKy6r57cnjoZqdss7osva/RVkF0WMh/qwwzpjPf5D8vIRWFCSeq2rMsMDXkP7/SHUqS1pV0I+s7UUlO6gMtybcJBkhetQJl6D8F7GqproaoucMRaJ7+lAM/vVEni+Y5nu7QrYRA85v5WS6h7kHWPDQLSibEWuuxXcaigYey0DqufPtJkzAW8G5Iy0Ofe/+MykwHjbJzkAeiK80/G5b7U2QNydok07p+Wh5MdFrB6L5gPWOJ8B9Ck2rBOLkd1ckrRLTFYgydpleM6Q4t+v9o1cZ4n5ZpZSDeJm99QF/pUlnpzOomVFptiEQOxQxLqQ5/YvF1XDL96L2k1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e08dbd18-33dc-46f9-62db-08d64ebf5d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 08:08:33.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2260
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
  dt-bindings: gpio: add SAMA5D2 PIOBU support
  gpio: add driver for SAMA5D2 PIOBU pins

 .../bindings/gpio/gpio-sama5d2-piobu.txt           |  31 +++
 MAINTAINERS                                        |   7 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sama5d2-piobu.c                  | 253 +++++++++++++++++=
++++
 5 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-pio=
bu.txt
 create mode 100644 drivers/gpio/gpio-sama5d2-piobu.c

--=20
2.7.4

