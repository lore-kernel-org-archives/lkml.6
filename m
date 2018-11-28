Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA28C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5022081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KimJYZDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5022081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeK1QVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:21:23 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:37917
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbeK1QVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT2JqF0yMgAc6KQd1+Yu83LSGjpK+Ke5Qik9Bv31PKA=;
 b=KimJYZDiX/IYkbPLZ3NQiDawXxw4DbyMkcLALi62NZXNexdE0+X35u30HuYeSAa5pUX0bBh/Hy2eu9LWwemhhNgA6nWmPgqg9PG5K0o17OqYExLzQUUHuHqp77S1u3wkrzZ20n5h4AmUKDbpyTWCeCC3LvrkudGTMMoTXDNm4L8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3801.eurprd04.prod.outlook.com (52.134.65.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 05:20:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 05:20:57 +0000
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
Subject: [PATCH V2 0/4] Add i.MX system controller RTC driver
Thread-Topic: [PATCH V2 0/4] Add i.MX system controller RTC driver
Thread-Index: AQHUhtokUPXuQJ+cf0Cz9F69Hfn1PQ==
Date:   Wed, 28 Nov 2018 05:20:57 +0000
Message-ID: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3801;6:sn3BTYo/2PGevcX5iuVXtcsGPLppLUaQ+ahBOJc6zscENceqXE0Ucw+dBOa2SbjzTMS3Rebf8FqCd234EO8ylMnOkfESidRkp48btSKj/QxJkGQunWRr+S8zBp5THjjuhvBB4mqRMJLkTvGpbxCYGKHBCBvuX+SFBIBYqXqTWx9QEKvHy0hT2VU9uGMg41wx4lmGulZ7U2Kh/ONPD9JANmRtOgrWmY8lj7s+Okz4BSrjbSEgjKpftChT8N7dzz0IErVmZncZhDfmYUTqiAlnk5+G6U2vdVKx94WdKUqHETvrFkKDkEYHobgL6S5YqPTlwWgOHIg04+Y8Jz5dIIUC5a//3/QU/5AC5O3A0e1XbHYhvKKUVp2mKoF6g78fmi3vt9r7bQYn1VDQ3Rx2+59CpZtTlwpfyu/vrZw/itYDy0szEXO77QshB3Vxsa4mKamP5Pud3JWZOQJibGUGhj8h0w==;5:TFWtPy/UYE/8PVTOAF7bomHY5AYgp49VU6UIb0dSeQ1Wh6A/RXqe/FJRJptIdxYqnfIc/kK1fC6jvkkA25FzMgraDcKex+iN9oeFqVMReQ3/kJJ9ZktnJzTnMWQvOBGmNTTfGx6oTy5ouaVrFmE5HsGOLLVFVzGGc2q2a6RBHwE=;7:jWgwTltVjFkzHSCYD7Bnb4npcR5Ta3KiYBRyxzfVEhssnmmS0qdT3cIM6C8oU5ALLkK7gCp4PWPRA1Vln9BVaziXeKrsQCV56xxeaYf1q/mkgszRL2L7kdfJBVpcKX2shovPiV/uk57sKi1+YppZhA==
x-ms-office365-filtering-correlation-id: 85cf49c3-90d4-4a8b-f143-08d654f146b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3801;
x-ms-traffictypediagnostic: DB3PR0402MB3801:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB38014B6EA6F5D0D13F15AC57F5D10@DB3PR0402MB3801.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231443)(944501436)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3801;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3801;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(99286004)(2906002)(53936002)(5660300001)(36756003)(4326008)(25786009)(14454004)(6512007)(386003)(305945005)(966005)(6506007)(186003)(256004)(26005)(6306002)(52116002)(7736002)(486006)(7416002)(2616005)(102836004)(66066001)(316002)(476003)(478600001)(50226002)(81166006)(8936002)(68736007)(110136005)(8676002)(106356001)(86362001)(105586002)(71190400001)(81156014)(6116002)(97736004)(6436002)(71200400001)(2201001)(3846002)(6486002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3801;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /MSjxezsLLrzTN6bjb7MHF4CiZjAaUEW7IFFlFh068HnopN3TeITrDtcTd6PKBcNHzG+dbthmBnvvdNNX9sIlvuWi2m8lD4TFDLMudRBrBjbz4xgv76YRud2hdS5cG79LYwZwLoi6jvjyRDpZ9/UxSn5+ZEOMoSfafVJtGh5Q+7nwP2din4IPSDEK2LQTMhOPlwhia0f1r5iJGK9yGppjcxB/TWcBRau/1vMmL9Mqqd8Dfjzfgv1nA38BOqTGFdjSE7UrshyRWD92o8x/fZWWyZcVfXy6i2+m9b7IYkLBpTPgsNGrz28KMLfqNGcRfmnSU7rhNKYppiF7VDzj8pQqHseDsszBQpQn2QKrHn98QE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cf49c3-90d4-4a8b-f143-08d654f146b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 05:20:57.3887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3801
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
  dt-bindings: rtc: add binding doc for i.MX system controller RTC
    driver
  rtc: add i.MX system controller RTC support
  defconfig: arm64: add i.MX system controller RTC support
  ARM64: dts: imx: add i.MX8QXP system controller RTC support

 .../devicetree/bindings/rtc/rtc-imx-sc.txt         |  10 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/rtc/Kconfig                                |   6 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-imx-sc.c                           | 107 +++++++++++++++++=
++++
 6 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
 create mode 100644 drivers/rtc/rtc-imx-sc.c

--=20
2.7.4

