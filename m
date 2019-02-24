Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B11C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA502085B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n6zlWpYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfBXCu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 21:50:29 -0500
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:11658
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbfBXCu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 21:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inv0zd1lGXPYjCKkHxkCG1cGUaq1baqCUxdg4l7brdM=;
 b=n6zlWpYIINiPJ1uRAYOaPGnamyO87++UTzpsh2PhtAUn8k+h9gaKd8wiyYLPr0q9SdM8mYypF8ypOYDwcWF8C6pGUKxKl2+zO2YvQqMaGuLtrggVqi7SJO+B680OrZxKK6Uq+Nj1pKun+tnuDfFxupbfZN8VgzfNV4s1QdbEfh4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 02:50:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 02:50:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V9 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V9 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUy+uvlorzjg3jRUOHT6mZ1AJ48w==
Date:   Sun, 24 Feb 2019 02:50:23 +0000
Message-ID: <1550976319-20216-3-git-send-email-Anson.Huang@nxp.com>
References: <1550976319-20216-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550976319-20216-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e491501a-8ad2-4d7c-0c2b-08d69a02d219
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3865;23:fS7BeB2IB9iBPXyzFkr9FsyBlKNCekdKiL1tB?=
 =?iso-8859-1?Q?gSxdOThFloau5V5gFAPAg7PxVlSUUpYvOz+rebOHItt9TBjXpLhuB9x0i0?=
 =?iso-8859-1?Q?vB5Bp949GWVb5+PTOpBSFGOsh3XfDXAptxbS/tgX1P2fARPE7urRxsXxg1?=
 =?iso-8859-1?Q?+dGmiuSVNwlG5akmF2VrR2+fvy9HDUhHVqqC2NkHRXn8e81Kqgmd02TuC0?=
 =?iso-8859-1?Q?EnFpvAJlhwPdFq6yla0h3qkuhyhe4P9wbaDC6XhChicrMfYhy9GanIF+Q/?=
 =?iso-8859-1?Q?oNVdKqft5sp5oktWLP5vVBMrwar5PeJLW4PIwVkuZemgOytBrGbJl7KhHF?=
 =?iso-8859-1?Q?5s2dqk3QhYNgp4qIX545xLef9t+Rqw88///QqCyju7dYw+xRn4xA1HErQc?=
 =?iso-8859-1?Q?J2Vt4MoCrP3fLtHFPFMiPd6rglgDghqCtxn4qXOHb8oX+3xEo4IA2DOqHs?=
 =?iso-8859-1?Q?1YYBj9VqTykZRHCopqHs3r/ceIU6bvgvAd+Ux6e6NZbe9UXanVUWqwet9T?=
 =?iso-8859-1?Q?Z5dqbCck0w0ZX1XQmumKfAtIYMxzn1/fGmf+v8E+Ys9MMyJZYKgO2NLIo/?=
 =?iso-8859-1?Q?ooa4WrESxA+NB9kwRE8FUCwK9jRF1dOA0neVbyOAaTEWsVr+3TQUhgpcWS?=
 =?iso-8859-1?Q?CANwHa23I9WlEN0F8/9mgG6GJk5/lOcY3WUb0Lb4hhne7cY3u/6hgrAecQ?=
 =?iso-8859-1?Q?CPpli4BGsVwT/9ck/Zoc1t4lk18XvwkyDVku1hQbi35ds+cnDvYpiQBaOo?=
 =?iso-8859-1?Q?bqTzAsX4hFD7dojvxhL9Bbae3ij6xKF+z+BV81yx3L+RI3FLy7L5C+SjMm?=
 =?iso-8859-1?Q?a9bWnvsb9pYrDtwcRDLFyTZrQswI1NPbfi9ySIyx2eFb6ImexasAQMql/o?=
 =?iso-8859-1?Q?iV709/3quCHIRcfouGL14182v2OGX+GiYHgG3br2rtwdoRMrXqD9lFnQ98?=
 =?iso-8859-1?Q?gVpo2AwKusBsSf2tnxwDkpQgV54ZYPP9/p1vaSj9gMm3Tt2sCXS06Bh7r4?=
 =?iso-8859-1?Q?mVHx2IoruqAYCozEocY5v1T4Nd6AnLBSF57NO6icFwsknWdvT2yB9r7cSY?=
 =?iso-8859-1?Q?8iQchgFb7VX9f1JCvEzXQdgwy6j59NQ40MrsnY0jt3NQBXbe/I8wshunSo?=
 =?iso-8859-1?Q?9qaKeOIIAGXgyyy5pysfyWQrV5kADz/OsaD2UBw4bHO9gJhW69PZSMS/dG?=
 =?iso-8859-1?Q?yAJeU6SpT6l1sRBEQ7pslXv032IOhVSQySU716EaDtsOlxnziB3p7LJ5kA?=
 =?iso-8859-1?Q?tqBKyz7RGrjpK0wHnlhDZDBBpieJ/zrCGSAk2bcl2NojJrRowhHVm5xCuu?=
 =?iso-8859-1?Q?1OIezhsmNDGMyfVZwUryBQYnP?=
x-microsoft-antispam-prvs: <DB3PR0402MB3865A12FBE28F069E2A85985F5790@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(136003)(346002)(376002)(189003)(199004)(110136005)(478600001)(4326008)(316002)(4744005)(66066001)(256004)(3846002)(6116002)(36756003)(2501003)(52116002)(7416002)(99286004)(14454004)(6486002)(76176011)(71200400001)(71190400001)(8676002)(6436002)(53936002)(106356001)(2201001)(6506007)(386003)(86362001)(6512007)(7736002)(305945005)(68736007)(50226002)(97736004)(11346002)(8936002)(486006)(26005)(81166006)(2906002)(186003)(2616005)(5660300002)(476003)(81156014)(25786009)(446003)(102836004)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /eIPHxPA6k/0x0hrPaWQ5pKN6T0Iom7Qj9zlD61yKWfzUwOoCZJMJhl4Qrx5sbnBANe7Vu/qRv/JCmeAbat5FioM9+vmNbJYbv5qi4SwmrVOvVB7gm0VCM3ryZSmM2f5Tp82lChBSeQAXgWiC31HcNcGepPgIblqgl4gDkmAeem1QAGVSeY9jN8rJ52N6MitGdDnL+kjFuLYlZ9L2o3dWilL0q/nUQxUsLCxHHq183hbKUs0WtHfTk4RapNtte7DI+Y8cLk6LoshvpFMOl0J7ehJarsNN/MZ+1HgwYIY8UON69DZ/NCtwuOUeWd+PD5OQv/SibbG4sKlV+ob+cWtzVHkFN/QCb0yW1hL434aV8Mhhtta5/mvYVNt9b/XqxbMm1XkbaC194pH4KsYeePSyPW0MbcaJ44Wjbgbw6kV/Ao=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e491501a-8ad2-4d7c-0c2b-08d69a02d219
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 02:50:13.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..52d503e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -413,6 +413,7 @@ CONFIG_SENSORS_INA2XX=3Dm
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_THERMAL_EMULATION=3Dy
+CONFIG_IMX_SC_THERMAL=3Dm
 CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_RCAR_GEN3_THERMAL=3Dy
--=20
2.7.4

