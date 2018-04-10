Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx49j6W9khhpdafMFSJQIJnmYYMV3PIyM9V5hsEyjUnN4yKDRWxU0WCO/JJQX1Jo31YARDryM
ARC-Seal: i=1; a=rsa-sha256; t=1523389175; cv=none;
        d=google.com; s=arc-20160816;
        b=0Kd+nlksHLhuOWJMLc+beH2FsTst91zXvIxxXAKeLz4BEMZ4EfBmIfsow1Yb0jcKGD
         U6zYsHL4fEuBzCi0D4+oUKdGSfJUSgiVrDfbkvZKP+1ZNMyQ6O6zmFAADpbako6e0seO
         6NzIUnOiou5cMCEuMhP9cJM8ozZVJ2kBsrNBwaPpj/OAgUejFQlZ+sRPwt7ZjSGjUG9d
         RMYAYcJ6nr5QFM8Tco1pQSKN2EFwt5tCPgadSFcE9Fb2AfKQTs/km3o7JOkYrOhqTC/s
         tCH9s7IzaV7LfSI8HxoeHozRaGHtxk2ChqhzXdcCK0yGC0ANfRqZneMrkRJA/fUXyuVT
         LgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=CbPBBPBb7xncETjWzC3iWhS1l5FpwZWJEUEv+FFe3Vo=;
        b=OJ//mwAOMZHH84HMGZWvNPXodqQf5nh2UBDKJrO8EoGYmVOif+y7d7RCc5i4mS3myc
         0bRycTvQVNxb+rTd2yq6oY7Ub+5xrttIgvNS9uVGQZ0Qlt70yJkj9eFqWuAKGzAsoWrn
         7MzHVFP/bE2YpIiftorz+7puwu1I+wHFyFAxRwmbyzZ+RGBAnvwcbZPJXoiojCohUUVJ
         v7dX9JEGJ8aGFIthkIIU/kmQcOHttcGHsunDbiC+SlxPP4RIa/QpXj99j6SbXhNv03wT
         07joMDhetd3od1XQRmyaEnFJnVx3GXuia61uXPCwZXjGYQySIBUvTVz8nbH53t0fqilr
         dlLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=MfPlKBWR;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.42.50 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=MfPlKBWR;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.42.50 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jolly Shah
	<jollys@xilinx.com>
