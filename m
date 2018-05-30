Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeE3U6F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:58:05 -0400
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com ([104.47.32.45]:37280
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932320AbeE3U4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:10 -0400
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
Subject: [PATCH v7 05/10] firmware: xilinx: Add clock APIs
Date: Wed, 30 May 2018 13:55:20 -0700
Message-ID: <1527713725-1086-6-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39830400003)(346002)(396003)(376002)(2980300002)(438002)(189003)(199004)(39060400002)(426003)(8676002)(107886003)(7416002)(5660300001)(48376002)(50466002)(81156014)(8936002)(36386004)(81166006)(6346003)(76176011)(77096007)(26005)(186003)(106466001)(2906002)(47776003)(63266004)(9786002)(7696005)(50226002)(51416003)(54906003)(59450400001)(6666003)(4326008)(72206003)(478600001)(2201001)(110136005)(106002)(316002)(16586007)(356003)(336012)(486006)(305945005)(44832011)(11346002)(2616005)(476003)(446003)(36756003)(126002)(921003)(107986001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1447;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT063;1:hjHYB3EyCaB+A1Xx3+P8K9xPHaX3FmxWwn1rnZOU/h9UQ3vTZbmAXP7BDabpYYvqGIjVCt9ntoyzfJtItqiSfJ4GHiZkkIO0zwadk86hQQAp6yO2iajmMUQkP7dkT1oC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR0201MB1447;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1447;3:tbf6PRWdimamtxdCR5LW2C8jfVO8bFTpUZ1z1+hnUVJCBuReNWYJyZK9ffPgWziWE/0TLXAES6AC22SPn28WOSrTkV6CGFJt16nrOK61Vk786ZjFYNz60zH/72c+4GloYDvS/VvU1zQRmEii9R/YHF46qa1coVy8uZ1N8W2bsZSZ57KKgr81FSxfkGJ5LDoCMvXiw4NFvpv+x5li2zdPjm98BI68U/vS9W8lC/2GxIP2mgnuVOQj8oDolopMXSi4z+/67R6Lc6Ghq+OMkrW1pObEOQS5NxK8T78i2pYucxYdsXZxVocfHoZxkQYUYoRMbZTE5hb1vN0/jR5dFEDnmkZzJBfiIOtK0RlFX0TZge8=;25:qZiRmlIWbpBWT3gKoBPQJFYxTfhXhIjorykf8Jl3+RsU3VK/X2smdP6+nYNjxBTB5115iC3m3kF3VXvkkbzr4uqRX611EvLgWrgw3PdF3+o8ICUqhH0OYQ4RfNPHcKdPYBWI5e3oiOps4U2nPvAukeoDSFyuHkgWp+2W7jz9ApCHh+Cr0K3Z1sDdi2fhL0MKleqN/eTDInxXZm1R392TXP0YZ3d6v3/xaxd2FD9VzrYLnh5yFeaQz44PK7PBra8zNyl2DirQs9meA7NcNdsAbvJWa61XEXi0YBq0R0RrsWQANQY7dzKcnQU/UlEJDZvNGC/ZV/GePFJ5LLW8dklfbw==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1447:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1447;31:0JNsnsPbFSUUBY+yUx25vVKmOuxjW5+9jCA0TZZkV8hk3mjKUiV1D4UjvuHV+BCtlOWqHlm+bsn3z1K/YI/XOfuGIK3blIoAxE/ebR8vJL3w7EuldcyFZYbMTBO2gGIfyoqSA6SOCfXlKT0V2o+sCD8FuY/1kvr2sLuL6OYIILJvZ4wZrfa/3Gv4aYfQsaqT36TaiUpEJnatiPRZkxko4+bsd4lPFVIdQ1AM117/mHY=;20:c1xi13E9w/zDnfJ9Qef2/zkEuhXLOWBmlbT7yr1THfkkzYZga9Ji1HSvg9cTbwJQLDdGnbfIN3ABR1whODkRsUrFVKc3bw5+oruCYxOtT80EM5g3lkkZzIHlwJKwJ5FssDtFTx61ng1lL0V0QeFqmvqWck+HmYNG2H8MFBwH8PKkx4aDQGhgKoJDBd36RipaYyLGcNd98xilbSdVUJXtC5DBXTvsnanu3u/QfCbWBF09WxKw9dNsdPmqAiwWf/iDrE3TWxrX/+3C8Cc6qX28zsq2P2WVYwhOGv3jMXKftYI3rF7j9HMzbttlLuzhg+7tTizj8yGdUpdzdkuHMQj3Ph5xiuobtaHvV2FRifcZObZrevKW23ibcSvK6HLhrc/rptXV5Go8IbY1JIB1xlnydySJ23Z0uPtLPB+fvYJLYVDE0JhxjRCJnpYomQ+Au087y3PU799lFDjqksVJs/gXAsyIMURNeL/Cz3spSRQfzf0WEP7/JzogMsRVL9mWG5AT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1447A4E495CD4FB8D63EE939B86C0@BY2PR0201MB1447.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR0201MB1447;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1447;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1447;4:rwDa8xHM6G9etxP54Th7AT8e8tt8ey2ac2fn5AGaTi3Qw0pY6PIO90lZxG0zhBPF+qVzakA8Vz1Ngf6XVKNgDx6lCdv5egX7ur56l5xzzQLzOOFh4MigYhBQD1KxjUzdaeof5oeVVwYXsItvy9U09F1bMOjkK13oHog1JwDp4ad2yIAH+y2fQbmYNbnenllztAPWwk4gkUUmWXXUEJLIRNZm7Hygc+IdmzXfOAYP+3wsqzkegdBrfcRsbKZ5jK9gbHSta/JdCDtFnRt2kwcZAjaptmPTn1soc3/mrRqOO1PwE8E76upq3+iFXkB9cEU4
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1447;23:F27BCjg6xs99Itq2TM3NlcJQvhzdVxtNGNeetQx?=
 =?us-ascii?Q?xf/ciOjFgK+RqZVTFL2mkRRuHNzJ0VOirO9MaKXWc1vu1KXotPuS/mbHqJvC?=
 =?us-ascii?Q?mJpJUJNDO2ODPpryOeLtNVKidYcg0K5bIdF9YeEUr46XNT4iKUhPnP+z2YfE?=
 =?us-ascii?Q?bOcoOfC/3WIuLjFzKcoTf159z8lR37RizJ92xFlhKl1JxOM21AZ5QItEP58H?=
 =?us-ascii?Q?s8yYp1LkrWvRFYPLrhENVBE77HBh6HBWPZeYYe0Bu3V5DdE04IDeFpb01SRd?=
 =?us-ascii?Q?vmbXlye6nPDmxHBw7XYuSTblw1uKcLTBCdHmiN7ayeBl7r/1FGh3Kc9jA+tF?=
 =?us-ascii?Q?rAOnYDI1A2qWDRzmqqYwzyNvJQDOq93w3SxVaKH5tTyT42Gv6zw6G2WFstHH?=
 =?us-ascii?Q?bsBeC1EwqhEXptQEcVWtWAok3ShiJBATOQEXg/atnRK3X99MGQ7JFJYmI83T?=
 =?us-ascii?Q?3Cdry3USZirbhQBVKVC2U/2GueKeUH9ltjQiSFUVRMbPuxgbpLITKovmnukh?=
 =?us-ascii?Q?k/M+Rm2IqOmN+pL2bc2z9JTzujNxiwZqX9hvAZ692+mTUNSpdrxkCzbOnBvd?=
 =?us-ascii?Q?o4eZH/xvS/aOHDvcD1jQjFRdNQ9V46QOTn0fe4tuQE34+3IJKhR4Pt2G7373?=
 =?us-ascii?Q?eK8bklIH9/JUgAtEXrKAtaXliSxu8avzhtPSl71gNufwNGNQlc8Tq9ogLQHn?=
 =?us-ascii?Q?vgee/49G92txFZOC0Pyk0ui1j4dzKjwYplrw3jmLXcACIcSdy5QaHdYQVLUY?=
 =?us-ascii?Q?J7QnxPp9+9mp/DJlI374Ix20q3iM0nl4EPTSi/wkVw40TTuD5MqjRrMjNexC?=
 =?us-ascii?Q?9dMJiEDPh/rBEw467F12nyJLL684jud2ZoIbkKWzQr4J9ojPSfAGzbTL2rma?=
 =?us-ascii?Q?D6pDXdpK/fecvZ36Vqd2FJSROFu7yfWU0SDMs5CGhfhhu3YjvBzjAaAjE2uc?=
 =?us-ascii?Q?bPo4+rpcerps085PPbkN7xClBIXoFdtst8IDNNYIVjxgO4LXaNIhY0++kBHV?=
 =?us-ascii?Q?1/K+6O0aKh/caxMBV0uENKhfmEnOxYYsOLPubVBHyXhDHG59duQIvEC2SDip?=
 =?us-ascii?Q?t3/wv839wWJPVOU+vyVoWuH0+gLTaDgOxI8bGTnagCFKbMwVhWA8r/+cFMbC?=
 =?us-ascii?Q?CGdcmk4ivykKXpEQE+Zr36SmW7dvaVKj82RcKQlRce3YljtKEzBpLIFN9/Gf?=
 =?us-ascii?Q?L2KYTwtFWpEVDrRLu4iLxuftQn/m6DkJwxkmZKQfr1MKigDz6uIUY/7tt9j4?=
 =?us-ascii?Q?7G8qgMzuEWvVPg9sNUbgNRNk24U63FXV9PlmUMqVgV5r1yymA2mu9t9k8msw?=
 =?us-ascii?Q?ePTSc1XWOVpQ1ecF9enjp9hLPFhoLrNsm0wzFsan+cbKn?=
X-Microsoft-Antispam-Message-Info: dDsqsS8jYULxRD1AeekmjQt9UUDQX+Vd9sp80FhwkptZ+ATI0t8tkXVq/J4NBOnDDJDOsBN2STmO2c39z/6o4PiezoqKOUihZybIz/sUKyNP2q0rYth/PFHlDEP034AVq5rDxJhpk5pQK7jrORWgMHUUGtqTw+r8U6S5h/KRJATAu91TfVRCaqVtSrJ0JuzT
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1447;6:isoD5wUQA4CDGuLNGtFS0Gd+LVSAVHmfgp/wXnIgsB4aUC2fuJiqrR7Grm8UYWh9/KHqzHiWYB5eqrrpygYoI+Tcjsa+AjtHjfiHPDpVNtKUAepwYMwb8+vHW1+gmTl5VX3pBF2grQT+yzQs8hQrbPtFAiTlb1Tx0T/W51rpiYVuPPJVPtk8vMI3LEDvflSLN20Ea620ov7nCKDwmCLCSlScnmD4z9zwdEHU+UvthBRSbdG/uyq2VGEO/Vn+L8Ru52uwQZJ/P8Sv0nEhVNI+bP1YMvU/sEzlxyF95MpwxfgPZKnjzNGrFcNR+0V980qo+8HfMY3N01Wn1NXjpFdrBZw25RhdwEF2IMc7VpTRur8J8A6LMRa+AZgAV5EsN4twPLaOah2B3jdgHIrEyJCiDo+8X4ak5HrmYZ+O2FYsB6DPrXM5xRXl1TJucCWRYrG4wnv2ANdoMPlHaJeQFrqRHw==;5:x83YvmZP1UK8Q7r3xUpVoSvj3SAWm4QMCFz21PGJGfynchHJVV8S5MsJSX+CRcsmRy9Ve05LP8Fz3uiIXRJce/YI6VU+1OWkHR9klZwYP+jqWfY8bK+yyUKGC+0mv5HcGLAB9YEHPzzPYEw8nwAhVOCXv7nl5KryA2XDvqsAoXU=;24:EaPK40uc2DQE/eYNzhzJQEL/L0xlKJg75oAi7dpbaXe0YsGgo5ER3nZ4rp4F5Qk0sDlvYrQxiVzIBBdD+1JAAOGC9hQJZYbGg5vXADkdDe4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1447;7:NJGxu3zLz4ZqpMr+0sjCiQp+bOKKhc3IboKb9G/BzqhtkMdFFg7Ovi8jHVsI9WWvb/S2ago4OObRGYP8daFGLiZUJWiVRlpNnug55XsY5Et85jczM72DPF3ZqF9S84bSYvhKOoUm6LHsEEs0xV0HKiw9chd/22gQ3mfrlf6q+YGS6yHrWOQkHQ9pe+DsxGB/TXDyvyumbiqZJhaJnn+P3N/yKDd+s60mta5W/qqOMjzQZJHXnFWvlRcns33xCpOX
X-MS-Office365-Filtering-Correlation-Id: 1951b015-b2b6-409b-f0a3-08d5c66fc343
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:05.5597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1951b015-b2b6-409b-f0a3-08d5c66fc343
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1447
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add clock APIs to control clocks through firmware
interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 186 ++++++++++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  30 ++++++
 2 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 86d9bb8..c764d6e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -269,14 +269,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
  */
 static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
-	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				   qdata.arg2, qdata.arg3, out);
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				  qdata.arg2, qdata.arg3, out);
+
+	/*
+	 * For clock name query, all bytes in SMC response are clock name
+	 * characters and return code is always success. For invalid clocks,
+	 * clock name bytes would be 0s.
+	 */
+	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
+}
+
+/**
+ * zynqmp_pm_clock_enable() - Enable the clock for given id
+ * @clock_id:	ID of the clock to be enabled
+ *
+ * This function is used by master to enable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_enable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_disable() - Disable the clock for given id
+ * @clock_id:	ID of the clock to be disable
+ *
+ * This function is used by master to disable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getstate() - Get the clock state for given id
+ * @clock_id:	ID of the clock to be queried
+ * @state:	1/0 (Enabled/Disabled)
+ *
+ * This function is used by master to get the state of clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*state = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to set divider for any clock
+ * to achieve desired rate.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getdivider() - Get the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to get divider values
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
+				  0, 0, ret_payload);
+	*divider = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setrate() - Set the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to set rate for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
+				   rate & 0xFFFFFFFF,
+				   (rate >> 32) & 0xFFFFFFFF,
+				   0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getrate() - Get the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to get rate
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setparent() - Set the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to set parent for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
+				   parent_id, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getparent() - Get the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to get parent index
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
+				  0, 0, ret_payload);
+	*parent_id = ret_payload[1];
+
+	return ret;
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
+	.clock_enable = zynqmp_pm_clock_enable,
+	.clock_disable = zynqmp_pm_clock_disable,
+	.clock_getstate = zynqmp_pm_clock_getstate,
+	.clock_setdivider = zynqmp_pm_clock_setdivider,
+	.clock_getdivider = zynqmp_pm_clock_getdivider,
+	.clock_setrate = zynqmp_pm_clock_setrate,
+	.clock_getrate = zynqmp_pm_clock_getrate,
+	.clock_setparent = zynqmp_pm_clock_setparent,
+	.clock_getparent = zynqmp_pm_clock_getparent,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 354385d..29fb352 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -36,6 +36,15 @@ enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
+	PM_CLOCK_ENABLE,
+	PM_CLOCK_DISABLE,
+	PM_CLOCK_GETSTATE,
+	PM_CLOCK_SETDIVIDER,
+	PM_CLOCK_GETDIVIDER,
+	PM_CLOCK_SETRATE,
+	PM_CLOCK_GETRATE,
+	PM_CLOCK_SETPARENT,
+	PM_CLOCK_GETPARENT,
 };
 
 /* PMU-FW return status codes */
@@ -49,8 +58,20 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_ioctl_id {
+	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_GET_PLL_FRAC_MODE,
+	IOCTL_SET_PLL_FRAC_DATA,
+	IOCTL_GET_PLL_FRAC_DATA,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
+	PM_QID_CLOCK_GET_NAME,
+	PM_QID_CLOCK_GET_TOPOLOGY,
+	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
+	PM_QID_CLOCK_GET_PARENTS,
+	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
 /**
@@ -71,6 +92,15 @@ struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	int (*clock_enable)(u32 clock_id);
+	int (*clock_disable)(u32 clock_id);
+	int (*clock_getstate)(u32 clock_id, u32 *state);
+	int (*clock_setdivider)(u32 clock_id, u32 divider);
+	int (*clock_getdivider)(u32 clock_id, u32 *divider);
+	int (*clock_setrate)(u32 clock_id, u64 rate);
+	int (*clock_getrate)(u32 clock_id, u64 *rate);
+	int (*clock_setparent)(u32 clock_id, u32 parent_id);
+	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4
