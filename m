Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6461521773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KH/08A9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeLTJIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:08:23 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:34944
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbeLTJIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/cQkhYhYXaStfF0P+6zYjWvjofu1YSjGtlDIMaWE7U=;
 b=KH/08A9FWNMSAutgcsgGxxXqJ5ztYkHroDgvOLtg0yfOeROfvfOT2LuTMwZWDR+zrbFt43KXRHf4QQkPmB6hIW0jjam4/lRLe9wjOt3qlcBBMqqjggHZzltQEYukigvqa/PnySO9C+lGaJky0tXBQgjsr8KNmKrI648k6lFZsHo=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3528.eurprd04.prod.outlook.com (52.133.19.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 20 Dec 2018 09:08:14 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 09:08:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 0/4] Add i.MX System Controller thermal driver support
Thread-Topic: [PATCH V5 0/4] Add i.MX System Controller thermal driver support
Thread-Index: AQHUmEOJmp9AQXTm70mHTxMvZlwcZA==
Date:   Thu, 20 Dec 2018 09:08:14 +0000
Message-ID: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:203:72::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3528;6:PP61ZDOMQ29mnxdKx+/pL1+Od0MNq4mOTPZVP7Y9JUvDlKsMVN4A01gfaOUu1y8XBk3D6AB68FExmgQAGapnd4rw7gGyJKFFZRhvHrDiSIaLyrtGKrSYWFXDKCSq6xR48JbygIB0R0JYxaKwhHIU37XEoCuJM45UyusBAnHOnOlHgNOh/QSl1rFosLpITCQCaXbhtsv6tI+E4hbacasRV0imTNKsbwZIqVqRH5UOLZp6MBypD7bMHMhVeUry6KQHUrh0maN918hQ+rzwKW/iPRnrIj1tVPz5nOH/9L0NOHao4dvxw7RUEHYswQWar7AKccMrLF+pDKn13i619gTumqyig8hv2wM/Id6ECt+as6ZHr4QXydKsg481IXxMTrsl5OyWOz7YyYwHG0UGgQdu+Mm0JoxH76peveBvGeZyrTIJliLb9JAkD28T/McdA/sRc3yD6WyvLASt+tsX4tYUog==;5:oLQu9m1qDlck5Ag6JMt+fx2I1YMjHyO1VwEGaDMYHyKs2hUHdN+n96QhLnbPFybA+OQIHxetoH5hWp9+H0jxVgr+CAZTXGj0JX5NaJtgCQeZotYacDQZXQt0ewJ5Fhvq4aUY/GWxkq1k4QbQLvEZN3Z1h9+388ox8Oafnz5/npQ=;7:dJUJMJ+6t+O+5OBSUCOCPxOGR7IQrf+9Vwb5lLKPPpVF9Wl4ZtS4M8z0WbANZzqdooGalZZ9EaTljTJFrp4ICHzbFteUuTwxonFCc3K+cXaO8DgzegJLAAZL454HQKIOp/gwpu0/fsYFE9ySTPTuOg==
x-ms-office365-filtering-correlation-id: 5999e55f-1747-452d-b2b7-08d6665aac50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3528;
x-ms-traffictypediagnostic: AM6PR0402MB3528:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB3528EAC9AC877A7B4B975427F5BF0@AM6PR0402MB3528.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3528;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3528;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(396003)(376002)(199004)(189003)(186003)(81166006)(26005)(478600001)(8936002)(50226002)(8676002)(102836004)(6506007)(386003)(81156014)(97736004)(99286004)(52116002)(2501003)(71200400001)(71190400001)(966005)(110136005)(14454004)(3846002)(6116002)(316002)(305945005)(7736002)(66066001)(6306002)(6512007)(256004)(105586002)(106356001)(6486002)(53936002)(68736007)(2201001)(86362001)(36756003)(7416002)(4326008)(6436002)(2906002)(5660300001)(39060400002)(476003)(2616005)(25786009)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3528;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RlYRP8jWG4R/SFiOwtVEpSu41aK9btuM/e5djr0ADSE7Ro/qvfCzBgc7zAUnot7UWRcKjDR/Y5foITnncVxqGjkGElrPHwT5bIGBnSmHEeVTDcqzBgDUkmQJZSw8EBvGK3YhqIq3yMvQxqzg94XTmJ+T/voy6zToAYzqLc0/Mu99fTr+jssQC6/q1BXDWLhyj880ZF1Dq5/kEbEk7FKO8BrlXogU147Yt+qdYjHOZvYnQIhk2WFvl+iUwalxaQThrO4M7hRiRnNAZYFLjyGgLHTdBvXQ3Eh2geePR7WHoKQmghuSn8NdZC+9Rq4h/k9g
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5999e55f-1747-452d-b2b7-08d6665aac50
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 09:08:14.6975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and thermal sensors etc..

This patch adds i.MX system controller thermal driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to get each thermal sensor's temperature,
it supports multiple sensors which are passed from device tree,
please see the binding doc for details.

Note that this patch set is based on [V5,4/4] ARM64: dts: imx: add i.MX8QXP=
 system controller RTC support,
https://patchwork.kernel.org/patch/10738681/

Anson Huang (4):
  dt-bindings: thermal: add binding doc for i.MX system controller
    thermal driver
  thermal: imx_sc: add i.MX system controller thermal support
  defconfig: arm64: add i.MX system controller thermal support
  ARM64: dts: imx: add i.MX8QXP thermal support

 .../devicetree/bindings/thermal/imx-sc-thermal.txt |  33 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |  27 +++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/Kconfig                            |  11 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx_sc_thermal.c                   | 201 +++++++++++++++++=
++++
 6 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-sc-therma=
l.txt
 create mode 100644 drivers/thermal/imx_sc_thermal.c

--=20
2.7.4

