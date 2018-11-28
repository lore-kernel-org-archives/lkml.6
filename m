Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0C22133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g9+gL8/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0C22133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeK2Ckl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:40:41 -0500
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:2716
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727979AbeK2Ckl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2oGYU2xb1zITX/2VOqHqTDv40bI+HKmyj+QProYstA=;
 b=g9+gL8/laIChREOW/xyoKVQaQN88csumavB/OUZfr/mnt8mKMvCgfpmVKA5cBhEcuVUStd57Rv/usE24w1Efx6okkY8e4yYDfUQgMJxKr69LQRWrY2S36/V3nKu4O/anQ952ldwcLhY2H5SKoLZuq1MeD2IgJvh5e+uPw1SL5Hc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5283.eurprd04.prod.outlook.com (20.177.42.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.21; Wed, 28 Nov 2018 15:38:31 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 15:38:31 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
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
Subject: RE: [PATCH V3 1/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
Thread-Topic: [PATCH V3 1/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
Thread-Index: AQHUhwDHgeIFUB0tfEeSggnwUbI2KqVlUnlA
Date:   Wed, 28 Nov 2018 15:38:31 +0000
Message-ID: <AM0PR04MB421116B3A25246AB43B535F380D10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
 <1543398696-3140-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398696-3140-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5283;6:IDyLtxHZL/SY9uYydkQRCJUUinmfvZZw8i+ARcbfODKr2BnWUSfS9H4+sGfO3Hw6QU81SHgvyv/8Smhqk77q0bxCtMf2NIXb6cTw/ZJIBnmtt19Exvg9U9wQ/m/84792U550vHNoNDELIVpjnKwAM2K8G5hO4/bGjv/Xt9NGZYI7dwI0oDCP8nUkSLBhLmfAIQ4GbYcjADhCqyR93djOBkIFMmnXv7XFO8SlK62YEf71slV55p5IsB74B5ziOEUDYZlTT59QCSEXp8Nw5gXkd56xhjmxRAlK2RQ1kV0ENaEWfNu7WmfxuiVUxmJNRmBNaMs5YzHg3wJEsK729zgzKLLRNbBGOnHPcMrEEzpdY7L/0sdZyhzucLNm5doXZCYjLXmW232ogpxBgUBZfsyPOGM0If9DgXYB4C87IGNIlBfI+zg3d1pYlvuzM7B8DkLOmtmYZockHesw0MDI0odf8w==;5:LM+R1CNR40hEdAAMaEYUb/b3qgc9kpu/3cZ3dBfuMoFi5Viy7cYyBYwXH2nwLQlVnua/DMXrhjG28rshCkN4aRMSr2OfVO88OjuV7xxgTfcda4ImyQCj7JDvZtYspFm4h7dU1uBI5gFen2TaIHjQ3MKlgvTdap+WINPZ57fXtq4=;7:H8rT01IW1Fh+8g1c5tQhfFxS2i3qSFpXvAU6FzMskwINsT17/SjBho8NV4eYDd5+fRtKddDWFkXYw2cMqgSrmWlPMQw+ippb+Pzc8YsEx9Hksdnoo3Xk4r8oszoKNxh6AouHiGXA/pWSaObs3RZwfA==
x-ms-office365-filtering-correlation-id: b0bd6e18-1577-4cb6-c33b-08d655478d32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5283;
x-ms-traffictypediagnostic: AM0PR04MB5283:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB528316D0378574983D6D423C80D10@AM0PR04MB5283.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5283;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5283;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(6246003)(26005)(476003)(6506007)(8676002)(8936002)(106356001)(105586002)(81166006)(81156014)(478600001)(2906002)(68736007)(11346002)(446003)(102836004)(7416002)(7736002)(305945005)(256004)(74316002)(186003)(6436002)(71200400001)(110136005)(2201001)(71190400001)(86362001)(97736004)(5660300001)(316002)(229853002)(2501003)(33656002)(3846002)(76176011)(53936002)(7696005)(9686003)(486006)(6116002)(14454004)(25786009)(4326008)(55016002)(99286004)(66066001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5283;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: guF+SGxqiVe4LuW/xk458wfSGCzwLqhUSXB/0WCUkEUPp5moKCN2tOuM8nHP8AqA/p02434Jn4QCscIGWewitN5iifIdkVRcyZAPuq3BtxFr88WiMr18GMGzWyAKdhX/OJJ4X0nDJ+wShEuCB5owLSt/77RoggCStBcvJ+3CG2KbkEUdz0zUQ2jZRvA/MnQemi6wSXK3LjVyE5+Si2HDK+dhJbLiBSAi+e4VvHldalSFz2WHOiY9+bPkssr4277rE5oiXHhots6JjlgYrU15cQUt1+/Ze9w0d+RKPeTUCv3DPCeJwMCUjw455NEeRtvOFnrYc5CvEXOU5RjHldwLUWfJlHQFTMbXCHZTXtEuP5A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bd6e18-1577-4cb6-c33b-08d655478d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 15:38:31.8516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
> b/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
> new file mode 100644
> index 0000000..d6e2353
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt

This should belong to scu binding doc.

Regards
Dong Aisheng

> @@ -0,0 +1,10 @@
> +* NXP i.MX System Controller Real Time Clock
> +
> +Required properties:
> +- compatible: should be "nxp,imx8qxp-sc-rtc";
> +
> +Example:
> +
> +rtc: rtc {
> +	compatible =3D "nxp,imx8qxp-sc-rtc";
> +};
> --
> 2.7.4

