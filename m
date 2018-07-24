Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D98020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="F4jebwij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D98020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeGXPYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:24:45 -0400
Received: from mail-eopbgr720078.outbound.protection.outlook.com ([40.107.72.78]:43856
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388553AbeGXPYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANTBhagBtqHzmgOzh01sQhYySbQD4UUaqWElqp/WsDU=;
 b=F4jebwijQTcx+mjmLIuPATrU832vzgZO1sA+uoI3XevTZPvo7tMwivqdzVCZ1fb0l6IdxzAM937O/iAv014ahBnzqlb7PiKSeYYKhSvGcQutvD1gk6EYZ04A3DE/vioxU6ZwaZshHoG9Y7O4L3/FVQEjJKxmwhHhNioF0/kdemE=
Received: from MWHPR0201CA0052.namprd02.prod.outlook.com
 (2603:10b6:301:73::29) by CY1PR02MB1625.namprd02.prod.outlook.com
 (2a01:111:e400:5299::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Tue, 24 Jul
 2018 14:17:59 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0052.outlook.office365.com
 (2603:10b6:301:73::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 24 Jul 2018 14:17:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Tue, 24 Jul 2018 14:17:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53984 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fhy8T-0000Xc-UH; Tue, 24 Jul 2018 07:17:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fhy8O-0004O5-UP; Tue, 24 Jul 2018 07:17:52 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6OEHi16004201;
        Tue, 24 Jul 2018 07:17:44 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fhy8G-0004NT-3H; Tue, 24 Jul 2018 07:17:44 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <navam@xilinx.com>,
        <michals@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v3 1/2] fpga: fpga-mgr: Add readback support
Date:   Tue, 24 Jul 2018 19:47:37 +0530
Message-ID: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(438002)(199004)(189003)(186003)(356003)(6346003)(7696005)(106002)(8676002)(26005)(336012)(6666003)(51416003)(478600001)(81166006)(81156014)(47776003)(2906002)(8936002)(54906003)(36386004)(77096007)(110136005)(316002)(486006)(476003)(2616005)(16586007)(6636002)(2201001)(426003)(126002)(14444005)(305945005)(63266004)(50226002)(48376002)(106466001)(5660300001)(36756003)(50466002)(9786002)(4326008)(107886003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1625;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT060;1:n2+6du54LkCPJdPHiDhEgFZ0B9x80tUNY9GHw83vRLyqa8RSVjV1sUIzvVyhEH0GBeGIj5eUILRydoCVrFgqKpjVmEFq1zAEtDUbKIOABZtAIi7e9e0kRfRKaKYMctXI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41cd3443-aab8-44d0-270f-08d5f17041fe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR02MB1625;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;3:5s8fWJqOjQKm75dR+QddYcB4MDdZ6mB5ROCAW8puUHL0bisCwEGdUgKgMNZnnNQ8/V2WJQI3tal4zN+VtrfgLCxVBWgdtZnWLJ/oTzxJa9Mvo76QtGNiZt5U5qQpiV7SYMGGgoFU607o1chAQUo7or5yWLI2kosHGFPDAsvpMu4v+Yl3mSnKk4a3vWRjSwGafkBI8tQt/ejkP17TF2lyUmBQiIrth7Inu8CZep4iZyOZFlGa4IejemB5OeLKZa9HoLQmqqTlcFUTAjxJJWU3X92e/FU4JZJLSqlWcisIYjxRSygnT6BfE1C2LULSsdypInultLxEpTUFmOf3G7BSnGAhbhWaD4KYNR2UF9OV7zY=;25:6f6dyxexi6Nc2jNiAJU6m9U2mlxLfDriEkTwU+t11JS2MwbxykVomoV1fe/1cxOm0h9KzHuD5hj4yNexyTWeBtDXSSWxVKEQY9SGuZYGliuzROtqEWsfBje0fHI7+JaAGhc4x0LEf54mFBSo3z+j5PnW40WvpTPcSnIzfICBm2adwJv4kAvM+2MB4g+s+OA4xsiPDxQKQ8J9feWsIOSjMuSSyRFP4okFVaW6BYqnDaUDHeEGSAH/8vr4ig+fCQIbxCEhtBYsPEhI/kNDeC4ahJrAshC2rmnnfOTRXBJH/ddo/0AXoq27Apkf4VEu15SoYLmwkYSAOOVPDasuL/j2ww==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1625:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;31:OQ7cuHvqhKalaFJDgL0e+WMx54s60EzlNyDsmS192B2cRl7MOLJH1OiBreg+X6qDKDukt23bebvUwmZPP2ilBBTtOD45NrB6dQm2wPwubXtUMo1Jy62Mo9wf393JxlxGqjI47jpcXoktyiB4kK+D/KXPvsmfEJUvCl3yUrRP0ku0dY+dk+0QPMU3BRI1IXcZgHWpvKbCnhFQ7WTUJNPs0m3lcf330Grb06e4XU00jxg=;20:hdpDHNmIma3MyKzl7Cq5xjS4IsAq79hmhKjslo8FWtqYIjfwQ1JvFubpI4MimD59f+t4utefVsjI+O40ekhipN4TMNMm0FaerL/0WhTDW+XodjhqGZaSYstQMjT301k12Cbyk6wCSN4TjuixYnVmkYhS/8y/NhnoRgK7eLsFxepBaVfo+douCQbpquiy/S43kPJd97RoUs0+ehiXm6qPVboGzO6oZQ4ksu6iSSdGQ8gaQN0V4NsEsBOHa4YbhgBKgdpoB9OCQLyUzyPVRyBnaxhRTS/kp8ZUNFeyJnIAt2mnyDoUc0IZxxsMbT3jZM4q+BrTrfAtmpiSIe7pwqix6Q8FLQIg5dvkJ30hfQBhm9j3OGGfAYbO86G4yWJiAurhhlHFsaDCWVmaPCBn6btGEgyxnC9utqyhsTMVLBXLnVnXy+0+WdUKtamSTknCdsgWixZRIG6eDAZ8mL0kyh83T34UAmStbatOnZ5TD4SLv2i2bArFEeKUhI+9Ar4ZCImU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB1625DDC792D7B9B07904A582DC550@CY1PR02MB1625.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1625;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1625;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;4:VO6hrf2SV3JCmlgrKyrDS6Ki17kk+UqqLiO844tEm80ufhY1j0XTG4tBzAElpqKaS1dUB7i9181qUoV2agDXid30a9lTllavbjvJH5xnxPTk5wy93bQdTJltAlxmQmCkwB952uWI+t5ZCLQCRCb3W0OoxFa3cCc3LROCdBxUKOlzfL8vqgZ/szsv94iKbI/udSoWFymffs8d6IRbpumB9ZTuR6YFIPeNcegqx9XiSBEJeDKfz/r31T2v+EpCCCmMlidlc1iu+w1z1xCZzTfPcaMLsDCZmP4OL7UJzgBnsybUt0lSqABV5/P9YsSTrsHs
X-Forefront-PRVS: 0743E8D0A6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB1625;23:3aDIKyEPkbOqg/arMvNNkpLiL/KrUpc+6zGWr97gj?=
 =?us-ascii?Q?4EZjCTpwWVqM7wKB52/8TdlCFzgQdYqyscwDCIhmV9/filyVOMA7CZQg7/KK?=
 =?us-ascii?Q?stZcHwaxrv7Yeqq3eUkJ4y/WUT+zgqMtgGn87ufx0l8ZYqDHO0fIDDEB9QrN?=
 =?us-ascii?Q?DTlQrU1lZLh6qaoEFMx6ebjTqxsUIF1vKZrXJw3hb6GnEpN6kWnRou24J67E?=
 =?us-ascii?Q?D5Cy93uuWDq9V2azfJsIIrVWqGvumBlKRBr/Hklyq0iDg2lde7KXKGgxcEND?=
 =?us-ascii?Q?0dxmkQ4RBVnSKNi1hVgCmYyx7V8okos/yRInzkez6UHhgNzkrzDRpufaAv45?=
 =?us-ascii?Q?7x4PzqF1C9mMjv+uRdkAaEV/tHaSqxLD/jpXlzhFL4D9NxJvxcJEfSjDPADo?=
 =?us-ascii?Q?+NwodpntbfCEBJekBY+ZRFexMQHyXhvFMnM7UqV8USfftuornhSZcit1tVe2?=
 =?us-ascii?Q?mumPzUvpfdEejKdx/QTzvhERlxz2+m01mBqFJnhtld2gYhZ3UtFsuDk1R1IH?=
 =?us-ascii?Q?C8NgzyiAHpfnocpfAxr2UdiOasjQVFLbyO/EI6aXWmNutDqeobGZDBjEitVa?=
 =?us-ascii?Q?diZE+bdDtZLpn5S1TON6yQT8b+eFvr6KC3KCyJJ+Gcx/KsB/CBIC2i+hDKR5?=
 =?us-ascii?Q?DwWL56DlsCzqKBtt5hpMIJbfuQM++WYEwRCmA4aQXYP8XVydGOnx4ObnIOAf?=
 =?us-ascii?Q?ntn1HEDrQMAl0Rw+1YlsUJkEDhORZ3dzKqRI+gn50Yhi+ktJ1I+x/cSj7qST?=
 =?us-ascii?Q?6y3Qup+VFtV84N3cp515yy9zQocPH4/vxNNfd0cydQDDW7a2vm6W753CybOZ?=
 =?us-ascii?Q?wpH+HrGsH34cko6f7zmTvBmEVdmnDCQad29nAf63Rtjn3ohq8lXy7lbI6/p3?=
 =?us-ascii?Q?9QotfWXWcHMFp3rdgyXTnFJa3/8LMG530cl7DlcyVeA6/gx5IpMAlM+iPj1H?=
 =?us-ascii?Q?Qp94vyf43bTttvyZWMkH07xWK9XsOEy2lYf7uviycjQAagBW5C58L6kvKg+8?=
 =?us-ascii?Q?Gr0YZK6G06yGDnlZemJox9m9Kk2M0q72wzQsJvvvfN8Mbgag+2W+h24dCQCk?=
 =?us-ascii?Q?f29IOoqAB0eW5vEPrf3mwMLHpiqIhu8lbPk4Q5R91ii5hHWvzo0V6QmTXeci?=
 =?us-ascii?Q?Z4JD64Ma7vYssSgN2a/VR6hrmL3Io3YM/O0D7BihhPpCneuY3A0FA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8M7tiFgS3BrOYdiS6sv3hFEHT6ZzHGbAV2JVatJW4j8WUQhPwxqWqfgZ7R02UqWoI+pbDKplB7H93i7TWulD/tBSu7DdFxfnR5w43p6lVLxJ3y5c2r41xeCpb1BERSTRSAXU5KygbhZSyZBWIxmgmAxhCBKTf34OMA0hFfeRO7bGr4Eiu1UfigqEogpFVA0xS727SHa8PdRWj3Em3OEEh1Io1O2PFWcSpypUrstMW/RZwFe4dKS2mTeKr1XYDh2pnWmg2Hp4ytFAnhMLJuz7BcRXSDEsj11m054VtVQwW7iiOZtGb1RBCtSTp5MwkBMyAUoOXRYf+2hBVnKntjbJlzEjd94V51XCxcOjDBl2ySA=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;6:cE619fjASlonVUDWVqfymC3L/rLoCt8vGWK5FcbTxqE/5LTM3L9xz6zgiZExPPAm1BWnHFFl9FbEgGXIk/+AdkWf3w9g8KQjA/lJEaObcfFFsVzGNIAG4jikZX+KQn+Lg0t+Pb8kHrRBrNzekpsO+PHKmz5uXsRUq4sG99yFs4QAljNSqEIUK5pvQSa3rPB2oCmTlswoZLqsXxjaxszKKSjsFWa2QZaVJGFeV1SuHLGWrAiTn8Tf/mh6LJK/8YiWzrjPSBWtRE4m2RbWuw+mZIWg6kHrESMIMi81+QpWC08iHCPmgto17/R6+IZOIRVSFSO473Mv4MFKAvM7RPwoKW7LfCm3UmnFwQcMHrnGP288M6yhAP4/EPKkdN9/x+iSCf1jpPjcPL0ZHVCLZE9S8by9JjKY5Yre4ocnPuYBm1Z+0WGXy2wScU/EDjwd7UFQsYH6maZg0aInINlNKfVfGA==;5:8moIZxN79pvdT43xL56sZ7Os9RUTveLQg59yUVWPhIB62jC98gS3y5omnj2E4Pcrk3OkrAr4H5F7dUp1jlqLRhKC2wnWPDNTljsdxs5uhmuTSjL3Bef0WQgCjTUeoxDEk5tyuw8TDYJosQywZuIy/QOqJCJk4VIDnJRrNaw+x/s=;7:tnUd/baNnKTGuH2Fga7/9mnyRIi7sTUuQj6aztU2Erl2awvH/nWJVKVwop2qDdXPElvJnh4TIn9ydsygLLxIOGTSYqPfErp+kxSEZlSi0Be0sTX1VmWIb9sUpARYmKnGMblR07oRAyw39n3ZCVQy7cEMN5HQgqkGGgAv+4J6hCHveDkfJ93Ue3lobZgdVJ+ensGBwtx1DXqZFgMWcTJ84/ETaccNkVvtamzfl6UcpLbNTrEKAUXbP9NZc+TmPKRh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 14:17:58.4849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cd3443-aab8-44d0-270f-08d5f17041fe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1625
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

