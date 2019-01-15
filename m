Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0424C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D7520657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rtf3lqG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfAOMAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:00:50 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:23552
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729322AbfAOMAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihD8KSHSvT0u6Vqe7PeBlDuFJ/wDC820LUWhrUm4F3k=;
 b=rtf3lqG9isfT7ViPdyXi4kfkOizzZOjoUZ2aAkH2A/GCpzy9uP49AZX+TzwdZKtxqafva4cKSAJdyYvkIDcUtNBVsLxfx1eIFcXzv9NHKmYRdhq/39Zy3IerPCJSKMiMBHdOIHw5TMZGwEpi83cXu2hWhAlrG5gSxofXMrDBLmQ=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (52.134.31.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 12:00:32 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:00:32 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v8 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Topic: [PATCH v8 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Index: AQHUrMnqDVoJNM2Ci0i+mFO5hrJI1Q==
Date:   Tue, 15 Jan 2019 12:00:31 +0000
Message-ID: <1547553487-9936-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4301;6:/akDTYaBr7nYCeuj7hdg40L/r5PI0jWmDO3/xcRn6G8e13n/a8pB3NXZWLOsctU4kG9sOzJIzLuDbWKp4jIPq7WcBNUNyNGLat4QU6HA7kII2qTcte0QyZbqAR4wAGGW4DOaVQ/v29k9oz3MWTRoBHZDQxeXIOmX5lif8/dPUT75+2aIkQ7CpRhUtthbVXSGeoqa1RmhH+RnXtCm91drB6/aaA7KyFJTdu9vhAl61aEOfpXLC8ZeEPL2nGzZ76kHXkxvKgCQSqk8s+KMABprT8NKmfUcZQ0q4KwPZcuETo/DUY+s+E9HlkCZLDYnCaTgciroX4h5rz/QdmHsfrBH4YFoAz68JSWI/JdAKhCXb7tyVRt2GcdoYQKbZp1UDY6lPmMdqQDy2XEFPwZpzhByhC/jy+Qr9iMlUWKRg7+Vu1Lw3saLI5jGUs9SCM3XB/QMfV2iOKCrnzwGl2/K6ATI1g==;5:ln0wTdvurcqiMaZxR76zU+SQ6eec5i0CQlGO0+iSRL/foyNlqYiAp8nOtWg2fWaE7dJGvAEF/trcvJpZt+pYRByrCp1S2uua2cF6lmOETdTMv9mEe/a0o6gJ7K+KigyajrY6+oChfVrp2aTC6csdVvvsU2v1Je91a3OELY3gZHrL98lFzyTM/23mbKurGpCNiDOwMfp4BlpOI5lErzkDsQ==;7:F9ooF9+WhFgPbQXeBaX5D0TuhFT960zBt1pacFEHmo+GefqlBRazdBDdGHB3p9hr27WQJWOLLW8ZqJQ/pGVIlGCuEKOoXixXAkIiA0Y0WCUsYy5jb9JPwIjVRlhYD/no0muEkPIq9g2eMxmrQWzKqQ==
x-ms-office365-filtering-correlation-id: 026aa9fa-ff27-40b5-616a-08d67ae10c76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
x-ms-traffictypediagnostic: VI1PR04MB4301:
x-microsoft-antispam-prvs: <VI1PR04MB4301AB1E1BDD76BDF89898FF99810@VI1PR04MB4301.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(26005)(102836004)(6512007)(25786009)(4326008)(105586002)(2201001)(86362001)(478600001)(186003)(52116002)(6436002)(53936002)(476003)(14454004)(4744005)(106356001)(50226002)(8676002)(81156014)(81166006)(8936002)(7736002)(305945005)(486006)(316002)(68736007)(36756003)(7416002)(110136005)(54906003)(3846002)(6116002)(97736004)(78486014)(2906002)(6486002)(256004)(446003)(6506007)(386003)(11346002)(39060400002)(2616005)(2501003)(5660300001)(55236004)(76176011)(66066001)(71200400001)(71190400001)(99286004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 90Vilt8ZdlvTMNJrG8gB//XvUJScHiUkArdup3h0rCiqbx/c1cKnhUZUI7GmTUnY7hOqenlMox1NRNqt2ke7+R4gGcrsOn/rqfMtEP4ze8aKJiB3e62NhEZDW4gvcgz/398ErYXS2tFSgpj4JLFLJPGWzU9arcOLJgYOlkjNK5VN0nJKrBTlPa97F8Con4Dy6945Q+r0e171RkgcpE47VLLFGXWp3arpl4pZMn/vSjgRvez623chL5Dg0omCq4r8DGmFr32VKy+HD/QOLU8gC2FEfUqrIO/Wp5FP6SL8IdYgOZxieBIXWyDMMgpyLvf/N6IUErDz0B7e2JxToMcxM8vJWHjbOPGy3SDwqvktTzL2rWHop6BafKGLdj5SvB1Xb0zDO0XynGAJjj67ht6/4w4wsPg+4td1wf5C8vjdmGY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026aa9fa-ff27-40b5-616a-08d67ae10c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:00:26.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v8:
- None
Changes for v7:
- None
Changes for v6:
- None
Changes for v5:
- None
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ef443cfbab6..fe7f35824a79 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -362,6 +362,7 @@ CONFIG_SPI_ROCKCHIP=3Dy
 CONFIG_SPI_QUP=3Dy
 CONFIG_SPI_S3C64XX=3Dy
 CONFIG_SPI_SPIDEV=3Dm
+CONFIG_SPI_NXP_FLEXSPI=3Dy
 CONFIG_SPMI=3Dy
 CONFIG_PINCTRL_SINGLE=3Dy
 CONFIG_PINCTRL_MAX77620=3Dy
--=20
2.17.1

