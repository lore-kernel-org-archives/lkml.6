Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D66DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150B32081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VYEJU+lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150B32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeK1QVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:21:53 -0500
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:25184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbeK1QVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+LW7ftGb2CSL+nlzNKv0RCcNpyo9t89/uqe822TvO4=;
 b=VYEJU+lIt+273enx0lrtdu/IS3waIYXTOcmpCM60URwr0emae600B/aIpwYo11r0SO5NCFTmX962ZtS2BxxGZqpiT3l4/d++usa/PtrfkoP3cU5U6dCQ3gP9wxc/zpbmrQ6rZ7yT7hTUdrGR8YWn6/H2vCSilhIz1N0qWpCEwf4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 28 Nov 2018 05:21:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 05:21:26 +0000
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
Subject: [PATCH V2 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Topic: [PATCH V2 4/4] ARM64: dts: imx: add i.MX8QXP system controller
 RTC support
Thread-Index: AQHUhto1go5FgMp6TEuaCuGIFJmBqQ==
Date:   Wed, 28 Nov 2018 05:21:26 +0000
Message-ID: <1543382119-2918-5-git-send-email-Anson.Huang@nxp.com>
References: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:hSncdXQa2h2PkHM1gzF+B4koabsK5A+cuXBk/7Wm59v3JQuRXOb2MLPmyClXWPDzY/yIyjPU6PT2dUJxknxfio2dyzGIaBu2KnfpPLnsS9af8s5D00NavU4GmaliVg+y204sF6y5xLrnEOpdPaVSgfmqZBvRJEwKwL9T3qfL1baqpUSepeY9cCKCm+Md6kl+mcu36wE0oMaXkzzgy7KcKwVDpkj7pW/RrU6d+UqLUoGBFFygdvaz0lhf00m6NNvejHi86fWakXrXnPihG08D8XnbZn/hK2s2pV+UltyCH4ip8VffLDUOOiWLl3dAWiTZFxFP5oeyygKT0n9eraMxo+LS36e8IvrvvNsWXzHJeMAWVHxIsjpfoy6mVQttkPMeg+G/C77lSol7VcjLvpM7jX7RVToza4IarX4h9S0GZ+upHltJT2r7MbMVKMqpZamKhOmfV7gtUumDAgyP+gmEng==;5:pM+GUZsVN2EEahrG8Qqzg03XDb16nrRSi8C8qo0dW9BgLR1vIraExMqOUO93uWyFH3NJUqxAthNemhPCof4Ze4b8fRPY20Y2x3eP76P7UCcs7BmczORfa9jOHy09KM0Gv+Yc/asruBj4gFjfr4MF+HAKVD6oCIX/+OW7QuRb0yQ=;7:Ecd3grzrR+K0kxs1cMcewfPZneWu79mJss/jLp027lO6IyD0+HH3kpuvZWkIFTaQA9VS2H0fdD/CweRkIYgE2b1NKqejPtLHj+/LpEbXSEqI5133g6FBOcDXl93YRFcd+VqmjAViaMVBGDO1Sem4Iw==
x-ms-office365-filtering-correlation-id: d9ed9d25-f0ed-4539-7d18-08d654f1580f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB365942E2CC84F78AE9700B7FF5D10@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(68736007)(106356001)(486006)(105586002)(11346002)(99286004)(6116002)(36756003)(2906002)(316002)(3846002)(66066001)(5660300001)(446003)(6512007)(71190400001)(2616005)(71200400001)(305945005)(256004)(14454004)(8936002)(76176011)(2201001)(7736002)(26005)(6486002)(97736004)(4326008)(186003)(110136005)(6506007)(386003)(25786009)(8676002)(2501003)(53936002)(102836004)(52116002)(81166006)(6436002)(81156014)(476003)(7416002)(50226002)(478600001)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rWDmdvJr9PZW84HWWCyxB5zUPbhwwxBdhuEFcElCoEx2b8T3P4lEd6IXaiRGYhJz0/A5rn+sRkhaQN82dGUTqIg+rNcng7fCi86eS/XKj4ET4BrgN0yCLig0QSiyLjuKxbm+kI9H4knLpAecw75YRt/TwkzUkgY9Pf5y1aabVT6OddbTqj86xORqrlewYxbgJllde5B+Xm0OzE9Bj9R8TWOWyIVIkwof0b4d+lFjGWGg3qHGWnQfSNfve3BxQiaC8QXLpnBnJEYzsjtP6kbyTDQwYbk5+d1Jv/J0u06QZevG+q+q3AAqOWgY4z+XlS8Tw7xIu5dt/Er0RKhWtkC5Cc4sMTn5lKg+M1kAtpUT28Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ed9d25-f0ed-4539-7d18-08d654f1580f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 05:21:26.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
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

