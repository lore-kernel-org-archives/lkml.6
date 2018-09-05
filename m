Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D2C4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95819206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5clwIMgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95819206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeIDLtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:49:23 -0400
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:46560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbeIDLtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PBIMWfNeX/mFZgea99N6X7r84dc1lsrbFuRPhTSnBU=;
 b=5clwIMgZlh6R0orJQo65+If6iKvVxb2Mb5ShfTq8DQEh1q3e2G/NMUbqdtBhvBdUlxnlCXQDGDUkigvoet2OFGn79H3zBkYjC5M6S1kx3crpfIWzR9aCHu9w1AiiDNto1bURQGeF9njepPWzq9DKZDarSmrbBZWtQSaWVYLWMnQ=
Received: from MWHPR0201CA0005.namprd02.prod.outlook.com
 (2603:10b6:301:74::18) by DM2PR02MB511.namprd02.prod.outlook.com
 (2a01:111:e400:2422::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Tue, 4 Sep
 2018 07:25:12 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR0201CA0005.outlook.office365.com
 (2603:10b6:301:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.17 via Frontend
 Transport; Tue, 4 Sep 2018 07:25:11 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 07:25:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47692 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5i2-0001R5-QG; Tue, 04 Sep 2018 00:25:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5hx-0008B2-Lv; Tue, 04 Sep 2018 00:25:05 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w847Ow8E015605;
        Tue, 4 Sep 2018 00:24:59 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5hq-00086x-9p; Tue, 04 Sep 2018 00:24:58 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <atull@kernel.org>, <mdf@kernel.org>,
        <jollys@xilinx.com>, <sboyd@kernel.org>, <rajanv@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [RFC PATCH v2 0/3] Add Bitstream configuration support for ZynqMP
Date:   Wed, 5 Sep 2018 12:54:45 +0530
Message-ID: <20180905072448.12488-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(438002)(199004)(189003)(486006)(426003)(126002)(36756003)(106002)(478600001)(186003)(217873002)(77096007)(966005)(26005)(6666003)(50466002)(48376002)(47776003)(5660300001)(336012)(2201001)(2616005)(6346003)(2906002)(476003)(63266004)(7696005)(356003)(106466001)(305945005)(7416002)(4326008)(51416003)(1076002)(107886003)(39060400002)(36386004)(81166006)(81156014)(50226002)(316002)(110136005)(9786002)(16586007)(8936002)(6306002)(8676002)(921003)(107986001)(1121003)(5001870100001)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB511;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT046;1:I37LXS1tDs++BpgaRtSbkzlWIYedzlb2b8S/VL0FQKloR88Zh+pM793C2B7uWIVkb/JUrxeMgwhmSLLj0xTWWa56QeG1Ze4prlM5ItaOftkHtnBgBCioJyX/169J3Kc5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e72cf953-382d-434d-cb2c-08d612378cce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR02MB511;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;3:nPTPbZhlY7v+Df8dkVdsIHSbfoYkoPBZQrUn7X2rlk6d5BpIF9XQ1Df6VxLFItxxjmpV+4Mx5l9d6mSdkohBabwjukZTbyAUj2XAHJIFsImx+QdzFARI/9PFN8pUoqw6zUHhuL/YyqisNlD9xfwaT7I5EVF3LIdmzA0B1mOwcTedLqisltOjhmEuwpgcYIqxeLatP3yuR2gav2QrbiccLwCVJPSEdbnm7f1KET3oRn+x3jAhOUwIXLxRmBj+OMv4pnK0sGwFHvStksq5TDmWRa1M45fh7L8nCxaDE5HtcaAKvmxaScso247oJg/B1y35HbojHACsSjEnw8kr9s2dKjO+0abUl+BAaYVO+Txz1e0=;25:Fyoq10elR9ctltD5tfbay/chHvHwmZ8HGFv3x2Mukjvr9elEQrXu8Je11lRXop07/0+IHjBD2VFL7MRW/67y+FYY19jsnBp0GGW9jjnDWf6UWt/5iVbQaoRQmjaol1dGgzP7k1jZvUp0dDPOcUr73TUPQAD5I/OD1vm3Lv6hnPUs8wCrivDNZqbYP4NaEAphISnQWQNJ6uIygN0kvwJBrR52DbQDVupaeWTl4qqu2ugNCJbho8X19qnwV2UYd/EiccdnRaqBS0q3isfeBvPXV+ERp++n07J6Wqqf+Vi/ZcJKCvIA0Jgqw4sGBJY1tEOeoD5ASrMk9Q97XeONpMFfIg==
X-MS-TrafficTypeDiagnostic: DM2PR02MB511:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;31:vbkmMJQf2jx2DFPM+3xY+1evjw19//e1+3Qb/iHTxE7zBgEXIKjSIrevWmiD3LO+ezaZzF2cxQIwVSL1QXs284otUsO6lmZC7lpNCQyJ++tQDZ6rwCZFbIT+BRxYunqmtO37wnr+Yjj5zohRxVwHi8qf73lUBl38Olbr2Y3sWEYvN7Wpjuz4L1CnsHyvGAMYJIlIAno+Rt+93g4cmKs3Css38woGx5slSwu8RwxtonM=;20:og1DtD+QZTJNTJPhtZA/4JvhdXzgsc02ahQyOq3gttaU0dAk6aV2fVb44KCAjX13kpdBHHY7Lkmx9uSJJ6KXtT0nw7YrpQCNVUOEERPcP4pRdtlGeM2yBp2Vj7829ftBP/feGyug0z4ESo5gOYdjQLOhYDrAsHI9e9hf2S+XWq/bmbLZfiy+hVg5Qlv0xCsZPnhIwq/diqs/F5IMG3hYFgqIqzD/bBGk5vQ35IOZjizP/Etk8vzrCRqYs098DCm6bmij47K8js3dEns/GUXCVnJMkbLh9Ky4Wu8pvtjaZP6GF7DLP9yvp7ANcv7YIOZDSbcHro0Xf5jTSJI/cgtj+0SIH3s3bCH/exGNGDutlD4YKas6L86/D+XBdd3IUOrSyIeh7MQCjH8L3/fvGme+9j5sZCd6GWCvbEkzPw8dd4OAoJAFhJPgHxWp785Gpvx3PPL6TUcg9XNv4kIcw9fwbW0xyXVyok2/55f6jp4gR4i3/OFVRMpAXk6lmhMYSju9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR02MB5111FD43B9F220BC871CF7DC2030@DM2PR02MB511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:DM2PR02MB511;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB511;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;4:6tcSa0/PMq6S8JiQCiIARnHsiN9k6kzkr15JwumI06m73pxnxkUX7mmISCXkMYSKk3QbD6hWVJyS4u/OjWp3J4PaCROINwXCve2Q7fWinZ6C3ZvoDNCFpdtwBPEwNin4TT4h888rGwuUczExeKe9Q/Pir84PnwQLVnoNR2wA7hcNDzeLbU6p8uGQSk42l3Y/6ztLpCnPEkbwYm/WHO7V4bGGFGBsE+qpKfLrN1kzZrjCntNhbtgtm5x4pEzDIEm/Ip8Ej2AsOB3awMAbejbDXA==
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR02MB511;23:/Eo18BNx/OJr7BU0tBIUEXfxtvKBUKx1QZMg1D6UAt?=
 =?us-ascii?Q?TagKRCmcaILIAbLlF1a986m7D4MQBh66nQoOcY9Pt2+CqmLrmQgelwUUD8VO?=
 =?us-ascii?Q?n0aeE5AQy/SczSHYa+gyYLndetGjMeB1SEmYoMRHlLjLbvOU1TIunalXaqQJ?=
 =?us-ascii?Q?aAHXZhj75yqyNUzi35sMuCF4sukxl8A/Tq3qRJXxAej2p9KdZgrzDrzx/wDH?=
 =?us-ascii?Q?i7E2hqojh9RUmZ7HuuaPNNgTF3zeO2+90mM3l5m6Xv33KURA+Xz5fA8N3GPb?=
 =?us-ascii?Q?GQFfIuCWG5wfbkgksjrTQOZkYzEhNo7L004Q9kq9Z7XblJNV29Auf4Yn3hkG?=
 =?us-ascii?Q?OVdez594Q3LkWLYs/6XpJVdFHtfSWOb19Zc3CUKockUJsFlv0GlM9dMCJGWy?=
 =?us-ascii?Q?oJy0N7RrHgyX+zLrTFIjf46YUgTj9fP/jHHxyaAeRXCUG5ODhkn/8iNKf3nx?=
 =?us-ascii?Q?jg9Rq03BiATg1aR73lXsZo5brhHr5Azw9bKJHW6xHFLCuobiZg27BB70HV3I?=
 =?us-ascii?Q?gdJEcHSrfMGFSj/FXP0CGAl6YOR86Kc95cYU04JkjdKoyjYT/Bk/uGb+0gQG?=
 =?us-ascii?Q?ajsURyLkwxTFBqVV0aNY3GOzvu6jMGtF9o5Qc1qCA1ftmS3l3W+qRrL+h6ZH?=
 =?us-ascii?Q?twRR7g/jGc44OmGUepVFGglS4GYp9uPccE92DeXqVPzMuEKxe9aKk+KuCCz+?=
 =?us-ascii?Q?Cid+N4S4nqv5QyE1n0K0Bt64CENDTmnJQRff0cq/VZQ+afldvrJRMAWoxfeG?=
 =?us-ascii?Q?hxMszH/rynljmrgH5OZaALrDibBCQNT4xB32t4ZtAgkKk9B4SlWNL3h8OD3g?=
 =?us-ascii?Q?Awp1vpDDMDBkWyEj8qNLA15K8Tzbo3zW0MikvqHsTy2mSWMgwRKL+vcnzOmB?=
 =?us-ascii?Q?kdUN75PNBvjea8Cu6/B/IDF8VuEI+P3eXjMD0qB1Da69o886f31tXe3hKQqh?=
 =?us-ascii?Q?qK+/pEXC9EVePK6U7qfClHb0wiEULlpepm6GG2DMNia8hBYO5mNoMYdavhrr?=
 =?us-ascii?Q?TVB7z3emkHEuneZZ6Zf00ePwXHpSyD46v/zE6edblJiRuLct0G9AZAjL4r3t?=
 =?us-ascii?Q?SBvJ1e3Aj7DSDJsO/BxSCI2uYwBiIN/KKOcxOGj4YmNfgGEU0Bo0Rb36b2n4?=
 =?us-ascii?Q?m4qJc2p/HdaOaipLJ9he9QmSTXgsg34BS+4SZepv0ivat9o5/I+laPU4Y+/q?=
 =?us-ascii?Q?hdOMHKp88lNzFizHtEncSdWJidjRuW2NOWabfTWqr3vJwV5UQxxySLITn1dP?=
 =?us-ascii?Q?VVQlL3Q0SLGOwXI5N4jfHI8NGweru7T/4oKUVXDl7LyfgTNeCHg4YaDvYwZA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: NVzx0gxI/HFfoKIuwrXO0NVRgpKQc524/D/wRbABG48Npa5B3q+SDZGckGYkeX7bLrQ+FQXkvVzNjX4BN885QXahEOVfz+dsnwv/Ye93LDnbaY4yVSMX/SEtcsfo+LVnzM+LSRtKoZH0ycLJPIw19rnf/5NkeG6+nPrar9k+fJc0B9AyVkUJI/EF9jNOUAXdJIXD3ff6ftnQvLS71ePjh56Iz1MNyQM8FK/t8aXnBIJ5fcX3kPQj7ABW57zXIg2vCbnp3wfbWhXjOv+XA2IqEBWnNkTvqZlrXftMlMVZ6AOFlK80sis5fcVtPI/VAiC2io2RJUQMkhygMWdr6GrdKK83VipndnAI83Yedt85Rek=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;6:YtjTzQ6doNSDIH0pnQP0z15ZVgcJHxOXamShIzNmq8qqAZBXcdHqsqv3pi6fvlPf9Kr2pKRaVF7vJtrVFqFxc8PDiuLFjUF5n08nkb+Tu6w/U4Fwdxp6vvYjVMhVkD1o1Ix4rc1LSZ/YoBD9xwXRn4UoWssYAM0r6e0Kz1Aw7Cgw0lmbBaUKYb2gaMT0fOL/uLj/k7jm3h8XT4N/oBEbOHzbqJv85/5kITkrglvCQ0pH6SaAaZ3BHYsDiqQ/dW7ayNUIsb6f9f7YEPMZi2YfYFdH643xQGeldHd0UQSK9+ZpRG4ZONtxGoQ2jW7v+v6nQlkrwTfkYBvqd0b4epOM9bJlFX5uNHzKVNn0uW5H9U5WtX/RvVwdTbP/bfhu7f6fILElk7I2ri2EBb+lqNYD0Y01FI4gh10V0OKBMNP7xjpbTNfuTFaIvCC61CxYQTmzRd51dTG2JCKOsR8YQ4ktOQ==;5:1CMK+xTRE5L0Kjcj7BSKIddNfK9atRTeK0F2sSWZbe3MxGfy0yYRLewruUR33fOZtIwHLBd8Z2h87qGu0UMHZzEKFe8VyvJLqSDYs2VU6EchWe6h8k5DNzQlwgu9KQqRNwUjn3Jenb6mUs5CG8eGGW684Dv9fZnxB1DRzmS69TE=;7:bl5g/DaJySclrLgFft/2AEQurcz48xJ4yOm87K17yN2BCiO4xyTCpy9IZDLJml5k0kKt9G+7r7i7j3/1rrFM9zTwBSidQAMliuU/6FMAqbeE7BDyMjvy2Be2H41xEVeW7/4ViqMx3BQYOeRWRYWHWW9G1cXPhJSShJT2AJGzpiTUaA26S0zacG1u2aP439VTyFkoLl9NNqtUwUGXUhIpZn/3Gy7EKYdMs1cMmKxe5yuoOUvuqke8FAAVt7WBhMoc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 07:25:11.2492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e72cf953-382d-434d-cb2c-08d612378cce
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt  |  13 ++
 drivers/firmware/xilinx/zynqmp.c              |  46 +++++
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   4 +
 6 files changed, 232 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.18.0

