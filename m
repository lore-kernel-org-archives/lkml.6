Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D54DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C542083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C542083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeJPSNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:13:20 -0400
Received: from mail-co1nam03on0067.outbound.protection.outlook.com ([104.47.40.67]:55836
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbeJPSNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:13:19 -0400
Received: from SN4PR0201CA0052.namprd02.prod.outlook.com
 (2603:10b6:803:20::14) by SN6PR02MB4685.namprd02.prod.outlook.com
 (2603:10b6:805:8f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Tue, 16 Oct
 2018 10:20:40 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN4PR0201CA0052.outlook.office365.com
 (2603:10b6:803:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.20 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:40 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQw-0007Kx-Bl; Tue, 16 Oct 2018 03:18:38 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQr-0002DT-6c; Tue, 16 Oct 2018 03:18:33 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAIWeB005765;
        Tue, 16 Oct 2018 03:18:32 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQp-00028h-PD; Tue, 16 Oct 2018 03:18:32 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [LINUX PATCHv3 7/9] serial-uartlite: Use allocated structure instead of static ones
Date:   Tue, 16 Oct 2018 15:48:06 +0530
Message-ID: <1539685088-13465-8-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.678-7.0-31-1
X-imss-scan-details: No--6.678-7.0-31-1;No--6.678-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588406191692;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(189003)(199004)(107886003)(8936002)(83322999)(73392003)(450100002)(336012)(61266001)(4326008)(47776003)(82202002)(55446002)(2876002)(77096007)(305945005)(356004)(6666004)(86152003)(86362001)(26005)(2906002)(50226002)(9786002)(76176011)(51416003)(81166006)(2616005)(426003)(126002)(76482006)(50466002)(316002)(81156014)(486006)(16586007)(87572001)(498600001)(11346002)(476003)(446003)(106466001)(48376002)(36756003)(5660300001)(54906003)(73972006)(110136005)(105596002)(8676002)(63266004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4685;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT028;1:tlQd/XLsgwg0bMVfP0zD1HnGBmuq7awykTehrVnpWoji8hq6i0ogNpmJiRnVW2MNNaMPDnoAo5W1QW6IbA9K4SRPWiGJukEfKk3agXckvUnhaZw+/muu6DkVEie1Y0/1
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df16cc2-43a4-4009-064c-08d63351060a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:SN6PR02MB4685;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4685;3:eqM0qHpvsS3qu8VpUvLJ2+jKJg2JIu/mI/MLNQBZZMRD4oplMF+4xNt2TyrutBuUN85tBks4utBpegHgxGS3wKviS9C1BtHEhrLUTDhJoxgTT8xa8oiR1hI5Q2EhyMkok2mQwlgJUiS42vsNpRn/MLgD/GxuyPKChLj7bGgsNiSMXAyxJ8kLUmg9m5AyBl2OVgo+0gaIY1yxi7/EmQog4E5L3rv0woeMHU2JxOpZRXhIt8DCAno9jVCF9u0R3cwfKPLLJAI2a0gTdDE31UpUPIg7WlH7BNReq7yq3UKpDzxmWHaN9tQvH8J6+gF53uaMF159UNQ/aeTClnxEub5F3krA6Mrd8uIT3WLGCENMdf0=;25:D/wvQlR9cAY0iT1nnl9tYI1OUVKluGJoTt4hOeYEux1HTm6uyKBIfQzQ5qXRwUi/9gF/+4j7/OXkBOuqrbmZVPa237NpjIJLC6Kkdi1n4XCyAE4LKTDJiFT6SOmNzLlfFY4XnfCxxQfHTR45G5klmDd6hmpvU+ao3AaiCRJdStrjLgV7YVGOBW1sCFOSjy6msuLA+KjpoY+2K3ydRPrQI4Aq7kVsvfgO+yWy6SelH+BwPRIg6N8DiCQOz7qgqM5IePuUHIy63XIuJTm6KFkkC2flGxcWNw+0Ps4f7A1nbPvr1rfdvvhKiYCCdYCjpIqINJKeHfFPdR0CuZ5XNXCPzg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4685:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4685;31:fgsnt7OTa+4Y7Crd0AAwC0KfBlZ061HCVX1woaD7tVJoqLBfe5p0fSvq1saxR0bXzOtJiftDuaKXraxjou8LwnSpRTq/aYs2pxjWZiGpg7+RzGCXBKUeAEb0lwq9CE3N4jj89luZhW9qDVI42N0S061INxy7wrdKSGUKUSysfnLh42jTz5WxuD/xeWnZg0I1y3Lc3G2OTY5f/JM0qQKQKtgjJFj7xR8bg4wrZlGxeKM=;4:y8yED8hMrnliI4SBCK4l0b+Ddm5oBx5QwH6sY01efSoRlAEvJNglti2HtTWuTwEe0bvGbtUgNH5c/vGsvl7eTRO30L1V/UMrsgLy98VfxjpUcFWAeMJHr9Utr7FgChjCx9rwZ2sLoORvcu2l2IjTkA8QAUBJ9OU7Aeovlm5dQ985bGuzSKK9KNIqS2g26rhljd4njR12Vp1HmET4iky7aBTiJ/rE79a8+49kOfW8iyk3bkxt8qULHHzkzTwH/TEb1fth18vQ/RRKAN01B7bW1M+ZtqY8cmBgOTlWWwZRox/gDjiraUx3el4blBSMQ6N7
X-Microsoft-Antispam-PRVS: <SN6PR02MB4685B251D9D57203BB056CE487FE0@SN6PR02MB4685.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(6096035)(20161123556025)(20161123561025)(20161123563025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(201708071742011)(7699051)(76991067);SRVR:SN6PR02MB4685;BCL:0;PCL:0;RULEID:(400006);SRVR:SN6PR02MB4685;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4685;23:ov3erJwmURm12M3AX5R/mRCf/sxht4FCUCgBmOWgz?=
 =?us-ascii?Q?mIzBh+TUOs3/PzbULnbCBc8vhtXy3uGhTq80XwLh59bSBzuJQLFqNere3uy1?=
 =?us-ascii?Q?LsrwN6uz4j+r2Xp790r/fgmxDxARl4x+OfutwrI1pFAt63NmZyA3BDCkMXCW?=
 =?us-ascii?Q?mDP6ELBjMr+FtKBCGwNYGK6WYFfrcLVrk2pkQUYcTa75s+pp0M1bJdoFwQYj?=
 =?us-ascii?Q?DrKomX9WTvK1qWb5xpIzvWis5z/l0B2QILEUF0YrlqMWET94+1+1WUcYlmbP?=
 =?us-ascii?Q?f8Z8MaMJJag+ai3UZsAv9C44uSrqPwhmI3nQy82Ht+0kBwQpTWPLNualk29r?=
 =?us-ascii?Q?Dhi3fb1rqONUWkpzvH4wUDkkl4XBrq1FDgL+NvFAO0FfmU1gtRRxpARMNR/I?=
 =?us-ascii?Q?Nzk0sLgX0vnwmGGTCZsGqOYW+bub8zZgl73lfltqCG4l3b03gtRNw9Kq7Fx7?=
 =?us-ascii?Q?FwKZo4hiGFJel9qaWGKsj1G/X1orrJB1M5jPXw7FLhgoypHakWcNQajiR18c?=
 =?us-ascii?Q?uQhRxmBvPgbV0oRWffev+DKLadsx8LnTfKHOEXNThckw8fw7+GCEe+JoqNk1?=
 =?us-ascii?Q?wOko1EFosZ5LIQSAfHAU4dGfP6/51gq2K9u+uVtSmDKD6Ix4xqyAkNBJxztN?=
 =?us-ascii?Q?TV1DKp/ZU6yOeTyIS46TrumTtaAJ2Y9Pu47T7sFBtKA9ef1bi5/91kvoL0jm?=
 =?us-ascii?Q?dxLItPCdThxiqEleCWWWQ/RB8mWxN7t9RqG/paZj67dOAv+qC9uWpHZQY0f3?=
 =?us-ascii?Q?NUFOYJ3lV4x5FJJeG+JrNsUmOZLWBzpQaFNRjnmT863reLy0RthEEE7x6Bru?=
 =?us-ascii?Q?D9nGyvx3hWe+IFvoB2JiHwtu4Ew8Il3Om1TFcz+XsUvA54/EWgO8qCMAoflq?=
 =?us-ascii?Q?KC6QlZqbBwpYoytRAIOXr9eDyKSykWGuO9kMMBRX+oDBRneLKj1I69uzcjP2?=
 =?us-ascii?Q?ciwbP+9fv7hq8O7yhCNPiGUQsip8pbmYUP9YzjwnvxiqxhV2ozV0iCCGYk5g?=
 =?us-ascii?Q?5eXA9ZDaPN1n3mceic9mDCCKV1uMBO4TLBSVIzYN0zC/yAQ6UoA82kzqaYAA?=
 =?us-ascii?Q?bHYxfmUp/8rfYbSU5D7z8BDy850+ocNF4r4EpzR9oZMzg5db27RJOK9hfdxh?=
 =?us-ascii?Q?9fH3q2YNCNHKCkGHtlxOyoIn2zM9Aov1TphMekB9nuIv7OonUEjA+C6fym15?=
 =?us-ascii?Q?2ubI6sfPusXyPdVGw/S+VKtt3k6YKtcxyJ88Iai07JfEVMtbh0scIMIMzWFK?=
 =?us-ascii?Q?cvWvRl/Xj7deeTzYXZ8W3s1LqSpELik+uk28nUTi9CMsui0LCTi0VCugbmSd?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 4drDRhVIp5b7/8r/EFrmDTtAXn9cdAoOPoxLnJF3wcK4zSSrjbbesbhQSagmnGd+tGhWnS2eK6pXWCH3RDBfpO0kGFVbxyJoygEgNobrknoH5gYzgoSM/EeWk6yd6sNlTb5auRG0GqrzRFefrlZzAqlv1RYOWu0+luXwNtzFxqMAGyXi0SYNvL2vW2M0VK10XwTCukcAJS+v4h5OxoMGN3moOprTnXDjN4+pKXJq+muDIfuGGo3N82DKpfm0VWyvT4akmggS6Ll6ZxMMy7YrRBJtmv+XDGgWWZ/qTBOOjjYvATN8q6Wn8YH8hQL5GV87MD1png4sshBE6h0IqkVxTVlm4k6CVFinV33W49d2TEo=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4685;6:C9iCGEhCt3kwSpFxDMASr7RDX831Lm9C6cUYzkCGoRyB9GK7nDTyIFmLApn4wzGQmpaeNi2WIghuJ1fO0cohkw80edD99/9H5+0xfPy6I8nkH6p5xB32yEuhSa7aJhtsujOWZDCuNHcsnexN3o/MvYmLxpUcjWwFwoyW50UlUw5Wi5tRIfICvExPbx4U2rgKC0ftC4SmSAmSoUoVuP/dCSzKHvKZYsbpK5uYd90kP/Wx5zQkGs1YsJ2y5AmxS9aO2U80xv1yIdAc/1MoYPTymweeVK633U7GeHOh2NFBDH9Drk0QwsMuZ79aSGBvo1I1JhdjiaTawy5ydpoUu7XHXG3KiVdAMaf+9SQlAPka/yKFM9axn6ulDEb5Sk63d7lsmktw9k1eGyxsvHBVYdQhNrQxVwDeL/emBFR0tDzkXJflCJSHemS8uiIdvQ5QYjcn8AT8gOmZRO2QgyzEhxTRuQ==;5:quiONAlcX8BkFbeWOMafUiwQycPOMHXVMYZ6ZNQd0uuIUGaJIdFAnPT6rlIx1yV2BcBZ6bUr7qGjScSM9iwUPByqiE7knXwtbWWp9+ketNZCU3ejujFpt21gFNhNRoz57EExRRP0k3gSpHOCWL5QyL76uNmkm3emGot6Uak/nxU=;7:YqXSpAaxxU0igDrwgYxguZO7cmOWDPLew+vBLB4KxLEeSlAqeLICKXCcGvq8hUpNnwEKhhvy+7mLhtXgQZzpr2ueJv4pczHrKwhHZJcUxix640sVtK1rW7np3bVD/jv1Ap+efN5zMuS/SFbs7aMtUyISAu21Jln0HcgV3WUJrjP8d7JbQKkpiKp2f+DHef4O/yV7gGdNw9pQ3tiVH2AD7dnfJMFkEAXPXjqTuvxUjdo0rVYT1G1AgLpqva7cduGv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:40.4316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df16cc2-43a4-4009-064c-08d63351060a
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Remove the use of the static uartlite structure.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 9c99a1d9..20fe11f 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -670,7 +670,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 #endif
 
 	/* Register the port */
-	rc = uart_add_one_port(&ulite_uart_driver, port);
+	rc = uart_add_one_port(pdata->ulite_uart_driver, port);
 	if (rc) {
 		dev_err(dev, "uart_add_one_port() failed; err=%i\n", rc);
 		port->mapbase = 0;
@@ -681,7 +681,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
 	if (console_port == port &&
-	    !(ulite_uart_driver->cons->flags & CON_ENABLED))
+	    !(pdata->ulite_uart_driver->cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
-- 
2.1.1

