Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCZRGI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:06:08 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:57120
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752604AbeCZRDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 1/8] drm/arm/malidp: Modified the prototype of malidp_de_irq_fini
Date: Mon, 26 Mar 2018 18:03:13 +0100
Message-Id: <1522083800-30100-2-git-send-email-ayan.halder@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe354c1b-63a1-400a-caa8-08d5933b8467
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:IwScmjzYN0SFzRf81KRJKvZfD8OoOhe3Lbhce4DlFqPjSosXZM44ndWA7OGH4f4wJ/bkHYodGjyGIVQWYfLHBhDvVPfU9Yrp1vfNV774lsi2Px/UAIMPTwHnnWMBGlUWSRHF2TUVAPj09FwTe8J3du9GF+6r/Lm6LaMZsSFJVl1HXGDf9uLbc6Xdr3OoK0JGhpXnUkxXXY+b/NmeOJS60LDiHvN0TG1E8PePFhD/2k63nq3WLFHVfbk/CdgdUP/m;25:RfIOjqvk5ML0eGrr/FkUHVg+nwogyIJ3FX4EDMh1XXx15kl4IQwxXi0dOfVNpB57BjhEQ7p0axopiakY+XO2ujniFY8miUbHXNy4HlS7+1dbq5sKQSmFTub9l31duBvTDgYTnIjqJBpTzdlIpEBsW0DDN0/q22NrE8X27LXAz8slCBEjRjcyfKsNNurdCMd561ld+yH+qabyhL6UmLmR/lEBwCGvAks4nZhJ3IKnosx62YQzjttyVFa3DNtUSMHxAq5+V25Xu91XS0N4YUweL6NVkcd/2IPB2g9agp0Eh7N+qeKB/mb/K/bwYkCjXjy+UrXaar4DPxSFhErNgFXN/g==;31:bAjp9nn/dq0FhKSGCdyVSrl1M3BtME12ifwehoqk/M9IKMAlZ/uzeZIkDZq5ANRL+3zu9hHWnxMcgBMw2sZ7aMMx/Engbp3R5wkrJRG63ij+3s2cEvM0cTqpcvjG81rdDl/Xt4u/13NQjY/gLeGuKT9WPfMuMllST/4ks9xfoznQBcEt8MI3rw6oiezGJ/yyqcI99jROpRqK1i4eLizuByrbL9GNfQbYPMHjs+jqvpQ=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:WPczJvlAF1h9GiZlmIibOIRdJeYF9iwZymDTJVctVuPBuGSDcyWIsoU677a9QhAiWH1h9HCjmh7fIXZFc0yNPyTB2x7z0I+dOtu8W7bD2DbKHSum7Fz/V+EeglH3uCtRL8in87p6guGyG+hNKTU/jVEUjgEP8LNo+gSdrJshD0M=;4:Etn9ahQ0NGKKhSBxZOLQT4heSHEWmWq6TLoFUl6s38RqLlTVMET+sq5ZT6GtwchTRu6h/8krHJwYqp8NpNseLmo6Lu3kiDndlLNwOAw88uYGpG6IxdwJMhw56I20PMZqXNYRGsTn5hY26zIdkE26jhZIGTXHkv87t+0bFEkvU1hf9Y/RHFjfxCPOlG6Oyw0qbOjVAgVEicqJl9y3EEyc/9sU7VejEUEfjchqjKFblbFxmHZoUd2UdD3t8VPxPJY3HgWnxrHpe1d5QClcDr+PjEmZrNwlCwncIWNWgqGSKDMG6UAZceAbTJj/28FzfBNl
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032CFC3B86A7E22792C57B6E4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(76176011)(305945005)(26005)(8936002)(446003)(86362001)(575784001)(478600001)(11346002)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:6Q9k0JJ38DDi+X3pP4hbnlFUV/IH0sN8VYjcqQeB6?=
 =?us-ascii?Q?W6kgfEUdYy55fSQlZUfZVzTMQ4gcVI3cs+s4OifGywKFStDQFaR7ZVqYV3VI?=
 =?us-ascii?Q?ecyCnb89COPdVcellyADZD8qPvyDk4hqpCBustG2Dgb6UpA1sF3SYrGQ7cij?=
 =?us-ascii?Q?K+UhJDhIWZaG+ATi5HV/rKFz+0MoxUZUbvyo8I9nBlzufa6zDSGui+FPOAAv?=
 =?us-ascii?Q?sbY/6p/C/MfTPCS1VQFLBEXkVJY3K0cwB+0q10u/8pX9RrPiGUq0ZSixcnvO?=
 =?us-ascii?Q?aonpQ08ujFWiSSOAVzlKEYg9IpTzjkJg6NZMCOGErkXSWgc8TZ2JcGAyqMCt?=
 =?us-ascii?Q?0N5l+Ui/+B141hihrKgsbVb9VtwzxVaYFvfrRYs7N0/aiY9vsqtw/GMHlq7+?=
 =?us-ascii?Q?EnWYq/fQdKCkvaPXtxCl3i13cc7qsY1ZgAt7pHJZweoOPRTuEO2Is6XTBN+a?=
 =?us-ascii?Q?UsVE62UT/18LYUbMHV5IN6Se6kakWJJkWy/C5ApeS7aZ0v1dnT13gPJOQqCf?=
 =?us-ascii?Q?ZLGnkH2/3eRGYkguDWIcXXmJ3e6nfsI3Zf0i/apc5ebDTSCfSoT4tjQHQs1i?=
 =?us-ascii?Q?S3EcvmQm9sEkanIRNWtq5VXORkjx8RRGApnNOZUCpqLEMxEtgY9ZX0vvcigh?=
 =?us-ascii?Q?vM33cyoDWJq2ubJJQF3pyTtxI2CfrYP5NynsmEqUhY3MYrBDTZLfMEh3kacz?=
 =?us-ascii?Q?r4iDYNJSPl4Kmds6oTrwLtp2q6dSRPQdgH8DnhJO4OgBGyPP7NmtUvWl5H5+?=
 =?us-ascii?Q?19cjIhDW/QKdqYddR65raCTEbn8OH5bvpG1iB3RHmze7MJAjpPw31gH/4RHp?=
 =?us-ascii?Q?imKzbEyvQni98iNx7PD2rtcr4K5ktUSrvgdpi2ZbVAizMRvVLJK4CTkubZ31?=
 =?us-ascii?Q?C1AViWBJloG3Af9eg/aoPkm66ZGIrETh2GhOYvvCkUkT3jeAyfWXwmHWVllv?=
 =?us-ascii?Q?T7xh3efDjKan1yUcouZb7CcU4aXLqXZPnUZgTWjdsDzfvX5iMkJle/nUdmXu?=
 =?us-ascii?Q?zWkJ3TVap19s/3MGUXSYkFk3c3yZpJFRhKWhEWRgx1o7qYUG1i3QS41tUA6N?=
 =?us-ascii?Q?Ze/g+Teol1rxkgMfQl01MMRt8fz5Ks8w4ra6qM6mLoFbJaog2s05/C18Df8v?=
 =?us-ascii?Q?SKIndaTxmZTlxezAqLM3XfyUGWBAZMeeqY2drTDqt1jiQ3CbpVpk6jja9Pb+?=
 =?us-ascii?Q?bvKveTABr5Gbvk=3D?=
