Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B777BC04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7733E20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vJ3HYgCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7733E20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbeK0Uif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:38:35 -0500
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:20448
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbeK0Uif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKjfdlfTufn/6WM5DbBbvEtt1I5sJDVpyJNBXPNoL+w=;
 b=vJ3HYgCWFhotPr7QtigEN3Z25v+phbISfxA9xtX7bNWLjA2870KLDtra1mrbgT7I8rGLQWrwNlQ6MAqs3sUz1cfAg+4MECzxfMqbosUjONtBYufgd40yCR64BIcFKV02k/YTw4eeLQDZ8zm3dspWoRe00kDhsYQJdMw8qKDWoUo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 27 Nov 2018 09:41:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 09:41:11 +0000
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
Subject: [PATCH 0/4] Add i.MX system controller RTC driver
Thread-Topic: [PATCH 0/4] Add i.MX system controller RTC driver
Thread-Index: AQHUhjVU6jl3KJhLqE+zdv7T9wSDsQ==
Date:   Tue, 27 Nov 2018 09:41:11 +0000
Message-ID: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3738;6:vGRPrl0piuInLbqEMkc04+fgZgdqM0ZiFcbiVrVaFBR377rtwg/sPfx6UC5RI8f3pbXDmi+mB5rxrJ4B4+cZvHOS9aN0L2iP4sSXv5NGoraZekHbZHFyaZ2m+7ouZzbsAoAVIq/bh3UcMVExDWh0Gi3NE17lq/v/0HfEGeBHBzeczgCn9TVlU3jYGwKcnvpYE5c96bxbjmbwb7RjTmn7U25My2HJjRhk1EEj9nB/N/Kpt/fxiY84oktmGYQ71IXCQ1+mIwPr67CugomUyUhGJ/MAu5UGBoG4sG80pqx+K5rt6boOtSHwkf+/BeZbPb3CBEoQW6X5gOxRr+PR1qCaZFtJOdXVQBqoXaMbSc4HtMEmR+t+4rXYfDzDo1vc6k8k9iXKBWS8vcin07mRAkOKpRVNvoTlqdMWSygcME2GUkw+bM+8UphUK5/qgGe/7MmEEPVOvmY5kyN0laZfq+pFJQ==;5:3GuwLpMW04H3VDnPdx9Ou8qz8fnkb1HGtVjNRWNDx94NnBYvUV7sWcvLOCOU7FOv1dI+Dx8tKrx8luh23yICSzlJGFy/5r1EeIksVUC1/r7Sg3IAWQalVDMavPq1zoSKL+ks38+ubiCRCGVHK7yQM8WABDNSSYjqROVTg2O/0CI=;7:3DJ135fksSU0ZejzygT5KC0dq2FDwFRcExzp9NyAKUf5wmuddYkIviUJIlG/3DELSPEczNrXiwSl9x6SdlMNjCraNaF9oUSkaMTtqOkCjh2uKNSD9IYjoZuzAbE8HHDRCMMw+VoqXC/2HFIIWu5JWA==
x-ms-office365-filtering-correlation-id: 3c461997-e0ca-49df-2a2e-08d6544c76cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB37384B7B062B54AD503EDF87F5D00@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3738;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3738;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(186003)(102836004)(5660300001)(81156014)(81166006)(66066001)(50226002)(26005)(8936002)(52116002)(2501003)(36756003)(71190400001)(71200400001)(68736007)(966005)(14454004)(486006)(53936002)(6512007)(6306002)(476003)(2616005)(386003)(6506007)(6436002)(105586002)(2906002)(2201001)(86362001)(97736004)(99286004)(7416002)(106356001)(6486002)(478600001)(316002)(305945005)(110136005)(7736002)(256004)(25786009)(3846002)(4326008)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YgQHp0LcqBL9ZGLhiLe2VoRKn8wffG9MK/uz3w/Tje0P2Zxk+KZdv+I8MmYI/xuOxalyExVBmOVp62t/KIwucU4yFMYuLHINDgrNSsNLThFQmtHPZzfDaabpq207wLvfY0M5lwSbBMqs9pP1pNpPHS5xHZc4g7nOki7IzC7vIXtZZ5ug7OIkc3jZ0Jmxzki9rg0tlVbEgNTq0H45l7bKK88Iz2ugaTwnLhdJUW4up0+r328Sb+dNopFWJd4OJt3Z5LaBiSHZebRaQwCHgdtblPry+OjaPA7ijRgDdZd3BaKGsrcdwwf1wKKZ6SIaagCnefnxi1uvOjkeAzCgeeO+XRf0e3rwLMMXNxy/+87JCg0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c461997-e0ca-49df-2a2e-08d6544c76cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 09:41:11.2508
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

