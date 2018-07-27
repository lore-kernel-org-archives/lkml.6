Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10384C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A363120671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="T2jC9UJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A363120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbeG0HnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:43:10 -0400
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:43865
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeG0HnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV6VTw0KkXLm7X6NjA7ix5c5a3l+HTKdL2MkHutZQUI=;
 b=T2jC9UJX21eWjp89AuaZRRxEqoHYDBomn3tMNcfA/PxU4R4kIYwbwfyV7siekNyzcZ+hzx1dYg4O2MG6fx9NzrB2kOF+9Asd/pNsrD5pRJ6q3o6JfJcsvFhZtZSDvi1zsNqr316HpWWvb2i2lqJt7C0Ay83mV4YS7ycVMvpWTpk=
Received: from CY4PR02CA0033.namprd02.prod.outlook.com (2603:10b6:903:117::19)
 by BYAPR02MB4455.namprd02.prod.outlook.com (2603:10b6:a03:57::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 27 Jul
 2018 06:22:47 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by CY4PR02CA0033.outlook.office365.com
 (2603:10b6:903:117::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.17 via Frontend
 Transport; Fri, 27 Jul 2018 06:22:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Fri, 27 Jul 2018 06:22:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51933 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fiw9D-0001pq-T1; Thu, 26 Jul 2018 23:22:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fiw98-0003g2-Or; Thu, 26 Jul 2018 23:22:38 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6R6MakA030104;
        Thu, 26 Jul 2018 23:22:36 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fiw95-0003fZ-To; Thu, 26 Jul 2018 23:22:36 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <michal.simek@xilinx.com>,
        <kedare06@gmail.com>
CC:     <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <navam@xilinx.com>,
        <apandey@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v4 1/2] fpga: fpga-mgr: Add readback support
Date:   Fri, 27 Jul 2018 11:52:30 +0530
Message-ID: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(189003)(199004)(4326008)(54906003)(476003)(106466001)(77096007)(126002)(186003)(2616005)(26005)(39060400002)(107886003)(486006)(426003)(9786002)(50226002)(48376002)(50466002)(16586007)(5660300001)(110136005)(2201001)(63266004)(356003)(106002)(2906002)(316002)(14444005)(305945005)(81166006)(47776003)(478600001)(6666003)(36756003)(51416003)(8676002)(36386004)(7696005)(336012)(81156014)(8936002)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4455;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT024;1:UIy5KA6UUoOfZ/vmjWF4K86tzoRx0ECHXc1niYTbQM77bhz0R6LnYQtzozSlCLSIDO03qSBmy69+MtiW8Dd4u862VlT48uPBXPoiA4/i1cfqmRHAvUO1ZVD+jbPDl3Sg
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f90795fc-5df8-4153-7d85-08d5f3895ed0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;3:7wtcU8Sj1D0o7aQILoTmRNyARjgpebmZfzFdgl0EirgmpTH06mXwd0zAh+UVQ8Mtb/yxX7FkyNT0npKKLW+YaV7S1EOZADS0GSyLobW7meLVMAeihN96lU1+QHuMT9T1mGeP0MxyhZlCLiRAuoNJe/lcqiYAsblucL6eUiUue4riHSBUiXIgCCg2DLLUeaLMtXsbOSyroOYTEt7Aa/D6/XBy/BUwA94WXBOochPsE5/gW3+FMeYy+B9lJ/y6piPfuCHBDZSF+VHytmXUnhIr2JcIOYqLtEAb0n2BnpfEq+MGhhLS3GFqLDB0C3DSZNaYaYj9wuxViufq0JkdOBKxwYLxQ9Oo+IDkNxUSTj2acAg=;25:WEhmnMnNZU21YdbwJsdGbZeRd+pOivgdKt2JRzNpJcm+tsu7InuCcEiFZGOgrXQab8BfQ2MnV0MTsD/RU8NkAHzp/5m/+08QWAAEjoZknp2Gk0lQQljr25CfRMD6ULfuw5B/6yTfoEfl5wCLSMa5iFViuel6ygzThIzwehnutHoLf+VuzQPHbuHp3wxITMHa0sqP5ebGmqX0nUMwvrayXfdj26B1mfR8xvKzPeRd+PK9vAldV11G9zH1klk/Hyn3pCnqmIYlPipDAPcXDnvyuSevsjQCU0w4aqg5blzFXYUd4hIIvMElVeU/PA0DRyd2xv/Wl7xbIz+Z93zBWeqscQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4455:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;31:vPyJfver0oHVSmu8BNkqvC2ojRfyW3oIEtK/3HaPE7wmchGMzk39lrWloodfcfR7KGYip9pHuQGpQjVfeF/yLBh52duzI3Hu1OCrUrZikiAulcs6rOSSL8UOlVNHgILwDqFhoL7AVMIBEVo07gLFd3KKhnb+4oVjYgQZPCtpOlQ5CorJrFqPTS+hycSyLMQyKhtB+tREbNg4t6HqdNI2JrPvlhdFfF54eMXnRdyVn7E=;20:hoJ4e485eavGq69yfD1BQQ6ZDGC5zxi6engWTHFwfclq/YURlahcZwd6RisUvLLT2AUvNjDs1YChn0nLJWU03ysgCEb+FLziU318LexgNF4unMl+QCjq+l30ny1BomXl+CutbgxcQTQAbPmxhA1pt+MhdpMIbjmcGspCyokAszegDXnfB3ByajqVYgAJr/b0U3AGpo+8Vz9sof+c+qjQFVTjgU4jJGId9fAYVPZoGeV0mCZwBUddHR3HULnPnmKyXKuHDCp7EdGH9n/tXYATa+Jc83ss9nGV+JwoVazMyvFCtaBf3zZRolm5wKLBGaGSwgHqrEOH3BAiNXssfFQ+08BMp7rWWTdLq3pNuWvSGgRlyG1yFUai9c2TvTYLidxzMVQLgSeny82ZcoP3R5EFstQH8JecL4y+yvihCiv1RMUVIJry5Hg81XUuAY9gvHpBy2IYWGxRIGNAV4s3w6c3Y6nugTKiEqsrGGmni4Q0d8OHVhdJpjOlhpV6qjgwjFKy
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4455B75F5E4BF8BFB34BD0CBDC2A0@BYAPR02MB4455.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;4:Vl/o4dqTwbvhbWoly2Z/I+tFL3J8CQm/D9TZ7GDbL8n+Dy4ZhD2d1SGEEbPjYWEiiLcoPP/IDUu3BZsITvocJqPFzxp3b1FsnayemlYKgLOXcikwWOaJo9nCEJ+kXNdDFm0MiRB2hWiIwks3+PMce0yexIhFFlxQCOFG9ytCR2KHpQDuYuce0c/KFYqNUakkjU1cPW/7pxBi2J7KNF5Fyy6tPeElQuTb0kZ+WB5MLaH/TlUui+Fyy8LcpLSoJ/RJddF7Wdk03uSIP5q23mmBxGK9ixSSR89oJnfGfUidZQF9hLJOpHrrsi9DB7hrWyKC
X-Forefront-PRVS: 07467C4D33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4455;23:ijHXmuRJTlXuo62ii/x9+wL9ZcNb25FgzFE9/K7qb?=
 =?us-ascii?Q?BekgSC7FAmCYDCJp8XJVp3g7erI4w/cdWqyd1PprmONEWe1BodhAtMzENa6Y?=
 =?us-ascii?Q?lbOTBu0pnV7+b/RvkfZKPHrRIzLJ5ioj9CC2ZMx780EiLBDAXTR0kYNpCsCU?=
 =?us-ascii?Q?oyXKcIoHiT1xLlcf0mCiJnvgefldAeNf43kN4nTlkJEVN+t35Cft9yNxTJ44?=
 =?us-ascii?Q?Cjnba+Riyz6xUzypfutJbaq2U3yykqy/1gWAMAmO9KAX8xQXIBKMEgCeCbCZ?=
 =?us-ascii?Q?mheVETAPNKVxMLy6C9diay3uCUftuTpEoiY+c3/vHwiSfPwOhYXrZxe5udvO?=
 =?us-ascii?Q?QuitZMmcleoRxA+89BGc+cU6qdR//0o9WLvnOAlo8hwO41TeDYl05f/jPEqn?=
 =?us-ascii?Q?+Z4nARCCCjklSL0LyUSolY/0Ic67JiSLumDw5VLfClW9nLjmgpiqq+OqHtGL?=
 =?us-ascii?Q?mPdYT1XQdc9cDHXLdXuTwHtBhg/Kh+uYDMra8ZjtGzykV6l6kZaJjf1/Vk0f?=
 =?us-ascii?Q?/QQ8TxN9148+Y+sA1cdHj69OMOBMO5ac2M2yTeZfgY3afzkJvVu2D5SWpvjl?=
 =?us-ascii?Q?I2VtY8l/tGaYAURJCQcq0f4GTRGyFsTJld3PfFBzlLYoShYuljORTSr3DO16?=
 =?us-ascii?Q?1gXGa3RJWv3sAw+x2CWF0tSoQD3D6Mh8HoH8elUH89qfdllORk4v0eX6Wqmm?=
 =?us-ascii?Q?kKkS/GQkTGeaFI9/BvxpMmeprfdAMq8DCMYpN4ef4L3LL31nT+yQfDU52QBU?=
 =?us-ascii?Q?j+1XXfA7FU3ajd/ccePK+S9KgYsBa5KJa0H88ogh+tU6jpdMrfpf4w8bojxh?=
 =?us-ascii?Q?dxDLYZwxLy62/GWZMF/mdffqgd4IWjHLR76y/6/TeP80V8EJsypjAG+i7Loe?=
 =?us-ascii?Q?hvckvlxsdWqkLSSYKRJq9qEjxA8q4byRZOfY7jJgc/xa4mNOFJ9wwDVg3k7+?=
 =?us-ascii?Q?bt5R0MP6yxEH0jKLSNj8weHj+zUhgL5dgTi3ilKAH+HfZUWAvIhVtucTvU0G?=
 =?us-ascii?Q?PBz67h4J/THC7ITBN7/q71R2mjArGDfm+q4BfbPRcaQ1KkjwFy6cC9jJ4Icx?=
 =?us-ascii?Q?e3oB1lqDipD2wdmLnXzLi6YrPUGTYwGfvQbTfUyKhgLoZK0JXcquReF0Sj6k?=
 =?us-ascii?Q?/uxGa3pCh5TBNf5hYQvaeWAuFf/pac4M7/XYM53tzDS3jYRYlabng=3D=3D?=
X-Microsoft-Antispam-Message-Info: K512Ir0N3jA58PVCZdhLV4KBY/vLv+VN3xyKdwUj+i18HT0HQ5dBVfMs4fnF24u/PdmkHUvrmyQdpLDcFoMcqfQ+GnnDjT6ZDhYxiSCw0z/RfC1PkA9FK9fcSFqRriFDSTYRlRtQcnIPw88CVuwx6nA7cNiskMJy4fH3UpaDw+y0o3gaRI3nHXOXJKDAgKXV6lq2FIt16zbs5y/ftvEoOIpzYP0024TcC9bOe9hKI0noPhkCZ7l+9Ujz2fuiCIu5j4XYGWTJplnNkd0KTeqEHlNAkkzChAXdVNlw+gxFIdOXNzcp8jdfKnnJoAuePYbl1M7/mo0t6GGGYW9SqhZ68XHTx1yb6w0oNpP9dInzulw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;6:ybEb/yrh7ybx0FasguydxisLiuv7MU3GClPhb5gb1yFBoZep9TqnEL99qacunqTCVYgl4nEECaCFb9GP6fiIgjPDYR+aqgmdk9LKg4Jz/rL7fdqQ7lZ1REZj29YDPwfykqWtMt4SuY27ABUEfy0sUx5lI74FHV8alDHvGBkbgbtjE83Bj0DHm+TqTn+XLFn+eCYxuXvmDzY2DwGE6Ym8ZuOqv+0z6H7I+lPV1rNImlLh7rz8yHeWDY/rxyeyQP1SukBErzdhqlJV39HlQA3FgjXoKdgA40f15hVnUKvLi+PqHgx/yy7dotRyA53F2vKEVZqVkLZYTgZ9AEmONHGqk4sGaa7sL2pIjp3mkU3PoyOjb3woSeaFNJrJ9MmUP5+j46SwjGCaO5Nx4uZOVPq0mjieIAkzud12YvvmDtWGZgfYJojDHX9QdTHhPNVzzUd/j1s3hJlex0Ai5hdRS2Vv/Q==;5:ldzSxzPIebg/Y/t0dwlMOVDY+yb6TkTUeeQe7WSCyqJFRHsUBh52XNdI0Tnj7wDJojYe8ZzG6X26jJzs+CoGoldi71Khi4I9E/gfj7Mmu9USyi3qlcYj9ps0etZUUDp8OMHyU02C71Tg7w4YKDXM1aT6s7XY2WJnd9lqJ+kL+sA=;7:wub6repG9Kt4hSCyAEH1qXCbm2sQem/F+jchAavB1QbTg3PYMhqRwDyPqJlOjnR2oNxup8Aeu/xz79yXRMCWAQ/GUSy/ZoaVRM9gcjG8TIg78kEgOJLY81C157b71myJKDysgAhWTvZ+KvZx8eLvBma28Oj9HUgrDqSuXmmRM6hbuazgrt4jQSAUkWnEI6xVl19AOpXIEZ2SeC8ZTaFvoJVvnnYPQygHOCntc94GKFqsal4CWrQx/PeM+oAolYVa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 06:22:44.6614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90795fc-5df8-4153-7d85-08d5f3895ed0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inorder to debug issues with fpga's users would
like to read the fpga configuration information.
This patch adds readback support for fpga configuration data
in the framework through debugfs interface.

Usage:
        cat /sys/kernel/debug/fpga/fpga0/image

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v4:
--> None.
Changes for v3:
--> None.
Changes for v2:
--> Fixed debug attribute path and name as suggested by Alan
--> Add config entry for DEBUG as suggested by Alan
--> Fixed trival coding style issues.

 drivers/fpga/Kconfig          |  7 +++++
 drivers/fpga/fpga-mgr.c       | 68 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fpga/fpga-mgr.h |  5 ++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 53d3f55..838ad4e 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -11,6 +11,13 @@ menuconfig FPGA
 
 if FPGA
 
+config FPGA_MGR_DEBUG_FS
+	tristate "FPGA Debug fs"
+	select DEBUG_FS
+	help
+	  FPGA manager debug provides support for reading fpga configuration
+	  information.
+
 config FPGA_MGR_SOCFPGA
 	tristate "Altera SOCFPGA FPGA Manager"
 	depends on ARCH_SOCFPGA || COMPILE_TEST
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 9939d2c..4bea860 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -484,6 +484,48 @@ void fpga_mgr_put(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int fpga_mgr_read(struct seq_file *s, void *data)
+{
+	struct fpga_manager *mgr = (struct fpga_manager *)s->private;
+	int ret = 0;
+
+	if (!mgr->mops->read)
+		return -ENOENT;
+
+	if (!mutex_trylock(&mgr->ref_mutex))
+		return -EBUSY;
+
+	if (mgr->state != FPGA_MGR_STATE_OPERATING) {
+		ret = -EPERM;
+		goto err_unlock;
+	}
+
+	/* Read the FPGA configuration data from the fabric */
+	ret = mgr->mops->read(mgr, s);
+	if (ret)
+		dev_err(&mgr->dev, "Error while reading configuration data from FPGA\n");
+
+err_unlock:
+	mutex_unlock(&mgr->ref_mutex);
+
+	return ret;
+}
+
+static int fpga_mgr_read_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, fpga_mgr_read, inode->i_private);
+}
+
+static const struct file_operations fpga_mgr_ops_image = {
+	.owner = THIS_MODULE,
+	.open = fpga_mgr_read_open,
+	.read = seq_read,
+};
+#endif
+
 /**
  * fpga_mgr_lock - Lock FPGA manager for exclusive use
  * @mgr:	fpga manager
@@ -581,6 +623,29 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	if (ret)
 		goto error_device;
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct dentry *d, *parent;
+
+	mgr->dir = debugfs_create_dir("fpga", NULL);
+	if (!mgr->dir)
+		goto error_device;
+
+	parent = mgr->dir;
+	d = debugfs_create_dir(mgr->dev.kobj.name, parent);
+	if (!d) {
+		debugfs_remove_recursive(parent);
+		goto error_device;
+	}
+
+	parent = d;
+	d = debugfs_create_file("image", 0644, parent, mgr,
+				&fpga_mgr_ops_image);
+	if (!d) {
+		debugfs_remove_recursive(mgr->dir);
+		goto error_device;
+	}
+#endif
+
 	dev_info(&mgr->dev, "%s registered\n", mgr->name);
 
 	return 0;
@@ -604,6 +669,9 @@ void fpga_mgr_unregister(struct device *dev)
 
 	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	debugfs_remove_recursive(mgr->dir);
+#endif
 	/*
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 3c6de23..e9e17a9 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -114,6 +114,7 @@ struct fpga_image_info {
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
+ * @read: optional: read FPGA configuration information
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
  * @groups: optional attribute groups.
  *
@@ -131,6 +132,7 @@ struct fpga_manager_ops {
 	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
 	int (*write_complete)(struct fpga_manager *mgr,
 			      struct fpga_image_info *info);
+	int (*read)(struct fpga_manager *mgr, struct seq_file *s);
 	void (*fpga_remove)(struct fpga_manager *mgr);
 	const struct attribute_group **groups;
 };
@@ -151,6 +153,9 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	const struct fpga_manager_ops *mops;
 	void *priv;
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct dentry *dir;
+#endif
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.7.4

