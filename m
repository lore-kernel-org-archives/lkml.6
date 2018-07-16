Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AAAECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED24F208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="Joxl+mQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED24F208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeGPGyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:54:03 -0400
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:58832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbeGPGyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0YmPIOaaUabm2O8Irt+eGKxMs9jO+KV//ranFv1rag=;
 b=Joxl+mQLk4rCQT0iNwTQREJJAKh8clgdWxOhU2SimFu0Ku6gnKRNjTiELN9zdVABS1aZkpE51t07gGyAY/8l7zxggVNd8IQex/60dnvIQ794x7sjzl/Jj0xYV1WMpr4SMLyoVEtgwrMcvqagr333Vgl+rvrj+w9eAEbGmw+5FOY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
Received: from localhost.localdomain (171.82.0.134) by
 SN6PR04MB4766.namprd04.prod.outlook.com (2603:10b6:805:b2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 06:28:08 +0000
From:   "ernest.zhang" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com,
        mike.li@bayhubtech.com, chevron.li@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        bobby.wu@bayhubtech.com
Subject: [PATCH V7 3/5] mmc: sdhci: Export sdhci tuning function symbol
Date:   Mon, 16 Jul 2018 14:26:53 +0800
Message-Id: <20180716062655.24703-3-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.82.0.134]
X-ClientProxiedBy: SG2PR06CA0180.apcprd06.prod.outlook.com
 (2603:1096:1:1e::34) To SN6PR04MB4766.namprd04.prod.outlook.com
 (2603:10b6:805:b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3f3a0e-cdd0-46e3-803c-08d5eae54ee2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4766;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;3:v+PSGvYjivs1gAgZQDksyPS7Zs/jn2RahgqC+GxGbY/hzt8EYiwOhlgdmidTXyhCSxpNZznFowBbGpBa6Iw+UwFJjq49gO23Tnzf9W38oIsQnkVL4xD8tRewpewIBTLyAMNIlEymXRcfzapfbgek5lWRM+b+yPFb/3wbgUthy/C4ksSizpQTfGv3cuZyxsE/d7MWjiKAz4uLTNIflCB06/dgpA+BNRAheNnnh9eVn4w2dIWdDi5JVu3YLsM9Begv;25:PYLaRnVlLPlRIcx9d0D8RZbST/6CBo91tX2p3kW2gGbRB2P0ODOKoXY0NEVtmS3bC7Q4flE+boPc7sxekhVv6ioet4cf+C/lwLY8WmPt4+VDuzjjhm3WVaf9wJ3QAw4j5/H63Z27/2cwY7Zi+ZyqzmK98ZMetXcsJV3QSLUnT6iRQ+f4evKpZ0iwNFxyou1x3Y67Te5oMNiR509bPyrpHvfJu/KzLqbJ0g4jj6icdJnqfpkmf2m27LnfsfKhZAiuhuqnbtt1evlgkulBzm5JS51QKBkzMagEO/U6BBziI+AJnsXQ8QnFchDcIosOmYVneLY6iEBRJIIQ+GWhhJ+XpQ==;31:zRXf803vHyHNHx7ny6+c84Sf1RrnRXiRVpLZXlbdv2OvSNMgq6TFsXAU5Ax1VOuo6fT7dYCbkSC+oMlxrCww9lZQ3EXAkwFTwFsxe/d6RxYkr4lig86e8rizc0qHo8newvZEn8akUrUTwSCFudmasN8OFISTbw/re6uoryaXKrbBCTkUIm7nYsM9DGeyFvp2WpCUVH0u2zxyYWA4PgnO9+xUYPg186L7HM0J7hIljk0=
X-MS-TrafficTypeDiagnostic: SN6PR04MB4766:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;20:zWjVZ3LECK1zsu/fIHXTEpcSe5jlZdInMA+Z8wM0TZ3SUeffVbmwOjyQ2M7nTdqlwEtsvVSXwTfD2DA25D564rAIXdDYbLPQWTXN3PFG/iK8eC0mU2Cg2rzluuQFM/icrGhSTyJbT6+2Hp31nExq9bkq6IIUhq+x/Io33Zb2wgYMZBgnFZpGvMjQAaMmX98VOzxJQvw5SxOs4ZAcc4iM+ELfOZeGvh70xfqr4HMdt4FUAZqduTpsubae5r8tX9dlai015ZSHkNap5Wo2VBVt4mksCrCxvUeLYC5895/aTNTB4piTyWp14c4owXHx0k3/LO9kcxZQJDN26hAli62K/P4feZYucv0a+ptXo09yU0k4jO+kCSxMQiQ9dDTpSwBoIMmJFfMdLuw26Hv7SE7B5EVy4jF3V7otUbsrczpXYIQ=;4:5bIVdkefWfSTlkevF2/BSKdFtLeUj5rb59Qzns8ItGTbEtXe6caZQ/tPFjxZU5B1vElg21m+kqw9g5AzMIRtRxUoeIfQEIMIDCDDaxu6k4b6JdkShG5maFG6YexLJ60aJHNV4FIFybrXBHIOoDM79sy90r0Y/7HGo1YItoEYJ6fvAIwy7MALZqccRqD0wqBDacEsaq9vUI6KzWvUf3+8TrBxSval5rHP5VYoloWpN4MZj8sEZYosn4g9TVXOvvBlKQgxwDJyPTTxLncJvEtCTQ==
X-Microsoft-Antispam-PRVS: <SN6PR04MB4766FDA1DEAAEF6C829BC537E55D0@SN6PR04MB4766.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR04MB4766;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4766;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(396003)(366004)(346002)(39830400003)(376002)(189003)(199004)(2906002)(97736004)(6116002)(305945005)(50226002)(47776003)(105586002)(478600001)(106356001)(66066001)(81166006)(3846002)(8676002)(6512007)(81156014)(68736007)(5660300001)(7736002)(53936002)(575784001)(86362001)(956004)(2616005)(476003)(11346002)(446003)(486006)(76176011)(386003)(316002)(48376002)(25786009)(6506007)(186003)(26005)(16526019)(107886003)(50466002)(36756003)(52116002)(1076002)(6486002)(51416003)(6666003)(8936002)(4326008)(16586007)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4766;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR04MB4766;23:ZAw1yIuaeleoK2lqsZNf+ZsesMWV/l+lNKdfQoPS/?=
 =?us-ascii?Q?G2dsZEAYmK6ll/tHBxCw1Gy+K8IINUB7MK+lVIeOgfSNch65sEXG5YOV9ggG?=
 =?us-ascii?Q?hfAiCMU+mDYh4X8mZyU8xNaKDI+uAI3TsLeC+mPIRpFF0h7UxQTLfscOiAPv?=
 =?us-ascii?Q?yE7mS+kBj1d91aewPY7DGxD/hqB2WrTEt9iq9Su8CBxf0WhPD/hNRVe+HHvy?=
 =?us-ascii?Q?qfvnk1gnIHmcnvuF3n39UI7V9iIOXilJTifS2o1pIexHXQwuXFPosS5m3djh?=
 =?us-ascii?Q?R2FK1Jn9wDXGE07T7iDMJGeTR8HlsO290mV5vj/friQ5Nn0lgni1oDZPHQ14?=
 =?us-ascii?Q?j0xGOdUNl5bAb+RAfWWuhA7MudvRGeqo9ffea+JHVdtaH8mrR6iu0VVNAOGu?=
 =?us-ascii?Q?ENCNKFocALmXbOSfP3LfKIIAOicVLodpz82flvPZLtxuSezVDkb8v/9ZUh0o?=
 =?us-ascii?Q?Bu1XRBVoOJsXOBcv6Og6I+tylrN2Cd9k9HgPIds9KVDXspHMZbX0CLkVd9UU?=
 =?us-ascii?Q?JwbuPcDWHp8Bf8tfD5vg0Vy5SVUYdjqn6k42uEQhZfluEO1hiYt5ShW/WBBr?=
 =?us-ascii?Q?m68YHVWVgEjPPTq7fEl0x9l3uiq8P/QkD1YPOPDFgsJfS5okr9U3jo7+hkWh?=
 =?us-ascii?Q?JxiwSLTf6/QZrtfp6G172r7asP29oSAJGc93v24oCDfYETsg0Zpi+J0ATwM+?=
 =?us-ascii?Q?SYi7OYNxIc+wd9cVNFf+WOIZuGybpnu1A4qncIQ0XOX2yy14Ng56gadDWNAi?=
 =?us-ascii?Q?qVLSkm/hU+6VvTu3kFMbBXZQ9pQpfPGmEoEZB/A0FjC++F75Tdr5IjK7skwS?=
 =?us-ascii?Q?G+vWVCpLlAmZJXepWTlKf515NDwdcD8itL/YtwHkZD7HkdJmoECqCFCENK3R?=
 =?us-ascii?Q?IaaxxmWEnfukb0ZeEH0+tg4rnAsWlOH+40MHZrD4Y+m6YgYyxxPG2Spbgg/N?=
 =?us-ascii?Q?jjWo3dmBETQcVWruj2zuSWfXKfBiwNQHhuaT6To2MjUzVbjJcBfDnTQLhKdE?=
 =?us-ascii?Q?KiotbSFjdUvTeyRC2wAfNABPf+T8mti1WAWshUnLYwZl2BbgEyJ6RHzKDaOb?=
 =?us-ascii?Q?Gpq4t4WewHkgsfYOAU49ARJkPfJXxF5cayc2P7PDU/+FzG6jOnob3NAq9Oem?=
 =?us-ascii?Q?drkpJHLATJiCjyxgXg4BncPeLE2XIkHSY50f7SAkTAf3m6moI2Fkxy0/X0A3?=
 =?us-ascii?Q?z9l5oLBnyT8DU38AoFqMNnQ80y4EhupWK2ed7ZMVBsFylLAuhdhmm6v2V5kb?=
 =?us-ascii?Q?j+APo+I1ErASjWJtpA=3D?=
X-Microsoft-Antispam-Message-Info: u7HJbtX7YF7d9pfMXmyTxNjcRc3FuGzFSw8L8PlcdSfx00Mc5od4BSiBp4mLGrC3boDtKyiB5Zl1UEsbW1/07wpvHH95Wc3PfylwLorzc6bBXwZssm988AbgcSA1qgV56tAwVWsKGziKWlNrlItqMwVINFJB+UFHSSBrw4EJ//23+Kkioc3IKpRveXsvX8jWrIq98m2TPLaRwTn/tAcaSAFbt3e27DTGJbEbbpeSDKVCTwwrtUz5XhLZVlvBr9Vmxbh2IjZ8n7kVB3pM687VNLMip0wU7co1TMH7AHITRDoix2b2/y4w+YEYgIW/Z2gb/JBtMFyJBcPFuzbaSGDUqrKLZQVWR0U27+REV9MFgDE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;6:7UGrLuLa5YB2BZJhTrkL49xfdyPzEvNuQ6XeqoYViWr5+BmrvXQdSdaCZc307qD7tfdc+mmXfFBJ1t6WrM4Gr3yM92pWZLT9W2d0kVtRe0Ygr5qSr7ATaQ7wghQ0Dnv1SfnzEmTRVJ0qlZupy4bfOObZqPLPvZP1f0o01/VSmOMZB5mSRgXTjDTPYTts6ey97WrTE662r7onXp9vrxvJ5bduTYyhBrOBTFDwkwW6AQa5FHRmahUdImnMJUFiA8CCdKNDQnP3yoluCHlRiGkKZus3T13XEWjYoSnrPkSsc0uNLG9K8eHdLivZQWf+P7jHzLK3OLznJPzK8iaEYAe+ueujRNWZcyduqSU2LCUD8xhh/MovenOlRplTTt4VI1bEspD1CECZz+ScOpFg0O4BWV9tekNgqGVinECt3LUY601ApHE9jfuItsRC+ppkpI/lZmmYBJFcmJSzo8H/Rdjpxg==;5:TJhL+Bq/IeqkZpX2oyxsQJ8pd0h23iMgbuGur0HxTGIXsoPdhMbke/ZoG69ZbvNYXdig7NOO7qTczHHbf9nmPXP8yQHYiIIizFMq3WXsQA5cWIa4SkO+6JKwRk80u+ZpyeSgeXDMg/aEdVZUeSJFpJOIPzLGQeKJeEMtB+s8Zps=;24:MgypFPEnbr9A0gwb4ROIfKSV+t+WSssDtjkSq7fZJUy/KNaZdIz8jXYYcrqtvl1HqDhHVPU2qSjV2Kp+68W7eRIlSYuSoVhUPgvwdjWlnes=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;7:xFs+U+Xgyl2k07man207Jv3fqX+r7l/bM7XfRA9RYXsP9bOi6PankDCph3tDzrbpmn8p5aSXo+g/ybmqsMVJZYo9jA10sCbkguSYcr5YT9F+VdnNPf6s9vgqtuym7nNGkLqJ4lWTzJXLwjjRUPSbLbFeLpOOo1wzhUG2Vtv7lfSrFdIQrC9RVhNsWnzeyUMEXVIV0f7fkBQQHk0ZgHMQ7EtKa1J1VWaowv0vEqtBVvKL3P4i/e+f+L2jrT6YS9Eq
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 06:28:08.8267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3f3a0e-cdd0-46e3-803c-08d5eae54ee2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export sdhci tuning function symbols which are used by other SD Host
controller driver modules.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V7:
	Export sdhci tuning function symbols

Changes in V1~V6
	N/A
---
 drivers/mmc/host/sdhci.c | 12 ++++++++----
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a7b5602ef6f7..bcea179a8d70 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2103,7 +2103,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
-static void sdhci_start_tuning(struct sdhci_host *host)
+void sdhci_start_tuning(struct sdhci_host *host)
 {
 	u16 ctrl;
 
@@ -2126,14 +2126,16 @@ static void sdhci_start_tuning(struct sdhci_host *host)
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_start_tuning);
 
-static void sdhci_end_tuning(struct sdhci_host *host)
+void sdhci_end_tuning(struct sdhci_host *host)
 {
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_end_tuning);
 
-static void sdhci_reset_tuning(struct sdhci_host *host)
+void sdhci_reset_tuning(struct sdhci_host *host)
 {
 	u16 ctrl;
 
@@ -2142,6 +2144,7 @@ static void sdhci_reset_tuning(struct sdhci_host *host)
 	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 }
+EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
 
 static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 {
@@ -2162,7 +2165,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
  * interrupt setup is different to other commands and there is no timeout
  * interrupt so special handling is needed.
  */
-static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
+void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_command cmd = {};
@@ -2212,6 +2215,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 			   msecs_to_jiffies(50));
 
 }
+EXPORT_SYMBOL_GPL(sdhci_send_tuning);
 
 static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f887da6..f0bd36ce3817 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -748,4 +748,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 
 void sdhci_dumpregs(struct sdhci_host *host);
 
+void sdhci_start_tuning(struct sdhci_host *host);
+void sdhci_end_tuning(struct sdhci_host *host);
+void sdhci_reset_tuning(struct sdhci_host *host);
+void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+
 #endif /* __SDHCI_HW_H */
-- 
2.17.1

