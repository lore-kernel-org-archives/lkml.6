Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055CCC4151A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD359218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DvWdEsxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfBGJx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:53:28 -0500
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:54848
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726939AbfBGJx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhUC3abvwGYFLAR6Z1SdcCkflQuJQgBUuu+D0CmmWlk=;
 b=DvWdEsxOD0gcviNDXYMS6O+GuWAFkAJgcX/WYmrI5LzFwkeAwWuJcQJAChykHn1qoqUTke2hVo7jVpUcFaT5qi6nk0pv911bERgLglz/5AwFLfx4gf906ySooRgGdg7++HvqU/6/QBqDBDJ1Ac80jQPqNAkzX3Q41cTgv013t8o=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3589.eurprd04.prod.outlook.com (52.133.20.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 09:52:56 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 09:52:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V6 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUvsrmy7YFR5pP8E6Q+nykG2OIww==
Date:   Thu, 7 Feb 2019 09:52:56 +0000
Message-ID: <1549532838-27025-3-git-send-email-Anson.Huang@nxp.com>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3589;6:y3J3Z+xvUWE+gUbENJlXv2RQDvRMkQ1132nxvKwJ/RVGpnqZmrp63A1WqfaukFP8hSH6t/03E2/w+ee0lWdvDnq+QDmJwVBf8uUVcAVOCvfZYvHW1UjNNX3AGGxufhvIpFANj5msEhlpoAG7jXP6dNs/FH48ohIox5XnYNP3Y1/q42FWj9cqpEoNdgs61sYNFlmb2ZBsCZz24o1o6hoyoNsfJ2izJnQOAwQD+Bf34tEPyN1KmMXlSuWyLbS6WH9aNovGKZ/pnf8ecsjhocF6mzCaQ3Mi6Islc1WwdKKAL+N1MVs69c4vpD+qpMAsfbYNmUSuxSg9JfTU0rjqwSZY0q55T7inxEroaVsX9BZHcQHMSUyWNJ8drg8nICr5VN6r/cMQlRyZukY6RxSfFRc+C58xeWsnr7Zd0I5OV8fwzuIfT2VonPliPcCveTP96jSXIXzspsB4aP36Kx89ncEezA==;5:er1FCl7+BcGXOfgsYQPMNQi5RnpeoZIviWggXzF91S1S+ikagT8OP0zO/9XLXjN165+a3wB6Bl+FAVzP3X4Or2vUfGaUF423PIzZM5ngFlrzzvGTcUVOyisSSY6eITGSozdh2lGXAsXrWk/ppugf6GanG/mCXGaDXEJlynG+zr0mbqEbJaRj6NmVnXx21FsNcJ1YVi9A+buJZYqkAH6Z/g==;7:Hk8LfAM3y5WNr1KkFe72jL9YUs3ctXC4BQmPlPzyk2YQ/pd2SbjCfnf3GbxzNrW+0MQ1V0VfpZLtXcFYG7VuUQ+I8xH505nXFBaHHyOXArVYxWCZhpsvmdR5XFK8Wrz11F5gLIvpcidifoqsdbGCoA==
x-ms-office365-filtering-correlation-id: e0b46cff-9c72-4cdf-7fc3-08d68ce208ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3589;
x-ms-traffictypediagnostic: AM6PR0402MB3589:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB358904E1420624AA33088ADAF5680@AM6PR0402MB3589.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(106356001)(36756003)(2201001)(81156014)(8936002)(86362001)(4326008)(6116002)(71200400001)(81166006)(256004)(6512007)(71190400001)(66066001)(53936002)(105586002)(8676002)(68736007)(386003)(6506007)(11346002)(97736004)(476003)(3846002)(486006)(446003)(14454004)(7416002)(50226002)(2616005)(478600001)(6486002)(25786009)(4744005)(186003)(26005)(6436002)(99286004)(316002)(110136005)(7736002)(76176011)(305945005)(2501003)(102836004)(52116002)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3589;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wwrJU9DWRWaYFn/73mymSw5Mtp/AFgwqbJTCXAO3rx69vMEErWlfvza9CHRGk8584O8QQv6xJQRuX3FoDlj9zJb43s9/Oxna6Do8iqc07QzC/1CxqHM4OxKmoTz0JO5NIPJd36eFRBYTDEtxuygGmTVvtcImF9P6INdsgrqGRv32B1Yu3AUXr4iWoixpv8DoD5bmkhJinSBy/+KLZyIoTZ1zqNaTm3k2o2Z54RBH/Aw2LPaIvVfcqWbRsGR/f3tdl+5Pcq/4o8vJoGKS00d5v1B+e57uS8i8T2HyO4eZeplupWeTa7red/yOfjFFCmej6e2R/JIV2Ab6lU8rmJeqIc9F3zwRuxT7PmFTKnylKzq6ezUr0LERES6i822bHdH0FI/cglxJvokC/pC1Ed8sDnNK5PVOA20wxGhfuWjLEu8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b46cff-9c72-4cdf-7fc3-08d68ce208ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:52:47.2399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 709e8f1..4c79832 100644
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

