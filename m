Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4565420832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CThj9XCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4565420832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeK2MyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:54:09 -0500
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:22400
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbeK2MyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNs0oO6DVJL8I0W9TTH17hc1AdXCmbUTcAzEnfIisjo=;
 b=CThj9XCEVHFK08YNAxydUvuKe/7d7VeSXBUburHqNjRpVeEqKy9N0jAX9qcHOKB/GOrtadH/ibt+FyZZFza7mMRvJ0+kwlWlACJU+AudkRZUsmtGpCyJNJ57WimaP6h7QNXJlHOiuholpCnfGT8yoJeBwh+afIvMTmsZOzbrzeI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 29 Nov 2018 01:50:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 01:50:26 +0000
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
Subject: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Topic: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP system controller
 RTC support
Thread-Index: AQHUh4XmG/9MG2NNlEeSqGLsLt5VQA==
Date:   Thu, 29 Nov 2018 01:50:26 +0000
Message-ID: <1543455856-18021-5-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3739;6:CTH5wzOnCiMOyKzvYVqliDvR21qmC6rLgOsbYRcIabJKtnCtvWXpwyLt3hxwImx5BHfODnEUgRtmBOil9DjXkUoNjJk61S7M4lkS3IDMYISdH0+FMl57FW3xCvZPK1HBT3Sr08ogOw/Ev441v6qUpt9aHPXFTm5E9lolvtzGa9+7Yx8MH8u/7cYk3RY+GSA8ewZkpPBThy9VgA10jFRUDfdpSmG97MoagJHGjAZB5Dd3Ib1aMblo1c6dXhEJ9FV73qqawM4q1pRvTq19ktQ3cHMaExk9nKpSBmfMNou8QwrlCBw9RQtct5qMqYf08y8Juyat4vjUITJ4BC2YqCeKk/eTl7vi3PVFaLmYI9Hp63LGNDmyLP60SOHBhtf6/N+LD6Pz0IKpWkloM1GymPQU6oiJT0i+RoI3z1gKkYn+ypoo5AWMFKeoW0gqoFmEuYb8ENKcri5AxIjy4FoReY+D2A==;5:a1gol5oC1XafGg8c5xILD0LovlNdyFsZ3SlnhJavZrtrakkUqmLzsXEs1Nkeh8nlsO7VxSzp1UjdSCPzg6zmfo7j+XzUGO/rGagu13p0UfoARwHSzW+c4D3S39HEUh+ikX/VWFmWWcoWdNei2IryNLgrzLHUGIixqQF+KanUfQA=;7:kmJ9yRfQ8RMVHGC/mcAm4MoerYdFH/ah+NhKZsMyPo8VTGQQfg9lpBan2tQHxfMxiZLA3OKR0qMozK5mnLgxbXEr4nH3LcJ1a7cW/nSYoea99INF2rP7TsZdO7pDVpFLPo1VMbGd4PSxsUgjcX5upA==
x-ms-office365-filtering-correlation-id: 019aa5ef-a78e-4df9-8fd4-08d6559d0885
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3739B5053EFEA9EF3E198089F5D20@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231453)(999002)(944501446)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3739;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3739;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(54534003)(189003)(76176011)(6436002)(476003)(4326008)(2501003)(186003)(81156014)(14454004)(8676002)(8936002)(97736004)(81166006)(102836004)(478600001)(2201001)(53936002)(50226002)(52116002)(86362001)(2616005)(486006)(7736002)(7416002)(3846002)(316002)(71190400001)(446003)(25786009)(106356001)(5660300001)(386003)(6486002)(105586002)(6116002)(110136005)(6506007)(26005)(11346002)(2906002)(305945005)(99286004)(66066001)(6512007)(256004)(68736007)(71200400001)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1+I+/JtfJKR19O5EONXSbenCrjUKg1KpAFIMHjswDU3gBOHI4x9peHCwWrtS0qkiGPNr7ogeSj4riC8dNBHRLvSTVwtc0fa0o21Dkvd+t7jQNSWf6bg3SqbBVzRxysiOkrCozBspIc/OVNiUUtJg75SaAaSBA6e1enn1TvAsI/VISi8R3b5Ne+22T1hY4LXbkE1vHqDkLS3mmTdCheZfrP6MNMr6PMWNA2oPuOezzJ6y2skvkJlsWsAmMYgkJ+AS7EEGJkjU6TZz2OVwtO4CInrwX1ja/G5iRg3BNQWvmBve9awjCyEZ0iLegLDraa1kLlXuPDDq5BlLNaPEea1KdrnjPDRSK4+VBW0x6IbbYzQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019aa5ef-a78e-4df9-8fd4-08d6559d0885
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 01:50:26.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP system controller RTC support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog:
V3->V4:
  *move sc rtc to inside of SCU node.
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 9155d45..b38730a 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -84,6 +84,10 @@
 			compatible =3D "fsl,imx8qxp-scu-pd";
 			#power-domain-cells =3D <1>;
 		};
+
+		rtc: rtc {
+			compatible =3D "fsl,imx8qxp-sc-rtc";
+		};
 	};
=20
 	tsens: thermal-sensor {
--=20
2.7.4

