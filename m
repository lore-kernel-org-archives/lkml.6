Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A79C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B26920832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uj/K+rr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B26920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeK2Mya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:54:30 -0500
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:61808
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727333AbeK2Mya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGKn56NTbWYf3BNfzsV5YX7MHvch8jyid9Gcu9P1kwk=;
 b=uj/K+rr2/YkifWE2s+N0/DW4Ln4QK8SmTX+UR+K4p0hUOqJ/Ge5DHa6MyZzgqm/v+0+aUo31qQnplxwOzf4sHraFyFjAPDHG+6OmCFq94WYUAKu9Q9xMYWJ+6Yt65BJwYh1O1mq29t5qojjIOCNoe8BhK3x7zJ/Izc5XzaOLh/A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3930.eurprd04.prod.outlook.com (52.134.71.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Thu, 29 Nov 2018 01:50:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 01:50:19 +0000
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
Subject: [PATCH V4 3/4] defconfig: arm64: add i.MX system controller RTC
 support
Thread-Topic: [PATCH V4 3/4] defconfig: arm64: add i.MX system controller RTC
 support
Thread-Index: AQHUh4XhICV7habpB0Cj3NMP51ukzw==
Date:   Thu, 29 Nov 2018 01:50:19 +0000
Message-ID: <1543455856-18021-4-git-send-email-Anson.Huang@nxp.com>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3930;6:IwtEKonY4tkVqcBwzG5/zQdYd3SArj/BUlJupCLK1okbndFQiGIfAOfI5q/pX33pxd9I72Mhcar8w+U9pwGNg6wRE31BtjbspOgKtSyqE8f4vbmRH6pcgwaRFB2itNEbIkrbFuE/Z2Yh4ATeaX64KJlGzbHJrQop7vXoJWz69CA2WSe+8v6rYbnYajXpQXsbmBz2WmAQ/KMjnh26rZftNXIj4v6JFMrgnwWRhmqbdLV0uaqXRv/30cK3ixppLWRvgWgOEJIblrsOTt9o2CO/0mBztUzsyamksH4YDpMb8jq7vLdoGNi7NtnFeBRG4Oj1ZJ+h1ixlz6EQQjAZxfZQRsXHOptZzllTFOH2ZleAaC+gmb6N8ye+1JqKPdWEojl2dFLzxZUPmo2KCRJo38HPpuXKOFomhS967hULeh4zfIWlaTx2N56UtVIVd7pNo9lRKwjzFkKN9/qP6DTd7lPjdQ==;5:7gqeXHLNVbhPfu3kpVgum4PKHhez1KBoYLfP6to2aSDP/0+MpnAIj3W1bsYMBpLPqIbarjeWcKYswIIMeBaB+5fhyyrC8qqu9YNmAHF7+tIqA1nI8Kp+ueiAilURSY7rXbvWhIb3GPh7kfztngBHktqnAVszSlIH7wVTOhh4gxg=;7:s4T/5uaVS7UHR7EgFjRTRV1yzlQ09kGnfCp32tt2aHoETkLlFbC+LhvkVkPghazXoFlMOpI1FRHSCqevsYD6aMA4DUbALz05euaPJFi1aZz9byksBa+14hfNDXsf4O3zZtZbCIAgyURLpN4Zkvo6ew==
x-ms-office365-filtering-correlation-id: 992ce255-247b-4307-99b3-08d6559d0422
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3930;
x-ms-traffictypediagnostic: DB3PR0402MB3930:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB39305102F4F2EA4D4D09091DF5D20@DB3PR0402MB3930.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3930;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3930;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(366004)(189003)(199004)(110136005)(2501003)(316002)(3846002)(6116002)(52116002)(7416002)(71200400001)(305945005)(76176011)(478600001)(25786009)(6512007)(53936002)(7736002)(14454004)(99286004)(36756003)(5660300001)(97736004)(4326008)(446003)(86362001)(81156014)(6506007)(81166006)(102836004)(8676002)(2201001)(68736007)(6436002)(6486002)(50226002)(11346002)(386003)(2906002)(105586002)(186003)(106356001)(2616005)(26005)(256004)(8936002)(476003)(66066001)(71190400001)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3930;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 95mJoK9nmm1qjMXEn0KOme7Q8PmlN6euGKlMYrxnDoSUbotOMRbh+Ftye2Ezdk5K5cPf4Tp2e0TSbk0BtdYyyUVnVIwBK4mYxU/d6Idw5QIiKA0IQ69PBaFlQFoXSR0wFN+kwNsnsFL3TZM/yheTa8z10RcXzF0YdZDSjBvjqPpRvGGg22BJzjzs3fnIRsGVNYpXAeTClpZq8uKgMX6sTFXhP5t0AeB+mrhK3913abheDMjdyiEyzGoAne4fYPyee4fowliBJJDmm5HHOyMg/aSeFYKKj6+j3mOKWRRHbK54Jg1j9S+eboLNza3NHqNZjHhLzd2OJG9L7GxpULv39G8EySyywLSsIphsKGaLZZc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992ce255-247b-4307-99b3-08d6559d0422
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 01:50:19.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3930
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
index 10fade8..9f12324 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -573,6 +573,7 @@ CONFIG_RTC_DRV_PL031=3Dy
 CONFIG_RTC_DRV_SUN6I=3Dy
 CONFIG_RTC_DRV_ARMADA38X=3Dy
 CONFIG_RTC_DRV_TEGRA=3Dy
+CONFIG_RTC_DRV_IMX_SC=3Dm
 CONFIG_RTC_DRV_XGENE=3Dy
 CONFIG_DMADEVICES=3Dy
 CONFIG_DMA_BCM2835=3Dm
--=20
2.7.4

