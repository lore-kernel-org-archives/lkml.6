Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E239E2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pblEkdoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E239E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeK1Q6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:58:40 -0500
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:3520
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727150AbeK1Q6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT6cvNhCuPvemCn0H4U6xRmGaJlXgiKEzgJ9SiVa0H0=;
 b=pblEkdoaZ4HHoBQgH0/Fw2MJWJ33Y3cvJPUzMx0ZfC0rtdjMTUlqnnMx55nlxaRW+cifX93TuTCu8KwY+HEdRtm5Pe8sLvyiY9xYkssdxebTcdYfUt9H4iSXZ9CgZJjRvUfuiN25OHaJULugwlKu19jHyF20j81AkJKrpWsisck=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 28 Nov 2018 05:58:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 05:58:07 +0000
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 0/4] Add i.MX System Controller thermal driver support
Thread-Topic: [PATCH V2 0/4] Add i.MX System Controller thermal driver support
Thread-Index: AQHUht9VQMdv+sp8CUCc7mlqurfeSQ==
Date:   Wed, 28 Nov 2018 05:58:07 +0000
Message-ID: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:2e::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3738;6:L+cQFCo0XuBel1+No2XMSJaCw2GsjrvH0s8wCSaDesCRCUN0imF658YnstqKEjGhCH1hqH1zRIJHtza3hHp3KLMa/Y209M/ZXua1XHXvVXr2L+kRNHS24ELClHLhzRCO/H0w3oGLWJugGfQpEvCtrzPtw87XHjOYtb4h2fpVqs2NYl4ro78jX7eNmDYahzmXvQx6u5BkIs3BIVd4QPjr3p+P3u02Oc0a1n3OaOc4IlU6PoXu3LvgnFlg0JT4NFhUBvzDX85snGJsWMr5fN+8oA8XzVgANtowiL5phP/+7zb6VM3SxXmXljzyu4zK7iRTQ8bVtajG1Lygi0tCIyCx9StXSXXYtSkGJxLrh9Z6CHK0X6oQmUzYm74wCKQPBbA+P6COkxZPmBjh/qZyZSpUY+maPH7JGPhmgtwWyqPXjVzBzpeeNi9VLLY5ypNdPCJ4fiweDMGVSg2fynSO0svSzA==;5:z/4yeRmID6fwkYWVfStnrX+bQrqjHklLTX8vZpCN6LC8XnJwixkXL1/fnfLHSuvAvGhNLx89TLNNdg9N093xTYk0PFLFvzkL0JCZGu4aqNzTEGv/xUIjMwdZK8vxG0PdRursQTaVOL86oJs/QyYai/pKr74idSuLwi+EeqI9U7U=;7:RQL2wD7KPSuFbKsBQRyiM6Bkm5ESHHY4ySPWKdXQanSpM5JLXMcfQrkQc9Snovj66ZZ1ryj/L1iMwZYToo4FAeY0/uM32JR708bFUBmZQgg/ZZPW5Oc9LEZZb0QqJz46w5bbPAieiiSOj5H/irOUiQ==
x-ms-office365-filtering-correlation-id: 05d5347d-7429-4723-2f02-08d654f67839
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3738D978508BCE2B46D4D639F5D10@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3738;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3738;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(305945005)(97736004)(2201001)(86362001)(6486002)(7416002)(106356001)(99286004)(6436002)(2906002)(105586002)(25786009)(4326008)(3846002)(6116002)(478600001)(110136005)(256004)(316002)(7736002)(8936002)(71200400001)(50226002)(5660300001)(81166006)(186003)(102836004)(66066001)(81156014)(966005)(68736007)(486006)(14454004)(53936002)(386003)(6506007)(6512007)(6306002)(36756003)(52116002)(476003)(2616005)(71190400001)(8676002)(2501003)(26005)(39060400002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y3r3E5KLfvyFk6qxb2A2GrDUpuDOUc59c69koxmBVTaEqXRppHnujmHbtsz1Kbl0ksBzM88+6xurA/GJZKcENvuKsmMDwE7K1/tGwX1HQaYKJNTTLNWbnnvUGI02jHr2S9kH7AbARs2CXYIFIkfRTm4p7bb6LC53+xPAzZHEgHqoCjnzzaTbkMNJOOBH/SNgEuihUmcIEjosp9fx3mpNjWU2rfA6iuwcY0aNkyi7tEAJkN2r+XyCdLkfTq1sYEl22FUyzDmSp2zu/fFDQ2KU02cN6HcXCGHMDd+VDR+ZhDdeRAE48FGm6sNEy+XIVW8MJhqYMImuopICjhWalV/kK7eB0h8vEzA4TTDlYns039s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d5347d-7429-4723-2f02-08d654f67839
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 05:58:07.8330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
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