Subject: [PATCH v6 05/11] firmware: xilinx: Add clock APIs
Date: Tue, 10 Apr 2018 12:38:41 -0700
Message-ID: <1523389127-14243-6-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(39380400002)(2980300002)(438002)(189003)(199004)(478600001)(76176011)(51416003)(7696005)(72206003)(4326008)(39060400002)(77096007)(26005)(106002)(186003)(2201001)(426003)(106466001)(36386004)(336012)(47776003)(36756003)(107886003)(446003)(356003)(305945005)(81166006)(81156014)(63266004)(8676002)(50466002)(16586007)(7416002)(50226002)(2906002)(48376002)(9786002)(11346002)(126002)(54906003)(6666003)(110136005)(8936002)(476003)(2616005)(5660300001)(316002)(59450400001)(486006)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3699;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT022;1:nhz3WkFMudYdpExli2wjS4uUtviIMW98YlCVqIzs4Hofy46Qunj8UoHhVW5W2/SqKrfv55Hl1/OLX8t18F5ykwL6At3CAX9ita60u1A0ewglYwpKAYkDtdFFuNOj6BVD
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB3699;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3699;3:pfcXry55GEowdZShpkrZVPJBqUKDoqJ9+Vn5ljY7EdHiB+x0QvXGbwCwrFhDrtJz6oSiYOvN/vkTSUm8C6AZOyFqnmQycoZDpuabveysFiQRlK1Y2j+4M1N6dCjaFXsI5vEoSHT3mcGLzs4NX5YNd5Tqr35tEel3U2qve9W/LUAl/egk7hWChP11XG7fFfZWw1bNgRysxEXNe7dt4voWscaolpWnhAC5rbBuqi5YIAXblTMENr5a1Up13gIYaAUUXCBZeICpKoqcLHCYpNxHM82HrYYNt0HTI759D2WBVd+JNrVRww9pI6wq8gjQcONBJG17fJzvk7MZgqj4ui6N14aJWEocjHz07ykdIkePePU=;25:LMLVY9K1JnUw4J5MB3r91f+TgfQU6JS+//dOhXmX3OA39M/EXYX8H4EmGqHDArp9dM6DveTQIImLRsirXdf0rqP5x4FamZRViW1ac/dE19SZEqa3N/ozriK17Jk3S/Dzf4QJJPYzxG5upwRs3YUbHn5Yv9GjRqKOCJIDgtOMU3TtjR8/GDfhydO6rMfynJbTducJqstxs/O984KOnnfQwk+OVnvrD3fVzR/twS+4kXKTPQ8FMan/f8GgIdjyP7NsgBbOoXmEo09bEUINC/jZXDEJaC8djSO/PteeUpF1TdstvIBFdOHnT1EeaOOg78nXGRtxiglKtK5BQxyVkq650g==
X-MS-TrafficTypeDiagnostic: BL0PR02MB3699:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3699;31:kiwwUtS8FdPVWsMDrhV0K9I9FCZ6mOTaCuieMpIn03XDHy6mTjNTbUTB0XspM1vBUk8sWgqnZDuBSxAQYdiXw29174kYLzYuLsHdeQA5ZRFeaR2TpowH0GiZeohOqUmeIEKBhG+/EXglkcT6TcnHWqzn3IdtsoN3KFQ9McR7V9guAz8BKUo55N64S27w9NIREymnpycHDAQeuOcq2OP7fbYwat/uzaLfCQAsqQRlWTk=;20:QYgfi6bpS1hOID5ohXtX9MOpcxi0dVKlsCpHXHOIcVzlyN0VawTL8+exBmTjClgD1TSXNtdYBe8ysSPV8MWJ7N9sAsGsYYPug2vKUz54YAj8QtyCNJgcwLDSCSf9ZmJ1u8hLIT9YeIEJaQOswmYBytcIsQXUzIfB5rMrFTh162WzQIz4mldW7h8VusnmAHUrzSNf0PhpPxb6pf7ZWXycp4b9HDSYzc1EK9jYmaQZC6rczJHClx9fzcSOtEqlTqExpdt1FXfioSvHm7fBtlp/kyLslRV5e7guMmu47IwUeEPQKhqjKAd8NDJhjuNNWl8iCQmlwNKY1Cj+tXwi3Ckr2w1WIu2roeLEmvF+tY1rhMpDrwDpEWiIL01wIjJvcPpXv3WqaXtQdEZISy0Y1fK0c6ySUj67sL5tFExEj6f8obOPa+7cjXV84t9ONm9pYPSe40MtyISZjK4AXn8VzJjq09ZD4DWvjgdCnFwhFOX7yBHNd+DMt/0BGdpDyeqdRE72
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB369900C77F64A60F6F676FF6B8BE0@BL0PR02MB3699.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR02MB3699;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB3699;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3699;4:MGG6UVvdYXiegcGnGcWSbaoqpL8SKaj9adbDKoc+SaRfZZwRHLcQrE3EK8c8dFmw29YtOcmqlYTZA9f3phuLssPsMj5sFNAFY+x/iSdu02ORg5qe3sNUsBTV1SX2is9149BH58t+d5ORUuzNUMpqMGuor9DgQbz8bXkOT4eZy52cT0NII/81dgM1aLekpHvkkLhtFpN+ZWFQTzW1SWB9EBvBdDBYN/mgQfpm84zDXyZIs4LMK2YgQPoqmsnWhrISlYP3qrsdmNvmKEQjy+cTiGGm7GQiZqxAKjPU7jzVvnEPgxiYFxdBmZ1+HLmb7zFG
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB3699;23:Z9ZGiFmW1p8PMunbP4w3c3ij1Jej2klr/rY6iCDaT?=
 =?us-ascii?Q?dEtjSH2d9GElaYrNeAv58Wn0xCOGCpWfikm6fVYHqGiwkJOJsZ1AGgHTBCV+?=
 =?us-ascii?Q?cR8OO411Sb9eLDM9QuWWL+bmyRC2rZyDzpnXcG5f7VfRfCFrvZ6gV8GoWZTf?=
 =?us-ascii?Q?xJrYpo760tgQ+lElu7X2RJMnUJy2bnwkpbzYO4gmpbDeo0Ch9RL9QCDcqdVh?=
 =?us-ascii?Q?4cmh5L5DcbEpNly5NAoynT/vvGy2zPnmDhyNZnXoQy5k4G3bj9xnpGFJf6Ov?=
 =?us-ascii?Q?rh75CfNoSRWelbfvpvqOCDYEj8zpEAjV0pxKNiELa0Tf6ffxXF51f5YWIz8a?=
 =?us-ascii?Q?7TPaSfbs/j/2X8vMCIWE73nx6l+/Z/Gdo/2RCX6So+Gwi+/qCowe63Myfl8z?=
 =?us-ascii?Q?7zZ5QrHSmJPFp7BmdQcHUo4lPCaf+RbAHuzdDgaP3sbRbD5OvQ6y/f3rdxa8?=
 =?us-ascii?Q?IKee4p9laHUiehm8d76xTfxwI+fDfXaCQ5bP7IMG6CGYMR0Xcwyl7CuVe1KB?=
 =?us-ascii?Q?TCV4slQgkeauOLvF3KRTkaxJSPzQUwSHD9bnRJr0PSEZAPOI10b9thtGS2Sf?=
 =?us-ascii?Q?IeUieEGNpkVLKV6vrRH1AbD8MhPwb28LpiKZh31IFkaOwVLzCaKQHUGtx8lM?=
 =?us-ascii?Q?qId4ibEr4JQ5aWBFYHgjeWH9SBie9pRO4KwCE+yNNPv+Fh8PsiaE2ufLuh8i?=
 =?us-ascii?Q?5LGT3xpNPKp1HQ55u1jJun0Z5jlarBIYrAtu0rZ1ZEjMJS/NQR03KiLbHcsI?=
 =?us-ascii?Q?NFzY82SDqTPvT0w/KTgjtddunsBuj5jN4BeQ9bD3EIKy/YeXhhgwLFsWEbrF?=
 =?us-ascii?Q?zzee+yFEvngi17plwuijezMdkZ9inS9fnxxZfwi0tABTkiOcVi8hTjdI3sLG?=
 =?us-ascii?Q?n819lUMcqAgr9Qh8gm8c8FXq8Hrt1+hoKVMEvzyprDTo3MQkt7DotFFSE5uj?=
 =?us-ascii?Q?qOeuP8yV2lqg7iwJu/ZNWc0bkrUuzWwJKC++IyH3WIVhaNJRMGxsKMLfxygv?=
 =?us-ascii?Q?RkK5AAbKIahKWMK3WeodP+LCeiuFF9kn/2pfUAzWkamb2n5lNZkvAPEbYJUE?=
 =?us-ascii?Q?LP9HHUbEDKhrcWm4Ae4cw4J5XcgHTgp6aWJ1CZkwpU+yW7unxZBZhBlYbZh+?=
 =?us-ascii?Q?bh13BOQsYz/ZQwJOYi3gw+uky5KZk9RoLN74sVUDaAUZ/ZED94dboRH/0xpN?=
 =?us-ascii?Q?tCKHOOWP613hGXH+QOTlyOkcOmaHfHSvLpYJcUiU0Rq3YUX2ZqPBIMM49omM?=
 =?us-ascii?Q?ZwMngZNyXb01fWuGQiDfwTVcojctgDgJWzi3hmk?=
