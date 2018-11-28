Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD0DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA2C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QkrsE5Gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA2C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeK1U67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:58:59 -0500
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:34688
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbeK1U66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAhRCCVL7zBoueDBD+x6mGt60KwQ6HBe239ovpPlgGQ=;
 b=QkrsE5GqbYBmhEwKViyTnn/olX7xn5SS3qUIJRDvTw5MX+KyO+lpPgdVJAyu8vVkLaqHWAHdVJoIAYgfHuQiqLrlSod//lB5fhXRG2LnopIkmJ53OD8DIvzZJYdzsCCqJMYhUsQRStuvuC/mD8J7zWLozzRw8u13qnZ4UGLQ64c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 09:57:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:57:37 +0000
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
Subject: [PATCH V3 3/4] defconfig: arm64: add i.MX system controller RTC
 support
Thread-Topic: [PATCH V3 3/4] defconfig: arm64: add i.MX system controller RTC
 support
Thread-Index: AQHUhwDKusHgojZI30Gcnpr+YFwulw==
Date:   Wed, 28 Nov 2018 09:57:37 +0000
Message-ID: <1543398696-3140-4-git-send-email-Anson.Huang@nxp.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:203:36::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:SgDBGVMwdPbalirBXxujTThdXNkNVlc6DmhisVCbdD0XnNyOocCk6HyToqsfLQAcOs38mC1hnDPx66KGdIHNkOERs7IfH1TTaZUNkpt8BtTEZ5lo4p5GW7+h+X4Di8D8n3RRDoHyqMwcbqt2ihd2IStUANL4ov4pg4ifSn2e+CKDnja0koTqpivGS1eDoNF5fNoc/8S9um3I9D2O44/UuXONob7kkBkNCUS/Lv1vFBR9AZlrbIKp3mbCandT/8/sb1PGR+TPLjAov9JzS/gqfyLW4D+XcPr+9LjNgT2WJovv3gr+rwtq7bgJ7j6s3LQAYzyNJYPzhYfHuQ0ZCd8TN/gpN2VnNt15j+ZB2ZYbjdkxo0JVus0Iw5g0d1Lthv9InF/UgXNt8bcgrBAo349Shmp3cAthyVT4weD+7nEvLes0wQamvJIn/7sdCzPttgU+ZnxTwiK9pOMKBAJYZpuc2Q==;5:ipxxDew3ZQLG3GZ3y9esSNEm9Pv48BbksIOzkUQv71an4oXB2N32xsuFPTk7XEV95oPGrYSW9jBA0a65MX5FDYlIRSp1Kf9AIoJlZ6pZByx8Q10HMYNAnmR0t/qicmatZHKc0txTPdFUDpyeyW+0sXeYv57B/jcATGwa9b6KIig=;7:15M3RCB7X7B89lA6bh87AFXBvYDqu7RwyRx4zYqQ3QTqN6dO+P+6l3LA2lxDfFtqxo0oeMOQwWGw2V1LQHcfnwVy4FY/HsIuT3Tz06xINUcmtPpTOjAmeWDHXbwb+vFBkmlR1QyPh8HlWflFmE5aXQ==
x-ms-office365-filtering-correlation-id: 4bb2e4a0-99db-48f6-ed71-08d65517ed1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB36904FCF7F617AB1ED2BE852F5D10@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(8936002)(50226002)(106356001)(256004)(8676002)(105586002)(305945005)(81156014)(7416002)(81166006)(71200400001)(53936002)(6512007)(25786009)(6116002)(3846002)(71190400001)(446003)(486006)(11346002)(476003)(2616005)(6486002)(2906002)(86362001)(2201001)(36756003)(186003)(110136005)(97736004)(99286004)(52116002)(7736002)(2501003)(14454004)(66066001)(68736007)(26005)(6436002)(386003)(478600001)(6506007)(316002)(76176011)(5660300001)(4326008)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oDOxF16XtYK98V8dXO+0Ukq80WzdsEpbHhWLGuEjX9KxFwih3/mTqHb1oHUTG2PDSmA7XqUJut36s9L82LNBtCnYPjaD5xKbQRaufKxA+SJA5KanhzxDPl4NEUVsgx5Ahd3XzjJm/Fh1OanNTUmk4UBR6o9EYhGLt5z/gsJxq4xx2laewttO2PfaN0b5s9aFTnLyfpl9sUBzI/8C1ADOSG8FA9fALv+eMvJSdHXG5lXiyD6fJjsbSkBJnz6ysXG6J8yniQMzwW/KZY/VBDVylzgX/WFDAGjbR0jiBFCR2x8x6cTUtPIJWNU8bjpVSr678A77l/3ek/PyKi01Rloc3T0rdG2ZpGph9vocgDcA+hM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb2e4a0-99db-48f6-ed71-08d65517ed1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:57:37.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_RTC_DRV_IMX_SC as module by default.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d3aa3f7..abd80c5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -572,6 +572,7 @@ CONFIG_RTC_DRV_PL031=3Dy
 CONFIG_RTC_DRV_SUN6I=3Dy
 CONFIG_RTC_DRV_ARMADA38X=3Dy
 CONFIG_RTC_DRV_TEGRA=3Dy
+CONFIG_RTC_DRV_IMX_SC=3Dm
 CONFIG_RTC_DRV_XGENE=3Dy
 CONFIG_DMADEVICES=3Dy
 CONFIG_DMA_BCM2835=3Dm
--=20
2.7.4

