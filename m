Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748AD222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="lt6XKJL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437719AbfBNIv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:51:56 -0500
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:35386
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437691AbfBNIvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3mvBf1dnQ9VhkLGm4ZhRo1M5EFCc7TUZgpQ65QZYwg=;
 b=lt6XKJL/w0+nF6U8N535qC1vfIDuNmM2DIzkaYuCIlvWE1hsOeUIYAGN0dKSS71BJUTWOGCLhsUyuqYoEzPSvETrjNcKmK1jJMLCNB0L7dOgeRwSOg0okynkWYYJpSdoFAL9hP6ogMPshg9nzQ3d6QS5CN+eRPZKbCPe4Wl+czo=
Received: from DB6PR0601CA0045.eurprd06.prod.outlook.com (2603:10a6:4:17::31)
 by AM6PR06MB4722.eurprd06.prod.outlook.com (2603:10a6:20b:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 08:51:50 +0000
Received: from VE1EUR02FT020.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::205) by DB6PR0601CA0045.outlook.office365.com
 (2603:10a6:4:17::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 08:51:50 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT020.mail.protection.outlook.com (10.152.12.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 08:51:49 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:49 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:48 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v7 5/5] i2c: ocores: checkpatch fixes
Date:   Thu, 14 Feb 2019 09:51:34 +0100
Message-ID: <20190214085134.12900-6-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190214085134.12900-1-federico.vaga@cern.ch>
References: <20190214085134.12900-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(199004)(189003)(26005)(1076003)(336012)(446003)(2616005)(11346002)(956004)(476003)(126002)(6116002)(426003)(106466001)(16526019)(186003)(44832011)(14444005)(54906003)(36756003)(478600001)(486006)(50466002)(110136005)(107886003)(786003)(48376002)(316002)(16586007)(2906002)(86362001)(305945005)(7636002)(7736002)(246002)(8936002)(74482002)(8676002)(50226002)(4326008)(66066001)(6666004)(47776003)(106002)(53416004)(3846002)(51416003)(76176011)(7696005)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR06MB4722;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c925a7c6-09f4-485f-9328-08d69259a8d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:AM6PR06MB4722;
X-MS-TrafficTypeDiagnostic: AM6PR06MB4722:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR06MB4722;20:9I2fL5HsnmBWArPjwOrlIFJnMmwtaq1bi7V+ipMdW3QiG4gLYTyHRNQsP5Hb+mXjd9geb7jSll04eb5YjWM/zJ0DLVDDNanuo0RHgiw0mF8L7kc5BoXcRiQ+NmkZ10Z0kDUTT0+Gr3lE+M3rnDqZBcMK88sKqZFMXiFy38cgFAOy+ByhYrDoSZZ+4uUcIWBwlAC6P9rmcf4Qzw5BbPIwBRHgiRtgJwq/RPDdbvXoVYjKi89MqiD0wVQFM/Ka69Gi+Xr13lmR0KkDg0g8a9bRti6ohus8ElADPilRtqhM2Y+zZLDOZOGVzBnV/X+ffyuE5zdxszAXjn1YIk398NYx1vUDvm3U6hfcjFYNOFoIko2Koo0QSwa781m3pgFL0/k8Ajz7wOPg4UntnEzvqduMDRKRhzZmRsLAQBhnrIgjZhiy86SvSfA11CZZlvWTcuE/R4MK41B/Lx43yr69bqpScmbEZXnJ7ViZjd785ubCYS+MeQqwTINFAY3bTspRpYCQ
X-Microsoft-Antispam-PRVS: <AM6PR06MB47228AE60BF272CFBA1FF717EF670@AM6PR06MB4722.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR06MB4722;23:sMYvmsgKe6qwshEp3W60pRgT6nzc067GR0QVpoFuH?=
 =?us-ascii?Q?vPniI0JSfFux8SRzq/EDQSrOhkFcjNwa2L8C7IEKKSs+bfrKLbwTw2MkYevS?=
 =?us-ascii?Q?9FsZRmMFwsali8UHUbx5levCwMhKFmr7vAL1YzpQW5dM44zhvPgKMbfM/Bdk?=
 =?us-ascii?Q?eQaZrl0s9i+XleVtolFKzq2DGBh5r3Ume5XhcU4lU43FN1p4q6vvWLl8IXSq?=
 =?us-ascii?Q?omD4CrUY39MA3I1co/g3ITK9n6HsMvyDjU197txLI7HrIzfGF22nh7ebftuf?=
 =?us-ascii?Q?JzHTamE4fGD3K8kE5+HwQSsX8OIMxhLHgOkn7BZW9Myy4v76GO9T0eX3C7/2?=
 =?us-ascii?Q?58IVIESixjWnUUmZ/WXfOzYvlvEoPfmaPwsiLKoHXl/nc+HzeexPJm0sgkh6?=
 =?us-ascii?Q?HzOfbWu2P0juk7l0KMpvfiGChw5oN1PVf99QJo7ZrX4O7HBtGQ4Uqgp+26WQ?=
 =?us-ascii?Q?ErzX+Ri+BXJI/bBG6BEeN/Ezc8uOzxzE3kbWKyyd2NAtL6eG34adj4rG927A?=
 =?us-ascii?Q?djdH1r+aCYxsI9wC+SNTJRz38jE3eNpttApie764z1hAiEcthmoG5rtrvXTV?=
 =?us-ascii?Q?oTqQ3e74I150ipdVAHyR2tLW+qorCXJtwtH6Pf8EuxW0de77uz0t85y8Ru5Z?=
 =?us-ascii?Q?x+2d3INjoibmHguxTebPzz7wk8Whvlr5hRRm0ZioIOptbOuD6GDFsAEY/YYI?=
 =?us-ascii?Q?OaHoobj7UmZNpQ7WDq2CTiIqoyBXEtA6ukWlv1MVhvIV4QNt8PbcdrDhkBPa?=
 =?us-ascii?Q?Gj5AEIyzgClRkWkif1QVC/LbQyD2MwW25gs116zQ1AVkB7JS2wIEHsvmyUTF?=
 =?us-ascii?Q?fDPrQc/DhAJs3e0v1PAETD9J/S13FtW9bmi9jlr0tEhPIRJZJhGjED7h1wFB?=
 =?us-ascii?Q?KxuK8sQqtmM3Dmt/BLPtpNpfwkpNN10XZ1cqVvLjmxTrmyBg6d1Vq0niGNPF?=
 =?us-ascii?Q?lI68lcpWya++5IqbW1OdLBuRuM7w7pRxTURI0YnjfdfB3fUDBtrDJtEGDNTR?=
 =?us-ascii?Q?Vx6+aX8ophwOLYejc7yP3yAWAU1u0AcVH9TJpWAM12L4uImMqfZ2yPaP/Kjo?=
 =?us-ascii?Q?LIsOMmWoy+Ml3dc6gIsKapRSd+bx24b8uCVxtEwiTuP43LTkxpxRet2+0jrg?=
 =?us-ascii?Q?hKg8seuLTW3lz/23+3pnHTHZTiNP1MYacMuJys9JJsJe9IamtTwbRFexAuKs?=
 =?us-ascii?Q?SvX9Gkm04lM+4+C7T+48XkbgSYDQEbG1eMQ?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QAvQPxAYbANjK8I5hD+/w1B1fVTA219HVD7c0ynsIj+rRgenS7kVU+TMNqRBt9JUXFMsDfMq718/NysD+Vh4N849dlt3PnZvqlGcLSOYaojRrorNTFAAwTYuIVdJiUjhd1fLaprhBX94+hSIIFP3jjBAZP6Vc3gXGI2tgbr8n58OMCJ9erw4Y9AkEN+YJQlyIbO5wLpa9xgaa+6RR22ExcPHaOCzzwilqsPS3aSbx2j3SZeenws5GCC5slMJx/txSFLmyy140hCDFCTF+kvgu2FWOOeHV1x+4j1wtTy3F10TtayPr2Drg1xXpxpcto5j7QDhvCJw6M2JenJJXLOdWbUkktnybb2NZAuqqNx8aZ9pE9x/f0gE2/f8Y9gJxZEawZJMl3gxES7lA/uiJEPySkMfgCgABE77rObWZfMwV8Y=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 08:51:49.8998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c925a7c6-09f4-485f-9328-08d69259a8d2
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous style fixes from checkpatch

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 78085a8..b32d67c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -179,8 +179,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
 			goto out;
 		}
