Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19BD206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gCvimuX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19BD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeK2Nlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:41:31 -0500
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:61360
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbeK2Nla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqkwAEgWvhvnxmFTFIVywPlME1oqixxzGKxhU1FSNas=;
 b=gCvimuX/T34kfc5SG/3cjbTRHg+ZDAyle1Gv4iQz3Qb6vAzwcGH6C4qg5+yhreudznywPrK9kLfYYZU/qU2P+wwi4KX+RJS1kHpUXyZe5Make2hKWUMP54XtaAQmUzhER37DdJB/lHgdvmykvbfyL30ATYmz93tcPNb0iDaSW2Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 02:37:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 02:37:40 +0000
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
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V4 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUh4x/dAiU5+dz1kW9lo5Be4HO6g==
Date:   Thu, 29 Nov 2018 02:37:40 +0000
Message-ID: <1543458696-4741-4-git-send-email-Anson.Huang@nxp.com>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:36::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3946;6:YE21TuyFanNsCGrTiCvL23Hy7eLSBO2XphzkZtxNVeh70lGzMDlTQxXRhdTO0GRDNoUmYqbGyPf2QdWhByrbqmyb4RjGiXJV72Bz5FW79UlDin+lp6V7tW/iUAI+tETZOaSNcKPcBFTxNR0F0vfWtt2eUTXdOexcheQSfLM43+3NK4Ocq2TqLBp00jHTwa1L+ZPIoFy3WQUNzRtcEuPKBKz1eF6en9n+A+oWA4TyWXmXh/kQYZTyIDwM6Ggxm//7q7QKH1Yg25mtkCdmkIO/jLDOEoxOrOuBH76mAuiCzzv4pGBjiRXjRlcAaRwWDwW3rvbFMOFOwX0wduLgVwNKoCFI7AzLGChyjCdQOCWPun2MbpXBTCWiC2NnAa4WX2O5bpo5oe2a945L715lnyTEmbg6W8hk85OQJdvtZNpPharXxZdnUDGoeMGzf2z7uYPx9XGofaogPK2W3dB2cLMUzQ==;5:/M6xqa5j5J+yrRqH7Z/KygZQbh9P6RV8PN8gXus5oE9qcKQletz/CIV0jRK6eZ81FITIl5RBncdAQ46NXxpdUPPQC14QC8tAScAB8O3kMe8gfi6tPDqjxtigEXfRO3eoJS8ndcIXSuhQ5GMmUzF4bJGbiATAHx8ETONylDnELxY=;7:/e++WfeD4V4AtWlzGiommIs024vjZ7M0knnMwAJ5ILEcylUEjye4y2sqUNL3U4yI/m8UpqoMXW3bHkEO7XFQXUMWtfhHJL9pN6c56waqI72HYOxpKxlcwZP0UEm1gCMJ+tY9rJz6KDjpVmYkeoN0hQ==
x-ms-office365-filtering-correlation-id: d09ed58f-620a-45b6-890b-08d655a3a17d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3946E82F2D89C65E66E4E36DF5D20@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3946;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3946;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(25786009)(50226002)(99286004)(3846002)(6116002)(478600001)(8936002)(76176011)(14454004)(2201001)(52116002)(316002)(102836004)(106356001)(86362001)(110136005)(186003)(2906002)(26005)(81166006)(81156014)(8676002)(386003)(6506007)(68736007)(6512007)(7736002)(6486002)(6436002)(4326008)(66066001)(71190400001)(53936002)(39060400002)(36756003)(2501003)(71200400001)(305945005)(256004)(97736004)(105586002)(486006)(11346002)(446003)(2616005)(476003)(7416002)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jKwiCLVcY9a0eEZPabvUFT5kdfSnyyJc8cR1PQB9Zsi1b9DNtx00YtTeC3H61XFNvBEb6i4Csge+lKGUmFXjB8KODyWD7ZbNJeV/jCpeilVRrU4N1exltioVIpf3tjLJKc5VmfAlUwTdysjvabepUdATIqcNIJMINcVpnINBicifL1xFeCnAlLM8a7iLV8Lfo30KRpEOxKF6xluuqrDcgmM5uBCsYDBi6Aut4sYZ+6tYApwoXq27Zc/HJWBnz6Trv38xh/QsgfLQrNfesI0TqTTuAygB9mKedpqI9x6emxXC0bLUpdtLKavyBztaoN55ZsmsluakHDDAYU6UQ2ZpGaj9fNPdzah91a4XH0CfOEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09ed58f-620a-45b6-890b-08d655a3a17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 02:37:40.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
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

