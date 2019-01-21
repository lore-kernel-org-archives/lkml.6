Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD56C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F215E20880
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Re8a6+it"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfATRkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:40:03 -0500
Received: from mail-eopbgr710061.outbound.protection.outlook.com ([40.107.71.61]:52533
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfATRkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw50xk2s4ClZk9xRIA7SCxOsGwJHCnEeNvuT9mFY4tU=;
 b=Re8a6+it5eIwa7/jW4ChmDHUNd/td+etcFjpYjcGIEwX7mrPQ9oYQn4kOITtb7WIMAcTWSkFGh4NrEjQAOGeAWN8WaNzx1T/TF7Kw3B5Mpv6Nm3/atkTPrbkECeELLrNXPfhUXpCt16ho3Q3rcwgqM6TWz8+V6jRLV0RUFUXldM=
Received: from MWHPR02CA0051.namprd02.prod.outlook.com (2603:10b6:301:60::40)
 by BYAPR02MB4454.namprd02.prod.outlook.com (2603:10b6:a03:57::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.25; Sun, 20 Jan
 2019 17:39:54 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR02CA0051.outlook.office365.com
 (2603:10b6:301:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27 via Frontend
 Transport; Sun, 20 Jan 2019 17:39:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:39:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56541 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4b-0001kk-6R; Sun, 20 Jan 2019 09:39:53 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4W-0002us-28; Sun, 20 Jan 2019 09:39:48 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHdjPc027285;
        Sun, 20 Jan 2019 09:39:45 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4T-0002tH-6X; Sun, 20 Jan 2019 09:39:45 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>,
        <robh+dt@kernel.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 3/6] dt-bindings: reset: Add bindings for ZynqMP reset driver
Date:   Mon, 21 Jan 2019 23:08:32 +0530
Message-ID: <20190121173835.21173-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121173835.21173-1-nava.manne@xilinx.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39850400004)(396003)(136003)(2980300002)(189003)(199004)(476003)(446003)(356004)(6666004)(14444005)(4326008)(77096007)(76176011)(336012)(2201001)(126002)(36756003)(426003)(2616005)(186003)(26005)(305945005)(11346002)(478600001)(486006)(81156014)(81166006)(47776003)(8676002)(50226002)(54906003)(110136005)(39060400002)(9786002)(48376002)(2906002)(1076003)(36386004)(16586007)(316002)(50466002)(8936002)(106466001)(51416003)(106002)(63266004)(7696005)(107886003)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4454;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT008;1:11Zgxne5reiReVekkJATLJWz4C8+CqqSV3pO+PKvapPDnBzrZfpJ5rBsqqOtiEXrTpGYz8EKDfYeDPmwi2XDIQgL7hKw2Nas8x1zde/lotN+1i/0vxwySsSef8ZS0viXAKDP/4IWEj52w1LY/wGu/u6z6LrYXP8D4DiXL2tB0nQ=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90bc12ab-c905-4e4d-675d-08d67efe4982
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;3:cy4utsyx7auug62y2eOeuUA2uR+wIkOfSOS6quUp12mDkVZvfpvD5Ss1TwKNP92YkXzcQ6T7IY433v375Q1gPq35H64yZL+A+datQDvq6EOhKSBVBdR1mTThkwL1VTnmF1PBZ56hiMd7CdjuaJWmQotO+hSae55mrSv0mm4WqOJ1L7cZUMf3JNSXFfumd/wSK7iEJcQAOhXoKu4O1K5EhJpw3CzhyOa7ZoGiwmaPt//KtdkPqDPVFfy82qPHT9JmH0X1C3mRJ++wV01+OEFjWrzjgv9onmtpIb1slN0DjMODhisx097dPhryKNQRyEsjuVWeAe3/bgYC0wtkTOHl19kqIHnwocjQnihStUlqCh2bcTqhgPsIRxrZuSbtyYuy;25:bTO4q3K8T9ezZ24MpsIq4FzWAKtsFUzdZzxhoLjwpl1SLM82shIMUp2KlQpgDuHK44HL6jEIsP1DtJsnag2ucZfwmdSKBb9jlmSHyUaS+5OcjOOXKsmF7JHWXRdZfH7XsxYt+vsTeKTtmUVZLM3yce+viIeFDFHDBHwghsYe8Zo0RBmGTYIgULJDTDXE5Hcrz285hR0smbfwlhDE+zaQ9TtMh0qFoKEbfCYG+ApGKGDYlvJdJgqI6Yp5Red0GiMKdE7tAd3fGz3L7QpL5XCbuDZeOmSXk/hXIWxkdvxqcMlZkHYpjmhZh9d26SKDfPa7KdaXZm7tQ4sRhK+RBtZZDQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4454:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;31:uuzl07mw71dleeU3N/5e/kPCTOrMZOKHV/Sq/ko7ipopD/8e6bAexBy4fT8pRDBcCmflg8lzcjG5Ge+nvgvP5EMwWsjh/zne/Bwj4Pvhod7oLiHFc7HplgR98KWHrmv/h88C5nBCIls+9cd3BdniB5Qn4/3SRNKrgo0XSJU/r2eyVfmuORCq79UFMKlyeDnx1t5lTn3mBCK510dCfBNHeUQu8bIOaIsJReVhKanekJ8=;20:Bu6v+VrJmKMLM21DKSqLTQ70onD3mHUwlQO2NmxCoCqCP/nXkDjmI9xB0yfIdN9v/eNolNBeLOO/3sfywc7hw7Yym8hF3MnvlrWAb5k+v18i0yzTL7PWOv0nSNYr73M/2bcV7bRHgGYLrGWI4uVuda7mcqHewSDX+V1rCHTqVPdGPnzy6oo4lZK9iWVA/pph8eeL+JYFWT9U99YgSvz1IeHBg3Y+nMwormmf5G4rJ8ZuRkhwjH278ZSUacssKfK7fgiOAp0BbhsMUjoltDdVWwUCzGXLWIrLq5wvCxDTOJJ/4ooYfsuKlbCRtb6nWbktU721poCSTFMBsbWGsCtqniIfVrKMT9vsCmuDT7WnjfAKv5rRHODwJ6HZTmXWIT2zj4mR2hplWZ87toc59Jv7GcK4OgAGVSh3LwHvP4De/TuD1B7XvUisn09qgSPBw3w4+f54jSvnkGg8i4UU1jvmFbzf9RL3wIfEsgQBUtTSWTQ2hUcCqargD3ZsK4jwFUoV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44548B5AFBA3170ABB5D9080C29E0@BYAPR02MB4454.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;4:XD1wj3UUUlp/jGYzrmbm06siKNyX8Gw7/2GPjO68pg7LF66ngspCCA4gUdIN5CZ88gxEprNUZMls+huYD2baf/hLe7nGA9vN/i/C+V2uQwYc6iGEN1Cc/JUwDljSFfpa4EjeD+0QCCo5MfRiXUp+bwnFv6qV1h/4MceZVqnb8MfGrWKvhC/JE1NxHDGp4JWuljNDNa0uqUKFgZfPjm6LR7WmwKAjdCY3ZShvJfYeB3hVPF5lmf421u3l0lylOQ8pEjhMoBN2E72VoqIjPLwc+S5Pe8n1tp0qSXAVALfGP49T5+cC3G5+/JBrGiFfVxe7
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4454;23:3PNgujj6IrUVJM0repkVaHF2Cel7Mo/5bVoEiUlau?=
 =?us-ascii?Q?iUgdL3woJ2hAjBHd0n5blwHFdRb0NgUBzB8OPD5acyX/ByZsSWRtGWkL1z3a?=
 =?us-ascii?Q?ZQqXg49L9f5eyFdWQp/1Zgwk63w53cOx5gbisvo8RJWQo1Na5FOsmkhfA+dm?=
 =?us-ascii?Q?50i10xhTDDvsx67uI0Z3jvcw5KfQuf9mtLKZ72wV0sGVccTTCoaBo0M1RCNU?=
 =?us-ascii?Q?MnUhIb1HWMPH4B/A7Ci5b88ApJ7bQtG0095vwBe6kRJBHTPluTWDzANbcJ6Q?=
 =?us-ascii?Q?YIfFwK5yKkFSLwJmDfaq1+Mxp+8FSBLPXlSLamSlEcwKE+1srbDPNAHzyw7F?=
 =?us-ascii?Q?7Bjcy3q6O6c9/COceWYEXWesAIvHtac3B9/3MUI5Ag8lvaNwb6LHv4CT4ACk?=
 =?us-ascii?Q?VBzu6qv7z0EpRGEGGT3YYDVCCA7C6AugN4YRDhG3b97kyIf+q2+tDzbqYZSg?=
 =?us-ascii?Q?q+FtWjsT7BzQydV4SFTbueWmXQywPD0UzByrcNtlZEbCA26Gsj8t9XiudWPb?=
 =?us-ascii?Q?asGY4tsVU0ett12n4li+3S957HNEJkWTVoT/WBlnf8Xg4eIlPOSNXFDHB7F5?=
 =?us-ascii?Q?PUSat7SB5E1Qa4MUzaOjh5htjFfz5mKPml9Be1HU1akw+alSd2+QjhghqmYz?=
 =?us-ascii?Q?UVKo8Ly9kzY44+xOKhpEDyS0Tkwm4ETOBHpdEme83PXqdnYRLwvM5Jd22InE?=
 =?us-ascii?Q?ne74SO1j/4CJruYybUT+0DfulzdKpfQiu01WB2DoHBcot1o0Ec4KOg3v1Ntg?=
 =?us-ascii?Q?+jTpCm+AsWQ3eI+1EJhXvygzzxb6DT6MkcJYIRJXoqFhkz12MM/vLkDNzfFk?=
 =?us-ascii?Q?TiSr6kaB7MG44XXdsUHF1vD+AuaQlmFIaLZ0GDzp+FIqClGd2wlSMYiPTzO+?=
 =?us-ascii?Q?KI1pBEwBBd93al4E3kOLP38xOWIYKHxQ4RbdAdwtKJnDMhdh6XlnNPXqRwfA?=
 =?us-ascii?Q?ngoOBIzv9kTP57D0Z2GjU4jle++EMJ9fVSn2kyqGUvykg98t7phqVeOXo+SD?=
 =?us-ascii?Q?4hMd2g5fKX0tc0fGkzBtxkV4TOnaGDf0czWJZz6lmqHax3rTV4X8tGcdUhzZ?=
 =?us-ascii?Q?GirBI/MnQdzm0/ljJud1h/PcoSiWVlEUHuIKHp1DiW1Yl/APS6G3t8MtIkp3?=
 =?us-ascii?Q?KKAZueBJqF0m9hu7Q8taCV14fpiWPsO0bZTrrGiENUcxfN/c+WDYIHv4RF6R?=
 =?us-ascii?Q?b+Sg413mN3tugyCv6chO6EgiPEhIoq+qk9s?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: U+V1pZP/kj3tCM4cPuSyNVePxW+ghNkBzLJ5X91TZYNEs9qRcoGoiMCaeCdmJrv01WPqm60le7vcjSz2HEvYrYf5MeJA42Ct9HUx9QDuphooVL9QW4t3VrrMMuxRIRU8MmIKg0DEqYJRmA2OfOlE3qV7pb+LscuSiWE8iqFsQMeFkTn4PCAFTWIHYU2BML0Uq62syVwRAc/jtd3ESbqCmKf74XKrpRgQ/Nnlpex5Swt0xxvbLGSHHSp+olF/IsqVBKWtbV4yDrEvIbD+6IvlAfNls0fYAjrJG4zIjxO6xkuxJEu/kWdjwY/CX0DYsbQ12iRA6TEeAjtlk/k2RhnKm0Uhh6TNojv4M20TGOtxh20nvyEYpuQMeKE7Vsq6681pSMVxIJAPeHHzvKsFbc+hp9R2WPFElos6/VT3EyZkwMM=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;6:vqRVCDM4+12/ywW0dReeEdAIDI7akvnxP3bV2Qqg5CX8IffuJwQ8GMZCNeI/CDVeWjHaoTInW6ho787wr2pkGbLMR3dJM7Hbc9wfROkK+bk9CQPU3PXzuoj2K5/HE0ML3AvMW1Hx/7mvV2Bo5TmxTq1J8dUsOehNr0t6wGYdUjEl/+JdlE/kmdkTPu71a3sVCWidcpM2VrFjiiHPOkKW7g8wLPFJnzAcmlKW2rw6umKHTO5ncng3B7aYo1K1LAPHE9P9NlLVhoQkDLq3RPGsK6gXDpMSUoRVMwVMn9Zj59n6qS4i9hfMHXRQADAHA+elgMYNVTWUnDyCcOJB+xQpc584A1NzjANOe7FkzGs/jYMVbu3fULKeFsvMFlbZt0qo9/fap+GmJc1d4DNAQqFiDLNtk6/YA9a4sFBlMAVjLbUVs6aXNvd2Z1nVxLjqGAN9EaWt3oPs+9TPvaqmYT6xoQ==;5:mE1mqteo2P28roI0lu51EaDjCqq/09l4Q8hRNBtQmwIBvZ4DFyH1wK/oA7RyAUnVsEIuOcaYEF3YO9r6X6YTcy3TrCEgLb9skozG/j85Uwh2F0Dy/GSAKQEkoFSxc48mboGJIRx4Df/yjoHqMhymXZ7u5LuJttgfh7tXoUlbd9O7fzBGTbcb14fu/yJorq+9SOSjqD6nxxHeQzJpf5+oLQ==;7:XwcVtXVxI/MFCoNhRm8QCphqQybtRlWFttJnIJfOnH/IiOvdVcFmbNKcyxKRQeDQN2sKjJTR8Sddz7n9prWpA5xdCSksLJb1PfgHl/GYMU8Mu3nLiSQd5tta4sCkoD/F9tKw/Fs34gtHTSe/0fJ7oQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:39:53.6454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bc12ab-c905-4e4d-675d-08d67efe4982
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
Changes for v3:
		-Moved reset outputs definitions info into
		 a header file(xlnx-zynqmp-resets.h).

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
index 000000000000..e295fd5d824e
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
+#define		ZNQMP_RESET_GPO3_PL_20		101
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

