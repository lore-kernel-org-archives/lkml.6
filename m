Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA535C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BDF20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GD9DGozx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BDF20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbeK0UjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:39:02 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:4526
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbeK0UjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUu/L+sjnw5ZX9y4Lgwar/C+5R5cD77LV4HIrQbQKAE=;
 b=GD9DGozxG+W7wp0WBebRSpaoumfRHmJOhYNjH3BGjewWB2EniBz1iTMPW7gaKKd8KI1dEjxpFeDTdsUfqQq2sB9mIeUCNtQ90fN/4ocrhKOjeg+6GvbgFvBwaVoSbclGbtH1YXo5akFMVtJTSMrehhrgGcJfF4oTLa6risJvVBg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.38; Tue, 27 Nov 2018 09:41:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 09:41:38 +0000
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
Subject: [PATCH 3/4] defconfig: arm64: add i.MX system controller RTC support
Thread-Topic: [PATCH 3/4] defconfig: arm64: add i.MX system controller RTC
 support
Thread-Index: AQHUhjVkKaS3fqObfk+j7XRg4pq7ow==
Date:   Tue, 27 Nov 2018 09:41:37 +0000
Message-ID: <1543311334-8807-4-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3850;6:hiXAQRP0AJ4JnXNmaAxM1OTGuyUutsCA+N4q308g+ujLGtoUmLEKLn6TJAhJOHwwlFC/bZ0sBCuCC6E8J+LwR/Cx8qbIFZuSK9uOsNlFTC7zaZfGylrSowZqKW+wNcP1U8fwx8zi/zL+IGJAaiH2iziKrprwlCx/4J3UdWB9+3SizvZM7+bNmVnM5YYON7kQ6Eld0ktLKzcOslM3vYmIQTKhD5sVe9gwrAhlBjGp2dXssu10tIBpfpQ9mkkpr/52IXLpqRffnSsMa6Rco4ayVQNxr3McI89NIcfLW5aa0frv6qTftqT/4htnAHu1p3HWKlf5k/LX63RkjX6+UELTZu1h8YVtLLpUD9HZI7N3MBfpRBmJ14mfJ9Hh+8aRvgV/Admp5Ae6rYMIp65/vnq0zumLXLv9Z6vJHtSE1Yd8dIcdPX+SM206hN2elPSXw99+EmQDD1oJQyZFCwcSXA7Cbw==;5:EbBU5nk5ySlv4MgPiF7XP8rsJhHv4xxcAiUOn9T7o14qwBkOxsRZiJ7Y9niXCk6bGMiUinvAOiPrFtY+ErNFUtgHA7//pLr/yyUDimighZXrZwznaXaryQcef9btIhX9DZiBW+zIAbCWEWcy7yJlNSQpMceeednwXgJY7GAZAaI=;7:eBlIx/zQB5NfsvjAjo9g2Fzeh153S56FqC+6rSzQAM4o0pSAyNpnX9X9XjHFBTVn1474bDYrbvQHgwRvIGeVLxaoPp109VDkrpzUG7YPF/PlHJs/DS1fSV/x/e9+qzfknwl4TK253ButqHpUXTMKIQ==
x-ms-office365-filtering-correlation-id: 9dc392b5-5e97-4140-ed00-08d6544c8631
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3850534F304E81A185DEDE00F5D00@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3850;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3850;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(7416002)(8936002)(81156014)(81166006)(6486002)(4326008)(50226002)(8676002)(68736007)(105586002)(26005)(76176011)(106356001)(186003)(478600001)(53936002)(486006)(256004)(316002)(25786009)(6436002)(2616005)(446003)(36756003)(6512007)(71200400001)(71190400001)(97736004)(476003)(6116002)(305945005)(99286004)(5660300001)(11346002)(3846002)(2906002)(102836004)(2201001)(66066001)(386003)(6506007)(14454004)(7736002)(110136005)(86362001)(52116002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YEwdIloUaX9Hi8DuVznrkLCzdKhuNh0kL4yG9ZuOIzmnC2iZ84GvoCFdTE86rDPAJxHE44h7PcNnmBcO9fKExqwpSYqz51gexIK/7r5/G4/cIyKFWsPftg0CrB4R1tt38iWGkEhZDwZ+5/KRZDBYU69dcTFeI4jMQ89J70QAGabYJAs/5Vk9YsVbe7ODX1o7DfW0wrpq/ujDOf2+Kg0wdDHyibgVrUvmQSxrGo4tSxxeDM/r3izVlRxxb7Adnpyvx8bgPtTntvzI0CIpdCBnvi+EnNosywX4gl+Ngn7jRXyZ0xgO6PHm7HAGDpPvrGO/2N2l37TcMPd+C3ERFrEKxAO6pfJeJQQNU2h8fecXpD0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc392b5-5e97-4140-ed00-08d6544c8631
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 09:41:37.3295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_RTC_DRV_IMX_SC by default.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6d224f7..6fdf2d0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -573,6 +573,7 @@ CONFIG_RTC_DRV_PL031=3Dy
 CONFIG_RTC_DRV_SUN6I=3Dy
 CONFIG_RTC_DRV_ARMADA38X=3Dy
 CONFIG_RTC_DRV_TEGRA=3Dy
+CONFIG_RTC_DRV_IMX_SC=3Dy
 CONFIG_RTC_DRV_XGENE=3Dy
 CONFIG_DMADEVICES=3Dy
 CONFIG_DMA_BCM2835=3Dm
--=20
2.7.4

