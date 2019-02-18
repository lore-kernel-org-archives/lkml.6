Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31AC217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RHOecRwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfBRGyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:54:31 -0500
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:9136
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728590AbfBRGy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCNTAynTg2q8AA2gyzNGQFEWGQmH01CDoDn7y9XG2L8=;
 b=RHOecRwIynovovZWkjo+kqk1OSDuh/MiG0M70Qvw7K62iTP+zdMAf7O/J93VVV8vDVi5O993S/HylmvMPuAcDcE10mCr1FFyLGa4BjqWAEaoqgvCq0xmJb1pLlbJhp4x9ptYfpDNjp8LvUfw+Hp3H5uwsKa6nhgEL6nVuWGIS+g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:53:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:53:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog
 binding
Thread-Index: AQHUx1azBL+yCPCH8ke6RA/LaBE/tA==
Date:   Mon, 18 Feb 2019 06:53:48 +0000
Message-ID: <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0850e54c-5c38-476e-5fbb-08d6956dd56a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:6y/u9uVkL4q68838GB376I9nX+cVMi4gG6YC2?=
 =?iso-8859-1?Q?cy/fWQcsLeH36tROtwkg60xN8OmhRNtJn+T/GDLFlppU1wVTw4ExlWjbzj?=
 =?iso-8859-1?Q?yJh8sNk0jgr+tzdP7l6XQNLsSBa/Nj0fapgvNalye/YtNA/vrP/Mb65xyM?=
 =?iso-8859-1?Q?dw8RZSwKqz6xD/PdRbQEERbqK0oYuePS0AsWSdwiGu1R18flJsFHzkEMKV?=
 =?iso-8859-1?Q?eQCaur0ZAY5NkaEXzF3oORBitEIar4BmIf5hyLIMUwWV27imhaBV7oMTPn?=
 =?iso-8859-1?Q?Kkrm+FSEzokCiRHhLsbAP8WH1DTy7b5k3+h5CLqSF3BfIom2nZoRQUEIdg?=
 =?iso-8859-1?Q?Z/QnzP33RC76l3RjKfBXA9xU0ROkuFGQmvbZpQODvEh8EF9+sdvHt69Rt2?=
 =?iso-8859-1?Q?RhsVM+q9iq37GRsMvC3/NKgJ29kzKjTeXatMIFasxn3gMuhNb07eDiTLDR?=
 =?iso-8859-1?Q?gxZS/CR8Zo2yEMyWGi8ILay2ay9LCy44d3ZIhKVGwjpLZvQWuF3ruWA/QG?=
 =?iso-8859-1?Q?cKXVCqqnla6vGZpgxfsmzQwAUCxdhUW3qeMtYF1bzqDXYkENmPO3KuQsvH?=
 =?iso-8859-1?Q?IKsRHf5vfdXZSJSS7hkOmVVZERJ5sg2Wh7klHCw0l+XjNkcZTl9b4Cqu2j?=
 =?iso-8859-1?Q?Gib6PWFlDMMTW7dIRliQdqCBWfUBDRYBr08aCHKEquuxBWj6Qa3p4Cdn1R?=
 =?iso-8859-1?Q?7NFze3mDIFP+vaqzl+IN+7Fw13hZRxAN2PwZTV+9dIhL3iORH3CgPYAMJ6?=
 =?iso-8859-1?Q?d+VOj4KCCoqsoGvfTGFex5m1QSI9200Kdm8+C9HLjjRn4fSqB2zjQtVPGT?=
 =?iso-8859-1?Q?oKgfjpDQaI1KBOMHLmKpd7YHFmZkMZHBCgxi5r1PP3wxEHHJkSPn3LqjIl?=
 =?iso-8859-1?Q?MLlmqBHje2aOtIlGb2H/QPRUG4I94kkccpmw4Uru2DeEvevYkTA6VcOc1p?=
 =?iso-8859-1?Q?UJkwba3A+gZKVDPaWiSr6iXBtxf1wLb1W+SpBz9+0u0ELOfnxEZJ8xtKLZ?=
 =?iso-8859-1?Q?vkcZTtuaDUsDiVJl8TmM5EVmdlNhKmR+otoiSV0+XcMO7SyVJ0TIxnG+Q+?=
 =?iso-8859-1?Q?FWNxn6wt5ez0H9QECEsCromUeWa6w0VkOo8uM5oc6rZ+Xu/5+EaE94Sj2a?=
 =?iso-8859-1?Q?PkLitwXj8fPTzZGyrpUJ/JFWZHKLiNafj1BiK7b2utQWL9okETdQhr93sY?=
 =?iso-8859-1?Q?pOvRrAdRRo1e+3ooDJIARg+q5SrK7FsJUlm86faUD9wRC5k367NfLloWD4?=
 =?iso-8859-1?Q?Da5eWtSl5ml6tQWjarHmKgwryBuQW1R7xksB9mBXbqd9d5kdo1E0rfok8J?=
 =?iso-8859-1?Q?uWgQ1h81aJ8o1Y6mkXYGwFahi6AafYViS4dkS4hnbTQMzUg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37070F694B18B03960D44C26F5630@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(305945005)(71200400001)(71190400001)(217873002)(256004)(76176011)(5660300002)(14444005)(105586002)(4326008)(7736002)(25786009)(476003)(2616005)(106356001)(53936002)(8676002)(11346002)(7416002)(316002)(110136005)(66066001)(2501003)(446003)(486006)(6116002)(3846002)(86362001)(81166006)(6436002)(8936002)(68736007)(81156014)(2201001)(6512007)(50226002)(102836004)(2906002)(6486002)(26005)(478600001)(36756003)(97736004)(386003)(6506007)(52116002)(186003)(14454004)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BRRBhFeOLuZms7r9HtFn+GWelMVt2obVZi1OiGnuGDP8yY378I19F227WigDiAcP3DDCCNYQdy02Vp7j8Ocnui99CFAEHBEhIXOXFEre8HEq1qlUGRYWChJhCfXbuROxr/zVEu1CnsetjGgMYHJdX1R7/BxkOBSekQ4FrdsfASHKg4x1RR7NbActB64MOsmX6Q2zVy9dkvJvyzZ4eiVPOFXPYeIdAfX6NbCWf+e4dpinPRZc2th13/h/wy8/QZnBtqSEqZTQbSTjJ/RahCX5RSj/xhrwLC3ECEC9AYtj1OXAJoVhZY+vx+lvmh5JtDbfBo8OWQfvfKqIEV989D+hbY9Zim1BJyQDif1JVsWeMw3GUxWk+w1evSbe1wScNzzW7RGK5jozWrEOMQnDdBjNfVEpmmHWQ+2IYDo1kM9DKF8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0850e54c-5c38-476e-5fbb-08d6956dd56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:53:39.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP system controller watchdog binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- update dts node name to "watchdog";
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 +++++++++=
+
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 4b79751..f388ec6 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -136,6 +136,12 @@ Required properties:
 			   resource id for thermal driver to get temperature via
 			   SCU IPC.
=20
+Watchdog bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible: should be "fsl,imx8qxp-sc-wdt";
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -188,6 +194,10 @@ firmware {
 			tsens-num =3D <1>;
 			#thermal-sensor-cells =3D <1>;
 		};
+
+		watchdog: watchdog {
+			compatible =3D "fsl,imx8qxp-sc-wdt";
+		};
 	};
 };
=20
--=20
2.7.4

