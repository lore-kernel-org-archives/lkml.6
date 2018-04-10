Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx4/4D68eV1ArbNpsoRyDhdvZ1mjx/KfLvrrdQiE0V2llYC4C72RAW/+8YZduKCeE66l37sIA
ARC-Seal: i=1; a=rsa-sha256; t=1523389177; cv=none;
        d=google.com; s=arc-20160816;
        b=EFblSiTtfLi60xZlKQx3iLZsPmPYi9DoHDO4olZVunSNWFv+k4KK+gFGIuGOr96Wdb
         shFgtwMuuPFDlke+93L90D5pntLKarhsv0wGzvHpgnGER9OhQNWdNt+4zz/34Vnb5oxe
         R8HjtgJRygiX5mco6eIOuayEllUhYLoVja9T7dgyKB54WTnyrVXxJOSQvoIdCx35rfx4
         VjnaEng6G4NRTJFIVycg9d9BRmS8B/viiO0tPJbjtZ10FaCWQTKFzP5lhTksxfCS/Pjx
         1prjjgUWdFWVYyr/Jqf9EJCnUOQxSrDcF54vknHwEsbK4XBHHX7E4LKaYu/jMH7QBJ7Z
         9rAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hLYbnKAXtI9tDkWxu6gT7kDWrN9eQ2pUffc1tdNJKak=;
        b=O8b48BjlrZ+J+bFxb+NtJBIHOzD39VXZALr+NuO8mhwM6X0em0l82vbWDrOTUkFucP
         /hgpRiolQOBRXb6TkMHJHD6a6srZW2eWT2syswhB0vPG1joaqA3yAR7yAKjw9kmxm7ah
         lMW3lQVa6T1j4PahxCc/JV0dxGe9H6dIeKyzpDQdE8TsLmX/O2Kc99PKyrPe2XgstGy+
         8LN/oaUkGJIRjVn5y2FeH0J2Cdjz36Pw7a3ijHV+Jx6YE54zDTFDffW/kxQ+/tyJDEX1
         x0PQt/xV9P2atNZiidhBYPW2kwcMWaO409awax33hcFr/ktGVtlHyfcp+XjnT/d8jOsA
         AXww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=T3rGb8Ec;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.88 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=T3rGb8Ec;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.88 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Subject: [PATCH v6 03/11] firmware: xilinx: Add zynqmp IOCTL API for device control
