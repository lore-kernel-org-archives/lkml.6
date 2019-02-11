Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D37C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA15B21B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="dZ4q8P4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbfBKQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:06:01 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:10080
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbfBKQF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=166USv8LtM5kWNjMW+EFOP9fjjPAG6JfgPZJuHW8ubM=;
 b=dZ4q8P4DZ6VQ9fTd3EGF92c+4tyOImQVGcpCPsZHIPNhugtiqxPH/5w18niXngHxVJ+NRT92CdgCm5kyuRetUJ0uL/mASZwLnXcrTDz/SBVQDhy0lftzVBmPDLjDCkC9cVIeNtKosUAskVir47nMzKFmehJbIvKqr6T2ckyIf9A=
Received: from AM6PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:20b:14::27)
 by AM4PR0601MB2147.eurprd06.prod.outlook.com (2603:10a6:200:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 16:05:54 +0000
Received: from AM5EUR02FT053.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::201) by AM6PR06CA0014.outlook.office365.com
 (2603:10a6:20b:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 16:05:54 +0000
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT053.mail.protection.outlook.com (10.152.9.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:05:54 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:44 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:42 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v5 5/5] i2c:ocores: checkpatch fixes
Date:   Mon, 11 Feb 2019 17:05:29 +0100
Message-ID: <20190211160529.23858-6-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211160529.23858-1-federico.vaga@cern.ch>
References: <20190211160529.23858-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2147;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bc91249-652f-4817-5213-08d6903acd32
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2147;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2147:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;20:pcDUzFXMkZk67qbGk/al9butmU7qFejWIAkixFi1BOiKJ7g3Szbgo9DI24W13IaIIvBDIiVukg1r8WyU9Wvw0aoxxobPZtqjLYM6bXSO/I1hABRPos81OxnkQzE1cwb5ToByB22eW5/61UofLylBB80cCVzdhaALRvOyYOTFVKiQFh9XHUznMYVLFCywaWNwtWuPylOLqFdqPPbSObisrrmXd+oMYv/9cTL9vqBIcSmTQ5sqgOUagXzRnB3HlwXzoPAPAVO2XiHnIKnhhkpz8+YV3Dggh7bU9wDgXWTmA3I4w9lKoM4CsB/WcUFkvdwZeWyRfiQx4VsfOhNw+Teut4BJ2rYTs2tn2btvLa7SR38PlqJm8DSoeE+kjFE91qdp5IVJ8iMG7AjfvjbRPP/ELTMmKAZowRMqDEN+diZmQ8yJ47MkUH1n4LVkfEiIY23zGxvAzNEViUQ40Ey5sDjqXSWQOdmuACuw5Te1Hi6Tk350Wn9M+ojKE6Rdb88eAaVz;4:Ouay76eHOmAE857qk5UpnhDFJ0WkXgxmuCktfzzOZkwcvni1adS4swXPWgLLWUEfAh9sQ2ndgPA3HQhG7Yv69cCdsy91YmgGVK06qBvQuANbNetyNFdYH6hctKP7sZcJE/H5mPm2OTC2fIF6fAXB08jUrfCcG/cHS06GMHhIk/78HgnehEo17miM/Pix4Z8kwiS0pd25UNRSlClyhg5Ut/4LglvryfHilwGgX80Ahf64RbFXzXeNBvcAaqjaCEHdJMR8Tol5Spg8/QBI46Wr6liZcV0M3iVpQtyYjOUcw/361IqQ1svdeYTd/GdCPxc8
X-Microsoft-Antispam-PRVS: <AM4PR0601MB21472D23CE8139AB5E9A68A0EF640@AM4PR0601MB2147.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;23:NzgxoFaa1zKT7B4Eno341B7uxZNLQQfP+nqU8DSmFZHkzLaOIVVVpIuOSl8hzTCoYSkPXl7POlRSIUPX5d4WR1o7US3Syt0vNx6RzAH/PDJN/amtuUT6MsJT4Ss9mq2gZFbEMKiYBd+yRRn9IiCnOQfbkY3x6OW/nIVKErIztPePCC1CPUArPaeNT2LMeEPN;6:98AnRUtxiQ2S7cj0QRW9eaODzlWBTJiJBoBpHjJIYf6eb025ej0apIK4zwfVq5iU4Ts3s+p3/3yQvR95HlAq1PtcmwrNxWeSIKRxNeleWUOvjfa6+3XGeP63hATQqr8pNc0QBJ8kWVaz+XVYsotcLgnwtQlNW8UoIe9sDmRcJHFI6p8X6I2bieMTsY6UlE9TMQEt6oKBTFlaP12U9DfZNH9jK9K2GLza7WJHchqb2VOjbi94zhoYzzdkr1irmzj7hPi/qrqgRnq+INxxxfvVNWBbLrK1YRT68yQRSYd1/mwzlVFwaIWiJNjMujxyUSq0oPmGT9oIOltpCXgJmYS141sfjMfodB0EY44aM7b0y3b+6FrZRwaGOE3XDKSlp4YuTjBQ5uxdmIaqp4kqUCv80Vg9IS3t8CUBb+RLeeV85y1HeovVhNaCsAtPn4ycB/HRpb3Cl3bbWCdaiTm6hQBJwQ==;5:YpjoG+ZvE3n7/+kaSluazrnfpR88pZfhw74W3FtWJTHP1rZKwlHOBRYfxHblG5Lrbf4CIABAHnzDsMyZ9RDXio/oZt8l77BAidSl7/zCGfyC9ne91z//OO/7dpZ4RwV6uhYpCIuZrCV1wwROnCd6olWukkZwEngqYsjleuC71nMB98lCp6SACqbXYDKPDg9JdistOwwb+ZdBVq3cwU8vuA==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KxZJIhFCzL2wLoMiaDtbPt3U55gG9S26zb1YC7nGqoQAziXn9RMhCW7pVsMfdm4Mt21V0AoqFNrvuRszauJxoWDDjfKWG4qvm2DEygkZg7k9PPeXYAPkFnPAq0lMXoSJXeJLme7S8wV/8Uo3OMlm1tVOTfr2h6eQjiDGHYIsGWODB11yuQYxZeXS78sJseOsIITB65A7c4L1tT7Ie2JYc2GyQqceSGsEyckDcb08lqJDwI4Zip4YOcsitThy2TXloymfw6HORxSq4auktnzgXylNVQtrza3pjtJ9uYN+5ukaXOmEYBoM7ISIlM5Az3R9zRQqskdGqniCCF0JWcHn4wtOp2SHLqcPiC07DaQ55GvWkJo5JYluyl0KjD7mHYM3ruRyol21ddgfkXYSh9kNBvJQSEk0XYHcCywJszzTTAa2kTTf63B3fMeyeIuqjDoOoHjBR0nVxRgfY2sUUg/rKaiaIXOIJaRs1bEA9++B0zZD0aA/3E0v5rcMT8qexJSwsNnYJsgKITYzMkORxAT9XifwOit4QRoGthCU02WB7kU=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;7:U9UFrTTIPNK/zBj/kNoIc//4whau/PpF7w62E4/MTpWk6xA0fQtCw98OiGKO77wpqZ0JjBJcwpDbcYlznRLUON6Y2LPOIcFwGhLzQU75W1NlBcFESLZ3UBkIuGJBvmbfc/AoU3Xvmr2D8YO0bQe1PQ==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:05:54.2241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc91249-652f-4817-5213-08d6903acd32
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous style fixes from checkpatch

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 78085a8..54b2156 100644
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
@@ -707,7 +713,9 @@ static int ocores_i2c_suspend(struct device *dev)
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	if (!IS_ERR(i2c->clk))
 		clk_disable_unprepare(i2c->clk);
-- 
2.15.0

