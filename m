Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3442C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCAE20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fH8uIebi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbfAPIm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:42:58 -0500
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:28224
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388860AbfAPIm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8W/JtJ4Q5rfO2T4ddkOBdOcbaoOZ18UOe9Enjaw1Uw=;
 b=fH8uIebieQ2HKnYYE6QQ8CGqezyUe/8l815LOt6kM4MiW4LE5cmB89jf1xxYFPvyoRewUNwAAPtD9ZYj+QsYBOcED8UrM3GBfLl4ur8pQpGNtlCFEc+SmLiuRcPPTRBH8BIdPElYGdmUQdiGhpTJlsTc5NfuB9BoklDy4+b/CxE=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3863.eurprd04.prod.outlook.com (52.133.29.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 08:42:55 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 08:42:55 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [PATCH v2] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUrXd5gLECNJi8BkujguT4zpB5Dw==
Date:   Wed, 16 Jan 2019 08:42:54 +0000
Message-ID: <1547628161-20461-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0072.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::49) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3863;6:kBo1eRBiQ2uWtVc4zbknj598/YIpqUdB1UAbdiTXBLeGflFk9DJ8OsF/BUnJ7bAkyQvetSa3VnSWgNJaAvwnCRUWiVFtLN3BVqfgrjy17zFgkqWP9C1yjidGoVZGiNgy2GlhHzgxfQMVBmwJWR+6L4cJNlC6V2gudHK9oZ/7itYvgvLrH0jcOc2s40q7GEyqzMZeyrbzrKr4LMD2bAfZXNqBxIwjvyu7YBW0jHLTN6lhPwmTwqvDEXe4DTF2V+Kuxh4jn63G4bUHQGRWDWj19gjYmrLFp7gDbi0FmbTDt4KO5Ixh6v4cdvw6YSfMV1JkQutpJqVFzcwVn63A5UKZ2BSggysDeEq4v3h5eiK1bwZGEYmeaBCIwlNZZ/JTCTHmdL8gyd97ftD/xsfbjCFJfd58ATj5Dn/5WnjBA2VhFzJddlLis/APKvYIwn3g4XjERbOFWJXGWnaL2pAikVPL+w==;5:eXZKucCKtIkGik7IiyYuMg0sM5aq3qc9tt2q9IX9FOIfSev7w8Z5P/YZqQGK7gSyJ0gD4T6g4/BBgFiSd3iJnBi2q6JQ91Vmv96bqpOJjqw0Mc45G2OaiXII5QHkjPzP2BWNtxyKTbGUV4hMP4LihQ5fUeYKjVCjuZ0mq7g7l96MpQxSI8WNLTCjdzOzUban2MyU/MHNRE6c6vJcLqazgw==;7:/ef4QiP5o+rwKwHYTRhH8zsZfos5TvWf/DUhrxpA3qqZzk+PqpegSCEL1jQOBTq2s+R4wT9mNuRUfBbNwZnyq4uTsZi9xABHyfGZejxGVmvNEVLn/uFCZHzKBNg1cN3ek/9JsrE8uo5yg2VzUGwvkg==
x-ms-office365-filtering-correlation-id: 77db1e1e-8edb-4776-240f-08d67b8e9ba3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3863;
x-ms-traffictypediagnostic: AM6PR0402MB3863:
x-microsoft-antispam-prvs: <AM6PR0402MB3863F011824E65BCAEAB6CF2F6820@AM6PR0402MB3863.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(189003)(4326008)(102836004)(186003)(256004)(2501003)(6512007)(6506007)(305945005)(53936002)(7736002)(52116002)(26005)(14454004)(486006)(44832011)(5660300001)(2616005)(476003)(386003)(25786009)(478600001)(106356001)(105586002)(68736007)(97736004)(66066001)(2906002)(36756003)(6436002)(6486002)(86362001)(99286004)(316002)(110136005)(54906003)(50226002)(81166006)(3846002)(71190400001)(71200400001)(81156014)(8936002)(8676002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3863;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zwsGdYNSMZmUUR4hGH+lD1ww+7oEooJISMgIrLHHPHP7YcgP6VD7c9+g4eaDuFW8z4o1YtyRmIL12CkeZrf46AeTV357XnHIer+QXO1cr7VNUq0CARK0mNiPbrm5bNx/Uv2Ftw0kRmbWlQDTjgc0+5RhYL+sRmuzNjL+yktdXYqjor3m90ATNf6sdEx85PJPV8WX2LXfOxg/ikPxGM02wjRafxb3kINUqaqezkEfWKp9uOaCMth+88WLMHK9HNTDogIGRe4CF8PCFvmqwbyhbFBmm/OC8HJKXFVForjVdvfX4vIA16jkdQQUiF+GBQkHskXyWQt7yTh52tNXGM30HOUzmxMRAoCqTyZVCe2G2eaDrF/WplVQKPWLTTW29oLqrdzXxN2R2WC4Pi5TCAOjcZw7voAhNzjHWkESAlyx1Pc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77db1e1e-8edb-4776-240f-08d67b8e9ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 08:42:54.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all the i.MX8MQ configs necessary to boot.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
[aisheng.dong@nxp.com: add CONFIG_IMX_GPCV2_PM_DOMAINS]
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---

Changes since v1:
 * added the CONFIG_IMX_GPCV2_PM_DOMAINS config

 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 032912e..7633fa4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -323,6 +323,8 @@ CONFIG_SERIAL_MESON_CONSOLE=3Dy
 CONFIG_SERIAL_SAMSUNG=3Dy
 CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
 CONFIG_SERIAL_TEGRA=3Dy
+CONFIG_SERIAL_IMX=3Dy
+CONFIG_SERIAL_IMX_CONSOLE=3Dy
 CONFIG_SERIAL_SH_SCI=3Dy
 CONFIG_SERIAL_MSM=3Dy
 CONFIG_SERIAL_MSM_CONSOLE=3Dy
@@ -371,6 +373,7 @@ CONFIG_SPI_SPIDEV=3Dm
 CONFIG_SPMI=3Dy
 CONFIG_PINCTRL_SINGLE=3Dy
 CONFIG_PINCTRL_MAX77620=3Dy
+CONFIG_PINCTRL_IMX8MQ=3Dy
 CONFIG_PINCTRL_IMX8QXP=3Dy
 CONFIG_PINCTRL_IPQ8074=3Dy
 CONFIG_PINCTRL_MSM8916=3Dy
@@ -626,6 +629,7 @@ CONFIG_COMMON_CLK_RK808=3Dy
 CONFIG_COMMON_CLK_SCPI=3Dy
 CONFIG_COMMON_CLK_CS2000_CP=3Dy
 CONFIG_COMMON_CLK_S2MPS11=3Dy
+CONFIG_CLK_IMX8MQ=3Dy
 CONFIG_CLK_QORIQ=3Dy
 CONFIG_COMMON_CLK_PWM=3Dy
 CONFIG_CLK_IMX8QXP=3Dy
@@ -665,6 +669,7 @@ CONFIG_QCOM_COMMAND_DB=3Dy
 CONFIG_QCOM_GENI_SE=3Dy
 CONFIG_QCOM_GLINK_SSR=3Dm
 CONFIG_QCOM_RPMH=3Dy
+CONFIG_IMX_GPCV2_PM_DOMAINS=3Dy
 CONFIG_QCOM_SMEM=3Dy
 CONFIG_QCOM_SMD_RPM=3Dy
 CONFIG_QCOM_SMP2P=3Dy
--=20
2.7.4

