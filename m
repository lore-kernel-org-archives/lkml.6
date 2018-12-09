Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A4FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D56320837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZAWh7Y09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D56320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLIO0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:26:16 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:42112
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbeLIO0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaGgA5u7CyBNNs5XuVeahIOP6WGIRspdwQIDduTlKjE=;
 b=ZAWh7Y09WmeLWTSv0ELJYlOjTvtw+Q0lCysdBqyuypQ25h9X4Hdm0Lb3gIIk+e/VdbGi02MFbxLccUFqKHtL0hASd2+4kLmZkRl3A2yr06HF5Gu64DWIu87R5Zv8yrXTjEVZj1RyO1JZbnSe/LTtXmJp1dNG9EenQXGUgsjzXrQ=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sun, 9 Dec 2018 14:26:06 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 14:26:06 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 1/6] arm64: add basic Kconfig symbols for i.MX8
Thread-Topic: [PATCH v5 1/6] arm64: add basic Kconfig symbols for i.MX8
Thread-Index: AQHUj8seTSAugeUOGEeudsCVZx0OQA==
Date:   Sun, 9 Dec 2018 14:26:06 +0000
Message-ID: <1544365552-30270-2-git-send-email-abel.vesa@nxp.com>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3910;6:e1L7V8Vl22ReO0iFFiMH1Ry2BRa6ghHtrTEW7fqLO5L7PQzuC040CzEx2CZ1SoAH68CYFgp9F6gmK0VIQQXutOLeww0IlaV5WooI5olj2DrjeRnHL3NqRvkYQn+WASJO4Iet7SmdFtwgOQgZ5jqCM94L2o7a24gdC7RoA+PIZNJw329rYTsHDiO3x5DBfuo7niuYezO2nMjTOCGlSY5S6w0qHPuNo99eT4Fps4PlkuwAKnPHCyx9fXVteCNsBLznO/LgZZwHOz+jyLe0PUa9STqHBXKSnJ0wkJqbcvCFqAgbEhEicQMyKHfF5/+OrgSoS7Xjel5xwPkmB9nW8M31Rob0gAACWK4oPABarNPNWhUUk4W+5PKKaF4OxEnf+3kr3N0zXxIhsutJPmlfmI0zFaRRzmsx2UVvq8laGB01mC/xytEOv3mAc53g60zVia69U/IBIc7uHJx6ESBkLlkxGw==;5:dfCrL8I3B+uzai4R5lnBl+U3wwhqQ3Oxd/JcF007ZP2W1KwgX+ysxSyKbvhgWqnow2qIKgsZs0SHfXKYPjHpsWoVX0lgamiqoLq9LQ/gvK+SyJnGAjxW2W5Bzi6gFENZQ+Mb/3YKbDz+X0RrC9iL2IisoV5aer9hMUKih7A575I=;7:uLlnOG8SQFkIv7cC7wHKDvAQc+ymql0itNhMHEd207Nu2uL9FvjS5rTDjf1MlOCEAHIKzm4TWah9ALYcnyz5u6FPS+peJO7z31im86WcPy8V/98Kla5bQUqogEw0/npMdm4KyhyaR1QIkfCD4l7oHw==
x-ms-office365-filtering-correlation-id: 3ad8528a-5020-4002-f9ec-08d65de24144
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3910;
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-microsoft-antispam-prvs: <AM6PR0402MB3910066636EF8D9EB147113CF6A40@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3910;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3910;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(26005)(446003)(5660300001)(25786009)(11346002)(71190400001)(2906002)(106356001)(105586002)(54906003)(3846002)(7736002)(44832011)(305945005)(2501003)(6116002)(476003)(486006)(2616005)(66066001)(97736004)(8676002)(4326008)(53936002)(99286004)(6436002)(81166006)(110136005)(6486002)(186003)(81156014)(68736007)(6512007)(386003)(6506007)(478600001)(86362001)(256004)(14454004)(36756003)(76176011)(71200400001)(102836004)(8936002)(52116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3910;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6fn+8CIr3vh26v09rvzZporHeXpP53Wr3shRE5YYr7znl2zNzKgTSQaEdbABpw9Wop8TRCp9oluupP4CwYExytSKbOdLPAPqafJCLnNIkPypdrPB2xPLd15hIWyWPzxzhbd9NveRZi9v4urFWfPe/YsAPq7Y4oWzTWhjoQxdV9SzJACIHZkBxvVla/E6db1I0or6yb4EaAx+GmSdku/SsFrev46jcQSerJlZMr6JxFsheLHHjpbh5IBZvQajhrgrzgn3dizEh+HRe1vCncPxz4E8ij1cIWNp8ZMZVj2iHvb2GK/f8D6U4yCSOrgO+cl5kWkQeDSGXhMfIjaSCRhzivCuA5Qinu/LI2/EogwOv9I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad8528a-5020-4002-f9ec-08d65de24144
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 14:26:06.1677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Add basic Kconfig symbols to make the MXC architecture available
in the ARM64 world.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 28f0521..7e1545a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -142,6 +142,20 @@ config ARCH_MVEBU
 	   - Armada 7K SoC Family
 	   - Armada 8K SoC Family
=20
+config ARCH_MXC
+	bool "ARMv8 based NXP i.MX SoC family"
+	help
+	  This enables support for the ARMv8 based SoCs in the
+	  NXP i.MX family.
+
+config SOC_IMX8MQ
+	bool "i.MX8MQ support"
+	depends on ARCH_MXC
+	select ARM64_ERRATUM_843419
+	select ARM64_ERRATUM_845719
+	help
+	  This enables support for the i.MX8MQ SoC.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
--=20
2.7.4

