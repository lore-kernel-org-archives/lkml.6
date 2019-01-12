Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896EBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1312133F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UHyk3p7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfALI4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:56:37 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:37504
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfALI4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLgZGH5NR6OYCg2MPPE1vEeZsvGGhWroQ3SkYE2XOiY=;
 b=UHyk3p7Aj7tgEJ7PtPaTNI+8u27+znw/wVVQOnAfaykY7VTlNF0rnKjShFbIPpR6q7flEgeAuMxIvYG5w9dRxXi4sIK3doyZ242/A5h8xQdP2MlX7KB6yYpa/5B0rcresSHm8Wo5uvQk5Nbo+1J9MYt0B0bFLZkhDw4ZeK6uXdc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3928.eurprd04.prod.outlook.com (52.133.29.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Sat, 12 Jan 2019 08:56:31 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1516.019; Sat, 12 Jan 2019
 08:56:31 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Topic: [PATCH v3] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Index: AQHUqlS2K5Efx9sZqEO6drzmPmyC+A==
Date:   Sat, 12 Jan 2019 08:56:31 +0000
Message-ID: <1547283362-13266-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0026.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::39) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3928;6:EUAPwZQKPQQi6nYpJ3jPNIp1Jp/WCFn1v1R4fDYnoZdJ4+QWmYiUEftBJeZJP55dO8ZxwprOak+4SEm3V1HfGnTpTIBcUld68mk8TjBSVba8brhifqPRaAGgREyJgZs+bQC1EQiumt7TuBrnz2ATT0mrcZtQPZmpxfrMsI9m6K4GTQ6xkvOV76y9XtnG+gITzFQQkUm1xQ4VN4lZ/k4OW2+I/rSYcCfgsqqGjCb7CK58hYAvkVJgRiw/G8MvRoglvOkPUz60HpqD27IaW+3dtLnOT+HsPdL0mPOcZx1UoXVwt+KnOmyBj074ITy1fkLW/z2uMOCJ8D+cEej5uzQhTNtlpEoGgy+97DI6Dz0UOCEaZqO/3t/gsK5a+WkXwxSeWGpFtjxZaqi3TgdK/40d7Pv5vaiOs1rDO97X6DhY4TZmTP+k3lA0o9XUrPxrNoYQ81kWey1jUMzds9972tW1zQ==;5:fLHlZga2Wt6wB1X/avUMc05p/57moZ2b55YfsIUSBtvTwEgp4n2DdB/Zo+ByHbep2RTM6x3/5vuBx/sa2CzUNMlgsYL8gKZddYIPTMVFtve8V/mfMDFssJvJkh7tB23D2tGwidGnmLUN7TNB5p8+aw1axwCWzBm2uUiR+hTh79V5xgc8QSM76i+ucInQye8cqxIynH8ByKsn176ofqBroA==;7:d7TvR+dHkIPZzAxpn481nTi8uaOURQ4SvslYW0ExIVpVOMc4PvAJSUrh+gos7BgLq+9pJEaSOle2ABw2qxz4UhsWWWZIioKqs0feWzxg2oDf5ASUUJerAh0IUDHwGMhPgVjieYzAgSfs9XdY6VvsIQ==
x-ms-office365-filtering-correlation-id: b66ad425-94d7-45e0-7fa9-08d6786bd87c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3928;
x-ms-traffictypediagnostic: AM6PR0402MB3928:
x-microsoft-antispam-prvs: <AM6PR0402MB3928153DC3106A53ECC2DC11F6860@AM6PR0402MB3928.eurprd04.prod.outlook.com>
x-forefront-prvs: 0915875B28
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(199004)(189003)(486006)(50226002)(8676002)(81166006)(6506007)(386003)(97736004)(8936002)(52116002)(14454004)(102836004)(81156014)(6636002)(44832011)(6436002)(498600001)(256004)(14444005)(110136005)(6486002)(36756003)(54906003)(186003)(26005)(99286004)(66066001)(6512007)(68736007)(106356001)(105586002)(2906002)(476003)(2616005)(4326008)(5660300001)(7736002)(25786009)(71190400001)(6116002)(71200400001)(3846002)(305945005)(53936002)(4744005)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3928;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vp1CPIUwo00vVZSMHrJrg8u7vGpyPrO53BBWGi2V9Snzn2+gvtZQewVOjYNeNPaUxlcbdXJQpzPwMDKf3QylD6Sa5RiL/sOf+oFrCmZwZi2ubZKzSZOQDQK3y4riuBAKUHVPBCaAR7YdmDEM2ohNPK3lx85Gv+dW1xfBxxx4pHvI5BpCUNZ/rbJP9V6TnqK7LfyMbLPpFxDB/rt79HUie8CFEs7fRBNkyUNsvLywRNFbcSP72/53jWdcy9ZwbIiYhWbXxA6hMDa/AJaqM00AYUnZAaAbaUji+PZPjd0KSXor/sme9UG1pPg0hCfeunio6aZjftXSM65ShKC91Z7OkiZfqknS2cCVhRaOFMjWOokHa/juYnK1/t/M7HUCNlvtXlmDIr9fvAoNdOGDagmPX5jenaI6Uz4e2e2nIbm1faM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66ad425-94d7-45e0-7fa9-08d6786bd87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 08:56:30.4422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is going to be used on more SoCs than just i.MX8MQ, make
the dependency here more generic by using ARCH_MXC instead.
Also remove the SOC_IMX7D since it is also included by the ARCH_MXC.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Changes since v2:
 * fixed the commit message to include the SOC_IMX7D removal
   as suggested by Shawn.

 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 2112d18..d80f899 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
=20
 config IMX_GPCV2_PM_DOMAINS
 	bool "i.MX GPCv2 PM domains"
-	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
+	depends on ARCH_MXC || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
--=20
2.7.4

