Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73654C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382F8222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="DDSqF07h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437753AbfBNIwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:52:31 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:52090
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728428AbfBNIwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8g4K+caOZ1VUPuz6/1LdHSnHzEGjtNXP6lJ/V32ezI=;
 b=DDSqF07hsoMurjr3UGBznsJcSasr6V/aO9EGqajzcOpJbwZPyoyWytSOjukffCbWWYjZFudJoJrh9WY7UbrROYMwCOvwxbQqzCfMzt23aP+vdSI5awOEjujkCWV+/hYrYiKGrtpAS4Uk8HVQG0mz76sKTQYbmp8/OpmwgJy2aiA=
Received: from DB6PR0601CA0046.eurprd06.prod.outlook.com (2603:10a6:4:17::32)
 by DB6PR0601MB2150.eurprd06.prod.outlook.com (2603:10a6:4:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Thu, 14 Feb
 2019 08:51:47 +0000
Received: from VE1EUR02FT020.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::208) by DB6PR0601CA0046.outlook.office365.com
 (2603:10a6:4:17::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 08:51:47 +0000
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
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 08:51:46 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:43 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:41 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/5] i2c: ocores: improvements
Date:   Thu, 14 Feb 2019 09:51:29 +0100
Message-ID: <20190214085134.12900-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(189003)(54534003)(199004)(336012)(44832011)(6306002)(956004)(186003)(4326008)(2616005)(47776003)(66066001)(26005)(14444005)(16526019)(126002)(2906002)(51416003)(7696005)(426003)(36756003)(476003)(486006)(966005)(246002)(6666004)(1076003)(8676002)(8936002)(50226002)(356004)(478600001)(4744005)(74482002)(86362001)(53416004)(7736002)(54906003)(106002)(305945005)(7636002)(316002)(16586007)(106466001)(6116002)(48376002)(50466002)(786003)(3846002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0601MB2150;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b31f16d5-60bc-4845-8b61-08d69259a71a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB6PR0601MB2150;
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2150:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2150;20:aobVDvyN9/gpXq/HAd7ioSgnl3n6BvafkzwNGn6Qa24/YwhpPp2ppHGFet3L8nhNRiAhU5gnP9tAlycMG1br7N/rgCEZjRRKpEWgP5Ch2I31oIRKS0L4dGVnPgaJ6IvBzs+4K/ikysch2nVvW4OrsMIHno+nP4nZGeuV5dRBI14yzIvtm8Llw3LaG3/Os9Lk1Fce7eFnswuAkyD9dl4O4emuX1VqTFLq5u9zfcb32lbP/f/1Lm8pHmquPpQ66/tNNyW3kP1uXFzDa5aHDm+kCrNR1yUBkSq9GjvtWP5Qd6b496S7/EPIkUUAeACSCMx+efCV6UvS3bfCX1vROgQ1dkSkY3zCoWT+U8CghKYqZ9vxo0zFhvODjndn+rTksesLKbAtOQ1P8xx+YO8IkU/tZMQ9nFyQDRk5KmGAEdywoY1Remci5BmiAgVZfefMKY2q45gBEnF9AWa8jUql/4EZBE7JQEyz9OOKWu+bDv6pM9dxe8Gf8qdDqsY+PkZaPN8J
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2150FBFDA61BFDBFB6FA777CEF670@DB6PR0601MB2150.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0601MB2150;23:xOfMXVaTlv36rQVqJGUT5ZhyeMLp2h1KfEAgIfA?=
 =?us-ascii?Q?vcX8v6u0eYmzbQirsatpaPpw+8l1ljXOur2Dl5HkEDf9SxMHmvxWfsZkU9wB?=
 =?us-ascii?Q?Ao4dprimoIFkEo+rIVgAuQHUkNVZ8kIvmm/wIdpde5uxHF9ICPRocuX6v5d+?=
 =?us-ascii?Q?fyabJUlvzZMefJaLaWltQE90JqNiOorkiykW6AmEKfkeEDW7+gDMcsKtxrn4?=
 =?us-ascii?Q?SZLdjFu/oesbrdOCfjeYUsLJ4Us3zsaqiU1t0z1K4C6iDa59BvUz9PVGIvlw?=
 =?us-ascii?Q?cFx6YTFomkhzt/j70iZgBBFC4vnV/V01b3JxQRcuvDZTQj/9WoVFwEG1xEv9?=
 =?us-ascii?Q?jIPYNZJwBMH9RitgfEhZvUP9Cnju5Nm7s5kkJSMjIDM82NdevbBGvd5tH4OO?=
 =?us-ascii?Q?/O3WL71d3c18xYMiu1HtCrDTciBFV5Fd96GEwDHDeDJPNcAF8NJ1LsOjM50P?=
 =?us-ascii?Q?tbFtcU0RwBmw8ogjlk9p5NstDgnA6ydV7Ru+zveqMczOd0bH1x0Ko9qQljkK?=
 =?us-ascii?Q?PO+TwCwoaTdstba0xKcY1MPD2B6MszI+qo8MIl4KsTI/XShE1uXngMdKYpE/?=
 =?us-ascii?Q?am1QtQexsYhu0EeFzLr6vWbe4adR8X/Ybq1piwZL248OddU0+EnvAXQUHOfD?=
 =?us-ascii?Q?Bj9OR/GhKHZ6pshdqiAlR7apfT731HOefLwtIeYSeZsKQPMeQY4yFzuqrpFC?=
 =?us-ascii?Q?ajSXLCjJiREYfUH/Z5fsJ76fRDineeL2n228m2ca6xDmy22r5DyvOgz9r7NF?=
 =?us-ascii?Q?uwOVrkP67LDaSVjCLMI9a2blUY1yCxpRVhyp+lYercKiE0ZYOw9pNuEJ/9+X?=
 =?us-ascii?Q?U3k3Ypsr/mhsMiRqQ6bGZ9wSWtJ0xrOKQwqpiUAAO+fgfffOQT0kK4/5DkgP?=
 =?us-ascii?Q?OrzZit8WJAxikGH//ldNUipGM/mPQxhnzYNor3/hhdn+Gj42fCYO4GEcSM5h?=
 =?us-ascii?Q?SbcA5bQgEKBTNjupJb6i0Yt5mkkrZNVT6QIg4h5Ih/pmZkJn9mfUZzAlF/Yq?=
 =?us-ascii?Q?FVJJJEZkBs5IhBTLS8F+sbp9xy5I/KHYAf6CUXTPdH8dxwSvWYvMDffR3LQE?=
 =?us-ascii?Q?f2rsFTqjpqYtszsF1AkiueOeg5FRyrrPA6NV5MVZsBvjEi4znq5d4KWyqk0q?=
 =?us-ascii?Q?2lNCxkG+JAXMB1p3et8Hinl7Y6PPLFH4VJdvpJIBjXytBNCF1ZvTFRSldGlu?=
 =?us-ascii?Q?KUCdzveIwSWLGBmLiAsobMOhoe/+acGDyGLQk?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fkqYNMnwCeukEv0in3+gm3RsZLEnTie7wnpbTxVQ950CXT3V3hlT8DndUPtMzM7rjMtjalmd/sxL2MrXW69v6QteipTeoA4FYfX1VPG54usDwO7jGZUDttH1ukEIUifSV4xlak1E9rtKmwq8QG6N3E5cFHTCjMvsdJPfrkUlhn/Y/LamTxK9a6vYdTr3pGNzkZjCX8/Bg6m47vNMMcotcpESzTtsPrQ1fRGF5IeUMWn1vs3BY+AuqqRMV9i6K69tYNcn5o9aBCVEvgSjq/N521ZH+oXT6KoBBFr90u7MdYFZD9XybYDoOyWere0CaYid/XXhTSDwolF9g2U1BeZEwD9DLw3e47uOI5jcMRaTt1ND9okhJ+xMRBV4k2WWuD7R/Ep+Rw7F6BDfXe1aN8j81iAQmt2N04/3KwyVk1FQR44=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 08:51:46.7872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31f16d5-60bc-4845-8b61-08d69259a71a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch set provides improvements to the i2c-ocore driver.

[V6 -> V7]
- restore accidentally removed 'reviewed-by' tags in changelog

[V5 -> V6]
- remove redundant code introduced in V5 (double read control register)

[V4 -> V5]
- deterministic status of IEN bit in register "CONTROL" at the end of
  ocores_init()
- more style fixes

[V3 -> V4]
- add reviews-by/tested-by
- add comment to justify the formula in
    udelay((8 * 1000) / i2c->bus_clock_khz);

[V2 -> V3]
- fix particular error condition on platform_get_irq(). Copied from
  https://patchwork.ozlabs.org/patch/1038409/

[V1 -> V2]
- replaced usleep_range() with udelay() so that the polling version can be
  used in atomic context.
- added dedicated patch for minor style issues
- fixed delay computation
- use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is always
  necessary and a trylock would generate an extra interrupt for nothing
- make the driver ready for an eventual master_xfer_irqless()