-	} else
+	} else {
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
+	}
 
 	/* end of msg? */
 	if (i2c->pos == msg->len) {
@@ -197,11 +198,11 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 				i2c->state = STATE_START;
 
 				oc_setreg(i2c, OCI2C_DATA, addr);
-				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
+				oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 				goto out;
-			} else
-				i2c->state = (msg->flags & I2C_M_RD)
-					? STATE_READ : STATE_WRITE;
+			}
+			i2c->state = (msg->flags & I2C_M_RD)
+				? STATE_READ : STATE_WRITE;
 		} else {
 			i2c->state = STATE_DONE;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
@@ -461,13 +462,16 @@ static const struct of_device_id ocores_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, ocores_i2c_match);
 
 #ifdef CONFIG_OF
-/* Read and write functions for the GRLIB port of the controller. Registers are
+/*
+ * Read and write functions for the GRLIB port of the controller. Registers are
  * 32-bit big endian and the PRELOW and PREHIGH registers are merged into one
- * register. The subsequent registers has their offset decreased accordingly. */
+ * register. The subsequent registers have their offsets decreased accordingly.
+ */
 static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
 {
 	u32 rd;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
@@ -481,6 +485,7 @@ static void oc_setreg_grlib(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	u32 curr, wr;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
@@ -569,7 +574,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 	return 0;
 }
 #else
-#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
+#define ocores_i2c_of_probe(pdev, i2c) -ENODEV
 #endif
 
 static int ocores_i2c_probe(struct platform_device *pdev)
@@ -686,10 +691,11 @@ err_clk:
 static int ocores_i2c_remove(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
+	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* disable i2c logic */
-	oc_setreg(i2c, OCI2C_CONTROL, oc_getreg(i2c, OCI2C_CONTROL)
-		  & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
@@ -707,7 +713,8 @@ static int ocores_i2c_suspend(struct device *dev)
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	if (!IS_ERR(i2c->clk))
 		clk_disable_unprepare(i2c->clk);
-- 
2.15.0

