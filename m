Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_FUTURE_24_48,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF107C41518
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692B7218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c/lhSyNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAXHqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:46:38 -0500
Received: from mail-eopbgr740085.outbound.protection.outlook.com ([40.107.74.85]:47025
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfAXHqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA7EtohcjS7J/1m9sGn0SDAUUF6GPWZSWqZg1nCod58=;
 b=c/lhSyNYT/DaqoBdEMbPutmMAinpnF/egqsVl58TfHdhHPYzYLAa79elRdd6I8zdosZYGMJW9CAfK2ZVYDNMRuuNRBiLm+VLq0afUwyKPbZdnv89x8Tg62e6N0G20lmHTvBpLf6KlUZsQ4DHcS+/Q4IBd+R/glLCgwJrTGjpUTk=
Received: from BN6PR02CA0047.namprd02.prod.outlook.com (2603:10b6:404:5f::33)
 by DM6PR02MB4458.namprd02.prod.outlook.com (2603:10b6:5:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17; Thu, 24 Jan
 2019 07:46:31 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN6PR02CA0047.outlook.office365.com
 (2603:10b6:404:5f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17 via Frontend
 Transport; Thu, 24 Jan 2019 07:46:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Thu, 24 Jan 2019 07:46:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiV-0005YK-EI; Wed, 23 Jan 2019 23:46:27 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiQ-00071u-A2; Wed, 23 Jan 2019 23:46:22 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0O7kCCa028329;
        Wed, 23 Jan 2019 23:46:12 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiF-0006yr-La; Wed, 23 Jan 2019 23:46:12 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 1/3] firmware: xilinx: Add reset API's
Date:   Fri, 25 Jan 2019 13:16:52 +0530
Message-ID: <20190125074654.10950-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125074654.10950-1-nava.manne@xilinx.com>
References: <20190125074654.10950-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(199004)(189003)(63266004)(26005)(77096007)(48376002)(186003)(14444005)(76176011)(36756003)(305945005)(47776003)(2906002)(478600001)(50466002)(81156014)(81166006)(106002)(356004)(8676002)(6666004)(51416003)(8936002)(50226002)(7696005)(39060400002)(36386004)(426003)(336012)(316002)(16586007)(476003)(2616005)(486006)(126002)(9786002)(2201001)(110136005)(446003)(106466001)(11346002)(1076003)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4458;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT017;1:nZgPU597VkHgZY8C2Ap2TIBT1KALh+1kP71p+hlkZxHuPJ0/oWDIee5aeL1ImcWtE3ZlnA89f3Rw3vCEQl/tRLQPbWUUy8U8bC3CbbBePHUyDjfyH0EpHSNQKkhR3BZpzbG6eOoLyPj0clHAISOKV8WQXGYG6tcyAwx309+FGSc=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f093da17-0fe7-4d5b-0d3a-08d681d00e06
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;3:6NceGFMg/KahIc6267Zgop4WUvT1z9/X9JDiZ42vGZGQL0gze482LJOZ1fXpPibZ7ow6ayAnc20OmOKnaI36DWbXyknDYxQFKNruZx6ja/aJcQnVqmX711/yBNtBFBwjscQIOI8gB9I14J1XpRB+lYP8TY+V9Xz+/pGDuS6G5JmNTF789+LJAFmiuQ4H9T7UKdLHn9W/cr6aHIsYajT9d6tnyQ6GuG04f+NMgBIAK2k8UPjz56+OsUDUPTL+Al6VLs2iEIbDDDPeTm4dM0WP8WX3AUs+e2syyth+I8O6b2I+l0IGxiwDafBSDk6LcU6rumqszzizeasgIt3Rti7W/oN02N8k8kpedCIwS42yyKQz37ssNw79wNuGapsJfT/6;25:a/Qm+YWzVyaeDQ4cjJoU7XiK2iegC+nVMw90tSzYyKmwyCgrhG1W7Z7p66rYDTEod5V8RuxJJnsyzcGp3i2E4Rtzamdbm4VL9oW93aUBE4c0Su4ejDEsNKC5f+DjaWyR5kQjMK0PqdV640Emiq9Bts3Pmy16bfDyC35XGXAz9H1VpKdhn4RfD9V0b+JUK30mgxT4jW5zwms5Z6bgdk1zReUc2wmgtMju6mu+ZezagW/xi78OS4K4og1qiCzSW6mbB705Z6RO8u0VcrKi0XcFNOlIIqfOu8Cz0jHTFQHBNbfc4nNz+PXyo6HOUpPs/ifkPXM/Dv0mMdl4ZVJB2IfsvQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;31:52KAhn+8DOo8B/ddIL5nPy2f+12dVhobKudtC4cZYHlOaDK2l9PzopXoDezWb8RC1dPlLp0Mwj3VDIg92BMuUh4mAJxhfSClPJIYuFKrhbmfG0j4Ht0QjoTj0HeVlcjB6UcMl8CNkuAcdaDLJ3kgfqdExQYwwD4j2Q9nYX5e4LN9CwQgSej691vIJZ4bVw8AihNiTXSwtDfiiiVx7N0yamDO5nIkCLKKneAvJ/t1TFE=;20:406I52nrFzZVbUDL/PQ5yH6g5J3zkGjiRM/zbTp+/9zjcExSrkvIy15TRVjQtldXh9c7548YzybnkU+4zfpchRoWJN0ic6Gr9vYE6Fb53dSm+BX8TtvTsSOXjOqqMWYriL7d5DaUyYxdi7YNZh8tC5cv9bmBgEuBqgK6IZYMb/iCNJMaxhBXKWIdk22j9KfTPpXfJ/zOeWd2VvdzD+0iov0+BUCodu06tSHS0amDJf0ujW7WhC2i+27eorZQlwJH2BIMu9z66U6qei2i/jWkPDvI+GURd8P1ccA7F9RKwVDc2CfMKTXRLDG2cFKjfLHMYq1iLF0X7cf5rEsj87QbdZ3owxCJ19awyOLV706sD/YAG+u+BYnAxO4dvjnj8jDoHpY3Svf10tlCDwC4pCFhXKyYQLzQWqoP5vErBjjeZTLI6XGM2Gnp9p4gJ7oS7fXsvg3XxqPatRS5tRvtfjoAmWroiIX2Ib30xt02b/yIv5WyEPqHQZ3HEPQUflmtw4z2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4458FA4E565085E4F97FBAE4C29A0@DM6PR02MB4458.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;4:af9HSEl6E7sdDwHHS4QYAJbq7DH3Sbqx54LNJ5941e9dg1Pz+wM4GDh5tcYXnL+AoNmp00lsPh8aUAzFbtj216a7iv/PkQflsf/OHT2GO3Kv5n1QBMR8TUXn2xYny7RWvuG+nvmwQB3/397hIGkGUmtAxToT2zLR19wvBG7vQVqSvd2Ds8je7s0xqSPI41JXppMbcCOnH+QWNKXljooStQqF1G8LGvpQxX/FmF8fWqlI/qUHGNUsfaLBANGt5VUy8z+3LjWD1ACiksk/bHTB52T1DeZgLQXOkELfM01Us0rFQKJ3DuJClGftaCor59QG
X-Forefront-PRVS: 0927AA37C7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4458;23:CLhQLNhe1xevD4QcUlLjbQXS5GMxVj1bjMX4B7rAy?=
 =?us-ascii?Q?0/10jdwNWv/t43oHXXo3GtD6FQWW+k4HqNiBZd4K/KGiuN+BOaKihE23qg9v?=
 =?us-ascii?Q?+jcicud3+7bovV0/8c0tkD1E+XeDZFygIBa6fNqLcHNiVBhMFbpENXWg/8Fr?=
 =?us-ascii?Q?ZCe/yv1feDoCtbbqPVwiFvoR2c34hl8rGr2bfO0vaNnTamqTkgB9DsDR0z8E?=
 =?us-ascii?Q?4L/8wlg5ujUFXqGDNNw0GDoq5ir+krnep/YUOqArpAPhuPjN+JEzl6qroTn9?=
 =?us-ascii?Q?SGuHwasN+dr7V49xnAg6qXCTFlrx9/G1NZGAmVvlFDTPbndRIhmesSTNSmqM?=
 =?us-ascii?Q?MBJ2w/9Gwme3cLcebtphFfWuncRhGVoN+4y+Zzqb+Yz0isrEXY1YoJPJJ1EE?=
 =?us-ascii?Q?ghY4q+AOuesgJK2igpal8L+MVIl1ULW55S+qsxWSPD2S5k0tdCRyAkPjCHOG?=
 =?us-ascii?Q?pDVbXKBXA2TZgWQHM1fRgunjxSxwu5jdqibZORG/0BWZAIVfPRKqkIj5T1rU?=
 =?us-ascii?Q?SAyjkE/B0bw2O+PtaBkPKlPQ8GaHZuiFPxr765ZPc2GZRnE1ClU8rroXlYvf?=
 =?us-ascii?Q?w0pSnZWg3zebtssSpSdwIdd7LhLYVFw6wgLyyyIiz89MYa/QGIHDsApIV75y?=
 =?us-ascii?Q?6M7/Da+qj37yaiQCvgLd4Tym+452KLDmeisYWu5sxd/Nwu2stvo3iRjaRrGB?=
 =?us-ascii?Q?Dza/rjSssYkYxYZSCf/1LqThsDwG5CMXf4bQ7hIgt/hGlKQcKdGElgVv3Ses?=
 =?us-ascii?Q?bkcIsB/UubTyjyehPYRJHwN+3pJ1/K5qyS3ROC0n9aWjJDxfsWP86v/rqwWw?=
 =?us-ascii?Q?Vpjy/yQyEmq/2KCv016IGMOxUX46T3pk+G3KQ4lYAdLPqH6u/KBjpMDaxzNR?=
 =?us-ascii?Q?yz7MRpYMyM+GVWg5fwm5UbdXENPcyoT2+gFOvvekBAyFenZF1fK02Fk5S0Iv?=
 =?us-ascii?Q?CdP/8iO4Kq4aLkBixTVXfl8O2I/BtTomKLtl6vtvo2fOd+x2LG2k6ulpxzut?=
 =?us-ascii?Q?QDMFVTP9dRSn4AyzijmQBRccpPmwofm8K1NMfLPT5NNQm9V8PzFA6vn2TUug?=
 =?us-ascii?Q?I0lkJPGRNdh0WsWY1LYn6fyCaHIChJkXFmaPkiaK0Q81WF4dwDYS+slXy+wK?=
 =?us-ascii?Q?v4RWWFuD8MOUO+c8Ag5HGKmfCOnT9hvfRSikXFlXuRs6btan4pqxg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jmjq+zX4QZq5i6jOXPmVvjgg/nQbMe/VmbH7HJ/Vkt4B9N1ZaoUFNkl2pFB2UCOGj5or1ni+l4kEAeaCOwq9eBBvwT+Y3VaLYt9ms28vDL4x1P5DFYVsDE94pNEhCKNM59GHFMX40fP56gqCUCrkwZord9BWzq+k/wc4hHmMXdjHYFsDZ/d6PQDKjIninx0ZCHF9ZzQAKRIV9u6WYxiO7yLpetgV5p8jVmndzLNwMg7DA5n5kPsv6nyeppEOBhdRWhU185NXBFSmGH7PVYAgwTy3sfbVdhfs+P7R4HE18LoayDeZf8bnLu80RumgPvFMJMC4yaPO9Rd8bDStwHomJTG1eDoHgirfna1FJJasT2wrjQlEAkHqazQMtBoy8qNoYiKFLJ720jGdpd6zS36ZrEmFpfNQ688jUOuP0oXZyGY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;6:fPmrrE3bQUslDhXMt0Wjs1e+YQ0Q4RKQhwFeU7jx29gYny+xev6YDUjslyknfWccu3jY+rEmDB/iKIJPIE/mXRSB5bmWxJrcYN31SBfsMr16iKstHTNMNTaF+tnhKxVPavUcY4PgB3aGpZ91GxwrihfypRMUNNniKqdAOK1I41vyPpBEMceuEAg1P23TU/7oQtTTfBS9ifBDWRNc4b2kaVNsWsumJsLnQxX64GkBzs3/98YY9mVwWrmltLcDPgQEaHAFU7u1ny2g5PzkpK0E5yZxoSv6QLPFK+jwadhqynZaXHLn/GLho+AFdXfhjkmQT+18MKnZrqRsA37H43TsNek8tr2K1ULm5Rf0RbRIANVqgKVcX9zETXWLT/rAZuRGfjuqslntCB6lBUuMRKjpK9uPgpL+YdHe2ByNEqQs1Fe/7Ymu3lbYKXcQSNrDJc0vZFUgBobJhI4Xf17zcX8XMA==;5:RVR6cc/o3ZSHtebyctGn/YwZYFn9cemOaGyWIvrU3A01tZyP/wbMdrEL9VsXvCmT+NB4I3Q664M71JXrDH4VfG3+/XGLmM2bczQuBUicOyDseN9EhadMV9sSAwG8Gr/F8S5G6oPsgCfo1qhhYdbMmcm/ipGrc2TxOW3OSiQRnX71jFLa7AqutYtrDSXpzhfSiwY+YAW0adGH8Z3hd6kNWg==;7:t88Bs7Y/y35Sc6TzyWt6hNRs2gZHfo2u4hvPy7SpihYKEblpAvkWKrNFvtC++5dFiGwJqqi2eP322586T5+dn4pFj99DMXeGt7qjn2eEah7LV2SWMcQGhYNBlj4Fukp/1awSEVLMr3zMxR5pxqUzUQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2019 07:46:28.1555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f093da17-0fe7-4d5b-0d3a-08d681d00e06
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds reset API's to support release, assert
and status functionalities by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Modified the reset start and end macro
		 values as suggested by Vesa.

Changes for v2:
		-None.

Changes for v1:
		-None.

Changes for RFC-V3:
		-None.

Changes for RFC-V2:
		-New patch.

 drivers/firmware/xilinx/zynqmp.c     |  40 ++++++++
 include/linux/firmware/xlnx-zynqmp.h | 136 +++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9a1c72a9280f..70b50377ae5f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -469,6 +469,44 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
+ * @reset:		Reset to be configured
+ * @assert_flag:	Flag stating should reset be asserted (1) or
+ *			released (0)
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+				  const enum zynqmp_pm_reset_action assert_flag)
+{
+	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_reset_get_status - Get status of the reset
+ * @reset:      Reset whose status should be returned
+ * @status:     Returned status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
+				      u32 *status)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
+				  0, 0, ret_payload);
+	*status = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -482,6 +520,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
 	.ioctl = zynqmp_pm_ioctl,
