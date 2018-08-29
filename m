Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21934C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71872083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TznlhlPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71872083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeH2SE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:04:57 -0400
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com ([104.47.32.75]:23616
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbeH2SE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRVGwIkXmu7fZk2rN+K47N2/cMdhmk2dYCENoZrCjxw=;
 b=TznlhlPHnZIaI5R5uvms8B7GJUmFwXRtnr8Rv5yOpSNcwlKrrPv0o0CRmGTUzt7VahHNSs3hh5AM+9pusP74LTJdbTb/sUHyFWgZtkdiRHq/eQ5Z5jEUAxL49vJedM6+LHtLZycXpx36irZR9i+DVlyOTx2aUc+cyED1Q0XTsVw=
Received: from BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30)
 by DM5PR02MB2682.namprd02.prod.outlook.com (2603:10b6:3:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Wed, 29 Aug
 2018 14:07:46 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BL0PR02CA0017.outlook.office365.com
 (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.15 via Frontend
 Transport; Wed, 29 Aug 2018 14:07:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 29 Aug 2018 14:07:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fv18K-0005ry-SV; Wed, 29 Aug 2018 07:07:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fv18F-0002hl-No; Wed, 29 Aug 2018 07:07:39 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7TE7UWQ016836;
        Wed, 29 Aug 2018 07:07:30 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fv186-0002h5-3h; Wed, 29 Aug 2018 07:07:30 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id B74D3604D4; Wed, 29 Aug 2018 19:37:28 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <vivek.gautam@codeaurora.org>
CC:     <v.anuragkumar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 0/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core 
Date:   Wed, 29 Aug 2018 19:37:26 +0530
Message-ID: <1535551648-29534-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(438002)(199004)(189003)(36756003)(39060400002)(16586007)(4326008)(103686004)(54906003)(316002)(110136005)(486006)(2616005)(476003)(126002)(106002)(426003)(50466002)(6346003)(478600001)(336012)(5660300001)(26005)(42186006)(186003)(48376002)(51416003)(4743002)(36386004)(106466001)(8936002)(6266002)(107886003)(52956003)(63266004)(90966002)(8676002)(81156014)(356003)(47776003)(305945005)(81166006)(50226002)(2906002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2682;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT036;1:ZBIZUquOTjwjuLJQn9nRIkyzF+HzNp2SoVdv1WhbubUgxLcGVp9NNWpqr2E88kX3KloX73i/bWb3+ZDtxeCRW5P9PrMZS1Yl0M9QShxdQoM7gAa9fCtWGf3243DfjO+f
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 001f15e7-1fa1-4d16-652b-08d60db8cb5e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;3:eXpZplWOZDMjc3Az1c522qA2KLwrhJYf5uvLGAJa4kzlUv2ReBd485CqMqvKtATnW3Vbguik23k1dXylpCUddzW7RqYrCmeVwMy5/aWj1GrC4pOxvy105KteuWH8Y85BzRNQjUPBrb6eN5uzEdMjS/kwVbJZx4/DPF7S//vnw8bP2T0IBd5eLIksxqbWvpJn/VWxsxFHyjcXD+/HGtLr4LhYReOFL3RTcpFNFpyWWwbInCFCMJXeJdR7/9vPJh+UEM0CmNQeau/ed8PFm2YmIbDsuJm/kt8xvCgKlgm+wr95C+XOJI2NJcgqHaL0MGyA+/ghIFz2UI3J2IvdfSOSjzbpVAYOMCKCJvjeYvDz/Q8=;25:SG40subrFZBiH1k8N7pI3iyM7StPk4fbqJr7GxlD4M2Wox5r+1mYDTaHufJYmOJ9Mqaz+ptvsfGi+HgrFbRO/dbgE6gsA1B6OC9LJCi5/Utd4cAlBfXIwBXRd3QOwiV42JmhkFXzIOHBikMJReCVF3rintywmgqVPU30MHHVJSQ43yL0jVBfqYCK3BwtdYsa3w82IsLYVs2ske41bK1BLA7gNoZe4+O6evgsJ+LwA+jBtlDBvMNYs4U6TVowoZ7xl7h4T22S9rb9pGt+CzXOrumEXcLVwXACNLFMrMhVKa5CDnKc3FD8CJKOH/Vzz/XuRfqwjooRKL60LTg2qLRpXQ==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;31:TV77JKyBqkeh24UN3hyankqoKbF0J4v0uVBxI+hSvx/37Ke4NHHiJwI1wB3PElLJxSil8FzEmcGjFIyLqsLPKnQ6aXx4tuvu/CfsvNUoaY+37eBoXaqIjjBPwJ4Fky/kriH967wAXGNYl0QV6+x2BpSuFbvlO6yg6ISTYl67YT7BB0asUpDTjB8DLpB+hRpTYh6FmW50s7rloflJj2IiAShEE3amkjGgVp5Cq1ouByQ=;20:E1GFDCl/9pVWfxnph7qPU81jrDsckyxdclBn/g3qUFGvCBuBs4NtBEJCqriyX9mX/LZYppevRtnloCA+A6Vh8E7FAGQmQ8T7czo55GQwAivOV/rR7BQmwf+kC2oj+4YFVhjyOlRdWiKsXNfUFlSPZb59wh0XuDR5GhRoWKn5J6ZY9Xi1GqLQ48VzwTRkpgQXBV3GxmRknpyyPbahBWFqufOpVxvXIsL5FFdcVMd+WIo1o7BlOM0W0KU6pX6RjtRTyxj5uKPTmiwPHfgv7XsHGe/eXKQ3f7MA80EHDeAsvqimj/CbXRv85qLkqikX9ex7muAjYgugUylhiA+OxAe2bm6NRmPvItYwp/UALGE/mx51f1Bia8EdAHzgVObNXrbydllC3aJAj7gaBGjnyOyYc3GrNJuy4lfAMy8S08pTBrEoibW9bU4B7OyNzxMPMjkd6APTdGSvall3GpsyGjemQ4NXb0WfMehA2/IHN/LgkEZJZsk3qXL0nCCELYsWmP/3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2682EBDC4243B45E1646D2E4A7090@DM5PR02MB2682.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DM5PR02MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;4:SIdrdo9aowaWouCTiWjitbfa+d+R95vFMfQ9n/E4KERRmRGSMUooNygEuUgyGqclar+YAbhrnWIpjyl2sQzjxLfo+4fSmF3KLYXEjz078QRkXZIag/xWhumFZ9P/rlJAL5kNXk89vxebOpT9V6trGqqF63R68JCaYzcT4DoJkFJ+344LfJoiTqdwBi5tUF/l4ABK9KrgIFk5bm/WFmM0vcaSqJict82bH2c/JYf0ABK3IXESDiPgFZ5h4f0wUilUMcXJq4VjGwTiy0GlfkXz8w==
X-Forefront-PRVS: 077929D941
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2682;23:N1INRupjn8bmfY43T8xlxq8Gcbec965tk3rNEulDT?=
 =?us-ascii?Q?46rsL6OqD0fDMC8YchEHqWYoLC9Hpr3sSgScBqCW/unB0DfP1qW5RLIh2kaM?=
 =?us-ascii?Q?jNIeeLi25SMaCnC9I8znyjnLk39wF+HDihry2cEIvjgtGuxUYqWRaRRKfHhT?=
 =?us-ascii?Q?aYd2yeKTuebu7e1GJDfeF+gAywo6o7rmKJR3RhoESbzD3caH2OJvsqJP9rPM?=
 =?us-ascii?Q?4Bwwd7ki4STwvbiqkZ5loCzWlux/8j5lF8xw/rqbcWdy5sMY1a5LfWTSIJvI?=
 =?us-ascii?Q?1UgvNr11jdibyVAAv03S/3ViWSkUYklkZNvB+vsK+3248sR0oXCUyu3PmiCA?=
 =?us-ascii?Q?5UFtmD+X/xltGSfLgLZIxLYinvLXuLIquPp28E5bX+em23pTI7i3w5JiUv0n?=
 =?us-ascii?Q?1UQX0E0xDkpgm8/RGs3pqfTjP42vjSKlDz3PrvRP4E0TKILDQBOEe1+WPapB?=
 =?us-ascii?Q?AtNwz/r0LAhPZDNfg7Bx1+S1oNCdIY3Ge6LCwqCjpim1z8L2Vrst5r4g9oZy?=
 =?us-ascii?Q?QyZREeobtu61FH0DxwVXd3bbxUoBNBYGfXWEVN9JIgVPSBxCE6QHkR286hNw?=
 =?us-ascii?Q?qlg9fNSjwq1B/SehWf0zMkdapsCj9lFTjPamRZqTtjDpNyUi9TcqsIWULivM?=
 =?us-ascii?Q?gLX4T4V/a55/pN3yRYU9582dyR6zuvxYI7R5xwCGoUdVZ0dmfqkZmC+7AGHh?=
 =?us-ascii?Q?xPl+mC8hgvCACuLhPgpoBThqASzIzUmAT7h94fMOnxgFf3FWKTvwX4ODwkZ9?=
 =?us-ascii?Q?vAO2qIsmZr3fj5dbW/DjTk9oFU5VSxuiMdVzX6m1BfZoPWGtcyK3ry2r2knw?=
 =?us-ascii?Q?sPy4JVUqqzPngPJhc1BuO/GIP+lXhRJvmNovNUR6XUR4aGAI5nEAl+bfV3xb?=
 =?us-ascii?Q?EPxtK4AWJZbw6aw8KoE4JaxJ+RLhY5B5bchZDpDyBUNwk60+uxi6daPB6dI9?=
 =?us-ascii?Q?0k+jislj4JjWCNEb2rbLK0HAXQll/Hz7UzcXXzWKf0Pog2iGDaJsIAlTgWnz?=
 =?us-ascii?Q?+NF5OhquRcz7v7DxCOrTr+PMrrmF5+GrGU/IZ1jWB5xfUGN1X2Ih80xWI2qP?=
 =?us-ascii?Q?2669JfBjbQtobYFPWV/Gbf9CCFxWIlIl16rtjCjpGcKxKXqE0X5LjENYMvzJ?=
 =?us-ascii?Q?ryt5FCj55hmLEN0jxmAl89ddqzWKfQP?=
X-Microsoft-Antispam-Message-Info: 7XCW0dpoHFNIgSAwXT0XV2QYPzqUdNDbln+J118QA+HxdZBz7dgqUrGDjwxAx5/C79zdrrpVZqppGNWiWXmEY6NRGV+y+/DFlhWonwlPO/XuRj/m3gSYDMkkg8solMSXWB3s8cG3ZKoKJlup4FYiPEbXhmi0rnsnf+xMYLT8sNeIWh4wiOZxlrO0DOCeMUJh4m33Tjor06jff2HTsp8cAgUdhSY4lhgX7XfLovL5C293YGTh8uXlX1kV5/zRSoWQMnCsH/k1bFFe3RAFnhrcinIiFxpsyrudD5Of9ZhsliYUuCyRoqD6wca0yyzpBQ9nqUyAJm0H5Id3y9SGM/3e2H6uf7gcwcq28zF5ISQRMxY=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;6:qY2gjDB6C0RFkTxgtoKVq9QCGLLzxDsGxxSUaxHC2OvncbciiSSw0WEMtKicjFzyu8iVK4/DRwq0IbGt0aF7Jhgat71JfDjaw7TBMFNmENI/BS4HlzwrGUWnMEGiZ2NXFwWdGFIKCyIMVtrI0mru39KsH8mbraZBPSg1poyJyrNcJcOpoGYHNBtzmdGe73XJ7MwHKlEEkjtAyNcr5JrB1zuI6Js+AlwKTlrQn56Q+h/vwrjQGN9MErtYwBqxygPWFVzFsmSfGGC95QkjUe+v4wMvM80Npr8AaffWqgW3zeJ5HlObu5Toa7YVkL3R70fT0G8M/IE2CyQlDcIduRqPF9vFafzt9Ej9C1HzoIK7lCuLZuuV0p3sU2K1P5YZamkkml4IX6z+Dlu54SBSdW4448BZOZeMONWlN52dRKPEBn8FIaxvk3HreVDnt2kR30ACAHEVp1SDeO3o4NhV2okeuw==;5:n8tPVueo6ZNQkynv0efoLotp+w0stzYSjZkOejDlPuYL/aPVTR9w2VtErnrF8iIEbSmq339h1adcMTll8yu11HCOUOXq7LuDsrBGYpCuqVQohTjhMyfCseOB+hvkA/51ly45+LGIPnZw1Sim9ClE6c1dKtPxI9a13SfTQdySkDg=;7:AC6k5NWAKxtr2ZAMoFvP0gCS+UqW/dMIx92fusQ+gJesd/G4u7ubV+EckOHdLo8HcUlPxFoAmg/hKEQo6Ziz5c2tsinURChwb/hyAioZ4sWNkeOJqVzUqV66v20ZhKUoj7vbf15IrccCiLZ4RgihUPK7YPyglOiqDIBMBkIq2O1LjOh7yqG2qCPEyQFR92ldHimKpqe86Zl11jmq5hmoO9ULLq/kod2ziJfSomTgb0IEMedibSqi/uvE8eowBMO2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 14:07:45.3327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001f15e7-1fa1-4d16-652b-08d60db8cb5e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP serial input output unit (SIOU) is a high-speed serial interface block
that acts as a phy interface for the PCIe, USB 3.0, DisplayPort, SATA, and
Ethernet controllers. These controllers use any one among the available four
multigigabit transceivers for high-speed communication with their link partners
outside the SOC

ZynqMP SIOU supports multiple protocols working at different reference clock
frequencies to operate simultaneously. Each of the four lanes will be having
a dedicated PLL associated which generates the desired frequency required by
the protocol configured based on the reference clock input given. Using this
driver, user can select the desired reference clock frequency for each of
lane 0, lane 1, lane 2, and lane 3 respectively. Each lane can be programmed
to have its own reference clock or can share reference clock from its
neighboring lane, this is called as "Clock Sharing". This driver supports
clock sharing aswell.

These set of patches add support SIOU support by adding zynqmp-phy driver to
linux.

Anurag Kumar Vulisha (2):
  phy: zynqmp: Add phy driver for xilinx zynqmp phy core
  phy: zynqmp: Add dt bindings for ZynqMP phy

 .../devicetree/bindings/phy/phy-zynqmp.txt         |  104 ++
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-zynqmp.c                           | 1579 ++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |    2 +
 include/linux/phy/phy-zynqmp.h                     |   52 +
 6 files changed, 1746 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
 create mode 100644 drivers/phy/phy-zynqmp.c
 create mode 100644 include/linux/phy/phy-zynqmp.h

-- 
2.1.1

