Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeDXSNR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:13:17 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:51605
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751216AbeDXSNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:13:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 2/5] drm/arm/malidp: Split malidp interrupt initialization functions.
Date: Tue, 24 Apr 2018 19:12:44 +0100
Message-Id: <1524593567-5559-3-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
References: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR07CA0189.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::13) To VI1PR08MB3037.eurprd08.prod.outlook.com
 (2603:10a6:803:45::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3037;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;3:6HeXIMtm8kZODn/SljyGtjLjj9I4VFaBOS1MdONTr15qKAabsrYIDFAow40nA9dzDWVu7IztlLyd5kXydjvccFp2h3HkBNQgyQXGVN5mETBUCTw/0Tf1u3UXZ6HEulri49eEoW6zgGtgaipeUxYu5hTQ/qLc9c3CDLzmPREUMjIw7/L/GGEHPJGXZq3xfYfN+VUM/8if+lwsBGnJmyvN0SPIyHWFXKp2ZML6REWD1FNr6e+e+GzwBx3oKQv8X0Mk;25:CSpzgxVei3rlJiVtdImTm2qnLxoQfBbsYqJwBKyl8LLCs3gn96jfargMss70WRHbVgxVpgU/BvHIDcc4ACmrsuz80Hei0Aom/nVoQQaS2TbdpvaAYyI7MZE76YrnBodjpW5bTHznMnzHVD22QYeUocxbwgHRpQib4LrgEN/TxK4wrdHmLn7IBnai2oMcwt0JDED3I0c6trSvMEVe84VE467l8kdHHajR+djG3rK3/BUfN5SNu814QoNG4FLgcEjoZPj/M/zA1sfStIlKWouLQfcb5Xh2r5X/4qXbujSeS2E+y9AjredWi44nVU931dFHlWrttzycVWn1PV65Dmqbjg==;31:qq+VbUYZSBUUAlL9gU8buZEmFmposTTpGqypg/RR5VXAG5a/grZlmKFVOjl65+WG4LaCa3M5rdWcwbobqGv6eRCSbHjk5dXsCanDGw3ML2MAQoX8AATggPTydHeCg2eORZk2t4tAADySY83gLRFh6koe0e2m8xjarKuxo7z8m9ZRxzEeAVeV1ID+M47ijgosAM3eCF+ZcmbpAi8c8GdYtTBTMaU29C0qp+0fRDRN/fA=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3037:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;20:tvd9Ej6nKnkUy2ng4pAmTPR/ynv9UQl7guGPublkGu25Ec0MmZJaR/6nE5bG9PkYZ2UL0N2pI9/ItSrRMwi5vZPw2zrg4S2nBq2W8YvACWyaXBbR82I9onXYQqNI2s9zOrno6OcLXU7FPABuzle0I1sFs4HoOdxxbzdzSLDGZLDcIAt/inQPBc5pc3/v+bKVi19Wk83sD+Cta5EC/8yrBSPRSQgA/OWPMZm70ggAxgy+v9cm9C1uoICkPaRsVgOy;4:VVyJO2Qn+WR0wS3fd75hjNh5arKHMLrr50rQi3bI1CKEyWpXKEGtMc/mS31CkCwuBX3gpITRZ0F6t+5oJSAkT+k/tY2wA/ikH4/OAoY+9zr/+M/oN3gVXjSJAA5BLTldkTH9SReZyaRD4luO+SX9/jbsq1/r+fmzRQmY4MRQwUzD4Q/dkOxDOJTo7Sk6R7d+gf8FgAQWzjpBwzwNiKkfY5bW3FmFV8GG/II1vQo6qsZwMztK4kUpmmvimhpofSfusR8Aj4ZE2bDvLIFizuN+Wq36GdGWsYj7mJ8ZNFkCrU5WZf0+FFe6cIxgoh7I6nlf
X-Microsoft-Antispam-PRVS: <VI1PR08MB3037A493E7ABA619AD3D7CEAE4880@VI1PR08MB3037.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3037;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3037;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(189003)(199004)(316002)(6666003)(51416003)(6116002)(53936002)(3846002)(97736004)(6486002)(486006)(66066001)(2906002)(76176011)(36756003)(25786009)(86362001)(72206003)(478600001)(105586002)(8936002)(26005)(8676002)(966005)(956004)(476003)(47776003)(48376002)(7736002)(305945005)(81156014)(7696005)(68736007)(81166006)(386003)(52116002)(106356001)(6306002)(50226002)(446003)(16586007)(50466002)(16526019)(4326008)(11346002)(2616005)(59450400001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3037;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3037;23:aDRk9jQy2Fo6oGkb2mVujfEiGyI3OKKlpz2G/5rGA?=
 =?us-ascii?Q?x93OSW78hzQ+M/F+VNiyOtOPDozOhSGFVbc8sQlzLxKt0s0mgGmTaJmvk6/2?=
 =?us-ascii?Q?wAGCaeIROxt2H5sbJIW8jWLZGmxWxN9AlEWhY1eCUXfelWDDswKcyy1mBwRU?=
 =?us-ascii?Q?KLOrmyQUehPIT05yEsroc4BPF5gbDWleAOFDNRT9XnbQLM1kRe2iSIcJOgWg?=
 =?us-ascii?Q?Zh0xB5wukaTUoeq0lVh8KA8iYEdAMI+uCgp0Ozt5qgp6DY/q9/EaBV6gcZtF?=
 =?us-ascii?Q?48fqW/jY4IgrVI52MWQgohWPmI1LmwXpu4zeXYACc8U7X5ncifR0OA/7hXJy?=
 =?us-ascii?Q?IM085rXxED93NTj6ptZfryDkiSGtSENj+yw+d8SO2tNvtWIC3dyGy8Whe34h?=
 =?us-ascii?Q?vdbE/rkmgPf9AasbHPLAJxaAcZk9x4qAdnbmlOpTjng3JPzqbWPEP+1SJx/a?=
 =?us-ascii?Q?OhVmFsphtpsh93kzHlTUkoIziMSnx+ADp/MMxVuic4V1aA1jeVVBp7R57VMO?=
 =?us-ascii?Q?nMMuh2rssRpFpF2kfIh+aYkhYm4+8CFvseqRVZ8PhUWgDVdb2rARI0btq8K9?=
 =?us-ascii?Q?lgE9W001tN/ZlKMYwW1Wtt7G2KVxg0RpdnUONlV53oEUphmjzbVIje1S2Wl/?=
 =?us-ascii?Q?KnYcRItfSbwNpEHf2pvmlEDmwrGDNIfl9Ml8fWyft5Zf10QkQbh1fh6i9G9+?=
 =?us-ascii?Q?dEDlZLqBJu7i7OgThMN7m7uIZf2tcIA2bTyzANPy5eN/lbScCabX7pXhtafU?=
 =?us-ascii?Q?sQnpD2fYpjPi9IYefp0Ac8oAQzoqIB/xs1KbiIrqUUp36rSIZSalXM6lfFbH?=
 =?us-ascii?Q?DxY4dYSIFOHwLcc2ICSZlJyz90JR4evbPqr4SlEU0ix92dzjFU7bnLZ17CF+?=
 =?us-ascii?Q?Jaf5LhS1Qu333wjKAVN+pAXTJGp3Fn9w5vJyhCsph8hU52HwTQN2M1GuOxDQ?=
 =?us-ascii?Q?1PKi9+uyLmKJR5hZdGXnfc8JZL2WtZF6siJDK5bDhcxiIkBOy2RKjVCqIYqI?=
 =?us-ascii?Q?HxEXa2+2kT90/QxaXvfcb0jWPGGMepBG78fWaA3Jg8u4uEKIMGTQnpqjQhdM?=
 =?us-ascii?Q?1RhtTgVzs3LF4lW0qXytrueU+zTdgRH7jf8KiWhXTuTC1OknR/Obylp47O8W?=
 =?us-ascii?Q?nqgKhZxzymGCNOA3MKU3LDiBhuxuvT0WFKn4+mu1mtts96x2dKg72EHCbr6t?=
 =?us-ascii?Q?2o1kgylu9Z9ScS9hElI5twv5LLVlYYwKJh+?=
X-Microsoft-Antispam-Message-Info: JBoxVcrHo3N+UjNaCz5hIWDJJUz/Kpw7dik/P0NcqSlHRMQyJGgGgWaGNZ+8nJzGq1t9eLVMt+XIDosTeDTEJuReZSZNHbOfOBRN7vM1B4aBSAnQmW+ijKPbPl5C+vLYT32jW9bfR8SIGy6Shqyj4ZDDQcrsIZBtaJaPqX6vutHO/8hG5EBO3sMm8A+VJVjz
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;6:4oc39JlgLiBaFFCQA+IFmQZQU5wYIKdn8SZaVpyjXzP9BMdCqAODqLRurFFmFUcAUlapAH0BXbFxIwWrhmpQWjRsHJtOPjXih7X1out7302pPSKH/qB/WneG0duTdq88C4XvQIsU2Clo9mm9InUwkmEutk/OfV6SGxoMcQt+iatMc5nJHg4WQxtO7reBcQEMeB+dEUzPHzMUO6/1wBZtVm46v8mWTVgZEr2sv4RDcU1e3jm4mlb7G9AlovYE7qkgmQK7+jXB+Bsr68PYeyk6YH/2WTXeaRGIWOtZQVCAusM8Z2OC013w8/uXPDW259XNF4QrjAV5R/ckDfYGWooYjIPVZPOeMlmp+YJJ1o1NxXAfWcYnSTw07cRwou7Do7+EUEv3BzaswJ+kd/As29CToK29Agdnruxc5s4j07A02x4iAb+/ZCe5FhKxXFf5sZidC3MqMmddH61+XtN3sEYdkg==;5:19AxctY9kOriTN0E8bnuFkfOS/YBJ3cemyArjJU+ON1DA9ZJ60Djm0Jgb2LIjglO2TrcrDWwOINLVrJI/bat7UETuR3qXCRADj3+uVW/MPJe6VCH98LqnrrQKVysArXLYHXefi0WdutRDY2tHPJbRQnFbzgFyxfT1jDbnqF2e2I=;24:0yizdVNyuAj3/2CZfCgSp4al0X55AsLwQ7FtT15GRjLVprDDo7QeGfNRUXdiZRGYq3A88jaSQEVk3anXKS0y5ADfY9rG98J7/1K900HQ4yU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;7:ZgDFGN1Og6kNLWU8FkbALG+vN5ROoo5uTvSRlEChuTr9usd5GfDD4JjRsTj4oMr6FKAWYOgPaU1ct8RuKCn70YyA3Z0ZRY7BQdSgLIJtvd1biEzJLCr3LJllEN5OmpluJBzUuY+Rg+1acNZOGWevsKeaZWZ9VIXQFCRn2DuU8pM7OI4lyxNCu5UQR9UgqKO5qJ4JZqcLctESZMWq5iWvFCUqfFQBrO5wxbbp1KoE5crZ4GsDFtep4cp+26/WO5aZ
X-MS-Office365-Filtering-Correlation-Id: 3e11971f-e418-4db3-4eb2-08d5aa0f0836
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 18:13:07.8363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e11971f-e418-4db3-4eb2-08d5aa0f0836
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Malidp uses two interrupts ie 1. se_irq - used for memory writeback. 
 and 2. de_irq - used for display output.
Extract the hardware initialization part from malidp interrupt registration
ie (malidp_de_irq_init()/ malidp_se_irq_init()) into a separate function 
(ie malidp_de_irq_hw_init()/malidp_se_irq_hw_init())
which will be later invoked from runtime_pm_resume function when it needs
to re-enable the interrupts.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v3:-
- Squashed https://patchwork.kernel.org/patch/10357203/ and 
https://patchwork.kernel.org/patch/10357209/ into a single commit.
The reason being that although the two functions belong to different units
of malidp (ie scaling engine and display engine), the intent for splitting 
these functions remain the same.

Changes in v2:-
- Removed the change id
---
 drivers/gpu/drm/arm/malidp_hw.c | 38 +++++++++++++++++++++++++++++---------
 drivers/gpu/drm/arm/malidp_hw.h |  2 ++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 8fb02f3..3f53f7e8 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -869,6 +869,23 @@ static irqreturn_t malidp_de_irq_thread_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+void malidp_de_irq_hw_init(struct malidp_hw_device *hwdev)
+{
+	/* ensure interrupts are disabled */
+	malidp_hw_disable_irq(hwdev, MALIDP_DE_BLOCK, 0xffffffff);
+	malidp_hw_clear_irq(hwdev, MALIDP_DE_BLOCK, 0xffffffff);
+	malidp_hw_disable_irq(hwdev, MALIDP_DC_BLOCK, 0xffffffff);
+	malidp_hw_clear_irq(hwdev, MALIDP_DC_BLOCK, 0xffffffff);
+
+	/* first enable the DC block IRQs */
+	malidp_hw_enable_irq(hwdev, MALIDP_DC_BLOCK,
+			     hwdev->hw->map.dc_irq_map.irq_mask);
+
+	/* now enable the DE block IRQs */
+	malidp_hw_enable_irq(hwdev, MALIDP_DE_BLOCK,
+			     hwdev->hw->map.de_irq_map.irq_mask);
+}
+
 int malidp_de_irq_init(struct drm_device *drm, int irq)
 {
 	struct malidp_drm *malidp = drm->dev_private;
@@ -889,13 +906,7 @@ int malidp_de_irq_init(struct drm_device *drm, int irq)
 		return ret;
 	}
 
-	/* first enable the DC block IRQs */
-	malidp_hw_enable_irq(hwdev, MALIDP_DC_BLOCK,
-			     hwdev->hw->map.dc_irq_map.irq_mask);
-
-	/* now enable the DE block IRQs */
-	malidp_hw_enable_irq(hwdev, MALIDP_DE_BLOCK,
-			     hwdev->hw->map.de_irq_map.irq_mask);
+	malidp_de_irq_hw_init(hwdev);
 
 	return 0;
 }
@@ -941,6 +952,16 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+void malidp_se_irq_hw_init(struct malidp_hw_device *hwdev)
+{
+	/* ensure interrupts are disabled */
+	malidp_hw_disable_irq(hwdev, MALIDP_SE_BLOCK, 0xffffffff);
+	malidp_hw_clear_irq(hwdev, MALIDP_SE_BLOCK, 0xffffffff);
+
+	malidp_hw_enable_irq(hwdev, MALIDP_SE_BLOCK,
+			     hwdev->hw->map.se_irq_map.irq_mask);
+}
+
 static irqreturn_t malidp_se_irq_thread_handler(int irq, void *arg)
 {
 	return IRQ_HANDLED;
@@ -964,8 +985,7 @@ int malidp_se_irq_init(struct drm_device *drm, int irq)
 		return ret;
 	}
 
-	malidp_hw_enable_irq(hwdev, MALIDP_SE_BLOCK,
-			     hwdev->hw->map.se_irq_map.irq_mask);
+	malidp_se_irq_hw_init(hwdev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 6607aba..864fe92 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -297,6 +297,8 @@ static inline void malidp_hw_enable_irq(struct malidp_hw_device *hwdev,
 }
 
 int malidp_de_irq_init(struct drm_device *drm, int irq);
+void malidp_se_irq_hw_init(struct malidp_hw_device *hwdev);
+void malidp_de_irq_hw_init(struct malidp_hw_device *hwdev);
 void malidp_de_irq_fini(struct malidp_hw_device *hwdev);
 int malidp_se_irq_init(struct drm_device *drm, int irq);
 void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
-- 
2.7.4
