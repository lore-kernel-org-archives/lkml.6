Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81249C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1D22081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQ20PaFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1D22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeK1U6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:58:40 -0500
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:34688
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbeK1U6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPSaXWgTowlA5S2Rh71Mw8ppwB54VUFWsX9R/gx3eNc=;
 b=bQ20PaFI7eMmHYPZc9TObExHnSlMl2FQTsoQ+LaOTDD2y3o3O2ZgHSMdnu0ITPuTIek/ICKQfe325jedXhyY4VD70fPgeBTgdjgQD+T79EirazODd6CHm3KbrIps5/fBzUn3Ni041prW+lo+UkhhgLZR222IfKgKPBf0GvDdxMs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 09:57:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:57:22 +0000
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
Subject: [PATCH V3 1/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
Thread-Topic: [PATCH V3 1/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
Thread-Index: AQHUhwDCSGlp3Rd9xEaRNKXRQcgHYA==
Date:   Wed, 28 Nov 2018 09:57:22 +0000
Message-ID: <1543398696-3140-2-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:5dBL/80nEAWxYXRyG3pEJiaqblK3agpPUmczPjG3DzMhHau7Y0Q6SbmzYAo6UFt0Cw4btcO526Lrxrsyz4O42cbHQsplbEjj+kIc+BnlyY+VpejjnGn/pE5H1iphNVVL9n602Fuw1nQjbANmiXYYu/s2nQcT2PUYtaRfO3k/bcUsMXMraiqV4p0fJeP7eAchN0ZP/eAu6C7OJu7CuH7Mvpn/ShDoF9FO78FeCzj767RhbMtqCfdf17834duZTgRi4xlDLJTdzFCGuKHY/03x6TJ26iK75qiMT6/spa1J4BapkC0fOmYtcCk6rn3CQ7iLhTS0o3kWtIgN51j4vjUqlcJ7QNzqnJpw4/DDN+f21ZqMAQZui9Cm8/4CF2J+JY2iOrjVg7brsUAmNy5HjliIXkORou0KLgBYXsaOf8Fdz3VoKkzOkhYfmObSnmQ44H2LiQEgRA2UM7nvBf6EZhKLVQ==;5:xjaQ0E1+faEfwwZVHTRsyjT60BXE0pjgnec/CRTnuDAvoTObnX2JQZW7WKpycO+geAtbIZ8ScKIOV0zMooWxC4IRZCO3XgThiDpkp+YClssdxfNTFS0e6p1PDUDD31FV6XkE0VHUWiNIXnmrC+605NQ8yBFFXmpIcaFbq4zaPjs=;7:WvhUdkwtwm2TBekDd+eYvL1LKQt0U+k4FVZQn587UtsMkd0D+h/4CQN5OPGMRW4DB5P6pyfBGxd7f/k7g3xBc5Rl9s73FHGMfUXZaMYY0YyP52QZP3TDqCs8rz5RJl7rLT4ercYzay2hJsHApEjbtA==
x-ms-office365-filtering-correlation-id: 35e274b8-a222-4f95-64e4-08d65517e438
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3690CF3CF4A81E00F43A2042F5D10@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(8936002)(50226002)(106356001)(256004)(8676002)(105586002)(305945005)(81156014)(7416002)(81166006)(71200400001)(53936002)(6512007)(25786009)(6116002)(3846002)(71190400001)(446003)(486006)(11346002)(476003)(2616005)(6486002)(2906002)(86362001)(2201001)(36756003)(186003)(110136005)(97736004)(99286004)(52116002)(7736002)(2501003)(14454004)(66066001)(68736007)(26005)(6436002)(386003)(478600001)(6506007)(316002)(76176011)(5660300001)(4326008)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wdgNdNwfv/ShWw59yVmvFJdeZGv1BNeDYfOsbFesfJnSyei+RyKRN9CGcrXfnGBTFQnWL84vDkYGmVZN/hD/t9EWAEHO3WGyRb82mgpg2eN6F93+Hs+tw1gHuPHqTT8vls/QTw6NwDmxXsxHwnMLhSm7rxLSB1OHyaYXn5svsqQ5PoB/fN6trbrj1wNWi7cJNQgk4H2V0IZXCSz0SROZzBuBbADwamk6WhnVZnqrc82Kkc1KsvKQtKpsoozjVkbare11d9PiOqeFIOA14cmMw4CINMVj0sQgWp4Ts14Nr+MBON0RB2/F8Z3ELlz2Q8en3mtgEPrigPzZE90MfGJsnsqnaQ8oq2wqbDeyIO+y9oQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e274b8-a222-4f95-64e4-08d65517e438
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:57:22.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and secure RTC etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to do RTC operation, this patch adds binding doc for i.MX
system controller RTC driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V2.
 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt b/Documen=
tation/devicetree/bindings/rtc/rtc-imx-sc.txt
new file mode 100644
index 0000000..d6e2353
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
@@ -0,0 +1,10 @@
+* NXP i.MX System Controller Real Time Clock
+
+Required properties:
+- compatible: should be "nxp,imx8qxp-sc-rtc";
+
+Example:
+
+rtc: rtc {
+	compatible =3D "nxp,imx8qxp-sc-rtc";
+};
--=20
2.7.4

