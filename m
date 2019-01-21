Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE22DC7113D
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7557020880
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WzyUnwWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfATRZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:25:52 -0500
Received: from mail-eopbgr680076.outbound.protection.outlook.com ([40.107.68.76]:24700
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbfATRZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74kgdItjdXT9dAelFbA7kgiLe+EDA8JgSt+NXozKRUU=;
 b=WzyUnwWjuqu9Dl+Qcy0MIoccPASDLhqYcDGJFJKz3nrYymlKEDnvUMGGGH5AY1l3tnj3cvOJqlbAZAFfNBYVoZpQ8bIYoORYoG4jVEjxWs7zF/KcKvFeZZo/FlhEzB5uhKEoo9T7NeIqA1YacK4bmOhwKWcxlpEKmjzjFlaaje0=
Received: from BL0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:207:3c::32)
 by DM5PR0201MB3511.namprd02.prod.outlook.com (2603:10b6:4:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.31; Sun, 20 Jan
 2019 17:25:41 +0000
Received: from CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR02CA0019.outlook.office365.com
 (2603:10b6:207:3c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Sun, 20 Jan 2019 17:25:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT023.mail.protection.outlook.com (10.152.74.237) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:25:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqq-0005VP-8S; Sun, 20 Jan 2019 09:25:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGql-0000ta-4i; Sun, 20 Jan 2019 09:25:35 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHPXtZ024213;
        Sun, 20 Jan 2019 09:25:34 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqj-0000sm-CD; Sun, 20 Jan 2019 09:25:33 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 2/6] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Mon, 21 Jan 2019 22:54:23 +0530
Message-ID: <20190121172427.20446-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121172427.20446-1-nava.manne@xilinx.com>
References: <20190121172427.20446-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39830400003)(2980300002)(199004)(189003)(36756003)(426003)(26005)(77096007)(186003)(4326008)(36386004)(47776003)(2906002)(305945005)(8676002)(81166006)(81156014)(50466002)(2616005)(476003)(14444005)(486006)(48376002)(1076003)(126002)(106002)(446003)(106466001)(11346002)(16586007)(51416003)(7696005)(8936002)(76176011)(54906003)(110136005)(63266004)(336012)(9786002)(356004)(6666004)(508600001)(107886003)(50226002)(2201001)(39060400002)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT023;1:xzKGWqslldZyz308C5B+2Qo/1oVUmC4dPWlBMwBPf+flknTHcVKvc6ywfzxUXG/00TBtjKTA/ORZovQlptyYI12Rgkhv7H7UbgR4bpbVD5/dZC7kgC0g/sFTIWvOAawkUsMNiPw7Y+Oi4+hRwlTku+PAlV+SIlIteoT6pJ1SXSA=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b8bdcee-cfb1-4a14-7fcb-08d67efc4d1c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:bFGgLuz3KCImLy1IY4UO3kIv/JuXIcYOdexzKd5GtXtBayVaKnESS2lwBdpf2tR7ByiI5SPyQqgSZ4O4abhBWPyuHErI+03+/uTD25YdYYh/zwWILCq10ZB9H1kxAMYQ0ZMhGmClIUccSb3z+IeJoNhHwJDNpkm8TpL5vqYUgoFxwjmLb0SNVqyrlfS9SdleLhNymgEFAFfAAp3eSZEG3fzGm8QzzXoV0p46ik9PHeFhgmMEIOPwzZG8j9MWPuiupTS9S1JBUx1CYSI0/aGAICNMV4AyEtX5PjEZg6eDZXL2n4Lw2iq8owqPwBuKk1P5L+l6Bkc68Hy17LYCh3HcRE32Vx78EtiT1Zo66hBkMM+wtX7E6sSDV5YmZj1Jn/ZG;25:3GI2RTlXIVmyeDZ7tctW/Tez/OEqTW+iOtx1Fs5B7MXCX7XlbE6mAkMNRn7dugdATpm6baSu+s7TtDUvJS9mUdVc2vc7Bjxfqv/d7UwNZe5jXsspC8r20FLyZ07jbyCCUbApze75iwnjnK/PRIBPzoC/1323RDLncyShWWfZLBg2vkoa8OJL54qQhsBfn5Td8AGjucc7jVPLLTaeXuMyMfRY3tYDXYxjfPuDFsKtdQXTpkp9Ig5TwzYf/ZH/Yv9YBJYHAU5ocHA9y16ly9KaGAp1B2py3KdRFwG+4ZqmoqrxrP3xk75dbdh3NSiSxPYXYqNKKF7hKMG+7on5ovjCQQ==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:Kr8yePuflT2cxxgubpLcCrTweDfGAqduJKhXsxk7CFo2p5G8bRVjj9eDwfIFmmoYcydNatoeEIgKpsK1Xr5xehc2DSV4V8ObQZkV65rgrJa0ExWYRY/aLCOMz6JZyMzFG+21H+qcHG+JbjxQLbDbEJREWo1FjReY3IGlJdXQdXILZ9VUbf1zTSGBM1/XOv+b5kKlRzv7h0ASE8o9c/UB35atgPh3vAntU1FvEXxOBq4=;20:1jmm+zeCQgLNlxLcf+GNL6hsl6e6jbgVeP7FyrnsETC7f7sjXR0Q846SMfhWXqoV8mgfH3iAXx4a1FDdsk1QDkYmV1OtGJSNwjR9gHfJZgkoQYn268w/Z22zAOkPKvcyBeN8ufLDqEbUs8O0YTotoFBVc78JaGW9NfzXEse6AH78AiKJLxAcLbtlCmIVu/ZpBk38aYVmzR9mGrO+PRcH7IuvjP/7z8jsdK43dg5/gScv0DjilHAfu8EoJCsPbhW2PyRWnPmOcx6BWddVYeB340NK54zcXiLwmNSjb4j89sZfbk8ZCY7t0HNZeOUhGiamBYG6Zh/k8QYOziUViSDSg9KOIcWWaeimmsfdQdKUk58JQrsQ4RcvLoOjeSSix772dmdQQVpqFlAIb5D3ZBHhLt5iaGFxrpKuzIpKeTmufT9JjE2bXzOuVX/z61Xb5FJZMBCAUKsb5htUd4bkmKHX/LZTqPM9LJ0aqLPH0F0EfwYuu3TcnQC9pV1INL+Rf0nc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35116B422B7094B2E06C1880C29E0@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:D1aGIHVqYgn8xzZ4EVGVlUfILyV527gAHkXX077wN0JsCGb0h774f8fyxjx3/tA+2kuDWJ3jDlXBd3UTYN/qJn/MZYEYABxs35OZ7bzM7d7/40pjBfObSx/OEajIfh+T6jsmjFB/ieqSNdrwrQ5HmeQfSTU+5a/J6rEamAyMFWvYrVs7klIle6KVUysm6HkSwsYwrmGIktMl9LALw8p1Ko44RpZVpLxCuaIuEeodFgH8Ei32kl4bG9SjUXaPfJS/+OQxc2cRS6+/dejqgD9UrUIOxx7jsGcNsoY/XamU+szGlSLTonEwtuT+lMEOw3pc
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3511;23:G2vt6tQsf0DG1DMXk0YggHSBl/5CF0eEMh312Y3?=
 =?us-ascii?Q?0ZHM3boSCY4j8ZYhuuKmdvEuKK+XWfj0W50nw1oc2Xfsk4jg3bAmjHKzYHKR?=
 =?us-ascii?Q?d5Ef/4psVviySI/NZz+vEUFQh+2GNQynYGwYPPjRrAAG6zdBsAZ+edCbZ5CX?=
 =?us-ascii?Q?AfRA7XTlAlcBoPwBzjTIQF3xxlPLNezMyVKMtz+RQIt8O29dj3ILPr/gwLTb?=
 =?us-ascii?Q?rSOjQNGDpf2zyLCgbNkYJvItnpSoQvZbLQfi3ovTAZpFdkpkCxW4Oi2TCYqj?=
 =?us-ascii?Q?HBqm61tz9yU5C/HpRMJ+vU2d5Jc+VuYPA94TODowTPUbn2ZJn/q2oUvekIN/?=
 =?us-ascii?Q?tzQ3BEdrz54iT64/nwYp6T9vFX69UWWqWfp6Sz9y4Esu53rpW9Wkmw1XCPue?=
 =?us-ascii?Q?PaJ++ovs0KMCYh+weWmaMRoVdVg2RCN64FMzi96yIHKXV0aWe7BmLRVYfYF9?=
 =?us-ascii?Q?EhjN/CIT5+faAY2H0HeazmQf6RLiC0namO+v+f/ELwWlvgaCNVxvBpMiOfXk?=
 =?us-ascii?Q?vJ3Y8fXgSmV1jYuQ5RxyTTapGQuzNdLTwsfXPviAoSzpRypgPv3JvvKTzKOj?=
 =?us-ascii?Q?dtbIxTy5jc+VnNrtQmEk30hgSWuXcpx/qFt0f3tqtNY8m2POqrJnVLMz9Jml?=
 =?us-ascii?Q?CgkuPyC95C9SvPNDsE5JwWAfx6JE/wAiK+rWTGuA7ALZuMpbqXhyHNcfoSUj?=
 =?us-ascii?Q?9Ah452zWjHEq1XGPLWpOsvLTrUBTP+IPkBUhYmzbbKLFBZ12xNPYkQumqjgg?=
 =?us-ascii?Q?3k4D2ONQIZFXK01rdiQ8QwdyVwarzjKkX8uoLnzk81SWltsuHYIGEkwmi+rX?=
 =?us-ascii?Q?oacM4kmTHz3BBVzY8pWX9L/xv8+DYOlirTLFhqgsFfqWexqg66DK1RE1W2Od?=
 =?us-ascii?Q?krK6ddh0JOhzgogIb3LI4exDQ6WspozZS4I02a9EgEgrCQ7yV5QeiQ/JHSpm?=
 =?us-ascii?Q?EeScRnskmVGDuuLw/2MtUcDC6mdyUB9CRUnBj2IbVIZOzljuBLhFEuJooX95?=
 =?us-ascii?Q?WGFavFUVBwbjQK3uYkYVHqPft/v3heOLeNajkFeYm/AR+BnZljGMGaLaRQaO?=
 =?us-ascii?Q?8pfj7dZEWrw7Nr1OdwYYwhtVGvL8OAmN25qfDGLeh3YC9Mt73uEgk5B9prId?=
 =?us-ascii?Q?oV9q7BZHGmW859JIopHKvHy4Fyu5dxL3U?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 51VUJwE4qhBpc2np56TfbzKFM7hznlvCM7sajkN8wJmxVg/mE0EgUlfXrhe3YMWM7nttNhtgYE5avN0yjXHwjIHn6BBaw0J25CZoPjy8Xdkp+C99qwRK5D5ZHVrZBsItLfFYQv7L4I4oLUwIppOP4vTnQ5x1CTO/v0l/sel4DFpQfTBfo9kUpuAA8PKwnDZZNEAHi2Rd+ZsWfV9TsnR3P4rMkl/GkgZsk3btu/mV/4jeO3Snc/yDOgyOUIheetRbuPbg2P1WDXY91swoUjgHuq9vAgr7TbuCDyUJS5KivGI/KHh2HGvyYCoMFilwHBSRDN5wB5RtXaXhmQhQJzvK4mZj5yebyFpqAXT7JovcQMZMv+CNS5ybAS8A0d6DB0mDMcqog0XI+l5as/Ue0DeMZLV8em0dyShEfmXu1FoJ95k=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:ynQhNwTAEP63PbO8bnTiCMcNrAWvSU5t4Eietsj1mk8vRpLkh9ZLY0/VPOiAGUEJQOGuIrzdVaBy8aGKGm2a+VrxeK3TS/JVJgaz/PdfD8SVOLPEQPheQMG1I4w1YTT4QpY2h3sfSXKg7jKvOAg53jcpc+fA7T9IkTyzY19oU7ovYEC8UrgMgyK5g8jQdCvBP/eUalAcTSfxjbZ5qrsAtaD9fqMlEQ4dr0dbHdOSICKLos51YjDUeVs9YFf2iUQPSLaQaZunmRGPTg4JO13b+qKN0wCwlOhrqc4bBG7JCkl5km9qlmHZ+5jYi2sHOZngCxW8mkC0Tt9gh2JgorSsW7YVeZXGk7rpKQVpLgx285Mxcj8X0dYDNPc7nyfLXH8Fhx4gVsXZi2aJMVu9sna6ApyGAeoeuZ9bfg7ApF35hzndgZEQKxkbbqKJRwqvQN9fNlmXUTwj3U75trRCxCTDCQ==;5:USnuIsuno7oYNR/b0+cW3rQzHPrOuPKlJU6Vr/ZnWt5WR+ldHOTG9MDHmc6TSwfS2TQiWRiwZWGJ92c7Kd8OFjdQ7GGUhDbIL+ceO+3I1qxYEhvpYN6juYgbuFL7moWH8mwfs1kF7WApP/kDd9R2ovC5LpVJIfGu3x00mPvAXGLANOcIF6nHv8TZM833I0zg6u7v527LNHytfzN8W6mQ1w==;7:GFVlyT2zwZH7hl5Aj1uq3CCnb2IKAWQMrKZROIvjGFfeHYWf+zp6XRgoYSDfjPaehjo01slnoS17PdnJz9brUXOKgmPIbsIf9irzv+bHJEAeHbsJoR8pYFe5L1jHQC6vMv4xl14HHIiVdlx3dWvZzw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:25:40.6637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8bdcee-cfb1-4a14-7fcb-08d67efc4d1c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
		-None.

 .../power/reset/xlnx,zynqmp-power.txt         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 000000000000..d366f1eb623a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -0,0 +1,25 @@
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupts:		Interrupt specifier
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
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
-- 
2.18.0

