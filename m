Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932556AbeE3U5v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:57:51 -0400
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com ([104.47.32.75]:54176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932336AbeE3U4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:10 -0400
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
Subject: [PATCH v7 06/10] firmware: xilinx: Add debugfs interface
Date: Wed, 30 May 2018 13:55:21 -0700
Message-ID: <1527713725-1086-7-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(346002)(2980300002)(438002)(189003)(199004)(126002)(426003)(81166006)(336012)(107886003)(36386004)(26005)(81156014)(44832011)(77096007)(305945005)(2906002)(186003)(7416002)(39060400002)(2201001)(110136005)(54906003)(6666003)(356003)(5660300001)(106002)(16586007)(316002)(36756003)(7696005)(51416003)(63266004)(47776003)(48376002)(72206003)(59450400001)(76176011)(966005)(4326008)(2616005)(446003)(50226002)(478600001)(11346002)(6306002)(8676002)(50466002)(486006)(8936002)(9786002)(106466001)(476003)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2197;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT008;1:LiFKznsFvcpax0vMFYHGGqmQOSicMvCqdZ989bHSWa4YN5ZQm3r2kn7ntGMMvXr4dJ6H59Nkj3zVZx6GxcIMe8x482SwvXpzv/1GE60Nhdft7GginXkUW2X++4bLWpkY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2197;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2197;3:1nJyhv6h0DrXEhdD5S5cqfX+zFUXdYgcpCj0/RyLFFeb6QvmzlrUAPQaO4H2MYJrm3SCJlkYZ72McZ2X1wkmiLRVht43+qfP51O4NiNwdJpgAK4UJgrrYpZDsokidCJarkhaqNyAwkBCQM8bbA5gYRGUiCzzIHk67peFrY7mroSpf6uppgUv72BK5NZAYPNHMtYFt8GW8JDvkJ7+Ee6jo/zgV3Ay4NRF3l1ovd3sEWOtvYxUyi9r330ctsCstMAM83t6HSajPvOWGjW9rDGfmFP7P/V67P6InqRK3z257NtWFFWWWEa6Ql/rlM8X6tWpLhG/WsEvrP0clgbnYytHAdrI+2tfBiswAzrQypXONxs=;25:blQYLRRb0CcA8Xr25r6DABLraUGA6Mjts4JCWuq0JWNyAaSK0khOXlkXahOd0fdFe8kwVU+CDKGE5fh4joyaHJnM/AYewow0SVYuIEBYZ+4NmMxnCHZBJjrWqBXpeEFzc4EGY4gXQBPUxYIYSzjqH0Pe12ULA/XWE9aqD1IP+FFjXH7lyPl9un+/ExAqiQJIWpetBZlHkaHJF1Wou7qzDIG3aYWYd90Q4rQrNS1UKPCfnTz+9+sDhhm5k9cmeZYNRLL6uuxKSqQjXAjNL0q8Gv7yBRMRj31YYOmaism9UoZRh1BbdFdunEvKHzbWt8hvyGHjyIkOw/n5gGtLdSL0SA==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2197:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2197;31:5Q5QlXMkanRNSp2aBKJI2DWzZh/onLzYkR5eYJ6yqusgtIQjHZb61gVvSHPm1YpUu5zBrv2plV9/CECy9e1bd/TJM/8lt1mid9oLuEVvDa8Fqv///NqTxMUxXT8GQZYgHZzIjfRi3hbh0haiC/hOUQZIS8kU7DIz/ZjQaVgDzDCLPSal/BkQfCNWiUmYjE1sHPvsQDVpKx0c8mDwvdHhLw2fI5fCLXHJ75bX4ojMJuQ=;20:GEWle+791cG7vvJbwbyGCkcq4G4IjRSIPRiZ303keq/NnPyMesONpk2LE0aseZ/iGITk6nVz4+WG2uEdoxao7hoeFPTDcWKWe1wfvDqExv9kfoRymxHSvBdDZ7WEgmX158GVgYsrpPvzfvAHjEi1CXu1belyfl0mPqi0ymUK4/FZFeWU8h2ew2fLAV4sFKWbE1vjerc0rTISzSphTAyr42yJsJSjjA4YOjMJPwulJErh0jxToZzO67LH5q5BSvwvy2J56WuCLHuqRwUQJ+jcErg4ivvKvHsaQgJMnR2PNqMpxEz8kei7pt1+mOPKxxzL5eT1BYbOsxgfbdAUnEiO0IB1QgfQ0ZhkFE6lf+8Y13H535t1jHSZixv9sfsAA9XwhJ7/ipPY8x6x3EPdwl/eKV8oiZNdTGID4705SP6cs+NaxyNf9TVV9Ms2DqG8EjcatuPo5sZi9cAhswvY78N7vHMghXtb8h3+jXHVTseiXllZ5LhIkOFQJLPtU3YDD/k0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2197263A928DDCEEE27A8FB7B86C0@CY4PR02MB2197.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR02MB2197;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2197;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2197;4:WW+txDYwSDTAfrSNIuJStnqOjS/gK5ajd2wpABl6GlaXRtYadA71xCKuv/uIduosvRPWc8um4MbAL8hcLF4RE6o0UAYMen9oh2wfD8C/67kZ/JAS8MpHEf52XsVayMc9GJ+JQGYfzwA/hQMdM2NsIC+RwwOIUmGhijK17qXH6P43uJeHYABsyAVbKxnm46+l6AGwX/8Y+pgYUb2ZI/k9wbC306BrLcP5RmDFmhyQZVTV9V0rcHmNtjYg7aHHi8BRdNEEaDQZEKxwM6fBN6qnmj4Xs+BAeninnORsdZxxkB5wGfqVjBwvaTWEGe3wqGng2IItq7LroWRfdjcr/dvTxzYvM0gF5SKQT6jaDToKHik=
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2197;23:eODA+UhQXEMLAORFCCOTpoz+YIE56hEgRMys1DsOU?=
 =?us-ascii?Q?SD0gKxlCtasxxAfdAReYYGbgD+k0OZEpcFv9wOQnMuFZMGStATzQt7/vldht?=
 =?us-ascii?Q?N8cFbpjWwZNOsFkS0egJbXS5U/9lLKzD4R92RPlZPA7nu6T82ZYfApB707oM?=
 =?us-ascii?Q?K/b39A4aUiRdfxSFc/BKOoaOD24PdJcMB7FSLAH5US/nho+fufLv7Bb4bZuf?=
 =?us-ascii?Q?XJdBUwZ5udtfWGOkcTuvxpL/hy2dosvHMWcMis3UYpuP5/qp9+rbIys6KuXt?=
 =?us-ascii?Q?7t25FruYIqRZ2Y/Vwa4mKVxcHdWaTuyY+N5XKb1ZRYS6NiQy1VG8d1zSAUZJ?=
 =?us-ascii?Q?0SlDR3EvK48oxyJhORdo6L8DPV143eanEYXGvLhON2FCqoKrfyp6cft+xn6f?=
 =?us-ascii?Q?yWQO7UPrqVa4md9v78l72GuHNc3vNf+SqCBp5wUzkEY1dYqhBS85zHkaE+P1?=
 =?us-ascii?Q?rudyFCgN5e/XQwwsPB9rFHHepVg7xU8cU0HiG6901ELrrVo33KemZ83uM02m?=
 =?us-ascii?Q?SpGXPz3qQd/o+5T7+hIv6U9+fQWpTtcnHFRcMCZEbKX28OVjI31XbBde7nbv?=
 =?us-ascii?Q?8AGwuf6ufey/ycZsJzZn0lZ3dZn+5oSHOASDQeJwNe+ciDd87PMtFyujkZgq?=
 =?us-ascii?Q?9wS/snofQeb2sVctyXrPubZOxCTdNQ03NzpxoZyhyNoBLl88z0f0uNkSNcXE?=
 =?us-ascii?Q?ChrJKeISexV+Gjm3tkU21y02ZpyTZaBGxkEtmInaD9xMBjlHMsdXCIKWGJuH?=
 =?us-ascii?Q?hiyEm0myRt0JoO4C6RIaqHMoiB6Ih6lrE47SGnHCG+VauAucBQubxoFeN7jZ?=
 =?us-ascii?Q?SXz/wk22A2LSFbaHd1NcBAfJXLFfab7c2io6++UJ2SeUEAPbGAifJ4F+8q3n?=
 =?us-ascii?Q?+e3/0vVpOd9YI+GEO/FtKOBU9D9vaav2ZKQagXwlNi1x/kGEgg5re6VRmXDh?=
 =?us-ascii?Q?TRJ9J+ED48pHtpB2YnvcxHM7MDDxXRAf4mhVhDmSlhSWZ4IBvw+z04435vEa?=
 =?us-ascii?Q?p/fSLztAsQnftqc4T9N6lT2hMtXzNGJsV5qeFtNPNrs4rgF69qy0lhR722eQ?=
 =?us-ascii?Q?KY/71i5cPImhm6/nLs6V6JuyVquWqLfGfdanF/PQAw2k7IB6BYKBcSEteeam?=
 =?us-ascii?Q?mMND313HPFQZLoGwJ4wVSnFaiayjHXQbET9s9o9kbf2aM8etVXVsJ+1MXO65?=
 =?us-ascii?Q?rGMSbcwIoLxwqE3HyC7dNIP/tpyeaMnGr38rC1gRZxc57KP2PlObH4h0ZNUp?=
 =?us-ascii?Q?o4UqFBdn4/RjhgYWUMyhnl+uf5FuHD8Sw05vvFcTq9SWkxuVZtjir9rwcJN+?=
 =?us-ascii?Q?PLhhRamtnGzM3WBRbcy8CkwVt0eoR/y0hyT2he8LDuEv+PesYaXsFHswNye4?=
 =?us-ascii?Q?+UeVw=3D=3D?=
X-Microsoft-Antispam-Message-Info: sa3KEyimwYIuu7hUyYEC9rtwKYD8TOFCLy0ZtzK9WosiHh9mSpxmfHDiGSNBRS9Lfd3MshLW/gjtwdCJOfXUaZO3IbhOgWA3mUBbSGcApMh3vXMa1pTutax+valnT8ZC2/fj3gjaX/qr95SqiBoOWUrjgC5rW99u6ZC1WdRfNNqBl8r3dw6v8prY1X5OBgBw
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2197;6:YnzEQ/5TQSP2EE5NPCKLSvs/gf+u+jRtvUgwBMBiCTncmbAw+PYtvOqQmG6u8sz+7VTmLVPioqUbSjbP7Y7i3P4YIF2P+E3rtjCAmPabr0qf0A6sPoSOSwMfTyBkcxLFlnsl5JjAbRmfOeZ2hMoUcQ3X2Ssz4IOqkC4aRbreJU86z40jRB3tMN1hEXCHUoVByJbpqMIDZgrF7IcJXZu08odK8gZAq6pumIKMsuSEKIc2w59A8cOdT4raHLr4b1HuCJveOG/D+F6HGNP72H3Q5WP/+xo5mbTZUnRtl7gdZaN1WsW1xb0+CrmXuPH7AzIp+q5VnTKqb1TU/POauEgiGKXJj7dqeZeRae1L4EhXSJoDVzBxzSxvsnxyjnel1sxsvqdJE7t730mL2JJx15sFW6x1B7IBIR+fz/1dkQX/VF0aoLbN7MBQW5OTupH/1bInS/Bq3Km3k085TJe7CtiFtg==;5:5RbXTytCWYlMAfqkIT2aI1hpKuakpOutJZlRpysRUkIzZl+GzVeXqxLWd55Kaz1PchIjlxNLp6aPRGcUdUWr82nka7nV4pf2vPbT4ghQAC73AfZRW+4zfsb5LBkLYS4efxI/B6WotwgJo0l8wfz3kio0gQUVTO3ZUkXCNziAdUI=;24:rkzhVICyjDX3uPli2oMtIZPBLfJXft9UE8c8z6dlvd1NWO+07TBHqF7MqydmILxhWCVpR64P94Ur0XxNS1jpt97bdxAiGDZHnlEQ79mXIXw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2197;7:lrOjKI7lQaMsJHjYAXHJx9/3X8ZQ1gaK4guweXk5ElF+0wTxqNVxydPYpKazJ0fH67bOK5drYJ+WveqIfOBNOxFC4dY0+P5+r0Ar39u7CjEtVDtK/2X7PIca8wtb/KYiiZUB/E2VoL9kt7kzylPFJQeHbKITt9o1VOaMVjfOAmi33ZtRGgTdFpbn58z2LHEgXuyfnSYzdrwQO7D3e/Xh2tDRf2qo58yLUcxWUHkHNexjhjV2/kXGfZb/Wn920DoF
X-MS-Office365-Filtering-Correlation-Id: 52659958-8b66-4d8f-49f3-08d5c66fc2ed
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:05.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52659958-8b66-4d8f-49f3-08d5c66fc2ed
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2197
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Firmware-debug provides debugfs interface to all APIs.
Debugfs can be used to call firmware APIs with required
parameters.

Usage:
* Calling firmware API through debugfs:
  # echo "<api-name> <arg1> .. <argn>" > /sys/.../zynqmp-firmware/pm

* Read output of last called firmware API:
  # cat /sys/.../zynqmp-firmware/pm

Refer ug1200 for more information on these APIs:
  * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Add basic debugfs file to get API version.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/Kconfig        |   7 ++
 drivers/firmware/xilinx/Makefile       |   1 +
 drivers/firmware/xilinx/zynqmp-debug.c | 212 +++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h |  22 ++++
 drivers/firmware/xilinx/zynqmp.c       |   9 ++
 5 files changed, 251 insertions(+)
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index cce4e4f..10faa10 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -13,4 +13,11 @@ config ZYNQMP_FIRMWARE
 	  Say yes to enable ZynqMP firmware interface driver.
 	  In doubt, say N
 
+config ZYNQMP_FIRMWARE_DEBUG
+	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
+	depends on ZYNQMP_FIRMWARE && DEBUG_FS
+	help
+	  Say yes to enable ZynqMP firmware interface debug APIs.
+	  In doubt, say N
+
 endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 29f7bf2..875a537 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -2,3 +2,4 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
new file mode 100644
index 0000000..4800366
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
+
+#define PM_API_NAME_LEN			50
+
+struct pm_api_info {
+	u32 api_id;
+	char api_name[PM_API_NAME_LEN];
+	char api_name_len;
+};
+
+static char debugfs_buf[PAGE_SIZE];
+
+#define PM_API(id)		 {id, #id, strlen(#id)}
+static struct pm_api_info pm_api_list[] = {
+	PM_API(PM_GET_API_VERSION),
+};
+
+/**
+ * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
+ * @arg:	Entered PM-API argument in string format
+ *
+ * Return: Argument value in unsigned integer format on success
+ *	   0 otherwise
+ */
+static u64 zynqmp_pm_argument_value(char *arg)
+{
+	u64 value;
+
+	if (!arg)
+		return 0;
+
+	if (!kstrtou64(arg, 0, &value))
+		return value;
+
+	return 0;
+}
+
+/**
+ * get_pm_api_id() - Extract API-ID from a PM-API request
+ * @pm_api_req:		Entered PM-API argument in string format
+ * @pm_id:		API-ID
+ *
+ * Return: 0 on success else error code
+ */
+static int get_pm_api_id(char *pm_api_req, u32 *pm_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pm_api_list) ; i++) {
+		if (!strncasecmp(pm_api_req, pm_api_list[i].api_name,
+				 pm_api_list[i].api_name_len)) {
+			*pm_id = pm_api_list[i].api_id;
+			break;
+		}
+	}
+
+	/* If no name was entered look for PM-API ID instead */
+	if (i == ARRAY_SIZE(pm_api_list) && kstrtouint(pm_api_req, 10, pm_id))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 pm_api_version;
+	int ret;
+
+	if (!eemi_ops)
+		return -ENXIO;
+
+	switch (pm_id) {
+	case PM_GET_API_VERSION:
+		ret = eemi_ops->get_api_version(&pm_api_version);
+		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
+			pm_api_version >> 16, pm_api_version & 0xffff);
+		break;
+	default:
+		sprintf(debugfs_buf, "Unsupported PM-API request\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_write() - debugfs write function
+ * @file:	User file structure
+ * @ptr:	User entered PM-API string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Used for triggering pm api functions by writing
+ * echo <pm_api_id>	> /sys/kernel/debug/zynqmp_pm/power or
+ * echo <pm_api_name>	> /sys/kernel/debug/zynqmp_pm/power
+ *
+ * Return: Number of bytes copied if PM-API request succeeds,
+ *	   the corresponding error code otherwise
+ */
+static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
+					   const char __user *ptr, size_t len,
+					   loff_t *off)
+{
+	char *kern_buff, *tmp_buff;
+	char *pm_api_req;
+	u32 pm_id = 0;
+	u64 pm_api_arg[4] = {0, 0, 0, 0};
+	/* Return values from PM APIs calls */
+	u32 pm_api_ret[4] = {0, 0, 0, 0};
+
+	int ret;
+	int i = 0;
+
+	strcpy(debugfs_buf, "");
+
+	if (*off != 0 || len == 0)
+		return -EINVAL;
+
+	kern_buff = kzalloc(len, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	tmp_buff = kern_buff;
+
+	ret = strncpy_from_user(kern_buff, ptr, len);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the API name from a user request */
+	pm_api_req = strsep(&kern_buff, " ");
+
+	ret = get_pm_api_id(pm_api_req, &pm_id);
+	if (ret < 0)
+		goto err;
+
+	/* Read node_id and arguments from the PM-API request */
+	pm_api_req = strsep(&kern_buff, " ");
+	while ((i < ARRAY_SIZE(pm_api_arg)) && pm_api_req) {
+		pm_api_arg[i++] = zynqmp_pm_argument_value(pm_api_req);
+		pm_api_req = strsep(&kern_buff, " ");
+	}
+
+	ret = process_api_request(pm_id, pm_api_arg, pm_api_ret);
+
+err:
+	kfree(tmp_buff);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_read() - debugfs read function
+ * @file:	User file structure
+ * @ptr:	Requested pm_api_version string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Return: Length of the version string on success
+ *	   else error code
+ */
+static ssize_t zynqmp_pm_debugfs_api_read(struct file *file, char __user *ptr,
+					  size_t len, loff_t *off)
+{
+	return simple_read_from_buffer(ptr, len, off, debugfs_buf,
+				       strlen(debugfs_buf));
+}
+
+/* Setup debugfs fops */
+static const struct file_operations fops_zynqmp_pm_dbgfs = {
+	.owner = THIS_MODULE,
+	.write = zynqmp_pm_debugfs_api_write,
+	.read = zynqmp_pm_debugfs_api_read,
+};
+
+/**
+ * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
+ *
+ * Return:	None
+ */
+void zynqmp_pm_api_debugfs_init(void)
+{
+	struct dentry *root_dir;
+
+	/* Initialize debugfs interface */
+	root_dir = debugfs_create_dir("zynqmp-firmware", NULL);
+	debugfs_create_file("pm", 0660, root_dir, NULL,
+			    &fops_zynqmp_pm_dbgfs);
+}
diff --git a/drivers/firmware/xilinx/zynqmp-debug.h b/drivers/firmware/xilinx/zynqmp-debug.h
new file mode 100644
index 0000000..3303b37
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_DEBUG_H__
+#define __FIRMWARE_ZYNQMP_DEBUG_H__
+
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
+void zynqmp_pm_api_debugfs_init(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { }
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_DEBUG_H__ */
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index c764d6e..83d2699 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
 
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
@@ -551,3 +552,11 @@ static int __init zynqmp_plat_init(void)
 	return ret;
 }
 early_initcall(zynqmp_plat_init);
+
+static int zynqmp_firmware_init(void)
+{
+	zynqmp_pm_api_debugfs_init();
+
+	return 0;
+}
+device_initcall(zynqmp_firmware_init);
-- 
2.7.4
