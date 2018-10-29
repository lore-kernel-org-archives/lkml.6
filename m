Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B6EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB252082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="EwBK7AOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB252082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeJ2XkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:40:11 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:28576
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbeJ2XkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cvbw9Mt6mUksJL8SaPsQFhX5NuUs0IZOrAoBKshVCQ=;
 b=EwBK7AOzvcSxBzHyfzKkMmUMtYiT9DSQrKiDKnBuFCvjGCCKn8fMoH2IeD4U7edQE8aQaLKbZkwU2na6jU6uDR2RVjGoQR7E2f60u9JXibeH36L42l7z6FoMBlbTWh7K7IRgRj3FdC/LGIlh2iD8o2bctxQHYm3dbFrr3KHdsNc=
Received: from AM6PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:20b:14::35)
 by AMSPR06MB519.eurprd06.prod.outlook.com (2a01:111:e400:8033::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.22; Mon, 29 Oct
 2018 14:51:09 +0000
Received: from AM5EUR02FT053.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::203) by AM6PR06CA0022.outlook.office365.com
 (2603:10a6:20b:14::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.21 via Frontend
 Transport; Mon, 29 Oct 2018 14:51:09 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT053.mail.protection.outlook.com (10.152.9.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 14:51:07 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:07 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:07 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, <linux-i2c@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <federico.vaga@cern.ch>
Subject: [PATCH V2 0/5] i2c:ocores: improvements
Date:   Mon, 29 Oct 2018 15:50:46 +0100
Message-ID: <20181029145051.31984-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(50466002)(14444005)(5660300001)(478600001)(53416004)(7736002)(51416003)(106466001)(106002)(74482002)(8936002)(305945005)(110136005)(7636002)(7696005)(6666004)(54906003)(356004)(86362001)(2616005)(336012)(786003)(44832011)(8676002)(66066001)(1076002)(4326008)(316002)(107886003)(48376002)(3846002)(2906002)(50226002)(186003)(36756003)(486006)(126002)(426003)(6116002)(16586007)(47776003)(26005)(16526019)(246002)(476003)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR06MB519;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf73d528-3c2a-422c-8fb2-08d63dadf583
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AMSPR06MB519;
X-MS-TrafficTypeDiagnostic: AMSPR06MB519:
X-Microsoft-Exchange-Diagnostics: 1;AMSPR06MB519;20:6MRVEB3lxW6tft2zkEu4VMUXAH1MQOEjHWURVb4aEhNHAh9BI4p7ve3s/Ar7GGR45AjQS6IgTpwqaj24kfl6eWeUnq4C2SpfKpBfAyz4Jnn1MZOWsHih+U4YZC6SvOhbQM67NEHMChKjN093wnUxT8wC1TQdKzrIUG2MGpR5UKkdPfqhY+195KH7+iPMUH99nbL585SvZ55EeSDbA/T/miFS5KsdzqH8CmFqrV9ufrUGkXbljD0RrjiF+YoJEBipWyM560+zMPDgj93ZkroFNq6z9v4vDSGTiX8IvBEd63pdVbFgt66uvMOgS902esX7cXUZuU9Hfk2bmjK9fZ+S5TVMWd4MfFFelzqr2NWcs2ne2e9clPThHkmaoiamrikAGdaCcxpIycnLciZ3xF8TWbbpHr0DXRtcOFUIP8UaIqG/UC1KmIUEWAJUc0M8ZeF11NllGoFPsDoGoWodaMq8O2sSsIOOLWqHvd0w/N+yRvz1eFD6N5uSbkxzVhlO+fy+;4:/m7iG70kMIUZKIk6bUdXJiVFG/Dj60Qeuyr4q2Eq+M2W3SpzyiPprpAle3K/YdCg9+e6WgdX6tx7/C/NG2zEhyVgIepN/vY0AoYPQlSSq8bIXtS1gq7TwqXnzPpKoPW1vZfxW0pCS9DnD63QxM7li7DmLbCbotSwR7TWaqH39bZBQAIpvERb81x3wHLk2Zkb3hIA/g1NWqB0NmSYWj8kVfJZdODgeDNZ+1mdIuFsiCuhYVcO7Mi4LnHQuyskO6Llgo8KKyUu5nRml0L5PmojIQ==
X-Microsoft-Antispam-PRVS: <AMSPR06MB519221E07D143288D0A695BEFF30@AMSPR06MB519.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AMSPR06MB519;BCL:0;PCL:0;RULEID:;SRVR:AMSPR06MB519;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AMSPR06MB519;23:NvWAeChOitMAkwG22lJndwjclUE/190k53KyhNAJQO?=
 =?us-ascii?Q?FNGxGKvEkJGry2n4zUyw9BdA74IvULVqx4ZypEsh8rIiOpJclAoj7q6TL2Cf?=
 =?us-ascii?Q?whMhs3HqRruGi2Jtd0BAXvCI+wVhCfCF84XjaWWHJSpMLz4Dlwq4Fqy4x74M?=
 =?us-ascii?Q?DIe5H0S9roQMciU0CVroT0OODcJwQsG+Ou7bjUkVkG7I60A2XxiT1UKUSfV1?=
 =?us-ascii?Q?wTwnqO0WoNoz1HDdswmb8XHVkClYSumslSjCUuA8HDRXGkWkpBI/qlVmvy1/?=
 =?us-ascii?Q?2XB9s9sUjIIBbQkBGM+BZffKatswoIGndUztlh9p1GwekpuDyAG5pksiRbd8?=
 =?us-ascii?Q?KXHPi8kw0LYM9CyyMIeN+OZyz4iWlEqdSjZunOV9vGntdN+Utx7qFKZExgCV?=
 =?us-ascii?Q?xnY1dbW3AeQ/K5pImChMrfKQi7+TE9DIFkwxoIb38ILOt2AnxtsYrfAaiPJb?=
 =?us-ascii?Q?GZ84o4vBiRaSj7UjORjL+kLpcU2YSuyEQeKpSp/pKNu82u3kvEojgqyUXLB6?=
 =?us-ascii?Q?MErQyvRXzms/e8v1e8TB8+sBKkvih1Bzgy51/oM2hDcC/4hsIZSlaNtfLGzt?=
 =?us-ascii?Q?YEupNG9XS3NYUxsjEOR0OjePbZZTvs3S36AEwDI3kPzvWV3xnHyaH+hdVEgR?=
 =?us-ascii?Q?PUc9CoahiN61zq2VhfnKx37Y9y6ZV8uAM+I1j4HvSrQIGiNM7VKzOlWihRv0?=
 =?us-ascii?Q?uxOOcPvAYClkovEwfT8BL+SvRKyYXN34BJo4MF0ddcbphkuhIgV9H+9bnAw/?=
 =?us-ascii?Q?znKUtdGoVtADZ5vBOi24QtYsKj1YE7fhOCgT+GpicQ2MT2nMjUdoRvY9ndNK?=
 =?us-ascii?Q?dXSX4dkvD0cp64boU88w4XA/cXRhhIJlHmVv6E37be/qFRcDdAEpG035+r6C?=
 =?us-ascii?Q?uGlYUvBsa0uoN9LlKoUTE5WvURqi3EaNyXjVAErzHBKcK5ln9jYl4DN+Nspt?=
 =?us-ascii?Q?BSEdKPViOuK1bunZXHNQLB+rnbSCAtAui2O5wBjO+vJqsyX0lGUfUREJtj+h?=
 =?us-ascii?Q?E2cc9MGqg0zO8SXq/7CnWVIEIMWkb0v+Y9XQgkzXYzr4YGKhO4BVKnD1SgRg?=
 =?us-ascii?Q?/R29UKAMlPmpdKD0o6G2KSmZZ23vrGqbfbc9qOoiY1PiZLerg/k43U0fe+WT?=
 =?us-ascii?Q?37jdag0RWUCS4QDMI7YnTbfYx71mIGCHTtw8Hy45H+8Oqv2OA0vhnNt/YUtR?=
 =?us-ascii?Q?u1nj8WtZVmIhY=3D?=
X-Microsoft-Antispam-Message-Info: /q0EU5H4Yo7Xj3VvWrowp6GSSdIfoZjC36qzgn/0mjfp35COaD1iAW55KvPtcPva5CUqXnigQa4QtTvolbZp7GsDukF4DfFPs6n3hPYFY+suoUrH81zPHzCXnGXwU5jBB2y5+HovbrD1+VaFmjL1Mz5JcINS92KVyRcmjcMEO12a4OEAhIFGW7jLrsEVyAQZMbYeMQUNvSV36Vnguhz1HJX2ql26l8mZCAxkLP/HNFO7sFqSltQdckgxpHmdi5IxYH+dOdgYwL2HMUa1WGhvBjHrlJm2lS3Hj+gnZskPPGYTswv4yK7ascRY95hsr/tomC+b6OY0pN8rG2+ufinKuZB0U8/3wzLuWUvLRFJ1pIc=
X-Microsoft-Exchange-Diagnostics: 1;AMSPR06MB519;6:Au9mMtNtVG6evckMmrBv9s6xkV101EmpkAKO1YwpP0fgVgpjC8o8bt2D7eWrx8OfDEZP4KaBuL8tuE8LGg79Yn1XjqteSQLBKWj1oB7iT/PX2BApLCa/SdPXurMNkX+82Tz5ebmiTsl3pSqH4RvNuWSivJgPBjgxTK0wziMQLtreNDLM/M/zqbtu8GKX1fJ/8NHm+gSLiM/heQp5u+cAxDEIW/l1dZfTEC3i+9RbsKGG7LJrVb+BmGrpWHVLDUAma1Vvk4yGtjBuikLFoKK7IDFkDM5yvhQCuiYw2TgRjrAzJOK9W7PgVsIv5RpC3xnMgbBR4biMz4kdcUtBUztOEow/bSRq5mwIbVlDO14eUljQ/MhPvjcitYD8uP3rb7ktZM7uJaRR621aQsKEm0HFpjAbSB305d2J4etvqrFM1BvHkXQXGcTwkW5e2UXIfDlyru2cZbBGrNa2YbSmCZv7pw==;5:1bRpteZDj1Da86ZVJHBJU/39FwmPQhm/dHNbUxWfj7E7fsjbZ0lryHa+CGpRFKreA5WpS6FpQ6vZVvJVCJdTmtaQDoeqB9g4pI8kse4TrOmiFQ8UvupSe/4c6CUgnnHoyE3tvAwDT9isSOdIfpPXVZtkJsEu7LTHVNBN86kgpnA=;7:j85WZCzKVcUozY/Q7tnfGMXuR9M9hdGZSRNdNxHXmdgqE3Gu8KQUXdgVh41A7c2FCefcjoIqesbsZjLPHXEZihLk4SOA4BkeNYbjIVwR/oThmPwwljz1G/0lUT79ywX0TpMK6sDrQpOpcBNUsYrkPQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 14:51:07.4055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf73d528-3c2a-422c-8fb2-08d63dadf583
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR06MB519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set provides improvements to the i2c-ocore driver.

[V1 -> V2]
- replaced usleep_range() with udelay() so that the polling version can be
  used in atomic context.
- added dedicated patch for minor style issues
- fixed delay computation
- use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is always
  necessary and a trylock would generate an extra interrupt for nothing
- make the driver ready for an eventual master_xfer_irqless()