Date: Tue, 10 Apr 2018 12:38:39 -0700
Message-ID: <1523389127-14243-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(486006)(16586007)(9786002)(50466002)(107886003)(5660300001)(39060400002)(36386004)(48376002)(2616005)(54906003)(11346002)(446003)(126002)(77096007)(336012)(106002)(476003)(316002)(186003)(7696005)(26005)(426003)(47776003)(51416003)(8936002)(36756003)(2201001)(106466001)(8676002)(50226002)(81166006)(63266004)(4326008)(76176011)(2906002)(7416002)(305945005)(72206003)(478600001)(356003)(110136005)(81156014)(6666003)(107986001)(921003)(217873001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1406;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT021;1:JjUGusGvAClg2IdSyXSOVdCq1SXIIYINebvt6z9gYAnYM7DmrNW4BGSQZ6Y4uQK7DwaWEfYyENuQsZgULOcQOwuLibFsmKv+0cnTSe9Kpe5HXP3sGVoAT1yYo7eZYcMm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR02MB1406;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;3:Ix6I1BQZNYUIrUIkpqhKjaHvPhCuYbvuhIuEZxabEO0WImXz/2dhzW+VDnRgj7tjNvZt7M83gC5nw+egF4+ggikYGEKn3HTdjJ3K6z4aKY2MW0TSyS2dgTBlnJPhxBzXmB6VprVDQXGzy9z1zLTv9PMwffp3fXG2KTl9duqXlYxJVBE1cPboVAndv32eftFOGDLdTpWUpIaf3kmLNZkcTJyRGpn74rNDw53lV2dejD70wjNK4NrvPYU++pT9xUOz607OswzHGDdprxGCFVG0UAPHJ6uTg7DNdtK6LCsGD8t2LifR1WFjoDbpUC/gRSsZ9Ns2XrpX3vUsQvPwTq+cgm6Ve97JabM/G58qK8uT7K4=;25:wkiGyj1TPABneJ3MVjcVHxmv1HBUsm8LZJTFSBnBM27bqKPaCpOP+UABHhLGVhp/BAWvL8Wd7tuh/vflwzjwAN2OjP4bfcPFPkmRVOVUy2PMpMeQKMQvtfVunTg4OARqk7KIypM5mqJoBF4tjiAptGHkxZDyUHDASo3mTbkxUJXytXDBs7/VJXSF8vhkUZ84W3nUO+nrEiJPhct7JYSlfc2oBUqNr1G4GWOxMApOy5wW3YOmjfuaVZrMcSws9P55g61oRx5gXuyi8W9buKizIzddl1LlPDuafN82GNx516Pq1UTjj95AVSpYERYiY7mlqJ5VEm/dl9L1PRZtxU2sgg==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1406:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;31:Zmv4z/Nm5eD6CJ4g8sRczX+2wVUDY1mVApOmaKTY9jbOqG3pYK0Fu5tUdyQYz8OvLMTJj7cnxpX4Ca3/PisNlNgWUwpG7DjiFZPvM4Vh7Jy6OrjeyF4bGiDe8ke9BKdQEXNFNOla+FxdUqePb3bcATHcvsnftNKieg0/F0+Ucc7K1c1TEG7Hy5A38iPwTjXskSi2aex2OouO/pIjepwwyz7/+0hBMmput8wJC9lImC0=;20:dGTGMoqAVtDmH540rBKp6LU/NIaU3qjVdPyrbTfwANX7w0w9E7TNP8egu8alz1KfB64cEUb8NHsd27grFL15T5QU7ggDJEU0eyTGMrmGm4MUWeqUM3zIwKGrcnwWsPFGl4VvzdzaPquV1PXKN/f4p9Gf43TG6Anstqdx7ue7GEq2U/a1/iBQjRGpQOlf1WF3s5MHplUNEpxA7BjUU2uL0oQMP2pv7dlMrXzG6DjCJErtgEZg6mw5aBme2yjt1rdHnSApXrmUXVL0EImMq7ZhKQjUMdyk6661Wwi5Vv0qT8qxPunN1elEmCcHljMabNdwZjY0l/LUNweosxLDQ6AxrP1L1ZuoQg5xwKjktGrFjBXHKUeNiKGoAi9okp9ajCE0TuhQhRjjHOVHb4+vqNHIZyMffOMQNEp9ZTry3G0Xxx5GG7yBJK/MSiX40fOlxPovBHVNmON3y20x4hk7DuKSVjxpFOS4BSCRDOmKc+oBIIXebdjQj4ue/eDG+OrMqNfX
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB140634303EC5D9C39BCFD73AB8BE0@SN1PR02MB1406.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR02MB1406;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1406;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;4:bv9e1VoxcBSYOQQzAKK6gGRiz9q4gxDbTIqAW7nmUsh597F8yRYmj0APXY5we2Mo7OTcxG319lqdbHFpyGP2ed0YIdf0UGr5fleltwH99Nq4Sb2Vz08ByOQGaZ0T9bo9YeaToIqgL9sCj7bgpizgz9D25eeWx7BEOjpXNBop6V5+nVmXFdWyC6S7NlNjOqj596W4eFTvfGMux/NbISLjKGr8yHmnhpBPI+i6DiLsFlQ2JzcBtO8GlHkTzGQp0z+DuBrXG+XFSPeG5uh4KN+letwLcwwv4ExCvgj92EiE3SqXyVGXQUs74M0UbVyIX61N
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1406;23:9fCupQ8uU5yUg1aZsrHvIFwEI6TDiGXMIwkYB0gOC?=
 =?us-ascii?Q?Ke35EaJt2g6KckZy7E8HE64uOp8aPTUR1xLq74Yjw497VHh8C36fENY+xP7q?=
 =?us-ascii?Q?63UM3YFBaI9xB2s3qnKwSe2xVDEbzC2vJTJtK7CG8sKvtIlDE36QBxgYLNvG?=
 =?us-ascii?Q?8mGDHMKASeWcIkdjhkK7wosyEUDOQ1bH2tiJJaDh7+YVezRQpJyK8XRbqRLb?=
 =?us-ascii?Q?uO6om5ydJnUixSi5cTTRrMT6RnpeZk3bVpx8WQplNSQziuOXsdbJdN3KcWrL?=
 =?us-ascii?Q?GzBr4RkgC9IaIyZUz1jlD29b/tR6nq1jQ8N/BXhSoFlxZfb1pyRpvriPwWDH?=
 =?us-ascii?Q?A9d0csgvWxjQr3Tc2dJ4nhZP5AmjU0AV0LGKX59V4aUrCiI+W/JT85Crav93?=
 =?us-ascii?Q?xnWyc1iXIM5KDXFTGZAbqUZ5XAUXsbIPxshXbF8/UKj+OSYGmOUlNsp73czA?=
 =?us-ascii?Q?mDy7jWAer+JVZMKoATcQ30i48Y7MAL/YZ2hxJeodXDQk0CEyaDo6g3QxCns7?=
 =?us-ascii?Q?cWo0HPib2+wFt8J6Fr1bcc39p+x7wvyEn7Yoh4QUYl3NoUkJMZq2bsxLk40/?=
 =?us-ascii?Q?KpE1UfotRdiVgbGsXN9bCeDfHMgw6Jik4Gt8aVZw5PZMLHyWz/a1cTJCfs7a?=
 =?us-ascii?Q?k8V0jlRVGtpTyNLbV1Z2UD5wZMThlVgZotuisg5P38WRv2fKlWf1He8eUPUW?=
 =?us-ascii?Q?ikrFyWy2+Atxe0Wx+AAYN9qhsK1Efvqlic6v5b0T19FCjnT17hxdrL3hMv0m?=
 =?us-ascii?Q?1HZ/0g2cHYZQJBjAbC+qUFMLunvRxCzXUr26Qtdf+lmyXqTVh8tSEgiHjkg5?=
 =?us-ascii?Q?E9mPrzsh3hYkTsKdSS1ALbgje+1q/buLeqK2ZZrsSygoQbpHzyFZkkccBRCx?=
 =?us-ascii?Q?R7Dz42SgnxBT5EeMPIIiJsjMBvZ+jQvL5i4//OaFHjCwL1efCx7EsfThheg3?=
 =?us-ascii?Q?m0dwDGtLD0yKQzIrv4I1wOMwSY3uBQf7Wu/llgSIrFPA85ZXZk1Crr4ZF2y0?=
 =?us-ascii?Q?5kdePjOhtNxoWEXrPf628iXBpsELixCJ6q6lrYhGeoCbkFtl9WUOBSHJERIX?=
 =?us-ascii?Q?SXhCjSEZ3+lYutZVWmySi6Mzo9/PUhsUkSjmYcPuVvJvf/w1TZqty8nxUfGS?=
 =?us-ascii?Q?Nj4CEVWUmvwpYb4W3KsIIIixTs6o1VJ+USsNJkEuQN65bjVnMDUHY9V0gLzC?=
 =?us-ascii?Q?qqVV0JSO+3nXrur8+FJSx6f7IXns0kDJ96w2iVpZig97k/b1GLgsv1WiIKwE?=
 =?us-ascii?Q?Rjd2O063rfjcAYeNl05RoeziIq1RAHgS/+VzwGeT6bYjHmPS7i5cUEMd+56U?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: kRm5JZ4UceWy6+CaI+jtxIi9e0sPfASPOo/U7BebnH9FTfase02kxHBJkAXXWY+ij1SBiTZP9VIdyKCSlpNURV9mRzGD7vFcG9FjyRaIA1+jV3bV52yF0kdRw7OzSN/812URT2NzPTz4BvfW9ommz6CLgTowKPLXJuE+dneERf1yAZ8x/tLZDxoC8481GLTf
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;6:ZJhDukO1l96VdHTORt1mIJuM23oj0ry8Ap0AmdrBPopX+RZ9sG0EgFtbjYgvwnQqXPteyZVQ4dJ0g9jH02lk94zpTRIL7lXHfO20oaiIHO5d3u4qHybS5mPLIqGz3C02tMfUz9sDpK0DoVdd7m/exMqDXOOHiOcZnuMOzgLyN4tzEh3nOUO8DpSZrT9DIJxrm6GPuGG5lnEQA79GGsyPdpmNS9qgfkAAER0n97gaoPyeTif8U4bIWMGZCJmOCY7zCGqmyHQ0IyOIei6XcqulZPfvIB6gdADssU8FltLIJEEr7OT/634LL5NI+d8nUka1Tjjy3XL4kwRos8QoYsolRaw8dROXCM3b2IMWWbRl3GWHIN3cpKOleMre5cfIPYG8RjOpxX8JYi/p6HonsduqJ3EJvDymhjqkg91+ruxd2yUf8AANepZE0VeS8j6JpnkAfxluxfFc6elX3sOtDdDhLQ==;5:nQtp9q6voB6B8qtghuesJRYvBZHBAH6Qg82TzfTs+ytRzcHxX48YEXZQaBrXz5ihZxsQ/sp0kH/IgNdXFA/wbZ4t6+HvNFh91ewE646KvE3Va5EqYSEJh8EGQhE086+cmNnAmr3h5eA4hbqyiZLW7hhaDO8HVzSSHnWuVdos7pE=;24:ApNtcWv8UAww1A4yrTQ8+W3TDCGh/mMMlB+HLG5goCNZJ/3ZsTXmtUUuQ1Y9pGNO4oZrHiUDeUru6pbx32GDV49FZRe4JiVH7Db9+TAbNQo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;7:KrMFGvMBOSNBZb7/E0HFXBpfjP/X5/G2zfChCG7jCv3uKyvOvcpkX+4Zx3Wu6u1rm5Ug4P4wrZw7UTl7Hm0ErC9QDEZAEn2W4XJilQP8/wqZCPr/w8M0/D77ph9PLYZMDg3+IWyO5XTl81uIcdNCxuvXHNL7UBLNbkfZpkUoZszAx0Tgi6JR7Tuzx5HFR4y5TKfl59XUU44zRXxEFq4KuHdTWhVahIHnhTxngogqM6i4NuqwX42MTGDJHt35XeJa
X-MS-Office365-Filtering-Correlation-Id: 28cf99b2-aa0b-4414-ee79-08d59f1ac678
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.1510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cf99b2-aa0b-4414-ee79-08d59f1ac678
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1406
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389330509199100?=
X-GMAIL-MSGID: =?utf-8?q?1597389330509199100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 490561a..44b43fa 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -239,8 +239,28 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index cb63bed..2eec6e7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_IOCTL = 34,
 };
 
 /* PMU-FW return status codes */
@@ -49,6 +50,7 @@ enum pm_ret_status {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4
