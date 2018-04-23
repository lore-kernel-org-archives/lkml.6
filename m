Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbeDWOvN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:51:13 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755474AbeDWOvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:08 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 2/8] drm/arm/malidp: Modified the prototype of malidp_se_irq_fini
Date: Mon, 23 Apr 2018 15:50:45 +0100
Message-Id: <1524495051-3891-3-git-send-email-ayan.halder@arm.com>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:pfKZfXGnWm8RaTFPbo3gXci0+rPG0CduD0fdee7yts83qHzrMQPvPWiupnPRHGKoXJhnvWD7MYheRVsTjpnIb0/ILaJ1M8h2/vGYwcOchncOsC35I3075QJ9mk3ycfYRjdtlEAjKGROiBlEt+V/39sBpAEqv3vyo4b1Y1jaE88aePCO3hIfqbte+NAu2vvQknBkzft8mBqtN4IYbeu9GT5Z7QPn5mHazKk/jxfC85167+r1aWYpdunkdeymSSrQw;25:vuzWKggiFY/gFl6Rjp5PFPwhsZPyL8OGkWjs115j5H3YObp/xiQXEcmQQdC3cfh/1AncxQg9GQmb4rGtvvvQC6c3gGApdegImyXElEpkyTnUDTFhHjaUUJTw048A/BSsBArLktZmSZNrLWmhoUifZGimIsWE6YMVNgvL4GHmdSWyNN1bQBC714O029LMZghppaQjR0Ezc+YPe1HLu9fTiVFx2gwxVMiN2QlOuaVpfcu2j4haSuvS1KehmCPXo3BU+W1c2LP8Soaje4xPAo/Gr0p6rW/EX0f4syiOx60UqLd//topLedpxZLIWkpuIsSUG9aWPK65bJ/8DuVQCMdM5Q==;31:lh7+btMo06eB43+6ixR1jqwX69CR4QVmlkPYP7JJdeOzI4aoRYxF2xw2ZfnHmLhHmVDCLR/XDyZCQ44GumUiOygKwPM6PqWhgYHPPtacxZ7/MPjDiODIv6KxxeBk3xgDAN9CUZboaTI5iaN7Bkn7Rpgz8cj9mgqhdql2MTBbse3FnIwB0dYCQQhkQ2TR19u/j7sZMyG9gvWG2l5xEFajTwyingi270SG0bil33yB8ng=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:AvJ5PBwDsZPR66LN3nC7nbO0K6gY6kWRXmWIMXAJeHo4SDI6gwhNSJ0IVNvOlsbEtsgvChKHgTIlnItnXQRJlFRGKREMZtK2vafYtUftOp28GHhwrd17GifwH2W9xuv/udZVdqaJqHc8whyg7XgIWj5j6+7aQvD+lJKPTpFBjzppxBR0PEDn+wh9r6s27KlmIqDIzLe5dNaAsuSDBE7/UJUd4y5xOVLFEmGbqC5NCPTla+f+Yn8h8btUlt2iAt3m;4:3SLX2PqtE/5m+QlXBH7mzQfNaZlhJ6+U8kn2BdpQ/sCV1AmKvIdTU5QUTabuS8ApmdJYAZ8pxN5JofbIUxQqUgTy7RTNZWqA4SqYwdb1cPfcT/Ly459QgfsJGurl3DuzjZp8IJ3UClm/It6KSKPI0QIQBQKQ6L1KOhZrDdXESwAmsofHkBuFptKxJN24iHZ7ll9q+ImRP+Q9TNmjTLzDUYwvnGmQs6GYhyh+WQ8ibqgU5AHUD4YQZron4IMSQt8TOOZmhwzl1OiKdDJcC5lq4jK140XQ3CI+F16qP1zPQ+YQCJmC5n00Tqu86FISXpiQ
X-Microsoft-Antispam-PRVS: <VI1PR08MB3039DE3BCD04251A56643A08E4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(446003)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(76176011)(316002)(4326008)(386003)(25786009)(72206003)(86362001)(6666003)(7696005)(11346002)(6486002)(2906002)(8936002)(50226002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3039;23:lG4Tr+VDKsBviAQrOIy/KhkL/3C68dTbZizdSim8G?=
 =?us-ascii?Q?VG+xcs6KZmL+rR+DDqNwFNjJkPHZxTgQahe/TTJusW6wKJrmof6+sY/q2pqi?=
 =?us-ascii?Q?V0GMxzQT82cNtntMR+x0fvA9MJ4EEEBxCZTrGFyB2NJY0gYHF115Ok7VvrLy?=
 =?us-ascii?Q?ZKwzqBZ7VD6MIYio9K+H0t449EgdZYU7qsrTo1HSUUUqUjq6Rhj61qu0YkoS?=
 =?us-ascii?Q?tGojaY0TGFDYLpUDO23JNf1tZCfQMml5AbYvIMJBpVruomVpPUuljyYhCtce?=
 =?us-ascii?Q?uQnQvZgfk97uk41AHVnwG58Y3nFZXgSP4XxgkkdIl4oXS+VRclazxbgwlUuK?=
 =?us-ascii?Q?4vQhJLxQqatJZtmEDvuSiVi77S3IzAimQa8wtHvup1asWVINuvCvWcpHbJ24?=
 =?us-ascii?Q?+im49xDIBR1RvePjCX0p5wUmYuuhybIITkK4OYn/v14CWmIxOAraYiZRiLKe?=
 =?us-ascii?Q?SP18T1CPTIVi+dyZOJxDDK7Z/OOsR+iLEwAVouvUTpN3QQ50ggaPY2AT6oOb?=
 =?us-ascii?Q?wAk9ihN7A+m2eQbi7Acf3kmNtsGxp0EOaqz3CbYZWePQbQMLPDpFjczIwsgW?=
 =?us-ascii?Q?APOUHT78X8pq4CP/nAKjWm5wobVCZBD8ZXKOKprdvOanJ+lphJXvG/O2rNZv?=
 =?us-ascii?Q?uuJZsIZiACb04TZpHpm5EPqALC7lPUt69L9nCYIgP7TQaw6dDsKEweSPAIT9?=
 =?us-ascii?Q?0nlojSECNaogrrPM6r7kXaVkVUf0n+am/g84MffR1Y5p52F0Rvl9El2xPNqG?=
 =?us-ascii?Q?qWhfTy3BaevG93OcvGJfS3SPLQZG29r8Mas2e1/K7Wgco6xf8LLtuIcKMnyv?=
 =?us-ascii?Q?PpCAs71hDvXL9V10fHklbAynVvR9HWyul1nuNFMduo/L+6C/j1LRiJZHZdCk?=
 =?us-ascii?Q?mu7cXHxznZGw2M69nrCox0b6MIQwaOe0XmJrnVYDLaLhnzAIv06QxzUNuE5n?=
 =?us-ascii?Q?8gZzdobAONnMjMLUHTpWPmIJz0vC+FPyQxCB8c2WA=3D=3D?=
X-Microsoft-Antispam-Message-Info: RDgX1naB/kxnMnetW2XFUsB4M01cDohujf97AkwZ61X+IIezkEbzHB4nNPoXbNwkN8q51WTwGqdY/R+bp0FrCJ52f5MmHhaUHKIgsUAbaEviryqUvNHAUKZJZwsm26YE6kLDqz0W+DbJmioAtde3fh+v9xYWDq1b3bU9dw1CseBtRUY0vBo+7LlBv7RdLXQJ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:a53EMSUBC1PChryxChnRJIIIDGR15Y6rnAlKReREWjHARrNFEw00kWKxeCGTJwf164AENI6aWwkLt6aQ01cL+AhdTjCAiinfvI5qrjCl8IM2OoUjgDoXJH5cnrO1JZBHjt7OMRGVB0IXPltNc9tH1RCMcvUbQTYmOQBxl/Ze9FkySxop2OJUzU0VJUXSZ8ASkrkR80qCL4ANd+6TgUroQi8yFznqhgTG5T/7qhKViKky29hZ+lmhMI/hchywGUpY7w/hnr/0VGkUe75zok17QEvt3BExw4vtFxDGZaiQT/LdCOyAZsItrCMVMAH0rOUaIXzsN+NZvlNCvrEnaUHZmEdENrSjaWt6sNYGKGsIgl2/iD7TiCDlmmLU4BOAA8wSIP+FJbYIhpcYizJjaaVzLC9OfiSieoV/g1N3loTHFBpQVc5c+8Ngr2Srp9VItavWFx7/Zlt151JFhuG2SbTOsQ==;5:N3g43gl1UpERCJM90ahxogmcxB5z35VTFitt1+VmCgq2Us9jbg1128DavnEKXoTGqqx+AVyT4NkizEoWMgL69qi+uhfBgo1w+RZaiUz+Z+e7NsO7QCoHh6OJ06PdryEwktIu3oQyoyWSKnYKa+K092jiX61xidWFisWZzonrBg0=;24:HT2ZJHgqwkYQgQtU/9e2UrwOybb2QDUm9u4gr2lA2knv6OTqgW60+7HxvLVraFZFXK12xXWdVWfadwRzAXJ6qjNCAdck2YkC0DaNZqU3ia4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:o3D5EMJZNrmyOfXbFAafzBlGojukc3vZet/inUKZN71gPx2kmjjSCPRWNlskfE/wvrZuh1JgDo2akixEb/Gr1f+ZawaI2ZEd/2gPhw/YPWufwaJLVsdUznMf8vhEZYUlEZ/rJdlRp3JU6Xl+ZFem1J2fAykRMnOoYh+IJ5XxTKzit1KNS50gI1Tz8dhMvbADrTUh2DmxjglJ/0b1rYQRuUjJUmJKFdPBqL2XswKnuCRxJdezGkFsNLhpnZuD0uxt
X-MS-Office365-Filtering-Correlation-Id: b40e4ffe-3cf9-4968-3353-08d5a929a403
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:51:04.9625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40e4ffe-3cf9-4968-3353-08d5a929a403
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct drm_device' is being replaced with 'struct malidp_hw_device'
as the function argument.The reason being the dependency of
malidp_se_irq_fini on 'struct drm_device' needs to be removed so as to
enable it to call from functions which receives 'struct malidp_hw_device'
as argument. Furthermore, there is no way to retrieve 'struct drm_device'
from 'struct malidp_hw_device'

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v2:-
- Removed the change id
---
 drivers/gpu/drm/arm/malidp_drv.c | 4 ++--
 drivers/gpu/drm/arm/malidp_hw.c  | 5 +----
 drivers/gpu/drm/arm/malidp_hw.h  | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index ed38ba9..f7a8beb 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -653,7 +653,7 @@ static int malidp_bind(struct device *dev)
 fbdev_fail:
 	pm_runtime_get_sync(dev);
 vblank_fail:
-	malidp_se_irq_fini(drm);
+	malidp_se_irq_fini(hwdev);
 	malidp_de_irq_fini(hwdev);
 	drm->irq_enabled = false;
 irq_init_fail:
@@ -690,7 +690,7 @@ static void malidp_unbind(struct device *dev)
 	drm_kms_helper_poll_fini(drm);
 	pm_runtime_get_sync(dev);
 	drm_crtc_vblank_off(&malidp->crtc);
-	malidp_se_irq_fini(drm);
+	malidp_se_irq_fini(hwdev);
 	malidp_de_irq_fini(hwdev);
 	drm->irq_enabled = false;
 	component_unbind_all(dev, drm);
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index b13dfac..8fb02f3 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -970,11 +970,8 @@ int malidp_se_irq_init(struct drm_device *drm, int irq)
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
index 6e2a2f6..6607aba 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -299,7 +299,7 @@ static inline void malidp_hw_enable_irq(struct malidp_hw_device *hwdev,
 int malidp_de_irq_init(struct drm_device *drm, int irq);
 void malidp_de_irq_fini(struct malidp_hw_device *hwdev);
 int malidp_se_irq_init(struct drm_device *drm, int irq);
-void malidp_se_irq_fini(struct drm_device *drm);
+void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
 
 u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
 			   u8 layer_id, u32 format);
-- 
2.7.4
