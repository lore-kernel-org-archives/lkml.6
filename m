Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7744CC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38250207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IGaPIEqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbfBMDJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:09:03 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:35136
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729210AbfBMDJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hadABVmIenAV+K4vIKEUEa78OqsP9peJGF1D2CDyp8=;
 b=IGaPIEqDPRZBTJyVqiP03OMNq5ZoCVa9Wal4nyHoFrZlI06WPGnTlXK2i3U4dkAPbmdKgLGwk4EB78UxCGJOdxtH9au8uhhf3zlil/1c2sswxKOhswNdIPedGozizpGCdHt7z23eqIDAuYLm23wsqstjs3q+IuEsH/fiUZ3Faw4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 03:08:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 03:08:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH 1/3] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUw0l12uqkL+fgkEG7l0YedIa+eQ==
Date:   Wed, 13 Feb 2019 03:08:57 +0000
Message-ID: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0150.apcprd02.prod.outlook.com
 (2603:1096:202:16::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3724;6:zzCViibVj+AhkDg2jsl+/AZS6YPZFrJOrCypKpwsyHhanoe/EpQEX6tLTW/H9FlPwhhY7PA22P3em4DHVX5n8+W14aeRGwRO3KEGqpZxkMZ93SB8EWR3WYgeRF8G5g6B/tuqrXKQfjwxYRukyNpyoRTY8UiS/vRWlIgiO9UBvzXqW1+Uscs0rXXmtVwzZ1qsjO+NRFdJrc4rWmYfNUtqVZmAbh9OXrfuxDlI9D/8pdFI7xC1URX3hH5uau3BWpAALBxz11JZX2TeoM8UsPetUeSJy3p+bRdgTXQ7QTY4jYEhTs5hiHDSpAGwp2hsKTNFnNhf2DOtDpGwiULfVgj/xwBEidRPifPpKQDaWebP2GPSCLXjJ92y2AZgJvDtNIKCkcEXeC43oNwdnarRCWDZ9KTsVqDR1VNoG6qGB+j8dU/HB4FMBA+kK1iIbwIjbnJSAd4OE5TBdrQi5d13zxWqOw==;5:5qwcRVnEmx4XDaGS5HLuYp9RxFeRwT3DSZKbulellllyFsoEigyYMyX2lweQndBjN3vjYveNVgVlW927nNdiY5eTGiExv/BC/+LXTapgxhByVSffS+yJpsYNLlJxeKflWBSIG9kPwJ/HDZ0g5c9l+movoZbOp7MvIHLqmhu69XGF5q2CAhMhmhQNIVw/6r2tmFvGdTGjV4R8m/vYlOdt2g==;7:FEvz7j2rHTfYyckN2emi/6+rp54CCXxHrJtgut4d8qd9gPI9XMhz7/rs2B6paaXZdbiEbz0q7mlyGvEwyAOy0/+ug/zhgsPUxvSJ5kF5ksDZVSB44Jti7LxRUZXxFzHV9LbmGIzDWZ2zjt4Li122lQ==
x-ms-office365-filtering-correlation-id: 22ffc791-f02c-4ca4-db71-08d69160980e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB372438FE6B140B78B4625A48F5660@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(50226002)(97736004)(81166006)(81156014)(8676002)(7736002)(110136005)(305945005)(2906002)(256004)(52116002)(8936002)(476003)(486006)(2616005)(99286004)(3846002)(7416002)(6116002)(71200400001)(71190400001)(86362001)(36756003)(26005)(53936002)(478600001)(68736007)(386003)(2501003)(14454004)(186003)(102836004)(6506007)(2201001)(316002)(66066001)(4326008)(105586002)(6512007)(106356001)(25786009)(6486002)(4744005)(6436002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: agodWra/oj/qDBzTR6IjzZ/bchzWsl90BfIaiMmKpMOVy2JXEb+X2Rc3/KiR4pgIV9QUQkIVCjYFXfJSY5ArxsMSTyODN/G/ii6DSwLNSz6CwhVnS2yvOcjJpYNl85WTDVEhRnUHabKWxUlqpVqJfH+/X4DyCi3G8BYcH8axFvC6FbFnX/o3HfXn0RffUA7/19s5RQ8Iui2FTLICGYVX1066/r/Cx9GfyHwik11QH6o0BYeATwvAxUl1k3Km1DVcF7egZ0yObl1dSFwRJj0lXleddtAffbxKm3I8UYFZNure4nfxguY3tQKP496tVvAb/xUUafXt5wIEWz5V1gAKzVlZdvYfcaqKK0uu9OZyaKRIl2SpsIL2p7oPEBMKdvQ5xYYPY3Rehm0m86voqrK06NNufbY0dyGUb1Ke2UWWeIA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ffc791-f02c-4ca4-db71-08d69160980e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 03:08:49.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU opp table to support cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95..3c27975 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -34,6 +34,14 @@
 			reg =3D <0x0 0x0>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			operating-points =3D <
+			       /* kHz  uV*/
+			       1200000 1100000
+				900000 1000000
+			>;
+			clocks =3D <&clk IMX_A35_CLK>;
+			clock-latency =3D <61036>;
+			#cooling-cells =3D <2>;
 		};
=20
 		A35_1: cpu@1 {
--=20
2.7.4

