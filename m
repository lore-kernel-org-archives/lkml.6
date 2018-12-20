Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F792176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="diQk1i4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeLTJIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:08:46 -0500
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:35904
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbeLTJIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMZlIFyE6Jpw8uI60bP2HEes0nmZBEhykr7NcKm0BPU=;
 b=diQk1i4gGtUTYgg4e2oUBdU5TCHAjvPkABeIxd22lANO+/iJd+T5aNfLot4DlrMI1cJV0Wf3FcNWwe8izaJYthzQUoZyQ8P0+E2+uz+rgU4ol2J97NTQMrmu1RqDWe0cuVo+sUiRLLd/O4BAkGG3g/IOXistqBYnJqpSknV4qYE=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3687.eurprd04.prod.outlook.com (52.133.28.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Thu, 20 Dec 2018 09:08:42 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 09:08:42 +0000
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
Subject: [PATCH V5 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V5 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUmEOa6G8xdVf9OE6By+RevjrMkQ==
Date:   Thu, 20 Dec 2018 09:08:42 +0000
Message-ID: <1545296609-20477-4-git-send-email-Anson.Huang@nxp.com>
References: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:203:72::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3687;6:Pk8m/+zopApEW4um/QFyfHxg/JGV+i3lEVxQjYWk6axSPDKO1O733M0Uc8UhX/9mgp7N+CsScP7/pWX6svjf/xkpwFbzWQyhjvYv3Ktxqv18JdrtwrGyj4NXkqjF7DAjCg0WovO06ZP6LBpPIyF9lH/hKIDwE90j7rT2VelqEdPYc0odi3OFm/qCEQUIdzrkcha9aqy8NWHULDcUXcSezpw/rl43dJn7QqBRrtmNXja95wR6Hb8H1CGLv4/d00vTGh2DZHg4LLl56kDhl8l/E6qO30AAxCw0j0TI9+ZcBQmF9yFvoA5nUd88OD1xqYeC7lEqyi4xTJHKv5ILIhluWGN47/ul4Psmn5VB6QPhAOASijGciSFhiL5M44YpWa92dNtcuNtiU09pdw7eQCSpa8ufVmrenm6Sr8JwltGWXhjPnCY8gkJ/P/c32XmyBr6XijVyO1yoHFMSwBW/Y8hMPA==;5:rzXxc96kJJewrIr+C+o71EJQPdLCPbsySSO4VCB8kr2c+N0irflFeJBU4uphx0AziTl91Q8cx+0Fb+9q5kGqO02xsmO8cCUfx0ae0SEIg0OZdcwkMxVx4zGZzsqjFjh0zVz4xM3MtuzgnvGI8Ygcb0lxJn9cpHHTAkEC+sBHRWg=;7:wTt381GTtl3wDVTacD3ybJzkJ1QAlM8yYQSkXHS7wndhVu6gZytwR1eLzzHzEqxBqnih46NQymoJineXcC1Cr6APhUJflYZzB9fvkvj3G9PMAVcO7RxG6jY0nmtUK8IzkQwutkb5WjV/qwCKnfhrZg==
x-ms-office365-filtering-correlation-id: 923f4275-6cac-46cf-81c5-08d6665abc6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3687;
x-ms-traffictypediagnostic: AM6PR0402MB3687:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB3687B53577FE66C817D4DCD3F5BF0@AM6PR0402MB3687.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3687;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3687;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(6512007)(316002)(66066001)(97736004)(110136005)(3846002)(106356001)(105586002)(5660300001)(478600001)(2201001)(476003)(4326008)(186003)(446003)(11346002)(39060400002)(486006)(14454004)(2616005)(7416002)(53936002)(256004)(86362001)(99286004)(50226002)(8676002)(6436002)(71200400001)(71190400001)(2501003)(386003)(6506007)(81166006)(36756003)(25786009)(2906002)(305945005)(26005)(52116002)(81156014)(6116002)(76176011)(7736002)(8936002)(6486002)(102836004)(68736007)(6346003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3687;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: ETG7LcAtduSdn4hrL4fR+RH6G5mAOatVJ0uLcTy+9ECgrYyc3sQlAhiWMDbBHu0c9R8HZFtIYyxOg2NXweq4MIrCgFQlQZ2qgzJOR34jcUAWVOAQA0LLiyOEwkUZ8kUZku9/FutmidsF77oD3KqwawtBBSZtNxWRjQw7qh2D6jZnu/kociYT9tl38+9YiKovgJ5LtTLYE8J8RWPtZ3wXO9uczRsZt+O0TOAX8ZfWdLzr2BsUEV5+/15napyd2yq4pbKqeIZtfQtBZM5HaA5AbUr4LSb6/wF8k8q1X9pFjhdAG1lxxIFIMspwOcLK97bB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923f4275-6cac-46cf-81c5-08d6665abc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 09:08:42.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V4.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index abd80c5..9f12324 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -376,6 +376,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=3Dm
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_THERMAL_EMULATION=3Dy
+CONFIG_IMX_SC_THERMAL=3Dm
 CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_GEN3_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
--=20
2.7.4

