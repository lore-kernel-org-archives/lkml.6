Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41EFC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886E1207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wmKll0tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886E1207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeJWNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:53:18 -0400
Received: from mail-ve1eur01on0087.outbound.protection.outlook.com ([104.47.1.87]:16832
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726764AbeJWNxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF9D4CkRgtvTARGP6qSJKY4HDzD4As5FuBYxgca8EF4=;
 b=wmKll0txq7W7UMUaeLZziUv/63YdnSb9xaPVxgWccHcsTpzorwQqVihY974t9y5vanKtReb/Mnf8DO++nqrT3jmVmcNWGfE1ijyjIbxbnhh91oBn21c4wU3xGcySYWAEoZqJSMissc6IY81F5gH99JxYbmjLrTNRyNeiaaO6NFc=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4794.eurprd04.prod.outlook.com (20.176.233.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 05:31:27 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 05:31:27 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V1 4/4] ARM: dts: imx7s: Add flexcan stop mode wakeup support
Thread-Topic: [PATCH V1 4/4] ARM: dts: imx7s: Add flexcan stop mode wakeup
 support
Thread-Index: AQHUapGl+6L9HzbtLkyRfB+dw/oQkw==
Date:   Tue, 23 Oct 2018 05:31:27 +0000
Message-ID: <20181023052831.2553-5-qiangqing.zhang@nxp.com>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4794;6:jo2QVP+OQJgNcpHIWdoZaFXjzV5rmvp3wELjEkY+DXVfYaCEi9LRf2lkuii0Zyfewhs+PRKt+yef3Cp2AjhZtypOwsO5wNI3+fp6kDu3hQsoXWTh8cRTJ54I7X5w8pOh2ckRFw6VmGLpaZb0n5yaY2OgHQFq/Acmgyud33FRGwWGpxE6X9a+2yM+AwPK0CTUhY8oqL42RQO98oNipjzXi5SuT0dmdz3Fc2DXbjdcdRyRkm1yOc7OgNpGgyX+LggrCj4LVAQjccIqkPAPjF69Y9mKYt+1qMC7kTA2UbKjKwNJa4GPDBKot+eyRMEOIm6lBfMo0HOlJwCUgm2BR6/MrBFc4J2qnfUgtU+OZkqci0+XYAOJjjeIr+WhCCxYHiYuoJ9V2/N2AxbIXseyi9o6ll/U4G0tu7hvyjNuaEwYCK1r9LXT2wlAMCI49NrcDddasFrVC/AWlqt2+gISqTBikQ==;5:T26Ka1m3LacncUboriZEEuL40vSbvKf6UxtF3kSw+G4ae5bzdmmL/Q1oMtIDYRU9bt78gOfBdSDlUQvjJiTRcOIezLe3YZh8N2QTGMAnMi/K9ZZxnLkN0fTlT2GlAkeGiGL1DbmxFi9duATYRyBKW1S9TQ39Wt5Z4N2C4iwbNLw=;7:vgkWh8jxtWPkZTGYw7a1NRsMcKlmxi2EObib4heTr+miQsSVCQdBgFAPQNzEqn9mF6VyiIqBexcA6ju0/SUBoCA0U8Gn6DNwcGseUEyB0qfL6C3Ax4nDdOiWhL2xSROBQdQTmd0BYmcKxR4V5V0bQQDVt8PBqnFmgmsu4k+BGCwtg1f82oAyjWPk6ieWEr1aBhCf5mBRyuKV6b7ZM3/EIfko+027lU+JSreGoM4pW8ub1YvLXE5Y06raca+x9XK/
x-ms-office365-filtering-correlation-id: 20833da8-a79f-4e8d-02ea-08d638a8c759
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4794;
x-ms-traffictypediagnostic: DB7PR04MB4794:
x-microsoft-antispam-prvs: <DB7PR04MB4794A139B16451DC2C1A3952E6F50@DB7PR04MB4794.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4794;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4794;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(81166006)(26005)(8936002)(6436002)(446003)(11346002)(25786009)(2906002)(8676002)(305945005)(7736002)(81156014)(476003)(6116002)(2616005)(3846002)(53936002)(256004)(5660300001)(102836004)(6512007)(6486002)(14444005)(50226002)(71190400001)(186003)(4326008)(52116002)(1076002)(86362001)(71200400001)(486006)(478600001)(14454004)(68736007)(6506007)(2900100001)(76176011)(97736004)(386003)(99286004)(36756003)(316002)(5250100002)(54906003)(2501003)(66066001)(110136005)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4794;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UuYUDVWyIqjPIJ92479I2mMdBTm27HJCu5AUwIhkLzQsn1QH1JGefyVNWriOU3XzQQ13+c3bPsA7WGPM7xywkSmo1dGN7tYJu+pedrm6DApwKFKsNffddGJVCzHHh+Hg0aYWnGGit62cVynGJA7LUz8EIGfpCE5M+Cpc549wskTbSn5//giOYI9pljqlh8iNbyUqHYU2gG7gKKCzPCF5ZlDM5+WuLiTA4TgK6l0BVRdopYGpj2XrjtFlD7Orh70KA37yWnK2syiIkU3yE5IW/XyrpNDX7XBhtgX7YwUzjK57NDXb5sfzHgM/ha6+3CNn2813qfQ2NMgyKkH78rMVVRr1hj8jPTl12X2Yey6aqng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20833da8-a79f-4e8d-02ea-08d638a8c759
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 05:31:27.3570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a052198f6e96..382f1e1a92e3 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -877,6 +877,7 @@
 				clocks =3D <&clks IMX7D_CLK_DUMMY>,
 					<&clks IMX7D_CAN1_ROOT_CLK>;
 				clock-names =3D "ipg", "per";
+				stop-mode =3D <&gpr 0x10 1 0x10 17>;
 				status =3D "disabled";
 			};
=20
@@ -887,6 +888,7 @@
 				clocks =3D <&clks IMX7D_CLK_DUMMY>,
 					<&clks IMX7D_CAN2_ROOT_CLK>;
 				clock-names =3D "ipg", "per";
+				stop-mode =3D <&gpr 0x10 2 0x10 18>;
 				status =3D "disabled";
 			};
=20
--=20
2.17.1

