Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6910C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566772084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="EM34t2P1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566772084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJ2Xk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:40:28 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:32791
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbeJ2Xk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2PcTbO8NqrrGatquEcErGvTqYkAPzt88zw0TAcD7Bo=;
 b=EM34t2P1CZJjELT5AmNna7KBTMTBwe/mODeb+kuAwJl4/didlpuooZf8km6X8BLzwRxgklcyYwtTcLDCnp0X6YYfiQ8fKKduUdcTqRTYky59nk3QaAt2V4h+2xOIWIXdS8lY1YqNeFJwJ3n//aairLCqX6XlI4gPCKVoNtFAgP4=
Received: from VI1PR06CA0101.eurprd06.prod.outlook.com (2603:10a6:803:8c::30)
 by VI1PR06MB1630.eurprd06.prod.outlook.com (2a01:111:e400:5970::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.21; Mon, 29 Oct
 2018 14:51:25 +0000
Received: from HE1EUR02FT027.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::203) by VI1PR06CA0101.outlook.office365.com
 (2603:10a6:803:8c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.19 via Frontend
 Transport; Mon, 29 Oct 2018 14:51:25 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT027.mail.protection.outlook.com (10.152.10.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 14:51:25 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:18 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:18 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, <linux-i2c@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <federico.vaga@cern.ch>
Subject: [PATCH V2 4/5] i2c:ocores: add SPDX tag
Date:   Mon, 29 Oct 2018 15:50:50 +0100
Message-ID: <20181029145051.31984-5-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181029145051.31984-1-federico.vaga@cern.ch>
References: <20181029145051.31984-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(438002)(189003)(199004)(86362001)(106002)(110136005)(74482002)(336012)(26005)(16586007)(36756003)(107886003)(6116002)(47776003)(54906003)(50226002)(786003)(106466001)(8936002)(7636002)(16526019)(7736002)(316002)(186003)(53416004)(305945005)(486006)(51416003)(8676002)(476003)(426003)(4326008)(76176011)(44832011)(66066001)(6306002)(11346002)(48376002)(7696005)(446003)(3846002)(2616005)(956004)(1076002)(50466002)(126002)(6666004)(478600001)(2906002)(356004)(5660300001)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR06MB1630;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13dc3fdb-0d90-4b11-bcc0-08d63dae000f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR06MB1630;
X-MS-TrafficTypeDiagnostic: VI1PR06MB1630:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB1630;20:xOtCt++odRM/aowWkk+2lyI7IzVSZV8aTE5xQ7kApNBOpSHCfzlHiS1D4f2CGlCcDKaRjsUXEwuO80J4bcywABLJ1aGZX2o9NKSl4kX4Pw6R4kEvfzn77MZCQVsfdZolCznNjP8bsq4ilw+LY5IWExV5oGXyHPq2KIdumItumpVY+xx9f4YWUYjGBHB6GzKjrwL2SOUqdmbRtMO4jHqT99IZUtTcBpHiyhRwFjfa13/mWUBqoUssYhwu4aohkQmuiUM1fGfIXMqddTqUI14iV2fsO8qboIx8d5z7ZuTXqokpMVQmptyqBWjKPYiuxp5pJ6O4el1+xNQeRbYbHd7XQF6AsNFgHaZgOtdKWpQDPH+pOSHrnGhJ/yVACKC5MW8mEcnog89MTKwWm6RQ9FCLHET6cDoaqUhKp2GZaKv8ZBF2N5RgmbPBHKrFgHy2XVDmyw1Ps8Pd9PLJywcGkhVgvuRzXW6oJZ8Mlz8d7nuRtJFr8GnIxEFRH9eny3qTV0uw;4:26OHC/Qdec6YV90zXHu2D/CdHUYKG9FlbCOa7BdWe8MRVYg9ERQLMBJ9KhAnJknZOPOBfrpOC+fgckOyI7WZ3AOTYQG634adjzRJXILGvqAJUQswK/y3++usxC0llkHJ7uHaol7rb0m3MDHyM7olkRd9iL8k5vv8FKV6bUho9c6chDXUARuUa2jyHA2mOREQwcPgHYBArcNu0aGGzSqZHr8PswQEFMNf+V2wBycZyKD6NrlRg1VbJuDGAmTjHxYgebPgyG+XdvgPoZvcf8A46w==
X-Microsoft-Antispam-PRVS: <VI1PR06MB1630CA7C52C567EA431A6EDCEFF30@VI1PR06MB1630.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR06MB1630;BCL:0;PCL:0;RULEID:;SRVR:VI1PR06MB1630;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR06MB1630;23:1ClIWU1+tUTx6M6hD6bs3xPJMupTh5zGDGt6IwZVj?=
 =?us-ascii?Q?UwKZkPzHWbqunEH3WMpPSxmBH3efM9LaUQ8a+LtKgzMF8ehDvNcf/thcjgzs?=
 =?us-ascii?Q?/IfE4LMb/sxAjHnjTDBEUHM1VwzI/dEA3KBoF0IWnmHcSXno+egSDAzZQxI8?=
 =?us-ascii?Q?fD4SaYTNfV0C1cf+4t7TVEWcNcq/7JUnUenKqQ4ZLr/6JUGO2UYREOTJymZ5?=
 =?us-ascii?Q?zhRhR7MWegXFp4mdCWiq/zQjzx5by9g+fqGIPXeG4dECjzzEmpv65Aae81uN?=
 =?us-ascii?Q?5mGE5CwTAwRCGsseBxqeEOf3tVaPA3PN8uZ1fZyKfwIve5/Dqc+gbj4SbBaG?=
 =?us-ascii?Q?nf4/q9bvPZEYdDc+uGa3V6HCKhH2bKJZUhIn+oQiJ+GyEZPbivwgRK8OspzP?=
 =?us-ascii?Q?6qsofL3dpYvH9IxF/ojOqOKitWHHp20RnfcS4UnhqpZ83qkPRoMkTTfzPAMA?=
 =?us-ascii?Q?3ECg1VcxQ1MdIco3uAs5AiMz5BmadqC179x36aEdz8R7jT2YCKFpX6NePl2y?=
 =?us-ascii?Q?LObJF4JXiXmJarBXcVW6aH2hGelvbs2DVs/SRfPKixulxJn96r3kag/ZHVJM?=
 =?us-ascii?Q?kuWx4fP03sFGK4pDGTvmPFKbmx+JxJqhi0YX8TIhOInEtTOC5I12c4Ivdbpt?=
 =?us-ascii?Q?N6NK+2cus6rulY+nijXcbcIXqvRFEjNrgqipZB/Vb0NUjIvD1/NHztFqSJXc?=
 =?us-ascii?Q?wDci7gzN3YQFG4KQesNLm3oneGNf9TP9asxhOfGkIfjHCb22qlZQjmQorLN2?=
 =?us-ascii?Q?V/rmiPUK6Jr8FoGsvpMTOwWhUtZpM+/rsVb6m7BSXhoKxzmnKOaSkK+1x/Iy?=
 =?us-ascii?Q?o5n1+YZnBkbHmfF1CCMrKcMhX9PMmb2qVBCHtErs/IbooiDUyVp5D7emDZdq?=
 =?us-ascii?Q?P+BCjSEsczyyfaucCsaUkniQLSsuQWqj4dmlLVMwmqF93JAFxQNjPlzbcKnF?=
 =?us-ascii?Q?aQzak5BxBRn0ou1/FgVuR1bGcUxmAbVyTWO33oWzh6m7ue9NWvcsnShLfce5?=
 =?us-ascii?Q?yMq+262V7RcI8uDj0uHZgujE6qFLOCTSUVbZTf8Vb8XAM2ydWxCCkqWkUSHA?=
 =?us-ascii?Q?XfeuMUHvy5T7GSZuF1AzOkjz+OWbv1tz8v7iy+a4JGKucl4yqy6OIKjhcswr?=
 =?us-ascii?Q?xdmLFxmWpDYhFFkXjfbnQplKd+8A3BHVlAMDrUmU7WZO0a0cXnlWAbzrYuRD?=
 =?us-ascii?Q?792OlH+72t/bcE/gchzokovtod7DZHQkljtpTC6Nyu8asx93HslrAkyR2vJj?=
 =?us-ascii?Q?nxnBNjcdUrrBiBHlB0=3D?=
X-Microsoft-Antispam-Message-Info: yj6crkLi54VKBJHWGFmVFA5nAaM2EEBcmas1zEvvUDyZI7dVk6kY3LB3ATX87trLJSFPHSPI8/wbteKZzIcY607imaf5sK9Wwyskmnqy374vIrvmfq2PHQcXel4e7V/OyHLQfst/aet6lUxwCobqOyPY/yWBmpZqGUol3kMTladijSbvSbV4lcrasiE9ytXa/AT0MG6Qfdsa5xV5kLEEsUVRwpTFMAPlxKkEMz++0SL1C73Q4KiB9ZwDk6/KCpgHokeeTBRfE2c3FWU7RJcXtaTYADc0F4WvSGHdLYULhnvWvEeQrlhRRKnPzsu7SUZQAkxMO5MlicshKDd6ya3bXvXFTHneq0+KcLcspfMCfcM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB1630;6:Jfns3fCml2+zizijy2Pl6TcGN0HtEaogTeRwJadF2VxaaVdociRp7BjazF4TDZjI0Q1gPt4s+8hA0EHDlMogkoDMNUtfP4JX7BBK12bITiBmjKNjsrphE6omXS4ZeqiSWj6Wo9WXclHAa31VmaZwMs+8M9gFMNczqwDrOG+mNU7wplnPLut7nroisepFCzuCpaqE4wXoIvI6lfToZSGU1uKt6zsgc6CF3G5OfGXlzCJ+xxdEOAwad5VnK2ck/c+xFv5jzGv9k+mdHNkjBlYZJl5Sn2zfcfvv9stKCy3rAG0GqlesWAuNEcnGMxveIAsnresP8VzgC66OpL2P0aKw+lieLo68MDSR9gzgX4Abb1/YFgCbwxhBvS5IUM/Gl1Xxd+yynTOCZCMnVi79LpED/qEED+DEAuVSrICJpksL2vZxJ8W6jJ2A+hNZvoYjbfViq2E4VwaPTB+5w+rhH4K6OA==;5:juf1SLALc6zPKaD6SROts2SKOx3mkJDKwROIUjxGpN0JuU/BC58rUybPO0vvuXHCJqvCBpTTHuWuPcqsQv2zhgkIpvsMSvfStthLWHtZH5lEcHIqbTiYfBqd6J0shYqQoqB/6fdlUlAW7NutWSWo4ol+Sv3ApCYPJPG4ExUGKQ0=;7:bvDFNScWH/sex1WjgvbHh0TZUxb3ws3TbAJXlfuCvvMxZOfWy1h/iNKFumcBky4ikEnu7aNaU8rGp1QbZNWa8OpudyekfpZHgG9p/P15TvHUyfx8VPDhWoCi0MyUZM6MqRQfYzYvP14LqR52bGpyHg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 14:51:25.1170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dc3fdb-0d90-4b11-bcc0-08d63dae000f
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB1630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds the SPDX tag and it removes the old text about the GPLv2.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 2d71f11..e48173b 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
  * (https://opencores.org/project/i2c/overview)
@@ -7,9 +8,8 @@
  * Support for the GRLIB port of the controller by
  * Andreas Larsson <andreas@gaisler.com>
  *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
+ * This program is licensed "as is" without any warranty of any kind,
+ * whether express or implied.
  */
 
 #include <linux/clk.h>
-- 
2.15.0

