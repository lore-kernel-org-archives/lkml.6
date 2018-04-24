Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeDXSNQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:13:16 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:51605
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752075AbeDXSNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:13:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 1/5] drm/arm/malidp: Modified the prototype of malidp irq de-initializers
Date: Tue, 24 Apr 2018 19:12:43 +0100
Message-Id: <1524593567-5559-2-git-send-email-ayan.halder@arm.com>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;3:DV6Pip5ym7qaHtnFPk+dwNqBt//cxCIZcO9u9pSzgk2ya8PUNSEsW7jBI6xZwbrcRb+VTErFNn2/gGQ9zLf3xlmyyocbECqTeUy7IZTucuESqBnUy2N0iT2vrLt2mVNEJLwwVzgsvk8lq9hj6EJ0wZVr3ivj/2PLh3OT35WWEZCR+0A359W8qEhThgxpPcw0nR5PMqyxEdFD4//OvUB2FN5CS8xfaiAZFsDXwM+yGZlXiwDhBxxEQ+4tDURPzRX3;25:UT1cS2ru/8KqQRyxPYk4KrR6lqjVhftwzrmMixd+uzmLf8u037yqw6ChnbagYEhNaGh7w5qO//MIjqc4B4rGo52iva8y1OExQWbb9AGsthog7tdzFRTxCKJFnb7l/MNxztxNzadgw7ozDMNXfj9g2iBllEGv+nWJui1LZGEZGAk5rC4Nu28E7q+o8SmvnaQqVvlaIPCqzJKD7w4eyaJVh7M9NQeWSSDX8vTRtqbYZiLpTc+4VyRCq8c4QNvL4AlMbp5BcdhUJnM/0MDJAnGpZ55sZBy1gaOhZ1hCEIsLOFyEvWsRORk//nQTn5EiZOx0BPzfi/kKSuvxzM+Ao2cQgg==;31:5kTHoOf9Bzzj+eGF5aqWIfgRtc1ccesNLTTtBukQ8m7RtIBcHciO4wpgI0EHLioFQR/E8sDcSZdLN4LuyCdTJl3F2KBNvpDHU93r6KzdEKVsCFDrOcvvhfxKn6HnPmApJQsPRKQNRqjTeq7Iw3xnpxehyGnwN/f6gPeAG3EJusRsUFL54NvReb4yoddVcZTrBjXKc5Zr/MZI0J76TJigghgKzNSASiRRuhnG00Vwv/w=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3037:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;20:1INhXmfB574em4xztOJwDhUTxlfEfN5ycbQDgFNyahQQGfWgZDdYW0X1x7e+1i1nvh6jgXQj/U7+/QkHm9inVjr/lIChgbxfRSiiTQcPn7W8hEs6I2o1ypnBKkcKMTh0/yvlkYOn0hb+8yiUYlZra7Rlt93HZ/YZWo6nK9xfc5zUjmHIxVhdaXVGgR58PYQ0ezfYI55UQxg5jHrrYBUcNQfaNOI7Dw2HI25Hu2GKFbs9jcu3fZrgHU1OQj5xAJ/2;4:ccCnl9JfAykvwGqLtsc96K+g1NY/1UiO/rd2z+ne17IaqVmw+N0Ns4KuJCob5i6wQG/H1a7sfsJnvIJOvn3BFfhYTI1Rlp584650NqYk+klqydeU+3hc+Ffjl6mS7KA/c2LVZdiQ606PW9EUQq1DZav70zbbcEMw6fyjKecI28wspHRzs/TzMyGeBSRbOKfcYR03atP2vAydScz7PRR76+WgaiCu7ziRmgW2Fi24ysanyAljQQnYRqxZuW+e03RGsA364CAYs9syHPRzT+t5sItRLSLg2m1o/vOvNttlE23RYQI6czfhCUZUlVp3tEgC
X-Microsoft-Antispam-PRVS: <VI1PR08MB3037269B6EB34A88CB5B0D50E4880@VI1PR08MB3037.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3037;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3037;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(189003)(199004)(316002)(6666003)(51416003)(575784001)(6116002)(53936002)(3846002)(97736004)(6486002)(486006)(66066001)(2906002)(76176011)(36756003)(25786009)(86362001)(72206003)(478600001)(105586002)(8936002)(26005)(8676002)(966005)(956004)(476003)(47776003)(48376002)(7736002)(305945005)(81156014)(7696005)(68736007)(81166006)(386003)(52116002)(106356001)(6306002)(50226002)(446003)(16586007)(50466002)(16526019)(4326008)(11346002)(2616005)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3037;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3037;23:+SwAz2PaWZ/Ib0c0nQOgqwmZyqIesyP4DtF/3tOYl?=
 =?us-ascii?Q?A+JLjLXszOoeWUrfQEUo8XOwRIOVQG3Jel0uQoqhyKXuoKa9WA9tUVkyw1L6?=
 =?us-ascii?Q?HSpSr8gn+y1/eGjLbi7lMITRqywsYEBhr7lfgP09C7HWUmLBHRgEt+MRo3hb?=
 =?us-ascii?Q?znqmVec+h0aU+SohutrR9x4TVAIQlOktxCcnEpkHSB6qJ/b5/DKzMuhr4xQD?=
 =?us-ascii?Q?9a8UkhXvwcYX1Zs5hJBHucEde/+RbLNVodnugJJPsFq81Rbiqn4XYoHYEgX6?=
 =?us-ascii?Q?4OHGP+6RD1aYSlhiwsQRD1Ug4gVxdG5wFczfT6Za2FI2yXpvNuplwzbbekMP?=
 =?us-ascii?Q?AXp8t7L7G6Y/Y/UEGVtkmIJKBmsxxR5Lw4EK1FSrVa5eO+SlD6ArqHdTE3iZ?=
 =?us-ascii?Q?9VF8/k3dy4p+Nx4E+gA8QkDoly0El9p6mlOvbWkxNdx1HPpu9ytS6edNKMfG?=
 =?us-ascii?Q?mmzeT38FSSY1OFAKAHMHxjZNvCeTwowhQRLFwzoYwFAg7lRqAdvqL4pktkgU?=
 =?us-ascii?Q?75RVYJ2FGDWD9/WuOhXzhuUySpqRlHMneN/fpCXx4MNibiQzJOhuWV1i6deF?=
 =?us-ascii?Q?0hM5ITe2JsZRHxpRWWMkrbEO8Bxx4nNJA9ZSoqHQEZ5VPDTwAnPaoH2vmsvZ?=
 =?us-ascii?Q?cePMBDkI3IcgSIeJqc++HiHs4RMd4/q+AebzaFzOgwHk6vFrP8UEvDIig4cw?=
 =?us-ascii?Q?ppJ27RNYQkCRA08TCJWG1Ii70M2eosEjC9F+p574fp2jTXRyaJAYHLMJvtTS?=
 =?us-ascii?Q?hCJBWN/T4CP7c1IfoV1V8+kuwJxA82H/Oe4VoFL+PKv4mx+wFHQECp/Mu1kf?=
 =?us-ascii?Q?E3USHrnDms7eZlkcfO7fRhdgM2asgsnTtSke+Ipso5o2UgONDtnRwj14iXFM?=
 =?us-ascii?Q?UZUfR1HcGhSPK56F0ocAEz1XSfNbpVeXLRymPFGgNvuetn0PlTWp0xzuNlQN?=
 =?us-ascii?Q?rUdZQpo6DrDvR4Mt41FYy95dXe1aA7WouKe01yihtxEABYVLNFRLe6htZ0Wp?=
 =?us-ascii?Q?0R/++xFVgyri3kR0VEuwQ0mh88RABamGhAdiZrwvwrcuIy1mVyH9AlBFnV/H?=
 =?us-ascii?Q?jJEULRCYcQElRmYew6UIk4ubd3TwnAD/adeCSgqryUiCpqZRV2RFyuMTcWTV?=
 =?us-ascii?Q?AjbX0T9lNci53lr/5E4SVMzNMYfeFhdDUUtlrEBEMV40jHO576f1UrVyt0V+?=
 =?us-ascii?Q?59XSszPuuyGS2nbfleYOQYVBiMEy4zk7QOS?=
