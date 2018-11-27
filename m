Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54ADC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84401208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gfNM+yFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84401208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbeK0Uix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:38:53 -0500
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:59447
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbeK0Uiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4Xlufmw5b/IDdhRMc85TSkuWHrq64HPTguf8S2AwY4=;
 b=gfNM+yFcjKx0tryV5hOLtWIELXEKr7hEewxhBdk/SMQ1xLY8tPqGWv8aIKqlG9A9TSXiQUuxF6HoY5wRmKz7gdTJXce8aGwGjBo/ODqJ5sSYLKObLx9oHEY6CKmsxHEFyjQQywknP57igCiIrPPChhbjaCDNHZXmXBEV9NXS2hs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 27 Nov 2018 09:41:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 09:41:29 +0000
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
Subject: [PATCH 2/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
Thread-Topic: [PATCH 2/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
Thread-Index: AQHUhjVf0Vc48JnDTUaHXid7V/C6SA==
Date:   Tue, 27 Nov 2018 09:41:29 +0000
Message-ID: <1543311334-8807-3-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3738;6:iYQEuzj7V1kRNdegA6sxV40PbleMVxswfDr7u3jqb6LPljLtn/j5Y1hiFecA3rB4nFnIF39QpGmcx62MvHWxRzYi1ICepqIe4BjYfSpScW4aiY5/D9d44LrqoFiD4DjWkwnvOVMhGWuz0d/gzOIsumXT7cDsQ09UfIkmyoJOFF8QCVjDqU9JJ6FQBRIwjmQN2Q45AqaDcLmE522b2J8sSFttdmLvR4pZ0S4wBEWN2jDYgJPVMmu4FH8GiCADIwcSTGxMAi0FMYy3SYFA5LaUB6WBLOGce//gwzQTgprwUmXiBJVwuNbjLC200Nc/Ch56B9w1H2DtXfPnmxJQTTP4Z6kBkHEgneuk0trB4yLBR7usFuwUyT6SSBLI66xuB0NOamdn16jR+X35oX6pAgBc5lzWZMrkyBrnZ09R/g2DoU5Q07r8EdfmHve5/Ydep3zLlfNopIDEdw43oPucSdvUeQ==;5:z6N9GSDlvHVf/pDFnsU/cRvpKz4EOUYph0azNpmwaDs2A35znPS5cBwb0DB8npWnvrgafri4UAK0I23youCmIaKI/dN/kDqY4I9bLzEhyTjoQ64hq0pRLmBqlzJTMzXECzAyECEQqnGq54rRjBj4jsww38R3aaIyhbwM9TNxW50=;7:/N8Wf/EIbFHXBKwVhQeegSa7DKCxdj5jswvbtf95r+g6CYr1GjK8GpJ13ZTOGhAF6lwC47T6kat1lY1HP1ULE9z/5yXpu5PeyA/2Rw9YCH8zVUiaHqMT0OMaAHq1byuySMEvAQFMbkn0yzZksrImkA==
x-ms-office365-filtering-correlation-id: 2db1a1c0-c80b-4233-4a1f-08d6544c8104
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3738CBEBDB3C370923FFB42CF5D00@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3738;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3738;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(186003)(102836004)(5660300001)(81156014)(81166006)(66066001)(50226002)(26005)(8936002)(52116002)(2501003)(36756003)(71190400001)(71200400001)(68736007)(14454004)(486006)(53936002)(6512007)(476003)(2616005)(76176011)(446003)(386003)(11346002)(6506007)(6436002)(105586002)(2906002)(2201001)(86362001)(97736004)(99286004)(7416002)(106356001)(6486002)(478600001)(316002)(305945005)(110136005)(7736002)(256004)(25786009)(3846002)(4326008)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ix28hccDmb2oc2ww/brT91DVcbiywdw1QyAWsHp2foKftOBAwUtYvamF07civbj1D8tX6ZyU9qN7oBze3DgPNLcGIhk/EEuGEF91ZEHKD9OZq9WrOXBgITyJMGR/gHjLf3K112KapqcywJH86xoWFHkcXAfiy8fzwpecLVrZo6b8x5uzj/5dA+DWhqbpGn7ai8frY2PrBJcjMN6JPZBaEeosYfg+KVuwEdHGQtNppZfUGYLozbaqkdTn2YlCCKoPM+INoF+6Dc2q7Nyf3q4SHYA2mknLZZcULAgox8pMqrofFeT21p8ykRXK9B4JHB+2NmrQob+mpd1LJGTlWcGktDYJXZQpt749MhdI0UgP2dE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db1a1c0-c80b-4233-4a1f-08d6544c8104
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 09:41:29.7981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
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

