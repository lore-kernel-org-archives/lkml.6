Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495BD222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="fu8g6JK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437706AbfBNIvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:51:55 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:23475
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728448AbfBNIvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObKhDBMMDmTNvLuJgDbxclXKe6EO8TQRzAdayfHAdkI=;
 b=fu8g6JK4nIBLRoAzaX0Ljaunjl5Jhm1zIMDvqXWFpj5rW2gv3ro1l4cBMfgo8r535piAulEfWyPmOuyA63lCxTLPckKFAU69WmHzTx3tg/qdeuEfGXywJ+0KaXlT7MJHnAIqjwAgczdHr02R0oFITjsdOhJ5dRJ72DGSb/Kama0=
Received: from DB6PR06CA0026.eurprd06.prod.outlook.com (2603:10a6:6:1::39) by
 DB6PR0601MB2151.eurprd06.prod.outlook.com (2603:10a6:4:4f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 08:51:48 +0000
Received: from AM5EUR02FT027.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::209) by DB6PR06CA0026.outlook.office365.com
 (2603:10a6:6:1::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 08:51:48 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT027.mail.protection.outlook.com (10.152.8.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 08:51:48 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:46 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:47 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v7 4/5] i2c: ocores: add SPDX tag
Date:   Thu, 14 Feb 2019 09:51:33 +0100
Message-ID: <20190214085134.12900-5-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190214085134.12900-1-federico.vaga@cern.ch>
References: <20190214085134.12900-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0601MB2151;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 471f225f-53e0-4585-e145-08d69259a7ba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:DB6PR0601MB2151;
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2151:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2151;20:8la5TDvmZUnMlXtuTyTiknI/4DV/cFZf50xzw3psJY+BI3Py85uoxbaqKiLql/HvCzPVNdRrEovKcIWcQSfFq46e93hnlCx/QaRQh9BE+9McKpbJzRwU568Oof+72o+Q8+3QLSxqVMPeXDY/9TfLM38ma9JOanZTczhCv7VUSnmyliVfBWTPTkSAvpWVPr5r8TLaLiBKhWBkiOs3iOrPrBingA0PASGH9gxnJI3Huo+3NYyuq4LIXxJ4ogx9IUoxP2N6sSRMNsHkVUWh3zzGYo9EZvJVoChFlaP8WPxa8iVsxHvURtE/qrNEzZm67JP1+Z3x2IhEEswTYJ5BopgipK8U56qP8VPVInSunMKkVOes4IE3J1d03+O7dFNgnY2Ze97szZvhiPl5KV6fEKszDs+OCONBiNjxiaB8ySHenUIcUocO28EvpwDlGZXl9n0UlKJhX5VQD8dk7QVdWcwpxFinZwxTs5tWXzSdoA3wes2ZVom1yyPeuVx3lOL+Kgl1;23:SNrx+el8u9ibUDqcK/Li8ZDp1s9DCb8XOzSK9BhvH/q0WdAmGzLptEy78yL39TvnvGQpROZDygTrmPnQnBIyLO3knEGqBeLj4TtDRL4Sswb4lBoSmk1xhSNoBPfcYDcWH5cNxjmjhjEslLfRqH0og8P+vX9gLC9tI4Z19UfgyWh9cQ+Wgnkh24r1jvYWKpM7
X-Microsoft-Antispam-PRVS: <DB6PR0601MB215186F2E34361D47CAB7F3EEF670@DB6PR0601MB2151.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lmX/vvS14sK7DJ5wo6YEifO22/3zXP7+ZKb4/YrMJ9qs/vlAY8okn81YsWsFYod+LrdX0qT8EuwOwwyBVj4VaWnkiDCy4W7Ec0Rxby33dUtAEno64YeGCY7SP5nI9S+U1q9vPqFARebCZzm60SQ7WYFe3p0bFJAXY4ri7Ou95WfZKbO03o0jqVjhXWU1aLj12lJoch5NvB3NRco/kLPcJH1F8fq130FHdFxJdRHSShGDgGNO5VzoJdHEzCeJKphRF/W/rWLZ/z+Ew6UP8jxARHWxPFbzXE0QPTKAyQLZUC8QVZH3Zg7PzSjgRYP/fhBYPEdKNr+VPdPQynb++fyLbdXHmAqFsWo0dsFYuM+QMI2LtZDjcSIkDXiVzuUVyvzGS+5j9sW8L9NCzn7ogRKHi69cMuO1EI4FiPPv7XSAdTS21xcfYF4rB2nIw2Uqbu7H6Kmihz5MNhj2dPo1HbK7rjhfBOuP2WfkJrEvO6EQC/wiR9vPvU4FumNUOa9QD2mKz83gGcVtfGoTGJDvH5ufNAwvKKU/9s2L+9kJqpx03nk=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 08:51:48.0869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471f225f-53e0-4585-e145-08d69259a7ba
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds the SPDX tag and it removes the old text about the GPLv2.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/i2c/busses/i2c-ocores.c          | 5 +----
 include/linux/platform_data/i2c-ocores.h | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 5dea7b9..78085a8 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
  * (https://opencores.org/project/i2c/overview)
@@ -6,10 +7,6 @@
  *
  * Support for the GRLIB port of the controller by
  * Andreas Larsson <andreas@gaisler.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/clk.h>
diff --git a/include/linux/platform_data/i2c-ocores.h b/include/linux/platform_data/i2c-ocores.h
index 113d6b1..8c416ff 100644
--- a/include/linux/platform_data/i2c-ocores.h
+++ b/include/linux/platform_data/i2c-ocores.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * i2c-ocores.h - definitions for the i2c-ocores interface
  *
  * Peter Korsgaard <peter@korsgaard.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef _LINUX_I2C_OCORES_H
-- 
2.15.0

