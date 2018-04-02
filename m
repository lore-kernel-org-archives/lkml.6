Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeDBKkZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:40:25 -0400
Received: from mail-by2nam03on0044.outbound.protection.outlook.com ([104.47.42.44]:36445
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754364AbeDBKj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:39:28 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radheys@xilinx.com>, <lars@metafoo.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 3/6] dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
Date: Mon, 2 Apr 2018 16:09:03 +0530
Message-ID: <1522665546-10035-4-git-send-email-radheys@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(4326008)(42186006)(50226002)(6266002)(51416003)(106466001)(50466002)(8936002)(8676002)(5660300001)(316002)(81166006)(81156014)(76176011)(36386004)(26005)(47776003)(103686004)(90966002)(186003)(2616005)(486005)(336012)(106002)(476003)(2906002)(486005)(36756003)(126002)(305945005)(551934003)(6666003)(446003)(426003)(52956003)(2201001)(110136005)(16586007)(48376002)(63266004)(478600001)(54906003)(11346002)(356003)(107986001)(217873001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2261;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:CZzG/X5lqkl3dFewo1NUQtBjZS+ubW47Dj4L3X8EBzq9/vG32m7r0BTdjT6uFE1NxISY7+toTKAyTWv3TMs8eC4KOMV1+2X7aH2lg3s69BqWLKvrLALsIb0z3lPjVOVV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21fcbc30-bcbf-4e03-f3a5-08d598860108
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2261;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;3:c2xNRtrF5NRPQK0kluGuSycoDXgLwArNEGl9UQSfz4bQJ8FuaZU5R2CMGdbZ8N+lwqKxdJdAqKAtqtu52jD6kUtxeIGxviBduJZMLvTZLDCFRdxQAva7gARGuBxmcaniDyQi1zgW5RixzIFEEQc7z4kxnOqGxY38nlqrXjjcxBPDxqSKa4C7gZdUe5dQvOpDiPsIF1l1/SV7q9ssgQ6z2oqPNO9GXivDA2ywsxfcn2+v2Ajli8P49G6YfUb3w+N9eYBkOtMPDLtQnRmMnPKB6VjTSwCVg6Rurqb75m5o9/mlMCVKrXqUhcBdIuYjWa9rLQ9fN3Dd/H6Yw0/N/ksUGIjgNfA+M4kIbIeHfMu3q/Q=;25:jClTidYrsIcZvwwZPBYiyJSwt3gwsoMbJT6w15V6vULhJTI5Ctii9Lj2/sFIkHj7bCpYi3yKAZQbhFXQd7ASiFQxdSZS0DB8WzNRPLvkwrDyb5cq/atV9owE/2/boplrouluIGfCIqBkdQ2+ebazVy4V/ov4J1p90Vksu5a9p8pFLS5VfnPCCnaxgO2srmP0MfxdAF1y6RNLtyGZnGTtvbJBKmdL59TEPYqv2mIUwpk50sDPUaz8piV2nLRBDf3VK0S6NI9EW82odGdQpSmvN7AvHLvjvu82VOCNIMlom2vOwF+k9igy2r81Y4/3ZOApc97jovO3vIuiIKLQ82t/FQ==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2261:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;31:k6QQmyGp5gaK/Wyb9yGVyUromptyRqGlhfvh/20ZaK0TwtFIdhgFpWm8G5rYV7v/la1nBg1vg2DxPRzqxe9PaNd2EWvTs850XBFwnc7qI7a+8f1CbgDQ0J/5Gi024x1NOZaWkt/AAdyTD6BIzEdn62YTOJtIP6u9Wn/QzmkuVUDLwfnJEcjEzqHM83eYGQfyZNzQ9F+xzgJ7nLzkIlaAIOMHZJS0lbdMSzsURhAeK7c=;20:pupbbHNDM1xUF7Nm0VorJHNcFN32FxhzoCZ3yLMBH/0cUHqqFCvUFf8xXlbEvvKSZX5nWo6EAfZd5lXnkAbAGE/TySbSJqPm0F/6RguZRhHCOiAZfesf1OM60bDO2i4wafJ9HGKRAMWlX+bYfTGII+D64pgGCC10UpTYiYabfISGozghym3KhG6JM9GOQdKzeIKzSjZSKhcTrBjkbjL/NboInuWvNpZ+3fmk8xTt5EZiKO4nMaANGNgYd7ojRv1qMXBVxnoLLIYVL7leFrKpdR626kW9Ffv411Q2+hN5//I8c1HvsrdbrvpRGrWzpwuGWwnj+uzPxHyjHECLphKTuAd/7kPkd/rc/qdJg0/V90MkjKCXgZVW5xCYseeWax3BlrSapplSJDhTFyTIPrXveogEOrsBuy85muqWiibKpiRpdfhP4FDC2sZOVMbZqxWsKyJOqdmJC7QF09Vd9HtUf1tVZJl4uydH/PTDnrrEIMExlQofTA0Hc98YM7gw42Rm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB22613C01BC78A57F711E2F1AC7A60@CY4PR02MB2261.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR02MB2261;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2261;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;4:iNdg6xAjGwZ62o1tt3zoxBG1z+gnnf3NEJJMtJ5oVSrFFn8oWSxODPABksr0NEXKnRi9Zt8vYvZmB0r3Z32Q0isJrPdSpA73b2vX0gpdFixJKaw2Bu8ottxD7Q4ymqT2NDm++YIA4Fh8W8xo8XUDOuTEsdKsd3cL9FZ774R0rmFbepw1SMQAWRdHGh2MNs4K4sfFaCj6mYZ7sRKPCfGRElJX3PkZLvyLMHVY+XjmsoUAVVBfg7oALpHqydnZxhRP5ySG+AvdiX43hlWOd9ljnyo7ngvv42RxUtqaWe4q4uNapk8r34bUl+HaQunW7Ze6
X-Forefront-PRVS: 0630013541
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2261;23:ZvwRLcwFnUVvla5tV34uajCXFfcP8vlCRFyNXmSA0?=
 =?us-ascii?Q?wSvQeoK2ugiZacRLNpdAev0G+AIJdqeq3K7Ty2qUbHy8d6wA9N4m323t98bv?=
 =?us-ascii?Q?Gcc0bGzYJFQwNmHF7I4+2nEW8CgkZVGlyo1IANyZnkHZngtxA9Xiyx8WuB1O?=
 =?us-ascii?Q?B2v6IDNF6d5kHKlYDcew7gbgkTkKgGPmQLvfITJoQue70nRnB3xko/o/A2Tz?=
 =?us-ascii?Q?rI7TCJJN6oq6wtSPZYIyazwgX3r6cc6MHRpKgO6IzDH7VCgpKcI8PcHWdWaa?=
 =?us-ascii?Q?IBtlFDHIUuUgDR/Plf097ScdhGXkuh3HVIxAksOeaFz6qaO4A23ZK7eam2ua?=
 =?us-ascii?Q?SY8VHBJCTI/3fxxVvTL5Sbmmwox8vel2nJKfFRhY3rXayHP0Hc5HVYDE1KxD?=
 =?us-ascii?Q?UTWG76g20rMuStkwL475UwmlnhAECTvv7tBjf9CJydmk2Nx4tWufRQqWRjGe?=
 =?us-ascii?Q?+GExNvJTjRK0+cMvBxERz8cunyueQj3y7Ci5A5R6iKCd7hD0yVUPb/5kCdwQ?=
 =?us-ascii?Q?zF8l+TU5ybuKf8A0LAf9wSmVX6pcbGCUNj25ZBcCvmpvJT3vr6v1SsandpBp?=
 =?us-ascii?Q?qbbhWfrGuoot0vbwa/YtDLsn2qp3cAJvmdhah6nkoSe29M/kc+cmcmvdfyun?=
 =?us-ascii?Q?4kog29ZulA+ymp2EgrHWeJpOSYWpJJN5t2y+GONQmmo4fCGgYO2vfs0D2Dvv?=
 =?us-ascii?Q?mOswFUzbbU2ipuMQQluU4dWS2rNIcUokhW6RPG9Y+ePE+zlsgCoz0Fs87LXr?=
 =?us-ascii?Q?JVLuK0LxnofkEqDm8UbxdaNLM6YeW9pCzdYTEfS4HHatiX3CDdJ4RPUDb6pW?=
 =?us-ascii?Q?w3W6iek9Gtb3/F3Mr+ooyOcJtcszBbq3A5O52/uHufrXBqqeeRqHiLSgYuYr?=
 =?us-ascii?Q?knwOfX8eJCxRVCzZNcMhf/CNcUaYlUhtDMgf1h/dHSX9F70vpnyFxmgsmgnl?=
 =?us-ascii?Q?A7PPB+hi8BknDhT1xNJYsyMeyp5JddMPyzBPfzR/xsJ+2C9SNFQPiiAdhveK?=
 =?us-ascii?Q?rY+SvgUD7jlDDdDCAGomsgSnudiyJ8ETrsV3/zedDF90ja6cK7Hqr1nMAyUV?=
 =?us-ascii?Q?flXMId3/Ghxq+mn+etVSbFzstqqDWVQ9DLuHlPIn6ulmbPA1mvHUjidiVQKq?=
 =?us-ascii?Q?e50K8czCeDM3RMrhfO6ioUSEhb6SwNBAu16Z+6Sod7frmTqf2N7S16WCyu/5?=
 =?us-ascii?Q?5HUHim++AZ1fMRF3S+AgiL2/r21V9LOqzm+OUbedc0WbD14UDhYk0m5rgo4Z?=
 =?us-ascii?Q?+YhPRYaAp4TXl0/wA0=3D?=
X-Microsoft-Antispam-Message-Info: MhObSt+G+3emhKY3y467LHUnMRlo3f2MLhghJvHIUzS3uC6OR1s1Mr3lmhoa4/I0yDh9Hnr3kZnvliidrBonOUP9RwPJEecVB/qkMutR0a501SLNsavFuK0tDGOcijTq1l2osnDkGhapGQUEoplmaMg+pKZv8AHiYuc0AGLCrZz5M9wWJZ5Vlrdt4c2P1Qne
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;6:MypMXg4Wc/VaUfYteGJnd+xdkg7PFopUzg5zZKiHCU3QeuOz5E1Wzcb6u2oZKOsYco5SufUDu2RggdNsMj3nrqgnyIF6SSaAsQdifXFmM4sernxwuC85Js6JN5HeOOYquXbX1wHKDRUNTeoFRdMQHeKkM9VplaldYLaYY+4vxdtRhO4CfEJFwbXKunTj0+dJur3tJCLFOiFeCLPlcRuyc45NR/4v4tbPb3MB1Co+2RNdJzRWuVkkHao2VnCF6aMjAqj4gm5oNr0j6D6OJPJB1oN7sWX9nqgfCedFz2Af22NzKdWMjXJzkT+tXpwpLq9Wvx4Q245UHVKuuiTtdeqGMdXhZA4H3l/k3zGRJsXtV5rUUjqmAgsXy8eZemDHROLhE74yikmYKIVrup/8Y2UVkELMEAkns5NnoF0uvMvF2cScSi1b4YEyLDsS6JsK+1cWs+9Djsdch+ctiCE7sN/PxA==;5:IGOYekI6yNa87MFnWe46kkaNcOa0F5TlZLNuUMlGluACpX9siQnKoTV2SC9f96SAQwY1fGFZckVxP2jErP1eIN9Qrz3u3SnuWDCUMXCAFaehjiEjf6imG8GFH0sx4D5pkwNmbDeI6da6bHM7gu2KUdvFqciz14lzBUmy+tOZ/Fk=;24:lSR0OPl+OPD0uOxDlv5gwmqwcAfcYC/3z6hY+GMaIf0r3gBm/sZoBjqN2DOsV072mZoRivQ5f4SWayNDuno651XvbiP2TvYLv6kV4o2QD3c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;7:M7gdBc+P4twGKKgErqj+V8UScjgUt2fF7LB8Oxt3EqGfYdjUUoix3DOVqSbRbc9nyZMsjGr7yFAUwSv86FZYTBEdHpM93mwx5z0FB8AAx3hHIB9ohIZEFPFTonrq7YJdFbuILgtwZ5IIT6XNdTUwybxGfmTen8MvysTU9shfNtGTDs9q7l59jcz2VIBZ/ySd+KLKl1zVISiWAxfBjXUi00+R0Vn1MS/CB7RoFkOpyR0Ag/DprUcVWaN5SxPz5hjk
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 10:39:24.9446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fcbc30-bcbf-4e03-f3a5-08d598860108
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2261
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase AXI DMA transaction segments count to ensure that even in
high load we always get a free segment in prepare descriptor for a
DMA_SLAVE transaction.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 16fee30..36e1ab9 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -165,7 +165,7 @@
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
 #define XILINX_DMA_COALESCE_MAX		255
-#define XILINX_DMA_NUM_DESCS		255
+#define XILINX_DMA_NUM_DESCS		512
 #define XILINX_DMA_NUM_APP_WORDS	5
 
 /* Multi-Channel DMA Descriptor offsets*/
-- 
1.7.1