X-Microsoft-Antispam-Message-Info: E0Kfkbv11n6zWXJJqlYUZilny0omtt2OrdloURTaC8Prl95JfbHdU36Q6ziVzsGaJ7GNS+O0hA3Hb388as6jqc3zbM3Bx9iqGRhipRVZxyFCmPja5XWaX1t76fAuPsr8yLiaw4lA33mell0F0xTVuR571qgaCtvqbzv5PENFsWUFarinF2NFkpLb5Gf6lpbA
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;6:c0rCbXJM5gXbS1Ln6M6yte5mYAMuUT+ZFtNsGBwSU35Fk+4ktNE1K7GY3t3wqjvo2oXE3u1ttQairo6nGfePBI0/y5LuLSRDra9Ici7+hd+Y+wobwE7sM7P2OPZ2OI/ZzH+YqVzdi4Cyvet2MLWssnWuljVcUO6eYtWQbl5emNP0VSAQqHDRBQhenj6M2y7+yARWH148ztkSULVXbNMwmZNsDAd8U3vFf+ijaRHeVMzIbLSxI5QW7nLz2E+YIfp4wemCRdcN5g+OK0W3OL5wKuMOUswQqDUqYBDIIvh/nnRo1UoLgphNbLbFEmtn73fXw5p2J+87cgre17i8jIsrtuuEahDdj5MQzzF4rUUbrWv0KTQDCTwHAb4G0v6pE5Vk36BgpHXUk+9lqvmzFMn/XcSXMVV2GD5MoNBV9lW5dJmM6dUm/C4Rw6NU74uQ7zVxnj8tH+x9QZkl/MYECAj+qQ==;5:KuquR063JIzdGDQequgpg5M04udTwVGXyzRcJ/xH8NprApOr3x21yDEOe0pOHI/UC9I92krA/B+nN1z/mj5FvIal5CJAKOYhfOggnT3WZz3e6BqBC25rM/gS6tgd8sYhvhO2qkJytk4SMSuv9QTRj51f2EhNVz/iJMwLIjaIMu4=;24:9oy+5qZPkJUW4xKPIpAsQH979lnykloc5+oKGyPeQ362BqysIXmNtevfbIY1oGbWsestZx9tzvRiIQT1mV3kDBzelfcvWxYPasXKLEB8czQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;7:4SEn1KIKvJnvTFegoFX+o2q4QMoeMfdyJVW3Afz9DrohFf/noh5PEsLq7ZoP8/POuzpqqGm50Ssu/tiK4ZVFO/J6C9yZQtviX40aqEpptKyV/mm44xu85b6SFh/hLnovv7RbKIxhfVR4E6o039NFPfqJSKEwCjZ52N1FgUcofnCq2QQhJf0eIYVk8CvxNLpQs+CV7JHlnkjc+Z1rgT4ctLj3Si+S7xcWMF0weT1/+9hzA+xMAOKHxbBa4BoBsQ+I
X-MS-Office365-Filtering-Correlation-Id: 03f0ee08-2eb0-441e-564f-08d5aa0f077c
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 18:13:06.6176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f0ee08-2eb0-441e-564f-08d5aa0f077c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3037
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
