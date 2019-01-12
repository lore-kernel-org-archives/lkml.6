Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3864C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C6920881
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hl3fAdFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfALKEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 05:04:35 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:18496
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfALKEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 05:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En88h0rMTn4jcliVURUscA7CVfGIa//LPC4X2h86YxA=;
 b=hl3fAdFtDb6u4ZxsGPis4+zk6sO1Ztbdr1xPcEMlP+QzAS8Wplf7CtWfdFADtfLPxkVOyaRrW8x+84WeBVKTLmthXZketJ6Nhh+KWknqvi3wbypUFinV6cFBx/nYqyzCCHQX5BeeiTiVouJ9WZppVwK5MPT07lhOA78baY3iTKc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3318.eurprd04.prod.outlook.com (52.133.18.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Sat, 12 Jan 2019 10:04:30 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1516.019; Sat, 12 Jan 2019
 10:04:30 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUql41bLWLh57rrUukHyLcrmJCyQ==
Date:   Sat, 12 Jan 2019 10:04:30 +0000
Message-ID: <1547287458-12693-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::32) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3318;6:AnvsMpQfAdo1ha7P845IFUEyjlpxLE3k9Nshj6uY9uTbbXMSZPYQN143Mj7jaBKVvDbVsElEOsS3ikJwPHNR9bDUqmFzDpiIuuF24grtXLupn6IGYghQ8zy6MmZ4+1emHSQHyiQ7jXbHyGFjqE3AmWiFp8JpH+Yr+ayfxMTXMhPJLElmdXtGZY43BSsOKWPtSAEpPKZndAiWqbD/iRuUUL7Pedk0bd5PqOpECU8G/H0iJh75N15h/EBm3AgQ9PdOFkwDGXkO5ReGte9N//dYcnJyQ1K2HTB+4YQRQtSKU+UR7u7j/p13Gp4aElFwealSwcB8oZDBxLJU4+nycIcyQJiVvHU9yxvuQsPg2iU/sG4uMOiLYLl7ryplJl7XU2H63D712Y4y5pmBHjdh0Vy5ayxayGdmYLna23M5Kl4nY4rGSEyFVylpN8JG8jeScc5eExhbveJrka4NDYbXtnLESw==;5:OoKV0ZLyJdz4PAs9aMuH3ILhbDy2YG3oUCG+nDwhOThlHXWw8g2lr5v1SejM7Z3CIHMZPRK68PBhjVMvAvI8Z5iR48NlpigbPq5qehjILBXmb4NbVbkmcC218SlQWIZfs/WE4raoe0QPAchPrRJ6MYBRAGCBr3j3F1GYkw1czvVvQmhfnyzR53cvywf5GUlgLbQ7qQmbVMPdQdkP+ptkcQ==;7:HOaFo8R3zO7CQPRRbaSKGZGs1L8Rp0kO5hdeEJN1LJS4YzThrlxm3iKRLyQ4Yw+6qm6dC9++k/puoXUuN0nJpmUjHiiO1CL/LEYa0uY0YPfkWwH2PJyd/gOVQv8ADpwHStIRw8rNvMYnvDlA0mRtvQ==
x-ms-office365-filtering-correlation-id: e7cf86d4-ddf7-4fa0-1638-08d6787557e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3318;
x-ms-traffictypediagnostic: AM6PR0402MB3318:
x-microsoft-antispam-prvs: <AM6PR0402MB3318323CEC38306F8A836905F6860@AM6PR0402MB3318.eurprd04.prod.outlook.com>
x-forefront-prvs: 0915875B28
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39850400004)(366004)(346002)(199004)(189003)(81166006)(26005)(105586002)(102836004)(2906002)(7736002)(478600001)(6506007)(386003)(97736004)(305945005)(6436002)(3846002)(25786009)(6486002)(110136005)(54906003)(486006)(6116002)(4326008)(6512007)(316002)(99286004)(256004)(106356001)(53936002)(52116002)(36756003)(186003)(68736007)(71190400001)(71200400001)(2501003)(5660300001)(66066001)(2616005)(50226002)(14454004)(8676002)(44832011)(8936002)(476003)(86362001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3318;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hWIgl05vbFhFnWR4mlQddWclJKVxTF4xqwCeu8rX017W3As13Gz+VOdy09pC3U69TYFcULY9tCZfPERCGtYSP3NkjGCIOaSfVBJCFVbEAJCD9sJN40UbE9ee9rQ6J1KKvTqIaRM1emCQ92Vj5ylsliN+dt4KJ2DOgBRSqrTXAs3aEp85bN2AbFGAisO0v7B7c/qTlDPX+EM9McrdYkOqHuHdVtQ/UuflP4k0p69/lKgEBByHCpROGpqiZJXM3/urRyIJKCJ1ygLjv/ho0As/NTnR6aCI+GdQRmeeL8dqz412BdVuUHyMgxFqijni4oAYanCyiRoKO1BkPET+BtaR1qKInJDw51LhMAI1W+2rqurfsvv9uL3VEcYgOFnRiLKSuKBPmM79dnyQg7eOrywQbV/sKOI1yxu7wxK8cbFyvZk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cf86d4-ddf7-4fa0-1638-08d6787557e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 10:04:29.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all the i.MX8MQ configs necessary to boot.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0478ef9..e1d875a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -43,6 +43,7 @@ CONFIG_ARCH_HISI=3Dy
 CONFIG_ARCH_MEDIATEK=3Dy
 CONFIG_ARCH_MESON=3Dy
 CONFIG_ARCH_MVEBU=3Dy
+CONFIG_ARCH_MXC=3Dy
 CONFIG_ARCH_QCOM=3Dy
 CONFIG_ARCH_RENESAS=3Dy
 CONFIG_ARCH_R8A774A1=3Dy
@@ -245,6 +246,7 @@ CONFIG_NET_XGENE=3Dy
 CONFIG_ATL1C=3Dm
 CONFIG_MACB=3Dy
 CONFIG_THUNDER_NIC_PF=3Dy
+CONFIG_FEC=3Dy
 CONFIG_HIX5HD2_GMAC=3Dy
 CONFIG_HNS_DSAF=3Dy
 CONFIG_HNS_ENET=3Dy
@@ -319,6 +321,8 @@ CONFIG_SERIAL_MESON_CONSOLE=3Dy
 CONFIG_SERIAL_SAMSUNG=3Dy
 CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
 CONFIG_SERIAL_TEGRA=3Dy
+CONFIG_SERIAL_IMX=3Dy
+CONFIG_SERIAL_IMX_CONSOLE=3Dy
 CONFIG_SERIAL_SH_SCI=3Dy
 CONFIG_SERIAL_MSM=3Dy
 CONFIG_SERIAL_MSM_CONSOLE=3Dy
@@ -365,6 +369,7 @@ CONFIG_SPI_SPIDEV=3Dm
 CONFIG_SPMI=3Dy
 CONFIG_PINCTRL_SINGLE=3Dy
 CONFIG_PINCTRL_MAX77620=3Dy
+CONFIG_PINCTRL_IMX8MQ=3Dy
 CONFIG_PINCTRL_IPQ8074=3Dy
 CONFIG_PINCTRL_MSM8916=3Dy
 CONFIG_PINCTRL_MSM8994=3Dy
@@ -617,6 +622,7 @@ CONFIG_COMMON_CLK_RK808=3Dy
 CONFIG_COMMON_CLK_SCPI=3Dy
 CONFIG_COMMON_CLK_CS2000_CP=3Dy
 CONFIG_COMMON_CLK_S2MPS11=3Dy
+CONFIG_CLK_IMX8MQ=3Dy
 CONFIG_CLK_QORIQ=3Dy
 CONFIG_COMMON_CLK_PWM=3Dy
 CONFIG_TI_SCI_CLK=3Dy
--=20
2.7.4

