Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeEOQEn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:04:43 -0400
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:19657
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752537AbeEOQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:04:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 1/5] drm/arm/malidp: Modified the prototype of malidp irq de-initializers
Date: Tue, 15 May 2018 17:04:15 +0100
Message-Id: <1526400259-7573-2-git-send-email-ayan.halder@arm.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;3:3HtPnTa0qN7B9SuihHDduwmC0I2OdaSQbT6aXmcVdhjHCm8lepQcrX6D5xmvqhxAGgyLulDKuWY68iw7ocbx5NAOgYh+F46p2Yqu9J1K/hY0C/BgEufnGd7+678QQZz2UJ6Qhoxh4IMpImuLrYUzvxrJ8KL/q0KY2x7sWn+UeJEbZQIDVY/p32kBhE8akBiqMxHNmbV4CYMssRWW4HeaS7TAelCe6bQM5Kcnn/yypXl8D0LJKf1Ri2V/TcCMD/Nc;25:A7N0yXnCzPtEWDQyk5eG4i/cwGH5G7fkyWZBrQH1jt6JKff/07GQsLIA2fUsGTDKo1gctB1robVLOtbNteNtZ69kmlt8KVDQNhWH/6NdEPCF+q2ziRb21woPc/dbXRCrL6w49pNTp2UoNMqvfIa5n8pwWjBPHLcdlU/GEoU9BM5o2b85sKuRM/nUXbCJjYzEpa39FYH7+iHErciY2p8iAKnfUrZbOUyEHowyx6cx++N55H52Ix1XLbSP8RwPrWO6DzCysWoLye7sn2azefPY00rhvHyT8EhmT5OXjU7aNDonRnfB2XqxD6iGh/a4HGYvL3uQXZM2RPDapFSE3Q6QoQ==;31:NkIKcrsIrS4WrvjheDwoQaE4JwWXjtSqDmBteeExwToQhHgU9rVfzgW1TRIzegSTR1zPc0XcIu/Kkb82RCCKXBio6e28IPWpvtb9FLpAh4ITZkl0R0xkaUx0c4M3vHtaJP2aSgwdS8zdfPOSRtPTxz6upxKcvh5J4AcW0a+vIXCnH8JA1fAaalULYHKI17fsb1pPNHy13SohCSMHmp7KNsVlsuS0fL2iCeMK8hdEpHc=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3029:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;20:4SCQ56BnEVJ+AXS3enwWIwhzsru1ClyjDEBJVINTo6fM7mOzF1pRbD/UkBSZ9X9/4hCm2Bwphe3dqRRBOUAEeXPlGJIQbaZn9JEBcmYUXFzoLASKgvAFCwL3CaP6u0t7moeWwGVta0VzxFwQbwI2kACGmhHL+EJksKiCZMDCPG9hiivC58rdmMBL1CMt2nYoFqv50wnjKDUx0/FYjwgxugW1J3O6UrNqTN3S1tozpvNBK4ckd2gpHffmYYG06zqT;4:jR8l5i5izGC3ehbEUsTJ8esEukNf+CHyJduxploDyfd3IJyERzZ1wX8UInryFXEhbJnA2SFIXyFrt8jUuZyd+L+pNlPDFMdwFkWCNVRpkD96X6S1g8WHYyJ5E1LHGOaA0lnYzdsNT8siASXRMCnEz7gkRucoi+UDp2IsUjSxC5dk+c3KuT42utBtjQnSnNiusiore5ufllobmUEajUkugAGUPuzcmvOL+1jEIQS0DFaMc8iFYw/FnS8SS7BkOfAO36XWkYdJMOcORFIJ99C6BUHkIHMrHZN1NRoeXtjL93R/zz0VrmZpyBZNjKAlBdHd
X-Microsoft-Antispam-PRVS: <AM6PR08MB302965BCC5B771CB4C2B6B81E4930@AM6PR08MB3029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3029;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3029;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(3846002)(16526019)(68736007)(53936002)(5660300001)(6306002)(8936002)(2906002)(50226002)(86362001)(76176011)(575784001)(52116002)(26005)(7696005)(51416003)(6116002)(386003)(446003)(2616005)(316002)(476003)(16586007)(81156014)(106356001)(105586002)(97736004)(81166006)(6666003)(11346002)(956004)(486006)(478600001)(966005)(50466002)(6486002)(305945005)(48376002)(4326008)(7736002)(25786009)(47776003)(66066001)(36756003)(72206003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3029;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3029;23:XdqoWu+MR8Hr16DojUS6xRQTfLPQOHdKtjOsVzWw4?=
 =?us-ascii?Q?a28/N7n5hKeQv72vGTp1/uly7NQL+MJhTRkW65Ptu2vtizFK324HYzRj5fUw?=
 =?us-ascii?Q?VqjG4Qp6WgEvDM7M+WFD3rxZSt1ZP32e9YS/du7sBqtgdRtEw146Tv9nWvbb?=
 =?us-ascii?Q?S400KaUGyIEcMSJUUkaZZMJgHjYFZywnSNHVO5aW96wpmmOEgAkk+ejetTD9?=
 =?us-ascii?Q?gfjqMprrBoW82fsd57FhYoRgFrSe6ol5zlK+CGd9X7eLg2wSMwCPENequkXL?=
 =?us-ascii?Q?0tFW4jdv/5yF+5A8t2mxZBVnMHJLm58K/vZkbGvM2mvzpFeAtTsKcyR5WFgd?=
 =?us-ascii?Q?ab8NE32hWROXRVw4kw4kIQlX+FH2zsVpdCkLL9sY3sUcTdlGCpD2OXM9I0mE?=
 =?us-ascii?Q?Qg0zUVH/s7b0MTUJrfxCauKteBKrypjRFcDB1XQtFlN0dLs3Qctu1y+8ObVM?=
 =?us-ascii?Q?4kSK7jWcz8RgdPRSxJ3J50QP/aIbV9ccDSx//wyaZsGJKJpnz3L+BYXyRQKj?=
 =?us-ascii?Q?VBvXm3jp6wT3BHL7P/QwVi2Z6729Lnj1HO2W3Ul6QjgIb4bIA8NFtNcYXmLp?=
 =?us-ascii?Q?yVIkbfS4PSZonJc3VCk0ciNy+9o0mB6rX6KUmS6APCB1++brV5S1Y1NAjTJn?=
 =?us-ascii?Q?+x3Bw1Uyvd+ATkn6NROc/d8kmCwg3HUu8HiTIaQuKPkuGTra1pvuqoH6UchT?=
 =?us-ascii?Q?7K+LDhPsw5GHXFh4eJYEuoXM7Ny0qg/A9r+jmHO6fDzybf3dvoLUoQEds11a?=
 =?us-ascii?Q?nQES5eO0vkviueZuAZVqxGTJ9H0/AAQxttncCT5iNnbBuqzEe28WJmpvk69w?=
 =?us-ascii?Q?RNl48z7jHkPgQvfq9OS0uomvrJ9F2IrpCz7N9LV/xjWMGGoDepgFauLzblMN?=
 =?us-ascii?Q?n4nE+p1wsRJ1Fih5k/f+3ePKXrAANE5Z/u3ONo3u7yDXVjpx+4+oX03cBCbN?=
 =?us-ascii?Q?KRW+T9KCUA0OqoK6RWmdGp8Sa0WjccloBezvygnZ63HcSDBQ5+UnpNR1g6Ze?=
 =?us-ascii?Q?Ryea5mjro14LiMhGwavs4JYPFNT+QjCHkE8ZaXEwC9uc9Nx6AJJ/FGDzNxZm?=
 =?us-ascii?Q?o4aND5qJqO7sAXKuSLePGFWXZfMl22AxKENnwgUzhtrwJE+KKKT3CyrYf740?=
 =?us-ascii?Q?mf4PxgzITS8hHyiWtzcOCa4nrHghQk1PgQONRwG5t+6YzOM+Hw+DMcCl7oar?=
 =?us-ascii?Q?9ebBNDA+rycNPC3C2l2VrUJbPIdLguvSvsn?=
X-Microsoft-Antispam-Message-Info: LyPVzxip/API2jEa0oEBeivv4Hdo1pvcE6a/fQ4mEBRWF9g8KeMNWO0mPcy9Euk9twWRWOpfCaZr3ZG7TRdqcIoMWpB8sezXaAFo0iIO5eXLSZ6LrC3m7dtTAgy+ikfDKeXxc9bnSHnc1PDw18h2OEyI2W24+qc8A6wRN+FEOHr3Ye6uUg/d93/qCsMJLB/Y
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;6:jqlXDTc618T0t/ll6hBI3evP51v3WS5pGr15TmzNISBpeenqvm3h13B0dI63PKP4vbpSgMdmF1slGXMtSF3AgyPm87xYnSPmnR+TEjPW4ScauiRXOwk0Z/nCvlJsc8YnHfPDrIuJ52FTN6WrxSR/ENdjeVeY0q2aIoyw+7AUBLiZf+FWwpn57ntBCELsarJxpBvOUqz678hk0U53jug/fsXN86cUdri19BejthIY5fPVGK1wzN/w4KpXxI/Z5QseWKOhkeb22kKh1DcRibzOSLuJfJoDcpYBm759UtoLoQtGkD+n3eREqt75OLgxyBQTZH2tGR06mLmfOZxoF/ZpP1e+5kerlLjJ0El1kXFIlyUmTO/GFhgV05i7+A97YfINv5URyfu5K48TCuzRvDYNFPidgJY1VKIWsoZMede8oA2n3oO9A3z8b3hdbA46NiyQpy2lYIIzB1nWXHbsdYoU1g==;5:EgO6HZiP+/VZ11XZnR8MAcECidLBAN8i+hM5yfERonvJ+8RgoEsi+jXZx6ddtOwNoHLUjk3384lIkJFxP9x+I8hCRDvGaPDV0f8zVhzyZgS5/nmsJS3bKZtI34vszfGsutOQN6/op4+A0inN5FZ8j4zeevAkg/pOtnOekb/0G0E=;24:P25XTTi4kKCXuctHvjE2KEmPHdIpfBSIKwXB2sB8QntI6jXCvD2iriIuoqOFSC12T60w8DM33uOQpnEaQk3qkM6zd7NwrymrHZzBVkiDsY0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;7:7X3299XbDgVDC4TGc933NFoq0NovBqhz5+OHnJaezE37EWc6UGQ5m0ikhNyyBODt8i0hAEN7oLyYsyxuuz5a8jqtUjZl5GLdt+rmwdJm4tRLLDZyF+iLAxCeKa/9KsPRbyAp25UJiGUOBknuBCTf47jRTLGO55wfKlen3EpHuaiEwqwJuyFJM0T3LqYYFF97/JLa712VhaRLh4HUrFQc2CIK9GR5Jyy10vvG0zOUARBFmIp1Rbd+/fEqpJ+vE69p
X-MS-Office365-Filtering-Correlation-Id: 8c467427-a621-4fa5-ef39-08d5ba7d8b65
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 16:04:31.3153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c467427-a621-4fa5-ef39-08d5ba7d8b65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Malidp uses two interrupts ie 1. se_irq - used for memory writeback. 
 and 2. de_irq - used for display output.
'struct drm_device' is being replaced with 'struct malidp_hw_device'
as the function argument. The reason being the dependency of
malidp_de_irq_fini on 'struct drm_device' needs to be removed so as to
enable it to call from functions which receives 'struct malidp_hw_device'
as argument. Furthermore, there is no way to retrieve 'struct drm_device'
from 'struct malidp_hw_device'.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v3:-
- Squashed https://patchwork.kernel.org/patch/10357201/ and 
https://patchwork.kernel.org/patch/10308283/ into a single commit.
The reason being that although the two functions belong to different units
of malidp (ie scaling engine and display engine), the intent for modifying 
the prototype of these functions remain the same.

Changes in v2:-
- Removed the change id and modified the commit messages
---
 drivers/gpu/drm/arm/malidp_drv.c | 13 ++++++++-----
 drivers/gpu/drm/arm/malidp_hw.c  | 10 ++--------
 drivers/gpu/drm/arm/malidp_hw.h  |  4 ++--
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 4b0c4b4..f7a8beb 100644
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
 
@@ -651,8 +653,8 @@ static int malidp_bind(struct device *dev)
 fbdev_fail:
 	pm_runtime_get_sync(dev);
 vblank_fail:
-	malidp_se_irq_fini(drm);
-	malidp_de_irq_fini(drm);
+	malidp_se_irq_fini(hwdev);
+	malidp_de_irq_fini(hwdev);
 	drm->irq_enabled = false;
 irq_init_fail:
 	component_unbind_all(dev, drm);
@@ -681,14 +683,15 @@ static void malidp_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
+	struct malidp_hw_device *hwdev = malidp->dev;
 
 	drm_dev_unregister(drm);
 	drm_fb_cma_fbdev_fini(drm);
 	drm_kms_helper_poll_fini(drm);
 	pm_runtime_get_sync(dev);
 	drm_crtc_vblank_off(&malidp->crtc);
-	malidp_se_irq_fini(drm);
-	malidp_de_irq_fini(drm);
+	malidp_se_irq_fini(hwdev);
+	malidp_de_irq_fini(hwdev);
 	drm->irq_enabled = false;
 	component_unbind_all(dev, drm);
 	of_node_put(malidp->crtc.port);
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index e4d9ebc..8fb02f3 100644
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
@@ -973,11 +970,8 @@ int malidp_se_irq_init(struct drm_device *drm, int irq)
 	return 0;
 }
 
-void malidp_se_irq_fini(struct drm_device *drm)
+void malidp_se_irq_fini(struct malidp_hw_device *hwdev)
 {
-	struct malidp_drm *malidp = drm->dev_private;
-	struct malidp_hw_device *hwdev = malidp->dev;
-
 	malidp_hw_disable_irq(hwdev, MALIDP_SE_BLOCK,
 			      hwdev->hw->map.se_irq_map.irq_mask);
 }
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index a242e97..6607aba 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -297,9 +297,9 @@ static inline void malidp_hw_enable_irq(struct malidp_hw_device *hwdev,
 }
 
 int malidp_de_irq_init(struct drm_device *drm, int irq);
-void malidp_de_irq_fini(struct drm_device *drm);
+void malidp_de_irq_fini(struct malidp_hw_device *hwdev);
 int malidp_se_irq_init(struct drm_device *drm, int irq);
-void malidp_se_irq_fini(struct drm_device *drm);
+void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
 
 u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
 			   u8 layer_id, u32 format);
-- 
2.7.4
