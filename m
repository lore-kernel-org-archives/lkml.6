Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B12CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4062186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dmQJMui4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbeLTRc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:32:58 -0500
Received: from mail-eopbgr780081.outbound.protection.outlook.com ([40.107.78.81]:28800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387686AbeLTRc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jbn21ZxW/q3mMQeu+YkhmUdbNz9M8L49v4c3Xx6HT8=;
 b=dmQJMui4msvA47neI1C3jaJmv6EyFMXWQxaBN92/svK41QooWcljxc3M8DZBE1wLlmstz+jWmEZuTXPyzBf5Ibf6iHr2CnQK0/X6NQqnBqyYUAKiHv6VP8UvoJCVKrWHCfeYzcRECv4Hl3VG2Ta3AL0a66wUHl/tzZ2Z4EBauLU=
Received: from SN6PR02CA0034.namprd02.prod.outlook.com (2603:10b6:805:a2::47)
 by BY2PR0201MB1895.namprd02.prod.outlook.com (2a01:111:e400:58b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.19; Thu, 20 Dec
 2018 17:32:50 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN6PR02CA0034.outlook.office365.com
 (2603:10b6:805:a2::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Thu, 20 Dec 2018 17:32:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Thu, 20 Dec 2018 17:32:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1ga2Bi-0006cm-K7; Thu, 20 Dec 2018 09:32:46 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1ga2Bd-0002Wx-Fh; Thu, 20 Dec 2018 09:32:41 -0800
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1ga2BV-0002Sm-6A; Thu, 20 Dec 2018 09:32:33 -0800
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATH v7 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Date:   Thu, 20 Dec 2018 09:32:29 -0800
Message-ID: <1545327149-22331-3-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545327149-22331-1-git-send-email-wendy.liang@xilinx.com>
References: <1545327149-22331-1-git-send-email-wendy.liang@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(2980300002)(189003)(199004)(44832011)(305945005)(51416003)(16586007)(39060400002)(63266004)(316002)(54906003)(50226002)(8936002)(110136005)(36756003)(47776003)(107886003)(106466001)(126002)(476003)(50466002)(48376002)(486006)(2616005)(9786002)(106002)(4326008)(2906002)(5660300001)(446003)(11346002)(8676002)(336012)(76176011)(426003)(81156014)(81166006)(77096007)(26005)(186003)(356004)(6666004)(36386004)(14444005)(15650500001)(7696005)(478600001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1895;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT038;1:AHlh8irtDgpaF4wZl6ShQ08VaCVKX9d8p3tQpS1Ozz1AZ2huArkrtPaBCBZwDVwh/gehyhAx+XyH+erE5oL2XR534Jl6HeufhLo/S7huTLnG606UFBMZs7WqZJa8Q4Q0
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2247d3-dcb6-4de0-2895-08d666a129c5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR0201MB1895;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1895;3:fufLpnzahp53GTnZ9apCOYgn6pyP71khFUMVq0WfOSzFYui6zyvo04TcApy/am6s1cvsU5WBW+ZYqORU5a+9e0FgaTChVpeUyxY9MX20ybeDBYw26eXgaGCldp+iitDyvHMXnaJT9EfVD5R7mpdbbtiLKOXDIVJlyTZeAu7boxA5x0GhwPfsmoPIps+hwAV52wChf9/Cx4QdNaFqKD5wVvsJFIgjG5o6P7LK4OMDvU3HhMNAYNmV1SuhruBVHhiajfiJzGIptAIG0iA3IGb8MXYKfv42EZI75ZHxzBY035iDMYU8JgXugk8gvdl8OXAgRSRlzPAqKrvWzWycEppzqP22ttQi+/FPC390BzRftSM=;25:b/LYYDgrCwuCGq31N06IGd4eWQmDnBgq9RYCaJaJqpicZIcg8s6FwmusNig+EGfOgoyb2CBUBl1pSWE5HvJNRAVbNx6Rd0FssYzCzFvoKa0X1ta2kFEfxiB47Qfw8QTFf8FVEu8fPuRUIiVtBcweinxKmkeBT7ttRi7pIDv6kPHKs+NPPG20Ck/QEFwWwojRikgwODdSSv1dHeMBsJsSXyPTF9KV61AHHHOI85pMudjEV/S+yBhymSpuqW7KsR/zjEnw3COykmrm8hmWEkHO2NzmkbH97yiOVtTiRMZVyJcsSENhyy1jYCe2uAuYVeOMTRxSsWvGKyTiN+BqcPX5oCu8U9bBgIQMr0X4TEvqMqE=
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1895:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1895;31:OCUdRcTc9pPnmy5tvXd91LrEkh8h5PsCHZoyFSJnt1zeI9I+bQhEToH+BByfjZt4v5JyZRe6rmba6Cbfwq00Leg3JEcCriu6PqLf/5eb6KdXktpEnAYA1SX663QiQOIViReEHazzpWaK9QnxOP50uhgG5ab4bk550MfNHJyjkGMrpw8Ww+RQOMnSdohcq+5jPgncPmxfjlSs8vNpXZho3eDgxYqigFEl8dRH3LV0kJc=;20:wYg/+93T9b5DMmycnqL5yuJTLLBYlO1s+STTZGGO1VE6p3vOnA5jjpP7/jmA9wem2oLgylswx0COWxkMAkRxeER3oVKiQfHsFPs4v9+PIU7YVT5WbpnvPegofsGMbmR9Qv5fcWpnXk1ShCcZCgsJ6E3IifEunYPD+kajzxMYqYJcr8otiZ3tllWiRELcQp5+0Y/tF/hpQ7YqdUzrWIfT7ITl6jfB1N50DOz3nxmrrxV7+RNu4dzdRZ5nfn51fC4b4u02Pr/YM03rb1Auv+fE0ptTJKt3U4z8Tef1S8os0bWQMHNp8ulahHXD6a7MiFDNMTDc0zI6I32ScyyfItPOTmZ5uDsYx/inHh2Qcj/vteoHF4zmu1eWXZK19slNB195FljHFCH2Ufnk5dQCLU5hPvB5l3uWr54Rzbmso6oCoZUWSjYza7s+UnKIL1+qqgOW4MHvgru2eClM2i2VDWcLFNzkt2WkfAVnel5cJt3rh8odWFqJCB93Esv1I67A2wSV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1895AE64C0251430DD536FAEB0BF0@BY2PR0201MB1895.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR0201MB1895;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1895;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1895;4:BmgI3vtd34JpQJp7I9OffZNlN3op7KRSTpc9VzK8PS5962/soljxXaylgwEP8sjtOhgUePy49+XeZJ50wPln7YOYjg/rkEiG/JMbtXRw40l+mTOcyafSV1zNsW4QPLm4TAj0iP9MJwTa6dLUWCGR+U36yIjiPfA+nSALUURwQbDMyvN2K130DAoW+OLZGFOEc9pE6HRzodO7AV7IdotGyR9Xm1zw4YzhA/zNTh6Y6DfPcjQ+Sl5HqgRToLqrnI/fQCPf3SNE2wOoALeL4bWlZA==
X-Forefront-PRVS: 0892FA9A88
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1895;23:5BpYy5kHZNDZTj2Ku9j4djIFWCJ6UM+ntQj9p93?=
 =?us-ascii?Q?Z74GPqvcMTp6JVZ4tlmqFKobwrfFmM0SGL3OOfzchVlw8mKmP7XNYjujyAq3?=
 =?us-ascii?Q?3Lk2QemTjpWKOw1sYwYpWw9jEE/Upi/ASZoQf1AeICK8TdHBIKeWqLydvNlS?=
 =?us-ascii?Q?Xd89MJvGhZcqqXXyMXBJf/B0lk+BMQ8eFa5phs6h7YWJ+CRh681I8ML2d2qt?=
 =?us-ascii?Q?gnvQkA4IKAcPSKo9wR0GApYiBBzsU+OfSrMuKP1eMyL8UQWWVFQX5ud1ZA6p?=
 =?us-ascii?Q?xc/+50tt+6uUntcWzUdOZDv9c0O9nNH/paOZDKEhYk1I9ZlVOjds5E62GFnt?=
 =?us-ascii?Q?NfqZqKzte1rxtHTlvj63yAZWAlmfIz9lmSeAxKYRs4mJdL+FNJPe78/pMKfw?=
 =?us-ascii?Q?NB62G/WGpu6INYcKwWcS9ZjDryYmqwD+nvuG408gN4uYmTSufEbwyMkX17e+?=
 =?us-ascii?Q?ZYXFqqhs4HyAgE6kSKB3Spo+mZFFSRZCgmuRHaLaALjDLEHBHwCjvbYhxeKg?=
 =?us-ascii?Q?q9dU9ll/kScCN7Fcm2F5zJ7Xitss3fpYDy4GVUs5qd1n9ivsWq4HZaGl6AvJ?=
 =?us-ascii?Q?uCHavUsUP2RoUJIYmZLG0Ee4nBQjYki0mgolup/OFYNBhpNmAMYS9Qus/nvU?=
 =?us-ascii?Q?Gi9ADYUGXGiw26/s5dCAsaDJUhGSvZ2FGyj282gjqsIwlQ/BzJAJBZOcy52g?=
 =?us-ascii?Q?wesTfOb3MSgMxDDGnjJ6B2GKeH+RUfTj71pd8dX4CMtbWabePl3OpmMGlEuI?=
 =?us-ascii?Q?J8GMyTSyHIH3KQh1Qm3JbD86NFELrOSr0Gf0gIGZD4rNH9rY3xQlhi0mZjnE?=
 =?us-ascii?Q?kqdljBH3ytrjgmgg31QSHS+eqW71Zkma21nmAXwni/wcCFwRxmQFBBvcoiRv?=
 =?us-ascii?Q?4DVrimTiNaNH3A/zMGSt/XYAxHYZwwuvEoFRJJepNSaciQkUuOPfWOZFnfsg?=
 =?us-ascii?Q?Yx8CLv1Jj8mmHwwrubtmYX8bPffZzqD+K5LCUssgKzj3b9VIbZOZq1lMILqc?=
 =?us-ascii?Q?yg6wxaDG7Y+/hXBO8jZkK+ExavH1NiCMGfZxnLLZ08jRk28wPWq/qFlDORef?=
 =?us-ascii?Q?QWMp85eHIpIamg6tyC4pJKeE+Jjl6wQ7zNOSagN638G8N+Rg5zhj7Y+hUHh7?=
 =?us-ascii?Q?wicKq+956PJbMiML+DVoJ+Up1JL4y8sXJwpzPZalwyM26zuy1kXsXT5drumf?=
 =?us-ascii?Q?EEAAJk6ztDzPCemU=3D?=
X-Microsoft-Antispam-Message-Info: A8fkqgIWjJQ+YdsCPN+dm+goHjtTYuXIUZt4mwE9jnYEzA6Wtoyzq61vp8G0icDCCY04Vk/gTp2gjmqle+wA+MLN7BPQ5dgtLx2rSXfgZ5yczQvouTzieFpe+MAX/NPFptW0Gvq7e0y0xddvx5GbMrwO1wul/5fFCAuH0GSkutihywieleAYldRLdtMzFAGkAnnVYXm9ca90nV4yxlD2LJGrRgtvVElzORR0ugbsbvNQFMNidAuXqVa62pDIIu/B1EtsqkRAX5nb6jG15JoRZiUHyfN6+GwFqR4j+5c4HwYhhsvo7zm2kEmhJG7LTdxf
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1895;6:JyrxolTc+0ozeW1d9+RuF0F6rJ0P2cIPI8K3B5EexqYykNWRlgsyNL1C1CVapSGmgFiQKsqSONgTv1pXinnQV90ndpBaVscUKLcwNRo7f6eMCFYoEMF+PEaRtAbljkdtgwB0xDThM4mE4VkXQ+oOGPQkMiHdVR8VbRIVnd7lKOarVGp7cH31+M3Cg4ChN8aOcSeJjwFk0NrK2JWsQRRfDd/Ut4djUKec1MmvZ4W6dIdj/eNziQkgzxCk0h1l+n50cb9ppytd2M/Ud7VcOZ19CAy1v/SYodm9PiDhOw5u3I0uKYqXK9g3iHyQNkN4jnB7MpUGFHPXbvTG0Ri7t/w2KuldbgFqqlkCDcdfy8IhV5AdcSpM2VhL5jzZZyfDfIYv2IMDNb484h69BaTaUq3wL+ZJFCcII0xFzEYvs3jMpzNsedVhnvot6SzNhD0tWRZXehj9zEpZppbTqnfPnK7w3g==;5:xzbcVmvOv75nw6LPz8a8NAq6Y/YAPc2MANGgOF1RDOSCM1MwpSu1Juehb26he/DXuOAzEWbCtB6HyqwBG06OnbkU5PaewGcULXtPGUndTB74Bleu/JvrEg2PitIhHwFBk4RNs9UI9b0KydYfodWEJ47/xP7SchYMySbf07fNZCg=;7:iVwQZbw6BufYY61Oze4wIuJrhpyjxe4JivrRo9ny9N9b+36OY7tRS+tH2hDmFJvJqbtbNxVvYNCJeuv4Y0XnseaDTHAee9P+JZnrT6LsvtozS95Pw5ay6oQNiCk1BLMdDCOPM1oy70+ZbZ3stEBClg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2018 17:32:47.2463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2247d3-dcb6-4de0-2895-08d666a129c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
in ZynqMP SoC used for the communication between various processor
systems.

Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
new file mode 100644
index 0000000..4438432
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
@@ -0,0 +1,127 @@
+Xilinx IPI Mailbox Controller
+========================================
+
+The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
+messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
+agent owns registers used for notification and buffers for message.
+
+               +-------------------------------------+
+               | Xilinx ZynqMP IPI Controller        |
+               +-------------------------------------+
+    +--------------------------------------------------+
+ATF                    |                     |
+                       |                     |
+                       |                     |
+    +--------------------------+             |
+                       |                     |
+                       |                     |
+    +--------------------------------------------------+
+            +------------------------------------------+
+            |  +----------------+   +----------------+ |
+Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
+            |  |  Registers     |   |                | |
+            |  |                |   |                | |
+            |  +----------------+   +----------------+ |
+            |                                          |
+            | Xilinx IPI Agent Block                   |
+            +------------------------------------------+
+
+
+Controller Device Node:
+===========================
+Required properties:
+--------------------
+IPI agent node:
+- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
+- interrupt-parent:	Phandle for the interrupt controller
+- interrupts:		Interrupt information corresponding to the
+			interrupt-names property.
+- xlnx,ipi-id:		local Xilinx IPI agent ID
+- #address-cells:	number of address cells of internal IPI mailbox nodes
+- #size-cells:		number of size cells of internal IPI mailbox nodes
+
+Internal IPI mailbox node:
+- reg:			IPI buffers address ranges
+- reg-names:		Names of the reg resources. It should have:
+			* local_request_region
+			  - IPI request msg buffer written by local and read
+			    by remote
+			* local_response_region
+			  - IPI response msg buffer written by local and read
+			    by remote
+			* remote_request_region
+			  - IPI request msg buffer written by remote and read
+			    by local
+			* remote_response_region
+			  - IPI response msg buffer written by remote and read
+			    by local
+- #mbox-cells:		Shall be 1. It contains:
+			* tx(0) or rx(1) channel
+- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
+			connected to.
+
+Optional properties:
+--------------------
+- method:              The method of accessing the IPI agent registers.
+                       Permitted values are: "smc" and "hvc". Default is
+                       "smc".
+
+Client Device Node:
+===========================
+Required properties:
+--------------------
+- mboxes:		Standard property to specify a mailbox
+			(See ./mailbox.txt)
+- mbox-names:		List of identifier  strings for each mailbox
+			channel.
+
+Example:
+===========================
+	zynqmp_ipi {
+		compatible = "xlnx,zynqmp-ipi-mailbox";
+		interrupt-parent = <&gic>;
+		interrupts = <0 29 4>;
+		xlnx,ipi-id = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* APU<->RPU0 IPI mailbox controller */
+		ipi_mailbox_rpu0: mailbox@ff90400 {
+			reg = <0xff990400 0x20>,
+			      <0xff990420 0x20>,
+			      <0xff990080 0x20>,
+			      <0xff9900a0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx,ipi-id = <1>;
+		};
+		/* APU<->RPU1 IPI mailbox controller */
+		ipi_mailbox_rpu1: mailbox@ff990440 {
+			reg = <0xff990440 0x20>,
+			      <0xff990460 0x20>,
+			      <0xff990280 0x20>,
+			      <0xff9902a0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx,ipi-id = <2>;
+		};
+	};
+	rpu0 {
+		...
+		mboxes = <&ipi_mailbox_rpu0 0>,
+			 <&ipi_mailbox_rpu0 1>;
+		mbox-names = "tx", "rx";
+	};
+	rpu1 {
+		...
+		mboxes = <&ipi_mailbox_rpu1 0>,
+			 <&ipi_mailbox_rpu1 1>;
+		mbox-names = "tx", "rx";
+	};
-- 
2.7.4

