Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE11C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A802D2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="dJ+9iEFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A802D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJ2Xkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:40:41 -0400
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:42688
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726863AbeJ2Xkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dEsFXfRGBYqthhjOMvHcQQ3/Wj/6osshbgNBnePpTc=;
 b=dJ+9iEFBiCyfvFqtFg/rjWVKfEA0XyyDoHbKz0IaZb/dkFc1T6GfRjRXJBLLLjYAv7LmjxMIAjfkhZa+k7V4jZ16vwOEXLAPeJSrHVRl4d6zLh04/lNWDbmIuw+a/YgKNtwoyDh8RKQFS+BjmvWQEa6LkdijfDt/8LqNdPQCXSY=
Received: from VI1PR06CA0121.eurprd06.prod.outlook.com (2603:10a6:803:a0::14)
 by AM3PR06MB515.eurprd06.prod.outlook.com (2a01:111:e400:8824::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.27; Mon, 29 Oct
 2018 14:51:38 +0000
Received: from VE1EUR02FT027.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::204) by VI1PR06CA0121.outlook.office365.com
 (2603:10a6:803:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.19 via Frontend
 Transport; Mon, 29 Oct 2018 14:51:38 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 VE1EUR02FT027.mail.protection.outlook.com (10.152.12.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 14:51:38 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:19 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:19 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, <linux-i2c@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <federico.vaga@cern.ch>
Subject: [PATCH V2 5/5] i2c:ocores: checkpatch fixes
Date:   Mon, 29 Oct 2018 15:50:51 +0100
Message-ID: <20181029145051.31984-6-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181029145051.31984-1-federico.vaga@cern.ch>
References: <20181029145051.31984-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR06MB515;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dc42c77-9cae-4360-d45d-08d63dae07d7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(5565046)(2017052603328)(7153060)(7193020);SRVR:AM3PR06MB515;
X-MS-TrafficTypeDiagnostic: AM3PR06MB515:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB515;20:ElnSq6edPW1xEULzGG/pFzBk8S//B8OUpZ7mEmfMqdSk2GKHWSF/39aP2k9W+Osv/M13FyJnOm58hZP9ZyiMYqUaCMsH+XohbujrLcNtvzIXYavGoHZuRAvTrZRa1Zg/YFKI8i5bUll3yckL2Mwv9P3LH7PXSDEa9wPJleb5+HLupBoPwi0PGPeShJFf+2ozCTVfPj5ipSo3ckoeqZt0oOh8mhoCWkqdH3OzfseQVtmA5/DYKKEu07JHI1aCcBJopQiYR4vepwxokFP2Ox2wgc64Ta/T6dYEvSyDBMfYEuJGD3O9b+GLGjRXdAscQGvlt08l0DZ6lQTMz6PYR9qXHy4wdMFjtL2vucMpX/oqoMTq+stiFcfw14PvAlVCrh6YdG1RsPUPVaEjyYqGMmgk0RXBwnXvI7tMbEN2EvcML7avEBNkN0fJCoW5pUHhHElHlcgCzhgUCOyB2evlowQBNcwM0ot0nOP3vL3PVNCgE0/kn3/lPjORXgDqBrHvCiAx;4:0VaLikvLyDxnwVCyqYYCVOiC3l4XYrDAQGTD7abjmeDPCzsYd6oNt6I56qN3aHwJPQ2tOyMBI2BSqlSwFlAl5hyeNH6LlAm7/WPDhNoOtDTfRiQhYzGRK9/HxS1xvocDy/VG36rdbBf2z2W53dLjuaTWCOt6ZBs6sIrLUTXIGW3/F+ZerqBgxQjsCk0RMV5eysVJ8Ys1LBaUxyLl2M+tVyaby2WYp7NJAcX6CUDw3eoBslakzGugJLYhZPl36gPjwMjWPkjDOlS+havYdPRp5g==
X-Microsoft-Antispam-PRVS: <AM3PR06MB5158A3E49A3CAB66E8E3647EFF30@AM3PR06MB515.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231382)(7700054)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095)(7701012);SRVR:AM3PR06MB515;BCL:0;PCL:0;RULEID:;SRVR:AM3PR06MB515;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB515;23:+z6bk6nGSl2E5vvEQeFn2QLU8fP0rSHUG1g5VxFl8gB017kHIXFKWMtxB2iYoa8WICrnUZpLb5YGZeC9jgGrLon9Ez7rommbs1W87grzDNP0lQRdtPnraeXWxViRdSg8nw+PfVGRSXO886jpTmBk8a+RCNMvrfJrVLh3AcvqsrPrTm8YXPM/ktJ/gn9sZ0KN;6:Crr5mUCidWAIZXQ5y9JP8Cv+sbxPRM16rziWCxuqVk5C5wczswpuHf7is4pAe/jhZmsLzKZ47fL5aDbddVpG2iE+KxcvmzwtSojSkPV/0wp54nY4WKObl7JUuX2/40cuYEbj4etLamY3D0Ucr4CXrrgJQ8gVXqiVEm6NWN7vPq7PVIWRSwkvV+71QMKj/4aU3WM4Y3HLMrd9Pc3QV0cGVABtlbwBW28v7J8Qljxw/zgb83M8NMXwJ4LInYU+U6lHCuSYydFhQ6c5PuNv7GZPKNB4Ylm6HO902DCQ/jV3KlJV6myb8rOLe4Wezaq/mS3Q97hkUM4WexOpFCySDDezxHfdvq0+WjOb/QTXyWK+3YA1RZkDpqFge4M1HVUSXU6QoVO/FkLfImttCFYSi6SpiVOe486MTJcMteAsqOzKWUpIpONcu6Sl8rXciapJA3B7ZvC4HLVXFI2edNVUkpkDXxw7NogeOePxDn4ycn0QqHhDQjpDrlTaV20Wb6F8PKj1;5:BAw//8qfxIBaO7d3jdH9B0tUIDocTCEnPhwWBTpYAh+YnkdIAsbx+/8SOeS4cR+6Far33pt2tZhhMjGHNFSTs/qmhx11OwVOHVpNWr91K0l9zeTMmcqAsk+YX0i+RPQWh0O6ae6GNKcyol5DL5CLsBUJ5HUwFyg6eeSPsuJD9rk=
X-Microsoft-Antispam-Message-Info: D0P0y3PBkhWbbTrA0yU0fYla0CtN1V5mrFHiypKelsR4ZANv3cbd4MaH82EZXmY3b1NcvlRSkbll4536wTG75H0fvTIwU7aDC+qBalSyaqJQqgP0ccmjBn3Pik2mizhnlS1MOgQS+Ii7P+sAeNjkYUKrVQDotenSHOZA1j9+KMHLBZeIz+YH1jETNwsamrWZdzLq2HBn71BF+pTdZs/p2dnPCvO4miRNFXb7bhpBDnOy0qvM7Yylf0i9edwHq0RaCpWWfWZgkW4qm0CjL1XQ8JqCG5VevUOZIEvQdbM6wgzktpANtdhYWzTX6cqQbSoVfAm+5fRWNxTAblLkDsVUfBtd5LPSpGkzzXc1WB1oP0VHA1U/V3R14Vc0dhn3EOIGOyOdNe8/QhrtPr9RmWooCazlyFliIRC42f0B6mPaOuIpb+8/SRl3wZlxmHTiHEFY78uSubC106djegRWt8DdzxHDPU/q5fwHxGxfhORdAdE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB515;7:Nwr6vZddDUA+01bLDpWE2HhvAHKVmALlXuH0QpU5Exfj8Sb7Tb1je2MGuvZwupWkKNtXkA16fRz2vM2s+yeGbQ0aY+Tgshkb697Q+m0o3hUIkDAfxK6TY3xC+oTVwN69TAgwRKXGx3qqeDK/hJXU9Q==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 14:51:38.2036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc42c77-9cae-4360-d45d-08d63dae07d7
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR06MB515
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
index e48173b..52c062b 100644
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

