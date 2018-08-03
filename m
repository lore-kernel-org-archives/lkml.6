Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9FFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143402177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PyH+SKJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143402177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeHCTvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:51:19 -0400
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:32368
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbeHCTvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY9q6XzlDsriWHdrcuaPTnv10bXo5ZNfFWWu1fIDmys=;
 b=PyH+SKJTMqScUwv89VJ+MKfI5lraVw6m7ZZJaAjG+waZ90iLQ2qG0TK7i9aZO39UB23PVtQihAh79ZiFpveFAM+dYBAHo3S4z0lBh8Ni6RBC6wQ3a6p/6zuC4FHVNmIGo6J9Jo1w7ca0jrwyjLfGOs777eDyc/yEo4wjaRkM+Y4=
Received: from MWHPR02CA0012.namprd02.prod.outlook.com (2603:10b6:300:4b::22)
 by DM5PR0201MB3511.namprd02.prod.outlook.com (2603:10b6:4:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.20; Fri, 3 Aug
 2018 17:53:54 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR02CA0012.outlook.office365.com
 (2603:10b6:300:4b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004fh-7w; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGp-0007cn-47; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-9X; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for device control
Date:   Fri, 3 Aug 2018 10:53:20 -0700
Message-ID: <1533318808-10781-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(107886003)(2201001)(39060400002)(106466001)(50226002)(217873002)(4326008)(9786002)(63266004)(77096007)(47776003)(5660300001)(26005)(110136005)(446003)(2906002)(426003)(50466002)(486006)(186003)(6666003)(305945005)(356003)(48376002)(336012)(316002)(81166006)(81156014)(76176011)(51416003)(106002)(8676002)(11346002)(2616005)(7696005)(476003)(126002)(72206003)(36386004)(36756003)(478600001)(16586007)(7416002)(44832011)(8936002)(54906003)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT044;1:gZGQQHUnCMARprb6H5I1+asn9Hsgw0Tnc287HYKOHfR5S/7U0ESoiGbRMZTznYI1DBXfcyO2cxS72IPUNBQGR1K2NyehQW9DMkwQObyeUsO50T0munQpAgbHuqKFiy3B
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01c19963-0a15-47c4-31f0-08d5f96a13ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:+ceyPEYBjP+JZt8oITNykf5abb8Ux+W3WBMnt4cjJfV/Gc2sIAD1tjtxO1S10Z1hs4B0J95XH2RFwsf80tyZzVGY+Km/vlAi18SyZsC8WqGhO7DJbUko9kKYmmebcalphvyjckHnt7iEEqWmRuDEIGmRj3/wrgX/K+B4YESCmXC95JP0qwcXjtH4oYi0MrGKBb4DND0q29uXRfxtDu3KozcVNgVPAFMLIKwcXD+fYVaSdYjpwHhlWeVblMtOLbMyRCUetfNN0PWYINGuirNmrcMvRLUtQ3Qa7KqEDkHNFPhXUhNHsV6rHY5kEzgKwMbEC16SvLWszVsxKnzpghMZ5NoO5jXZUKoltgQiWHWDoEs=;25:PZ2niHdLF57AVpNChi9dZLZkPq+V/5ucSJ/Quf+crUmpThSuPUIQWpfCVdvyZKB4udTh6VRmZubiJQjebz82WiBz1k7pc8jAzIpQTZQZQyvuHwPBkngHux3NQiOmkxvVEWMoccxLLMQkumlNHzF9NQ51S681D+Vbm3PceXXNSY0Jnyo476zgFM3c2pad8nFOSm1ysNv9vVu0v7U6YJva4o4IR0hLU6hcxqzk9250bzqHyBzcrFpJjE+U3Ie9kW0ek0EGFhxAIDTIPJ78PbfUFYQWoid2vidQ86QFpnVraC2hZc7XmCihB/NalxrUEA6b6v41svtAXsfr4FvWBWivjA==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:vBSqcixlCMiSiE+3CLXO0RYHMNFRPF3D4UWI/1Wtv+R33i2hUd+7nLRq3yGu9phGVFivIVojlEBBmjmseAGQWA8irZYSI+unUquot/j1wfFW6W0z0dzP6QDhF/H6jns2/OBQ4Cf2yCI+cjtMRb1oVsXMprEWntbPA6g5hY8PvPsqs6wAc/ruANZXoQHZNXPnsmt0hf+OldPwfw2USfOK6hawPJlSwLgcn3k0t5YQPvY=;20:UNMQ7s7RJ7vVmVKO+gTiugFJoU3WoiPlXyvr1zOdagfzaMtWMObgAcgifUB/s5kGfKlKHqmnIYIYpGGEF6GpKMtoF+NeBDxPtKO8E8Hy+q7PlJ1MWe8VgCFeDUiNDtCmJcpMJdgsNivOoY2Est/UYsMg/yeA8O3nrpRGTuvP7mErtS3AAfBitSNMyGLWSHdiNoQQqsQ0NmhYZaWu2C/6P43T3pXsWLMovP779/aVL1U5PUGFk4cJm+h44ivKFec/cpJuHzGHfpG6BWEPHZ0IfFG2DXFarUwVN66AbR3hiTBckEHRBzs9ZwK2GPVUxdI75M0E/OYhfBpWGphWlHyC9rtlNZW7um07DaaZ7+5QOTbbWXzMdxb0dK+kgXFWnZoEZNbdyLqDq27/HQyuNgr78egpZfh/eKg6js50jVBSVaZJu2fPoLBG2fcOjGhDw+joAmphB4u+wbFuClZa9fMlk+0sY4YZg8gl/5bQT6Lsfa+MRLpo5eHqIW0wnpRNcuO6
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35113DCF800C8F51851C2010B8230@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR0201MB3511;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:eo5MTD3N7roBUHJvekYRU3IvNUurdAwzI4Fya7jPE/rp01CBkRdE/xNWJxKFRg0G+gtllCV6ShNqZ4719ZlBYrgME8tfezNcQn0x3/wLcp4NrN/AyLx5K55FuJFRtNOOM05OdrEViU9wm1rY/F8zc5/S6XZEM7cyXJR3G4b7JCUqRsv9ZXDW+qM6MUrhvTRdiOUo6gN0d+F2FsyGgqV6GFwsbRH9pJKBuIqlS5/E3iZqxJynkjcIxK5sb0ooo5h/ghexaSxtX0EwoBjaDkx8z1TUE9vuGo96/0IOHbTV9Mj5iyIzofXMdwesDBoiFrjO
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3511;23:/r1QJbUB8a3/X2RQ2tiC952QbvGBAKqWP/IAKJZ?=
 =?us-ascii?Q?/D2MmjweQC7NCx4jBM5hAS3k9K6PTpXGQtJAPwpLygsj4hVPuTW/CW3AsPs7?=
 =?us-ascii?Q?YHM0ar51rBbg8KfuetOQx+5lip+bhTUS1NFonj9kxqc9GgYfGcJuO3NJ7GRe?=
 =?us-ascii?Q?TU55iBb1TWDzMJmHdfZolSVsB02BYKznCinyI6XCp2f6J/fSI6B94SYSs9mL?=
 =?us-ascii?Q?0Pqq6PnQfVMneTGlFEmMyBpLLzlkLBeKmbopVbjfwFmrZ4ozOU+SdRevrLFi?=
 =?us-ascii?Q?fZBeB4el23ikLIbxr5YM9euEZeVKK+YTyD1z38rPXteJNOuDz0wv2zdYNcLb?=
 =?us-ascii?Q?Q1IaAmotfb0ees3P/IqLBtLwCXlA5nWPyE6F8aO42XOPBGHs2BMGmwh8r9+R?=
 =?us-ascii?Q?kpLQK9IKPdliVjNsUnI1mO6+DBQHl/S3to8qZUtEm+0/xHMsdhhBqwHJVdtH?=
 =?us-ascii?Q?GeTtz1DDcjPlNMH0RM4/VJb/kyZJOYw3ThG/q1nQRWqQaQlTdnnOK2Gj7Z8Z?=
 =?us-ascii?Q?RKGpEGjTyVEnOColkCRPCgm2STpIGzJujet77vcNH4YKslzL0XjvDsP+g0Zv?=
 =?us-ascii?Q?LiEQ2u4RVE7sK2lqQMvAjojZi6NTwBk1diy883WUCzFwXjL3zA+qigRgmZxs?=
 =?us-ascii?Q?/KrAZQm7OMWV5YNDdxdRKpg52jb3XslwGp7afxN5C5NrcZ6aklBp2cdePPD8?=
 =?us-ascii?Q?IscBWvD9yQ7zJ9DEtYMmwASX4L7+dWgFynbfN9ey6azZb64QA411om3Lm/zf?=
 =?us-ascii?Q?xKbM/q3HAQnjlPWyKqr1GMaMA5iR9CExs2cj790lRBxGQ4CPPrnSiN6RlkSz?=
 =?us-ascii?Q?cbdE/jDeqi2QzLxDktgdLQJElzl74GA+/R7WTRkpB75spnXzgrFjr8nNz+VS?=
 =?us-ascii?Q?senBfvVUwqc7o05tA8K4Fx1JS6bLnYrzLoCm1rYfYiEXF+9pujH2xnil/7iG?=
 =?us-ascii?Q?nd3RMCCEGpS+tdF0vbqYiroP5eeM2SMIujaIoGzE67Ly7kK3F3Q6u5hmVGS+?=
 =?us-ascii?Q?qV6JMpjL/tdSdbj47IuIeAWHUUVL+j+poMBQcNeWVoPhh/T30cc0yZXnlMZs?=
 =?us-ascii?Q?yZvwzSJQ2JwKKZXVfHQkSBcof/j54Mp3Lr/8O/FmX2nCyYQbPJZen16VTak/?=
 =?us-ascii?Q?9CjJgkPaZ5CKWMql7QcmjZmbHPd7vJVMHrgtCfhrMCGXCsuJ1e7txqsOYcBY?=
 =?us-ascii?Q?of8+w60nfQZW4cJ7eICDXWQZDsolyctv8Zp+xgHW9oazR0k+e2UtXsGSJ8qr?=
 =?us-ascii?Q?QxhTv7CA7NPhMM2vCshhFJCN6avp/kyK/yjj6mGdz?=
X-Microsoft-Antispam-Message-Info: Ovciux+C+MzAlWIrO+/NzJYAt6zE4giyS5pWxJCLoAdwUZAJeHc8FE8ShFdLFVMnj4dqHjXhOOUZhoGrPcpoHdUBRLgqP2mYi3CHDKNboatVtztQwfVkOaRSu8rTFjsQ8QkO+XdOztS4ueWL2PUDiNJtZwJh47VrTtKvyo6U0wYuVuAH+LhjnGftW1y8D4qQkBeV9Kgp8EFEMK7xsziTnVRKOtZoBKd+2eW6inR5M1hFIWxiorr1WzaEAdsEd1qWgkY+qEjwIgY8FAUgzN3Xty0BUhB3o1iEvsI2LqCwPllO3ymOIOcm4PtchH1RwINKSZcazQTpiPpxh9Dyaw3j4VIwDcx/g6zh0fF8KbpFS4s=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:3jPHBmOPcVfhQC2FGyfi5sd8IXppoVO4oNCdaSltz8ulULMwrsTpkpdh0bIEVLlExei2T4TYqsC2696G2/k5+JGBN7Xi3Ovupmm4vfpixPXy4+Me/pJ3QleHHscDR8QiDVLQKsJblEl46k//cUF28AVYMam5dBmQktP6f3d/JwX0RAvW7MrsFezgLzVZ0HXoe4O1ltFYLDo5a87JQeshngA2YS9Wia2EY+EPnZlU7lHCNQ/KmkMrs7h2F6eT8z42trL7idsBvlz48P8PczW+qX7XlYCs93PRVNkMCIoyuCSdTQdsU9ifLpenSsKtkFxo/36QOkhMW5SFAHJvSUJQk9cgVRwGDAFOfyN9dClNtlO2NjdUts3oqJyQgYTzdtnodjDbiiYIFMTFIwsvBUqF1fqrrpvuyfovREm/CNq5Qa6bqYGEQ2N4GQbvW3ueRMomPMHb9frK77gRv85ksJAHxg==;5:Lp450hifZ/Nz7ZY/44/zL8XfBA6+yCopissF9iwagzjRuviDP6ENfU8WHJEuFEJvm17N5L2pRV37qzpfWakzkKlrQv3BME+CHHTAd80vqI9L3wJEmAYKDjwQOkuLt2Cu1r8X9tdbd9wsMTcCWcpVeCtUyB4YNPg1ZzcI+cAsSfk=;7:8cxczJaeYNhowMZfCrjvNeD+h4Q3sgGrLgQk/N/44XhFHYUEYQeL1O9WMRLvxgwyKcMuJylLfle2HlP+GAElAD+DD91Ec8SOfu3VphuaVYMl0tCKCi+vYpY8aLxBzRkY0lWJ6HG2Cscv0RCv+fOaiKbGQbAy7vJ6QdqjEbSMDP69U0Z3lY1uTVhLlFXhjzcqLGOFnjgthqa00FS1NeIkt0urZPaEqlomSJKBy4nLnSBwDZ+o0PnAAZdr2T7+gCgz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:52.7598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c19963-0a15-47c4-31f0-08d5f96a13ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index edbb84e..24cfd9e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -241,8 +241,28 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index cb63bed..2eec6e7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_IOCTL = 34,
 };
 
 /* PMU-FW return status codes */
@@ -49,6 +50,7 @@ enum pm_ret_status {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

