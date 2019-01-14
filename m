Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EBD206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JUTnf979"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfANTXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:23:30 -0500
Received: from mail-eopbgr730043.outbound.protection.outlook.com ([40.107.73.43]:28112
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfANTX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOprgopWaThs2RZVQAxl3VL9bMTAW5QLsOWAa5YF6qc=;
 b=JUTnf9794uxAAi/OdtybXkefsQi73qLqFf4wFKECM4+vOyNWvZIGSsas41pcSz9UvXcRox4wgVoVyYqQYLptY0AuDcmw5x+aZFX6jVs09W14z89qHq2IFs1x2agep4jr+A0JSMrxmVKLS9qYlMJw9nuR82WpHnz+F/i2rFSn8TM=
Received: from MWHPR0201CA0106.namprd02.prod.outlook.com
 (2603:10b6:301:75::47) by SN6PR02MB4336.namprd02.prod.outlook.com
 (2603:10b6:805:a4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.18; Mon, 14 Jan
 2019 19:23:22 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0106.outlook.office365.com
 (2603:10b6:301:75::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.18 via Frontend
 Transport; Mon, 14 Jan 2019 19:23:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 14 Jan 2019 19:23:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60809 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gj7pP-0000zj-SM; Mon, 14 Jan 2019 11:23:19 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gj7pK-0006Hg-Ou; Mon, 14 Jan 2019 11:23:14 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0EJN6gJ020663;
        Mon, 14 Jan 2019 11:23:06 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gj7pB-0006DT-VT; Mon, 14 Jan 2019 11:23:06 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v5 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Mon, 14 Jan 2019 11:22:56 -0800
Message-ID: <1547493778-22720-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
References: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(186003)(76176011)(2201001)(36756003)(426003)(356004)(6666004)(336012)(9786002)(7696005)(478600001)(51416003)(5660300001)(77096007)(7416002)(107886003)(47776003)(14444005)(486006)(106002)(305945005)(4326008)(106466001)(8676002)(110136005)(2906002)(63266004)(2616005)(54906003)(316002)(50466002)(476003)(44832011)(50226002)(11346002)(72206003)(126002)(16586007)(26005)(81166006)(39060400002)(8936002)(81156014)(36386004)(48376002)(446003)(107986001)(921003)(1121003)(5001870100001)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4336;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT039;1:4JzUapYvOHdTPWY0112udjgqz5F9K8LxN2LtuHKVQZPnztaUw8GGBx+yvEd3zrGa31KP0YAuiB8koBxZIiie7IogEqi26nq7KAbnE5Cj6RdvSQ3jp4NTCviaALrTPnwO
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8235f6e6-86dc-433a-7fe4-08d67a55bf73
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;3:XpcU5odkncc0OMxMnGJF3BriVwBs1IrM9uuK4UZqjwh0tQRIf1zcEJZBL2SFtiV/p2TbNC+maD+1pJvVZeeO16knlFoENUbORQehpGhGNfJNbnoOauTn3u7I2IoKcTKo02EcX9xotNhYWy2LvITxZLIDcntQGQneIZmonmrCUfKfNQhCyghOMm356tUVuVitNrQpn/n1PDkPWHNnncEP9Zurk4a3lp2bPVGpLwYaS+a1nV04rJPdGdprVp20gP1hNzbaeCpUvdjBzIKgCt3n22ziL+eJQ/naYRueH4pkf+bxYg2aNB5n4Jqw3RV2hR9IxD+F+D7a1vbaupeKIk66BZriOBoN5dlMMew4E4InIO5wAO9cIPvx+pAtq2tovs58;25:PR1j3/65nGNRtTKdr4P2HMR+ItWcsLyZJD60U2lzzhEQaUZu2v4ERBp2ONEGCJgDRfUN1FpWlfACk20HQzYsVzZWb78B0AmL17BmEfnDWE4DD70hrEi16UqTzDF1+9ezwMSLKdFeNFMN3XTawGizQMXqy/W9Ke7U0JoJ0QMFNl0DVcTakzKXaQsMKQqbm8zPiy+gicyHk2bVbFiAu9qJ9rmxH2+yS4Xd3ilwaEkHDC8isi/r0eMpBjzZVp50DKHLMw+pq1HwcQfGiP2ZCvc7VFVjSCuIcGIuF2DVdoyB8svBYGmFU/JkfWJvopRiarCBs4Z2c8EcnCyx5cOBXfdtmw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4336:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;31:RQTrpwkoDmu2iTzwAT2Bg9K0bcl/Kz525vs5qqSZAdUk2yCIcCp6d6GXESqnLhp/OGYCK9lPy8AUsxOTKpu+JbvzFPSUjMNaga5c4XVl4n8lthInSZpq5NPFyctyVMzspWv7C1wkaX8hkn4sCohlHGs0xKxzpqh+3MqqX5yXR01P7Mjo32vPrU+BAPfDOLXI2awV2ab8bNvISycLvtBEaohjnMM9Tpq91IpBUij92Yg=;20:PsRsTztytkoORa1TmFV7KlBJGDZUi32dW0NC/BSb7PdfJ2Adn5tuksPrp49DBvIKGvqr3tSvWifQCKAEqjWQVVY2c/4t+F5uI1T9bAH8W1W5SQ/Ydfw8SCw3n3dimHbiWSdbTT97wZgR0wO3xpC0UMD62aJfKpBC90PhZgQROY2Uasb9t0r7c98o1o224erxAYKVudMWXogePm94vlvQqQjbK+fI24+c1L7rYZg44EyBPscij8onT4KFU7uipxDmEYrEJDY+tsQmBAq7LzJCRGLdTH4T9882Hb6EtpkfktUqRlWZ9jTi2Y3wGNXRDi25UHsD2gKmg8PseSdpg6HsZz20ntbb4Os+2YEmSn5t4lpEzmf7DIWAKBAfZjG7XoQa1Yu1g629yxk4z3OK/dKv33aPI297uCqirru7uHvar38KN7EPbo1hS6je5fkcVJsK2tUGrqQmEKyhwn8zngNc6EHFT6dIspV1Xf5kWceKCQ4O0m2oEQEgJHeHnGaLylrg
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB43364FDFEAE914D6EFE3CD01B8800@SN6PR02MB4336.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;4:bJbjOWd2WxpMwdoiih8oUibfQjo7bALRwO4VayVFr/WGepkB6EaWh7hEXx6Jevhh93ozr5a/ne5zmd6H/VHp+HwbQZn+ioNe/vV2tJmzkkotxaVPGCLLVnRwkqG3ns1Ss4RdSnxC0e0NEhja1RNXd2+mJLCosB0OZ2/hkjUp3JeAoMbbnqWLIjUEvyDXhOcxrGbhzVnY0f3shAQqhy2KknUqdDfN5PlDUgUoMLQ88e4vS1CJ/1qMZ11d3laA/Qp75CFqjMUwKr5A604ZsbMbeON/b5sUI7i5nCtued+Pjj7X8nfiwBUXWEgzKrAjW64i
X-Forefront-PRVS: 0917DFAC67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4336;23:6y60N5CguoE6SUaxKLIrbtslOVATmOhIMl3pxhI7f?=
 =?us-ascii?Q?9xZMAePSNnN+5Ks3ErKPFQiNvyVPro6izi7eifX4o8xjD57LhOeHBJ+Mvdha?=
 =?us-ascii?Q?YVTcXk3UTikZqlcsVAqLQlC3g2P9Uq6fhyJdYldpFmGx2u/fwtFg1dYVHB/f?=
 =?us-ascii?Q?8eAcCk7vW1FxB+dzaa4YRw1cmUeECD85jsCyfWY3CfqoT3unPQQ2gLR6OWex?=
 =?us-ascii?Q?BlYDUD7Cca3eLxqZ9fABf8kDTbNxWodELp/vyQoqXofZkboH5bfRspROqzH6?=
 =?us-ascii?Q?o/pecb1Lo7c6/995aR9ypUVnZHhSLvpGmB9v/TYnDCuj0On3FtKDCm/8awrG?=
 =?us-ascii?Q?TYXfebiMr4jhthUl4huUPveRbJZ7PLSisO8dFZMrVGsn2U80ejOqsQsFomTO?=
 =?us-ascii?Q?ka40X8QDqGH8x5SOmqRMc4ARIUAEZvewG20Y6o+TDzMtDwmjz89yiY4MOR0o?=
 =?us-ascii?Q?LXj/rOGfNFwwPAZqLi3MzCd6tEqaTzn/+cL8K/CIH6iQLnXTWAL8OaS2W7Sk?=
 =?us-ascii?Q?ICTVncaS9qpbFg/OXd5iJkHRMszG/ZeJGj1OIPVw6aRu5kBIa6BSemYOYY6h?=
 =?us-ascii?Q?ZcNfgKrkd++/4UhHXUrb2x13vp5mdBiZg4Acs5Jc0h5C0dI7KXUzTQu5JMFi?=
 =?us-ascii?Q?x+iXABVVXP2pWcjwEjEb7yGTHCa4oineN4dgTgaqSW2mp1JgRtxTY7DUpy9d?=
 =?us-ascii?Q?8LMtutZT6A2RHQ4Oc3WmDStx20fASF6pHtWYIRMPfGJV2SB/h9hYNVRyH9qK?=
 =?us-ascii?Q?XZmivxI5EV4ak2BVOoisBkfu1veTfk5TNtMmZQ5dH1zyXu4ltt1PKDr71LRX?=
 =?us-ascii?Q?y6powgPjB4m7GArh/U/PVe4B2UB5bSsRiV82Hlh0siupQj9rNyaBbhQ8QPNQ?=
 =?us-ascii?Q?Ag4t3/HBWtWVNYuGkVrW+Q49wUyoC9gSYJSht5y4YP0gkH/Rh86ksbWfN6e8?=
 =?us-ascii?Q?jtvts8o+Hrfg0BH16QFsy8gG0QCb4m4vGUfoWT5aUWwIqWVm2uEULE+tOGhf?=
 =?us-ascii?Q?WYfCdSWOxnZkDzRkyXBXeRnx387thWGFF1cM9tKAd5IM5Nmw8s2kqaLxYD5f?=
 =?us-ascii?Q?rNr2URQqie80xA9H/iQ5dlSygNgGhkzToJI/+4SPuivdT6zfC9cK/5jE4QTc?=
 =?us-ascii?Q?7oDk98q3aLP5KQ+TweehwQTW2+m9hJ5uEQQYEICHGhTSWj++ucG1oWJRGlYL?=
 =?us-ascii?Q?kmqP3me5d6gc002Sbgs51Xn/8fZldxDi0wUQ5Ou5Fspn8OH8/53WFk0altuE?=
 =?us-ascii?Q?D7RFgodFH/p6RXjJxqYI5m/9wbtTeyTYIxRWek5OknDlS7DZTzfiwN1my4Dx?=
 =?us-ascii?Q?G5xJjKiR58nz1T1mFwa4EFdt3wFL/DviSEme1YG+bOA?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5vgjv75jcDpxu8wLD4jYeUx1XgMB9t9TStBLXhwVkxgiO/T/sPzkmg79upik1JgdKjWPc7HpirxeMpym3G5r2NZMHC1sjqKZCncVPGl3h+c0bvrY8QRskpFRHVCr4yTqbWE2QajOApVqncTfSoJTITbYKgsWEKBZ+h3a27eMvxSIRdeJY2CfLoV7FZEVzFPUOEe6zAjPL+2eE4aUNnuqV3fLqgnpEs1PFUs9lDXORAJoOQpojc9vZHLUE6pEGPgMqUhFc7cQCXqZysP0HGY4Zo1imwBRDWCoyXDbNst5xaUjQaatd/NuyWESdpHu2ydkVtxQPeYmNeMFL/H8DzOVZznFAHw5SBpbZeIHwfKrsPn5SSFVgAUmoRbwgZn1Rxz0E9eU3fKybQ+MAjJt9TFiZzbF4xVewByJDbHeOf999ms=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;6:WG9+WiQx1YuQV1BnNhFPfTABNXqd33Mvh0JxOlNspiQ/7M6T0n4P04e2A6XWNg+EeQ6LFUOBWSYyFx7/VZaSlXh46ozZvpOM8Cnp3H3Omrn9XDIpN6Wla4SnW3odLrxNd1wX5jCIhw5MgsXxKPAVtPp2mtZZR7Ayn6ScCIHubVEsCmE8wq1hTN1dOvTN40RUgj+RP+rF6kKBn30N7twyrteCUTNa9c5hOhJtGVCpE5B57C0/IAUUOo23YWDY3tn5yo9vuFgHtWXewlWzo+lJZPqMrlXcYercgFAwh0D60oM8vliGBoObPiv5VTZmO934d5ZXDDlcuc7O1+iF5++jeYom05wmNtPs/op7DAIGbfgU8pJRw0mhsTw9LbOBb9m2Kv+iI4G3l2wm/I86ppT0jVIP4Lrr2su6w7mErZ/tT/fWAJk88kzOK98qUviiB2LylCeZ8NcZxnX43lrK0LOkaw==;5:1F9+07V16fMVbgEJjS0laDzZFH17DVm+1f8rgm8xMT8gOA26fUERX+oX5ToXI/P5j3RauDxWdw7j2kC1gKgFa4b6Sq0ERdw/3E6PmWkKXd3WYQnw70nXEVV302LlMh7llIMmwnJnzU0GT86gJdiBQ3IWfrn2TnHRzu+sFU2bfLAImHnd4p55fITKgyPZjQ1SDwTnohxBnC2nKDnmaQTCog==;7:AOcJbV9LrSFuzkTm18qD50FaACmoLMOhqmt4yQRD4QO1N+22tqJpg4DY8GYSkBriRIIpKhGjKmaJJrc8gmz0kRSwfYloxyMEOl/G62Nm4jBfXttfsqp1zJ587NQ/6qSh0wIW3jeddIVp2meav+Wd0w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2019 19:23:20.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8235f6e6-86dc-433a-7fe4-08d67a55bf73
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4336
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
 .../bindings/power/reset/xlnx,zynqmp-power.txt     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 0000000..d366f1e
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
2.7.4

