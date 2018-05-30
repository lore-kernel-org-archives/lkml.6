Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeE3U6S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:58:18 -0400
Received: from mail-bl2nam02on0063.outbound.protection.outlook.com ([104.47.38.63]:44948
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932315AbeE3U4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:09 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v7 01/10] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date: Wed, 30 May 2018 13:55:16 -0700
Message-ID: <1527713725-1086-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39830400003)(346002)(2980300002)(438002)(199004)(189003)(2906002)(4326008)(39060400002)(11346002)(7696005)(44832011)(81166006)(446003)(50226002)(426003)(305945005)(8936002)(81156014)(8676002)(26005)(77096007)(186003)(51416003)(107886003)(76176011)(36756003)(336012)(478600001)(72206003)(16586007)(106002)(7416002)(110136005)(54906003)(6666003)(47776003)(356003)(48376002)(50466002)(316002)(9786002)(63266004)(2616005)(106466001)(476003)(5660300001)(486006)(126002)(2201001)(36386004)(921003)(107986001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2199;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT035;1:eL1BZMAmCJaSKKqcf2gIajOfaRD7Hbdts+thUeTIiY1T1HYnBjrcuzWt7dGY7/olrpycFX9D2phg9YCRQjwSSQJxcvEzZdgCeAovr1ByMdNqsKCFBoSV8rYkd8kupyA9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2199;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2199;3:Usx7PUHqlf9Vo9+ej24CWO2AUPGMmTtHKYt9OWXzWAZsUBe5w9yygvfzz/OoyvpiBkDz50Ygo04NW+G28+WeW/SNT523swjIH9UrNQRYcK7mBjb1JYh5HcsG6irik1uEHXI3RdJsrGWJ4vVSRDouF95ai5l0ozQfdDTL2JP5Xi4QsmNvNNym6iLtSYVqI27o32Yyk+NKNBtGWdNVSrLYCOxQ1jRvGQxeOnhU1fOgDC1T3eBptr8NOoH8Z7jJfRFl8nvHAS9IkJS224Jd6DMW1/c5L8K/eAD/rWiH2gRcl6t26rzDkH+9UBBweupaNRq+cwHm7SYSQJ5NHN1xck8qHZsP/i+2NwJ12poyQn/8wrg=;25:ZuKWXdC3hCOw/mB4tmp+QrH2Db99I9M+MH+Hd08GJma53vQf5IUu84KYuYVgEiNW+GtIp3XGTiGuPi19z7qBXKKxD3xPIJL/aJ1HJo/QMikdQ+rO3yl/J0rOTvscwNWXUKaE6slkcsfTIfe5g0ZF7787TAEFtiNwz7Lh3PO4WCiL7kEShF5VjGZEw8YXO5dX/6XomtmggBj+NFtS+9gMg4zOvmIwkelbGNgWVHJ7ri8YNgxbfnPObcO6OgYZYMYKPow32oneni1rgEV7CKxrQXi0gllDb5uH4RWMy6mqUzN5KkGkpuNBnngYfcVRtQixttWr41csOXdSrtOsiPtHAA==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2199:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2199;31:cHFfJrRUwoZhT/CcHGBm6vrOGBSl4TnyF3nZ1iJRV5XWo/FsmicpOa6/WYJBG3VRTikVidULznm92OCiyjip0N1HE/vvGf8NvhSOkSW66LleEO5PzThfr+QyCVz+Lx2CK3EbpFhJN/US502k+/067uUmNvnoPbFVG7SlfAVUvejUB8xlD58Jox9Zg1uBhg94qH1OpPGnUkTjk51WfsqDlK7L9LEsTOZIstmqbSsrKw8=;20:KXwK9FnAEefIHEQM0xVKGCKbmwP9HfMzFGZdAnHhSqP5GsbpQNUyn8+/bU89PzP1l2doHesIOO/UoF/P/HriBa3LEaTHBR36Gb8pvGrcied43j7kq/aLrGW8j2mUfsZz50u9iWMZ0NrbYZK6e1QJapRCyhTKhS3qS6+gtwNiik2vDuBfHNIWlsXZh2GWtbaCvY/Uu7UsjKGpc4dpSUlEx2vAnmciSFrM5yZ72CMqvVTMZflX4zOofxggXDm99QvhOuwYEheVALrMJiB5ZANcGUrSsQqVF2KJByDgZm1yDIMsDLDaSuxe1sPc8PJf25q5IktZO8In2/Gdr1dc+ZpQGNokfp9RNJJnuJ6g6ghnsuLYLvr+MPTOD5+GiF37HX8O3p9cfv5o12uXC356Xvz4ISX7JR32W3QM1GfKFn+txHfq3SnbIbwA10NelCewrYEF+q5opI/s8ST1s3SF74b4C5B9OKsCJTrF+C92fDxr37KC9hmH20o5IgVAw69CXxal
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2199E9FEA31DC474CC0FC3C4B86C0@CY4PR02MB2199.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR02MB2199;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2199;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2199;4:Mmockr+NAuBj+CLkvsDsXT83VKPCwmIBinOyUMtXk5t9dhj8OvvWlRF2MwsRnVzwoBXT/cErJlsUfIvdNMV4V9k9dq3q3f142/PTHL5Cvpi2pPClFUP7DSLhmfGPXr1TCs8LB07K/ENeSX6llCnckJYe2p5SWsHL499C9yWNFaTNJK8H7RN6plcptSv3laZfKKPcMVlN73H9sNIsVkBh4+1q50nr0aM3MA51HvhXkkxknFsWB1zwy+u3YrGQ5+MTuyIzADp4GqbkU5KUg4HjLPL/z/d2JKPOcuzVxUB8JTV3T7JLU8hvdfPgq8Pj88Rw
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2199;23:7cFFtuPZ57Hit80OrcaSvwZ/+BtK3FoZTXvHh6klU?=
 =?us-ascii?Q?4j1nD+OddXf5XYoQAcIg+H//dpHqmJp2D0yHqzyoYnVVfqauPnyxl9EngJUI?=
 =?us-ascii?Q?ngN29TvTILCgC3BlUfhkyLRRyJtE9K+BtbrHjNbI2yWbj0ePb3+3v30LMKu1?=
 =?us-ascii?Q?MQCjSPifZPkR8RQ+VJj/qICIKL7OpSQ+FqsmEkapydweOGOAI3w4qi+0CwI4?=
 =?us-ascii?Q?1PTd8BIWxTvg95WGjsx83a1fuGrPfuGkZj5dzwShwFXdFjSpBk6qhHLKaKkG?=
 =?us-ascii?Q?QoEwz1gVGENPZnVzD1buWyG+8eTfooTi2TUXMgt+bQNntZ+j1fwq8v8pe1pQ?=
 =?us-ascii?Q?lfSP3MYNtXbeWb9PUuWvKNkX0lB8lX0NjFME+ovAN3nxAI+sVhROiEEsrC5R?=
 =?us-ascii?Q?86FBqiClb/8YKsThBNoDc/yvUNJXSdTMQyU7ER1mfa6L7gzbpa0XHxei8ErH?=
 =?us-ascii?Q?oLulMosgo1ozJeM8l2QbjGsP8hH/OyG3GNMW2ApyXCWWUQwWGPMc5wmt+xdy?=
 =?us-ascii?Q?SogbZhmiTMu2dglg80hYc1a6g7xc4VzaSjJnB5MYdIZOWAILuyX28iULICTa?=
 =?us-ascii?Q?t6KUi8Q/apKHBP//vTZ0i7cP9i3tNcZVMCmpmlE4hUsqHNE1f6T2s+0RCnaB?=
 =?us-ascii?Q?oT7/rdieXIS4OuPeuun1npQ1DGgjhfxb1fzzUHiY7phzS2Nhh24ZEbS0qn4H?=
 =?us-ascii?Q?44mzog301yIR7pNz0e75sZcAuqHQAqWaNbJG6ujQn8oxV7TyjCFDk7FsoQzv?=
 =?us-ascii?Q?KItPrRZSMXP4VidiT4zK05qiLyAxkbRFOSGKPtB2kVcbiZqZyPLF529snWVb?=
 =?us-ascii?Q?3KR0vBktg3IZyOSICL25VzSYE3WpBwJft2oArO5x3DGhWFGHgeUzUezafBOq?=
 =?us-ascii?Q?mvObcKDUyfsYC7jhNTlioq2NiQMa+tVZtixJyZeiwc2W4ArfbKlxgafCeoS9?=
 =?us-ascii?Q?bclywi57Rq/3jzbRWwkzP1CUjejzrZDK+PBHkyXydxhftE7liWU98kmngcVo?=
 =?us-ascii?Q?ApFbuVM6KVaXv1frE54wSXictDC/NAPSN7Eas2+RJmc0y6+AbKOhdr7eI3cf?=
 =?us-ascii?Q?ubrLfl81eUoYg7l2og3MUfjdy/Zi3gyr25RId5FXBvQhK1hMJ4pUh5a09k8U?=
 =?us-ascii?Q?5C6bDDwO2j76Zj9edye2IUhEHJXkMiDv3unE8fWEOO+Cqlfb9zl5AK4QLWg2?=
 =?us-ascii?Q?ToHv/3d4WF2U/OLZIgxbHH/9Zu6Hw60t5/bHXjCDfXYQS5XkRVS7smAFQhV+?=
 =?us-ascii?Q?szBB9iFcvtYl/llL0ulBDNw2vTp5uDONQTUBPrpYljiKFYyqPkbT8Tm8OJOo?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: KiVNh5NiZtQxNXgf0Y0owiQqJUPZlCzku8UIvnqZzlLhuJw656ueAQhVOB5rSjGOlEbOgLfi8tpDeBFcZfumdPY7Z98fLQ15YXn2LumqOBMAvkd+tmOq2U1hXSCU148GE9JO17+iegQbPDLs2sz5vPuBfbz4lT9MRL7oyt7jjugbGNKd+f4m8p7tKqG60oeH
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2199;6:TLGlevFxOPtJ6ktVhnEQgyQgghNMIFVwCkh8/DpNEcpolz+ESXrGkbxJEqveUioatjt12zMXPNApC12ecCO/jm0+vLLRREMA6Qs8KWHB1NznpLzW0WsC4U3DwLDXZ62NrabBINVdraVXwHSz/u0gJPlyeL9uekKDl/Ge1rptiVz4q8kDkvtPSA4mLIa5xNYFTE1MiVe4Kvg9tcWVF33yZX79VNrUXrQcrQ96Skokamd8Vb8H2ViAXmenFBAPdRf533UbJqUGRC+hM4qgpVWDaszdV+NnNnVjsegPHPwTNHH1e9IVRZ+Mcg3p++mnbHv/Aur8Gf13pqLaohXlLkxWRSTs4NNNN0/4CdLj6E7NC6YdvE5IA2frW+UXh8Qwh2pfSvrC5WZgKGQGJZFaMnrqVrvaWL0Ma9dWOrOIedx72pm3OYkGIKzqYkW+Lc8Xu2h5/jOjPacAvbYYjXAc/k5JeA==;5:RA9WgMsfv1q1L8Ge/Pui6a1Gz/LniJe9ovvwuSJwjjrrfGbOOi+cXkNvQHd5sS122x0W9v7Kd27tf+UHWJMtjmQfKNxUKGlm1QWQXeM8ewBkN3KFBfD0GQ5AGB0LPUAX4hF2/sN8f4yqm6JU/4BxReKInh4tsPYrbF+NO9/Z2Cg=;24:5g29fwbPoSS/WbvOshzY/+oLMx4x8bqx3tio1vsM34bAM4NNenRbQl4jQSLao0SJ6tyPbdaZv4ygmV7idAUpNHEjrClYe9lLrv6befKPPpM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2199;7:oFdqy9gLtgz7CruaswbX3aMOj7l7SLq2HZ9xCjWeBW72CwU11TioNO1x0Pr2ue7mjhH31LAMZUHa00HuprOtcsVsz54Q8Z8DrZzfhKNqzSklw+xF0m4TqfQbtu2ftO+eAHH8G6C7bq2iyXxctJLustNb/p0/b44t6OqI1klrmKd2J7iS+F9pOPMJm+QEv+ReZH4yrNRMYseUmRAaL/Cb5M/rU6tQP9VBC/trvdUsopGStpO3b6zx5PPhASlf5NKp
X-MS-Office365-Filtering-Correlation-Id: 99e9e187-d9d2-42a1-d1fa-08d5c66fc317
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:05.3643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e9e187-d9d2-42a1-d1fa-08d5c66fc317
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..1b431d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,29 @@
+-----------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
+-----------------------------------------------------------------
+
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate to PMUFW(Platform Management Unit).
+These requests include clock management, pin control, device control,
+power management service, FPGA service and other platform management
+services.
+
+Required properties:
+ - compatible:	Must contain:	"xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+	};
+};
-- 
2.7.4
