Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF142C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54359214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="i7cKH97v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54359214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbeHPKDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:03:37 -0400
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:45121
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729566AbeHPKDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LTLvod/Vzc3+uX/yI5dCRhRzIYe1r+iayxuBlUavJE=;
 b=i7cKH97vDU4MIa7FUQAS8WwSfSfaGqr7DTAnqs9jA7rmcRkyEdoMhB+aOCtGeqKYQi8PcQ3dOSHil+ShefVpt30Cxie6wOiTi8eaNS/zlcLOaDB1HKyGvo5wCnLuw55keO6utmai4KkXziAOnK/a18IAh4M7JL3lSOvfC0uxksg=
Received: from BYAPR02CA0052.namprd02.prod.outlook.com (2603:10b6:a03:54::29)
 by MWHPR0201MB3516.namprd02.prod.outlook.com (2603:10b6:301:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 07:07:09 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BYAPR02CA0052.outlook.office365.com
 (2603:10b6:a03:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.22 via Frontend
 Transport; Thu, 16 Aug 2018 07:07:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 07:07:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50223 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCN3-0007Hp-Ly; Thu, 16 Aug 2018 00:07:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMy-0000y9-H2; Thu, 16 Aug 2018 00:06:56 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7G76mNo005191;
        Thu, 16 Aug 2018 00:06:48 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jliang@xilinx.com>)
        id 1fqCMq-0000pj-Li; Thu, 16 Aug 2018 00:06:48 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <rajan.vaja@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH 7/7] Documentation: devicetree: Add Xilinx R5 rproc binding
