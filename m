Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeCZRD7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:03:59 -0400
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:26496
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752606AbeCZRDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 6/8] drm/arm/malidp: Enable/disable the scaling engine interrupts with memory writeback
Date: Mon, 26 Mar 2018 18:03:18 +0100
Message-Id: <1522083800-30100-7-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:803:1::31) To AM6PR08MB3032.eurprd08.prod.outlook.com
 (2603:10a6:209:45::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 613cf87c-8ceb-4546-74e4-08d5933b8a43
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:nVqm6V8wm/7lf/W73unWvbEnREuGuh5tRs0JtOBgnX5crjG8ARvft57WSX/e5r7Ni1E2udmBUmhddi9IvNQwv6Mz3jivvnjvyNLLibiBY/J0HxgBFEy+Sd3bk8R9h0rEZbllMx3eWiUnfw4USjRjdVvZo0Ljv9716JdnDgscH9NaYDM4IR4aoF2IW4Jf8/b8UsMrXeZ205ZejV+0wA7OVWwLZ4osme5PM1+mzn/Vc+GhxhWwXSZmYGLmD/tviA5t;25:fxJfXyailu339Qt9l2rCTgHLcffajsdvFtyohAO5QTZJXgDKWoj2RdvTR75FvMUV66zi5z8wWTEjhBeYiDg9Qmz5zWKtlMF58bEV+c3yEkSsPoGb2ePMtOBmjnjsBy3zygd2vwzUrB0I1Cnm4AidNPlAu6tUV7SNWMJ78hCX9MEFcJIF4LNxBP5YbYH0wIvyLbZRbnepYUqSU9n9PnMazFHDmrz+qsaVmzVgb3EL5gzG5sI4DUROX+0KhAlhloj2JQ3aMb3ALjlDXx4hV+K0UICa1vgoMzsahi6WhqNs6EWVcLfMY+wa3D2k4XuhfGOO4BFGuHZAWHG34/A2d/d9gQ==;31:cO+vRkJ1sXVw9UlMnIl3f7CPSqNahRtxVX9Bh8cEwEKS2EhyFcEdhac78sVpktQUz2g3yRZIIVb1Zd+1QQaCeAyhPEMbfJgQnj6tJ5fbXGvtERXzOYH1+CWNMerXQsUcP13EFfHwjcNECoSJUt2jIB1pPGSlG4iBhBYv9NsEqNWG9lr1MkPggIAdeQ4gRHRhkz9A4gRlZZ4Dux0oSrdMUkaTgdSa6llpT3ES2DmLnAI=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:vLxwiTr5ILnPTN/SbYgH4NhyG6mXwvCgT+wcdGKWNh46avijnoLyTsLJ8aof3V+/X1q5x8mBSaCf2jQkPOXJJE46hgeEwwt6EfLfEbotmdk5OatUdC/2gO59LGvAYaXae/TPe/140p5+yZ9PHMVpoIp2OiGzA0jBNoCRfLZw8HU=;4:1gpJXtKEoQ9RLc/HHkqgrEWpmvLCyeNBgC3Nlslu8mM/uUV4NM9pKKk/3xvB8vMlnQm+v2Pn2J1C2339fEq9sC7pZVv1+RgBogdL5QoruLdt3hd4hHbjVONgRFCzHxxTUyJoMKOwECKNU1o8JgSKwPemKjmhC2iBwH+49ldjvYb6cl54kjv6QVkNL2Cyd/kTsLrBHtZzTPlkyEI44RU2miOYq1QcJadAI4645dRihcxO1uFTkdufnCxdUPpOgoHzZniGT3rjI8xnxme7BQO01arJpN8gNjZ4xY60/JXC6X4F5aUuvHiHrNJIqTPJtMz/
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032E6236096B90EB32B1911E4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(76176011)(305945005)(26005)(8936002)(446003)(86362001)(478600001)(11346002)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(59450400001)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:fNJodRuZdH9e5dLdFk0kJi/AxMn/Zppcjt24JIp2V?=
 =?us-ascii?Q?TfOoAKR0vwKrZm81X3WkvF6IUTZ3p6Cxln+VIj+xEc4Dd5zJ118cTk1WB7p5?=
 =?us-ascii?Q?HHwNw6SrFzxoWT9IcXERA24MY04HYUfoIKzRYkKdRID88mi03ccpM/mnj3O/?=
 =?us-ascii?Q?9Xra7Zr7376M0NXx/87K5oXWmuICPFoV0shW9ESSbgl6Bk0RZiv5vwhsxcUe?=
 =?us-ascii?Q?Y1YpZFMpTNiOHSkQb3jU4r6UgLrYKzTLE8csEQYU36GO8T8lRLW96R6lS2FO?=
 =?us-ascii?Q?5OHEERRee08EmAmaH7DAfwXcUGPt/TeC0sQm6XmkOE7Ede/qWUutrauYZqhf?=
 =?us-ascii?Q?nSRoWvBVnQ9XWoakMh9p3QM5wn6LIY+lteSkGfcUr/6fnkNh0zBmDchQzNxu?=
 =?us-ascii?Q?suSGGZiTnXUr95gydnrhalGjc7Gw0yOWlmyddYUBkwsR9dXNzarUyy4BLtxZ?=
 =?us-ascii?Q?Csq4odC1+M87c9LUT8fgZKUxhPLghDc0Qh9uKjqxJkkfGsvH0kw39BWP4K+A?=
 =?us-ascii?Q?8Bb3O4YtPqM8vs7uV7+jKF2siHIiA3wjP2sJZ3W3aGsfFy/wht2t40yKsNIb?=
 =?us-ascii?Q?IDty7eBndduuMJGX67C/rvo2D6JAn8pmhHKrbVHClmZteeg8wguvAdWMQgAe?=
 =?us-ascii?Q?VBIAy9wPpzbvJiWMHha8J6oBuqCvIchifmj5YF4oJGrtGASvx+F89SVvZVCh?=
 =?us-ascii?Q?WNsMFgyAb+X/YQ5Nz0WVB2AIMFEjXn1FCg79mS08QPyEJXB8Jft2kGgU1KTU?=
 =?us-ascii?Q?YpQhiAQoKLqDX1zkwIyRz1937h4sMPOhJYB2K2wM5kPbbQouV9WnO4+F55J5?=
 =?us-ascii?Q?YePoOZF9P+BRrSZsAoGPi+bodQhXTnuk5AaAMlCz1Dn/iMkJHVQV2TV5hjza?=
 =?us-ascii?Q?e9tKUc18QxoBbI/N1twrlYLlQU0smwjbe+GgvhJzZC8VHLw/z6iv/kB9rTcS?=
 =?us-ascii?Q?UBn2PfuVqFkMWnaEMrOQKil7Te5VoxyAPKjvuG12VBH805/+3nS87bS5gq0g?=
 =?us-ascii?Q?QGs5OUcgEQE23XwzfZSEOXazQbi7d++5oplZMARjOgeu6zcJlNwi9+I5kBzQ?=
 =?us-ascii?Q?lu3RRDobOhj3PjjKgSf/6/3zdVVDBtJJQc4/2JA97Kpuz3Y6bBVib5g7Q+xD?=
 =?us-ascii?Q?wSdcym3UFrnC977/j2tKeNWelyxZKNoIc7FbEr/224nyGJeZmoVGNk2HWAuu?=
 =?us-ascii?Q?yu144l21jAhSYc=3D?=
X-Microsoft-Antispam-Message-Info: yHNhfdCFbaAK0lLHm/ByMmpk/f3x/blS2ILjG1neyFLfsHyOjg7Ou3ZZyJ0AhOweneBRnlNr1rb1yVQ5L2Lipniyz5Q1bKrMMPcKIOtV2vGXQGHNlTHX1P0O47ZcjDoIiV3y6NJGoeWaKpWDs5ZtArawwI+cHpMVvhUU13AY2FsOKQwbyDoAdiGu3UhzG5cN
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:e3N9rSFzWuV7GojtY/TnQa5IYosm87mHNhHe3i0Uz9thUtHBaMW97lYcdlaB5KQx+OjeeO1Qjy/gLz6C/cJF3xk731cLuA86xcZu1DBIOk52jCxnUXHVE+n01Lm5JjoDO7yXM0UgDtVV+fzfyYoBvgoFuKrXSf5n2/8TJIIyU1N7o+4pbCc07fUEt5twoobie/b93GSB3AVn2A0BZwjuwGHUwghsJnAfbR+mR/0V47kulQkrS45xE5nlyU7s7iT4/ZRCdH05oU+rsh9Pw/1xS/eRyW3KIKIn7bywLLsElfjKLAqm0LAMsRc08vzXdIfvUMxjOFcRwnWLLNYSYOpyJ+eAkKh8U6+Hg7hMkn2KhAQDmKOWNBf9FvOwYOD/xbLeDtQ0YImS/cCol8MA1lDBH0L30UIdR2FDlGMk31i/aqVGOJRQgEvFAa8TfbOONcXGYYkuWwfZVwNPH6XlTIpW9A==;5:QGp03y7vX7WRYaGuPXtX/KcUOjXeAATBfKoKB1g0kDJ8ehdCt7eH5lxFZs3ZjkVnYHOSllyLDoFeAlepHZ+XVgs80jiwnj/3jP0bNt3uv8U24YT2Mt05LSETGBRvklMXtKPBWIu3uh6f1vXqhjbmZrv7MwPBFqAvU5u7XqNxOMw=;24:wR++8Dm475a7LMtcmo8945EHAcYApmXf5IQO8LS9C5JjBlO5xRDQxKTxnuPS5NzP5bJNe+E2sV04N4/8kNHcyOWhe3lx5RN0PGZlW5cs37c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:80Xh8RVJgVWKqk+wP7eAuqFAX+j7ePDjAye/YDH17A2y1qNZjHcAT+rIUNO9umMnEQwZsKFN+urBD9fZpdxb+bKDmNzigDVpgnD3kk3WY/8SYcYv5NYaKVKBEmwWkN8JzlNxMrRYlipAmc7+PA2k4Kqbnpebk0cDhexEBVoaq7GVP6hLT+sbm4nNPz52VoQGyNblsUcXKGyfDKxNTcqAFky8CHpkaMxsUNXwdEV3VRGszHUYkTLnHVOhui7vfYfB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:46.8260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613cf87c-8ceb-4546-74e4-08d5933b8a43
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scaling engine interrupts need to be enabled/disabled as and when memwrite
is enabled and disabled. The reason being scaling engine interrupts are
used only by the memory writeout layer.

This patch depends on:

"[Patch v5,1/3] drm: mali-dp: Add support for writeback on DP550/DP650"

Change-Id: Ic78aa5cd7b53998a1947067c4a15c19de239583b
Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index f5633bc..90d76e4 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -621,12 +621,14 @@ static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev,
 	malidp_hw_setbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
 			  MALIDP550_SE_CONTROL);
 
+	malidp_se_irq_hw_init(hwdev);
 	return 0;
 }
 
 static void malidp550_disable_memwrite(struct malidp_hw_device *hwdev)
 {
 	u32 base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
+	malidp_se_irq_fini(hwdev);
 	malidp_hw_clearbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
 			    MALIDP550_SE_CONTROL);
 	malidp_hw_clearbits(hwdev, MALIDP_SCALE_ENGINE_EN, base + MALIDP_DE_DISPLAY_FUNC);
-- 
2.7.4
