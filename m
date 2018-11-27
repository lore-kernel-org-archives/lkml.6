Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31173C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HTtW0wCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeK0RKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:10:53 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:20953
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbeK0RKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1yt2V7YtcWLqU7JSajahtmUMbUWeOPU9/TZc3n184s=;
 b=HTtW0wCYxFufufIIO1wgA2JwJDoAjZMYGzrIiGbdF/+6t4/ZOYiDoZRgHm9NniDPRjTApWGM/aBSZJh5Fyj02BEHxy1pBAcLiQPHPTpGgMOowgN49OWtYk0b/Q9738jHDQIY0ineXhSMANm3BNwC7cZOJScfWdSuID8CXKP+Qaw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 27 Nov 2018 06:13:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 06:13:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] defconfig: arm64: add i.MX system controller thermal support
Thread-Topic: [PATCH] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Index: AQHUhhhigLVS7kcDk0+lVk/DQgR+0g==
Date:   Tue, 27 Nov 2018 06:13:59 +0000
Message-ID: <1543298903-8389-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:203:72::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3739;6:HrZCooHEIS1InIx5qy/sXV/sjFI0f5XeL5Bk3fRrskuRhPiTErnoYYbrkMEMtwBZ11pAt26v1XX9mNMLUXYmLE2tjpTKH/F2GmL/d6+7XA9uL5NpqpHO0opm+3LPNImIHlx239huegaZx2/DUKPqCVSVJk3nSSkL6wvCdKg6l6ZoSujNAYP8jPyf4ASe6MncdnFb0R8TiqNjSnl7g4qOlHO4PDYU6ERpSZ2dK/MB0lt0VrmVb22LciGIDI1ndDCkMJC6tqqpMXdQSbVs4/Vrm3uVymJVJ8jSzeAq/bHTV6fs4Gqzzld+KT50wx1+qFYOWykS1g39fiJP4IPSlT3Vy5+OktjKa+wEBqbWgvIgo+CIdVFg4wrwWeT7Mi1wOm16x6fxw4uU9pZRj+unEw6cu8T1XzTAATRKc4Sj6XyFarP7SZgsRvraI45Wjg+bMC9L9BwuGsGIc32Xvr1QP6SuzQ==;5:aVlYmn0DeaWzLzFYB4iDHv7rs2JOurubCnb1H6/6+qocr6YH1B4m5GSNqhVEhGXrytXQh/3BeK49GGfqfZ6y8Ff75XB+o2qWYpqdztwiuzgurbWBxNCiwrvycwegTdNq46BWscU5y7CJArRQyONagjvAZblUYRldxVQCHmBGciQ=;7:McPffIs2gykgnodHs15PGbqehcAopDgiQpx+YrLGV1v8Vn+3q2WmRPlz9um+kvevUG/y2VVmRn74VEBb1VqZubPzQMDLkG2cAf4dLo03uaMcT/00rMOletkK5+E1Klbsbk3r5LOppKwSoqJd0cMW8A==
x-ms-office365-filtering-correlation-id: 1c3d0cac-f714-4151-6c63-08d6542f84bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3739E8FC3C4D5C290F5E89BCF5D00@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3739;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3739;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(66066001)(6436002)(7416002)(2501003)(486006)(1857600001)(14454004)(4326008)(6306002)(97736004)(8936002)(8676002)(81166006)(81156014)(186003)(2906002)(102836004)(478600001)(86362001)(53936002)(2201001)(52116002)(7736002)(50226002)(2616005)(71190400001)(316002)(966005)(110136005)(106356001)(26005)(6506007)(386003)(5660300001)(476003)(6486002)(105586002)(6116002)(3846002)(305945005)(99286004)(6512007)(256004)(36756003)(68736007)(25786009)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h8TN+TRGF8fWufbS+nAptTgCZXT58nw68Wnm7h2n71YCWKUt2kzs+Fiyc03rtlcpg8U+hQOKrivLU5Fx6nxfeFpXr9+GpCx+V2p1wpO18CqfinxiqyVCqEZ7UqRkG+adXkYxGlWq2QeT21dWYkOjfChlHx+7g+U9q0H+o+Pt1fUySuXk2uo7gInGbunmSZo+j7K/YMfu/lqq729MwP6z8RST48EzV8FafnOtJkAQ6EhlP58V3eCecPxXUWf1fl/OjJPJ7xDC5NEjfpINmfPfDMDz+zDdSGkyJOXgLBqbGRL0jeIqXabX8sgLGCRIDbwLxdUhYbSxWqmt/2pfPeFH0/K/HqWfAR+J+YDjgGMK0Y4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3d0cac-f714-4151-6c63-08d6542f84bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 06:13:59.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_IMX_SC_THERMAL by default.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	This patch is based on https://patchwork.kernel.org/patch/10677315/
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d3aa3f7..6d224f7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -376,6 +376,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=3Dm
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_THERMAL_EMULATION=3Dy
+CONFIG_IMX_SC_THERMAL=3Dy
 CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_GEN3_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
--=20
2.7.4

