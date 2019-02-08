Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7EA20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="n1OH0u+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfBHQNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:13:15 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:64546
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727427AbfBHQNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnHd57Xy6TUUABWh3UsLV7+RWZnypHpk7jGY3BbQSUs=;
 b=n1OH0u+YpFgu7nFrJG5rY5aMphrNpK8xkv007lRvA3swXvmAm3Pqe7Y7VJB8OX2mwiLwf4C2jUxgcaZm8isqr6h4B56Nr7FS6ukwbc/pmDrKMI6/5bsLA7rVVDQCpoyt6GVPljU/rPjNo1kNUHP86DshMJbWgvHQDksCFrDrpXk=
Received: from DB6PR0601CA0048.eurprd06.prod.outlook.com (2603:10a6:4:17::34)
 by HE1PR06MB4009.eurprd06.prod.outlook.com (2603:10a6:7:9c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Fri, 8 Feb
 2019 16:12:31 +0000
Received: from AM5EUR02FT004.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::203) by DB6PR0601CA0048.outlook.office365.com
 (2603:10a6:4:17::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Fri, 8 Feb 2019 16:12:31 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT004.mail.protection.outlook.com (10.152.8.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 16:12:31 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:23 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:23 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v3 5/5] i2c:ocores: checkpatch fixes
Date:   Fri, 8 Feb 2019 17:12:01 +0100
Message-ID: <20190208161201.7860-6-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190208161201.7860-1-federico.vaga@cern.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB4009;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb222d5-320b-4b39-c4e0-08d68de03a93
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:HE1PR06MB4009;
X-MS-TrafficTypeDiagnostic: HE1PR06MB4009:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4009;20:QMbnoxQZP9LEu5UrKu5lJLUHjnz4E00kcIOSPhoicFGlUwo+r6fSmS2t76NTZGND39QXNwBUuLmFKzSBeX+jdHT5lORwjnTsrFaCVKVxy8Qn/K6CumzvrwejzGj6Lot0pEnErJ4GMQVjS9z1AJ9FiJbS8gxsAt35FvA4fZ8VKe/dszRjNBbDBIK4aPUkprnsz887szNSV7qnosFx/2SR38lD0j8NC3uPJjTbBEnMH+zuk8GNV8ruJilf555IgDQa/XeWqAF0DjrDqtzsFGtjrPLp+sOOf1DsLmsCY+GV04HOh/04+DhGj4lbc9/x1KDxH4+sPSbzlbl/OpMDxieC50x43QJT3eEZfUrgYLBhtvOAOM3WjP8mDnk/ZGqbbOsb50xHtkMkrsdjl2qVSkAwiqmBkVDxwarNPAcoIjS6uLu3p3vOroFcN7SkWi6OaQdjDjFqnlabiNg2dbAo68+GdrwJt3/9VZglTE0WsKxj7K18HsoTm0p3CTvMktz4h2v2;4:ymjnpUliq3IiAKRQL/OZQhgWu72FIktUxWvU3biI0sqDKwL1DQbYF0wLA786ZTwjSdNFAX9aHsRq49vcfWOmfjKfSG1gwbks4s+ze5YX+On/ODiLobMkGIAy1oQ6b1XsWx3HE+StDKdav5VRkHtQiKeefaQmUwkraX3qzXsYgzyWBvPxjb1mTFx+teLvGoMItUpwLBdxt13WZ0Hr81LB32O0BnyD1g/+FPQTWZsCdCbDjXJdeNs+Em6Y1kw7eD2qTVXOJ1yQ1LME7WgrDI9AZK8rD/3dpdBjZVCJkwGEqRFNsJFqOiKjk379q+OiUvsf
X-Microsoft-Antispam-PRVS: <HE1PR06MB40090A7F291395A2E3DF38E5EF690@HE1PR06MB4009.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4009;23:Vl01dpGtV9AtC5SHV9YTwhl6uZbj3a68y3O07EsYVKOL15mc8X/PQnDCX1ZjfjM5q9mS5DPbhK3RP3g1SlKwTZBiTe9HeXhjyouC253bFJ/x0jPoRvd8hU9FBf4IKcvGYYuF3D3FcDqABpDNVpat0jTpmTG7U54KCHDD4KkTLn/ZFQ9LcwRZKz2syWiojRJ/;6:SEgf+B2C8rN7IPVyrbYrjKPKheuOstQ6mXuhuNxcZzT0McmCQmpEwxaTG7/i9DalV2H7QmhiMks50cUBYnq/CH1YYC0/HO/Au3WLAzwQfhyGcn9VyyKYlLQf+2FHD/l7wFe9uUgQnkdfCBQvkG+fx/+Qk5xFtISxw1PnRnJAJ8hvnxgt6DrXV5QuG/z3CMOvI2f9oem3772iE83p+ZsxYnp1aNb2EePtSc+qy0peHWQ0COs6dZOGTyR0nCVLiahRFKL/wUtBX0zu1ArxPnGmK8Bmn49RnILf3HXREyH0Nes75P5LZ1ucfbSHJFUB2AiXUHaLe638xYvU4aUyoXrTLQDje/KGtMA4F/+xODUV31Pr8WsHHUg3Li7kqEMtT2iotzG9Yzy8ic7kT2wB7o340hhCj2jarfHBOILfuZbXAWHkFNWFQZbcn7piv4JtVunzFcvFHcHHpblT2KK17mAm5A==;5:X6P3RUlfZ3+i+U+IOsxdwCTXdShjNqeKx9kdrcMnnK9ECfjPLURAc57+dz+IxJ6UoHxNv5kNvTZYOWk1kzfQhl0IpJjjzC1rcNbkWUtzzIG1KtY7uqsoTA+CS5eBMulKCWCnumxu/rplwlKOZOcGPCtzhaNlkRowDnaZ15siJmJhOPnWDmsRTDJs2CwrE6ErUbiz/lRPwEHSbQBHCuN+ZQ==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7acAZCXRRyua39Kqo6TY2tjZZLg13i7PQAsgSbZArIz6xcdu7PP/PcOhHdWEwa1tkb+dF2PFmnOBga1+vLHLCzSpIcUSRM3qiVwW8QweX6ZWCTEXZvAzX5mmhhDJ5LtGH1P6rcWWQoKhd97ydyBL4slIz4fWRD8ELJGy22eEMBaq3TAkeAvHXEKdauseGSooHlxPuP3Izqv/wAQ+ovGC0UNCD3miHeSCEIlcNXLyByLrxI97me0JKOb/x3EfArULBwys+cZ2iheMo42VIXCynPiqm+iNVz2rgdT7E7mLLgz3etQW1Yq3XsG0CfLhOVBLoe8zaAdpQMFtkndfwpbuWuqcM6ObVsZWLpE6/r4oqQ7fy318C9BY9KNAFRXL8WhFCjNCLV/ayqljFV8lQGa0oPRvrABK58VenlfiMrxo5gxumOltqwR5KoiguJcXL4Fk8WWrsckCl8v891kcIJACi1rEtAbNnOMGgxSKT/OPlmsibqdzsVsc6YONJz3GqjZo50zbtDzCK7cWaJ86dkxBQUqedGUs+74ZOvXRLvFPZCs=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4009;7:GUjGXxxiPooBwvfObCAQscxuq7Zv7Uc9znIrTV9qbxZiXnS0tj4OLNluuxWpj11kcp2fO+fhcEWoXbe9KX8JoorM7UJ42aFtbdXnGuTONkNNAWRzR90jEg5rGGLDUyNINWdiXH/7bCm7AEJVOgrL/Q==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 16:12:31.2025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb222d5-320b-4b39-c4e0-08d68de03a93
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB4009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous style fixes from checkpatch

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 5b80190..ba35d2a 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -182,8 +182,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
 			goto out;
 		}
-	} else
+	} else {
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
+	}
 
 	/* end of msg? */
 	if (i2c->pos == msg->len) {
@@ -202,9 +203,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 				oc_setreg(i2c, OCI2C_DATA, addr);
 				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
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
@@ -405,7 +406,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
 	prescale = clamp(prescale, 0, 0xffff);
@@ -462,11 +464,13 @@ MODULE_DEVICE_TABLE(of, ocores_i2c_match);
 #ifdef CONFIG_OF
 /* Read and write functions for the GRLIB port of the controller. Registers are
  * 32-bit big endian and the PRELOW and PREHIGH registers are merged into one
- * register. The subsequent registers has their offset decreased accordingly. */
+ * register. The subsequent registers has their offset decreased accordingly.
+ */
 static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
 {
 	u32 rd;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
@@ -480,6 +484,7 @@ static void oc_setreg_grlib(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	u32 curr, wr;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
@@ -568,7 +573,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 	return 0;
 }
 #else
-#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
+#define ocores_i2c_of_probe(pdev, i2c) -ENODEV
 #endif
 
 static int ocores_i2c_probe(struct platform_device *pdev)
-- 
2.15.0

