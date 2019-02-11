Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFBCC282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6463A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="ZmJPocJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBKIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:31:52 -0500
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:13409
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbfBKIbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqaXARPqjHc+a9b58MZjY/C4KY+GEQgRLw9wZXMWjAI=;
 b=ZmJPocJrVMZYDerdjw+/1oSnDetcu6gKRDCwkx1yPsdDgtatYdGi/FfNCP+GakIZ2pdmxvlM+qRNw9N1eMdQHLtzMtFiqTCmoTLbdp33al1VBcR3oldjTGybGbl6U+j4SyLUzpqW/9/oOMa7AqDz1iaPgKdvCUWiUpYD4iwAPD4=
Received: from VI1PR06CA0087.eurprd06.prod.outlook.com (2603:10a6:803:8c::16)
 by HE1PR0602MB3532.eurprd06.prod.outlook.com (2603:10a6:7:8a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 08:31:47 +0000
Received: from HE1EUR02FT011.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::202) by VI1PR06CA0087.outlook.office365.com
 (2603:10a6:803:8c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 08:31:47 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT011.mail.protection.outlook.com (10.152.10.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 08:31:46 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:39 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:37 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v4 4/5] i2c:ocores: add SPDX tag
Date:   Mon, 11 Feb 2019 09:31:21 +0100
Message-ID: <20190211083122.32485-5-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211083122.32485-1-federico.vaga@cern.ch>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0602MB3532;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 291b1205-00cc-4e7d-891e-08d68ffb5c69
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:HE1PR0602MB3532;
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3532:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3532;20:nj06eUC0ib3fIhrYsXGADbLD7WORX/jh8RRitRx9PI1lm/KnqZ1g2bydNw7wK59tYpesJFZiF/uUI+4E5iwtCmSfoIlMjcNS8QJe5PYMsSPwmT69vT+Jo2H8X2z6mUXJlOsjFouB6T8YERQrmuN2/gchC73cU4V5PchBEMiJAbnZOUyaNSBwc1d6n1vdTO1gMb5A72ZDlnNItEr2JV/ub45hpMgUnBAaqU1UXEabIQZlTWRkc/gncc9T2XpKTMyBq/9xHSum9VEOrI+ANj+aNxNvdxMDZMMhcJc848gwsXlPdlQzkZ8AyYBhqwRBpLSXao+CvR1TQb5y/8idvv31qdrOKaK699Vi0AD2Bx7jMda6Sn51mdWIDFQy/g0+JvXxfYN1xIfaHAnNQoqO+Jpyc0NUu/715g+3IxpdKy3mJ2yALBOGKMD0dX+hVwvAEs8owMggWaV6G62ECC3AF0UtPgE6BOYzTTBgFUFcH5Fa/Y7y+81hfYvHGb904vXthIOr;4:dLmo46xdznp9gGzH5TKOi516HgVo2bVnbFw7zy/JMDLsMgORRNUtbRdmZqPR+YOWbLoOI5MY8EIqxRXHj+d2rPdyK/BI8yMEx+B3DzfyvZr1E8kjKlJ3V8SAgn2dEnngSSsX5v1/EhcdfAtEbONYEUNOpA/0m3E015RJun2q8Ir6TB9yWjXwIUFLoPyyFI2l9IPCmeUEtFBtwF1oxxvORghWy5uCHd+4C/q6G6GO4d0UQyGozZu44WT+elUqUvcnTBQ0hT8CmVDv+lqxPv5hSyOHUR9NvY9JcUo3KyBnQDygAevk8dvXN7MfK69MR9N5
X-Microsoft-Antispam-PRVS: <HE1PR0602MB35325CA5D7B36C11034DFA7EEF640@HE1PR0602MB3532.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3532;23:o6Wm7df5aE9gdWEeaDkUkTPtpge46NE0X2r3LB0KVLp4hsyxuc2WYwipZiKl7HeVElonTTiBdyJ+NzcAJrSqh1lAAimZY/2xp597G5tKXlKu3xs70Kaqs4TJMJAE3R3v2DB6C0HmWxSSxWU0OQoZJhPRmaMqPDOd9zE1xYRG+ueLjW/BwMogfBD8pBwHIjmt;6:AjEqKmr91xRmDI6VXRGfgKTy+fbngOfBPrYpku4S5ZTutJzo7lTunhLWjNvbR7S9jkXM4eycYMyAfHDIoLEiLJwpHMsznOKnMqk/e9kuxiG1gr/RbIRTv4fVisyxByYJXKILuuPItWjJ04L/DSm/pRHYdnTBRlmynRWKaRSU+ZrEjPgiOmv2Ux+plUR8ox0NuksL0iH+oRf5HLedU7DfhnhcY9yi9iWWrURf3So+KM2rJly5F60XE+LDxojiL8IHGYgzS8blpy38/5r6/dK+Ydzdj8crFA4rXDec7qGt1fsiAX/1yjTtHBHFFBu2QIvO9S7HwA2VnN6A8wXKH8/UNVKCv3gDcnPsUTjhqbqnpBR//GuPjD9YcspFX7LhpYB5KUiZh2dH6NhAqdLTXSoX+QfwBJQkOXSPl8Ajd9LFqgaRZH4LcDcBzi0rqxKKSewhie2C9qs3TCj8yrk12XP6IA==;5:PICU5R8f8MiTnt16WvNKy5Bfa/i762yo49ttajqOBqhd/klauPADyzCfKdxcf77sVBMTzM+MnQ9MBhcssL2LL5fmZXY/fSOUyDrs2s94laMKqXIo3/GpS/5RTXjYmZsHDxw25cCPA9lWNRRYBenc5+7GVb1drGRN3IlvGR0TjZjakhpfV4YYTJFRQYuXux78O4u1VV5wMNcTdcZ132E4ig==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: CC59yFVkQRI3Py0if352yN9Ddi0z8KSAgiHn7uWCtr1ArJx9/DZZppj9tNn4gJdOhXBc+txb8THNP1gmevivLFA+pjVKXVEJuuaNcjD0KGZgABFjh5IgTXYxApc4Fx19Z/6hH2jw09LPYf5WfwsTR8wGSTnyhdMqTJidTvb5en6AP5WZ5UrjD+7WGDeh/fOFTJ9HOhZg4oZCaePSe7ReCm1OK/6On8YTCvFzJ78Ydg0ZhjDGjyBAQUxjin1Rpy3WuCaWL3tGH33sq6Gk8vrz11645DrHOCq3Q8eYSpLwjbs4Ts5IbBjfLDV3syrfaEx71MwTyAd27La3VCOiUg5TDoX8Wnjkn2x4nd1Jd6siAWkJx24is8Nek2s8DdZgGxfF0psso9PYCtmJWSnGUaGsPhy0KQw3taYp6z5WWW2kMWoaidIVxKq+BAK+/cxUYcPcVSwR7bx/QdkEa1wbGVi9H/FbFQ+Pu2vDF3VTQn0VYaYopg3PomUUfg4ZfYJ1nSa4JRPBYxdcotCNSjKqXYCUrV8gq3CVEJOpLaaCRS+gu1E=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3532;7:v5Avee3KMaL8ZvYzO9pbR6m0TfCPlNt6NOr/9LKbrHubcCbYmChwKLPS2SgF/mxgAfVug2qhRjVhJfGFdKxWxFZXU6mPfp/2zFhRjR1XNG8ArJ5yPCQO4OkmoWvGxp2LjmY+lj1NUz8FmMUfCFOqcA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 08:31:46.6424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291b1205-00cc-4e7d-891e-08d68ffb5c69
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds the SPDX tag and it removes the old text about the GPLv2.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
 drivers/i2c/busses/i2c-ocores.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index bbe3e96..e87fce0 100644
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
-- 
2.15.0

