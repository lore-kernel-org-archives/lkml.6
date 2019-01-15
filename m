Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77163C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3485B20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lpdU4sEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfAOJu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:50:57 -0500
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:13070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727334AbfAOJuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BVxtYkAEoAFBdU6ScL3FOsJaGZ3q+ZS/wiTE5sx5TI=;
 b=lpdU4sEmXDiyyPFMrq2/ytCwhT6x29HN9gk/GSDy7Guasb5ScdOKBcAXhdWbcxYAdEqSfJa2XFUFKCDXwDlpISOybK1A5WXmX5W/i43QVFRnrcLrv7vtc9deun5eo05pXUIYEn1yYDgT5tXErw957/irvtF5pZIdM2L3GW4ASWU=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5086.eurprd04.prod.outlook.com (20.177.50.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 09:50:47 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:50:47 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
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
Subject: [PATCH v7 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Topic: [PATCH v7 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Index: AQHUrLfKb6E8UIGMIkaBOtpDTfQOcQ==
Date:   Tue, 15 Jan 2019 09:50:47 +0000
Message-ID: <1547545697-4042-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:3:2::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5086;6:Ky9oA+WUiTiGnksNOp8Lm0Ya9xE6OF5R6axLCjZuC+g1zaVxt1/z+Daurqd/43xgCiO9qS4c4Q3TtV9Dx0JptF/GjflDbFgR7EDU+HZz7K/vgW9cqIKommiOHgTVbKCW+5KmK0M4gxu9hpx8Ioon+35TPk/hxLV7UPbaX9x7l0GMHHQ2O+olasqCvrTiHd7QdhoGoRW3YIQhrma0C7sIoWCoA1dtR50/XOtHcOHultELiMfqH1qvZN/2m6iI4PLsu54ZS7Rca50aNBTgwMsrKL39JJpMa6QyBiBUdizWkntjAq52x+r5LcJqKsNvhraZevGKpZTIz41eHinO6r+4m06B9+L4kqQhVDW6hob1JVjX3FqktqU9XEjQci7tIcL6xr+wPEK0W7mAVldfCMOTOy9FynjzbIDoxMr8ODckokSkppJJSGlQPda0B+fPRs6kXnbKfYUvKNPVbFvMV6Wvuw==;5:j19eb/92l+0AShdEfBM3/2ujYUaqdureHcCAuKL+DfYRjhAb/dqOMuPm5NXMQmmrxqJHuJExCRWXyBTYYFVAN2V710xMVp8FJ8bd5HP4PQYFQZl4/XLHeNVBv0NfqZ9WlVdnTKP7ipdqLG9DRCGifPutHmAKzBjyOR0tK2QAfQmXM3ddNapBZFqcEyP6oFJHfXOKdQ2ewOCm3LGnw4K/3A==;7:ADu40BG7T9bM34xIsl3/2CIrFdtTDDGXrUVzBDGoQC7l796p4flQ916cd3/pd4RFCoAyjVQwIWQVMAJXVxcg0IxY4hXgWeHAYVUGifEtcPFLYyt94ggsdAADz3aCVmJKNJOJqDxTRtGlYkCFcf3Z4A==
x-ms-office365-filtering-correlation-id: b9019300-efbb-4b1b-7bfd-08d67aceec60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5086;
x-ms-traffictypediagnostic: VI1PR04MB5086:
x-microsoft-antispam-prvs: <VI1PR04MB50868DB7CA2AABC940C8EF5499810@VI1PR04MB5086.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(39060400002)(7736002)(305945005)(2501003)(110136005)(99286004)(66066001)(316002)(36756003)(50226002)(8936002)(25786009)(2906002)(486006)(4326008)(478600001)(256004)(54906003)(86362001)(186003)(97736004)(2201001)(55236004)(102836004)(14454004)(26005)(3846002)(7416002)(6116002)(6506007)(386003)(52116002)(106356001)(76176011)(5660300001)(71200400001)(2616005)(78486014)(105586002)(71190400001)(68736007)(11346002)(446003)(6436002)(6486002)(81166006)(53936002)(6512007)(81156014)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5086;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U3D1TsQzFKmJOkJU1rHI1kOACpfNTFUZZzL+M+Zoiu9mFvB0X81Y9afF2i6B6vyd3I2o1o30LsGsall3un2YNlCwK9Yp+4sREpCRIaamASoAQMvxxXr5BDVj0iQTOtyIX3miTL0qckwR8qnP6gtWdgIbCeoQDveM6EaEyeTKH0hIUJdAJmFJCPMn6+l0iU2MdfrM0kG736h9nlxg9AupHRvrseKs85+gHJZJ/qKGDMIe4g+3EvmSm02q2FixaSpn0Sa28sDhIoY1Nagkok8XPgPHP4cDAMPl4x1btPxhaTVSxpR42P6TO+Czv4W4CKKgez9effdaN4cwkZqbuCKrnf5To9T1AooMExpOmKr+bYfvSa5VLcZ8HKKOQ9WdSFNWg0zZxM10CYqsZkdiJN7sMRGgG1dgqQXRzAvSDCiuXKo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9019300-efbb-4b1b-7bfd-08d67aceec60
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:50:40.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
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