+	.reset_assert = zynqmp_pm_reset_assert,
+	.reset_get_status = zynqmp_pm_reset_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3c3c28eff56a..07c587a0b06e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_RESET_ASSERT = 17,
+	PM_RESET_GET_STATUS,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -75,6 +77,137 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
+enum zynqmp_pm_reset_action {
+	PM_RESET_ACTION_RELEASE,
+	PM_RESET_ACTION_ASSERT,
+	PM_RESET_ACTION_PULSE,
+};
+
+enum zynqmp_pm_reset {
+	ZYNQMP_PM_RESET_START = 1000,
+	ZYNQMP_PM_RESET_PCIE_CFG = ZYNQMP_PM_RESET_START,
+	ZYNQMP_PM_RESET_PCIE_BRIDGE,
+	ZYNQMP_PM_RESET_PCIE_CTRL,
+	ZYNQMP_PM_RESET_DP,
+	ZYNQMP_PM_RESET_SWDT_CRF,
+	ZYNQMP_PM_RESET_AFI_FM5,
+	ZYNQMP_PM_RESET_AFI_FM4,
+	ZYNQMP_PM_RESET_AFI_FM3,
+	ZYNQMP_PM_RESET_AFI_FM2,
+	ZYNQMP_PM_RESET_AFI_FM1,
+	ZYNQMP_PM_RESET_AFI_FM0,
+	ZYNQMP_PM_RESET_GDMA,
+	ZYNQMP_PM_RESET_GPU_PP1,
+	ZYNQMP_PM_RESET_GPU_PP0,
+	ZYNQMP_PM_RESET_GPU,
+	ZYNQMP_PM_RESET_GT,
+	ZYNQMP_PM_RESET_SATA,
+	ZYNQMP_PM_RESET_ACPU3_PWRON,
+	ZYNQMP_PM_RESET_ACPU2_PWRON,
+	ZYNQMP_PM_RESET_ACPU1_PWRON,
+	ZYNQMP_PM_RESET_ACPU0_PWRON,
+	ZYNQMP_PM_RESET_APU_L2,
+	ZYNQMP_PM_RESET_ACPU3,
+	ZYNQMP_PM_RESET_ACPU2,
+	ZYNQMP_PM_RESET_ACPU1,
+	ZYNQMP_PM_RESET_ACPU0,
+	ZYNQMP_PM_RESET_DDR,
+	ZYNQMP_PM_RESET_APM_FPD,
+	ZYNQMP_PM_RESET_SOFT,
+	ZYNQMP_PM_RESET_GEM0,
+	ZYNQMP_PM_RESET_GEM1,
+	ZYNQMP_PM_RESET_GEM2,
+	ZYNQMP_PM_RESET_GEM3,
+	ZYNQMP_PM_RESET_QSPI,
+	ZYNQMP_PM_RESET_UART0,
+	ZYNQMP_PM_RESET_UART1,
+	ZYNQMP_PM_RESET_SPI0,
+	ZYNQMP_PM_RESET_SPI1,
+	ZYNQMP_PM_RESET_SDIO0,
+	ZYNQMP_PM_RESET_SDIO1,
+	ZYNQMP_PM_RESET_CAN0,
+	ZYNQMP_PM_RESET_CAN1,
+	ZYNQMP_PM_RESET_I2C0,
+	ZYNQMP_PM_RESET_I2C1,
+	ZYNQMP_PM_RESET_TTC0,
+	ZYNQMP_PM_RESET_TTC1,
+	ZYNQMP_PM_RESET_TTC2,
+	ZYNQMP_PM_RESET_TTC3,
+	ZYNQMP_PM_RESET_SWDT_CRL,
+	ZYNQMP_PM_RESET_NAND,
+	ZYNQMP_PM_RESET_ADMA,
+	ZYNQMP_PM_RESET_GPIO,
+	ZYNQMP_PM_RESET_IOU_CC,
+	ZYNQMP_PM_RESET_TIMESTAMP,
+	ZYNQMP_PM_RESET_RPU_R50,
+	ZYNQMP_PM_RESET_RPU_R51,
+	ZYNQMP_PM_RESET_RPU_AMBA,
+	ZYNQMP_PM_RESET_OCM,
+	ZYNQMP_PM_RESET_RPU_PGE,
+	ZYNQMP_PM_RESET_USB0_CORERESET,
+	ZYNQMP_PM_RESET_USB1_CORERESET,
+	ZYNQMP_PM_RESET_USB0_HIBERRESET,
+	ZYNQMP_PM_RESET_USB1_HIBERRESET,
+	ZYNQMP_PM_RESET_USB0_APB,
+	ZYNQMP_PM_RESET_USB1_APB,
+	ZYNQMP_PM_RESET_IPI,
+	ZYNQMP_PM_RESET_APM_LPD,
+	ZYNQMP_PM_RESET_RTC,
+	ZYNQMP_PM_RESET_SYSMON,
+	ZYNQMP_PM_RESET_AFI_FM6,
+	ZYNQMP_PM_RESET_LPD_SWDT,
+	ZYNQMP_PM_RESET_FPD,
+	ZYNQMP_PM_RESET_RPU_DBG1,
+	ZYNQMP_PM_RESET_RPU_DBG0,
+	ZYNQMP_PM_RESET_DBG_LPD,
+	ZYNQMP_PM_RESET_DBG_FPD,
+	ZYNQMP_PM_RESET_APLL,
+	ZYNQMP_PM_RESET_DPLL,
+	ZYNQMP_PM_RESET_VPLL,
+	ZYNQMP_PM_RESET_IOPLL,
+	ZYNQMP_PM_RESET_RPLL,
+	ZYNQMP_PM_RESET_GPO3_PL_0,
+	ZYNQMP_PM_RESET_GPO3_PL_1,
+	ZYNQMP_PM_RESET_GPO3_PL_2,
+	ZYNQMP_PM_RESET_GPO3_PL_3,
+	ZYNQMP_PM_RESET_GPO3_PL_4,
+	ZYNQMP_PM_RESET_GPO3_PL_5,
+	ZYNQMP_PM_RESET_GPO3_PL_6,
+	ZYNQMP_PM_RESET_GPO3_PL_7,
+	ZYNQMP_PM_RESET_GPO3_PL_8,
+	ZYNQMP_PM_RESET_GPO3_PL_9,
+	ZYNQMP_PM_RESET_GPO3_PL_10,
+	ZYNQMP_PM_RESET_GPO3_PL_11,
+	ZYNQMP_PM_RESET_GPO3_PL_12,
+	ZYNQMP_PM_RESET_GPO3_PL_13,
+	ZYNQMP_PM_RESET_GPO3_PL_14,
+	ZYNQMP_PM_RESET_GPO3_PL_15,
+	ZYNQMP_PM_RESET_GPO3_PL_16,
+	ZYNQMP_PM_RESET_GPO3_PL_17,
+	ZYNQMP_PM_RESET_GPO3_PL_18,
+	ZYNQMP_PM_RESET_GPO3_PL_19,
+	ZYNQMP_PM_RESET_GPO3_PL_20,
+	ZYNQMP_PM_RESET_GPO3_PL_21,
+	ZYNQMP_PM_RESET_GPO3_PL_22,
+	ZYNQMP_PM_RESET_GPO3_PL_23,
+	ZYNQMP_PM_RESET_GPO3_PL_24,
+	ZYNQMP_PM_RESET_GPO3_PL_25,
+	ZYNQMP_PM_RESET_GPO3_PL_26,
+	ZYNQMP_PM_RESET_GPO3_PL_27,
+	ZYNQMP_PM_RESET_GPO3_PL_28,
+	ZYNQMP_PM_RESET_GPO3_PL_29,
+	ZYNQMP_PM_RESET_GPO3_PL_30,
+	ZYNQMP_PM_RESET_GPO3_PL_31,
+	ZYNQMP_PM_RESET_RPU_LS,
+	ZYNQMP_PM_RESET_PS_ONLY,
+	ZYNQMP_PM_RESET_PL,
+	ZYNQMP_PM_RESET_PS_PL0,
+	ZYNQMP_PM_RESET_PS_PL1,
+	ZYNQMP_PM_RESET_PS_PL2,
+	ZYNQMP_PM_RESET_PS_PL3,
+	ZYNQMP_PM_RESET_END = ZYNQMP_PM_RESET_PS_PL3
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -102,6 +235,9 @@ struct zynqmp_eemi_ops {
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*reset_assert)(const enum zynqmp_pm_reset reset,
+			    const enum zynqmp_pm_reset_action assert_flag);
+	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.18.0

