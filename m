Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C8DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7127C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UpByhYUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7127C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeK1VAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:00:17 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:14095
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbeK1VAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqkwAEgWvhvnxmFTFIVywPlME1oqixxzGKxhU1FSNas=;
 b=UpByhYUDMnF7EbcSNH2+S+1TjgjoQJqRkD3MLou7p/zvXcMnYvEf2YVrkrT0mm/uh5lYXaTIRQW7jKzYpKHCt6YINMqvzpkSB1XGVB04eSZGeE8wAxzQnTSBjf2sUQKcs12nAYMRBuCZNW0aApk1fBODP/rUHz0hsRYimkJVfMw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 28 Nov 2018 09:59:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:59:08 +0000
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
Subject: [PATCH V3 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V3 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUhwEAejWVy9TTxEeid7xSxHzHzg==
Date:   Wed, 28 Nov 2018 09:59:07 +0000
Message-ID: <1543398783-3185-4-git-send-email-Anson.Huang@nxp.com>
References: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:YgAc5NO0IdOIurFnNqRuor6HvoW7azYzNntDQwPno36cFB5Mb/qTX+M4ABsAUNEtxRzT/wiS1NAUHLilVvXBSrEi6HZ+/iqZVNXeqLesK3Mviv6w6JGqTaXGoYaMUef93pPFuOG7V+alAxIWRUqFS4VG3UlBsO2qCVzreFXZxurbgllgaRnMcKA088fQFv8f/jJZB43dkFVFyPWKYLItxVeWwhPoo+tULVt+JeqbhFRelxCTvTVUA8AMGegVgM3Mlg2maskM9GbhNuzJCxGafZnDg63/2QifsqUD/85JBnuO2WJMO1qQdVEbWHmV9UaSBidjqsKtMM8mGI78Pc2dP+VNB45z3N23DfAxVmv9cprxyMNnZavl/LF0TdPYa/9J1uJfbMpdGHTc1ilXzv+LASj89XL52PoGq5LBFvekGMMeinNXPWd+9U62GHW9bnMthNAQWLmuEuRLtbIxB5L03A==;5:EGd7pEYeqfljGS5BimQjFa8KwO2bxjEuAjQ4k/3q8sUU3ECq9t1pjQg27lw2fFtttlXqkuRP6B4b3YBtDs9RsoGc76yKPrBWrzSvKh1xJmJmFSe/u1JJOOV1d819mHhj2WuKJtVR83K37DrtFlr9Y0v2hmAAZ4vkimlwAkrcQtM=;7:m/DrxYNxeyjBaD3co1Xszij6I7hrwuj1rQkmL5jAuBfiWPGh0gdkzgOm5Ko84hd1qVXTGf3WmVdnW6Dp0FlgoN1zqxtDEbyvglvSzw+6vBQjreM42MWJEpuwTVi1BdWLcop+WdW3cpD7mVOVC5LhmQ==
x-ms-office365-filtering-correlation-id: 24b98a61-f892-4ec8-deee-08d655182309
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3659D8D310DFFBA0B46CBBFAF5D10@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(110136005)(4326008)(97736004)(186003)(6486002)(102836004)(52116002)(53936002)(25786009)(2501003)(8676002)(2201001)(26005)(8936002)(39060400002)(76176011)(7736002)(386003)(6506007)(86362001)(50226002)(478600001)(81156014)(6436002)(81166006)(7416002)(476003)(36756003)(11346002)(6116002)(99286004)(66066001)(3846002)(316002)(2906002)(106356001)(68736007)(105586002)(486006)(2616005)(71200400001)(71190400001)(305945005)(256004)(14454004)(6512007)(446003)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bRcU3OWQwHh+eZXr55crkLxWcoWvXi/AyaJiodgboL0WBP5dlL8oOUvHW0AfVpH8Ew3Ssjiwq1fGXgadReVd9B167JLVwwXc0QgLDacKGNRvXXX0rUz33vOE87lrmjiHs+PD8lX3hk8AU/1ZMS0kOdmp6tw/qP8tBbOpXNUTRvZnf2iYr/tvDUJzIqTKP3a7ziXm8KTWi4yGMuF9sAnA9YHC6hhPZgiJwtgix1qDF1vJ0j4DGBn/XgQBaYj2LYS5Y1YIs1sAYf9xrX+n+6xZHP8Ep63EMBADcwxFBHLisSf5hZD27ku8R8y4Ud0hYjMKs9iiyWFM24OIBb0meoTVTkyOlbF3/q5PHLmacxhBUaY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b98a61-f892-4ec8-deee-08d655182309
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:59:07.9773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
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

