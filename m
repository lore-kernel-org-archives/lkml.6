Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4DFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3962081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xAZw+PIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3962081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeK1Q7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:59:02 -0500
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:7696
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727150AbeK1Q7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqkwAEgWvhvnxmFTFIVywPlME1oqixxzGKxhU1FSNas=;
 b=xAZw+PIkv4PZkroxK4U5lZGZF9+KqK3omiNlZ3fzwk6o3n60lMknf1ju3i/wFbR73XWkS1Rggmwg9QylQcr1iuaUKrg+iQVClDcH2IcxLKZQ0x1yFXva9rTXk6W/3/op44z3LJNT4pW0OBw/If59vhlDSlzItEWBSULbSQ/ffpU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 28 Nov 2018 05:58:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 05:58:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V2 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUht9jLUta/RsnpkWkiU5k9aqvsg==
Date:   Wed, 28 Nov 2018 05:58:29 +0000
Message-ID: <1543384349-2851-4-git-send-email-Anson.Huang@nxp.com>
References: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:2e::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3738;6:2KLgwMg9xpvu+Q74Wf2BEJq7NjaV04le6nVQGIwJ8za6yFSKJyyvliKAcsyYvOUu4Zd9VRRM5vNGY/TtTMG55I1ZOD1gZcu4qiFYPykf/nZ5Znjas0KLT+UXgBgnayhYZ1URfw7h4nvmquuIgYoUObeWX8nLy4yMCL2Kq6NhNCzCrqKXiri4154FKfZmIlbPzuFOhLP0/tuRzDN2SJQwBbARqgZ6cNGzKQARTDFVIgT7N4rGWWJ5OmlCUNHtECQhLuwGu9OGY3iGRnLjTXZV2m8VugPbn1PZp8cWabzOJGGtl+WzaA959vbutz+S4TUDDMYlxEzGg3ej0Zyd+U2cqTI/JRw2aK+dA8iG/vOituQhjtT2wBxHn4cWN3sovC/FK0m4DhqhCQKTFf4WsEoYxaV0OKzuIusKuYalxIMwlahSER3lx0Bj94XoA0GRW1gEX4d6U1SUh6aUsJ7o5yggJg==;5:w79Ooy0sVy13pImRJ4kAojNJ0Q2XjS+//6ecZtZQ4LT6Nh1ElrI45VVTQaHNHvp2uBpxDNg6oVisYrn8LqWNbFHeWCUUXIvOPtIktjGI4QOIGyDPgeiuQX3aAbHZH8TLFqSAsNPSZMrGkMWVgRoh/wTNAR4VHyXlTceoXLsm+BQ=;7:gIK3v6yTo9MvP93AB94NAhEdphkFXHqGnOn+JqDgFdyw7R7zZohdeC+QE4f5Svw6pr6iS/Ctmp0FGtJV8BC8C9+Mz/BJSQeGMWRc7pCYRu7leRwJxBPRdry1P4dh6D3HabGhgjvcXuW+eQbp+WoLqA==
x-ms-office365-filtering-correlation-id: a2f0e082-55e4-4879-bdfc-08d654f68553
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB37386F8A662139BED1759921F5D10@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3738;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3738;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(305945005)(97736004)(2201001)(86362001)(6486002)(7416002)(106356001)(99286004)(6436002)(2906002)(105586002)(25786009)(4326008)(3846002)(6116002)(478600001)(110136005)(256004)(316002)(7736002)(8936002)(71200400001)(50226002)(5660300001)(81166006)(186003)(102836004)(66066001)(81156014)(68736007)(486006)(14454004)(53936002)(11346002)(386003)(6506007)(6512007)(76176011)(36756003)(52116002)(446003)(476003)(2616005)(71190400001)(8676002)(2501003)(26005)(39060400002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RWxh03V21V+iPr6EdtBg9UDa/PXwfJczREh7MOnJWXXY05aSGF5tWY6MVAex69k5pxKpahOcaUPPMlhggXRKaHqL3b/bxY9r1MbmaYSk2AzENbGKZ7gyG0ND6afW00D2mbjoOF3CuO5BqLMbj4ZidSp+rvQIb8ougJE0iVP2O310DZZtJudyEzToQQug4XbVd//Ql6BsWFnBBPTl7P2Qm0A5TX8qmfoTy3PG9972X/zxLl1vk8/U32FCeEGWRY7tdO1dISH7E1E79qtWgnFt2drEIY1WJEFIo8qCDvgRE/7VsS8qw/IbMLOM3V+DQbynSCRNM3DvJ/qJmB0Yf78iWL/E29T0qPVdqN/0yggLmt4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f0e082-55e4-4879-bdfc-08d654f68553
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 05:58:29.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index abd80c5..9f12324 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -376,6 +376,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=3Dm
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_THERMAL_EMULATION=3Dy
+CONFIG_IMX_SC_THERMAL=3Dm
 CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_GEN3_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
--=20
2.7.4

