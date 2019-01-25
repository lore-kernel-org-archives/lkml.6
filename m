Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_FUTURE_24_48,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDE5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46745218A4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="D1BwIIDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfAXHqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:46:35 -0500
Received: from mail-eopbgr730073.outbound.protection.outlook.com ([40.107.73.73]:57949
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbfAXHqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJwXgWin8VvLhRCmB6C0/0GfD8TL5S6HaPiOpNCIn08=;
 b=D1BwIIDGldVwBIGPY5zZTiA7v3MCnM3HdapO1wwDQfvZU+gMSguO4UZ39AVY2mpnap4B/7FlEtfgCsQBVjThXV7/5VnIyhAa2Ew6YF3fnSPSrpNzutkcJWOVWUAkok7luy4UNfQ6N2ywAQAwc0jOHdCxWQOucBmPsa3seWdeq3E=
Received: from SN6PR02CA0033.namprd02.prod.outlook.com (2603:10b6:805:a2::46)
 by DM6PR02MB4331.namprd02.prod.outlook.com (2603:10b6:5:2a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.16; Thu, 24 Jan
 2019 07:46:31 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by SN6PR02CA0033.outlook.office365.com
 (2603:10b6:805:a2::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.16 via Frontend
 Transport; Thu, 24 Jan 2019 07:46:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Thu, 24 Jan 2019 07:46:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49028 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiV-0007f2-CR; Wed, 23 Jan 2019 23:46:27 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiQ-00071u-8R; Wed, 23 Jan 2019 23:46:22 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0O7kHtw028337;
        Wed, 23 Jan 2019 23:46:17 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiL-0006yr-5K; Wed, 23 Jan 2019 23:46:17 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP reset driver
Date:   Fri, 25 Jan 2019 13:16:53 +0530
Message-ID: <20190125074654.10950-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125074654.10950-1-nava.manne@xilinx.com>
References: <20190125074654.10950-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(199004)(189003)(48376002)(63266004)(7696005)(76176011)(39060400002)(1076003)(14444005)(50466002)(478600001)(47776003)(51416003)(336012)(9786002)(2906002)(486006)(8676002)(6666004)(356004)(81166006)(81156014)(11346002)(36756003)(316002)(16586007)(476003)(77096007)(110136005)(446003)(26005)(126002)(106002)(305945005)(2616005)(186003)(426003)(36386004)(50226002)(2201001)(106466001)(8936002)(107986001)(921003)(42866002)(83996005)(2101003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4331;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT014;1:qtSxNhF6vlixUA/5c4IZwzpAqm9zxyQQC/AsKrLFzuQuw7ZKMT5Td69IVtmlK3nQkzq/GzLeTeYKPPc45wTEyFbAKXpFM9xrfUg8i46iizSag9WFJh19OGCjm3h4r4jpBaU4PqHFU03OOaVbzXk7edOPI8pm09jNZsI7NdOGtKo=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6de092d-ccae-42f8-b3bc-08d681d00e16
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4331;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;3:aS8GQq98/+60LLiVtf2Cx6puWPsnSShzrszIa/p0xGRosr6TfJSuj4nw4qjy54p7sqeOirn6eyl4Ay+IvClzplA13+PxpnVz4KLPux5K2xKj9HU9QMPf6yGLlIxc3X38udtluSWqyPdNLRY4SmOUzTXHb79E9ypVN1EICa/CaAv8qzVO2aR2Ka/kV/fTprrBL7fFODOk3vXTe4G4vzDnFS3+zopt2H+NTlS5SIav8TtgqH7H5t7mzwaAJMxufdL5l1vMA+bLO8tE7eZ5OhWez5astux8ynA9dKwX9nfLd5iF6ann3iLFzd45az09/X/f87ctvS49BvXaJ9nXrW+bhAa1QoN+DRIGebHTq21FvlLSgiaTcNoAer5kkXV7faw7;25:3CeylflJNBZOrEz3zUJmyCtZ91oQoIqM0S5fXgV0Ll0RjyrCfZC+X9O2kW3LitdHLyzARx0QUqN/6U9kAu8CHL6AJ69jS9jlH/6R5OOh2KuaAGh2CEpWLA76h9ghh0fPViEpmlQzRrV3rxfM0qFSCLvLnhasIANQBw/Nb+Gqo2MXNZZMG86ERDLB/Z6tGyaxzYLiOSRtSFgOkoe3l7d8cTpAxnyEdxlkByKMoCuOIvukU0FHogMQtLjdpmdQjOjYpo5xaqghiueLSIbP3BVAn3uGAoVmKECNMBcj1MIHYSN+EZCqYvJ+MznyqmM+wT0zc5iTT0R/+nGxEhlaZOwVuQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4331:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;31:Oho2vVqpAMwo+UGHawm514CDyGWBUUWOWlw97sLauk9S6vpXDeIwytZgT+1eT1pTJv7h+QZZdIxQq392bhAoJPbWrZnxU5yn0mgEUGtE4DNrn3BN+HNrlGOPqHaww0IfcbicOaQMRbNRfBQTeDsYGsihmrFYigGZMR2Ld8XH3UAnyFh1Xa9MCout7gyerK7Mm2Ug+9H/olDOqaGowSU2Nv505QDFYP4UgqRehFkqm28=;20:B8UShwkuE/3KGN76VfrovIs2EyyBfSppfByPhaU23UbsnaUC2UT1CGX6PwXuE6YZBGOs9WlqJMZhU+hI62Yfgim+uZ3nsYgzAkIvGlE6D0l1ScGwBPPVP5S1yXw5NjXtTgJW4/O/VZkuj+lbXq90HspGb9qIIpelIc3Z6ZmwGtsDHNLfolAjXjC1u/9s8pI1bF96C9CxZVVztGcE0HQGsLbIW4PzbV95gjUhJx57DxvDs/20Rjs99Byhj9gpEKxzI9QDJ/SP9YX4Xw8TC8iO91uu9hsedg7YKLh8mau8JqvxgYnt1QpdsrdXpn2r4/0r1KOwMh+8XxYB+qA1350YNwPLDauV/CXGfQESV71zEeJ64+uz245jY1fbcMQkEeZizRUbQtLiAU7Ur8ROzvEM3kEjn1knkeJSy1QxTdV9v9oHP75YFYSpJG3S/UVseHVroXyIkPXQUGcNDer8fqnXQ8nRc2QYz0U7UIJGLaZfIuM9tF+GqN/0IR3qNi7VGB9B
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43315D9D17420F1EA8A0A78EC29A0@DM6PR02MB4331.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;4:BXdr1EUUvKQUxcV5l5ioLcA7/CWjadt5kFnA7H6mdsQRq+Jup7VxDImXh94KESimHeZO8YVgk0ZtwQf1dP7RBg05OVF3Xhp8/cUR8ymskz7bzJW8PlkOAa1GthYwRZYIErxN9eMTa9nNCqn3Pnnx8mcoOBEo0fAq4Ph5aonTZuUbObgJQJkcNOZ0/IFGp3r9zhUDL9cpu3rz810ynD4FDVLZjuUgnblNaUVvUqWxCdA9BtxCkfAqIXHbV4c798AqMnGBkHvKojHbOjXS07fyZLTiowu/tOzaB1KrqHj8p4iYTa/l15mz/hUsJDuhjPx5
X-Forefront-PRVS: 0927AA37C7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4331;23:EgI2OK+unmMMz+xQ1M7XiixlLEAEKMPl5mW20DdJ4?=
 =?us-ascii?Q?iZ6JRa0Nk1bbMfL1wUjjJlgsjLU0HFfMTedzgnvFt0gfiI2kajdEzdVLYanA?=
 =?us-ascii?Q?R1u7rbBlHQHEK8+cNt1kVjTAogflU/EroHlJaKL1Ps/tnJyVaTk/cqggNm3I?=
 =?us-ascii?Q?tymu3wv3WQLYWEZH2+zK6yAGOmxRae/Z+kw0VueOnYUyGsQr/eS4V/rxiXKS?=
 =?us-ascii?Q?hMcRVkxf95gcKwG6vdi1qF50ZIk8vBMDowqGzJkwEhyyjhW8ncW6fMoXbsZH?=
 =?us-ascii?Q?pbC4JCLcqnpPAuodV3uo3Vvz5RvcG3by2Xd/a4gp0wAPbAG673a5E1rLaLif?=
 =?us-ascii?Q?V6UYYx9wcYKoBb1s7ULbvgF5Ks974sG4kq4V2EqgsqMl8HfODgsCYqPscldO?=
 =?us-ascii?Q?87kkbgHE/iojLdQXIXHsZu7C5MaLdBeVpsWoOJjPKsKIRxdgE27/YZIWkDVx?=
 =?us-ascii?Q?r4R3wfcn7ge1Xwsz2svJNjgiVs0CLl8J6TFhSLwLvb8N5/WyyFfPHMFSXD7Y?=
 =?us-ascii?Q?Wt1DneFPiXJlNPu64snZdIZKFG2/R0RS6+9rxYnV3QgZ/oXQmWApyVpYVgfS?=
 =?us-ascii?Q?BHvARSk2+c8ExlryMcZC23WYzrppBScJuac0JC68gnZm9ww7vDZikhXqKtgn?=
 =?us-ascii?Q?6OHxpPMWI1YHWlPwHLiXaQNz624BKcSiKKtY4bvVb/3QJSqHBJGIv9pkBYg9?=
 =?us-ascii?Q?zTk2/elomEfUj25sewRXlsWjuUssetf5SCjMdLjJQVaCKmsKIVUw4blpVSo/?=
 =?us-ascii?Q?+ZgzBcj2gD4HgIBBYx1QFrl6oy54lFa/uZxmeXCejF9XDCJeSwvtcvef7jtT?=
 =?us-ascii?Q?CfmKLOJVotAmkex/Xkh6/OJx/OVtQphVX2tBUUCqBXAzy/LKOZQTkAGkEJwS?=
 =?us-ascii?Q?Gh/FRPWLBJkOoAcyR7ZrqmV26uOWvgw1uwaQh8Lda8QStUdL/xxjeq+YsrhM?=
 =?us-ascii?Q?oxWnxjM/eGodupx/dDmqCQDFasNTPK1Ws5W8PtwFhsIxYt8q0+NB0aNm/EvZ?=
 =?us-ascii?Q?ISq4YiiX+4+M7TjhuPzeMU5lb2tb/5GySv+g1KSMr3z3mngSrYJIXEvVQaAW?=
 =?us-ascii?Q?ArsVPHD1foUBZ/f1YD4TNVqD8tQZMj3TlNXFc7GKP8u5Fd1WdI646ULC1hIc?=
 =?us-ascii?Q?me9BLpN99V7RICHbjCyCkhCrzGWB4YdadPNQ3zvDwCqcoRkAHWbVF0ijRt74?=
 =?us-ascii?Q?ldXmcTyt40Px0K36xKIB3lowLfv7UkN8NnD?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: P77Wb8SsMy7gkh7cFuzz9cou5PzxM2CM7XiIL03PYXXz5rxd7E0YpLBXCaxJk0oZVt6d7SmkEg86UN4SKfTRicW2E02GHvE2CsuUgqJ54V/7K7HEqV0jdfoXy+4OMIkHVATzsOl9JXLoT1WGi+7c9YiSyQe/1BWCzzNfK014jBqojMroJ0f0h38aslIScX/AsSCrNGYJ7iSLWp9EPXcYwKT0z8uux9y0purnPEja1EHLhUG8lZ5CoGMin7PA7X/xOv3/68OD4goRWONEH8NwNfJgEDazS173pFG/bSGiZr6gh1Y/pO3m0rtCSL+O1fagdaigKewOfNDk+/jezcZuEYlhCiuPz/zJ6aE4rJAQB5WgyOtT6vnV4OP2Zatj40HxmhYvKAY2zWbUasxEEcKuCm0Et6YcI+oIN5FIuYeKdLQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;6:QaZQy9Rj5+NMo54SKYjx+bUy6+nSOdCzak3KsUzv9Y87Ug+viznX9+xh7uywCqOsfEpU3E8BDA8yVLeCmFfgedbla7GCvAQoCvxHLQGMwMyckjmvluQQOze16O96iEvyeKwOepCJ4PaFdQYEZ5vIlpy80afzx63nZLEmOh3UCi4PM6g3/DzWNTST53ZFxkT81HGZTYsJFPGDqCzxQi0XndpJGCrtHwsKMdn0mLalqB1+yoi2cF93t3nhp/jqAidKxmWYso8AJWR/69tofDP71VwtQQ0ywKv03BSQdhL7Bj9Ql4Z2T+lgjK02V/b9km5CTZ2VZjh539aSKkB9TZhVa12Pk/9SpPVuTZQsBSMM4sDn0Y3CLLGVgj+cHuLR2FBY9W13fKshts/6feafvpmR33C1O8Af0UXa3pIDOqXVNDulQkNiJ2xyveGqL80N2ejM80ujoxX6vvCfGlpsuO2E8g==;5:4/bUNgwp/mbX4zDk4lAwWKS5V/vjJvofUs0eyxu61yuqbB7nSo5zGOAf4WWeM08Anhdx1GAhEW8wMtLXM0Kq9k9VMPR490zsBSVYXvMJUgENtV7nZed+Gcp3qssXYk1YTa4X9h4uEJ74BhaCH/oE8vBsuDBSEtn0RrJ5HcI5eFqpjSTGFYSq7mbrkIOU/H6BWFYkDM0YjR5hge7jPU4mqg==;7:IHjlWI/1Nn98mtThR7chH5mTzMwOaVq5U7cCpgnGXO36xfFLXy1sgXsKIRdgp6/0/0RCdAzAsHUUpiNpYfKJhp3/DoVzO58y+9ifR3DcigiBG7qO4uTqoQQYWaTWRLJUcaQsdSnAVjDrgu5n1+lvpA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2019 07:46:28.2333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6de092d-ccae-42f8-b3bc-08d681d00e16
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 +++++++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 ++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
new file mode 100644
index 000000000000..27a45fe5ecf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
@@ -0,0 +1,52 @@
+--------------------------------------------------------------------------
+ =  Zynq UltraScale+ MPSoC reset driver binding =
+--------------------------------------------------------------------------
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible:	"xlnx,zynqmp-reset"
+- #reset-cells:	Specifies the number of cells needed to encode reset
+		line, should be 1
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		zynqmp_reset: reset-controller {
+			compatible = "xlnx,zynqmp-reset";
+			#reset-cells = <1>;
+		};
+	};
+};
+
+Specifying reset lines connected to IP modules
+==============================================
+
+Device nodes that need access to reset lines should
+specify them as a reset phandle in their corresponding node as
+specified in reset.txt.
+
+For list of all valid reset indicies see
+<dt-bindings/reset/xlnx-zynqmp-resets.h>
+
+Example:
+
+serdes: zynqmp_phy@fd400000 {
+	...
+
+	resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
+	reset-names = "sata_rst";
+
+	...
+};
diff --git a/include/dt-bindings/reset/xlnx-zynqmp-resets.h b/include/dt-bindings/reset/xlnx-zynqmp-resets.h
new file mode 100644
index 000000000000..d44525b9f8db
--- /dev/null
+++ b/include/dt-bindings/reset/xlnx-zynqmp-resets.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_RESETS_H
+#define _DT_BINDINGS_ZYNQMP_RESETS_H
+
+#define		ZYNQMP_RESET_PCIE_CFG		0
+#define		ZYNQMP_RESET_PCIE_BRIDGE	1
+#define		ZYNQMP_RESET_PCIE_CTRL		2
+#define		ZYNQMP_RESET_DP			3
+#define		ZYNQMP_RESET_SWDT_CRF		4
+#define		ZYNQMP_RESET_AFI_FM5		5
+#define		ZYNQMP_RESET_AFI_FM4		6
+#define		ZYNQMP_RESET_AFI_FM3		7
+#define		ZYNQMP_RESET_AFI_FM2		8
+#define		ZYNQMP_RESET_AFI_FM1		9
+#define		ZYNQMP_RESET_AFI_FM0		10
+#define		ZYNQMP_RESET_GDMA		11
+#define		ZYNQMP_RESET_GPU_PP1		12
+#define		ZYNQMP_RESET_GPU_PP0		13
+#define		ZYNQMP_RESET_GPU		14
+#define		ZYNQMP_RESET_GT			15
+#define		ZYNQMP_RESET_SATA		16
+#define		ZYNQMP_RESET_ACPU3_PWRON	17
+#define		ZYNQMP_RESET_ACPU2_PWRON	18
+#define		ZYNQMP_RESET_ACPU1_PWRON	19
+#define		ZYNQMP_RESET_ACPU0_PWRON	20
+#define		ZYNQMP_RESET_APU_L2		21
+#define		ZYNQMP_RESET_ACPU3		22
+#define		ZYNQMP_RESET_ACPU2		23
+#define		ZYNQMP_RESET_ACPU1		24
+#define		ZYNQMP_RESET_ACPU0		25
+#define		ZYNQMP_RESET_DDR		26
+#define		ZYNQMP_RESET_APM_FPD		27
+#define		ZYNQMP_RESET_SOFT		28
+#define		ZYNQMP_RESET_GEM0		29
+#define		ZYNQMP_RESET_GEM1		30
+#define		ZYNQMP_RESET_GEM2		31
+#define		ZYNQMP_RESET_GEM3		32
+#define		ZYNQMP_RESET_QSPI		33
+#define		ZYNQMP_RESET_UART0		34
+#define		ZYNQMP_RESET_UART1		35
+#define		ZYNQMP_RESET_SPI0		36
+#define		ZYNQMP_RESET_SPI1		37
+#define		ZYNQMP_RESET_SDIO0		38
+#define		ZYNQMP_RESET_SDIO1		39
+#define		ZYNQMP_RESET_CAN0		40
+#define		ZYNQMP_RESET_CAN1		41
+#define		ZYNQMP_RESET_I2C0		42
+#define		ZYNQMP_RESET_I2C1		43
+#define		ZYNQMP_RESET_TTC0		44
+#define		ZYNQMP_RESET_TTC1		45
+#define		ZYNQMP_RESET_TTC2		46
+#define		ZYNQMP_RESET_TTC3		47
+#define		ZYNQMP_RESET_SWDT_CRL		48
+#define		ZYNQMP_RESET_NAND		49
+#define		ZYNQMP_RESET_ADMA		50
+#define		ZYNQMP_RESET_GPIO		51
+#define		ZYNQMP_RESET_IOU_CC		52
+#define		ZYNQMP_RESET_TIMESTAMP		53
+#define		ZYNQMP_RESET_RPU_R50		54
+#define		ZYNQMP_RESET_RPU_R51		55
+#define		ZYNQMP_RESET_RPU_AMBA		56
+#define		ZYNQMP_RESET_OCM		57
+#define		ZYNQMP_RESET_RPU_PGE		58
+#define		ZYNQMP_RESET_USB0_CORERESET	59
+#define		ZYNQMP_RESET_USB1_CORERESET	60
+#define		ZYNQMP_RESET_USB0_HIBERRESET	61
+#define		ZYNQMP_RESET_USB1_HIBERRESET	62
+#define		ZYNQMP_RESET_USB0_APB		63
+#define		ZYNQMP_RESET_USB1_APB		64
+#define		ZYNQMP_RESET_IPI		65
+#define		ZYNQMP_RESET_APM_LPD		66
+#define		ZYNQMP_RESET_RTC		67
+#define		ZYNQMP_RESET_SYSMON		68
+#define		ZYNQMP_RESET_AFI_FM6		69
+#define		ZYNQMP_RESET_LPD_SWDT		70
+#define		ZYNQMP_RESET_FPD		71
+#define		ZYNQMP_RESET_RPU_DBG1		72
+#define		ZYNQMP_RESET_RPU_DBG0		73
+#define		ZYNQMP_RESET_DBG_LPD		74
+#define		ZYNQMP_RESET_DBG_FPD		75
+#define		ZYNQMP_RESET_APLL		76
+#define		ZYNQMP_RESET_DPLL		77
+#define		ZYNQMP_RESET_VPLL		78
+#define		ZYNQMP_RESET_IOPLL		79
+#define		ZYNQMP_RESET_RPLL		80
+#define		ZYNQMP_RESET_GPO3_PL_0		81
+#define		ZYNQMP_RESET_GPO3_PL_1		82
+#define		ZYNQMP_RESET_GPO3_PL_2		83
+#define		ZYNQMP_RESET_GPO3_PL_3		84
+#define		ZYNQMP_RESET_GPO3_PL_4		85
+#define		ZYNQMP_RESET_GPO3_PL_5		86
+#define		ZYNQMP_RESET_GPO3_PL_6		87
+#define		ZYNQMP_RESET_GPO3_PL_7		88
+#define		ZYNQMP_RESET_GPO3_PL_8		89
+#define		ZYNQMP_RESET_GPO3_PL_9		90
+#define		ZYNQMP_RESET_GPO3_PL_10		91
+#define		ZYNQMP_RESET_GPO3_PL_11		92
+#define		ZYNQMP_RESET_GPO3_PL_12		93
+#define		ZYNQMP_RESET_GPO3_PL_13		94
+#define		ZYNQMP_RESET_GPO3_PL_14		95
+#define		ZYNQMP_RESET_GPO3_PL_15		96
+#define		ZYNQMP_RESET_GPO3_PL_16		97
+#define		ZYNQMP_RESET_GPO3_PL_17		98
+#define		ZYNQMP_RESET_GPO3_PL_18		99
+#define		ZYNQMP_RESET_GPO3_PL_19		100
+#define		ZYNQMP_RESET_GPO3_PL_20		101
+#define		ZYNQMP_RESET_GPO3_PL_21		102
+#define		ZYNQMP_RESET_GPO3_PL_22		103
+#define		ZYNQMP_RESET_GPO3_PL_23		104
+#define		ZYNQMP_RESET_GPO3_PL_24		105
+#define		ZYNQMP_RESET_GPO3_PL_25		106
+#define		ZYNQMP_RESET_GPO3_PL_26		107
+#define		ZYNQMP_RESET_GPO3_PL_27		108
+#define		ZYNQMP_RESET_GPO3_PL_28		109
+#define		ZYNQMP_RESET_GPO3_PL_29		110
+#define		ZYNQMP_RESET_GPO3_PL_30		111
+#define		ZYNQMP_RESET_GPO3_PL_31		112
+#define		ZYNQMP_RESET_RPU_LS		113
+#define		ZYNQMP_RESET_PS_ONLY		114
+#define		ZYNQMP_RESET_PL			115
+#define		ZYNQMP_RESET_PS_PL0		116
+#define		ZYNQMP_RESET_PS_PL1		117
+#define		ZYNQMP_RESET_PS_PL2		118
+#define		ZYNQMP_RESET_PS_PL3		119
+
+#endif
-- 
2.18.0

