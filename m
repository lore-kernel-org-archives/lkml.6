Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B12C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA9020821
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ax34OQEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfBMDJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:09:11 -0500
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:10048
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729210AbfBMDJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX4Bdyv8t29fkm1tyactRlK1QolTiPnV9764JFgkFCY=;
 b=ax34OQEeK0sUnzcaKauS17Epo3AJRTBJhLAE4xlK5Ap1twFU7FwA+eUxzH9IEaM/Lv877tTpmvzu+AOa/+ZgRx/FBhHQRgA7O/Kf8d+kQc9vNdPbPGuRJUS4vdy0dHfIQgtfbKaZTSGcd2hay9SLdZSmevNdfrYtjX+4KC5akTE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 03:09:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 03:09:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/3] arm64: defconfig: enable i.mx system controller cpufreq
Thread-Topic: [PATCH 2/3] arm64: defconfig: enable i.mx system controller
 cpufreq
Thread-Index: AQHUw0l7rOnduRgAhU2afJW6/pvR2A==
Date:   Wed, 13 Feb 2019 03:09:07 +0000
Message-ID: <1550027011-7884-2-git-send-email-Anson.Huang@nxp.com>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0150.apcprd02.prod.outlook.com
 (2603:1096:202:16::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3724;6:2gnHvycJRcAfD0UX42RLf+AH4RU4EEi9PGcUWxofe1ad/f/VUFLympfvwBQKhjflIqqcrgoIPVdJ95HOAlyfeYZLvSjOjzgylFC8Bmegr44lQy5uvszamePLhhFmEkH36wmzc35ysJf7yS5tBTFXgvOxsuykS+kRnUrGhTX4aTe0F2paMnCqc5vZ73IHgwXqSCF5bhGpc0fMWKPT/25Wq3+dq4PRQarzLgFY/rRNaeQO46Ze0ekxAnSXwzAa3U8zIVpcrYkc1J89mwxQ7PApmcXuWps/b8wO2M4aQVkXXmToQptK0HX96dBSK85OaBvlhz1Ym+/Xpi+bsDstc4CkNVkBRqLfWgh9ymkxX0urWG/OZQt+kHQRvMQqE23NggBQ/V1XHFGt+YkvsHT15i4ml8rPrR+010DaR7gkrfbYlN9flyZ4ajDKY+Ucvnuhqjq0ZBbYv8nTUYLn0O94NA/Hjw==;5:vTcZyiNbo501OzK3WA6BZEglifLhG/6e9SES6sgKsIrkx+Ifoe/C2bb3oQ0LF5X9JrwwPpNHWn74LT1uV55j8+0TsEi/DKNW+xzapthOnw3M7JZlHxiMJM+Xe9ZnwHvOubE1a+HupTnirYgnYVyWRSIROkMwISziSaVGQ6KMyBSV4S5zhfdb/wHbkUyPmbawXrOI+wxU6flcohbQqe3mVQ==;7:8zf+7heMy9EcArEUGg47IS7Hple3SpWV+Rg14eE5Jvbk843qy4cZeyDgWOB48EO4kLOeHeY+PYMJAS1RyYB6OuyiPaoA4xU44t/wuXY9DBgEX4PXLYb/qQFMfKsM1A1/A5qixyQ2AQlg+LrJPAZ49A==
x-ms-office365-filtering-correlation-id: 132d41a1-7d68-4a70-ec29-08d691609d82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB372498058773FED51324DA25F5660@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(50226002)(97736004)(81166006)(81156014)(8676002)(7736002)(110136005)(446003)(305945005)(2906002)(256004)(52116002)(8936002)(476003)(486006)(2616005)(99286004)(11346002)(3846002)(7416002)(6116002)(71200400001)(71190400001)(86362001)(36756003)(26005)(53936002)(478600001)(68736007)(386003)(2501003)(14454004)(186003)(102836004)(6506007)(2201001)(76176011)(316002)(66066001)(4326008)(105586002)(6512007)(106356001)(25786009)(6486002)(4744005)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ayw7x0eRbsq/tzsmMySnjEVe9/0CQRb9u+UFlUjXDuvmtz3YjYBEyXxrafKqbs9mBhGm/SNlqYnaraP2mFxmmkk5TZNBgXLiEp1zW0AOgROKBNA7WB/VUg1UJLypzAx9mvGEf7Mp+rfys6xqf5v/5iuZUgbKoR6Q5Oh4c5Wu0cGheUSf+5BLWdYB2FDNXiiHB0AO5f+w4CgVX09MuW43cuWthAkKVSNKzgJAlDvqKfgMgHWOiB5p8ipA+woZEP6Cl8zEDffgymv+tJjuCckX9GmvCcywTRFEPxd7X+x4dH6awMEtHpC0LGdvlCVG8bN3Sy0W+8fk29gUXUIvHascEbKM5l+BNKYGO465WoNHtOFQulj89H9IgsoWqJfhwVOpxMs4IdL2EoIOHoOqMkT5j7VFFTtblCgwfT5QNeEN2gs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132d41a1-7d68-4a70-ec29-08d691609d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 03:08:58.5400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_ARM_IMX_SC_CPUFREQ by default to support
i.MX system controller cpufreq driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..3a940ae 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -109,6 +109,7 @@ CONFIG_CPUFREQ_DT=3Dy
 CONFIG_ACPI_CPPC_CPUFREQ=3Dm
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=3Dy
 CONFIG_ARM_SCPI_CPUFREQ=3Dy
+CONFIG_ARM_IMX_SC_CPUFREQ=3Dy
 CONFIG_ARM_TEGRA186_CPUFREQ=3Dy
 CONFIG_ARM_SCPI_PROTOCOL=3Dy
 CONFIG_RASPBERRYPI_FIRMWARE=3Dy
--=20
2.7.4

