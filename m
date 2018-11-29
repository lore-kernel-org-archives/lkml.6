Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C872C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BBB20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZtJ94zPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BBB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeK2Mya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:54:30 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:4690
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbeK2My3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdDfCQ2r0j67Xj2S1vORj+giQEEmWetoQ7SUIpLLuOQ=;
 b=ZtJ94zPqMTZpHjwkcCwNw0egKPefuxo20PGXOTMy6umZHMFqEWTS3D8FBEvtJTZzoFZdJUZnehIIzVCdrwZ8ij/nfJUpErBprhum4UyK/Sq3QVXBobr/l2hJjktFXflW9nfBDU1iIz+i/peAeA+hrO1B5tU0eUhQWdsb9xEPWjk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3930.eurprd04.prod.outlook.com (52.134.71.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Thu, 29 Nov 2018 01:50:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 01:50:04 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 1/4] dt-bindings: fsl: scu: add rtc binding
Thread-Topic: [PATCH V4 1/4] dt-bindings: fsl: scu: add rtc binding
Thread-Index: AQHUh4XZ8fx1c9h3Q0647uaPvvX+hg==
Date:   Thu, 29 Nov 2018 01:50:04 +0000
Message-ID: <1543455856-18021-2-git-send-email-Anson.Huang@nxp.com>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3930;6:izO1XCXKum1diN+IXYlinXXOcEJFr1WjhxwZnypuajtpmOR9ucXO3mc5VwcXSvOZ7UwXUfmwJyF7o+0OqdFHu6mk3j312RQ//9SXWmbPqI4JXtGoaHXYuxdZaJnV22ihfbchwtiGMsYzoD7SmNB6GKCivpR9IRmZ3dGjcIeEYXPFVD1/A92cnXn2sTp4jvGyWoFhu/TsiaLDCrRdKXtTywMw6+eVZDCSfO0303PwAYl1CDZ4qAFvfKJ8s2ZUrmGW0dbl+drMeMJuLxzC96oyERg7M7a1hliLy25C9f+abTKjxtu5gVtJM0/2fgjj5q6U/WT+/lSZ3MEiEeutPbzCv9muQA3o2iwx6mb2K4EKW4Pm1l21A0dHGU3MZZAXgJezbrmnOxrlpCA+spf0/7SOGcnXFa80Q8tqFNQ5o/V4gttESyJn+TCo2qvTuqBcWyWHfGLE/P+XmHOR6QBrf5iTAA==;5:g7sv5nrRBOC1yY4PkDrKtZ0QsZZJtT1zbmw5IQADj9fGZJf1dx0TyI+q20LmJPuB2CMzleYWgzFrzSHfCjMTPGUB0TnA91k40RanR00m2ETj3hYC/Lt4OBTjcBW0/8n7t1pBfhkUeuW7b4mS/B44oYrjfz0uCorROwtkgUu2cl8=;7:LS2e31p3zvcePwgbPRO2bR2XSmk8s9vUPppWGn7u1JTn0L98uo6j4Y7vPplDgh1/G/8oq+kZi75JodS9UWhetTqP1n/Y264jYyujCdRvyGU9Qm978ENQ9IPGam+BVT1dFoFceAKOl+sktr8t6zGSYg==
x-ms-office365-filtering-correlation-id: a87a7478-1e2d-4c47-9678-08d6559cfba6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3930;
x-ms-traffictypediagnostic: DB3PR0402MB3930:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB393001F759614966ECB78F76F5D20@DB3PR0402MB3930.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3930;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3930;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(366004)(54534003)(189003)(199004)(110136005)(2501003)(316002)(3846002)(6116002)(52116002)(7416002)(71200400001)(305945005)(76176011)(478600001)(25786009)(6512007)(53936002)(7736002)(14454004)(99286004)(36756003)(5660300001)(97736004)(4326008)(446003)(86362001)(81156014)(6506007)(81166006)(102836004)(8676002)(2201001)(68736007)(6436002)(6486002)(50226002)(11346002)(386003)(2906002)(105586002)(186003)(106356001)(2616005)(26005)(256004)(8936002)(476003)(66066001)(71190400001)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3930;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pN328h+oIlNJjVP7pSdv++6jFYj2XQJAEEkw9ssDJAF48b6qDHX6PSCqiyUc7KlRBp05u6NJC+rquv2+WSxO24TCSs6cBHhmVgxqoRQKLJI0ntF7mID0jfGVmOSLJ71uCt4b2gVofWg0RFAHMWTfYJIoMS23UDgx0WIUwfqOYentW4k2sEAHBlewO91teCt0iqxmHR2HwtJ0LXCKW1gv49RVTnpxt+pYeJ73yeaKrH+ShebQcMtCSwXiu+WS9Me3iXqfjYl47bL57XOh1K7o9sQ+WpLUN+GBSOdvmqWNI7H0qaQkk6Xrg+iGbh4/NfCaLHIj8eCeFveFkPwbeyFZ9DYRS5ZQoPYTQMdzZxGExS0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87a7478-1e2d-4c47-9678-08d6559cfba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 01:50:04.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and secure RTC etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to do RTC operation, this patch adds binding doc for i.MX
system controller RTC driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog:
V3->V4:
  *move rtc binding doc to scu binding doc since it is belonging to SCU.
  *change compatible name to start with "fsl" instead of "nxp" to align wit=
h other nodes in dtsi.
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 +++++++++=
+
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index c20f38e..3f3d697 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -106,6 +106,12 @@ Required properties for Pinctrl sub nodes:
 [2] Documentation/devicetree/bindings/power/power_domain.txt
 [3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
=20
+RTC bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible: should be "fsl,imx8qxp-sc-rtc";
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -148,6 +154,10 @@ firmware {
 			compatible =3D "fsl,imx8qxp-scu-pd";
 			#power-domain-cells =3D <1>;
 		};
+
+		rtc: rtc {
+			compatible =3D "fsl,imx8qxp-sc-rtc";
+		};
 	};
 };
=20
--=20
2.7.4

