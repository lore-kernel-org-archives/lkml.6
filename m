Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7211FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A832086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pl51LZ1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A832086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeIYS2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:28:23 -0400
Received: from mail-eopbgr730081.outbound.protection.outlook.com ([40.107.73.81]:48160
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbeIYS2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP6ZeTSRzx5vyBQhIKcZtxZIiqHfWLLW/M1v83LbOFw=;
 b=pl51LZ1pbJQqOibJf2L6adeAgz+GCa/tbqYn0+FrwUPYbO6YRgx83Ns8o2hQu+aLgpcDvh2TeaZBShCyYzDEB7hMFQag1R7gxFOMb9JiFTe1cnK7wkp5f6scoMrECdwKu3vCpK13e65ZADKLkhfoXepn3ty/GyCDuqYi/Us2pxc=
Received: from MWHPR02CA0055.namprd02.prod.outlook.com (2603:10b6:301:60::44)
 by DM6PR02MB4764.namprd02.prod.outlook.com (2603:10b6:5:18::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Tue, 25 Sep
 2018 12:20:59 +0000
Received: from CY1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR02CA0055.outlook.office365.com
 (2603:10b6:301:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 12:20:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT059.mail.protection.outlook.com (10.152.74.211) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 25 Sep 2018 12:20:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKn-0008P8-TX; Tue, 25 Sep 2018 05:20:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKi-0004n6-Q2; Tue, 25 Sep 2018 05:20:52 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8PCKlIQ007541;
        Tue, 25 Sep 2018 05:20:47 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKd-0004mH-7y; Tue, 25 Sep 2018 05:20:47 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v11 0/3] Add support for Arasan NAND Flash controller
Date:   Tue, 25 Sep 2018 17:50:28 +0530
Message-ID: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(39060400002)(50226002)(2201001)(9786002)(110136005)(2616005)(478600001)(8936002)(5660300001)(476003)(7696005)(8676002)(36386004)(305945005)(77096007)(186003)(26005)(217873002)(2906002)(356003)(81156014)(81166006)(36756003)(48376002)(51416003)(6666003)(336012)(50466002)(486006)(426003)(316002)(16586007)(106466001)(126002)(47776003)(107886003)(63266004)(54906003)(4326008)(106002)(34290500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4764;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT059;1:okIxV5WsHfNq2Q+ASNqO4FDsmxVDXsbrJLUDTYgZWQq8eiW6tiMqNVcDdObLb3u2q+HjkYWlaIm5PaKbTSllx2uEy700ZT2bIX2bjIfBikBZCuMpodg8IKm4BkgrzINN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d64c6861-2740-4d64-1974-08d622e159bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4764;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;3:/nlKZgCIUDB8acJQVc0oQRG5IamkjCkWk6Ke1sGBicRHI9xmq+PaDHKma0VqJ3wEJAyzvhbErkBrCEFksYWiQsvqzgNuhlCh9eNh5JcsH0PSAtmzvAqWpEbgPhYytOiYXMXiDDuLPgxyDKiM5tgOCJeKA0Ie02Fb8PmZdcIL/zutANf95/sgl7/h5zXxTlGeRHNl//JG7hTRajZwsWEMtITpTpGfzcZQwt2SltvnPGFee9SbsJYOHDlz/5Iq6thDrJVaqsqeyj5/vI36mxRtXPHU5IxuEhT5Yv2o1L+aUOHoSlJ/D6Q36mmgiAPn6L8KxrScPicufp7EVLyD59QKorbZjv+wIzunc8gPiSKA9ko=;25:QoIJDY+RRpLlpOqJa5e235q1xQlGxdTbTDUvv1/IBxVEnwhTe9fI70TRZ/SMTOMz6uBRrRrtdST+OJVTlARqsb2p5W30VISRfElnhqoMXAQs0BS9M3nt5i+GQMlPRy4YhEElprZHc3n/LI7BDGkUArtBQa/wuYy1erMfJ9fpJlop4vKeHoiZ3QseJuSpplPd0Ic9Gdj/ocbUF+W8zU1oEeqsVMbbAR5rJp101sYuuHM0PtUMVb/9Yl3UJ946vMKHKFedhWv1zJ27h4x3dKeZhaTlGRIUu55Q5AJ8pUifXYNrsC8hb2MryYniKj5WOvBZ+fqFc0Vf+0LKjzkIHewRYw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4764:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;31:IR4T7oca4TjCcPrxBN+h/9/ANtMPb/pRz9VlLGLg7qk8Pm3pjC74lR+7IgoAVWgy+k/NPRrlc8G0vQZSlhoVhAzrzxj/tVmUHTuDFWFDs7doHrhBxxL9+VtHw8l5Up16wi0nL+8hnjnRBOAxyGGAfh62nouYazMmTk9Xa1TsfeM58Mf2ycQQk2xLDZ5l1hMqrucGj0uMf8OrzFzYVJVCx2RwhzaR2+4J4hMP2vfYHqQ=;20:iL1jg+sRCivAWsq62WQG5+24eAsmauOY4TmoJ9ae94q27+5teWiTEBuoXzmCwbr0EMJHWCe65p9vdFahJmdwcy4NXufiXOE7bRLQveEJuXRM6EerLlr38FwT4fmWGVrcoYlkpiNKdaFEnSehYclk9v/Z0JspSOW1HNL6ppKf7dIP2bsIm1Vuf9cdYcLxAzxfdaFSnQPktsUOF4iaBc1KghoeVETPSxZQd64pBCv55t9IK7+um5/rjhHpROMsUe8W9D5nwhJsCHXTsqHF/nZRJOep2+N5pdsMUHNXi07N1RcZpKxYWtEFatY2CfsL1uAnv+dNegQVyScDWBB4YXpOH5cgO4MKAQzOzXrc/uGejsx9H4AaU5rPxpycQpyzbwsQ3jXOHPE8VLXQsUodB7Ws7smJZ6IykGdqx466NQX0A5Pp3LHyXYwsCetAv+/zhls+rOGlu0O1gWpTrjFN+VbT39OY6uLyVVDnV8sB+5CSgBcKAyMdOUtYKM5HsDic8VaC
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4764457E98ABE89099626348AF160@DM6PR02MB4764.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:DM6PR02MB4764;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4764;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;4:/tu45CYsJud3TPE3wqJgojCGWBmBQmMUck7M1oKQjNERzE6uB121pleu+jYrI0kjR3Xca9UXVVXn/8kkvcoLDJiLEfsROdaZVvXFzW2pb8gzXYPkMRpjN68b5FgK4p6i46Od68GKhJFpStQ+rmI8r8SAhA0jP7dK9/MsnmoWp06/n62tp8AeFA6LRRzMf+dGISZ8e7uGU9U0T/U32rALe+fDBDiDW5XfHmf0PyA36H3YYx2DC/69aKxjxVBHyFYCY1Jfq092Q3KMZfcCoRJtMg==
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4764;23:oh8yNAKxFrLa7aw2tQJGUbXx5mbEU+W7p3pMaOUI1?=
 =?us-ascii?Q?rA0qbMA+9b7nVycZlrnpsO7xk7/cimcBOqJNT1VEM+pezaS07dTGbcWDOpM0?=
 =?us-ascii?Q?yGd52T5/E9DDYE6DId/MgKJwdeIYPpy/7enedi6MD41Ho7qaMNOrZ6C3DyVM?=
 =?us-ascii?Q?lVsIEvAfFrKOYiVs7xnT8dCUXs7Hb19SPab3pYo9hrjYB0jhL3dNgHkCgdu3?=
 =?us-ascii?Q?DBG7aYc20MFnN2f9UqBGt1618mAkU400BHDfz3rRxM4cWs1MF7uMoXIIrgiu?=
 =?us-ascii?Q?eJiKcLHF2a+FQ5ZsVsl+1ASInV91KAe7Oz1CSPH1DnOgY/BKOu4VGCwUs/p6?=
 =?us-ascii?Q?uszGnwHe1xeKj+SDG+wGSCEFM7DDM3Ml8RDFUimRv8TOAeUipH035i1usADH?=
 =?us-ascii?Q?JxU4v17MxFSkYzsImAPKNBlTgWx2mU7/lddKbEOgqWanZP+tAW4P160fU0HX?=
 =?us-ascii?Q?k3N8W3usfc+4ijwPq9W8VfAj+A+Mx5sMgbiMl+bFvn/dw+Ohs1sruGXAEcZX?=
 =?us-ascii?Q?qkSawXNGRCxSkxl7NaSBrNdA8zbiqLm5TU+EkA3TRZd+CppBUa7VknBQk0Su?=
 =?us-ascii?Q?vsTILJIa+sbVm96tK0Pz+UBgTii3mKqhHnCM2DeIwEZZMQ/SHXuBCA2JLEkb?=
 =?us-ascii?Q?l9mVTuOqhvZgb6yJueZ8MhDMHGbBlGm34W3u68SNAVMhnnTreuw5hVXfmvsE?=
 =?us-ascii?Q?41OPq9+6OzbLI1yZgvsZD6tUOSN4jzfZyD71TdJvUNp4swFSos3teXVfQB/3?=
 =?us-ascii?Q?FhAg/tNqqwBP0L/ZJL5cd5kG2c3udKXl2I42A4MK7VgZ+XFHWa1ZZI9djV1j?=
 =?us-ascii?Q?+qRX/6EV2rfNgRLY/g+ao57b/RFnleHFsiPr7LnZVqZyNTWqXrkZp0qgab3p?=
 =?us-ascii?Q?ijBBYk7t/vJHMjKzs2EoVYT0C8iS8Qy3gVXqYznMBLyoHZEfeXmddu6ZtWjy?=
 =?us-ascii?Q?uyQaDP2sfMpOeQFddzVuQqSRSOwLu33mONRLM+ZYvgabYxhOXJDWlgct6T5W?=
 =?us-ascii?Q?Jj1Y9/C/yUOf6KN8+2RaE6Wj7yigOR8OVzvrVg2Y6L08y2HCz78uhKUzt3qN?=
 =?us-ascii?Q?bwy3XW03JqSW7Q/9Wxj9Mk8YQ7a7wt9asfGNCBioNmh+PGXkOxBEE3cQneyg?=
 =?us-ascii?Q?QO/G/Z66t3G8V15Dg9sdwRCKrfnmKVH?=
X-Microsoft-Antispam-Message-Info: vNFwUWGPf5m82PZ0N7Ek+SRkw+E7DgUpM0CFCc809zHDMrt/GzZWuM0u/4iriOisHy8P0nnIPQssaiLC6zw9LW2rlqCDRCJ8whQPX/FDxViMfaEd8I2PbwW2C/36b4CRXOq4JJ6ut2GATIwUuWUewicoiU4JUVQotVcR/kPnNqS9Y1YIYO8TZ1aNAmt30AQWMhfLSHioy71A9WVe4XSYodpe5wHqglZuNFKL2QsUSpYtq7JDULnp4GkLWOxFmSjPmeTYpZRVxYMyz4flVM1Ih22o0yzbj7D6oPJnah6Tovvl1+AfhkTWHLM5j2RREIBto2DfgScwpld2fzC9dHQFooUh2zu5/MzMd98UfveD+us=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;6:WrK/tLor7rouZmSo322VzhJ/AgTVoSkZHPG/F2Al2+nUEJBO4sA+ZfV/LQrLOnWhF2oMFs0Bmtpqex9MY93gsh0BgI51srLGpY5FHqa/XHQrmvU/vzK+oKBFP9AxfZGNLA4PeCj/llu2fnEfLFZAtOesAm1R9XCCEkbGuKytlEomFm6JlLjWL+EzJzA7rfWwqBOxgap/bIxv0nXfJDLZS29oLloPiHa49wjLdhEuWjWjH5pUJxND8z8i6+9jw1pyHXNoc0gOQ+8ICzsFDXy7iJONfRR0O1dc3MPJmAdxLu76DcIL3mbAiwRTf30ixUMyOmyfNlisQ8JyOr5tI8c7pZl3scOgYSixiynJoIaifI4EHRnGc3w/ZG/o7y/IVMs6Vjq/4jfxlKvmmfqOWHMA+J4iaqKV1e4jeUtvrI+qHr97luq6ULAbEU0yDWXdOSwd6gPpvprxqdnj6FraQOuEuQ==;5:8PL3LWEejq3JvD/zpj+uTHnwJ8CQbz1Y8Ou5jQNaQQdFTUlYFIbpgg+Z6JiOdJHXtfSS50yG4ZpGoaiu9E7VVRMQ9VmLICQSnqfIy39K9wpoC754w2sEz6kDTYySbJGBayZmDpRzK+dXrp8KhpKFQFsG5vqZfxHdKo7gO6iaxBs=;7:4OqnH3szzwAjc22ow4TSHOMyNsZ/jIEv+M2iJtfrYzUGFeTY/2odamk4ySaSZLGVm+XYQ8xLeOTPvsupuviJVGTNRCSnD4HPsy7Ym3bNJlyDlFXeaxC2SpURYySQDGt5RtLgSGan2aRhnb+1RgOgDmetXCncSVMvhWxC/S9YVQHdXWh6ueDfuSd45tkGRmmA39E5+n8qaNmkIrSPA9WMlJDgYEJCKs1quIPi0uakB7P+XztSgjjvgwQ+8+Fg1B5s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 12:20:58.2584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64c6861-2740-4d64-1974-08d622e159bd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the basic driver support for Arasan NAND Flash controller.
We are reinitiating the patch series by fixing the comments given by Miquel and Boris.
Major changes are exec_op() implementation related.
Rebased to 4.19 nand tree.
Tested MT29F32G08ABCDBJ4.

As suggested by Boris, it also adds a new varaible called mode in
struct nand_sdr_timings, which will give directly the sdr operating
mode. and it is useful for some controllers, where we can configure
direclty the operating mode instead of timings.

Naga Sureshkumar Relli (3):
  dt-bindings: mtd: arasan: Add device tree binding documentation
  mtd: rawnand: Add an option to get sdr timing mode number
  mtd: rawnand: arasan: Add support for Arasan NAND Flash Controller

 .../devicetree/bindings/mtd/arasan_nand.txt        |   33 +
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/arasan_nand.c                 | 1324 ++++++++++++++++++++
 drivers/mtd/nand/raw/nand_timings.c                |    6 +
 include/linux/mtd/rawnand.h                        |    2 +
 6 files changed, 1373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/arasan_nand.txt
 create mode 100644 drivers/mtd/nand/raw/arasan_nand.c

-- 
2.7.4

