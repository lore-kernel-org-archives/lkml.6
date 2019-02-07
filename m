Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20165C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCC520821
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RmOpGyXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBGPSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:18:43 -0500
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:57358
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfBGPSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSFn8cdpt1eoAnepnuJm0hYlJEQgbR1zqZIjUDVZJnc=;
 b=RmOpGyXznFe5ZijpIqbB4li9xzIQEAxDpsypxCqrAGnozjysTpQcW63hHggpKjTpyMX/k3wWgmmEOSzD4vmdFauuZf6i1PtUSJYaUmEcC/MArtwouKxxYzASCSMR2a4ueuJ71Nl6dPwEIlFdeFAUR+1YGl4iXzRxqVJ+kuKWbKk=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3846.eurprd04.prod.outlook.com (52.133.29.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 15:18:38 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:18:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/4] ARM: dts: imx6qdl-sabresd: add regulators control for
 mma8451 sensor
Thread-Topic: [PATCH 3/4] ARM: dts: imx6qdl-sabresd: add regulators control
 for mma8451 sensor
Thread-Index: AQHUvvhmt2fh6/DLD0uLoYNB/nAPdQ==
Date:   Thu, 7 Feb 2019 15:18:38 +0000
Message-ID: <1549552397-22798-3-git-send-email-Anson.Huang@nxp.com>
References: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3846;6:BrMxQCBAf4IDUS8FUuWuMJB/yOPSGjlr+AGEduJWpYF7nTnl+V4sdA3X/JT83+TDYGmesATG7irMjMjFk/eET6eIiN6gGQg0Mx2IjWVgnxaGnFjGYRiA/ZvMBFyAnr7Dyu+oL/q6G2Z29ZUfJ/b0bK1OontFDLIIxWxjilK0gMRopCo2upcby9KHKYqznL1DcSEIGOdcCJmpqDDIRMlkqWJL8NsixsR29xo91W5uS51wRBlfp8Tg4KXyTenTPx6s10eGaTcdy7YNzTwApzxZ0NN3A7FuvM0+FZ4ltHS5SFPDE6h01HLpBz3ttSbcX8V2D2i+4qSy5hl+77baswopSAbtWpodrMc8+1O+Y3hgO4vS5u1+iaQ3asqGqjCcGxnwwvpFbND0vVsdrkt26kLFNbMHK3fSSXsLJ7V3NcvhbSQDOHit2UtZZWOSGN6Xfi/6WgGufNeZqZ1eqfOQSyGzNw==;5:8DAWDNhA878vTpqaLXBBrCGECzx+FMEXTk/dwmM6BXkFtbuOYvjdtr3AEeXe1ZXXzgYE5s/sLtPnCWKwB+iHoIYHBmkPRzlbLe+fVmz472h3XaW+y+NkMVMi508t/IUoyp+2uvPC4wdWOEyZl0WH8mCiCUSzL6IBRmsGSshxOVUM6rqe8TtTalt/ZilTV40vtPtuWk0Bet6mZaX12uBbxw==;7:JN8cnzhu0f+iNdgenzSTjk6Ar2ap8PbxtjM2Oo+iWT4y5avLf5MVa1gFXQrd5fWFMPiWaYVJiFpGqVOVEbxJbSmN7MswE75cfVyD0jroL4BpAaZjo3AOI+eYO5POCND7GFUGyEi2j9F/wlIMMTHCuA==
x-ms-office365-filtering-correlation-id: 564023e1-542c-4e21-dd58-08d68d0f88c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3846;
x-ms-traffictypediagnostic: AM6PR0402MB3846:
x-microsoft-antispam-prvs: <AM6PR0402MB38467F5D70758CBB77006564F5680@AM6PR0402MB3846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(2616005)(476003)(6486002)(86362001)(11346002)(446003)(2501003)(110136005)(2201001)(76176011)(52116002)(486006)(81156014)(26005)(81166006)(186003)(8676002)(6512007)(256004)(4744005)(7736002)(305945005)(68736007)(316002)(386003)(8936002)(102836004)(478600001)(71190400001)(6436002)(6116002)(71200400001)(6506007)(50226002)(3846002)(4326008)(36756003)(105586002)(25786009)(14454004)(2906002)(106356001)(66066001)(53936002)(99286004)(97736004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3846;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8jQLAs/L/da24GOypPGMZ1rt5DKYFoS8zw7ra31gVaI5f5s2nzY+1xCsSyVDlC2dXAG/u+kf/tPbJomEHan9qfu1OKX9rKexWYkcGHSw3JHUiHkusDtpnl7gMcp9OBnK64idWRMxgUkodj5BH6rHKlFbwHGvjnAWhXKY0o6kqa+y948CZ9fauWD+V1RQ4SF2wL339uE4ykz+BAX5Eg0N37RmhrQB2DYb1bubkitTyB07AZ+KFolazWoQUpEYfPIrD5DUE6pthX4tKVSeiyxaKvF+L/IA8xTEBIllAbSW4f3GKAbWpeYakseMrFjeDeRjpVOSDijJsEXYscAB6HAazMGY4iyIrXHIqiBUlEPVXI3rDb9wbYHzNi8tnfGBWnlTDIbIJ1fE9Ysmsoy5HvOjsaOwffGdN4LcCzvvrI/V7Zk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564023e1-542c-4e21-dd58-08d68d0f88c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:18:34.6656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mma8451 sensor driver has supported regulators control,
assign the power supplies for mma8451 to enable the control.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index 618f186a..80b9901 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -250,6 +250,8 @@
 		pinctrl-0 =3D <&pinctrl_i2c1_mma8451_int>;
 		interrupt-parent =3D <&gpio1>;
 		interrupts =3D <18 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply =3D <&reg_sensors>;
+		vddio-supply =3D <&reg_sensors>;
 	};
=20
 	ov5642: camera@3c {
--=20
2.7.4

