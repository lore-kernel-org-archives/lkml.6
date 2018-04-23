Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755701AbeDWOw6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:52:58 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755244AbeDWOvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:04 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 1/8] drm/arm/malidp: Modified the prototype of malidp_de_irq_fini
Date: Mon, 23 Apr 2018 15:50:44 +0100
Message-Id: <1524495051-3891-2-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
References: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::17) To VI1PR08MB3039.eurprd08.prod.outlook.com
 (2603:10a6:803:45::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3039;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:uU+lDrvew9YmjAH+HZxGTzmyQyFfW64t672aLr999nfiAToxEjnmv79nUVrVdGHzXl1HnhAfekgvdymUgQCJDzCUr5KLdpKu0+/yoFYYbK/LNrx0Uz9Om60dqHIlsT8Rypn/h4E/Pd9PkFJitEjt0JiC94YKC/Z20Qu+bmcCUePAUBK8ybA/hl4JOGNgso8smhG1gcSfMG4JT4OIsVbF1RLPF+qcih2hL8M1/OuIP852aApDkRHBif6EzZU+H/I/;25:O9OVDKTIJOgE6whMurjuWIjYDm9KfbjPZ/3JtA2wv5D/WuYKCtgRHTY3+Fl3IInobYMzsCI/JzYtJCNBJ6MNJ62fWqrAfVtUsxYfdJkJagb6B2MTRSJghYmo4QyWIwq6X7jcSnPKI4+YUM168ohhcslJHnFM6ZsWNvFRcyP0qTlGPWoX2Isy5lb0wXk1b6BAVB3VjgUXA3AWOxIoTGhlU5fzB7f/m/KzvLzBlngXYl0pwStPAUwOeSR7ek8lN+S3tIr/frCUrR19wuxBbg9i7SdlTEQmInf3hr7+drhWaNC/Gb9xi7XEkd9S76g6oCOeqJbWN5LJKCTSnXq9v9u6lQ==;31:pAGVHuT+/ep9/vK/lOahsvhWuzoxEew5TTRiSMe5m4J7RDIho2Oacq4QDCMubHCNbNUOMtyyHI6xXpB+sErpGzp7rvAIIWGy/0HhgUFlbbMHv6tajMDnh9D8PPxvepovu4K1rRbw4SmwX29KYPuWgAzLZOYx+NNhSxP0cU0bW7FobyPk6eq3kOkeIR7ARd6+PT2vrZJmAKzyookDpBSgVYMD4CZgHqmypEbpL9/qpic=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:DsPqoWZV9ZRN3muEMaJ1iS4fgocbTqnyyttgmPpHihuAIAs/CMy6Ux61a6+unSDDF0TMNTIqpAfloaF5oI1s3iLxtuy5ghTuSRe5WG6AUMHjD83snUw6glEl9WERpcxr21EfAt6GhXJnlbEhtDcOeDfNpfmzf1WUteakwzu766QUdpQfLcWNWuIlPQb3l5+7GxbgSAQlB+4NhqvHhErIijYEcC3pbIt8hoHxNHnfFezetafzEk0eXTSqj157KUOl;4:zMklgOHWdYSl8bWEdOaAN27D2TeONHm7hYqS2MpCLMWZxKYpoxRg6hf+eYEouHRyWozljoM3gROPLQgAwSzjzhNzhW1B1IcYj8Mu4xiIj/juMurfqAW06CnnqxZn3bbSCUdDE/kwWCec0AQyG7pK7Jj2DI63D7bfFShEdEEx2co3vMFQ5D1RIL25c4t69dfS0tbASZQ2vr0cfl7vJPdu13KbB7i/3FpNauEah9g/ITIw3sZjuFiVG7UKRRsw6eFHOR8dBP0Y8oYGEutV0oTsAvtP4bZ8y8AhZuNCOy2LxXl03SVLLbymGYa2iRGrCrQN
X-Microsoft-Antispam-PRVS: <VI1PR08MB3039EEF1177D69EB4E405F14E4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(446003)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(76176011)(316002)(4326008)(386003)(25786009)(72206003)(86362001)(6666003)(7696005)(575784001)(11346002)(6486002)(2906002)(8936002)(50226002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3039;23:m8Q5TF8HoU7TasjlDYPZs7+QlToUS8Ye/AncdBF7/?=
 =?us-ascii?Q?DYo9Vo0vVT0f9Gfa5EBOBHoo4dzwa3huZtTb2Algssq9qta2VMPqQS0hGWRg?=
 =?us-ascii?Q?vgmDRYAHxyC9cijHvRywOSaqiaaDTCZGA8l9o9EuIiIKzBTWkPdlLt+6AWz7?=
 =?us-ascii?Q?64/rvfT4iz77hDFWjCj/369lbjdPrCEP0OIvxEvfBo8gMlkllPwaCb9aXZcl?=
 =?us-ascii?Q?dkxmVQUYVAvmhCWJCbSdEx1bYRW/U5joPGbWepQD8XfnrZaJoLx9JWVmQODY?=
 =?us-ascii?Q?exxjw2w4oKg0QYcWOFD0pf6cgJwcTNOw5ChLXvEKCFUiaYs/ewfCo5+eOFA5?=
 =?us-ascii?Q?BY9lzaN50kKmigQZ38hxhD5hDutdmUpwqr3GdKpSJNsh99dPz5RqTEAUk85X?=
 =?us-ascii?Q?uCgXHAiCozOt8AMG6uuHy4w34Rv30MSZJ17qCHeCLjaGPHeu+nOJzHjWUXwL?=
 =?us-ascii?Q?dvVvUxlYRv3UPv0B7uFNrbnUCnYY37OeCtJNEJOvOhcYQJu9ohZaJ1CxmJ+P?=
 =?us-ascii?Q?nxfLg/WKZYB69gznVqrXuYoQ2tVqmKHP9takxyf3I430uURp3xJ9DS44Joaq?=
 =?us-ascii?Q?0SZikD8mzudjH6vkY3uDwHuKFYuTiNbs0UhnjPKmNlQWRq8XTbI8eaB/Mez5?=
 =?us-ascii?Q?Rd7kFZiJoHoeQqIL6gff3dYT5J7ozvm8QtomDb2cSokH/Nx3MqJQOJlrtU0Z?=
 =?us-ascii?Q?SS97VE7B5FNc77o3URU4NiflKm8pmg+uO78y4SM5oKRStz1jvi9QvMnLs5qd?=
 =?us-ascii?Q?PNvf9u6yOxlebNWCYKf8ylZSovZyBb0703HCAgLYyWt3tqV5EwmgzRn5TzvH?=
 =?us-ascii?Q?yVeuQQugE9uPSFbirjgWNxMl9WarwSiTCnOBs1fVFyjfTMnPoDvstNurlN39?=
 =?us-ascii?Q?7fL3rkra+bc1hyvW//0Q+lXssf1mS3OeBJ1lhw9NNDrbG21JvX7WOoKW57Fq?=
 =?us-ascii?Q?Khd2ZmLNAYtcAlLBRoEGfVywtke7R4RjksRuHRtEaSCrMLdqw0wc4rswrhQ7?=
 =?us-ascii?Q?kI=3D?=
X-Microsoft-Antispam-Message-Info: FTPRB+8xwMcHD4cUk4Ag6G34bHliKMCaawmhxQSBIe4SH4EiiJZrdsYJF6Q/hdqo4H3kvSru+SE5NkJ/KpZQ9GFnpRtKbwRhKfvfrBKZBZ24SM3vFumwnxaGD4nEIcO7xWmU+WPv0uzY0HLuBbwtTh3rO+TOOR4PhSydt1X8xGJqBKfpvYAVdEyvUMRdsuKX
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:LKvrZwtppPJa941RPwqiWBNw6xsS9EgyJQHtwZ+9cBKgozvkaoFs6kIHx9af+gwgKWWVOIyqsR/V3touBWnxWdIqgimDJTj/WtX8SvM764oWk5PuY98h7m7ofSS37sBF15vNmMhT0X+8DboW5WVgjVGxIXWVdF99jmuQEQnzghiWkn35JF+Z3wWgYGC5Ofq+vpghyoFdhuD+J1UE516vJtfHQKVWjm+sVTKVsN9uXtt/p/+YlK+mIeI/VyHVFOsXawZ7ZKIP1tUMKRiGcotQTgccfIOAkaUFetcH2QjcoZ6ojAh65CzoMCGRSUIpiav2rMGxHU2GgY0hE8PEaWXQIFfve5W6GIhEquMv1yMmdUXCn/sMKllR13CAj0kbs2+IES4+hWnOnZsCEZoRcu4JCCse0LDCf18NzSA/38Rt9tFPB6KsOibR0CiupXTdJVj+YYhx8L1+Uu9TvLsZPH1wuQ==;5:PiZKvsk31fV+u5fkDFyB9s8p25VCLdF8SBU/kPqIdeSSiU5eKHqFBVm3Rc+cJ4UPbKTCDau2SBhtWoqIgi6eNVz74rDSGZobuRQZj0IffoIE1LbU9rqrd+446DKB1jp6yawuRbyZA2iHphN2yCOue0GqlbjABMRBWLhHa1mXjzY=;24:45U3nYuZE+8pXIlp9+XaBH4wOLN6XHGQ5RRH0w5A23XWcgZdkmTQnjzmmauaWypAjNHXeyOFIZ038b/tDTsP8kLqYNWzK43vCqnDwRqUXZ0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:HPjtlnnMihpWXDxgl73TgCjoTPh2vSqECztxlTrpiwXPaz07amLKOFz0RAhDdkpDGR44EeuLYbPZU2IIF/67ULk/x8oGvzQVs2D5stiqtib0fiXqxlD9w+g3LIjAduWYEHe0aejyf0HImrtxgoT/hR5Z6BRCGzdVOZkFkX3poYWAfL3s1el3N3LcSCMuO4InD7s5PHy4sA+VK6ZzXmIR2CHkbZzYGzOGdWZpLiOgo7/RxlP4OuVqryGQ90POf5Dz
X-MS-Office365-Filtering-Correlation-Id: cfed7a08-8d6a-4583-a4e5-08d5a929a291
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:51:02.5406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfed7a08-8d6a-4583-a4e5-08d5a929a291
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct drm_device' is being replaced with 'struct malidp_hw_device'
as the function argument. The reason being the dependency of
malidp_de_irq_fini on 'struct drm_device' needs to be removed so as to
enable it to call from functions which receives 'struct malidp_hw_device'
as argument. Furthermore, there is no way to retrieve 'struct drm_device'
from 'struct malidp_hw_device'.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v2:-
- Removed the change id
---
 drivers/gpu/drm/arm/malidp_drv.c | 9 ++++++---
 drivers/gpu/drm/arm/malidp_hw.c  | 5 +----
 drivers/gpu/drm/arm/malidp_hw.h  | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 4b0c4b4..ed38ba9 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -295,6 +295,8 @@ static int malidp_irq_init(struct platform_device *pdev)
 {
 	int irq_de, irq_se, ret = 0;
 	struct drm_device *drm = dev_get_drvdata(&pdev->dev);
+	struct malidp_drm *malidp = drm->dev_private;
+	struct malidp_hw_device *hwdev = malidp->dev;
 
 	/* fetch the interrupts from DT */
 	irq_de = platform_get_irq_byname(pdev, "DE");
@@ -314,7 +316,7 @@ static int malidp_irq_init(struct platform_device *pdev)
 
 	ret = malidp_se_irq_init(drm, irq_se);
 	if (ret) {
-		malidp_de_irq_fini(drm);
+		malidp_de_irq_fini(hwdev);
 		return ret;
 	}
 
@@ -652,7 +654,7 @@ static int malidp_bind(struct device *dev)
 	pm_runtime_get_sync(dev);
 vblank_fail:
 	malidp_se_irq_fini(drm);
-	malidp_de_irq_fini(drm);
+	malidp_de_irq_fini(hwdev);
 	drm->irq_enabled = false;
 irq_init_fail:
 	component_unbind_all(dev, drm);
@@ -681,6 +683,7 @@ static void malidp_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
+	struct malidp_hw_device *hwdev = malidp->dev;
 
 	drm_dev_unregister(drm);
 	drm_fb_cma_fbdev_fini(drm);
@@ -688,7 +691,7 @@ static void malidp_unbind(struct device *dev)
 	pm_runtime_get_sync(dev);
 	drm_crtc_vblank_off(&malidp->crtc);
 	malidp_se_irq_fini(drm);
-	malidp_de_irq_fini(drm);
+	malidp_de_irq_fini(hwdev);
 	drm->irq_enabled = false;
 	component_unbind_all(dev, drm);
 	of_node_put(malidp->crtc.port);
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index e4d9ebc..b13dfac 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -900,11 +900,8 @@ int malidp_de_irq_init(struct drm_device *drm, int irq)
 	return 0;
 }
 
-void malidp_de_irq_fini(struct drm_device *drm)
+void malidp_de_irq_fini(struct malidp_hw_device *hwdev)
 {
-	struct malidp_drm *malidp = drm->dev_private;
-	struct malidp_hw_device *hwdev = malidp->dev;
-
 	malidp_hw_disable_irq(hwdev, MALIDP_DE_BLOCK,
 			      hwdev->hw->map.de_irq_map.irq_mask);
 	malidp_hw_disable_irq(hwdev, MALIDP_DC_BLOCK,
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index a242e97..6e2a2f6 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -297,7 +297,7 @@ static inline void malidp_hw_enable_irq(struct malidp_hw_device *hwdev,
 }
 
 int malidp_de_irq_init(struct drm_device *drm, int irq);
-void malidp_de_irq_fini(struct drm_device *drm);
+void malidp_de_irq_fini(struct malidp_hw_device *hwdev);
 int malidp_se_irq_init(struct drm_device *drm, int irq);
 void malidp_se_irq_fini(struct drm_device *drm);
 
-- 
2.7.4
