Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624F6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2264A20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QzF94q/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2264A20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbeK0UjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:39:09 -0500
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:20637
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbeK0UjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+LW7ftGb2CSL+nlzNKv0RCcNpyo9t89/uqe822TvO4=;
 b=QzF94q/b7908WByH8joCfuLc7uQ/msgb2fNXYTN6lXwG4OXzGhI9zNc9ArIWrbonDrbSuo0PElwQ64rLHcfjwGhaPOq9X6fFzcKIjk72CuUCwz0z0gfrW2NP6Ig2sXVt+yDD8w1Bp+WbrtT8IpM3WBwoupnDuCsOBDBA4UucUng=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.38; Tue, 27 Nov 2018 09:41:46 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 09:41:46 +0000
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
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Topic: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Index: AQHUhjVp2fzkoSnTjEGBUoXMaMsjHw==
Date:   Tue, 27 Nov 2018 09:41:46 +0000
Message-ID: <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3850;6:TRaOzRBCKbs7WpLzwDKq2+xq8jfqNuzO1iVQpxaIt9WGlP9sd0CGMARlJ7UumWN5Ie4KrK5esacgZMmjgBghUKyYiwkUPjSycSP3NX80FzEHaWi0oEtbxiVRR0DeIMWT7wp5TKs42ABjEYmW/razLnevLIcM44hNwcWJ6PKXavDzmSfg1+k0N9iFFYeSWVNHRpinJPwO4iDfMwMlClLMr/q2W1WkqmHHpbORjeAFRdjVVa8GUw/7wESV1y7CDm8rOTM3LY5J6hARH06HxSzSMlCF0bPHK01O2OMJ4Ehb5EaORZP73CoZ0qpsHiE6YQE77Fzdz/zbHLrN3LvOvLm2aAYDiGqyLLD4Go5Cfwr8q7tUjt+CacACo9RoTcW7qhugPASygfdf75lCb4NibpGfPvJ01A3NXJd0z/AmDB40baH1TgoQBmRuUmPi2w+lQWEHADzjoejT8WAqxoHcQcK1yA==;5:Nws1ZOPxAKPW8ENYfw9DAQ05Gt0c/12j7/BsTMpCI3sCytBd4JguicwktdPN7WgMFIvOfYURfnouXhQ+BIDC7AtpGYXMcJ5ei2oDGYFOsSgxtIGb7/GEFdiVlmw2u3jHCrmrEfEfXbs5/FjIrI8HD5QYIDnFAv7U4OQ7nhuOOh0=;7:7kKKn8FRZtcwyKg3HzL1SOPVtZCu7ENAFdEF2/PDT0Ws9PwHQn6gSarPp+2tZi2mKAS9Jz0QLab/F15yAd7BLMpGie3I8DVh63KOPLlAjkmg3zofpi3oQSYl1o8ouVyIWlvkejCfwglYeBZpUELz6A==
x-ms-office365-filtering-correlation-id: c2e6ab3e-e82a-45d4-6649-08d6544c8b96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3850891B6366899790B08A68F5D00@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3850;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3850;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(7416002)(8936002)(81156014)(81166006)(6486002)(4326008)(50226002)(8676002)(68736007)(105586002)(26005)(76176011)(106356001)(186003)(478600001)(53936002)(486006)(256004)(316002)(25786009)(6436002)(2616005)(446003)(36756003)(6512007)(71200400001)(71190400001)(97736004)(476003)(6116002)(305945005)(99286004)(5660300001)(11346002)(3846002)(2906002)(102836004)(2201001)(66066001)(386003)(6506007)(14454004)(7736002)(110136005)(86362001)(52116002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WMBngHI1YgjyyMkL62HOnkhU/y4zA4Z0sSsVmHSIRS9LRCGgGLnriUsecZafz7xc1hkaLgeRDXcAJWTe9rA8F7TXrMkKAdIT25T1uKzTIzwS0Eu8UrdFCbM4aZ9OdLldVX/Q4aBY4yKlPZF3Wl5A3htTyFUJMGIAfwXeS7I3ruH3w+OlnqukstL+NEmiXh88k+FxgjoHMjZDHo47eM0Z/80kTJhH3Ppm9UKHN/Nl0V6i3+iC4EGEqtVulU6z/IstP3ZeEQ9nwnh3TDmi8nK9/C9HsVOE9bNyarQ0W2mnTcg81ti4m3lkn0qsjaiEX2uWodDG2Pa4Zwb5kaqf7xhljdcCmGeRY/YTSD57W3W2EcA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e6ab3e-e82a-45d4-6649-08d6544c8b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 09:41:46.0328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP system controller RTC support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 9155d45..ef57db6 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -433,4 +433,8 @@
 		#size-cells =3D <1>;
 		ranges =3D <0x5f000000 0x0 0x5f000000 0x1000000>;
 	};
+
+	rtc: rtc {
+		compatible =3D "nxp,imx8qxp-sc-rtc";
+	};
 };
--=20
2.7.4

