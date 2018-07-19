Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EDCECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3A20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ByvgSV6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB3A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeGSKsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:48:46 -0400
Received: from mail-co1nam03on0080.outbound.protection.outlook.com ([104.47.40.80]:6479
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbeGSKsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbvDZ9Y8yw96Bo/YU3wx3W1L6ygmGQte+JfmDqTqnBE=;
 b=ByvgSV6ItWQ0AZv/p2v67EukdzUp/NgU2VX3XDKIidH+0hNHxrrBumsOmxNjdriB//YeuLv9JdBLvGK1LwFLEpbR7qk23D0kHek820jduPPryz1vsjS06wQ1LebAK8U1a6aoEOjgaGyJ0L5DiD8QQltCDyi8S9DevRcMrm3XvmU=
Received: from MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24)
 by BY2PR0201MB1912.namprd02.prod.outlook.com (2a01:111:e400:58b6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Thu, 19 Jul
 2018 10:06:03 +0000
Received: from CY1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR02CA0014.outlook.office365.com
 (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 10:06:03 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT042.mail.protection.outlook.com (10.152.75.136) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 10:06:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5ow-0007dT-Of; Thu, 19 Jul 2018 03:06:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5or-0003wa-LY; Thu, 19 Jul 2018 03:05:57 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6JA5oQ9008708;
        Thu, 19 Jul 2018 03:05:51 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fg5ok-0003vc-Id; Thu, 19 Jul 2018 03:05:50 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id A998C1214FE; Thu, 19 Jul 2018 15:35:49 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <bp@alien8.de>, <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 0/4] EDAC: Enhancements to Synopsys EDAC driver
Date:   Thu, 19 Jul 2018 15:35:43 +0530
Message-ID: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(72206003)(486006)(103686004)(90966002)(48376002)(6266002)(47776003)(476003)(26005)(478600001)(107886003)(186003)(63266004)(36386004)(2616005)(126002)(106466001)(4326008)(44832011)(16586007)(52956003)(6346003)(8936002)(42186006)(316002)(2906002)(5660300001)(336012)(81166006)(81156014)(2201001)(50466002)(36756003)(426003)(6666003)(51416003)(356003)(305945005)(54906003)(50226002)(106002)(8676002)(110136005)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1912;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT042;1:KO7NsQe+HiVYsn4x5G4pLpMJNFN6Ua1fWM7t+RiwLQKA/TVUVDmc6xsuEVUy6H9hzMAyt/6NcsmIKYDSqyyPmuqDhxCXhyygFo5IcF1wiu+yfm86Lnap3BigX/M+EoTg
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e1c527-113d-4b30-4d29-08d5ed5f3c80
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR0201MB1912;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1912;3:pnn39GIUgLFoA53VnAlcxv/kFTjbdCP4g9RmdVwnlLuEBkbmWw8aT+bU3PKOfwY2pfoQLsHEhPfPUqxR9GEp0M9mgbb+nrFO8gqmrBADVnN+gMhsuE6NbW7IamCr53VO+6fHmMyxZK+IdnikE8NXu96KDjJ2ab/NB7PjwXIXIvT+VERttvLX/dJaisyX4jPBKVxLWFk1/3PD1IdYeJqtXQvvQlvwiWgfX+jqGY1TqsdYkDtt+oW2hZm3UeVuu1RiiUm1ZUGiNxnpvb8tOegr8CaTi1xbczGVLblFGVpXMKJSZs2UGRZVl21KClctmxE05dIvJBMpBtEg6gbn1kESQWdbCvIJ9iDWj0hZUTMkD2s=;25:RzA2JIvDaEhNK5rIHG9gUeXgGklsXMZIYabWItDuwnoTnVnBj/1WzH3rnbELZRgZKkklIYTtDa09nuxKcDTZKFBZoHHMp7YI/FgIeLD5ob60t1QNXzh7cryVGF8nkmyhmzi9WgpmgSJaaXiFm/uu2KVfbjadLY2xaVBocyR1vx3XeJ69tpnLseSu6PVf3yGa+vPjUEryXi8Dxh+MIcYWGhl6HhpudFEACP1dvVtd4FeUcIP0QvOgT89gaXgbVCZ6XFNLMlmqgshi3bV+50knkEiYlQ+9Yu/rvkxruoql3Zff7LpL6aJJSHN+BqndfLRpI/OpskHlEHRnobWlZPCVPw==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1912:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1912;31:cPou9wkb/xWBCL3th7qAN5ZWcetjTHDYx0hVDlM4XQYRJy7xWYSudZbKOFXZZ27D37puzJBdmiVNohTAMA5oi/qwl0ls9XEo4fg0bY/r5Vsz0vXQSHR3JEVjyVPEX9LneM3e83WCKdt3f/RHQjutSxHCUjFUXpl2V2CbM56IpyUF2RUpNjbf+S4sa9x62YLkD5BEDR8+QwogDIaKPQVdGJCSS2WrBKJrSmripSAII0k=;20:1cFbEimU8Tz0Us2G5ZBGaw0o02yOhu2bxG+NujjqxXY+vtiB3ow1a1VAREy818qdVDlq/gMhdbiHedLPo+itX1GerOoRy2T1jGEPsi9K6MhwJ5HYthK5ydIWGGbh6gw8Hw2GKEdbK7VCRmYwiQ7McnYgAzeSkwZTNE+5FCYAE3Xi6lWm6KWcyW6f9bJMQs7crniC6aYUbotLAt6hCDc6FHGZWdedPkd9UHzNyVEAegLuqNF9q1b188VZgwlGxC4Wq+wZ19lTsLqbtzi6KFf6JwMm5GWXZbeqdgga/VrDbZ+r4dvTiQPl6YjSUf0pt76LYHS2IErAYLzgI0APB2ixHLxK63Px1jioM2JGuVKv6mCEtE+G2gXZ+5tO7jeRgFK2mdfGsy3zZvpgirS4bxP4TfVM9j4BOng5txXnKQjNnHtXHbTyxizb3HB6KEdYW4nJV93ae8SOGSCW25Dr/YMBjAPDh7ce/y6ReOk2avsSMzsj0G4AAJKYREFvdWvbitIh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1912B4E85C6E250DF245D7FBC1520@BY2PR0201MB1912.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR0201MB1912;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1912;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1912;4:lqypiJwDKBTYZNjP9nEnb0s0QhyyeemECk/Ed4DpiCYIY+i3kPOXFVRwCAVyaDDA2CX8/M97cvvnZfqcTtmwMnPOkzDw01tApbvtEfDRDVd9nMoRTk83za4c3f4nOFPHKk0Rq7YHegiEGSjxrkxfgL1m9YxJhc4reBkD1N7lbtRR8HHI9XGULEDDNxIqhGkqLoex+TpQSOFq/U7HBf6euhdoNqUh6w6xslQGlLfpvi4LpIfvgtGvnERLC+Dqx4zb9JaoT50vo4nod7ZmrHr5bA==
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1912;23:3ifCrOCekrDVHXJdKcTtB8GRFSo9SYDrgfhOdcX?=
 =?us-ascii?Q?KybMAqnpEIBi7hk6Lp5UyACZrmu8D//iuzKo5DKBVIIXFXczvFod1/ads31F?=
 =?us-ascii?Q?fWEy4qev8h/1c5qtqukKyfrGve96mUEg0ZJUrhd0dXH60N/RzOnFJiFzoKlL?=
 =?us-ascii?Q?xD8/tdHRC5YP27/oQ2uJyIfC/cirZkrEaofYGMik8zEVr+UslOcNDcvyfDFH?=
 =?us-ascii?Q?vdAenRUHSaBNNyaP+tjRkl0k5JsSu73PRVsfujo5CjbGY9C2WAI/ggw7l5C7?=
 =?us-ascii?Q?l0+O0GN7hLoT/H9ve+JCwxalZLzXGe/PxMpkdhhBYQr7bP+gk4G6rka1eM+2?=
 =?us-ascii?Q?Ia7jXp/6LLlzq4CTiNXiIktDmiV/A5kzifMcgxSP7YLxX1xDyzWKZdSNAuqY?=
 =?us-ascii?Q?QvZo4l766lFjR7R6LHnBVkBn9OPI0g+qy2ME+iiyxiHmWE9U7Xvaq9MVmTxr?=
 =?us-ascii?Q?8QzIyQtLf//ie/lrFERYKnlDY+nqOtYqQIXm/y8Zx76LsFNlV5aRhypINIgb?=
 =?us-ascii?Q?rQC9uRBJA+WcbAC44l2dGPlLO2zf9jKA9Dmw15OhM+1qUxxKJ4EKQqvLvY2C?=
 =?us-ascii?Q?gYfYMkSXrO0+TloBjgKDJxmDaQGxdxA+pevnrEJERg0QSwdZY8ukLj34qMuh?=
 =?us-ascii?Q?5UJ6dbo5s4VBdN7l4NGx2O3hrx4zcRo8GDlI0n0QqhIpodUnaGSsYqfEY1TX?=
 =?us-ascii?Q?9iF6tTbFFUXzF1KmZsVZ91fPyT8Zy1sWAFzNB3Q5pBzzTCYYkTkiQwOivgSl?=
 =?us-ascii?Q?8Hr2EfGDBIAj84CZYcOPaRailFuN7si4/+2h/4XH2fEO39DETbDfY+/ow38u?=
 =?us-ascii?Q?nOvlZfaTmaBD8iIbkDImtM9mhASGbYQHI7JH35L2fNNN9+/KMdK4kwWB480M?=
 =?us-ascii?Q?kyZ9BolTd0491DYNAmfjsq2oSMLr6uXGNkrPEhbjav4oT1q9m8zTEG9AmWbW?=
 =?us-ascii?Q?9YBOpMw/kyAkZzBIJ5ci0tc19adft7nwX21FhkUQ24yb4d7bzD0gUs6Z/Lan?=
 =?us-ascii?Q?8hOcUCm8cF9bkbfl/H3kU8eZ46XPnxVnC0YnXxPZQ3AXMRzEwWtM5n/ziqYW?=
 =?us-ascii?Q?TXh5k7KwWrsuMBAFbJyuckiIF7BmtfpNkjiJ8oUkA+E2/mZbRMmO3gXNiqlP?=
 =?us-ascii?Q?jWI47Z8b0r46AoIkewSgnLgPSrJkhud5Byg9VsE6JrpHqjfsBqwu2zdLDhgm?=
 =?us-ascii?Q?OP1tbDTbY9YA4teI=3D?=
X-Microsoft-Antispam-Message-Info: gkiP/29tCemeCsms0RWt0M3a9jYXpRbA/v/hgrDYrcAxFNTB4jeEy2YZq6UJ3hm6NJC6RZ2TB2OI05A6+nSRbeJVHLtHQSPfXq2//ckENGKkL7pmJOVtZWTzyr5XbBVyQ4VfAaKnpUfx7dagsydOed0U800M5O6IIAdQWnxDmSyncK0Sta/IF7IT6vGgyJFF02Xh4+JCDAzDpbP+MHhUPEtrTTvxVqnLob7c7d3TLPmkKsvhqkKVAsNhAhHAFisk5mx6KFPIE3q0AvLaBxNvvVieC/QJ5MHp96c3YVD/QXP4vxxvb4G2OZuLJ+88IySeSfsD/1tW5K/T/1JTPSOrRvmt3esdpnh2VS55c4zxrvI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1912;6:VQB9UMQSAd6iTAGU1KSBAUzwvPh/rIkrztag8ko5KrU7mkBt5FC6pk0sk6b68RgwFybYi2P6YQE+nO9w9rVVP4gdzeqmwJjy6EjkyHqmOTzMLU+VFAiMji3ge+7XZ+uBA8E25q34j6gXAvefSU6OjqfjFsAwUMrNkp0vudKnbhTWk4wQCMeY2Ssb+K6paMnrePTTDrdbaJ+6Dw46Y8dwKTlvlVvmIZshcaFYCnXpqNFPPPvL2JsBLxyNXW4ivZgcC7CTEechodew0no9ZZ5CTvA1zGLrUxsZYnblAH6awJmMKx2rtTw1MAJPLf9uGI7J1y479PRCoSORnQknTm1XYVeCS0nCXTWnTIx7l4T6rQKV35Zaj6qT2N6DeElsYL0XjPkHIYKF7WCORiE9XkTt5BIKzmu4amsgYBNo9GoIROZfcCzuLq68S1H+0OJ6tgU5gNn1E54H+O9/Iozt9Cy3Fw==;5:IAjPbpXKgnMs7ke2PK0/ApXkuf5HvF7NFzJUN25aJnbpZBOmPfyRmNAIQN1OnUuCSUSYx4UcgMOhjoBZvnmdb3/IK7i6KbVETY07U9d9cSrbr3TMyYXMSyUklaQiqLCt10tTb5/aVrdY0N0GtXVsxVFdkeuSiMRR67YE3BDROrk=;24:9pBVO9gwdCc4HWPUgG71tF4XEQFSXlMeOlpcN5LmBITZlnKLVmTXZTyclc+v15FqZ1W0by/rqDK6Ipx6bXCY9w2xqzHcrIwgzjr22E3qo9g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1912;7:m36Bdk0piwnTpj35jtlDNaoQf0zFSrMHQKdzlcPwYs1sazDyr57ejI+TtXKMGkrez0/kUukCPP6vXQZb5kNYo9fljS00YPGZedHffr7gh72khe5wgaWA37kzI4QpbhYEdpy/r3iZibQdW7FsXJN4AKYtfk8ZDnDvB/FIuRR+ImbXhiilMpflwxXSR+mPb2oeE8xYawLWeh4rB7B9IysANv8ZLe6DvAlc7LI1+KJ2ek3fWe+jkKE5ZheACHwIdEPK
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:06:03.2229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e1c527-113d-4b30-4d29-08d5ed5f3c80
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the current EDAC driver to support different
platforms.This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Manish Narani (4):
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node

 .../bindings/memory-controllers/synopsys.txt       |  25 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 916 ++++++++++++++++++++-
 4 files changed, 918 insertions(+), 32 deletions(-)

-- 
2.1.1

