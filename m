Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2FC10F0A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E46218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wkp+lLm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfBRCCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:02:17 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:55457
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727873AbfBRCB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ7KBQRzG1pkCz+hQKnSbVHy2xbhBdBCBt48ommeQUU=;
 b=wkp+lLm8Vw1ph6cSNtgcYwoGL0gq3jfbU55dLHXVZXfB+IXckxMuOYWQHUtdBAyRvp0mOV96fVKMgI4CvULW+g15BuHzC74F4qHZB2NetGHcNyVJfNfQYDQOapivS6s+F5LtvKqmIJ7scdr6gckjbrgh0JxfnzxyZqGdqCdiJY4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 18 Feb 2019 02:01:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 02:01:20 +0000
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
Subject: [PATCH V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Index: AQHUxy3XB0HTxyCzNkOieuLhEA6Imw==
Date:   Mon, 18 Feb 2019 02:01:19 +0000
Message-ID: <1550454997-4398-2-git-send-email-Anson.Huang@nxp.com>
References: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe3d3c72-d972-4eb7-c650-08d69544f975
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3900;23:+yqbDc2AfVyL5JURXjkfR8RQlgbUHTrluKGM+?=
 =?iso-8859-1?Q?uMAg3cFe9QghHZaPKTUHYVXDGtzzciulFawlgBOtTQAfS5Ji3bbFUPZyja?=
 =?iso-8859-1?Q?KsE9RDjmbJG49xqVYk/NM62NpDS3L21Z4r9DBrdsFYmGK/LxxVsOXv2xji?=
 =?iso-8859-1?Q?G9NlgRWk5864WZdMpDbOhgwWgXM8Y5isJ9L3s6CA/pwsYMc4zU6miL0A+r?=
 =?iso-8859-1?Q?+yFnOKTv3IKbki4jCLfmSHQR55w+ti8SGinDsUFjtzSymr8X5Eao+X2BkP?=
 =?iso-8859-1?Q?pIvfJMLrf9ZXayoruC7uag2QgzTPXpBx8ryxd/vyF3RdJV1Ugc+rdUJ78Y?=
 =?iso-8859-1?Q?+i0v8IIWlyDJlfgKjnWsRaKrKmnN3NqDLWNSe6LK+tJKaHOdPuw7lYnlE9?=
 =?iso-8859-1?Q?T6eHxolR143X9pBwO/aBSw25QWyt5Bv5GMf/MyiMGOtp1158hA1oKnADnv?=
 =?iso-8859-1?Q?2b269xp5Pm85icTTRaRlb5+px8j6E52T/hTFjWj/bEEMInMyVC5t+T7aDK?=
 =?iso-8859-1?Q?it0/mJ4k+GyizdREn7CxoT2GQTaf1S20ekKb7HyomlUzG7y1lcgBQ7R7vR?=
 =?iso-8859-1?Q?NTNouh92Rs0OPPtDWtzASjuyMdYJZ4qV/nqqX9ldW3wNuXXEcJfYGAk2jy?=
 =?iso-8859-1?Q?yBj8h+59PtUZGtcC9pQ35Fzjww611oW9lxg/5NcVJBsTxQsa+wFzQ0WE/s?=
 =?iso-8859-1?Q?TkLGnmhQTMzr5lESGbPyf6s/271W1bgHhCa+9j5lurmPReOHA4lYIPG256?=
 =?iso-8859-1?Q?s/efOlw7PgK0xGnIdNEoWRn4zfBqjmKq9r0H8pp3n2LuEqRmoWEz9TQrWV?=
 =?iso-8859-1?Q?Az67wJVnLP3vhAAfxtnoIzos3b4ji36Cgn1TybLDeIbNj84aDvOXA4J0Mh?=
 =?iso-8859-1?Q?UntKgyzv9hVd/2xB/gNRLMuAKlxyN1js4IWjzVyx/2qKLMcXnZ9pYCIhBm?=
 =?iso-8859-1?Q?qU7MUNFrJAkd9pNGEZso/poioDjGIeBObn94EMguOFi3Q94z1yeLWU8d2x?=
 =?iso-8859-1?Q?F6OGkdeuAXPsb3JLHjWd6r3fbtPRA+OCF0rqLXLM8uajZicTPORTkATzUS?=
 =?iso-8859-1?Q?pnLlRrCBi3fXvGG67TLS/jh6vyp705+XtgwzyN9Ij5h21H/81rANghlykQ?=
 =?iso-8859-1?Q?keBNb+YS1O4dalPvEMEK709pYrwRE8lVotODKsphenVtMo+l9qVWlHGUEr?=
 =?iso-8859-1?Q?Qto9Y0dzSAEPk/UF5mhazP4z8EWwoNOAcGSxoLRdPG/aaDuxIl8WEnip9y?=
 =?iso-8859-1?Q?8MhERfFf0RoWKZ07lvOgmwUbkkHnnnaGF/XI65CKQXP2vDw4EeKNNOYcp7?=
 =?iso-8859-1?Q?tupSEf5AXDhu7eIkt7w6UAWrWo9SyOUBm8U2wtCIjVoVnkg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3900F95CDF78AA7D0F81ED95F5630@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(6306002)(7416002)(66066001)(81166006)(81156014)(8676002)(446003)(6512007)(11346002)(25786009)(3846002)(2501003)(8936002)(476003)(6116002)(2616005)(50226002)(68736007)(14454004)(478600001)(2906002)(2201001)(105586002)(6486002)(106356001)(110136005)(71190400001)(186003)(52116002)(966005)(76176011)(5660300002)(6436002)(36756003)(486006)(256004)(386003)(26005)(71200400001)(102836004)(99286004)(7736002)(53936002)(4326008)(305945005)(97736004)(86362001)(316002)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FVjjdmL48xuH+DPQnUO9tW6l/Ufr5AbJ9kM72LAEAu4RE+bMInkhNnF6GrhSx089DPHCtewL+0yDq3SAXKDfBaud2RbeEak/SZj8sLVPTAL+KvJxni9Z+KEptJylpb+mWt8yLMwqzZvU09zNFuscietBCukLMqHSVA06hqi0/0EmYy6z6g9yKk6/SR1VNjm8ne7fdecoiU9LqMQrCHqXkfVzC9r/HL0X1MQZGpSbWfji+82f6auKH5gGFzGQWhbahFmAtVeDTWJeGU6I67lxOD3jvt2LBZZLAshd+r/xKJz2VZjNVTDjEuRnSBGjd2vWDTSqAGSLsrSXw1RBirO3I8vCD6D+og0a1nbMpsQ86/uTJgRt2NG+4Maud7Wz5XURqQVqspnYva/YBhRFrCqRakU69ky1TB4KFt2HCRMMqHM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3d3c72-d972-4eb7-c650-08d69544f975
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 02:01:11.5086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP system controller watchdog binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Note: this patch is based on my thermal patch series: https://patchwork.ker=
nel.org/patch/10800699/
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

