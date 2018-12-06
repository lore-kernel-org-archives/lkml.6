Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C9DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B090420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JSG+zL/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B090420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeLFNQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:16:28 -0500
Received: from mail-eopbgr710047.outbound.protection.outlook.com ([40.107.71.47]:55908
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728482AbeLFNQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHtsIsf1u+UERrki6Quec0vj9dGqS5HgoWTacNA2jeQ=;
 b=JSG+zL/FeTr6IipLwy52QJG8iRkGhWGoqIwo4kohdsjTpMMaB+lfcvgrav+LQQ3FIqtmozvtie+m8yuZ/Wr3yr/RNkjFtfKcjwThLaEPPLNtTVp/5bRQW9nxLg2OOBy44yZciXqz2plu7FmYf4X+4uKhbeicmSnFmSQEA6k4VZ4=
Received: from MWHPR0201CA0099.namprd02.prod.outlook.com
 (2603:10b6:301:75::40) by BL0PR02MB4324.namprd02.prod.outlook.com
 (2603:10b6:208:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.20; Thu, 6 Dec
 2018 13:16:23 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0099.outlook.office365.com
 (2603:10b6:301:75::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.19 via Frontend
 Transport; Thu, 6 Dec 2018 13:16:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Thu, 6 Dec 2018 13:16:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56267 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gUt4L-0005HC-14; Thu, 06 Dec 2018 04:47:53 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gUt4F-0007kA-Tz; Thu, 06 Dec 2018 04:47:47 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB6Cldk2005198;
        Thu, 6 Dec 2018 04:47:39 -0800
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gUt46-0007hn-Ui; Thu, 06 Dec 2018 04:47:39 -0800
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <mmayer@broadcom.com>, <f.fainelli@gmail.com>,
        <ladis@linux-mips.org>, <treding@nvidia.com>, <digetx@gmail.com>,
        <d-gerlach@ti.com>
CC:     <linus.walleij@linaro.org>, <michals@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v13 0/2] Add arm pl353 smc memory and nand driver for xilinx zynq soc
Date:   Thu, 6 Dec 2018 18:17:32 +0530
Message-ID: <1544100454-6357-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(189003)(199004)(39060400002)(186003)(110136005)(54906003)(77096007)(106466001)(16586007)(217873002)(336012)(26005)(9786002)(107886003)(36756003)(48376002)(50466002)(47776003)(7696005)(51416003)(6666004)(356004)(106002)(2906002)(5660300001)(305945005)(8936002)(50226002)(2616005)(476003)(63266004)(126002)(81156014)(486006)(8676002)(81166006)(426003)(316002)(966005)(2201001)(6306002)(478600001)(4326008)(36386004)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT022;1:0cR+okOah05vMz0ysHjpcso3F6U0HL6W33SCyVRx7hkxg1K8KLlJV+JMljkqXGQd8t8IzWdYGWL4T+uFHnWw2CArfpBFmnJWNuMped4ZIwtr+9zeEvj16voOQrS/eY9R
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68af689e-96a0-47b0-02d9-08d65b7d04a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:K2FsJ3JCjQir02lz7WfLi2/0eCxkFI94ZiMSPZCyr/oPRppacyVzUDNUFCfFkEgz/mJXzabd+d4IfA+9bWsZkug1AHZx01ZpyBPqZljPzbuZrwqNicHNbOZnwvJTzlYWpBnAI0Lzl3RWiBqare0v8hJvzR1AvWFVnrs1kkBAJ5MQRsxjo+sUAeyJDz0pNTaXdhjugufaT5sVwk+bpfWN66XjJfp2uKgbuJiV+MJ/J+s+N+MH9WQNovT8pnC4tT+p9S/lfH/epS9pK0/fd2HFfX96lUN/CPjIZz0tzZfQDbpFThrSjh+ytO5gGaMlgm+WK1DzYfSHhB3AoYfO8Gkeb18XEosAB1s1H+4OXxhyzHs=;25:0w/7ONzTpyb6T4IJDrGhmYaz8PcPN8NX+lmgEXkJEKM31n7NrzI0ZpPohQHEoh45n2d3IlQ0KBIJm3H1Qcz8Jx5p2hB8rSHIerCDnpYEO2ZceeVZpBvvQvKbioXnlnq0GRT4ZR+ox2k0t6ioBEEAZvv6fwKBDNfo4GoBTI0fadViXhNiDIHaKGldH6In4APz/bOTHdCyHzjHBm6nn7V+QxviZUgV9yfOUHTzuVzezgE7qk4CUa4nlKlYRUt4VH00Cg/dySLr6IPRlG6yVqJJomEjd+dnY3riTbpLwMlWGnXqEsq6nn8ITqvY0kpHHKi9C0QImsO8ugBeFclDbiw4dw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:O96NPD2bUK0ZhCJvsg33egUkGgIcESdD4fVBw5pDBsxwdqgVnkAEsI/xhofloElkmoXl6pSVUotuAxLvUxknLZAGWKgKIG1fjE3Ak6v45R6opWf1Lnl3VsfurN3smiGcpfgF1PvmwDjgug/co+8QQi3F86EhojwR3KBx7SZlV2z93on48A5QOtKHtbdHVmQm2B+rUXutTN2XepjHiQITFvh/oEYlJS2xQyiLJ6hSfVk=;20:EOSj40JP6MatMcGGLZenr82VC3U4IiwT//cUcQGxPaSl2um42RleQAzQTmXEcWAKpeRmQowfj+d/fnevAKcepQZ3mn6GBkUNHzr8vrPmg/SlZ3FVYhSFCSIG50D5UFI7/npBwOzNGgRhKA4A9Y4bNZ0NRTFiaZD41H5Gl4coHQoGYPjppaa51pOIZixdeiElo/d/HIFlAhnJ/J1eTPhWkNqOZ2sVzd6mA0lAQ0Idg8iIwA/X0NqMoVeqRAgtFUlEfLHCOBDHbNRfRKQr8a2z0SFqaH4JUhhbJc0bRxiEbrNdrHDBfb4cI9CotBEl+1xEBZ3yyJn4Ppp76HpYlVnVyWO44LIw5vN32nCj6fGePmY/OW263NRcosvkUcRhBDd459SInkOWYe2ZPbifIx1QkY5xXucatUDeFuAbS2qmsPc3bJ5yokhXApZfqmdcHS2/kWGVIG0zloyDRkxm7sEb9DIcsS22ejmeKkybEZz3rub+gcPDs5PdSFkgmL4LcL46
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB43243BD8B7F448DA2EF44D32AFA90@BL0PR02MB4324.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231455)(999002)(944501520)(4982022)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:HQqp6N1spDDtdf59rKuOxV7ZVbMwJGQLLrz7tOlcpUxNgeQwtXkadEOztDTlqJOJJ2r+HHzOKfhoVsWdam57WKbmrTDmBEpDGbKc4+L0oszcbKBzi1TcAvAcSzIm2IE5zqfOnmjy8YxL/nKPEn7XTULQ5UbRBBph1hkgIOksbPd3iZEcLrtwKEumRnUS7lEWUErV1+z8/WJcvwbuV4zsz1nEZavoKHiDMpsAEy8rLNzeyqorvEALNnxDxOHphpwMmjR4ffv/jcfR887JjGgncw==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4324;23:b1Xt8x0XwWzI2xUUnivsmNdfXwIbHUjiB0/cdBhmD?=
 =?us-ascii?Q?vLyj0KJKCr7eb7zrCpS6p0Xv7etvslgjrQ1R3QKmZsujmOh9JMketKgDaFle?=
 =?us-ascii?Q?fN/+lwtjNfvMbpCuTcPxk13QNHw7n9+yShdYcXNqmuqpicpiO1f08KT7ZOJQ?=
 =?us-ascii?Q?Hzszs2fIVa0XGviT0Hr1nGDYrgxgIZQBD0fSP/hDuM0PG2NByh8ev6G/xJYq?=
 =?us-ascii?Q?dUWpHFEjcn1HAsRa1TTGYYfHGLEQqq2aHPicJhkFWq+X2BeLM46dZf909r4g?=
 =?us-ascii?Q?oYweSRh9Q0voYZXGtWMj6LzAwNN0wKNRulVzWXypYnse8MNt4JBztErqOz/U?=
 =?us-ascii?Q?s+FIRgWwn/C6mtcZ2xRAiftCTiYnFEjSde7G0rVp+OWwhYeiOv1GQvljEdAU?=
 =?us-ascii?Q?tL2JnL2Tlspt9MYD1cQjEhlMSr+p9/7Zj1r3360W8YQSxYUEs0i87vs2IXvb?=
 =?us-ascii?Q?6+iCDuM+YMLd93yGVIbdbT7MoLZUbHc9ReWBc1+zG/JE5InqArJfS0BBwAm5?=
 =?us-ascii?Q?RMuBKiqctLeHAHLiY24CCo1HLNGc0dJ3isxi1g0a4QPIRCwe9pyOPjxxa+42?=
 =?us-ascii?Q?wGhJMzbbM2sjjeT+QdTKIdUluj2Zd4yFGKK7C1HKySv07vaqmv0mE8Rp1uvG?=
 =?us-ascii?Q?RuiTCyT3UezU0mAhAzP1bzAu2tNR/zMeuY0AW+lo4r9CXtRfPJSVvNeHcuFi?=
 =?us-ascii?Q?NCT0oDUQeWQKkq4kDM9xEah26bffyLKq/kn+hKhB8+8Xn5WTFSANJUx+x3Tp?=
 =?us-ascii?Q?xS/8YJ6Z/efxtPAIXxo7FSCWOJx8gXEOhs41CHFsftu2cx1sDVv/yA7A8EP/?=
 =?us-ascii?Q?FB4tQo+p0IcPfOIJdoFtMPzxHDVQYXbg7iRfgWqh6ki3ZXK5guctA8p3rvR8?=
 =?us-ascii?Q?yaxi3efn0yh804xBqEMswC04tJxhannRTUCm8yZG/W4Yf564/lKrSJ9WSMBZ?=
 =?us-ascii?Q?JW1PmCDRDqTHU1Ix+FEI1aTYiZtwoO+aaRLKftDFpbXG3l/538wSkdsOwsA3?=
 =?us-ascii?Q?LfLwkTydEPDotUD1tF/R3g2P3EhwSis2V88SV+cCJ8sZRHxfonQcRTgLPPcu?=
 =?us-ascii?Q?Gw5V6PdPWk/3HellHIO1bB74aqDnvJxMIN4UKifRCrBVabhYi0PStP4prKP4?=
 =?us-ascii?Q?KxyZmBbr8F2/AeJkbwnY/Uudiw2kcwONax8kZ+JSWoBrGaXoB6AUKuEPDpeC?=
 =?us-ascii?Q?S9xzTheCm/pZd8=3D?=
X-Microsoft-Antispam-Message-Info: 5lRXvL0667rBX/Tbt7uXPnhXPJjETOt8jTg50E+8gYCh62s39J7eLewXY6/Ng+8MOi2+GFRBn+EEp7lFALnwb74mZ6mWT1yj/4iIcaUg3MtpmoTi71gslFxNVVzOBVttykQXVKtmOOS+skIXqweGFF3Yl6/cEOJ9shKlq9NafMSgqHCc6KNAwMFgalm26wSqeqSL3zs0hy0bm+MWtLBSLl4GeI8GlNQOv6/K8vlDAg9XmS6WX4NKJ2gwiaRAGBswlXB4T6umboQh0NPNcN0OGCgGmPRa5XufTG9TJjJ7NP8fOOykZHtCxLf9CNYY8ymVWo8H+Amkqh/bepGYgaFDFWKGc1NNg7lyM/2zC44U9oo=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:NnAyRfDLVRJlWPmEhZQH6EC/eVvpG6EGMzDOGxxZzYAZKJ6SsMTKnxHxUQFitFTJRd5sG5k1MY0xUk+P+PwMVdB4sCpn5m9xm3fnQ/M1onJjXitzs4VM8tTA4omihpy5d7GjwVDvJ+SVIE/SUOeeFDd3fjwBSNr6LDq8EyUFoQTK2ZO5NRYXflQV17GwMbeljDGx3W7l4bNaUr9uRGh4u6dRKkBVI10Nxs/A0rdQslz18SfyoC+P3yjTR087e3hWzjxkFOG2OuW1T1/ZgE4++hapbHgsx6XcCe1aCxdIsW6Ie4f82REkUBxQCn8uWyzfeFHw2hLIMPIE1pbdG21GZhyCRlqCJ4WQkFpItvysIHACuKQjx54knfNcKiopMhZnuDhWz921HpDoNiqTRQvMzmy5YJU7/QbCTRqfd4JWjx6hI3DT8AL9gMGlW79ooTkPrgNo4ih6hCzmpBw207DUkw==;5:wCodmTdgm5xpHYCbLjfKU5LKCwemJHfEM704L8SmhSkdKXcWQg9ZIGiqssN5WVFRgcGQ70OYZo1dKliLLkpXiJPb8Aj42IiWMMUa1EW33f52iUaDN4bv5AamVQ2qAS89eMf6XqYvu9tmmwAi6vum6uNvnS5xeO2zVOwg85+IYvY=;7:MxkM5bfZ+4MNNSyPBNCV2bDR1jf+LZou1gm9+DEAGboTjCVDBAJqtBq3yDaIaQLlek1nbRbklgbfP+95diMkZmvKq2XG8MoOOtGug/RxF0OxpSCuFAEbXgHLvV1FOjBZmh7uL0LDv1GcI7aKwwYZ9g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 13:16:22.2847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af689e-96a0-47b0-02d9-08d65b7d04a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add arm pl353 static memory controller driver and NAND
driver for Xilinx Zynq SoC. The arm pl353 smc supports two interfaces
i.e nand and NOR/SRAM memory interfaces. The current implementation supports
only a single SMC instance and nand specific configuration.

Xilinx Zynq TRM link:
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

ARM pl353 smc TRM link:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf

Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.
This latest series make use of ->exec_op().

Naga Sureshkumar Relli (2):
  dt-bindings: memory: Add pl353 smc controller devicetree binding
    information
  memory: pl353: Add driver for arm pl353 static memory controller

 .../bindings/memory-controllers/pl353-smc.txt      |  47 +++
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/pl353-smc.c                         | 464 +++++++++++++++++++++
 include/linux/pl353-smc.h                          |  30 ++
 5 files changed, 551 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 include/linux/pl353-smc.h

-- 
2.7.4

