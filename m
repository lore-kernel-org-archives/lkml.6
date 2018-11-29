Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3A6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44083206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vcmCYSrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44083206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeK2NlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:41:08 -0500
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:65312
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbeK2NlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkysKFRfhAVL5uj3S4K47Mc3bgqAAhKc7eiq25Qgxpk=;
 b=vcmCYSrMpCsgdnN4qle+okLPbcieHkp1SVrYR4AFrhjFWc7oLaxu5X2IlqtbNntYqhjAMoXx+YSFdysxmWlRkTfexqn+Eod4eq4q69xhd4Pj8pgQIuTNNNDJMdmHGplD9p63jV7TrljkcEqPZytRFPJfQ3Sw1m+cLabNzSXhkCg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 02:37:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 02:37:16 +0000
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
Subject: [PATCH V4 0/4] Add i.MX System Controller thermal driver support
Thread-Topic: [PATCH V4 0/4] Add i.MX System Controller thermal driver support
Thread-Index: AQHUh4xxVvFI4zIfIUemJwHdzamWzA==
Date:   Thu, 29 Nov 2018 02:37:16 +0000
Message-ID: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:36::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3946;6:umCH2iTWW0m5gJemsBB9ZPXZhsi0IZQvG02/y/UInp2rbV5RcvMj5VHeT+fpchlXFUMineuDX/cKze3sViWewMaPrzcciOa/jNuG5lbRziOKwOw0N2uSgpCdgL+Bd9qtw5/Xj1RQB0Rs5J8zHeg3+PvlFSC7tVtntWY2RbFzSb+Jsz+Z0ogxBc4b4HnXz5UiufIrwNS9aM3nvZWDumX0jR76/jDZ2jG9rdVGW9Q6PQEJCgLgwkUWFcjcA8uS5NQaCaVSjKbnKj8iCm2HI0nJ8TuMavsxdBPw4HgSsJsjVDTxiUgjaskQJz/rpBFxPmXtikXybQUepHTI60jz1LThv0YVmU9EHIDNSX1EtL+pEPif0NcEMsSQDY/eHDpZpsRFsmSOfylvjjb9gKPO4Jz6fDwRvTcbAdwyspFuOqjf783iHbwJFs12NkX2p/zhBQaX9lClcyghvLUy7I+ySh18iw==;5:7tqxjaoh9Np0q5LrZEGMbcCbOBEkHSt/DMa48U+tBKps9mE7LeBszWteyShKKWf1cfuoMBqeLcm8hWwz2TdiToMUTJ2OIlbR8Z7ArUiC2pR4cFmUvgdV5bA+At0Q5jJdByT40gUb7rX2Cwj5Y2ktVfYWVIAxxytpOfJyuwLEIjo=;7:kG7qm9zzsffYWXBWPN27U5UquBtYGBwKGnNseNkuumBfZ+fLkzhA0TlmusirMvug9uoiDuQjaFMVLBDloAnPaSlM3Q3xJk6QABmW4GHgjhffSLuKJ2hbd4AhPPEZdGDEYCHINWvAVjudCBT3eRoDog==
x-ms-office365-filtering-correlation-id: 551ca580-3aeb-40c2-6651-08d655a3938c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB394673F88003F8835B887F28F5D20@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3946;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3946;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(25786009)(50226002)(966005)(99286004)(3846002)(6116002)(478600001)(8936002)(14454004)(2201001)(52116002)(316002)(102836004)(106356001)(86362001)(110136005)(186003)(2906002)(26005)(81166006)(81156014)(8676002)(386003)(6506007)(68736007)(6512007)(6306002)(7736002)(6486002)(6436002)(4326008)(66066001)(71190400001)(53936002)(39060400002)(36756003)(2501003)(71200400001)(305945005)(256004)(97736004)(105586002)(486006)(2616005)(476003)(7416002)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yppHZjpMOyaxamsiJlv0ZTlFe5mZ10Nc7lElYXCVuU51JWu6s+mQsiIPc4vINqGoxhtcnqpyx/qhP+StBhWHno6zikdMEa3DHezwY76VPdYh1BktYinPE4jR5UFsKPxZ2ZPFvFC5iQqEvP5kDOiEWYIk2Mo+ZYvT0Pd70Psk82TDqy9EqoczNjHSOGGyBxFr1kP2bHFf69nlERawNgcDugt0/GFHJPRpWe1G1QuWD1GIpk42ftkgHRl6eX7vhXAeoOEs//fecEDWl/A1Qayr8FlpRHwbDk1E9VR9a3Ki7fOcIt6Vn0W314C/HvoPadaW5dpjfIJkKQ/U7usHPI+aduyHffUs124xoEV8R+DDvMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551ca580-3aeb-40c2-6651-08d655a3938c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 02:37:16.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
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

Note that this patch set is based on [V4,4/4] ARM64: dts: imx: add i.MX8QXP=
 system controller RTC support,
https://patchwork.kernel.org/patch/10703779/

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

