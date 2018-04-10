Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx4+i1gULWcWFZf0nRNNhl81ZufbXwfZzWBAEDv5xsD4MkPO1G/z8A5u5JicpJ5ltjBhuZQOW
ARC-Seal: i=1; a=rsa-sha256; t=1523389176; cv=none;
        d=google.com; s=arc-20160816;
        b=Iv2bCqIibwu0lhpfzj4+v/CF+0YHJPfslPLryrZ45MUWu4q6/AHzhgWC1EN2Mi3S1m
         0QeMeSXqYoHO50FFl2ps+6/lhzHdCheoi0xn7kbmsozP1gNUjinkqxZc8I0n/ct5wL6p
         dH3+yjOT8SDGK4ClyyYToCL34xJ499CsTQPcE/+g+IV4FPvTi9w3MED0DquMF+hqKOjc
         uMZT4BighclwyCbnJkFMnwL0qPzRG9/OvY/tKOWngOEL89ZuMAV+9ASzhEE5+AM9+taI
         thUdjqSMq4DiZa50SSYziVhquZtDkTBNNAkCLcVQp/jBOIRbBuHHJim/gVcSXacc4H0O
         vrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=65eyZ+WW8uNgImsZaZlQneCC/9iMlQxrxJIXc9vsimw=;
        b=bthqVeqT5d/aUQ+al/ltaRXlgMFuO1Jk+4YnzRNGpJY6EX/YV1aS1xLuoy7qQvvJnS
         0AqWHuMl/aJAr/OGb1rq6DyiQzjnGdxCUstKFE7u164fz7ev2IDthVnG4VME/y2I+0yE
         nNs8QztEo1I+a79pG4U7OENJ+rRivGgqllZHULq9wrkR4MUqWyixWQ7P0uYt75NVvMt8
         wNdk/cVTHqHcve1NUiYyqyt6jTfgw4yHplEhwKY8E5firSbcIdNs40lWCg8m4KDwWapF
         P7pUAzFVzxgdIVPtL+mmIs0yyEdVh+ACRcXQ49RqgZXemv1SGZZxuMElH6TXSmaECCE4
         v/4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=iZTrFdca;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.68 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=iZTrFdca;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.68 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
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
Subject: [PATCH v6 04/11] firmware: xilinx: Add query data API
Date: Tue, 10 Apr 2018 12:38:40 -0700
Message-ID: <1523389127-14243-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(186003)(36756003)(7416002)(126002)(476003)(72206003)(316002)(110136005)(4326008)(50466002)(48376002)(50226002)(2616005)(47776003)(8676002)(7696005)(305945005)(5660300001)(16586007)(77096007)(486006)(76176011)(8936002)(11346002)(446003)(26005)(54906003)(2201001)(356003)(51416003)(59450400001)(478600001)(2906002)(426003)(63266004)(81166006)(39060400002)(106466001)(9786002)(107886003)(106002)(36386004)(6666003)(336012)(81156014)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1396;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:hxpGH8r02kaacS1nWpqsLYXgMR7C7geUWiX2PbUG8Rhy9W8cQ7q9b80PNOEhNVFs3n8Xa9YY4t1l6lBl3U6CF/ABQjF8hzZeP/zdk8g6VBd9VcmqFqccDqkLdo8CEnOe
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB1396;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1396;3:4dW8JUUzXScO5SULdxY+mBCzdtpB8bjgonULCWOIt/fCzgzpocHWV5vCTYXJmPElhNAWpKwnLI+z8VHTy4oLUjxMBQAnCu9pGnj3dUI6TiovcIoC7sYzqbO5ltr3PHYrH67CVXrPaVqEi2ondlQ12ltU5dqYfh0etnprB201jdnc3SPXuoKcAHJorDyc+h7BoICJU9XJvk/nTbEfK/bj+va0jz/YL6xZOKP/0sXQ6TcXQnzzNTfBLWG7Sjk0fl4cKDmVnLv7Hy+RsLByvUOlj124Dqm71rTWecoUOt6MU+dasrI/sCtSHk8cB0eEJ1kxMnWpa2ODwNbGQCmj5xO8lxB2ZCCXDMUx3q+lvnET9oA=;25:GgtT7HDhM55SvrCoqCwo8KinBg3Wl9mqxHw2ZAjW1B0wQIUnUgvSgdYrEVX5Woe1fhVPSfy6rC2orunx5L22dUASLoNnepXy1OwCNdy51qRoI3NeVxi/xWR4kM6NpKa8el8ASdiBE8EkurXWtAZGFsoJEw/2y4oaC7C/QESDdpMPXgX7P4WXppPANVR3ZNWMfxrO8vu9c3pzF9iEzqF+/DzRSAebs8+fkXp8ki0DhSDlrmp9MZnJ9rooteRADNwgq33aPjYgbHysZr5TlRWcjUG8Xsra4RigcHmSgFLvkQfWrhXDkfHYBos3kbUdzhbxWw5+UuLlR7yFSlgRmoQ1Jg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1396:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1396;31:vIvqGj3FzylobIGhJ1h5zqYvAgW8ySG7qZcIeu+w+lPRavqjICTaOhj5a2GijIFeiuagGtQml9nuVRc2eHHQynNagMcVBZbM/iNNGZ2d2oBhBwO7XZCGN8bzC2uBQFupAfiAuvUMXVd+jKGrkFwrffnHEciYoyc2yMQbfiC/adAIjIt73gwH5n3VKmPE27xycULwKkH/tjn8C84bngNe1fsO/kaSS/CqQcDgpIYFNvM=;20:sPwzwQWDtR3excGwoHyL+O69YgJHjWahuLMONLkx3qZTIvgR379WpTQ7NzFHzCQbiPi7V2cAAq574BKAKk7ratgxKDeZIq4jRm2d95BxlyvTBjSwakwlARvYy5FUY/4wJWeazqg9vGBluHUwuiDFxX1qJUiZNM90WWR4YiKvUAilEYJZoaROVIJ95+3GXh8Ewln62EwX2++lJ+CtxMsQdTnrbEO9g5T3sCEvK6e1yiqCwiGcG4/fLQ8s2TWxdLQaYErZnZanV9wl9dwZBgz6RPXmgkzAos9ZJhpBYQoaok38Y2sV2s0VuRuiHY7Z6swcnlPOkev0Dsqp9cTBUmyhJscJ5B1t1K2yBO8xnnMYfwA8l1TAx1yqyuiTQIoQwEVL7+jhLIT1yF80CichSSoy561eIjl6b3bEIFQgAbeLimVmu304gKUMBd+vYdBj1j9F3fechTZgkI6JtbcwaS/7bJBuKAC+uwlnpn+C3JUCQDBCGIPFSmVW/LIRf3CSEExk
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB13963AF6F67278D42961155FB8BE0@BY2PR02MB1396.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR02MB1396;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1396;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1396;4:RO6eD54TtgAlXzWCakM8qCVp5NYwcNmctmI6vyuCeGu8S0YiQDgGYWWPVSqkuZElOs9wmXDghajAFAEKfddvUpjWrOeIXvPfM4lFflt/39Ss5OiKAPVazwuhXmQmfL17uw9iSu1PWgU46MV/lQC3/GEJ7PS5nMdasntvShMGpJ0vwOmA4jiV0dUVUS0aHLbGlzEfAUR71QrlKuJglDLS2wWKG9QTQfImZNvb0jQnlsQjwfZQUgGU1APyKAjxqNJJE+pG+jC+A6swjnWABUy/P5hhMWFpuTmQRARdIS6yRV47F7HfH/hiIw42Xal25W17
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1396;23:OlaR/UXkr6RyyigdHEJO34XVD6daiAcr4lCeYPJ8C?=
 =?us-ascii?Q?4bSC+SUtqqAyFKbGpjWmu6M9CUuT2nk9QFbJsmYli7vH9Oiwp6nOhd/keID4?=
 =?us-ascii?Q?8NwTWa1z8a7LcKIfM8hQ1bSvoka59wiL4IgpRXTy/GiuBuAGVXuVAISwtUuG?=
 =?us-ascii?Q?isnZJV0o2cs/3VXFHraY8zvOwZavvZNSbSPXzxkcZfLDOPciRCSb1zPFSb27?=
 =?us-ascii?Q?3HBjN+Av6EORsDSgDCGLyJkL8iDMD3Up5Bx1kF7KeqZQKe+LAp0pZXN1wkXp?=
 =?us-ascii?Q?+PNV1RQxT6ioeYTDYxwp33xdIx/JGNidZz9zwb4+bGJMWSxevUxjdrdWI2wz?=
 =?us-ascii?Q?Qayyw2ku3mT/NBRdIUQA4A95WQdLvO/D+4r6ebeYpe6sbsrCq8r89xiNU0qQ?=
 =?us-ascii?Q?LNS9fG0Pa4gxysYnZWLXCpva61ke84x6jXYMMKHWcuitCHLe2Uic7dOi31Qg?=
 =?us-ascii?Q?D46Ce3YYMwEsVkTVcVHbSB5n80u2vy3QJm6hmJixuE/x0LisVgKF0IvpGMB8?=
 =?us-ascii?Q?Ej20j6BjynCGH+7QHVbHjhDrQhqwC81IDDxsAj/nzmPxxwmzCYC3VUMDzdTi?=
 =?us-ascii?Q?GcyIZRLp+CyyfRepYQzmx9r46Swaey53pyMsDu4dykPvNsV49G1kfuETAnR1?=
 =?us-ascii?Q?J/G+IZQpx2K+0324Mx0EjPe1XEYJNt996SWupGSm4fGCVFaLg0mNPSdLjZMY?=
 =?us-ascii?Q?VdyTyxvnjXpqbkSKXtb/TaCPJfdMnqkNB1U96vGPTPIhLsChsd4bkjTmhb/q?=
 =?us-ascii?Q?+/XsgDVNtfjnPgMdBFkvYXFMtQt6gBbyDlv+yq0d8Nv14OImCAMHHBO49Wph?=
 =?us-ascii?Q?IiQgjJb2v2U193pmXY/GQtDgrWxFgkbFnE4U09N/4TnGfccffbB1rB1wOH8A?=
 =?us-ascii?Q?Kp0TwvcV2Lm2pJ+px5DWhHLuNsNzNvRbLrwLfbbsycL/EEdTAJC8pLnAiUlw?=
 =?us-ascii?Q?38aEjgCy0dv69z4YrsuLAzjA7YDV/8dcGol0lwUzyVHIwTASPYUvU3GaM93d?=
 =?us-ascii?Q?oYGqL8N3upaKgpzcYeroKhpkC0x5suKePxAUf6OB0racYpNlYrv/qhXTmTtQ?=
 =?us-ascii?Q?0iifuuxDRY1MoWeoZL64hfg4bFmXCBxQ7AW96JbKEUwVJLyonEWnPn5wgFNQ?=
 =?us-ascii?Q?fyVU3fT5XyqHIDnbWOsNs3gA0bMW48pW9Q/1D0N8QyfzNDbcUPC2vsOIQzud?=
 =?us-ascii?Q?IT3OvqZvOcClo77cv+zKp7W5L0C5m+x+urdt2cLzGJNCIIF5yyI8pKG9ntjN?=
 =?us-ascii?Q?S3kcHxbAWpnVoOBn7GGwAk5PWL5XVT0jVPHzjUwTqchGSuuL/NApf8/TzLPM?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 5qTSBPFMgxcZNfjAobkQKQX7/l+oeibwyqlBEwl7XB56NzKQbDwf9RPx7ig1sCQcSHnoZvpPMZblqZVe02CpmEIX1jZflv8wX5utVENL9IzKwclPBwWCSQJN/vHasWDn8Dt/vJyiG+7mXbsUxtL4QFLe1HPhVVr2bnNGE/z2TVdnlJELzn4MQ1aOdGLVPE2M
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1396;6:3al7twmr2HG+46SawyvoFhSedNvJV/6Un3uB4Kwm1qOY4yss6JR62jdk50JK27eJJ6e3SjQCdmBbKIuq4XdKvzyinVm7+crtg/0f/Ha2RapdXzdu70VwnWKX3xf4TrPuydKvJT24CZemJbLQV45QBPUeXURYyWRn8x6r0PY1xBnrbKmlaXDxfwVuEwcz+g2ZjDFDMZN7wKHyB8SaXjZRE55uqahmT0q7V+L6IgtPUnst41JLOoQEjwcFxha+vivWSn6++fUEFK2oIY/1ete3XKpjvgVUDKH211QcceO1n7/eXXlkMM5Ft8no1txDx/Hljv5GlLXoMnlLrSoPbmxt9/zuv5WkntnFwTLv6larJh4twimIEuaipumjg+r8vsuET3wuccjj9Ua4iba1iVcp0xzjk695U3qIYWVshQECgEu8H1k6U+aUjZHe6rnZvHwL3TnTI29DLPi3iagUTzFODg==;5:STpygWpqXf4be31RFmkHswN7+KP7qu4bKg9V/wf50oLPJ+n8ggebhBisWioaohqiHsejPl7xy1P7ZrF3PgJPFN2BOHt5ySNaT5hCWIE4lm/QU3uCpTry2fO3f6A3CSghzPopL6aqRCaR77DnVcT8Y1jHq4r3ZCKRCpo1ATfCTyA=;24:w2rOl8luJfuk9cXBmV4USKCjxHygNXcQdroIDpQFVc8hiRX2T32Y7Ns7FHXzGQ5aBUfzkdb7zWQQoFOx+hHDxHdj6KjXhZtbBxodvilm4/o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1396;7:S9D6FVEdLyu2e5cMak7F7jFlQCiH7aeyVnRkdD0s1OV7e2feVblqjMQK3BR90ZFi/uxBtd5JdhqiPyKGaW/8YOvUBjabURLED4Gx0PmFBI67x+KP/fOw2LD+9K/VsaBHRxUh66zd6uVRMk8KJYH1eV4dMlOWdkmjTt4XaHUWyURd6EBefTGCJavxv6rpsEqfmzqU65oeVrf5MWQYtK1Uwv6I1MXbe7kzgFOZlZHa1ccdMB6WI9wDKa7WHrwCbtpa
X-MS-Office365-Filtering-Correlation-Id: cb941809-c996-49e6-aeb4-08d59f1ac659
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:27.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb941809-c996-49e6-aeb4-08d59f1ac659
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1396
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389328792813890?=
X-GMAIL-MSGID: =?utf-8?q?1597389328792813890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index 44b43fa..ef09c44 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -258,9 +258,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
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
index 2eec6e7..6f05f07 100644
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
+ * zynqmp_pm_query_data - PM query data structure
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
