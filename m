Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB06C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACD521A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="teSTd7St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfBKQGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:06:05 -0500
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:61248
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732479AbfBKQGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBVm7vn2whs9bYtdJvLQZRIQ/YXQCA5/XUjonZ4b62E=;
 b=teSTd7StAHzqCTL4HFHh2NTk45yMEfrgauPQBrx3AgE3Rv12z18bMNKcIe2PSM7xaOh9C7tODvY+CUPDze6nlhvApovNfVjl0HAdzlR3P0ZSA4SmJfkNYxR3g93SoJTm6CO3B/7jmAcwomFdGqXtllaWGKiNxqkOrJK/oaYP7+k=
Received: from VI1PR0602CA0015.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::25) by DB7PR06MB4728.eurprd06.prod.outlook.com
 (2603:10a6:10:56::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 16:05:58 +0000
Received: from VE1EUR02FT009.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::203) by VI1PR0602CA0015.outlook.office365.com
 (2603:10a6:800:bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.24 via Frontend
 Transport; Mon, 11 Feb 2019 16:05:58 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT009.mail.protection.outlook.com (10.152.12.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:05:58 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:41 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:41 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v5 4/5] i2c:ocores: add SPDX tag
Date:   Mon, 11 Feb 2019 17:05:28 +0100
Message-ID: <20190211160529.23858-5-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211160529.23858-1-federico.vaga@cern.ch>
References: <20190211160529.23858-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(106002)(478600001)(7696005)(51416003)(54906003)(8676002)(76176011)(7636002)(110136005)(16586007)(107886003)(186003)(16526019)(26005)(7736002)(305945005)(106466001)(50226002)(246002)(6116002)(3846002)(74482002)(36756003)(48376002)(8936002)(316002)(786003)(486006)(11346002)(356004)(53416004)(44832011)(6306002)(4744005)(66066001)(336012)(4326008)(956004)(1076003)(2906002)(86362001)(2616005)(426003)(446003)(126002)(476003)(47776003)(50466002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4728;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e694ac43-a4ef-49a8-c4c4-08d6903acf8e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB7PR06MB4728;
X-MS-TrafficTypeDiagnostic: DB7PR06MB4728:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;DB7PR06MB4728;20:YC/eXcblXAr6qY2tu4YMLtcCr+kl/Zn0OV8/m4/4YLWr58No+4BXrPZRbIBrgdseqOVCrXJZHVzyQdPmw8kZjqAgXTeTBQtPJISo5Nu+Wszirkt9qu1Vx1juLsZmmTFtKlpZexVhyvz1mVnlVZzF9GzvJhLlP4pQuJ7ntqMcZtclTZhLAYQ/SrFqIxAPswfgj7kqw2C88Vh51fBEJQ4gC+JNUn3t5oWchrKML9DdT0LB5OiJ8h4OJSRNd8x+H8oaGo6E9FSa+t5mMRLYhou8sC6lRLP7Q8JKl3XUtM+1uT+4wc7mtZAzLxLGj/gY7ImjOlLv+Chl6hQQ4VWizT1FZYUy/FK0llRZOULe7k2fpI/2FkTOo58ldPwnQOQArk71P+9ManThdGZhhNYp41hKhFZhioa85lvjQtQaxYwaHfOtFCGd58/2pCMOhW6NeMaUm7lnpXrmC4mrfVx5AwYmmZq1ys1sRKxiNG4r+9KoxPaIxI3gWZgKsspaAMJl1s5J;4:LABmwde0BmtQnpXEGe8O/uJE3rcbYNNn+OCOvugdH5j1Y1q3rdagZbdLLKv+FSmD4H8n1RsRqAr4Fv08td9Mawv3G1ncqWoN6lHttT4BF3PRq88EChXc/d7C8HurzOXVGU5YQsfhDcg7s3ubpZtJgRjkc7ZvWP08ErU/NtiOgAwCEwfEsJ54bLjCWonz+CS/UYX4iU/OZjZ0MrUm8lo0J+UFfk10IU1n2S9OFg+i0WU/tjvHiogVk2YuIiQvfzVERXBl0wNtPIB20OzHn8JXX3PatpdFynZ9GMG/291fihTuBKXSD8EPbqiQ6FntY0Hj
X-Microsoft-Antispam-PRVS: <DB7PR06MB472876256B5D2C1E4B937E08EF640@DB7PR06MB4728.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR06MB4728;23:H6VYt083vIPrXtyLSSNjCWdhVTF1zED2aTdmFwCmC?=
 =?us-ascii?Q?mEzjqdd3JnxL0RHx+EtYHvk2Ub4DXp/E01YN3Anjs6sMMJemtHv3enqUkiki?=
 =?us-ascii?Q?ia6qT5TmBkUR5L69gGUc468HoNdzI8H65+lwf/JZpcyC7fx7v/2mQMbfxlBX?=
 =?us-ascii?Q?AGUIyFbz/ozZwoJuh57GUqGgBDluDi1IEwezNa3H938QLM7uTRnkxq9IYcSa?=
 =?us-ascii?Q?AQDIW8aW/dQ3uMkPA0rTK8Kf5kfg/sTEzQd2AlScVg/86ONG/u0dFG3aMb1h?=
 =?us-ascii?Q?J85UwayDGb25BpiUZ/d4v9AKxWKVOwp4PfgEZZiDcRfKPEysXxp4m6hMhLvK?=
 =?us-ascii?Q?OwYZHPo5jWPPhhZasy7GpbP/HZZ6gsZUbgLV4Su9bP3pJvYxozXOtd66KumR?=
 =?us-ascii?Q?fumSRGPL5uh9iq48d5nxVeqrS0f+vhiGupm/MN4M+eqh9h5vgzKUpuEAs1Gh?=
 =?us-ascii?Q?FyuLY7nvx8gmNxe2meZUQHBYgBwQinFQ5Cjvz315bSpnoDN9tYvkLZMNcbjZ?=
 =?us-ascii?Q?1EY8aQ5dHJMoOtQ6utYe9gYx8MOkfi26mbgoVkCRU0SsVXqOjcg78JyjVz3v?=
 =?us-ascii?Q?ObD6QrEIbXSOH0nevDvrvYRfOt+Y9NiGKqUqR8xgo5+9wTKRKRajvQCxZRVi?=
 =?us-ascii?Q?kacG+O8vCqLTRZITbgKHR/NMdYgzf83qXISnVrTCe0nCkg+fkq5uyaa1HBpB?=
 =?us-ascii?Q?JWvf8UUHMDUJ6dU8aMPRUr0UvcMh6aGo4Tk0UYJaInZQv1p4RVmi5xidhALH?=
 =?us-ascii?Q?RnMAq5D6mUhKj9+DKQsD/48Vts9TAnAnB0D/hbhgq7t4kNBvE79++pkuNJTi?=
 =?us-ascii?Q?jX89KgoLCO1Ob3SZnyU4qgC5E3PG7sO7TXbH0+JkrDtJ+5pR6ZjgwxScVbyq?=
 =?us-ascii?Q?gH11EhLJwTJ5kcP4wbiCjtyjH+ueb2yp/oxvCnuuNqxrLstlmKjxoxLHhiQS?=
 =?us-ascii?Q?PufD8m6AGka73++7dQNtuPvAqyCQPD2/9vu+sAvplmdqn3mwfOpLoTHs56CT?=
 =?us-ascii?Q?jKWZ3O+wZ+HWn5HkyB2e1bfvkRcDTgfWspf321MQclhpy8NsfogtzGWOAg15?=
 =?us-ascii?Q?Th5A6Ct8Od6rHdjuqIvLJx7/CsrPblatHJftFnPmOmV6R/3ARxR8cQihpHIg?=
 =?us-ascii?Q?gMuJH/drahbTQJjalOhdvGG2wPahZEsot+HRsrtG+21ufOQcVh+QsBfrdZys?=
 =?us-ascii?Q?ExVORxMAqXFZN+f8C65dNTTdectutjiufPTWZQyr8Xw9lKate+bgs0bZw=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: CBlqgN2RiMu2bXFCeTs23s3tfHo7BoDvXR+RIY+U3aEULUG69o7YhxMNOMkVqwIYMUK0cNDjZtQXgpPtXykhsYDX/d9qyqfNUZeTuUCvc04P2T9dVSg6YR+0wKou1Nc+0xHEgD0kwiwpDBecT9yl1oMCDSBq3RckjsewxNw/YtHwISvILFlnHdGcTi0savR7wWfgFdxerKsDfaxyrxzFFdK0qJNzz+Xfrhq4ye6g0++vJ0+ZrnDQzPm0deT4XGE9uVXUeqkft95uEo1SQuS4aWtsJh2N9z7iwuriaPeVoRiF7YrpQHD9mR1wLHcZenD0Z9GxM3V3EiuwOMNxz5wPAUtT6HDhac+k7LIepoI8SllVlFo5ZOyNktfbrkdLsseHjq42ITONvkK1d+GVK7bK38HRqOFfwwUYM+orF3iYK7w=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR06MB4728;6:HvMPEPAelNbXeulZwNAY6xYRFWrm3BWlDplhDjj1shZIC8XdJ5YYkMT31n96XrqTtOVOM2qljiqqE+aBkaw8tCbb0RlG9+lWnVshnQHVx2v9VpruRAholP/vN2uQTC7XhMonbFjHg5ZGf0worj4WREfeyMVeHbHAAaZ/XIwJYtTYrIp+XB7g8AG4ePVjYqYhqAKxPsbIWhgJmSOPsPCoxiAKPwcU3qYy3rJmUPmkRjUhkgBmQxb3XfMA7mjMPV2YLti18/KhGYTER0z418PNstarOuLwDbirqiNqEV2hBiPpxbBjNCMyKofmsyrgE1ijFhk84BPDSxHKPCMYU2Mi7Qq9Rwj6sN7eE/ATC5VrLHfJfkpmSuI5ulsjXPur5zsVFeeV2/Wmc+4+1eUBCUaIQzFWTG3eW4DL8mB+qnmFHa//mBXsC1s00rv35hoFWaDpafSH2WNHqHDqw58bXzlQEg==;5:O5jQGzrILomkt8YV1Eg8SCP+dkARDdriD/hB6FHIUYZzOnfIFmlpJYf+xJrvUdCCBXimFyrM3ZP8YrfY4PcJbfBNnOnVgEpPffVBt8jAIEYLyyg3EZojFocS1PVbsdjH8CZVCbQA8h+aEdrInPPYXA7DugjxZ77DLGiagGhbGRtjJ+hphtqNXesPuj2aADKNjNa/NsuUA98faDSW0TRhJA==;7:/SIBZK9hgx2xwtcXgWc+WQFdL8xV+ulDXkIX/pOze2yhMcQRlE16gh/+jTC/tf3mH0sH7aHim8mWjYVQ/YLshVC3RZqSOyAQ/LzPY3mPGANc0wLJXZc7I44zKn1lSI+/iJN2o3ml4IouPB42Zrx42w==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:05:58.1564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e694ac43-a4ef-49a8-c4c4-08d6903acf8e
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds the SPDX tag and it removes the old text about the GPLv2.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

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
-- 
2.15.0

