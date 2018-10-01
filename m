Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B110C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1C8208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="wa0Lwq3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1C8208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeJAU6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:58:07 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:42264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729395AbeJAU6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YABUggp390lSamPf/3FCSR1FQhG9c/1Evr82RVI0VMA=;
 b=wa0Lwq3cOBrvVuJF6cwmLAp4bKqYPMzOAvfed9OwXoGRknrzbUTFDuzgKEtCGvvNZlyXC3moa+OCyXRxouo3rpa8U8H5lHkO5rxHCq22VhSebfkuK/Z6jtsf5j5bmklZwBosgdrek+Njqsueg38eah80r5Bg0OyDtMjEpnpiezQ=
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4659.eurprd04.prod.outlook.com (2603:10a6:208:75::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 14:19:59 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 1/3] pwm: imx: Sort include files
Date:   Mon,  1 Oct 2018 16:19:46 +0200
Message-Id: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:803:50::19) To AM0PR04MB4659.eurprd04.prod.outlook.com
 (2603:10a6:208:75::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e65dca-7156-46af-a67b-08d627a8f86f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4659;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;3:yTZmjqryHZnKMWM6S2sdh1HS/SDTSJccxJbtoOW0+NuqttTMnv8WDEwc+L9Hc34j+eNeMyGELq3d2T7f1JnWguiyHaZuTQNAopFhzxJGIfvUm/i6LG3x2GrLQ5jid9GBn+24WdHRz0zC4fqQO7eWE5uvVsS7G6Arl/WUg4Q8a44tmsKuP4n75dzWWcOiVMsmG/d75FdFYGt8GVTxKpDOypPqrJbHn3kGeDxytb4n5BmCXpaqIV+z6MjwWqDRPtO9;25:wW9fk1QytKMEW3zWWgOEk6pPBd0fzAN+l/XciobNlpyJRmiuI85yk4ldgdPNocotl6we+8HMgSsTmgGe4qkJut9ntQJQu6tl9dDnr7MSMCYx9283NyFK4gQXhZ4BmAw8cSzk/LLeTE0lGND7dexwuRgQyn+D/6MfD0//BNHIjoDoaD1BCQ7DdaZsYnAg7qNOHz4NaxV8F/7Rwcyv8gb/JLx7Cgem6diFAGQCJSnpvuOzEFEb8aCAkewrlcOA2tFPv8vpfjFKRbuKzDh9Om1s0Tzfv6VCn4BXAzWDxOD19uI8DbNXijHlH1iKo8XPJoZnbZuBAYaLw7iKUFOJXRTdLw==;31:NsuB3gbu9G3+eDuwbdmIoZAX1DWYOE/0t6uGvhhwts7bB/d+FwQ0MkDmPLZj9I5H/TEg8KlEKUCC1gklFdbdqOmcFpvLdLS0dvWVUmCLlEQAD2adPik3c+H06NIytSXR2kpbNPOI2DclmQQhrhR25ZM0XMkY4KnxoFv9omOeM62wGEpjniMIk4ckccY68o+yx2FMPlmv31MISgW8Ng9lUSo/xZD5CpkSNGaTgy+kfu0=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4659:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;20:RcVY6GwtYMbrs5bPF4h9tflD1H9+0YfmCct/LK1jJZ/3QgTuyedHf+P/yJR8kNsB0yMav00XR/ibpDxPgelRvFFBYr/9g6zho82zDwIZYEJDssCcKwLpLXDKhoK/K5d2sIhYThqM7Zl2D3a6mn27bOXGMDUaSSCAgIsIqyGgDZIypGR8dXbbb6Eir9EetT4PRYKaD8dTGqTrLecTwr+AIS6b08mbExyGlVCgRcqiN/rjEH4+OKJUrfmeeYjoXTQG;4:OoU9c22Q9gSYY0Tl99RsAPdD4zBbjJ6s7P9pw8p850DVv+n69y6dzwHBQmUrLHOcozeNLisCqCKu5Z1MaEXXsB07CFt5k+ECAhCv+ILGagEJ8KQ29yeu5z4YwtnVCpUIZYzLKdgSceWL7qQrlDKE+qY4Gku4yex8hp4sTTv+0eGYoUOaQuJ+bQuCd/9A0DNd9Txgh14yuy1uPichg6HcZE0M7jtIulNDokhIr2wu1a12RHstJsAq3RFhQkCh8pOwoAWzELb94xutYtEgWh0iBQ==
X-Microsoft-Antispam-PRVS: <AM0PR04MB46598E7D8964528EDF514D039EEF0@AM0PR04MB4659.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4659;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4659;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(376002)(346002)(199004)(189003)(6506007)(386003)(6512007)(316002)(36756003)(3846002)(6116002)(53936002)(34290500001)(23676004)(86362001)(52116002)(6486002)(6916009)(476003)(2616005)(956004)(6666003)(50226002)(68736007)(2906002)(8936002)(5660300001)(81166006)(8676002)(81156014)(486006)(97736004)(105586002)(106356001)(478600001)(72206003)(25786009)(4326008)(39060400002)(186003)(16526019)(6346003)(26005)(7736002)(305945005)(2870700001)(107886003)(50466002)(47776003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4659;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU5OzIzOjJydGduZXN0cWIrU1ZqVmNqVnlYWjI5NW5V?=
 =?utf-8?B?MlBUbUZhNUt3SWZHSFp0eHpvUFE2OTZ4ekl2UWxrNkVLaWh1TG1EV1dLRits?=
 =?utf-8?B?UExYaGJrd3JDR1I4VjZzOERmVmVrQjRjdnVGV3l2UkYrQVFPRit1RHM2eEM0?=
 =?utf-8?B?SUE3TlBwSVZBMnp4UlZ3ZW12bzlQU05aM0VHZnlUaCtnT0xpWjNyN1dqQll6?=
 =?utf-8?B?UG5EelM3S3ZBYVBBZW9EWjFUTzFQWEEwM3lyTnUzaDVoamVGRkgzWEEwblhj?=
 =?utf-8?B?ckdoT2UzTGF1Mk14amY0UmJ1aWZNZmNFaGUvUGpNY2x4Y2IzYUVjeWkvK0dI?=
 =?utf-8?B?bHBuSzQvc1JoV2wvM1ZUSzkzRkttdkxwVXpuKzVnTUozMm5uQWV0YkFNeVFz?=
 =?utf-8?B?c2R0Zm5uaVJWNzk4R0lPYlNVZW5qWlhRZHViRUxXQkZ6R1NvL1loQ0QrWFpl?=
 =?utf-8?B?VDV0RFlEb3FEUVBzZXNzUGFkM2xRL3hWZk5RVUZTR0orMEYxRWdVNS9JT09k?=
 =?utf-8?B?RGRpU0RwQWx4N01mNG9qV0NhLzVlVUJyQkJmZnFDWjFWV1IrLzhiWEs2N3l3?=
 =?utf-8?B?SGsvNnFOQjZpbkUwZG40UVZsUVhOYlRaUGQ2eFZJemh0MjM2dGtUY0w4U0x0?=
 =?utf-8?B?b1h1N05HQjRJYUNuOXBsdkg1Ukx0ZHBuN1NFc000Q2hEVHE5UFJodGFTRHRr?=
 =?utf-8?B?S3lRMmdiZFM5ZUN4TkRtMjV0d1NoeFhGRDJlM0Q4ZTc0bGE2eUhSWFF0dWor?=
 =?utf-8?B?WE53emlPMTVlMExFd2NhY0o2TmJjMWFGT1dqdXg4SnpsKytncVdiVDlEdXA2?=
 =?utf-8?B?T2U1OTlTOVJOVmliaWxTVkZObXZncERtNDB0UHpCN0NsM3MwVUhwSWlubFk3?=
 =?utf-8?B?KzFTaVdqQmVLdG5EUDIvSUFma1NseGQ3bVRMN0daWnlYSmY1aVkyV2wzaW83?=
 =?utf-8?B?bE11U3pCOUhOSVdRR1N6cGNMQ1padS9aeW9jS0h5Sm53Z3ByZ05ZNHdhOFV4?=
 =?utf-8?B?WDY1VkJ6MEx1N0l6WXJ4NlFzcU1UMExzaytwVE14WEExdVE2ZDBqTTdNVjNF?=
 =?utf-8?B?SWM4U3R2Q2gxa0phc0VxUnduMGdyckpXUHgzdVhjRkNIL2pxRktKSVN4Y1BW?=
 =?utf-8?B?SmoyNmFXZkgvM3VnNTBJZFJCVW9SdEZ5UDhza2xFZ2p6OUlUQzJ2MS81NktU?=
 =?utf-8?B?WnRmQldJNG5RcFdZczdGdXBXYXpSQ3NyTUg0V3hhekJVRXd6SzMwN3IvdFp6?=
 =?utf-8?B?Nno0NmpwQjhIV0t5WnpKNUR3SXlVVnVPVHFOWEh4NnZyL1RqKzVwdjBuTU1h?=
 =?utf-8?B?YXhyYjF4WVgxbWdEcVhJSFNzYXJXVWdkT0dnbFNFOENFcFpkZXQ4dnF3bWNm?=
 =?utf-8?B?Q1lpSVZvU2E4ZDJ6UENrY0VwV01hUk4xb1c4UXFzNHdTQ0l6SlFVOFlCdng5?=
 =?utf-8?B?YnJJc1pWa2ViaDMvaHZHT0NNS2N1alBtUE5tanc4M0JkTDhadFY0bjFHN2Fs?=
 =?utf-8?B?eko0Ky9ZcE5JZG01NmtuSU9GZ2YxN2lVd1NkYlhOei9JVHJGU1lHYUQ4N0xQ?=
 =?utf-8?B?a2oyeG96cVprVG05VU1GRC8reWp5aE5DK0dDRE5wZXN6bEdXR1IvS1pzTHZ6?=
 =?utf-8?Q?zNR9ggMPIO3+pM+ppiI5?=
X-Microsoft-Antispam-Message-Info: 7yK+/y6KtvP55LhS5fHoAKB6QglnWLYRsp5OH5cptC0kER38jU2ZA//UngQldBN1lV81SHPiOmh7jtMbgouldBo+jCuBqhZtNXeplczc8lf7EnqN5vjLEUcFMT8G0n8x/Cnl4BlI87E/7nM0CpqsINPsx6Jgl/2+qU91ggJp5Wgo/Df4G2C1BnfyKyE8D53dvLgquQ7h3mnAYS7mpZsvnLCaV1lrAIHsqmeAmFVACrAgKAcwYnjlb3sHkhHD383gvcQI5Oztz9RojwlZ/cuJrGQTeS2NDWvjm24QZtpCr6NOOBE8lkSU6lt8mPq+65j/Y4oUMFPjFeEDJ+zIpK89jccFoCB/6MTt0lIPmWrYPdo=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;6:F5bjMgjrtxzIWB/KG6aFNcr4lbpneMS95nvQMBKYfnW6BjZWP10R+Kz6cJMbMLKDXs0aCB0pOKgF8u8WtEmblNQES7toSTqQkcaEoo687EtU7p6LWardIUzSBKHSr1OLKLzO6765ex4m9lr/An6J0leWyO/Im+JbRinSbSihpQDNHJMSPDPou1/I61/9vozPJm8ilDzkz6gLS66v0gUtdxcol8BrG7NJ4pLJbyMW6u2tujtU05NxsEShQf2pzDNvaeuwe+EppHFajIXQdddgNtRxZQ+Ti7u5aROR6sRerQXdOgAb6/+n6+tPtY8z/AoIA0uyIp/+JP+vkq/2Hyt6Y02jQzR2B4PhvH8HbW6Y/qDfaA4sRXONUcFTHiNQR7N+nKLfZdkOrAhEY4wG6yBSyM5hOLXatRSPVmZNrsTkgbdIvLWBLYv8MI1XBwQYnGQeBV5tspLM9INPIymrZ+g/fg==;5:UdrCNbbE60iO6UO4zZrRIXo05VEvCxCR7YQNZme8Ia27p2HWf8XkjjndueZLQ8uOWsKQISGmVVHbNss4FKhwQfOcPHli4YZe7aya5yGLeTXxsq3VJwPwbKJXQIFqkl1cSxhoZmqM2J56q832a4O0RQLtDHwZvsWxZibeRcqu/Lw=;7:tZN8BqB9Wzdan4XaKygqyQwq0iFRmZOpLou25AyPTAQDak88iI3KJs0PwVpGSefglBWdkuBQKmYANsMJWld3732DP4l0ZNhM3BrA/qsdvjVoJYKIIq+1287RjvaPHNBVZang4+UreLwLfLfN+2Sr2O1ILWBWXjagPDo1E+lj0WwyZEvT+9P3w9myNZGkWPvziDRs2rkUcn2WQVoRHTp645j0HkUq+G58EY1d0/hhaI8Ft/6XqxHoXusYiFxDo+fw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 14:19:59.3215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e65dca-7156-46af-a67b-08d627a8f86f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort included header files alphabetically.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/pwm/pwm-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 1d5242c..bcbcac4 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -5,17 +5,17 @@
  * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/io.h>
-#include <linux/pwm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
 
 /* i.MX1 and i.MX21 share the same PWM function block: */
 
-- 
2.1.4

