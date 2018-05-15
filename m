Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbeEOQEq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:04:46 -0400
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:19657
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752453AbeEOQEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:04:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 2/5] drm/arm/malidp: Split malidp interrupt initialization functions.
Date: Tue, 15 May 2018 17:04:16 +0100
Message-Id: <1526400259-7573-3-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
References: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LNXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::35) To AM6PR08MB3029.eurprd08.prod.outlook.com
 (2603:10a6:209:45::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3029;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;3:sPOczSgjnww77LSd/2Yb0eBvu4CNUUHI5kwlqBGhoqVtPG7Y7GwWODmU9S+b8d7TWE+NFB79U6nWV55++1YL9TCKr3uNQZ0/mnbs7jSXxx42I1Den3wWVD+pSJ7zSOmTL4Gu6z5gCHpWeoGwiPSUHL9ilksUDjRPHnMIu89TswBa1G44GM4v2otdrYK9N+wJifqxVQ/XfXQfZ4vtzXrPVUEMgx4DIedn3szIlfCTWJK9h7bruwggub2jQ2yZ4uN6;25:ZyPej3mVJiPLqKWGGaHuX4dsoxGkeVL1N9oz1FGC2s5xwzuC7YdiB1ntO0eQF01QqfBGOwASSXaJ2nwKCId1U17yGDjEbHakV+i7kSMH5ShcrsXzgx2BZHrFKnhbXgmu2eY2ACqBC1On0FNW7OLBZ3YpXvti1B1S2GKOmZ0MZkJJPMYScMbRA5et5YhRxH/+piQUK/vCWiGCQRcAl1W7vxLbVaugwa+y6MoeQgopwft+xyUTp0nuQ1UYby4DWWGTIfCNc92qFB169+HvQYiXAz9KTxtwp95fUiRGi6p/Qs1I0sfsNL0UniytDupkNJOXJLmrDLL/Mu8uVAZKXbsvFg==;31:JrZTgclsa9x2sKvJcc8ZZwxc3ZROxyjZyPnY5TV9DXn4TaZcZIrKaZp/XhbUcOZs9KQZv8X5yYUbNL7bugJqOor72Hp/4bSMtDvCdRvuE8PnyJCSFFu4r1Ck28IVMsBEyjRmSKx26WhDmVvT+SpZS2imqcgrOZRYvuRQ0wij5z2iqNMKdzv9Cpc3hPS+0wqcrYmWXtGyPU4vZFGZmP2V2tfFO0pPddFgak/pj9WFuJY=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3029:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;20:YvElccyGDdsB0l7XaWfD0Kmwr1xRC2VOtwrC9cuRpgvsMu0+WQ1gmS7wL/RpNL9LLRxUD6z1+SfUZ6anola2EqpBbJkf0wBJGxHUX+7lnVeb+1VVKG6mfnUnhUpSOulCkIl9HE9qNHhsnQa8+JO/41pQBsMG8/jYYdxMlArCaJT3Kxvmb1u/WwHE439pkfdJBXOf1u595e08pvzsE859PAcpMkD66wzWZo2Wrplg+UuaxvVINvifCJwFoZAUo/RQ;4:DsGQy2tB0SsZsSiZR9BfzGQ3pWCjgDoxA/G2BG9J75UMnWaSVIL3YRot0qqMJAXDCj33B5b2D2/u+1MYkhfZCfCPWgdeVVdCxyZtVMqG22iio4/e+tF8T008R77q1gjBOx88ozwK+L0BqQT5puM2xr2iSIbbbUoYA8BiaHZhfGMrqaRXQ6oIfZ5ixzdnkyGMTYX2LVzGOi/GiW/KmsZPvDl46Ymp2O21Ezf+19sWeF0yYBWSU0P2W7ovRydHq6QDy7nkQ6yzcdhJvukO+Y7pggHfGaEQjglCPlOkp/y43pDrvzR0z+kGbA9uudBrLg+d
X-Microsoft-Antispam-PRVS: <AM6PR08MB3029C6234E6B1C76CE0B2C8EE4930@AM6PR08MB3029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3029;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3029;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(3846002)(16526019)(68736007)(53936002)(5660300001)(6306002)(8936002)(2906002)(50226002)(59450400001)(86362001)(76176011)(52116002)(26005)(7696005)(51416003)(6116002)(386003)(446003)(2616005)(316002)(476003)(16586007)(81156014)(106356001)(105586002)(97736004)(81166006)(6666003)(11346002)(956004)(486006)(478600001)(966005)(50466002)(6486002)(305945005)(48376002)(4326008)(7736002)(25786009)(47776003)(66066001)(36756003)(72206003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3029;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3029;23:PAf4Oy6Q/8h+28bvBUxwLkQtZnsNm9u1iTL+yYHu3?=
 =?us-ascii?Q?lFINHnSweFj35CXFdWBpn2bus0qkl3VOFoureF4C1/lPjqrrAwbgsyJChdtw?=
 =?us-ascii?Q?hvLNcL22bYOE7VU8smk6mKCL35sTpujvG/Hh4mPT2QXwWbaAHe9is6GZ1N6l?=
 =?us-ascii?Q?v0OcvKuJfo8/4uo84IwjVbYRZm+QshRA19DSvSKCTncC8WuqQAX6QEOfYJ1s?=
 =?us-ascii?Q?Q4M0q8SAysBeZ73QrkK2CD4RgqqKuGg1UwRQtLpapGiXAwk+FBxw7RPrkiio?=
 =?us-ascii?Q?tl4VzLkyp9Ki+To2Z+MANh6IzsyPVxbPXcCFNkN28C7Nv9A0hWK8tqfoM3lT?=
 =?us-ascii?Q?y43IrXuofIpA25WJkO7byusBhOUKcz8BZk0LLf62HMip8SvjvM3FRb4B1/m1?=
 =?us-ascii?Q?qQEmN51Aa9kCyNKZh16N6OqmgcnxJukkKGQG8GmeXv+mUMHkTEMRnaD+EWVv?=
 =?us-ascii?Q?oR0M605Tt7j2Y4AazGnIR41Z73v/9OXyc7YdtXzu2fnacYpXTwa2nQ3OeElz?=
 =?us-ascii?Q?F04wPA7QdzN2MM8k4miVOJ9CtJMWPQjbJXRAAyDUeow7ujEs1//PJEoXVry/?=
 =?us-ascii?Q?pHsAvjPqIgn8+fdznxQfoFZZhI2C7LJzETAeGQvWF1S8LPsxVCPFSZKI7xim?=
 =?us-ascii?Q?K3IJ9MYAZJinwH9HOxg9nYjoc5DzXcxFIftGnN8uITra8rJedfJGTqnmtVBU?=
 =?us-ascii?Q?HmyzIb1euV8Gy7vj6frf9BaaXSREjOTaiubkwc2zBwX097ysTRcS35eA0MIU?=
 =?us-ascii?Q?NEPNj38Sr/bPyZLuGj3LI8Rxin3l9/i85RunHshOtZ2nWzXfYdbSQUjevt0z?=
 =?us-ascii?Q?4YlhMOXn+MMBE7dOmg9Q5Mo+mGP9mwYFYbQCbNPgLMtn60ccPNa4qQPI7Liq?=
 =?us-ascii?Q?c8e0Z5hp6VUSLFzw6zIcxQVHLoQYeijCg+Bl1TUVt6L21IXJCr4O1m/kZ106?=
 =?us-ascii?Q?oIvMNCMrCu4Co2g0bYdcOvI7PjFXudEQm++UqoosLNM4/6tNvy2MBjyLzLJS?=
 =?us-ascii?Q?60S2u1gKACRsxSCd0sn4/Q5ktf3tEK3WKQ5qdxg5a8hJ1RZ/0f1aeKcESD3Q?=
 =?us-ascii?Q?MoQdss4zQu/aUSbzPApMStT7dneo9ewfOqXGm5pgVh5Vvmf9t1yl1ICpYrTO?=
 =?us-ascii?Q?/fWYm33CnqmkxT/80R7m2i8qpRLjSlIpJS8ZpEdWPO96FR7rUdm61FtmpR/r?=
 =?us-ascii?Q?luMGUJVZCe6y71FmzzJIa1YivJxBkw7D1UQ?=
X-Microsoft-Antispam-Message-Info: K0jhFpXY51tg51e17fqVd8xOpfK0x8SNiSAsXS6vywbdBnn7nODXtlUCDZmQvzui3EOFJMC+P3r+BWKwr/DGC7Bfz/crMFOlxKgFLqsJZEjbjRRx2eUqYkI1T44H97VfunbGitrkER+ktYupj5lt7hQzpgj+8QPjpd7ZgW9lAs4f/Wz2+Xs8UtUDh3DbURnS
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;6:YO0gOgisKcqNuzpc0XgisxmrQFSW8sUGuXi34LXLIhWR5bE33rVWcskxYwSHfjnL7tWE4VqCgJd76UMjH0kBfFeyDJKwS4zL+nQ5putW8os2Vdp4itMo4oexdPh5zecqhk9ITKP07YklBJwz6z8agK0/tKfs/hes4js0Cpajr8QU+qpQX9PPG8hEUhSkOOeEcGYPykhR55G1ZvWwGB81otz/wS/k78M3HBXGzW2TRGNu81MjTXsKpW1lpdjiZPK4H/UoROnv6ID5VzrDt/VBUMvrrrv6qLjXT/YvLcEZJQMfddjdRDYMZ/1qea7UMcNJ8hHVIBqDozjO9iRhq2Jy8ZMom4KFtnNQQVmay4DjdZbptKy7XrQEIhZ96HI4z8aieNdRAESSE0zoENZ4gW0HLpCl6UgvY5Di/tgsNgdx7dHQvDEUaOmm9UQ+mRa2XN0mymLCJ4w+RqH6o4AekR5QFA==;5:Z1kYtJ2ViX7lmjxBwkgq+Vu2dM8qARDpl+g4zTWy78+djp0O8vaJH2zKs7XcyQWf0CLdXzK+QGQP8OSoc1B0t/UZU3eH3/zEZTzbNQSrm1gTxS4/2TLKzCtjSmDKFRxlzjx3rHnB/IGnZp3vI/3hgyEDq64L5oMUmzKONrjC8oY=;24:ZvodoCABbFu0PW3tJ+EaSa/FO4Ioqtsmps9nS3fTBorVqejzhzwiEJYgkdQKostIANDQpFJA3oqPkqe/JF/uv4oremkWICqMDrIHsQSZbls=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;7:jNe4WkhBAaO0HMWFfXKtbsExlbcraxTsCDci7nhlk2ggg1UDq9ho4qqzVOdv8dp6hWIIYhbC5YNQ0nnx5keT3KVrRSuee8iczeGN7+x1EMENmASe8ZYBxDimOYQuDARQGzI4ElRZIgYFa9d6URALYi8cBTeRMZmV97dUgtacBt4sE6tVOH79ar1rCObrmhixV7GoC0oacKBYLLXt9vo/4FBg1u8j5olsq20yEiN6He4SFZMh9rL0bvHbouB9Pflc
X-MS-Office365-Filtering-Correlation-Id: a61762bd-40ab-4953-4990-08d5ba7d8c22
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 16:04:32.5185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61762bd-40ab-4953-4990-08d5ba7d8c22
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3029
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
