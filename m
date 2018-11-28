Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC862081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sVKn8b/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC862081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeK1VAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:00:06 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:14095
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbeK1VAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT6cvNhCuPvemCn0H4U6xRmGaJlXgiKEzgJ9SiVa0H0=;
 b=sVKn8b/bWG86w+tc97kv7LsAg99b9AglSqW0WccqsRO81CGKCBenuaOaCvtE/ZvknnG6hZ7C6N9cF8PXbKR+qyiZQ7fI+RV8WCGQDmBIdnviB3Hrc3aWwKZyhv6fctEUUGZ9aqQjm3CS/D/3+zH6qgRvvA3bvFpcCEHB+TdlJAQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 28 Nov 2018 09:58:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:58:43 +0000
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
Subject: [PATCH V3 0/4] Add i.MX System Controller thermal driver support
Thread-Topic: [PATCH V3 0/4] Add i.MX System Controller thermal driver support
Thread-Index: AQHUhwDxUnlqLSS0w0CWDZfX858ZtA==
Date:   Wed, 28 Nov 2018 09:58:43 +0000
Message-ID: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:D7p7jIXzLTM1QVgMkJCRnRQ5p5DA2AytKscnVclIlTMQVVvlWT61Pt/cWXxPS2HOM37g61rRxJBs1Yaw7xQzFsTPWYY7aDdGjFn5vU+J44OF3b3IMsURS+8aWQWQIhycKpCHtkXWtijYsRjj+qbTDmp5MS8hPI7IYB3MqBEPLXesXzyYPeYLQwKwJ+urvCu4hpLZ7YPz3yvvnP3glktXamYs/Jnijsx4nFjLp9FjTRxYFNUWeRopFh/woQR67KmGZ5FP0IjkII/cRmEU/3KDNr4GQVGrVZBLItvpGVGs0EEtnb/7tfszc9RIDIewwjitHnOgnNTUWSIhgp2/fLo1Lqak9S6iDjhLk2OoJV0zHP8w6oJJtlNRlkrpwQDXDR1VKQWCVL5BqzbyPKqAA9YrvNci9lLqZt9FQKd8STpmx2XE+jppTLk0G/6WPfikaUhDKOPBbbLtldFJQnSRwpgUQA==;5:M7wTlITcJ6EIln0NprXtqErQdJVxhylGBrAOj24bKR6OU29Vcls4khWI9MURUlXEHjrS05xLHcXe3hO7nVLILlp2YMgRKZN23xRnDhHnf7h/o6tAQkE9it+3ZQS53mTKJxblTVWXHWdgMH9U7c0gV5xIOSBAr/+3qpNv5iq2/sI=;7:8QVEQo+6yzrzr6Ly39unaWG1XzRYUAB/G6uVO4xu7PK21+c3QKuX/h3i0AgYUsew3RnHjU3BGEqLxtIg8GxVqGCJ+hu483xXW632I/HUhEtYHd7AtyLNC7XlK7l+W0ZoGibE7/ulI1dOUQMm/7dXQg==
x-ms-office365-filtering-correlation-id: 84fda4f1-8ea2-40a4-860b-08d655181425
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3659B594C7FCE436B893E6AEF5D10@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(110136005)(4326008)(97736004)(186003)(6486002)(6306002)(102836004)(52116002)(53936002)(25786009)(2501003)(8676002)(2201001)(26005)(8936002)(39060400002)(7736002)(386003)(6506007)(86362001)(50226002)(478600001)(81156014)(6436002)(81166006)(7416002)(476003)(36756003)(6116002)(99286004)(66066001)(3846002)(316002)(2906002)(106356001)(68736007)(105586002)(486006)(2616005)(71200400001)(966005)(71190400001)(305945005)(256004)(14454004)(6512007)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HKLpCEVL5QdXzbnip2mt40TcCudsXcc7E3TeHT1qeiuDIRWqxOutklpKd5TEPwKx2/bly/+Y/A8HKbeFlQqPP80J2lynH0vF2PzhZ9qvgPxdrmpaNPI4TG3LjX4Oeui22KfoC2nmWolz/Sbt71PfedqiDYd/R/zckZf7+yN8cjndjbpkLxOgAgGNVZnjFE9C+A6qx31kyMc3yVCWi7s8uCAMxsHGvy55lKdMUXZKPKV/zjoS+ORamPVYWGEb26p8YlXzd6UE/igUYIFp6atJVqdl9p/nudjlqkeCeQbwDZfwG20B7JUCzPEM54QrfRFFGsRVdMbr49emzjBY3+RVeByTMAY8kuKIRwGqklVnNHc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fda4f1-8ea2-40a4-860b-08d655181425
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:58:43.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
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

Note that this patch set is based on [V4,5/5] defconfig: arm64: add imx8qxp=
 support,
https://patchwork.kernel.org/patch/10677315/

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

