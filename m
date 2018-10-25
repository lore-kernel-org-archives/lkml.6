Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682F9C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2409C206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JLtlupb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2409C206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeJXQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:01:23 -0400
Received: from mail-eopbgr700053.outbound.protection.outlook.com ([40.107.70.53]:50544
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729296AbeJXQBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgYfi/MfkUFotxoK3xG/CSjRegvS2FQq84QOio8adQY=;
 b=JLtlupb79q8uDAwCWqFXRwwxa9cLd+GPJs8BEBPHiddB/jCT9qpKRT/CohVceDKu2S9ebOnildvhSgcdvkVgEbQHg6Sw5JF+18rV2QgSp04sBq62DSZgbHcZYLJF6iB2Bamxre9ct/bJyh2etFGUV3sNuxRtc1+yJoX9XJWVIck=
Received: from SN6PR02CA0030.namprd02.prod.outlook.com (2603:10b6:805:a2::43)
 by BYAPR02MB4327.namprd02.prod.outlook.com (2603:10b6:a03:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Wed, 24 Oct
 2018 07:34:24 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by SN6PR02CA0030.outlook.office365.com
 (2603:10b6:805:a2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.18 via Frontend
 Transport; Wed, 24 Oct 2018 07:34:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Wed, 24 Oct 2018 07:34:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgK-0007f2-2l; Wed, 24 Oct 2018 00:34:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgE-0005wG-Um; Wed, 24 Oct 2018 00:34:14 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9O7YCBE021779;
        Wed, 24 Oct 2018 00:34:12 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgB-0005vF-TQ; Wed, 24 Oct 2018 00:34:12 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v2 0/3] Add Bitstream configuration support for ZynqMP
Date:   Thu, 25 Oct 2018 13:02:03 +0530
Message-ID: <20181025073206.9264-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(8676002)(478600001)(2201001)(36756003)(63266004)(48376002)(426003)(50466002)(186003)(77096007)(26005)(6346003)(2616005)(336012)(81156014)(126002)(476003)(486006)(305945005)(36386004)(9786002)(50226002)(47776003)(8936002)(81166006)(16586007)(39060400002)(106466001)(1076002)(2906002)(316002)(5660300001)(7696005)(356004)(110136005)(106002)(51416003)(6666004)(921003)(107986001)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4327;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT037;1:hmaXRLC9uV7bOpkfO9RVadlkqla+rBzN8VOtKv7XAf5y2olQvHvMtwsu0T3/X8DMX2Ri5i9+ilxrFMREI486zyxAtYXcY7ggc79YqP2BmsdqV8QB6WCfrGbJmPZiuunL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53195721-bbde-454e-1ae8-08d639831eab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4327;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;3:d1/vmdpRen+q/qJ2Tft8cD86eWS6PTKpc2lBVAIO4/eFFWlq3dAYZNolEvoX1ClF3fgI8K2BWEyrZeWY3hnM+O9unzqehwn9arvj+7d1x+SA3uVNq50d66xQ6purgIaYgqwIwmFUXuvn+2ncUYuzBXjFFO956OgFoThzUv4fsqi7ePJq7kWKbN69Gj7zaHE4UYDlR87cZqcHZ3jTzCvoRphEM75bWEX3yUmwkXVIxta5PnYZQIRHQl6+YBpdBx3WB8KBE6gcGnQ4HBiuFpgVrxu3qbCevaUzUCkQsiHbi2XLi1GWXkPFpPP4P6Ql9verX+Ix31p6yIum+Fl+nqB4YaymOz/YGWMSW/CTLEzzLs4=;25:RVlIgG5gpkJmPNnpOz7vjC+ABYs+zfEJ6udMaZrWPP5yXZsLSCDCA4KRbjmIGuEF9DuxcMzn+RmXE3cZ/OL3BTZGh8i3gTi7s/QSCuw3UtfN4+9irnMRff465j6XU1vDJHMjrk5hLq0yQJv176rDdnHyXt79z/TYYJoVdlKTomXg8kXdEXpmsZt15d9TvpdSZT/Pyl4aYuE4/kQSKTROyOhzHfwts2zGyosH9ZvNathXcABuW2lGMuEKW0rZ+f/EPWmkwWdLiBVkVys5vTOnA2OVDKQ9KAMFPRGN5FMbAIc7OlInYVLS8vRK4JFMBBjv9hO5kWYfUojXNd+m9wXAew==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4327:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;31:Jp3okhnCmOFm0K3jRLi42pZFuqqljJjALYf2tFmSY0cRKXkqw4x3UzyC6AKVgcrYBtyGQ4u2pYI0VukvAcqlyoJtezPowwv2qn7Ry9Es7e/v0Dq/bdbkgfybndg3xucjrPnxP/NPnHgOuvGO3O27IWS101lHGIx8Xap3DfL4E0mkPQFjTEM/wokclRPqbRsf0WNk/ZdkfbtwoVnPKIa0MM3UalfjTRq0K0C1B2HduD8=;20:fJaYOmCWN3iz/G9CeJv7UWgettawvV8WntPyz+cY8xSE+VTzr63/XOIaZCXekZKUIfgCdw2wt4a3lVKNIC+RNzuNFTrwCawMj3/wnX69No43ojOFzPs4VEupuG8t+7aQh4i23PXPZubTyHA15htbSM6R1cHi29kBdNgKh9MBXxWjT32nix0l1wCw98jY9e1jOkf9iOXEhqnN2AAD0mvLzLNpCcnlaset0JoC9BqyGd8ejLE+/noCcqq+qFapJB00Y+FZelH5unCBs7FGDn+pSJDIiqEwcJarPoX61ysbS4I8K7pKpzJgWgHyYapM12urULYiVNh5XP1bUY1H56q8G4EVT8rU0j4pGq98acWmufsiOE1zuQyjq8T0n34ob4ZAbtCMoRjLCFRmg2iyd/RZ6GweJ7eWM8ZdzSzQ6qobdgKhdTSV5TzZXUREBBCyL5Sz9wjcM7mrlKmFeuZYqxGhhtq056VHbitFP9odtQvtm/N2Z7fPWwk2zf9hwYA5Tzgm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4327B05AE24276E917FDE59FC2F60@BYAPR02MB4327.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4327;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4327;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;4:VZdu79wA7bLHDd786TkD0gtl7WTCnFytzVqPFkUckT9xvWLxZj0e9tGsfF1m9KG/nXVdhTyBWAxR+aBbB/C/1c0hs8eRu4H6+KazHhIaH1UOc4m3e80XBTKlyUTOSImKN5fg0tjs+aqYBJ/wwfM2tb8Yrv8IDjCQfgoNQR8Z1yPSY8q7W2DRqBnJt9LE1I/1xabXgT0mK1uqDX79414pSxf9Ts4PnxuHm22LoiylukRljJtrkxJKov24vuIW6jn5+bSioisqTVbEIWmyCnZkvOO/RDWPnoynDAh/R35pE+f67UtBAGtMRMI4gT1avrPl
X-Forefront-PRVS: 083526BF8A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4327;23:1flVpmPXLjIYYGCSOZPbIJG5abDiyio0XRnRE5D4I?=
 =?us-ascii?Q?fwqlrjGMo6s8I6aJdUCJHYxDi7DlTypbBbL+VDxHuQb33VjhUfU7UavKLqfE?=
 =?us-ascii?Q?9JOZGmmLC63IfihJLNDHjWw4V59/xwWS9OaHacKkbFNpdydTCYALIoTGncV+?=
 =?us-ascii?Q?TGBp0hqdHMuey3Nr3m3fxuUC6h62ik5RPinCugDT0mCLdaLmr4J2faSPC69d?=
 =?us-ascii?Q?/nGlD2DmtjkLRYd+MXSVH4fMOL77FJKSZIOxo6gCctYQExJaFLHsaXNHkUDF?=
 =?us-ascii?Q?DdgCLAMhfW08h9fUEwBI7MCd3LaiP6bHLVYDI+sm7VdeNTEfQfbx7E28OAnj?=
 =?us-ascii?Q?u2DUznEMRHGWrHjNJYTSUf2aopKoB2i/SCWDu925BQ0y+q7TvHDMAW6K9X7Q?=
 =?us-ascii?Q?AYAIXEkByl1yDFAfJPaKAXdciBw56uIJPuF8p3ulcsA7REKjx4Fkt6PkTheh?=
 =?us-ascii?Q?TxxWMOZvyjjp46KG59o4h1CpPU4SbbfLVrxazhhpdlR/SQyarQ8T4xWiZ8Rv?=
 =?us-ascii?Q?2F6Md7J57MxswSZcjlc/ML4SdG+04TgZeIrn2cmJA2gz5LgWrIhTX0fi3G1f?=
 =?us-ascii?Q?/I3JvehOUdWIl1VhYfAFxhudv5Y5Z95QprBI1JFB/ZsFAY15kmw9cFzfDn+g?=
 =?us-ascii?Q?9daFJ+jOOLWTq4eXXeANu+ExDvr/vt0u9IX78iIPbRU6KYqHzgFqtT5h+z/x?=
 =?us-ascii?Q?TN1gD4gTZXcJfHGDGMVkiZbbXfgjV6NCld46lXKORAe8K3j9txFgTxbDYqJ8?=
 =?us-ascii?Q?n9lAvix5e/uSiidt8uUxXTIeRODZhsVm1SVWujeyLEtF1z+TtTppVs8bJmHG?=
 =?us-ascii?Q?5zCLWeViNXqPALrVUWp6X9VPjPjReVbFBeGdTH/52QFQw6Kc8L0C64jmhpJ7?=
 =?us-ascii?Q?su1dyO+xR15oA503C1xNWuFhjX0iu1F69jziTxHaSy7SThAWIrHdBrsK4G4+?=
 =?us-ascii?Q?bm4EE3chwn0krU1jxNAYQJ0Gv0BMRzNOGqMAvLmMTxbMy6NfQJfqQfxTBPvC?=
 =?us-ascii?Q?EFv6MXzij9OuhnmI3uZ48ZGTrqsF92o7QFN/3KIboh+v9qVPETJPhTRy+y7N?=
 =?us-ascii?Q?DESlgSPMPLOaxfj0gCJ+uoWjiNO1f4zPuaWatU18oa+9FFDEMZUJZlFSYBTR?=
 =?us-ascii?Q?a+pZx2333JIdKWzDfrJeENVFLLEUSGi?=
X-Microsoft-Antispam-Message-Info: 8IdkIesLGM68I3A0LKUV5RDA2pUB2MJfg1QxFGw71owIMVdikwQerZhwzuWj4sMaDufQXyID1nP2gy5PuYa6ajru4QW5XCUmgop/fLY9jhQZsVY1meQgmVjL43Pm0xPL9A/qLWU6fEBjJxCX4ucc7uMbC9f4jUuktTVmI0itBR4ROL71+qEkyMOqNzlQ0wrbCHjSyGBxnNRWokbPq1Xp7IiP5hJOgl2umJCt6X053v2Efu/kltc9s2J3WcNDEst0mFLOnWih8/WlGzk65bCN+Vvg5x1NpqyDeQxHYVpAdaOPg2Lpf+GMrCQoQrwYtIlJK4JrWI/Bzf65DZcdsdwi3v6wDzRK9+N1tvrzxxzrqPM=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;6:Z68WycOPUUBaqHq8gFyxuGwb21BYQpY2p8o9XWQPgsruagdz1ipDjxt4BO9mEErFr+rYlEi2s2YK0lLt/T0lJsy/aYX6VUJtNco8AJQydXSWUgaVd571pu/IGrn6Lv2YO8y3QcoiHOj+/ih4CNBFaCCGzANmln6fGPW6W2pg2XKyqjnF1nhiEj9gaZTrN7XChTaOBbtncToCmTHrcahTtJPDB5ZgrdAihWX7Bc740eiEdo7tUYBDtp63rNbWzxs2pRQDAsJni9yPERz8iO2/qv9kBJ/VNcIH3yGMvq2sg31HZGq6tyMF0yFb12bjo2O4w4jZ0/4Fh+TZJmErc8JBPLb4xBlg55s0Oy1NaQMIhVL2YFl0RCqPGMXSZn00XZr53F0hPHyohyFCNasdpecBl6VhJVcboSW3qkiFnfqjC+U7toNS6sN0YCRqtcacO6u4YAzjX+SllZuCsCxqQxgvaA==;5:UqqZPCABXH8GZuWXgERxwIuGltKwbRHN8+lRizgde/WTOASJMxZw8GfrS/1KJojYU7tI2n+7i8YryK4HDydD8BDigEF2k14RLBXBftHqfI2sXuxcvLaM+bGHisUWp9kDuzOuS+ul0pGNTdD/Oa2tcZh28OMHfhao4y13TLXZ0tM=;7:uCUzd8rXlOKm6wFNx7yBvJjLGIvvopHPkdrHvv2LPfbgVEt+fgOv/IjTpFNE+VnuASlZ44Vl/LeOb3w9Qp/yK7BXtW1onIxrbEoneZxVPu5a/vfRw3N1aYXhR4CZp2RzLiVz9tA+rvKZ/dHfpktBkW7jjrNQgygQqJ4tv1pMgCsFct6iTnSOhmZJgTsZ6D+WtQWpkdJ+uCMXMDS2++YPciRS7KfIP25ieltEigVTDFxk/fVqPWDbT1lq5XdkJ7Ki
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2018 07:34:20.8001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53195721-bbde-454e-1ae8-08d639831eab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below repo.
//git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
BRANCH: next/drivers. 

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  13 ++
 drivers/firmware/xilinx/zynqmp.c              |  46 +++++
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-fpga.c                    | 165 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  12 ++
 6 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.18.0

