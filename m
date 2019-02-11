Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A483FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3B9222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="c68rUgo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfBKQtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:49:51 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:25040
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727508AbfBKQtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8L7gT61M9vVz2cX7bxzzCq3pxB/5Yfg8XiFVqrlaXk=;
 b=c68rUgo0AQvczcJWRYw9uAz1/65KmODqpYOmDFrdRbd4F2n5Dg3jmFtd0a/Z74CSEKdYisqcxIm6zmNDY/3XTsFPJViLW9+TnEkSNrN959jJ7lZh+7ovxMTej4vnYhP098ooXnblqlmCY2x4sCgpFqr6IMO4shUs+8EeXG6+fmA=
Received: from DB6PR0601CA0024.eurprd06.prod.outlook.com (2603:10a6:4:7b::34)
 by HE1PR0601MB2154.eurprd06.prod.outlook.com (2603:10a6:3:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19; Mon, 11 Feb
 2019 16:49:29 +0000
Received: from HE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::205) by DB6PR0601CA0024.outlook.office365.com
 (2603:10a6:4:7b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 16:49:29 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT056.mail.protection.outlook.com (10.152.11.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:49:28 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:27 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:27 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v6 5/5] i2c: ocores: checkpatch fixes
Date:   Mon, 11 Feb 2019 17:49:13 +0100
Message-ID: <20190211164913.5988-6-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211164913.5988-1-federico.vaga@cern.ch>
References: <20190211164913.5988-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(336012)(1076003)(74482002)(486006)(426003)(47776003)(50226002)(44832011)(66066001)(8936002)(476003)(14444005)(126002)(107886003)(356004)(76176011)(4326008)(51416003)(7696005)(6666004)(446003)(2906002)(2616005)(53416004)(48376002)(956004)(16586007)(54906003)(8676002)(106466001)(26005)(478600001)(16526019)(36756003)(186003)(86362001)(106002)(50466002)(786003)(7736002)(7636002)(316002)(305945005)(246002)(6116002)(3846002)(110136005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0601MB2154;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 953da2e8-04b7-412a-d848-08d69040e3a3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:HE1PR0601MB2154;
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2154:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2154;20:PQkKBBjdKS9l2j2VdSYOZmenlkgiAyRMxGKvfwJmAU9tWNoE/37ZIA2R7nsXKbVjjbf6qzMcCy1eb/jzGIZSvxTgFhYVD+uQ/s/EOu+c5YcOtoout2XTe6XFgJjIqIgxH+KOanrlGi/400wkXQQNJQH6aMOXXAuL1Om+VhRIz4vSqSYbePU/++p+rQQd9eJ8e/jCtYzbXsENwx/ETjqOPenj7vXC0Py9KAbzG4vUGEv+L3EENkfii0oYnSdxBsEteGNw3foFqLbaxm4nD7llasH2Euj/Xn0gkiwwu3o5fyl4rzg5gT2FO1a8YAmp+k+loe8cpcVxjS2+afupWJpU8WNI+paeILj5tdWYdfkIPTaqpH2BW4+FuY/2HMX8I6TV+MuoGiSfgFYQ0qPyvAjsBXtPk2vZa0aaDW+WbEa3cLJB0w9yy4nkZ+wt1xi7Cb2FVC/xB8pjSK7/MgEoM9IcoCbrIAISVzV/fW0BNFBLRVxNsQzMeMue3Cmu2ny0l/xr;4:E/ZxL70e5sajGVCKD7m+8Sdq88mlwD0pExP4sG6s5uv+iG9ZPJhOBmN+f3YqKiLPWpwI7i11WOibYGH8u3imB3bWyxWUwIfHSKGeR3JEOa1PNOTE7csomHQd3zMpUB0z962Dxi7hulSv2ZIWGNj+MfAh34tQ2gec52D5iRts5LqONEIRVR4SzUbrFkuB/bRZviOc1PXREBRf4f7b2ENaSeKbezdGQaXRZXRwsH30zFoPgPrW9n80wKMUnWFMVdESFG4CqY2NJ8fAVm+GBFxIRy/BQy2tzAwxSkEOS9S0Lo4=
X-Microsoft-Antispam-PRVS: <HE1PR0601MB21549BA3F863C70C128D76A9EF640@HE1PR0601MB2154.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0601MB2154;23:w442IC2RCzL5lULXoPhgP1PhbvmZjKz1X5A/zI4?=
 =?us-ascii?Q?1WMJir6iqp2kHs4oOwTvN2HyrzEmM+TasztQVXhTMSsnazfHmo4qhtFCcYby?=
 =?us-ascii?Q?aQ8MS9SZMhV49CcIErsE15EaHvmyvxO5V1wtXwmyCW7jxz6Ob39PSrY/E5vb?=
 =?us-ascii?Q?6/QV/dqbFOm7Cs8jxuNuNV9dwoOzgwOi7OKHcMnswAqoTEODby5F49xPUnV3?=
 =?us-ascii?Q?NYaakeLI7BwAL/fMK9rgXukHvRqtLLu18CT8x+oQM8RoyZQhtMqn20UVsUJh?=
 =?us-ascii?Q?lQN4iIe3SfnDqmSE+Ctswc44i3a4tI/+2W0oGaPrELqgB7vPVhdpLwPLTtnL?=
 =?us-ascii?Q?XjqDJ77snf8zTBcpM+qElYH+qQ9joN/5m1s5TUSO+SGCu+hGC/6mlGdgjS9k?=
 =?us-ascii?Q?XnVLF4cZgE7JMzVMkxWS3Qka84kKM3Yxjn2F/a4xDxubs5XEEodZ3Ckke9QU?=
 =?us-ascii?Q?q2VgoITLzUjh5ALi7ugN85I/KXGB0ww0RUWjfkEb2WCJSvMliGKw8nyfkSl6?=
 =?us-ascii?Q?gA933+/dARTyazmM39tfvNzSwgpGvfon4UPFTq1BsW6o+ypkjLIpGCvsWUoC?=
 =?us-ascii?Q?hJz2nPeTFKCXiXlQC48yQ6xmcjyAv6HGQnBlh8kg2XmVpE6QA3vMGoI3TtDr?=
 =?us-ascii?Q?ff/GxTwemVETfFHWCKa3C3IHKnWeJGvAd6FO4pOzDc5OO81Rs6KR3+pq0sxO?=
 =?us-ascii?Q?1C8qiFJ5649m+OuPobjRcRDSINY9WONysECMkiQFmUMevLaDPK96v0ODC5aZ?=
 =?us-ascii?Q?iyi2thxKFDJgf+Nz5DEKR6okSwwDwpPxDtAUCp1ywoQ8Yzq+45nRQH/Tys2J?=
 =?us-ascii?Q?367gJde1IQNPawQ5Z2wQ9ILsmx14QGYSrs3GyrDhpkEkR+xNDiNWkhJaTYiB?=
 =?us-ascii?Q?EreysG+5mti38PoOHaweBypIlMW3wYTKc1cEpc+J/PGwV71KpscYs5ffGhLv?=
 =?us-ascii?Q?zp0pRxiETpB/LHeTOHpdQuWsjbIS35uqSgwcFYy3qx06ysV25dPTqfQKsr7R?=
 =?us-ascii?Q?vwGTg9Rs6CcYOcWBd7aotaoZVoRsGastBdKnV6EHZFOSQ4DSMl8VnJM0tHJv?=
 =?us-ascii?Q?pOYlMBmk19Wh4DDJgsydLm6zzGanF+SyCn0LVVEfB5mUCZBLal2KJNecSHd6?=
 =?us-ascii?Q?l5DDmDt0MXjqJ2k+NKotX0rfkHA/y82DZffbMVD4Fl43sguXxCKXgCkJxfvU?=
 =?us-ascii?Q?LgxIUtEb3WxCXGlFlqrY5DghHklr/tW64hcCj?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: orDyluatGvjuLGON2UOKQrYGZmEHKWqTx3Dlnj8D7Vv9YSFhAuMC57n58aoPTFnYxSZX+QzK9CuIU+Uc4mo8uGnEPXeMKenrAUxcdsPCX+0auoEw6o3I7zzTFPK7DCEnDJgOAcWAveH26EF5L9dShbIg53NIpZRocbtmehR6MTgGel7f0DjclV33NpId5qHJMY3ya1FJ0doa17oMiopieiaInb5iczCLVYNnsl0zlrDzmnq4B+cd5R3LNxOH6eVy988/tCfL4Shj09vSRUTQY6TMmdoP9r3UJ8RaDxwVUvxoNUFadMIUVedCoze2eHiXEfxQOo4CVg3uWcA3t4MV2Tn1v2VyH7g/1EvFOme+Z2Aa49cmDD7gCSd9Bb0PONqhfNkYGvQER1Q20C/KiRsflWlNtpcHzUiVwH6qIdpLS9U=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2154;6:+4UGPPZWBy57L4++wmySfxJObnB5V4m9TYDt24xc9omzNUyaYp5BqFHZg29Ku2foI3xd8W3261You14MEt4vxVzbDjNPwlYnK0FaQzssyY7NYW11vwYbsUotWfMrSdozizzXFXZAw+QVXmGAsMPf1/N3lt+44Muk/cVrSVHGd1u8I+qDakyl9afxBF1TfU4kq2fK95jahPw8IP9uxR2ul1aAqQX3rSqeWz1b3dDQGQ6KfIWG7Cj19biuAtmRRjhsVHzmEriBVTMa9U5dErLxsLGG/CYTtqmJeUwuKp4xqoZsARpxjJjnKl94h1nIMdmI8pll8pv4A5J0Z3TnMzLLPmp8o5n3bH4w4sWQtaYunL3d22NQAErD21Oc1Oieebwz2Y0S1VlHZJfs9u97fPOyODfb1yb8JhBOoIgbjihnAmVwX/MSy6phKmi+5O2uoXmDXQ5MsboLg3SixZZu+FpexA==;5:lfsuPNl9icJGTs0xTfBsKY5XHT+lB//gka2m36CyIxVPODbGd1nIo8FvgEt+JL9gDkPGbwo7lglZg+ykR0rJ6MQ2JWa1TgBHlJ6JlwnsbOAvUo6E1Ltcg6fn9AblAFicyTNNdIvI+1oAIuaJmEAUV0HOYLL3mMzTHYOSNxvTg7E85hOCm4uk2+9BaDdvCYxzDApUWy9PebtCjFhsxm3mMA==;7:9b4QJbeO73RO7klMKILZ23Vuj1/9q9hK2pK4ShbqOTabi5iGzSib5t+0gQ+XwBcQQEa5lVGpfPRtNrP0DdcHQn+u4XlphhrdG2qTrZiim+LHdmVbYnpNNxY8MtvlOfjCKZ7R0SOr3LqmaVNTwuw5jg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:49:28.8033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953da2e8-04b7-412a-d848-08d69040e3a3
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous style fixes from checkpatch

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
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

