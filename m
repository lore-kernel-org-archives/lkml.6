Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB51C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C8E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C8E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJPSKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:10:03 -0400
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:6325
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727097AbeJPSKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:10:01 -0400
Received: from SN4PR0201CA0071.namprd02.prod.outlook.com
 (2603:10b6:803:20::33) by DM6PR02MB4681.namprd02.prod.outlook.com
 (2603:10b6:5:1a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.26; Tue, 16 Oct
 2018 10:20:15 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0071.outlook.office365.com
 (2603:10b6:803:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:15 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQg-0007KU-GN; Tue, 16 Oct 2018 03:18:22 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQb-0002Az-Ax; Tue, 16 Oct 2018 03:18:17 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAIGQG005718;
        Tue, 16 Oct 2018 03:18:16 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQa-00028h-4T; Tue, 16 Oct 2018 03:18:16 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [LINUX PATCHv3 1/9] serial-uartlite: Move the uart register
Date:   Tue, 16 Oct 2018 15:48:00 +0530
Message-ID: <1539685088-13465-2-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.877-7.0-31-1
X-imss-scan-details: No--6.877-7.0-31-1;No--6.877-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588143521679;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(199004)(189003)(76482006)(61266001)(5660300001)(305945005)(47776003)(87572001)(11346002)(105596002)(73972006)(54906003)(106466001)(446003)(83322999)(107886003)(36756003)(81166006)(8676002)(82202002)(110136005)(50226002)(55446002)(426003)(81156014)(16586007)(50466002)(126002)(86152003)(73392003)(336012)(498600001)(48376002)(486006)(6666004)(356004)(476003)(2616005)(9786002)(2876002)(26005)(316002)(63266004)(77096007)(76176011)(86362001)(450100002)(2906002)(4326008)(51416003)(8936002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4681;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT053;1:edoFrY1icu6Wis2t/5FveP/S4gNY7R5fzCx+M6kGV//Yav3TYfZwcuaGLY4YQAooz+UZTmmMp0wkpV9yun3f8mmGqYd+paJ4baeMhCW+ke/QtWJqnVLeSolVvicjcd6G
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c495a32b-1e90-485f-b177-08d63350f653
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:DM6PR02MB4681;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4681;3:UssUpOHrN/oZH2G8bCbY2I2BcHkeb5p/uxXQBeoHlZsOhHd1ZLgkYs6EGx2kDTPdh6TkOMCBpgOWwMoV6akWjzyCy4nfDxucikacxalrkoKbaaCd3XERdT/HSBfr0NhiAljpeWIch3oo/6CBd7PQcSImkkrNK3v/BEWZLR6fM+icN2JZpHWbHLTjJbxDA75vWYiv2ud9I7PIlYzQmZTzMVU/6IoqTVHR55OsdLps556ErNG1DQd3JUheb0U2lvHGGlw13EIi6Q3Wio1RWKT1YHaPOrbXJAqmhA8RKVOz3PZHkWEin103o2gAJ3RT8eusOJraKpFROAMW1GU9949GR2HnO2k0BubcClAc03kOle8=;25:jawDPLrNqSwWA35uN1WL4YLvNTWaled1On9qyIXlKE90GM5wOfw6dK5bkbPrivD1VhaD0XpCwK6pjsz1vmhA+l7gSKRi1x/rvnqa+VCGID4sYdGLzFULM0/3E8UikB02VL1PvSxMt3F/ryDB5+ueyS1o57WvGy7II1NIBmrmUStRyASbCaOgGkvvHQdB3dnBJFbAvd8aExCUYHQhguRMZjtn6vnO8J76c1J6br/zMUXhSSpIm5ICvGGrsn0h4yz41OsUUVo5RzxuHIsWNGLatfb4eY2BGLzl90qjALShxRfqLN+9Fz8r2tRTE4SWyZzJfR2v6o0i7y86z2h2IS1p0w==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4681:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4681;31:+DDB3+6MDdBhZkwUZejPDmLl5aOiuCFtaLDR4aIuIxc/RQRD/gR4fS4mU36lyPvIJYl+yxF1Hwu2R4Ct8NFEfddsTGPfrIfRNY5fqlR+tpATMbO0v+qZnZOxaWPntTQQAaNwLAUtVnyheDTohFZuZuFhqWckxApARPgpTPWhKVs0z1Xu79PnMvPFoRkzJUhuj2vHShBh/0CGsn8jO04cWO4/9mgCTFu0wrzkcORB2G0=;4:fUUKdJKfHp0r97NSkC4notRH53X9d36qlYayXQ/NDhVNXApekrJ9RdP4vtd0wS/hnW3F3GExiHxS30+Jk/1iS4P67P9eWPZwb39necMBqa9FPQ5gNiHXS5XNusT0HkMF+RHP5DPQ1jypzQUnUvOnU+mu7M9PYQ8rvHWjo8xqG5tKtkah0o+7Ph/6p7naAWexykMjuJMHjTQ2ET84G4AYL9bv0QSZpkcVtpcNgIEiVGSVVc7jXTY06Es+4IfyOTNxY/PkpL4e0BteJarj+OnLS/8kmWeKzGnZrAUNSdBjZyKHKNYol67VokU1N0A8odnD
X-Microsoft-Antispam-PRVS: <DM6PR02MB4681F288AE28217CFE8EDA7E87FE0@DM6PR02MB4681.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(20161123556025)(20161123559100)(20161123565025)(201708071742011)(7699051);SRVR:DM6PR02MB4681;BCL:0;PCL:0;RULEID:(400006);SRVR:DM6PR02MB4681;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4681;23:7QjjQRTLxtx8G/v/dZJVC2ch8R7Hr3k0ycZf1F8dv?=
 =?us-ascii?Q?+AVO30Hstm24ZblwR9EKZTPUaMLHS3tZjLUN1l+7tWfBlcZaGxYaFGl2gWHX?=
 =?us-ascii?Q?r16De2D3J0/jwfyCfWZRkAJmQOzU0cOcLXDQ4pnj2OkDaWE3KYP/rCTCsCZT?=
 =?us-ascii?Q?PhIOz1udZ0U/zL/1Neb9bgo7UdjFtTNln2pz6fbXB+sO2T8AY1iaHCIYpfEp?=
 =?us-ascii?Q?tgFM3e10X8pnOx3TkdEPaIJvdHbQedEpTjlnyvgthktmUmTUo2aa9M/rKXlu?=
 =?us-ascii?Q?8WBYTtMFNcM7ZfVXRD6xjlf7yzxL9pleSlWVxxUlxnidpEga7fg9iVALjAax?=
 =?us-ascii?Q?0LD7L/nxaY+WBn82IdfR3T4evpKilcUioBbpyufu24A40vCpwnSDS0FmIJ1V?=
 =?us-ascii?Q?Tp0SqEh/RyTkZIli754sJjEEzOd1q4p8rDs1tdq2SK0bm9atHrYZpz1IAe1l?=
 =?us-ascii?Q?As7f2QNFZU6IK6HoVRns+TBq8DQ4fRNmW3C2IYr9WiJRqNuaicpEuTrC5GBH?=
 =?us-ascii?Q?nAA7LB8zy4Qk2o7K2cPCS79qYsakjmZ/k4ypeBdsXtqtHKeEdEXBAYtIt8Z0?=
 =?us-ascii?Q?LWQ8ZX+1I6lFmjFEypv2gQGCaYqgHlkJIh0TJkrCOm9p5qaJHBij7MNUZkXj?=
 =?us-ascii?Q?avg9CPoil4oEFAAl+7eZxhNLR6UMGSbG3bxbxttBoJBSbJCoCtvd/v3wBLj+?=
 =?us-ascii?Q?sNV5HTdeQkdqr7//lTUPHO290v0PKm7NXBuDRFl06CTskMUV9GtwXFJMzOsT?=
 =?us-ascii?Q?wQdVwDa/JLWpa/A08gefM+zP0R5PjKuzcwbTUivmr6dXk5YxkZhcAfOESjcC?=
 =?us-ascii?Q?7IC0eh3BwMiUp+S/3KsLmohhONbrOSc54YRlMzqk1/4W3kXHoi6/q0ZdeGZ1?=
 =?us-ascii?Q?mAeykJaz/CAQfI2vyFvqXVeRbHuj3HMATCAMiiTjqITFeNN11p9TXbu077g6?=
 =?us-ascii?Q?ErWBsh/hjYPvg4mloM/+mPP5VmYIfPIEBSFo/Z2m/4aSUBFfWpcs6y/FY4vK?=
 =?us-ascii?Q?njc3yw0VlY2Jc2T8kLeLInQEp2w6D1HSVMGLKpRDSLP2CtX282ooRC7rHz9f?=
 =?us-ascii?Q?IZ6+kDola/im+/jCaOVhiygAa8b7tW6+nRlJpxwVaJ5m2XbRgrrxTY++3QWc?=
 =?us-ascii?Q?CXSMuaxVpPc2H++cKx/utd4H/IPl/4jJ+PVUftaWUscWlrovX4rHHPCd8bP4?=
 =?us-ascii?Q?px7qGoRLgqgr7hbhKf1RLZ7zJJl7gO1HN5fxncLOWQIqd28f9U1L6cUgOP3I?=
 =?us-ascii?Q?DCHf98yg8xHFF0BiX8OFwCRxysUF0I1uZQ3fLS/v8Lo2Rt55zRjR7oQKJZp0?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: ffU4alAV+BDodDY17eiHulsxnA6VsQxKpRivSRW5TJ+YccxoDbNo1qDdrukL0WDFKt+dkFiWm77ychndvYm+oF3DToUhDrIk12RcB8TFDzIXiLGQm+qEloLx1Ey+XVBu5zOmrjaUY7uVUxLakmbvZ+jK3FXr6rzeEdEBZsoRcU02WUXzPaXcQksnuIfI4etaH+lEu5QstN6yddMSMDC+58+F4zGM6WG49mxWx5edfWT6Kt9cvDbPmeuWOUrLkyiwy3RNatA1Leb0Vo2cr2aRUnI+MC0IoaeoGXb8rCzY7puHZQN4adG3SFyF/hEbCMFYnMmLQSoJInmnC0ExZDYbvSev3qpCa3o7SBhcCiOC6zM=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4681;6:rBTRxH6ndky/vpHa4iozEJhNW4gdsltzG4wqWXqKNqQZDoxEBO9zdwRaMz80PmAYA1tVxodptPa3EJetnfyMoKxH+znKbaJDKHONkXuC/XZx4g658dYuBC7ULhnrwAbxZINgvUoDICnqKqWCD35GHF3tokBp0FZrOH+J5pAAf0FagRdpP2bm7eoM7PgrTLhxaW2TWJEGI8riHXq1oYRNNVg47oZyUAx1AiIYb+cfSesCIHSR9+G/W2Zl62Ut00lM2exmgKJ8ktgfqgvxR+a9657hpxtHwpbnGlyNIFJDQCy9W9j0jvatay6i12UCZAKY4+7OPA13Vq/4ErKXRFFni4F1/b28zyQSvBQreiGcW3D1zhJ2XYbQQgzXOcjAZCtLptf7T+9TVDC0qILfSZaOKp2h0qtZOWkgm56hDE+U1e7o8bforuz7+Q4Ao/A1jnLZ3cw5w/3wpuPZ0HbTV9gIIg==;5:4vAq94NIj3Yi4QQNQuwO23sJmsJX3jNWx6rjbgudrW4aYy/3MChv2PzrJaoq7G8/BX0EfW5YiX+mkCNvbxx7JFu6svqTc++kv5QuyzFvAZtGmq/nU5sr5RAUAVHugmmXu3Gv+Ed4auLS8qk+NjWZ4lBHKoMNLzyCWhCWa0t0cb0=;7:QEQMWGJKQL8+dOpQ3qnntBcEFxaNpegZ9gYBQs2x5rUNTcGvWf7OXSofVyykvMobbzu2AJRVAZCqeYJ8LRMiGJadu8uGUMvai+zqP8M1BORbJPxDYq0t67KDzNlWGJnx2j1Nt+yc+NmvDI3q03ZkXioTtIGPLzBX9gTJtkHbtK/cB4k9uMc5QYFkGl+gEZKue88quSoPUHazoPzG6OoUnNyIDuZlkwdTv9fbyIwqKilkO1QdmKa5MsC3omX3dW/d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:13.3990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c495a32b-1e90-485f-b177-08d63350f653
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4681
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Move the uart register. This fixes the error path where the
clock disable is missed out.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f0344ad..77bc9d0 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -763,6 +763,15 @@ static int ulite_probe(struct platform_device *pdev)
 	if (prop)
 		id = be32_to_cpup(prop);
 #endif
+	if (!ulite_uart_driver.state) {
+		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
+		ret = uart_register_driver(&ulite_uart_driver);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to register driver\n");
+			return ret;
+		}
+	}
+
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct uartlite_data),
 			     GFP_KERNEL);
 	if (!pdata)
@@ -794,15 +803,6 @@ static int ulite_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (!ulite_uart_driver.state) {
-		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
-		ret = uart_register_driver(&ulite_uart_driver);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to register driver\n");
-			return ret;
-		}
-	}
-
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
 	clk_disable(pdata->clk);
-- 
2.1.1

