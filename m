Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AA0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EABE2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FtuCU06t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbeLTRcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:32:54 -0500
Received: from mail-eopbgr800085.outbound.protection.outlook.com ([40.107.80.85]:61813
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387479AbeLTRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpIZld68Z4o5KcMQYkdijxZNx0I7++9p2pHvSm4v8CQ=;
 b=FtuCU06tNsgmcFRqxuXuBvWOdDMiDPWHpwjBSWm2jXqzkP36BOiRlqda1u5LjAScoODesWBlV64UCOyc1JhX2ai0vHznJak5fOr2hsws+inem4WJkmK63Wik0kcpUoIFWP9yAc/T2zVz5N0/ofq3py6VWp8DFwqO9sJbDFLYn4U=
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by BLUPR0201MB1890.namprd02.prod.outlook.com (2a01:111:e400:58af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Thu, 20 Dec
 2018 17:32:48 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Thu, 20 Dec 2018 17:32:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Thu, 20 Dec 2018 17:32:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1ga2Bi-0006cl-I6; Thu, 20 Dec 2018 09:32:46 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1ga2Bd-0002Wx-Dz; Thu, 20 Dec 2018 09:32:41 -0800
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1ga2BT-0002Sm-0a; Thu, 20 Dec 2018 09:32:31 -0800
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATH v7 0/2] Xilinx ZynqMP IPI Mailbox Controller Driver
Date:   Thu, 20 Dec 2018 09:32:27 -0800
Message-ID: <1545327149-22331-1-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(189003)(199004)(186003)(36386004)(305945005)(2906002)(106466001)(47776003)(14444005)(15650500001)(7696005)(51416003)(4326008)(5660300001)(54906003)(81166006)(9786002)(476003)(8936002)(36756003)(126002)(110136005)(44832011)(316002)(486006)(2616005)(63266004)(48376002)(50466002)(16586007)(478600001)(106002)(336012)(81156014)(8676002)(426003)(39060400002)(50226002)(26005)(107886003)(6666004)(77096007)(356004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1890;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT031;1:V2ZPFPfsQxI1BOH7TdxXUtEagqmNJEREp8tjKdODDQhxLfajPYFEj6rLML9tyVRHuseRqF3iazJav/yoA6sNQ3LyIcQAmNG06fNnIlafhFW8PNwKK/+YWclrLOw4D5sa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f589ea6f-ec83-47f6-28c2-08d666a12855
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR0201MB1890;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1890;3:0fMiq84wSYbE2XbVruF3NGLLrUN61HszeyjH802OfNuuCpjR1gdkWqDKlwXb+QawZUVjkgVAFI1DBHhwpggo+wX1gH9GsTqZj4X0lGKs2KrB6JMdMSUr5nLylmxpSCub7e1JNG7dHGTK0OQe0hGO2JHz6XT0QfazQQLEQMdGN9d5Tl6TjNDmzsypenFmZsoCEW/VMbb+Ml9UC/SunaFXTmAxqS5EV7iFzG0X/fmHtNl0n1KVeRhNyv1m+GJov5yRB4wDeihfvORTZZ5JQuHq9AFFybgA4WGCBliy5z7vC9upoDf2TQqljfzcCbVHB8FcUn+8fZ8yvUGIXFMq7pDKGudGq0Q+3f8f8Q54DlRQuh0=;25:7HWeQyoquZVk+Y+8Ei48+5yjjuRqjezXVanutpMn6dIIIOJbaOSHGmdSE7icFh/f1D3INiHce7xHcqjhHWbdiXmd09MXDoVIqEVNuB5pZGGuriwKjTzPRGkwOhsGH4JspBASQeM2GHXbg8ENImS7R+mxMeokc0UUrYMDPq/zbceTev08sfwkzN8C+eByo3OqEQqtRXNvqzWOLs2+XRgKDli9aP28R29/lFFPU9lA5ayGhcEsx6okEBJCgqVeWlkeTNp7vLpKGDSzWYGdTWiXfsRElm2bRwCjAzLaf0rVhN1BfNCeUAAOH3MH86/ly4Ledho89h2MpdCenyit925Fd5cxQA7Bx3B9eQUH/hWJy6Y=
X-MS-TrafficTypeDiagnostic: BLUPR0201MB1890:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1890;31:DmemqVxzEWUXajk8MRKXAcBJMY7srRVvvO23RrS3yvFUrCbUSj2nzM7ljZCT9Nz2uVXZk+p2nol+4Vil5ZyMM9xf0oY2SZQ+c+HLetCRwpUTHzwbHF2tfznp/FRHRqzMaBFiBL/4SsXtyKsEY8/n36IwCo1VZdNqu8Z62ITwCVrrTcB8g8nnqfZCUhwggIcCxffgS/M9QK3QZuTgiZSZNXniO4AFRzkCMK5doEeKBz0=;20:+xU23z7jmV5v43HE1Kki5kDdi11rWytnPYokKcRNUBep85wy6QIMLzpbGY2e7LUvF+paKMN9cqgbO/5xF1w1dmnlf4yvi34YC2g06cUeP7UbpVm8P0j2Sk1QPT48JwlmHdEkPrncy4AfGst/1b+Kmf+d1rkEFU9eECkvKnPIR9QKkf+PKmBSMBEPhb4nyi8j0JTn35FlyRdS2VWUY4ONdIqtzN67szTQWs/pIq22OsjfXJMbAZfhxd0a+IUWXNUWSecVBmCSITJX/Ayx5GLv6fjWbMUOcp5WMtwB3kkeFWMb/ovsXQQ+Lf2pBJVVmUyjcObPU1Q1YVRTvvGLFGnp0YuAh6l5zTDmny1WhA0ZmGT367hVoaQeHEoB+fMLCk9Z73FyZqMJ9/xYHxVYx0uO1vl5SxXG3ezyTN9O0yEAFlPPNhuLmh82EnU607n+z9N26vj2WQucWLJ9m9dcHgcgwwVdYHY+ZdQXGzwQxBeRiZatC+MnZk/ivbfpK8XdnvdI
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR0201MB1890D3D026B28DB5AD13542BB0BF0@BLUPR0201MB1890.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93004095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR0201MB1890;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1890;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1890;4:DRsdHG2SLJHLz7ADFLZkqOEPUqTF6gH+NgH7p3jr/lUxA0LnZpK0Yf0Zjc6QtWaOEuY+HqBEEiFKTjNMGwYWiTfsWffF+SQEvEJLRm3ZfRXvs784WcAvpAWnCcso8rG0JeYh56I+ftW+TV/9gO94fhIcZ8a4m/lWyWyukgyp/oZiaBhVnMJLfTdBJUBSZN6g2Nd/r4o4jzEcJ2aBi2S05ZdyRYjzfSBEskZWOe2eGBHstsIEZD5aH4k7ZRRMG+dSokCGFQMmOj0DC6pL/bfkEA==
X-Forefront-PRVS: 0892FA9A88
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0201MB1890;23:iUOCMF7GXOFvcS9ysnFKeeEKVg6LT8QmgC4EWI7?=
 =?us-ascii?Q?QSrlrrHE5OOrATeD6Y7BdbejoxRMQN1Iwps3A6CQocpPYwMkQvTWWQGOn60V?=
 =?us-ascii?Q?VfEpTjD2+/nsJX8dwwox11T/+DN2UmsuTfBtQ/65x+b8TfTWbwtTu1rKN1vp?=
 =?us-ascii?Q?ZqgvwqrIJ6qXdKIt6MorHZ5YB2VFIRWKJi9zNVnWDu07T7F+vmuv4gDfiecy?=
 =?us-ascii?Q?vVqaCvmWR2Z7rspvZQ4BsmJr2UgbrwzHLSpjyeaASdaPH2jRnHV6cfw0Cfzq?=
 =?us-ascii?Q?4X5xHRKdM3vkFIbg5TmnIRsH+uaOIukbvmNdkmla/KKv9d1p5hpGnil5A2dg?=
 =?us-ascii?Q?d2xpsscHeb/uXUoWNHT4tfCgOlTzT4dbWPYn97jZuJD9bK2BWecENdcJ05/P?=
 =?us-ascii?Q?kdQwXEnTntyI0wL0xiqGMcV4PrGNGYWMQpdYNRTy10hSJOTrijda0x5/eixO?=
 =?us-ascii?Q?1vA64Pjgf4hX1BBdbAP9DnsKUGdnln2kJcxpD468cBP8/8zaItzU2kFI9/S+?=
 =?us-ascii?Q?y9okjLhjr7zr3LEK1/G3Dnpfy4UB83F14VTAeQXo4+QwStv8lUS++ml+2Sol?=
 =?us-ascii?Q?JPgxs1z9e+dG2+TOv2C7DSt3FrX9fdLPEJqK06YVTT93IjZPGYojQVSIxLUw?=
 =?us-ascii?Q?wjIJFX5b/fLm6plZsqUzAFKztJq6uUmoBtYCeYd6vS63/g2aL8zLgB02NklC?=
 =?us-ascii?Q?J0wCg5DmuEiI4lRKxmxZ6Qpc3g5yMGP8UCjLzskKKBMwqOXtnGaDhOn4iDNG?=
 =?us-ascii?Q?KWuTgegZ2uf6s4SFio1NaHovt9KJ8RLtAYbWBSSPEkSds7xl1b6/w3rdFLii?=
 =?us-ascii?Q?ncNgQnHufJ2V2ySFc+myuPgl8an8qU5llvCcrqi8YK68NB/F13YCryaB2m5f?=
 =?us-ascii?Q?/r7DrNMwxxCwySSiK9A/zIe/6/GXBhNDIixi5+nocQXCQUyd0JB9C4ilBJUH?=
 =?us-ascii?Q?pUxsNz9DNJgcJCyynp0pFYh84B3b9s2PxDNrLNSpv4GxwE6PWssNYAC7o0RJ?=
 =?us-ascii?Q?w+YSf9oDOFPrPKYMUtva5+zocztGneWd6smX0us26AP0rOngrGZOKGYt9F6t?=
 =?us-ascii?Q?xuW/3ZX0UmFEBty6V1S21Z7I2eQIIDGli26czhweYJ5QmyQxOwhdkgkEQ0M8?=
 =?us-ascii?Q?T8CdoLyLUuAU=3D?=
X-Microsoft-Antispam-Message-Info: LetAsKwMnKqvMVOkdYE+8DDeOEnHNae7QQcAcporsaDXBQzUjktBcu8Lu2acd8zoP8H3OMnJVbccWGGOWTwZY6f07mSSFOpUxjK5s8WJrVTBkknE42IgRnKehHa1TyiUh0+EIQuXvZ54d6/3F/RNduVhipEetg1ozRz2pia6/F3cxwXDhHNWmW4BcQG4MavD+gm7b/Df7dgMIAWPdG537xildDhL969EfEo9RzRvfAdESAnxanQIuvenhExAj1Jz/PpzK+kKghdPPf6OMZlt2S/notNJJFrOHQs3IuKPUz9wtTDE7ebA5j2A+ZhLzqlv
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1890;6:SLyZOmhItWi7y9Q104vHtgfKiKx5iiBEUmN0SPPoCdK7OQbzEoD0/QiVPZYrlv+mVc79SPUgdSso+wgufeom6sxV1JLBvt1lrHvo+1HIxkb22QtCxBbzRtWBDd+MmOLMtDIFTSISlWAYGDhODNF6q0X94xb/D4fwxfowKrABxgBxqTadH/fxP1+YNqo7JAA7arGJv+cY7XJxXq8lOEfMlWwisz79kVn2ysCvE3GfPZCmvbjrw6p1CVCZorAWjBMct3SiSmYhq9zEZ+p9rRX9eM1LyuD1tXVRIlF6RBJGMwO6D0ueKq1K7Oklunh+Jkf0aMh1F7yM3P1n5eA+BC9BDyO4fm7bSt/gY4Al1u09HgeBXN2dT1C3vCb+ZoiKktf7TiywDONWmouWen6J93xCc9734VLfasV/gial62nJ5xPuRkxGXaIdyObJxAoMTHqdg3TrJlGoOKGW9AaZKeCPUw==;5:TbRzPA2uQKiYf41GVF+BMoz4oltE1M93wgNwWhdxlmrnw9acXp63IHdUtoRMytgdjTxOZbTwdj7iLrZZXQr3SJWeA5+c15009WjY3jyDCnf0Vb+bIkO783AyC6luWmf/3QPG+GlIPA/vVr9Y+lhwYW6lw5mJUDKdBMABIuTNngo=;7:A4/DPLldFpw9JU867ZEeQ5mKMtFVBInmWlvKOrfsXmQuCBBK/YfJddIr24mzruk5ZBsEWr6rA15nwV5eK9lFja8DoCqgzS4/68RQvoh35tgA+SqDCmy1W8xsWjYZy1qQQ3d4YGhsXRV4gVxpZs6DHA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2018 17:32:46.9441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f589ea6f-ec83-47f6-28c2-08d666a12855
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1890
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce mailbox controller driver for ZynqMP IPI(Inter-processor
interrupt) IP core.

As the device tree bindings have been updated. Do not have "Reviewed-by"
nor "Acked-by" in the dt-bindings commit.

v7:
 - Fix sparse warning, and documentation check.
 - Add emply block to the end of of_device_id.

v6:
 - dts-binding, remove compatible property from IPI subnode

v5:
 - fix check patch warning on write a paragraph to describe the kconfig
   symbol.

v4:
 - make IPI mailboxes as subnodes to the IPI agent device node to properly
   describe the hardware.

v3:
 - add NULL entry to of_device_id of IPI controller

v2:
 - change SPDX-License-Identifier license text style in .c file
 - replace xlnx-ipi-ids with xlnx,ipi-ids


Wendy Liang (2):
  mailbox: ZynqMP IPI mailbox controller
  dt-bindings: mailbox: Add Xilinx IPI Mailbox

 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 ++++
 drivers/mailbox/Kconfig                            |  11 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               | 764 +++++++++++++++++++++
 4 files changed, 904 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c

-- 
2.7.4

