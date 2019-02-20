Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A08C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1482086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pMLQZUQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfBTGxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:53:54 -0500
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:28160
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfBTGxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h39d6OETW+XF/DF2IuVoHWRDPyvZ9O+7p8EqrqU7GU=;
 b=pMLQZUQNb2mzhGmkhQSLTLnV1xwJyCaKGMQrKpa29icJf2kXNzoUVdy9YyM6PSJCiDaOFnPF1KXs45RC0pp4Qakd+ZscPQGFTdo1MT1narMcgYF8fwnWXJITfnRzfV3Fg88nqVF87Zl/Z0DfgMELijNAJMPONhx7IhnuB2gBQGA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 06:53:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 06:53:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V7 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUyOkIqJe/pFlRJU6xs/lv18OC9w==
Date:   Wed, 20 Feb 2019 06:53:49 +0000
Message-ID: <1550645332-2907-3-git-send-email-Anson.Huang@nxp.com>
References: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed6f3f6f-b0e4-4522-c82f-08d697002a74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3883;23:Ks5A84FVNHtfbsRSvdu/AN8Y0Z6vvCDZD7oaE?=
 =?iso-8859-1?Q?7vYDfeHWaIyBqBKfLJNmW5qwpGClCOMCF3P+D6YAZrm5sq1eo6eWbLCDtZ?=
 =?iso-8859-1?Q?/s3b8ut+7FQ2bmK7fKp3LyRh5rVqvGLr+c6CT52Q9V8q0ds/IQzbebNtdv?=
 =?iso-8859-1?Q?6SmNNPxfnbPwkydf4NxQiMWQLtGzEwZz5JlXyey63xTXqJ/lnmU0/DXV4r?=
 =?iso-8859-1?Q?H9yLix13QepU/XAOHLwjNyY4m/hU/kpFrL3CFvSLCcONOPd0ENk8z+ZJfF?=
 =?iso-8859-1?Q?3k5um9r/7SOIvEYoftDvwce+JFisUl4ogNfWPYmAlGNaCCFu1HAqgi7Lrx?=
 =?iso-8859-1?Q?9aX30ddLXrbH5BBMM4TFu3/8JNIxIGiRe2KB1bLY+04uKoRhNMLHdHv3Ia?=
 =?iso-8859-1?Q?TH5jpowlAasuunenRtD1scOWJRmu5/10gxDpQbTNbL1UYcq+umP/mbY5aL?=
 =?iso-8859-1?Q?162wdPvstbdV64a/OZACA+/wMeAr47NddlbF6xuOXVfXCT9av/KdoM+lfw?=
 =?iso-8859-1?Q?s3qshScqeM2mGNk7jkm9z8BZVlBJvs9f61wqalKivhKQZQ5yJuQZQpfvbA?=
 =?iso-8859-1?Q?uIUHvRmZTDbygvQjTxyox6pfJ+a+Wwl2lqv07tdUJERbuKHBbGaTOBiIiY?=
 =?iso-8859-1?Q?5pG68QicoH+qNs2RlJC3UbW1sDF8DtCbS7FKnOU47iydjuBHRmZgpHGX63?=
 =?iso-8859-1?Q?jMTuoxEgSrLTmpguqoVypUGMZW9hgW04AEXv4/g4LNlYRlJOSEozbyXNdS?=
 =?iso-8859-1?Q?oxwmDgws7EyE9MFKNNGwWWPOxghPI/rwyLcqAe4SSGcV9ngNJB03PG66z+?=
 =?iso-8859-1?Q?j50DElnhva2fbh7uUWuUioLPYzYvPruiavTvNTmcvpGMJQwxlDw1hXGGnl?=
 =?iso-8859-1?Q?rAazyiFHSeqNFPrBcmGKR6tMo6J4tedQlGAL5T4P0eQXB+xPNWzQ9JjcG1?=
 =?iso-8859-1?Q?ncsBOcUVpOxiteBjiQ8sNP6vtTrDnICYKXYJiRyxLlQpD3h0puH7SqMFhS?=
 =?iso-8859-1?Q?u9oXTQj8+1xGDZw97Z6UYzYy46AT/AUMSdpTujbhKriZrgANywLnGPjiG0?=
 =?iso-8859-1?Q?ofV7h3ShmKuPdA/Rho6bS4+LVcOoh54Q+OGp84ZDc6cqoIMKFBj/YRrgia?=
 =?iso-8859-1?Q?EIfmQUUawlkq05mcZ1RqjZWTxhO5A2J0u9hUErawcTa80Vyn5E6H+/0De3?=
 =?iso-8859-1?Q?QMK+IwRbW6UL4AjuRUXpC9OXqx2zYUUMwlgo7SpVKyo/iPlPBrm0iqohqO?=
 =?iso-8859-1?Q?a3XV4/bJSWbbMHqxAaPpvE0hu0PfaMHwSQ+7DwNE26fAhYKJzhaRnAgxmd?=
 =?iso-8859-1?Q?5URIEx9NhpmIB6Tkf2xdqp1JH?=
x-microsoft-antispam-prvs: <DB3PR0402MB3883E063CC95478C768F0CC8F57D0@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(7736002)(53936002)(6436002)(6512007)(256004)(14454004)(26005)(305945005)(6486002)(36756003)(7416002)(66066001)(97736004)(478600001)(186003)(102836004)(106356001)(8676002)(6506007)(5660300002)(81166006)(50226002)(386003)(105586002)(2906002)(81156014)(8936002)(2501003)(4744005)(2201001)(110136005)(486006)(316002)(68736007)(76176011)(86362001)(4326008)(2616005)(476003)(99286004)(3846002)(11346002)(6116002)(446003)(71190400001)(71200400001)(52116002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n4HbuC639vgzUeN/emMCRtd59XvyUk7+8vBtuNBZ1FzVaBhVA8gttAY4BSqHzjOryS83f4eZPiSOolMbk7wYVk/X0R4z6QqtZcZFN4AXsw5OOAds/OUSiUOFIYoTKpiTjqLelHeMQnb+Ce6eBK2TuefLcYGOHZ2ChnHUO48zoWL8PhhXVEt3vsA57g7LynX9u8Kv+QMvGoL4Zlm4t7wuqEpEnOLH+YobxmYVbfTFn1PBPoPOiUUfY1/OI3lx7UBryDe9cxxjP69oiNPXgzf0Sw+0U0SnpX3UNhh+DyYAh8c9IVJWo/sETHBcrkdqjwn619AFHl+4FC1yHlNHWYOyspWUy7vtfR6rtKV5H8rpdMg9uc8FbJIU5RAZN4UBV91EyTJjl1+qE/C9uuvRmDyVMxWNI6m6wWdxab/NC/6vkkM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6f3f6f-b0e4-4522-c82f-08d697002a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 06:53:40.4405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V6.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..52d503e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -413,6 +413,7 @@ CONFIG_SENSORS_INA2XX=3Dm
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_THERMAL_EMULATION=3Dy
+CONFIG_IMX_SC_THERMAL=3Dm
 CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_RCAR_GEN3_THERMAL=3Dy
--=20
2.7.4