Date:   Thu, 16 Aug 2018 00:06:30 -0700
Message-ID: <1534403190-28523-8-git-send-email-jliang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(136003)(376002)(346002)(2980300002)(438002)(199004)(189003)(6666003)(16586007)(44832011)(316002)(36756003)(6636002)(110136005)(50226002)(2201001)(8936002)(106002)(2616005)(63266004)(126002)(426003)(5660300001)(9786002)(486006)(476003)(446003)(186003)(336012)(11346002)(26005)(77096007)(478600001)(356003)(305945005)(4326008)(50466002)(76176011)(47776003)(2906002)(8676002)(36386004)(54906003)(106466001)(48376002)(81156014)(81166006)(7696005)(51416003)(107886003)(14444005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3516;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT032;1:a0nqH3+byvMN515/O/WFX1UiDiMhVG9XWbowQ6fiR0Vn4f2GF6BklNGxi7MEPuT0OXWdzFDT0GTUwuiUT9wbhGiIS6GiL5wmy0yDrBYaSfhiLwjUUm7ogHX0eAOw/grE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe7677d-4d56-4995-a973-08d60346de03
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;3:l1wz0GY0HeqkM8iwhMlEVg3l5svyMKY4zML6YTXP+X3Eb71TmDST3F1EdGs0QFw1MLRTv18lT9ecVVGznfKWSnPq05ISikcBre4U6OVza90e3nbeSsqAPbTJy4SX3lNeayakghCSQD1LCMqnL8+240iLnk+yt+3TjT8pdU+vMTqEuQ+l7CoymZqmJEF/ewkNY86MBiIchQHmBxLnDKtH2Wq0lElkO6iRt+oPGrxNu1QY8fKccLVV0JSFF5EcnHVwox5WjYIWGBb9pn1r2RqAI1W3xCPHhrAQta1SABfys3cUDgrYdO9HrgImb66ONAxfmrW6e6PaovClLf6MTF2in9d88sNKWgHcyBwtdzJwuS8=;25:1OsMVhTrXjcAlcM5fja67N4s4tBHe/VP0FMDfenMaHQSrkp9urZ8nO8r+5By6IKPpEW748xXWu8cWwPeVdvTYxTH88E/aP5lzkagdWBm2BGXJwx/GT3xkuRPN9ZVfFpCuEc3ykVLasvNvdUKbXTn/m8AKnwqFHGJmIW0vlRTUg//W9FNR/gxle2au9LYnGHgkF5D2uPdOLtaYdCVEZpSZc9FtuLh6bo4fBknelvaEHCuNMrt6IB4+tjk+ZcXKjz3W9K0F4Dxmjc4QuE6vNCUajEIsyxctMxlfBtKjPWNUDOd6ZEDMKl9jQcG4zp/7R0IUa3w73N1AFLjx/AqwBSPvA==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3516:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;31:iCRR2rWMyVQKv0rZYKl5z88Kgrq6n3ufBCMUT9IGP4REKhzkxs6/c6ClqMTKUOY127nipLVTiV1EvKEDX4nVDPcDah0iN9NWttURW1hFdoLJfPZY4kGSZX+ZWdUe5ERkTmtnfQIRxp16K7n7QmLUx5ym4xDxesx979nNDvA51kO++H2cQ/NCQL2BOQw6LpebAocMWhkFBrNXNIMbSWInNNo1+O5FdIQ9tpTAGT8FaLA=;20:hvDZ3IoVIqVra9AxHmXxyvLG+c8wGv3YQbeUIWUiEMRA1AvYK0CmotF108C4NQ21RqRGJ+uxnG8lWy87ORJCrQyo0E7jFv8PAEnjX6/CkQz0fC4K7OlYbP5LCjF80l/lMgBX97OKlShnIMCYRQwamul+68uMOZZjZrcxamj1wcaw3yq72gBjKcpADAJMhzIDxLU/5UsKB0D0Q8ObPTdGkEDCipYeqMNlmwW0/L7QruApF3KVEtiXS97ilJeN44YXe8hw/3mbjFqOlvu0QCtyeQgipBridO6+kGEukYuTlqE330Ml6l+nc1UlotufH6SKr2jK+RcBD1MUP1pqQmXpEfSqQhZ88j5AGaUOeJArSlwUGs9qViRXNh//RfRU9RJ0LkvmQpyeVxd2GpruuYl5q/gT5taKzkVqmYRlpwihrRLvaJVfXBkdzrfRWh2ronTDrWoknpTso/CB8SD3GCzbZBxQZ/PtOsC/nPrbFm7iO6rpb5oa1Hpn+87LXtplm6eh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3516C42FE958DDAA341460ABB03E0@MWHPR0201MB3516.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR0201MB3516;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;4:IHNRkuwaS5PYd1UYPjSCrj7PE22n6KoNEJs5Ogaxfp31SwUcq07rYi2A1wuN4uEbOsT3uC/J83aOAGrdbgeEe4tBI6IVp+k+6necBqJO+K0ljcpLT72x75KJ0yYcoF0ZNE7BERrulXP06Sah+b81+QwLywdKFy7Lgxv+hIZpdxqCscrN+weRK+lEfu+EMWR1J1ULQkb3NjMcXvHWNKqsmLpLFnJ5hvXCa1Kev/s+oylgIWq7HrrGS85zE/IWJrGgagW9NTBe6vblafv8SepRMPjWqjFReH9TUApdUgagJsskM1O+0bYNJ/bRmSBU5v93
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3516;23:mWj2ffIHX2bg7f5LFMwoq5KNYQubHQW/cx1nh7X?=
 =?us-ascii?Q?jtElaQPqcD5VhtlFuWedTBSMdnCGx3uz1wXWthO7UGAXzjycaQg/yghXW/5N?=
 =?us-ascii?Q?xg8fdA38nmSRulUn6nsMQGwMXAR+FjQziwPZwhc2bYEdTgJiqMBNXi5ShI3T?=
 =?us-ascii?Q?orslzpSlATWEMmjj762N79H2ug4v4pUZkQv02hIggWMiPdYXMxHMpRXfVPfH?=
 =?us-ascii?Q?VU4yHEd9o93DzjqPRq33qOfVfXz09cuLAq89PV4aNUOnsSxvyDpIE3JhdhnZ?=
 =?us-ascii?Q?/i9dj+49xR6FDWyiZwRfzVGn7wL9cKvarY01D5Opn9OImfZBen6V668bqPzJ?=
 =?us-ascii?Q?sm1Bx6GsEz2MooQ6TJLcpNZG8Vz5sz7cnwiUvq2egyrCsyAzOmksEo2quNia?=
 =?us-ascii?Q?YdtTPuDShEAfqmU+Y+z81vPbToHq7w8+GCD5wsWSJdVTY2jUKDnSDBzozS2o?=
 =?us-ascii?Q?T1Jk4QeZvjQAMD2UM26+RB0huAP7ifC7ovPcBCXyVydpo67nignhy3CjjqFB?=
 =?us-ascii?Q?jAGa6PEA5lpMLp5z3scOw46aHKMSmNJykTKbHuVxjWNJjzyA46ldSv+GNyR6?=
 =?us-ascii?Q?yFRcfhBu4Oof9msMzZNOqW/h1vP1bKmqVzcJBxReDn4dDs72VWjcwMp6ZdQA?=
 =?us-ascii?Q?HTbER4uUY6upHnPPDwLfvld9NMB9MYcr+xcub6gi0oHYLuo/Q2i9fRK8RX6E?=
 =?us-ascii?Q?NAi5yNtshvunHKCIeL9bgLsZZwyUZ8gBHmGmlCR/+yLRZX1jdEEULye437i7?=
 =?us-ascii?Q?R08zAXAJHR772c13IegqHcZJ1+dL1XJfM4xDUn7GRf92iCkBsDV5RKWd0ewT?=
 =?us-ascii?Q?cZMP+gfNCroN5oEQFOQi5BVFGcRDVq14SC7WH6brlWdXTuEgGtgx8TTYVGvC?=
 =?us-ascii?Q?MVl71SGiNCAnZgCwrtjUXW+Cj97O2rR6AEm+daS8VwYd4n49kBTSnpT9CRgG?=
 =?us-ascii?Q?xrJzNfvNkGNpxVD6sh7VMmhNs9QcJ5ObaWDG2n3m/KED3GdugXIlG40K3BRr?=
 =?us-ascii?Q?WoTTpuEU2SkUCsc7a636Hw5rcQONd+e52csJF41OrDBVRT6kIxHBdqROjz77?=
 =?us-ascii?Q?Ry+PGdE2vs869IZ8KnExUsEKyjPLBtNOM63Xe58V+GFkPbtAkeaMqbeUScs1?=
 =?us-ascii?Q?216FsNhOnYx5edhltuLFF3D1/qnFKIYVFYnY5dNFH2Odl7dSl8ZsI8QoOO9T?=
 =?us-ascii?Q?w63xtRvmKFoMa4f3SecnQ7ww3I+EBnSUKgJGR?=
X-Microsoft-Antispam-Message-Info: eAtXDObg+IktWj+GgKLH2/IG+uzr1P7RjafDiAY5QUCil6YXVSCmuG3ksG0LVaOOOGIB8/qNGl+JVCW7oWonrpQgaV+9o2pt2EktHHtp/ORwQ+I/wsjq0tyk/9XXolJj33oBV0z+kKLJtudqJm/6htdJfjcm/+ErLIKN3R+co4E8+0bHrjqaYj68feMxvIm6liwriykZ3GsNf7wy8gI+T4WQ9KfSIfHMr0wcTon6vFlkfIseekUJBosS3dosxvFOxASHs0LmAm5FZyp73RXXT2ywVPBH6kJN6gkBUt2PtW2Xn5kqHOC7lAF0GeQoahbnVLhwHKdYnLN58zF33XhQGOqT6nb+dX/gdaR6wVZR4+4=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;6:7uqXCAyjJ7UV5PsHKTDXYn8Oa+aafsRVTsHKoy10fnfSuHm09muBDOaUr4nO12WTS+z/RytN/sCdywjSMdrGfk5TAUk0Oz/wy6E3VPnWrg6fn632a1GDakDwMuYEs+k5X2gZy1kMsyo2qyKba/jngJv7bC3v4VAkFdB6N+8qZe6N4HKHOjPrpBZKG1ybdblFvXuAvQcMajtaDEpz4iPTLn074IuMQ0ITATyRH1Ggmxc0O1T1GKnZQlXVaqbzbQDdbncgSoIoGkcoEk7UQeoFf9JjlDrAAD2IT+yE0fgWU5BJn0kmxPMHK838c9w44lm4+mKgTdOAm7/mWwTzJidVIVq5MeCeJ/8vnONcZjq804ugqYT8+1pRwOBVtHAj3Tp1GdFHWqxHiUYyVaSWFhueAgEXZFKinYSEmXdsEo2nOEMUfRviq/Vnk+/cioWIGgFM7ACx/DGFnW6f3DVsHXb8PQ==;5:VcFRgm7XORJ9mHrVVSM65yLqHuE6pM+qNMzxBJFhWlKvsbKpiY74S/MTIMyj651Yig+FBUwQtvCS2nkhH5pv80QrNPeLlZFDGxUtfUpIlPBYeiLVaeG7S+tZELdsqrVfnpLlHpx1wO4qbG5USZR8/YUMlaVVJ0HUE5AVLzeC650=;7:BtfwZ9GYa2z0Aszv3jgYquaxVdYjkE1e/9t15n7ryBX0XO3Vu065R7y/iGHzBacQBFLv+I8ejofZnVPiZwjcDvw0Z3gXA9HMjVnXUI0HdxNruXv+ueg1Y1yP+hNTu9OGMrmWni3LyxBv0nIU/GhGN3UYKeiZiRTEq1nAoAbz3mgFCQDnCwf6MAHevNruh4d/baVyhScHH3aIR6cyCzWh1de6eiTjcngjqVCY4zRU4HuVB0fR66xDQGYBvOM9lUs6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 07:07:02.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe7677d-4d56-4995-a973-08d60346de03
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for Xilinx Cortex-r5 remoteproc.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
new file mode 100644
index 0000000..3940019
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
@@ -0,0 +1,81 @@
+Xilinx ARM Cortex A53-R5 remoteproc driver
+==========================================
+
+ZynqMP family of devices use two Cortex R5 processors to help with various
+low power / real time tasks.
+
+This driver requires specific ZynqMP hardware design.
+
+ZynqMP R5 RemoteProc Device Node:
+=================================
+A zynqmp_r5_remoteproc device node is used to represent a R5 IP instance
+within ZynqMP SoC.
+
+Required properties:
+--------------------
+ - compatible : Should be "xlnx,zynqmp-r5-remoteproc-1.0"
+ - reg : Address and length of the register set for the device. It
+        contains in the same order as described reg-names
+ - reg-names: Contain the register set names.
+              "tcm_a" and "tcm_b" for TCM memories.
+              If the user uses the remoteproc driver with the RPMsg kernel
+              driver,"ipi" for the IPI register used to communicate with RPU
+              is also required.
+              Otherwise, if user only uses the remoteproc driver to boot RPU
+              firmware, "ipi" is not required.
+ - tcm-pnode-id: TCM resources power nodes IDs which are used to request TCM
+                 resources for the remoteproc driver to access.
+ - rpu-pnode-id : RPU power node id which is used by the remoteproc driver
+                  to start RPU or shut it down.
+
+Optional properties:
+--------------------
+ - core_conf : R5 core configuration (valid string - split0 or split1 or
+               lock-step), default is lock-step.
+ - memory-region: memories regions for RPU executable and DMA memory.
+ - interrupts : Interrupt mapping for remoteproc IPI. It is required if the
+                user uses the remoteproc driver with the RPMsg kernel driver.
+ - interrupt-parent : Phandle for the interrupt controller. It is required if
+                      the user uses the remoteproc driver with the RPMsg kernel
+                      kernel driver.
+
+Example:
+--------
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		rproc_0_fw_reserved: rproc@3ed000000 {
+			compatible = "rproc-prog-memory";
+			no-map;
+			reg = <0x0 0x3ed00000 0x0 0x40000>;
+		};
+		rproc_0_dma_reserved: rproc@3ed400000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0x0 0x3ed40000 0x0 0x80000>;
+		};
+	};
+
+	firmware {
+		zynqmp_firmware: zynqmp-firmware {
+			compatible = "xlnx,zynqmp-firmware";
+			method = "smc";
+		};
+	};
+
+	zynqmp-r5-remoteproc@0 {
+		compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
+		reg = <0x0 0xFFE00000 0x0 0x10000>,
+			<0x0 0xFFE20000 0x0 0x10000>,
+			<0x0 0xff340000 0x0 0x100>;
+		reg-names = "tcm_a", "tcm_b", "ipi";
+		dma-ranges;
+		core_conf = "split0";
+		memory-region = <&rproc_0_fw_reserved>,
+				<&rproc_0_dma_reserved>;
+		tcm-pnode-id = <0xf>, <0x10>;
+		rpu-pnode-id = <0x7>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 29 4>;
+	} ;
-- 
2.7.4

