Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84970C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE8B206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l7hm6BSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE8B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeK2Mxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:53:40 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:22432
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbeK2Mxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKjfdlfTufn/6WM5DbBbvEtt1I5sJDVpyJNBXPNoL+w=;
 b=l7hm6BSp6BKDva9pZcuiatB3AdMIqpR8sJkIPu3drc0jN4b3VSuvv/vLv9H5pnrRc/wmpcUDGcNYQbjkVWDT6CnInFEs9VN1ZLGJ+ylxoeZC6L6PsaiHUxHrzH/KhgmGNZhaDoeQ/r7AqyN/wytSM2AxXimrIm8ECcDpUz2rzNA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3930.eurprd04.prod.outlook.com (52.134.71.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Thu, 29 Nov 2018 01:49:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 01:49:57 +0000
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
Subject: [PATCH V4 0/4] Add i.MX system controller RTC driver
Thread-Topic: [PATCH V4 0/4] Add i.MX system controller RTC driver
Thread-Index: AQHUh4XVDagmHqVV106EeG0wt2T6cg==
Date:   Thu, 29 Nov 2018 01:49:57 +0000
Message-ID: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3930;6:FehLTAuyB6MlcU52fscn2en1OistGiHClUfIu8et2X6l/1yTNlEJmTvO5EESkCxA7DoY/6tsId87W8l/P7mtqP2akCT8sGfUheprKz2SSxieUq6hkE0Gb2+oPNIjwRaX8K2Vmm0WTqpiZXR1xUBvPCkZWsQpLxSZT1Bq9K+dxvg7hpQ9/DAfGV4WsKDdi6orUUbbevTmDlIyEYLsgYObGclirx/moWZkdgbdiQY9V+ekToabmGJyke3RQlybyAdJ8gCZKcXcgTbsNw9ia8BQUX6tYTxvOaYbUsdhWC2/uQR+i81gu+irYIeeMSK1WYEQ1TXnKiFwHy6juuYjnkSEpQO6tgOhx4yI4BGueRYoYK/Wt+2PX28WEZwE+Tml60hf36u1omeg3PNpBW0HIOqpmUIF5fdKGnrc/4k4ykssgN4Y07KAvE0OH0FWVzuEi94WXcAekriMsvsk0v1pVaPgiA==;5:7Fd2eYZ6VxyHa0RHHpTVh/csTsDgcRpcfanNklLjD5aRTFUj8KVMycJmJy0gtmBt3mjaWYjTQVOeq/D2JVU7tBClB5PjIhyezgJQeLT+0OaPQ7dIfwl8lgV2BaTUFODlm56S4u5PpkiHmBTt7GZNgWj5ubygTHM++ceUjjlhgBY=;7:jS2QMXbVJf6BraZ+VpSYC1W4cJgYIqj6bLFVuoCM88gvPHjO2msDaE/inTW11cQhaDqdQ++KiQO49yMFNt4xERsFuHdFV9Bs6juZaYJtDms/eaIGb9vUZ5yNHf01Rn67aJSixOQMBfS/unrO9jfwxA==
x-ms-office365-filtering-correlation-id: 6dcedd22-9b76-435d-b4ae-08d6559cf737
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3930;
x-ms-traffictypediagnostic: DB3PR0402MB3930:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB393067919D57DBB2EAFC6FA4F5D20@DB3PR0402MB3930.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3930;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3930;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(366004)(189003)(199004)(110136005)(2501003)(316002)(3846002)(6116002)(52116002)(7416002)(71200400001)(305945005)(478600001)(25786009)(6512007)(53936002)(7736002)(14454004)(99286004)(36756003)(5660300001)(97736004)(4326008)(6306002)(86362001)(81156014)(6506007)(81166006)(102836004)(8676002)(2201001)(68736007)(6436002)(6486002)(50226002)(386003)(2906002)(105586002)(186003)(106356001)(2616005)(26005)(256004)(8936002)(476003)(66066001)(71190400001)(486006)(966005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3930;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KwQmLuHl1uqba8Mdd17CtTbXdwBWE3RlYHhwlQxzG4sSpcie9jFbY+r/lqWvw/HpYEtUki2QDaCjeraluNTcAEig+iuKYKhAN0R9uUK1wW+8tlXzIP9jUGhvBc13YHqmaR2IQE9e2BrAKrUwkFaYR5DOVhFDhkPnapqF4VxU4kAU3Att0vuDM0lfE8uwOv9KK1RVOnI3N5JP+yG++2+icascW8qqdKTrpo+uzW+zwo6aCmJOZxyhZ6QiVuwlXvAlgv0VRYKyvl2tLAJtKvPoXCPP2t/xIFydbIr5xMPdqhmsM5m0/sFb57YRnzgI1CKMy5z7ysXDauL5PiEfYj0vvE07TcDOTxWJJWfy74621DE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcedd22-9b76-435d-b4ae-08d6559cf737
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 01:49:57.5386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and secure RTC etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to do RTC operation.

Since the RTC set time MUST to be done in secure EL3 mode (required
by system controller firmware) and ALARM functions needs to be done
with general MU IRQ handle, these are NOT ready NOW, so this patch
ONLY supports RTC read time for now.

Note that this patch set is based on [V4,5/5] defconfig: arm64: add imx8qxp=
 support,
https://patchwork.kernel.org/patch/10677315/

Anson Huang (4):
  rtc: add i.MX system controller RTC support
  dt-bindings: rtc: add binding doc for i.MX system controller RTC
    driver
  defconfig: arm64: add i.MX system controller RTC support
  ARM64: dts: imx: add i.MX8QXP system controller RTC support

 .../devicetree/bindings/rtc/rtc-imx-sc.txt         |  10 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/rtc/Kconfig                                |   6 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-imx-sc.c                           | 104 +++++++++++++++++=
++++
 6 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
 create mode 100644 drivers/rtc/rtc-imx-sc.c

--=20
2.7.4

