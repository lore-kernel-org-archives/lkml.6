Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932477AbeE3U42 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:56:28 -0400
Received: from mail-cys01nam02on0082.outbound.protection.outlook.com ([104.47.37.82]:31398
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932261AbeE3U4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:08 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
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
Subject: [PATCH v7 04/10] firmware: xilinx: Add query data API
Date: Wed, 30 May 2018 13:55:19 -0700
Message-ID: <1527713725-1086-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(316002)(59450400001)(72206003)(5660300001)(9786002)(8936002)(81166006)(54906003)(81156014)(110136005)(8676002)(7416002)(16586007)(106002)(106466001)(356003)(63266004)(2906002)(6666003)(48376002)(305945005)(36756003)(50466002)(4326008)(47776003)(7696005)(186003)(77096007)(39060400002)(426003)(76176011)(107886003)(2201001)(51416003)(26005)(478600001)(36386004)(486006)(2616005)(44832011)(446003)(476003)(336012)(126002)(50226002)(11346002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1456;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT059;1:7cWukyU9fRs52oC0vZGtUQYS3HKYP/XiHOMnpEnQJFR7bnl2c2HNbksff4oEXNn0YpYZZJBl1SgOiLYM5o1Ia47Ufqu4UKiWYPfswEIb1YfJYqSPvFPLXLQ6jfsIxHEL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR0201MB1456;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;3:lmQbqjaVSy0p2itmazM/h08n57glvPUvG6HeonVjFz2A9+rY/6d8orQZ9fd0n1yfR+eThWfKRGJWu67CIE8hhXlWZA48IYTPAwPKg5I+U2RUk0xd2HVyw33zo7dUQ9PKagRQ1b1eSMwJ6VpDhNr6WYHV72ikCtjUCGsviP11A+snpK1sTJBWkAYqTPjnkLbLKtG37hjWzVNBB9Kx2ZuIxGDbD687AzJ0+tWUR7MMk3fu3nYaEPV97dMA9TfHyUdouPsEXmikmqtyGqifF+C7TsYKEXyyX10iBW09IDx0lQleKfBZRXRduuuSse8RSNE+asalGM2jJ7myyjl+EeBB3fhRMazz4S9o4YvBs29APJg=;25:wxoZ2Mu7fZc0/k03+LLazQXjcHfNr/0vDJE/Da07dWlfx3aLHhxwc+PsJSsKMiR8wfy/QD4DeveKMglGRRtwryXqlWPYRcIKnXe/0GxHR5TYmWyfc6IS+sONjLSnOyiWMihWyarJqzp7lahOM8DQ0jDRQXW3sPUJMABELGy83WxeISw1p0I/pFWWw9rOoHxys3TYQVpecof8GcBQhEzaOuc0SP/E2yQusdgXDVVYXpv8TM5MoOi317i4nVpLe7be4640RO7c16alWf3ah4ICzxBhxrM5XNPcmFNnL+ExccN7HkxLcwJv6tS5A9jjOVQXzxT/7V9zDl8FIfRtPHx7QA==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1456:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;31:4Ben5QxMEVrLWVUXrjRakH9aZcAMd2/F4WCaLZpXZ87yF+cgBgyUHi0xid4PEci9jvt2OW0qaIZnBJyKEtZi9vErcr1IcN5HiRo0k8G0Bh0OM7E+niRGPyyfjAmkcxPBgGsRLUmointYS6qU2aoNAntMs+CaNvH1SBn9BE8vCvY0c9jeZGj44TxGYqbBNXQa508zJKdwo0yKXSSbqedeVC8cWRT5u7SctItXXB7uA4s=;20:NE+wFqoGZI5qdKCBQbuozgZMAhtIOBEqiEJ3s9KLpTzOPYXxb4CVYqVbnnTU7RzSqNLu01APoRL2qU8XeUP+pX/icZKQMSP7Zuf8YF/nJZg4DIN/R7Phsy0bGuHcjPkqXYI62CXXRcS19VmakjMunYdKl22aqfg/oObINqxSnwDH3ifhg7Lqy84LeFKZi8YgfRH53XNLBiG8zFn26u8coA2G6jse4iyPBc+A6DPZOwwFpMjp98gxcE3WcucFc4OIo5UHZoBjYLItwP571c2gDYVaQ3iW8K4edy3nO+L8dUIoLAP5cSHgNNh4YpvZ2qtoIMlnxVai4K3szmKlb7MblAZ6jIK9LPasnF+1r0Pk7ulpiofJQpN8q3VbUUbPb35DSpSJR7ICo7LFMuFHki4FkBk57sZALigyhoYVtpvE7Csy5OSC9Nn1NXmN4YOhZU/rAt3zRnKzvHN2ec01YSCSaAYgBP3mpMZIvtQQYEjSGeuySlemafTDj/IWgntLmi8L
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB1456CB46D697E6748EF8FBC2B86C0@SN1PR0201MB1456.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR0201MB1456;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1456;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;4:xXCqBe7mTXJHk1VFu2Eck3xwtnEsYxT+wxyQ8SU+ZCTgcLfKYoH+I3qkhWXjanrQI9J5W78bktjpF7zk+0Uze+GQLZOqN2CJd3TLgekUmtOB6Xvxj26AMPtX9Zc4ozlF5PhMHqeXiqmNrBelqLsTrJn7hNDif8qawoptJwcDG2ylPE/NT3pgZM7XvKbN7JGy56hinRrx1X+UqTbmRSt4p3NvTD2+CDZGHNDLyPGfz36axjwHfs0+6vIjQ7v+A3NykxvmCXgfphugNs9+m3Vv6yPmcJSXbGPkJXmZ2r2SyI/NA45hSGUpDrvMr/7FeyhD
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0201MB1456;23:upW5GU98KgH4VLR9ChKgKErMkcmuguZ41S9LgBQ?=
 =?us-ascii?Q?bitKrudVH/L+8Mw954+bFvQ3OKdaiMPohWjivqx09afuirV3ptm74SDNDs1k?=
 =?us-ascii?Q?ioV5SmtfjZBOkd4UcEzoMrk+6/By+/CHJFxyK3YtfU5I6BhAxFU6Bx7MU2+w?=
 =?us-ascii?Q?7iLwlzVZhtVOTqJAMO8dNzsScAR5g2LxN3LXPbehOHIAJh6bOn87/DiavhkH?=
 =?us-ascii?Q?eeLaPCUNmSEprX0tixexNQN9IJhgv8u+dw+ZaPYAFLNzMlQdxfrueD81xf+E?=
 =?us-ascii?Q?U2LNq+9s2O2qQXghADyi4o6W5kUrumQUHEykqucvltXydfupvBYzlfpuVFZC?=
 =?us-ascii?Q?SS+/SVNHZkEFq7kWbVXQQdVrMQ/A/Ra78LcJoT61rOUqjpu+PAagpJ+onAri?=
 =?us-ascii?Q?OnM0SZIay+OD0/2v+99v106H52isZl4tHShjI35yriQ5m+n0MQep/q8OuFjT?=
 =?us-ascii?Q?sBOXXkKrEuLF6ybFIyHQluWW0113d8grpjzn8vatRaXw3oNObdrXLhr0lJu+?=
 =?us-ascii?Q?n0v7JyjIrrtiNqtC0CbT1CNQTtOvAoPSOnMF0bB8Vtn8nv9aI+urmd/xIUHO?=
 =?us-ascii?Q?KX+bu6lP4uo3LwheZCjPHhNyCRvgUTz/CkfwDBBDXE6RraeEAVfBFVySUJ74?=
 =?us-ascii?Q?PuQdzULMgXhl2gpOM/MPrG87hTZXaJNWM40UIehwruH+2nOQU6HcwNLlvnIO?=
 =?us-ascii?Q?fSEL7w1MqnCZbdkRi38RT0y+QsZezrH3F8XAVKAwlz9Cbk12+r6XHROUspIv?=
 =?us-ascii?Q?V6QfKPJo4aOieJIKe3LnT5tx33JLt4MB8J9a/FmTBTEmB+aolyb4mrt9tDG5?=
 =?us-ascii?Q?x6VBXO2Eh2fqwp1xDAaBnr21jFccH19kwE4hslWtnR4XCy+xXO4ENgVf11O0?=
 =?us-ascii?Q?zRryl/h5FhVRZwi3+AwLuQ5ymnPSQKdC2exdsSLfciXoyJ1OX+ZbkaVNr/Z7?=
 =?us-ascii?Q?4k7B7RbSZkXX6wZ3iRyAz+y7Oo+PBzDGHK/CduoG29qJ9gv4WLgmFLZfqY1r?=
 =?us-ascii?Q?eyr1Y1siPpE0DRxs7Mp1yfPddXrctQT+Ob1gE17s0rHVHFG2Pg4LqyKPzqyQ?=
 =?us-ascii?Q?LF0Vq1XS/VKT/KDL1Knovu7LhRfB5lwdhoyF52Oaev05EbiSay1JE8onxLms?=
 =?us-ascii?Q?4dNqzn23eCrjP0e67gxNkwPFQT/mwsdsSZmPt03lciJ4ahl0iEhoyg3wn+hN?=
 =?us-ascii?Q?zyp+nybphS7oKZ7q/wXOswHBldWIV6iYqywxqZ00Xk/VPP12P5dmx5pY/PrB?=
 =?us-ascii?Q?8cvEFMDKLFCWQFrKfXJwxGAEdSZglhyEyo7s8V7HEb2YqZj9G/tCu954U/wV?=
 =?us-ascii?Q?WWw=3D=3D?=
X-Microsoft-Antispam-Message-Info: REzzRv5Xsjkhr7rtM8XB8cA53BACF6vB5CUz1Q65mFxk8Kbgwus2asJMti8xyT1LLuU6PNr4cp44xobYpeGW09QyXQmB2k6q35UdUSfSK07uEBQzfek3yHXkaYrV+zZ35jJSaKB+8I/7N6QYIF2dGuwNLg67xnZgpQJ77jfUvcX6YHGULsDKeJ+xlsrL1u8L
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;6:zgXCnyECWb682Qjs5VhXGUBbKjrreaHwAae9nLnQ8TDCdbUAl+/pUtp5MpWmpB3suIQFITBTUx2En9f8esQ05kOSxYp09TWB8TTwGUJju9OY5gFU09Ivn7+2aPjF5CopkWs7tooQhvQLogNJwwPczqMo/TwU7618H3m4NvTgEyKpwfGdVS838shLdN8FSQ+SVbOe5jEzaqA8dKUUDmyfKO8FkeJsCygf5ATqAzY4L5CHYym5JSGpv44E9ds9Sc5s5G2iMh+2dz5VDWXNanmR95ByV61nTioPI7GU4BZLRi8kvUP1uRmytlG3ZODuiNTcSDi4xNCgZidB7Ogn4pNQ36rSQTD5Z1VHGvHBKhSYTUvs27UB7URyYMDk4h/XlWnbWLbKnGslm5JN5gdmMD/rZvXaN0Fqv/Cffjawqc4gm8RgATmFa8ahE8cNJt5dpY6gQf3kNbHbZnIqfOF6Q7MLFg==;5:QqOSTC+PYdsY9QCIcG3s27dfJj/jwXiNNX2eEQ4J9tVQjrpaa0xeIsCpM3VtcaldqxDCzEBjtg7qD9WAvbD2Q3qcSil7UDSiX4Yt3BV0CKe1OH3h7MDGDoO+a/ddS1fzS8iBehbE074R0evOXa7MTz2GShmivFw3QqzfAjZWwxg=;24:ow9soHxWdQqnwCoujQQDubI7A+XFOVK+ROU0tFDBoLRt4O2F+vyuvTrpgJn8ivtmxzogwVcdypW+0K9yrY6rwucxezBAknLEgQGxukh0u5E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;7:MqT4C8QKrxVpjymb1NGancuETObSr90eaKQxEeobBbupiTtFikYYZzueXktNZYmPmp0TJhWTGFDFLiSPQn1gOBXy5PxXttxvFHu89phe4scs+qLktxVHvdvWW/1HvS2VQqHHUbzcczNPhSWCRPU0AqcjEhfhxB9D71N03dKHN2ftQqSvsBd0D5RrjG7yDVYOtzlnqm7OlV8HenOqmQ0HTBt9UHNHu2GRojz3vpe7aXjZTBpKbAeNApXr1Om+KU2T
X-MS-Office365-Filtering-Correlation-Id: c95275db-0521-40b1-0050-08d5c66fc30f
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:05.3377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c95275db-0521-40b1-0050-08d5c66fc30f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1456
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware query data API to query platform
specific information(clocks, pins) from firmware.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 34c5ad5..86d9bb8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -260,9 +260,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_query_data() - Get query data from firmware
+ * @qdata:	Variable to the zynqmp_pm_query_data structure
+ * @out:	Returned output value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				   qdata.arg2, qdata.arg3, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
+	.query_data = zynqmp_pm_query_data,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2eec6e7..354385d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -35,6 +35,7 @@
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 };
 
 /* PMU-FW return status codes */
@@ -48,9 +49,28 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_query_id {
+	PM_QID_INVALID,
+};
+
+/**
+ * struct zynqmp_pm_query_data - PM query data structure
+ * @qid:	query ID
+ * @arg1:	Argument 1 of query data
+ * @arg2:	Argument 2 of query data
+ * @arg3:	Argument 3 of query data
+ */
+struct zynqmp_pm_query_data {
+	u32 qid;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4