X-Microsoft-Antispam-Message-Info: H5pTRPxNr0katdArphrXvGY5QN2qqEYjJ2gY0HwMGfs2taPducqfBYaa7c4h2cHRmRvOMSaBMWLq/LoYfY2IwcyNdqM2U0bm5XvJuC97Gc/XeYyMNEgGxc9FrLSzbQRIuupP2lUTyps2DIA99yoBUWNtOL2Ml/tUu3Rmyr0xjIlMtI2lJzON6+FbPG4iI+OO
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3699;6:+W/3+Ohld+ZLByw6PJXJdfC3IfeO2FyjQ8ktJ3+TAEq0lrUvWSnlsK+N5KUTOw+P0cEx42WnoVuV3PbdcgwS6Ew4ShlHlTSwgTvoux65Xxqkk/JaC6auRJtoaqcSd50WcpcPpUTNfFusLKHTdoUW1/QwaXi+DljFE3inJStx1M19yrkga4VeP8jJL1NGg2tb1wBwYkQm1iOaIFhV/WX/A1HaD6wVitrMbK9pYQ7uA8FTcJVaUOfLDXSqMUgxfdEAW3+f/pVdJKIzXErF0TVVX8cqd5HyIOOhqEy8PCfN/XM6RkFpJ/bHrwoDEswiqjA7tJu+PVUdBTrqyzWhXV/7i0msBm01pSwiMZb3JZ2uYoR8haYs2BO+6NtwHw264g2T5d9K9t06ZDT7aYYa2qumPelWIC6PdJZvlJb7qfpboNbxAmsjV1wLy3mTi/KWxRJW3S+6xWNCd7k3lK2Eq7skzg==;5:9Htz6JaDY3YqhRN8po3jh3ZPunaLdzG9MfDV5x+WIBgdroXekXC9eRuS8GUazGu8J6FIwaU3W0Y4DYPKyBX2g+SJzJ730VQPAHMReb5BNpGJMpLhUZ3CQIhNGLWIr/yjKkciQ6rssmccg+gWMDNxIK+wBHSaAiMfZ4zRVqwBOTs=;24:VmVc94Tt1i0qK9HhIg9NwpCXNVcyRSdJ8METSpng1BlF7EyysbjuMI4PDm+HUNEiuF1SwnGLkRqxYJi3Rz7BwE4jRxmnKrZdnZoVh+2Uo1Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3699;7:lVGfSsIXf7vaXD1nvzEuiGoJm6X9DEQHwnyxSN5aJTDuDbtBYzc8RZYQcqSifjllP5Se55fb5xq3CBz5dlk4kXo0S9PtGb3JKZD03v+49yFL9aAA4KDWhgrcvKG5kTJ5V1o/Cn4rBR0bRNLSlbDpjge8OejkgQkYD+omPCGWmILRdWuR6yNRLR4Y6UeBEUF+5LfGXhhNniaU6EeFRH4WCC2WHRPEUrGiW+tjoi/7lKDjq8nDLquC12FlhhRkprNS
X-MS-Office365-Filtering-Correlation-Id: daabca8e-ee81-490b-d022-08d59f1ac67d
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.1518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daabca8e-ee81-490b-d022-08d59f1ac67d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3699
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389328366345306?=
X-GMAIL-MSGID: =?utf-8?q?1597389328366345306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index ef09c44..c172fd2 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -267,14 +267,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
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
index 6f05f07..bebf926 100644
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