X-Microsoft-Antispam-Message-Info: H0iq1cdhdf2/vpeMdrPPg9dYsXKNyMOZhDfjvA3hbW4fbE9ilHVCMXoy0SWIRlj8sxo+4hi0bbTAr2Muv8gA3SQzOKIiGQ5leA6RkH2cuP3vkPdDD/h3yjPblq9e5bQgpvibODeO6/xaBImTP4BX0cPpZTd4LFtZ5WQUtxrfio88WsB1eNfMH3D2bY11/gPN
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:D/WVS3IPexo8L1hRKy0UIz5yXzfUtuKuvTXr1HvVE1nDYI/AAgDYd4o6EdfBc/KZoI58k8Wmi6AnjU7neTryYaKWYqEah9+yEvqI2utH6gGCr1DB6YywhNk2WAYdL5Gc8LLDrS1R2CjOM0dz0N59c/z/HyE9R6JggV0Xk7SE1nbu8OXTyO0fECzPi9AqzG3J2F8NluLb9ePuDmFPyIcVtD0eIjqvXx33B7onEF1XGI0Y/Xp/lQLcS2KoXXy9zLoyd8r1ZzdLmEe1gBPT2T2cDni/86KlcD+Te/VRR6pSOHNyAk4hOOUHZE5ZuNWNk+a2wHeejyN1qurywCJWTvzx+7T91OcE6qH8AyUL9v+lZyZVIktn3tH2gMu97E2TRoAsRIAYAJ+nepbRVgyqWUYbMCM7mdcI0ZI9Qc7RX8lbTsOBxn5hJ1+IC8Z7rx2uKFucsQAxgIt+GwyD+X3kI59UYA==;5:zTy8jNVDy/+MEYUoPayB1vAd2Hguf2SzqTQsMqH3H8fUHAkk2XqALit9OSnEEGloa7QbShQQu2Tq+rx7qqEyv7UaeiYEmN1ukHq0kfYX5+0LCnwLQ6o1uAYpr4pnm/YupfAgTSAP0tvs7ygw7OQ/VK+zMa5QQYjLh0Y/vQgeyv8=;24:lTrl2hK22DhWHGT237n72IKfnGO4UzPcFFBcLwI6vvY0XPYoDoC3+g5F2Sd2ezbnVCgL5MvYFaBkLWXboM3erVC/ad6r7uWa/HA0n/teU88=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:Ge8QlMVsi4HCwhpkCy6VYVzeX8BAsVrcfSBbvjo3r4+YDTOppNBVIlRkyBc/b4jplT/fo9RaYznj7BdqaDoeDO+DvFqBoCPadcMb0TlYULtT0vs4C212ykPgG7fhbne/88qYZdyf8aujmX84jpFbHIfNsnSiA4/uCgJHbRJkmsm3N9C7bcPM8FATH59iUrFGAEcwqEizrvVfysJxp6IVW1znHBbaGu+n3UGBsclTVhDVTn0DHC7wwbrniOdTZadk
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:36.9978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe354c1b-63a1-400a-caa8-08d5933b8467
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct drm_device' is being replaced with 'struct malidp_hw_device'
as the function argument. The reason being the dependency of
malidp_de_irq_fini on 'struct drm_device' needs to be removed so as to
enable it to call from functions which receives 'struct malidp_hw_device'
as argument. Furthermore, there is no way to retrieve 'struct drm_device'
from 'struct malidp_hw_device'.

Change-Id: I39c38cc4c0c9dd951777fbcb13e2ee3168ea0141
Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
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
