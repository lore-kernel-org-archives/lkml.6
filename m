Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id f1yaIN1kGVvWfQAAmS7hNA
	; Thu, 07 Jun 2018 17:01:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 676A0608B8; Thu,  7 Jun 2018 17:01:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hySluI8y"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D197C606DD;
	Thu,  7 Jun 2018 17:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D197C606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934468AbeFGRBO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:01:14 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:64255
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932915AbeFGRBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylIxPUCDrGj9o01gPAZWZDvl13lRo9NVConod3s+PNo=;
 b=hySluI8yNTgqqd/MY2kjsDWYobH9XJcQfqLDID19qoNohViTr2RWCI9BJIEbitvBtnfBJG/YoypyykmOykVYZLGwcApzOpAtgVd5HrZbkJTcQGgFjsjcl+wHFPUZHKIooXx/JES34JNWGU1F2IvgTAn+y2DW+YL7Dk2gztfcY1Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.11; Thu, 7 Jun 2018 17:01:07 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
Date: Thu,  7 Jun 2018 20:00:55 +0300
Message-Id: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM6PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:209:15::30) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:jc1OLWyudLbiYUuCOQY9WszEzXhgasjTStwC4jLd10NnTCRJE1ObzbB9P4UhN0Kr3+PviXuCTU4yYxP5xWFxerONiY/ZqjHIv9slFHodpWuZb3j/HuHgsmBamIN2Ln4Cz1juMf8hyeJ524b1geDwvG0QgA69EQxjlX5DkbAiaLT1Tf0/rztSPjqrnpxr+qCs6xwwcIYPqAf8BnSy4kcc1aPukgMnwd+jQ0tZWXOohdRJjL+RzKDAJ47qcJHHTAiE;25:FSAA7uz6YZLp3oV6CNBmwxToAcUbx46iomz8BPepMs0gXw/WZkk3hDV3V5yfUyoCqyExTbLVauQuJzBqiA02RUMhqrmWsCoahEGR02KPOpX8xJycoWT9oJUMnqM1wqb+kRYJzd1vedMAOmatTKwjqkpMgkmQVrrdSpVp+F9ifnLP3HiFjrpuwPijUoaAVnbZpkCMn+jB7HTQYxlFttgjuNUiVIHvTzP5y8bBnXdYuXa4AkJIq0QvpjC77sHvRpk2CcaqeTQhiayDToZWrRhXJtXhJNJfyO/1mulVrDhA8Jxq2+rnz4YZP8uWUg2LgSyrk3oQPAI8mQz7Jfqm9L++8Q==;31:Csdf+olKECfQWPFpDeyBbGrXfq6F96PqPlTeRYX1hvXUIUBY/1NeJi3RW1EGp9v1WHzlZOEWtfg8YY/v12lVWLxL1ccyWsOFIGA1ZSvyo0Ujnl+2qSCKoCyQz+85VtUexcDsq3w3RSEcXaf3WyI6Q11I4PVVzg3eD777SSamBlkppexmHpKMmD/nf/RdbbZ+ohR5Pi/l92qPC/YLHXAbaiiQ8LbYP+9FTR439x6FZvk=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:F/Iy5KILiUszYVP6IzUGpMp8GL2SbuHkvh6u6Hp+P7+Ua1FVvIwzDHfe+0QxK0C6COkPdpKI5/ZM996noPurHW9RDUns8qZtjRnPfztDvwzzqthI/b/5XUY5mnQWnwN1cB2pjTsvH2LH8UuxVE9Tb4+EF1a1B1aovffassdL1E3HRJrPRudo8U9bIhRkrlZNXcxm1pMfNLpbYq2UrjZvxbtWQN0I5bXg69tUW+6Kg4GOEjqVhJax+pQ2HzIdBC+TR1qxdep24rrrDhWKWDPAYnJt1WPMv7zdvI5Q1NWrkgvAsulEkfyaugEHWL4pNh1e+Xj/4uFn2TRIlkmz5+dqw6bu72MewCI+sxlLFvYsdcpcxkz3deGm6GA3jPvDn/JQOutLlm8MKmgvP1RqWf8F+Jpv7twAAGFootcI26eMsFx8Si97FaGPpi8khCHm0lRTDSOpP+mEaIAsJsKQi8ZkDfJwpmRZpYY7aFHrtftFa3ZZqKX3877m2j5Kmju74Jlm;4:R6tZW0z6cxELGTfQiOWFbUr50evXV1kE4FdHxpR5DatLmaSofRtdfIVqFUUoK+Pvadic6PJcXIBPvEa3oQDg1e/eAG4k+xblUDnuZE2eCRH15G3m+qXGEtUSm3j/SYdoM+kWmYAhtWGnwOH4EekMCpGHx1gjjePUEkfD31hbCmjEgle0SWl0W8/CiYnTlgYiSYzSdHgIBMyusGDIpc/ZgV66QPsMzF2aKyRL0zj9DuhWP7N8FFV2s0CfiSioC9uHSyG1Kiqrv9G3KylaH4/3AR/+JbHY/qConl6DRZmKQDRd1yfYQTd+1+ucNAyVcIK5
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290CDD6D22415245583C7A8EE640@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(189003)(199004)(575784001)(48376002)(2906002)(105586002)(5660300001)(81156014)(6636002)(106356001)(305945005)(97736004)(6512007)(118296001)(956004)(36756003)(3846002)(8676002)(54906003)(86362001)(50226002)(6666003)(110136005)(39060400002)(16586007)(7736002)(66066001)(44832011)(68736007)(52116002)(25786009)(186003)(16526019)(51416003)(6486002)(53936002)(50466002)(47776003)(486006)(8936002)(6116002)(26005)(478600001)(6506007)(4326008)(476003)(316002)(2616005)(386003)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:AgcNhchFOJjJpFJtcyXXyEnUrqInIVfe5mMnUZV6E?=
 =?us-ascii?Q?rMKw6bHbiCCFfo+1WxCCU5vt7x0U3QIuL04i7umAlP1hH6XwzuqMm7pHz61/?=
 =?us-ascii?Q?FyJXAo+9j68eBYSiuwghpwb8I+I/yUSA8NT1b0b7Mf4fayCDdNdMVT2oQMz6?=
 =?us-ascii?Q?/4z+ReezhmimS+dPFThbL2CmcIHXLDnAJwBuckn5qYjMtTenZMYDTe8tRW47?=
 =?us-ascii?Q?EuDLhVfb+Qzn/T6XxYganrMOcHx+3A1rKCfZ0VlIsNdO5OEkubMQmLbo3Tpt?=
 =?us-ascii?Q?O9f4juI3To9evGMAndDWsRLAPxTuZq0dvRoAj1SbTvwq8mk8exV8+EpVwr2e?=
 =?us-ascii?Q?MKnY5wdPdmmRbPcmnihDI0o8FmR90aJYlz13P8eixV+M6wExmxS3M14UnoCD?=
 =?us-ascii?Q?V8BciK3wbcZG2BxvVnJdGzFmHCcQafXG0shjyDtIKJ9m/qzvSHYvMiNorrmQ?=
 =?us-ascii?Q?1X6xAt9OOgudFXljG9w/Xrr8XwG85IB2VXNc0RUHYkW/bNbWpoyxVa8RTf1v?=
 =?us-ascii?Q?gDhCmXo/C5teqNnOaU9mavMIxthJQnZ4n2EOPSlnkHf9OfgpitmjabfUISvK?=
 =?us-ascii?Q?lCerojtD9uXABHmh2x9lWprM8Fzv1z8kVrd7QeZRU5r9bbbWFGlCwJDdRXa2?=
 =?us-ascii?Q?ua3qqn3J6k3pOmStt5xqalESIrB9kH9n/4lear0e6YXWK9pD5ytFFNLPvtdv?=
 =?us-ascii?Q?wIM+Cq/llyAnoDUyphAtArcvt5XAFdrEfbjOTUNbBXcG7Nw2bzbYmiTzknbU?=
 =?us-ascii?Q?PLU3kSezsWtBZXuyxwr1PAh7F4Zak6yD10P0PrUhf5IouNrRMP9Gm6k1LMgd?=
 =?us-ascii?Q?zfOA6G4nJsxWxA3SmbNbJ7krKjWP7ttCTdhQS+KWjdCEJaecZ0g/9ehivARM?=
 =?us-ascii?Q?5WVWL2qCz4uyjOfr98wk0PPMqH+3/ORpI/zKUtSKMbbjGfokFJLy3hwYhfFh?=
 =?us-ascii?Q?LF9Z42b0gN8wViVKwGmzZezhxu6RoudHCK4pSPR7TBho6wZLiBOZR9hstvF/?=
 =?us-ascii?Q?91a9AQPxHNnZDUrI266vxULJNkBtgVdFSYK0vAPxV+6pj3MBio2xd4nIaBAm?=
 =?us-ascii?Q?bEhDEHtgVYs5AWDwgFn8ERyNONmsgr2WTNJGhVv3MU1eEjMxistr3M6av7Rq?=
 =?us-ascii?Q?KgKFnBmW8oJD3aHrqwSO7tWOGlaVVevEwNVMetqDDp+FWE3nXirVvde8zT67?=
 =?us-ascii?Q?IGNQfKt4CNO74OWC0h9FbfFTLoy2Og4Ja+p+sEQ4RW3Ge8N5gKxwbv97KCOW?=
 =?us-ascii?Q?wH165NvBGgmCMmA0Qd4bhkuOcayZYoIEQSVDr+2JpWWePmwTb6TdP35Ae2fS?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: AwNHjkwjerQzipdxSum17lRWRIF8tPfO3Dug20nDvVuKIcE+2D4qtVfnpSb9K8tN8XekRcnlkq80NKuRozW++ADiIhBL6XRzHXdFnVHg2myI2qHqzHccvTdrrnE7zRwgWAhQiCmZCKQ/rl9va19/LLfqBaQQifo3hFdVlKjRBl0hNeHAhZRkUTFK38GAKqYz
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:nStaIKiGfLA8n0xSoH10Kzql0QEpphGG0en15L1v1MY7svfaBIHVB88sszqHsYMWvivvXuorBod+8cFErz8yG7UF9ugQvq/wRazVdmm/+1msdYPW+WxekLjZ42OMbyp6GgHJlr2fJwqGtN9oaFZsjrqk/FhA5G3+PaBo6RniYO7zBbbsNfia5Zy3Alk017OFL3aMnBF+8M/LwQatIJ39+U3uGMcebIS1z98NQCu4pGAUfpssKlApksZkVMBDaGObtWNuem55R9qIUDziDz/QhC2V74Y7ZQZfqGscbhrgKyrtEmr4Wi/9lmLn5zmy+hc8E5MIwoGg87hyyfEZ+AlHcws3OmamkgmWy7/1QhlokltVR54zB1nxJJ1TjuviUVGzV/2iX8snvYaBbdU/F0gSFfafU81fat1BvoiCgG0CF/2vuWWUy2Z3rkF5ttB55vSff9Iua2bmp01v1QSDkacqhA==;5:u0VhWI4ZMTJBQv9G0MBh4DQ/Z3EELRGG9l29WcF2RTaM7rM8PC2Rn62lFUokJvfrmhOmF1YVygONnUMtCS9hBJlQFnH4LuBCLiSIeaSvTc5ImaUUWcZrLndjw1evdr2/mO2kD7BJLAXHMKEGN1b8KEbaqe/jLwF50+Nl6vf0WtU=;24:U4xeeN+MZNEJOOXbr7pTf+zPRKMEYp2MFEhSi6+wlPn6r5bNH5wccN2afxlhDqDnCpE/QCLAUYUeM1QbiBn+bBfqBf1/msih2T3H9ifKaYs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;7:X6vWlW5fW5xuPSC2FWuxrwJ/iFU6eih66PjcmXBpB1yc89jKgzn/7jL6kKzWd4OOZHI/hMRFONDBcDIedwk8+msSpXLkjZDYCtRYNOo7uDVjn5ygu1ithXnqff21BcrUao/5euAFABVUPf4zfEYasCnvbPabuuQaOcbVWdyEHt/10VLrz7ZULmifxj6oDX/8nhK1plKAW9aymMTRhAp4LZMgAfe3wjYuzK52eBgIRUtrcMiQ7FBK56LHRU8SQ6W0
X-MS-Office365-Filtering-Correlation-Id: e3b074c7-af86-4f96-e829-08d5cc98439b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 17:01:07.9145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b074c7-af86-4f96-e829-08d5cc98439b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following sensors are on I2C3 on the baseboard:
* isil,isl29023 light sensor
* fsl,mag3110 magnetometer
* fsl,mma8451 accelerometer

Added under i2cmux/i2c@1 because they're not otherwise accessible.

These are all supported by iio with following configs:
* CONFIG_SENSORS_ISL29018
* CONFIG_MAG3110
* CONFIG_MMA8452

Tested with raw reads from iio sysfs.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 54b0139e978d..a6193240259d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -160,10 +160,31 @@
 				compatible = "maxim,max7310";
 				reg = <0x34>;
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
+
+			isl29023@44 {
+				compatible = "isil,isl29023";
+				reg = <0x44>;
+				interrupt-parent = <&gpio5>;
+				interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+			};
+
+			mag3110@0e {
+				compatible = "fsl,mag3110";
+				reg = <0x0e>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <29 IRQ_TYPE_EDGE_RISING>;
+			};
+
+			mma8451@1c {
+				compatible = "fsl,mma8451";
+				reg = <0x1c>;
+				interrupt-parent = <&gpio6>;
+				interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+			};
 		};
 	};
 };
 
 &ipu1_csi0_from_ipu1_csi0_mux {
-- 
2.17.1
