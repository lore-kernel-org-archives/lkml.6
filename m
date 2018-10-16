Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D69C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEDD2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEDD2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeJPSKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:10:24 -0400
Received: from mail-eopbgr730047.outbound.protection.outlook.com ([40.107.73.47]:34558
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbeJPSKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:10:23 -0400
Received: from BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27)
 by MWHPR0201MB3563.namprd02.prod.outlook.com (2603:10b6:301:77::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Tue, 16 Oct
 2018 10:20:33 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BYAPR02CA0050.outlook.office365.com
 (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.22 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:26 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQo-0007Kl-6p; Tue, 16 Oct 2018 03:18:30 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQj-0002CL-1Y; Tue, 16 Oct 2018 03:18:25 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAIOiS005747;
        Tue, 16 Oct 2018 03:18:24 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQh-00028h-Kq; Tue, 16 Oct 2018 03:18:24 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [LINUX PATCHv3 4/9] serial-uartlite: Add runtime support
Date:   Tue, 16 Oct 2018 15:48:03 +0530
Message-ID: <1539685088-13465-5-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--2.733-7.0-31-1
X-imss-scan-details: No--2.733-7.0-31-1;No--2.733-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588260923787;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(199004)(189003)(76482006)(450100002)(36756003)(50466002)(6666004)(107886003)(356004)(486006)(16586007)(498600001)(54906003)(86152003)(110136005)(4326008)(86362001)(87572001)(73392003)(14444005)(126002)(305945005)(82202002)(73972006)(8676002)(81166006)(9786002)(81156014)(51416003)(50226002)(76176011)(83322999)(26005)(8936002)(476003)(336012)(105596002)(2616005)(11346002)(426003)(77096007)(2876002)(55446002)(61266001)(5660300001)(63266004)(48376002)(316002)(47776003)(2906002)(446003)(106466001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3563;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT022;1:0irQk7I6+nrU2kl2psKKUZqSAdApkU1N38ALTu3dlTvT6yvx55MRXgi6JqWhdIRY361Gmpv+VK5bfHh00t+iYdF8gVGxaRfdGq9cHiLYPIuQSQBAv95qImYxLpT2YH5k
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f83a1f30-e9cd-4372-072e-08d63350fd5f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:MWHPR0201MB3563;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3563;3:eBGHH1WZP3Cc/5BHnuEftWK6d2ar64jLQLnRkRZV4wh+3l+XtGTyDDpGPSKB8+VeAkb3n9Ci/V3jF317gTyFxwowUTlpyo1eWsLVVAct3ip+jycfXLVU5YgDkRmmx+NU/Fak/Njm5iPot+HewGcmy3pKmsF4KKKaGHPiewcVWoHphddwekGXDzacuGShJmA5AQ5BtUNuXNUgJX/k7jRyOQGPunCOJgikKTcg1J0SuXFIwE8VddAwTLp6eYvg7prMWFw/KHBONAuFjOOvtNSn9cb4V9WTaGq+lzIRGmng69faEFpt1n7PppA/BejYEBONDo0J1IdsIzAgojo5xUyDkpgjPRgKvw65V9guGULkZus=;25:kS+9tDQ7PXut31dStB0wV5jY7aZjvHpMWsBBsprR4uAZJ7yovMngeDqQQGgV9dccqiTX/NlhhE8/rwTIdB68uiVNDEDD5SLnPx7Ien2a/BZm2AJgbp0PgTfdr/J0LQ8XcwxEWHsgtpO0aVNtS3VtNQfwnTno+MTp/0DhQbaWIEc2CjgA4pSAUYu+33h+ge07XwPyMaF9o4SXJ2t4tMNY4Dj8i9EZ3X4zr9HXcjTaOEv0XT/7rjDniGT1JQiWJZzPFPjMTARyWuAs4IAkjdR4/kVxbIyx7Df26ceEUzh49/UgIUCVHzpGNqkQwDscU7iGzBv1JpSp/WC/Q+9Ils5HcolPp+abheddNVpn9MeT5TQ=
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3563:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3563;31:xjz3e+aIKJ2OJf+yejn33YJJP50TkJkY4LwX1jVHUFiTdUzg0cfqVqOj11Q7G8ySnhlElTVkjj02o3D+QY/UMhgdSTB79RlsDJvMN/l1vFeP7b9b6R3VqX8yqjLesqVmZV7xOcfXltEI04tMoDd3Q9dFvqagXsF14v4A3zCWMB00V3+VI/mxvwMo013ufgUqfaCDbIfTwGlKU+1c/MHUtluW1qR0mgUPJMUraQruGTM=;4:wzOzq8MhlQAX8elX5js/zRp6CZr+jpxfq7jM9Y8n0xskruRUl6b7reucSb+dJTT9Kyso7zFPTH4XWDkMl3hzfySIR5j9Po35hE7qsP+8VSm61LQM0qCRiLO9GmKcpw5n189L0BW3RFWEUupvsWVuCp+sYrhHDD/nfLbaaei6GK1onEgxnoTMGOSuaFk1uDFqQcudcdANEpZoTHtMWTnQOPNFyqwvRZUiy9Cc6F0IIay3F7CtZdrldqXH0yeOMcgkIiiPeSiG0e1G3Xcps8bES92+Ru4bVsPhkNT2SExtkZzEf2FLKEGM3Q8ihyvjgUQP
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3563D3A4401BEE01591792DC87FE0@MWHPR0201MB3563.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(6096035)(20161123561025)(20161123563025)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123565025)(201708071742011)(7699051);SRVR:MWHPR0201MB3563;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR0201MB3563;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3563;23:jjEZR6E5E7ThTejiflrU0PExHpyp42rVc7q9/EB?=
 =?us-ascii?Q?RKLXSC3gOLvVT5QZfFTbTnmrD/yq0YR5xnfyZ6fP1rZBR/ARDEGtEkP93Vys?=
 =?us-ascii?Q?0HUREqsUqFDwGEUL/0MT/tGDViSZsY1XJ3LJLmRgVVAZfLW0khxDUjCKUB6U?=
 =?us-ascii?Q?ky4UEtV585NWDbcLJc2yDYYSFTiZq8nbkTFY6zf0M9r1s44vuYaSEnnBHzMo?=
 =?us-ascii?Q?JmwJTAI8MOHIr+aMJ+4UoYyOT92vr9I/ImjH2k9TgI6Mpl4bdN41LqeiyzAu?=
 =?us-ascii?Q?L2NfX9b13EXAD7f+eTVEr7rP9kZSkPHP+eliwxvlE5tZJ97VxscvLxgppcBI?=
 =?us-ascii?Q?H7x4EdVJ90c9SiNTpDJ+owNeFkS2UJkb/D8dm2f0S1JGQuWhn7BoZ6V2ZKsY?=
 =?us-ascii?Q?GXvpBw21ZTCo9Ji3v5Z+7X89lapg2V4Azl/7FA1VJiUTaNlcsrrYpiok8UgB?=
 =?us-ascii?Q?Csl0hk1HBlmVCF5R6Z2aqdmNvGgZnyuOOKahDtBy6hZ+wdthKmJU0LXm8/vP?=
 =?us-ascii?Q?FHF27xTZKRPDrPeqjkW4nqI5v5CZgWqBrmQzEEcOy6pgh3xgU3wACY5jO/b5?=
 =?us-ascii?Q?2c9HGRWbZAi7rAUGe0o1sH3WiRH1g8RHS2kT9z7xrlAEsL/WHHD65eOJdduZ?=
 =?us-ascii?Q?ZZeag5CPwD0k5enjuH1QnmMxhTB5XWBrbsirRYh6jLt7NBt4r4D2G+mU8r7Z?=
 =?us-ascii?Q?j6y8vvFrNZOf4KB3pzfBYiwTAF1/tgpY3CzOkCHSLLZOtvLEQP25AKuXNiGS?=
 =?us-ascii?Q?ES9H+2yB+bCrOHGcBQS9vjEqGzq0kAWmXOhUrBFygiUkpIKq/YYdsIEcHTnT?=
 =?us-ascii?Q?hCOPsjlxdRTqbMg4hGzM6fmKS2U0PLuqup0jOU6ULqocaCm0br/ZvfdA/RTS?=
 =?us-ascii?Q?jeE0A2McDAuGz7LXEu6Km8pnmaQgXfkAYLYA2RyNKQ32UDjBUaQbfejqQ/Xo?=
 =?us-ascii?Q?96qEumTiAEgoBtpGfzs8mBRxVB9N6b+xS/W7LsJoe6VT6kyFkZD3FCZCswIX?=
 =?us-ascii?Q?8zSTZkqwdPKNs9Gh2K+gTt1gWu4b91hiMQ/rMM9Jcgb7VM0guH670lbor0YH?=
 =?us-ascii?Q?ilq6F6oin4+AabZppPhgZF0gnPxkHBbCy4UGpv267+CPM9apaT9ijgCN5jGX?=
 =?us-ascii?Q?O+1E2S65BzCRSwuQQx/QwW/c8S7MDrEUcoZvffApp266Ylim7fPONEru9uom?=
 =?us-ascii?Q?c/8blxHhosgcdB/gNXLIVttMNR5axZE8KE/AeKejfgdNSCr7iZ0moiLd4cGy?=
 =?us-ascii?Q?VslKeULn64Xpsa641Wn2NGY2B2JfZ7VeaEcNggY606cghA5rhb6GgjLpqLBv?=
 =?us-ascii?Q?8+rFwkoD1pj+Hq8jFUD1swQc=3D?=
X-Microsoft-Antispam-Message-Info: kGHlWlnXriGUR1hdSF3Z887voS5Q5KTnTqmDNAVCjpOVOXoz/LFYPzxhC6YeR9bix3CdJ/bQDC+35m7zGiS1Yh4UqIcu4NrzCJpX1pMvTpyoYtgaqKDi4M8hkAd96k/hUl3GD/Ala0WYhVIHmFjpklmYRxs3GOKaoGF9xLq9rpvs5bwhl+SwkABynXj1J8VjO5+wRLF5huI4N0hiKtHod6mV4xp6UZ/FxfZUlG17XizVP6wl0y5kT664bqAICtYXa0TqfnOiw+szQ78iKra68056ik0uPw4v1PMKFq1kqHIQZ2mDmuuYmuMfZFm99lOakvZR8+TG6AwORYxSeHKOeN66cVxxHVkIib3LnIFfP0c=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3563;6:AkGnZPdSfI+PqO3dh+u1Ci5XiregDuT9Cuqj2g9FuYLow3hts7FFqmxgYCuy+M9sEAeiKfrQTPzfAelWyLos347/hj6Lb1G24WOKrNpHtIPnI3a4CL+CzuJQ8+vqO2EOXh7bUm+2QaeathQKu9xAJlcuTF49u0B4cI99uRwUH2fWy6wMQznaLKgW8ni5UDgknQuyZ7qmy7dD7ztILNk9PiWa3JSZefnpnS6tlLrpAqQjIteKKwPxnNvxcHmTGHpQO75XwvxXBZn8d4qcZzbNYuYPOu/EgsNgMkbESVglI4VNL5rLitTnR24Yhthrp1FFxy8Zp4eXGj0kXiEN2fxb/v6P8E3+i/YMuID2RNehtP0M79JpMbkp6ApLoD+V+EM3Wn6khulqH6kgxbIIJm1Xk/Y1fArGOV2aJG/Pgkbv4pWxPNApyyQt1Be1gGCKuoRBaFkUpEH2JQTFtqYIoqwLaA==;5:/4dEFuxFg34X/2HA29uy7eF2ukUSMTnJckMPCdZ0mrZuggM230xGkq9Y603eC4pyz8VWKd1hLLUHIeMoKEBIu8Pk4Xar5JWq7V9uEF3kdTluHSanaSTcWKAqHaMALo7p4rGVO31jOg5vXpRTimBsPEtUENMvdcGmkqRU7ndHT7g=;7:RYJlXIp1gFKkogu9X07R4FoY/+nmilOAlTClvCHefqiSf3mrVWvA/tSnt/M4Pnfxb+x0PwgFWZalXpQRHguGQBFW7UoGaguKfu6wyT3RP6V9MtL5EwGDiS6XXhc76JJLofIKfPS0sRwSqDeQo9WAlmuDck7sKeOQEegPwvQA5bHRe0iMuhVcPMtwBJoiHDl3CA19oGjF8W/z/+Jsma4catRSvrmldNTWsw3aMwlV2u2UA/qXuTESXuboQGJPKPkP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:25.1533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83a1f30-e9cd-4372-072e-08d63350fd5f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add runtime support

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 52 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 64c7248..58296eb 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
+#include <linux/pm_runtime.h>
 
 #define ULITE_NAME		"ttyUL"
 #define ULITE_MAJOR		204
@@ -54,6 +55,7 @@
 #define ULITE_CONTROL_RST_TX	0x01
 #define ULITE_CONTROL_RST_RX	0x02
 #define ULITE_CONTROL_IE	0x10
+#define UART_AUTOSUSPEND_TIMEOUT	3000
 
 /* Static pointer to console port */
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
@@ -391,12 +393,12 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
 static void ulite_pm(struct uart_port *port, unsigned int state,
 		     unsigned int oldstate)
 {
-	struct uartlite_data *pdata = port->private_data;
-
-	if (!state)
-		clk_enable(pdata->clk);
-	else
-		clk_disable(pdata->clk);
+	if (!state) {
+		pm_runtime_get_sync(port->dev);
+	} else {
+		pm_runtime_mark_last_busy(port->dev);
+		pm_runtime_put_autosuspend(port->dev);
+	}
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -738,11 +740,32 @@ static int __maybe_unused ulite_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused ulite_runtime_suspend(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
+
+	clk_disable(pdata->clk);
+	return 0;
+};
+
+static int __maybe_unused ulite_runtime_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
+
+	clk_enable(pdata->clk);
+	return 0;
+}
 /* ---------------------------------------------------------------------
  * Platform bus binding
  */
 
-static SIMPLE_DEV_PM_OPS(ulite_pm_ops, ulite_suspend, ulite_resume);
+static const struct dev_pm_ops ulite_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ulite_suspend, ulite_resume)
+	SET_RUNTIME_PM_OPS(ulite_runtime_suspend,
+			   ulite_runtime_resume, NULL)
+};
 
 #if defined(CONFIG_OF)
 /* Match table for of_platform binding */
@@ -815,9 +838,15 @@ static int ulite_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
-	clk_disable(pdata->clk);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return ret;
 }
@@ -826,9 +855,14 @@ static int ulite_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = dev_get_drvdata(&pdev->dev);
 	struct uartlite_data *pdata = port->private_data;
+	int rc;
 
 	clk_disable_unprepare(pdata->clk);
-	return ulite_release(&pdev->dev);
+	rc = ulite_release(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	return rc;
 }
 
 /* work with hotplug and coldplug */
-- 
2.1.1

