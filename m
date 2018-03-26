Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeCZHfR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:35:17 -0400
Received: from mail-eopbgr20131.outbound.protection.outlook.com ([40.107.2.131]:56367
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751074AbeCZHfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:35:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Takashi Iwai <tiwai@suse.com>, Egbert Eich <eich@suse.de>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/atmel-hlcdc: add command line option to specify preferred depth
Date: Mon, 26 Mar 2018 09:35:02 +0200
Message-Id: <20180326073502.19259-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0009.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::19) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7d360e3-875e-470b-36d4-08d592ec1c69
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:dBiYls2ndS/GMJs2j3TN6sw6mMijMeLZf9EcL8OJO/k/FK93+LR8oGLAQtzmjwo813LACYqTiFbOAFdD6b2StuUvgVv2veyRnQszutLAiKbIGs89IHCCPkd5HhQ6KMYCY66B5QFrQ96RLBGqhinnkS4nGcUNkFQL32X1Y8BI1jbWxj7sgfgIZF26S5BOJ2GJcWh6gGh69a3ZvDaGCLGHCVGdIL2jU6rH+KjM1IuFtGomJ/5DFJSnB/BsnNYEAR8H;25:r8C2VwvGancmGld6yFhrwtl9fzADGtKHAWQkm9/MekdrkmFTirQYe4bM/0gLPum24L8HOTEHUFzECJkATC9XDvrWCkjljaQQqY5T3gChCKEyHd6ZsRUK57daWQvtuebsJ3Txe/WvPt91QHYHpmMEOSfZ7AiKSv8aIGDmlwKWgLdvIGbgfKXNfVSV826GjPDajXQZE56cjfrc4A2dkWiomg4v5BRGZlzHeA3JgYtgHdIPwaqb4ad7l6fPGuhUYzMu5hjW2K8XqmiRmVH1WvSKx7gdNrPLTJYE1bMuIxtK2Ld5zEU+B88UbqUV5v+kVsNmQx1C6OUdAR697RjPmTUJvw==;31:RfsQNM/+j1pV3mCYdqh9AjwcHGHtlskBuNm3NttWmVMOmzk9Lxy59bLvSvDxo2U54NGsHQH7roDYxBCPjPHkSTmEp2ksbN7RiV73/ysfK+v2G6424f7IH3IavpE4cZXow3FKnCqYP2SJc5mctPjGYyA12iKf/zqxmM8ljUGH04a44Xkr1GPFEFTUxwdpn+OW0T0OCyi15dyn8zeYLo64hCm2gVK3gxIB+gmmnFKBUrs=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27754DE5A159999A776D6664BCAD0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:yD8hj0UDF3mfFqARV6c7DS10LlW7yXFZaDTGsGARqNihzzTM7xKuU5dxFz6l6hsAPtF9CH5+V6IWgyZoNtSBONZDGSQ8UAIFWXnIdNmHwjIpnz99bp8mqHyovTJuu1Hgrhj2bXMaFBC2D5HaVVD0AbIDCjw25sbuTp7WJY4BRc39P169sLvzhAtiZ/BtL9KvT8J3SC9HORdBZsO4jkDELl19meFx+7oAw3RLBjUc640VFQw4wORxlegFdj3Cbuoa+zraRu9c0nsj/sPy5iQmnw==
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(39830400003)(396003)(189003)(199004)(5660300001)(8936002)(74482002)(305945005)(36756003)(2906002)(6512007)(6916009)(6306002)(6666003)(50226002)(966005)(6486002)(2616005)(25786009)(956004)(53936002)(81156014)(81166006)(97736004)(8676002)(4326008)(68736007)(26005)(2361001)(16586007)(2351001)(54906003)(1857600001)(7736002)(186003)(316002)(106356001)(86362001)(478600001)(1076002)(6116002)(3846002)(105586002)(16526019)(51416003)(52116002)(50466002)(66066001)(386003)(6506007)(47776003)(59450400001)(48376002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2775;23:egQOB0spNL4Uf39+s+mcy/+PQtkG9mzQO4dpQIf?=
 =?us-ascii?Q?bVWJH4yeb3Ghl27RMC2zhA62oIIXKAQ85BUjUbiXYPLQROx9OXnFFAOzI5+c?=
 =?us-ascii?Q?tS/i+p75STUAb/otE9B/aFGSvigYQM4dPPSzsnAEfnsM4WrojRWKw0sSws6e?=
 =?us-ascii?Q?SmCqW2Xvt/HZyHggJ2ghGMbEY3nXoGU1+r1r/wzXWs3yuWPff/BrVChDOYrX?=
 =?us-ascii?Q?HERyraqWuBn9Y+2fbqMT9Dm3rXOJNvV8aW/WJ3NNsoS+vx9XxJgFzLsoUp/J?=
 =?us-ascii?Q?HTfzXqyifKIZt8/3jni1koSedZKvaUnJnIeBOE0QpBRpVfzVC/ZFJrkY7cTV?=
 =?us-ascii?Q?yMa9xTp3dHMZOVggIIYOoWg/ShDI938x5fBnjlQu6RLz+Id8m6zx+BuutZZA?=
 =?us-ascii?Q?r4JGaDXHO99g1ECIlnacGFKHRIvq4Kqr7H4pY/xFUtObnZyMn+WSf6x+bvLU?=
 =?us-ascii?Q?Zi7coyCRhsknJu720qq7BLF7ewVvafqIG58LO/fcnDFWzuNjEI5txN/zjY9Y?=
 =?us-ascii?Q?eI42NGJ4Kx/3nEhwI8np8Kgv3pCif0KURSqN44A7YWum208dUNHd3kVEY7x+?=
 =?us-ascii?Q?VccE0acI5k2j9naKFQ9w7ZtdjAEPGgseKnRK6lfyutrMrJdTQwHKMw6uFWSs?=
 =?us-ascii?Q?uwVz8fGVGzOLgBFftDdie9czlMqNXUlSENhxJ2Hhlazt22itbqiXPgmh7lbh?=
 =?us-ascii?Q?0CEAwcVN20olElLF4EdDjvJIov6IpHM1o8HIjyLVFbHQKQc8OYpm6H1UOMoB?=
 =?us-ascii?Q?4D+K4WyYsUVdLcTiMNs0EwQdB0chMURaSJtT11k/hGervJgDUrYkBEDE9mTu?=
 =?us-ascii?Q?JzlHEcKzJOd60wi+/ehSLQXZc6IZeHAdX1S+ug0z9SFmoBos4qla6lUouowb?=
 =?us-ascii?Q?UnnH4edsPnX5c39CvfXNZBQyxLyPU5j55T3bh1E0M6q+JE3iUzLKlYivZ/k0?=
 =?us-ascii?Q?AjX6MZ1i95ZKXsH0j9Io5d/ZiIilhY0o0bWYF42izoIPLPOpXsE+NZKYr/rO?=
 =?us-ascii?Q?ubAflpTxA+CTgFs4qYYjaNzoygEYh0CRlAnFlNP1LyTmzG4VxnHcS4QpAAXL?=
 =?us-ascii?Q?awZjUXgGVbibmW/pTXfRRYqAbZbvsV9FyyTi6TyTuVNPhqeNSUVdDgyfT8BK?=
 =?us-ascii?Q?C58AaGBl5B1C3nIDh83KGoNCE6dUhq8wPymYHjxy6xSU8O6X0Dq4OTegj8EE?=
 =?us-ascii?Q?UrSw0+8JuSgV8AAr15hsCLfoQZNnrYsU9HbwJFVcTOEtRcseoNorhW/AzDlG?=
 =?us-ascii?Q?Y0vX5Zl1mYo5/ysed2HLKegtbAXDm5VYTKVxiU+61XXWXO9Gapj2kMFl74fZ?=
 =?us-ascii?Q?1gw=3D=3D?=
X-Microsoft-Antispam-Message-Info: hmlrVPo/h15hGfL+MDh4Do7R/LAwGzd0qZhG3kcncAlugbe3e/zXwUfTfXtR7O2yKow53EkEXxEnWSzXWx6m+oSx7khSFvSivkVWTIcyz6R1+2ewsf2uHMmREZTX40HtQBoJkPb+gqme2z9vmmsmswlSq2QdiUOgWMqEJzeoDz3cx+2HiGybTMhDVxi2AyYC
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:hyF8Y6iJ3E4Cmk6XsFoYac5/jgUnuU/zAasvr34OlQBery6XxMWJ/dPPfSUguMWnIVZLGMYqFlI5/7j+m905BiYiMwYENY2tpdzir2oyldKgPCw7VoGPMEdxrDXYQ1RsefwjDlrwdMzPNj504WgaRVsRtCi4eUihifDknXwi13fpp/o5At3s2ho1BLnV6czErSGxs0bLfus7/Kw0vGLtgIdDUOeVa4nZu0XD3HaEmoNLQX2NFodq/0cBsqMkNewSRTv5uckkLHjdhQOkRDPDkoT2DzKVH8FnkJo0mUMaPVv6/X4cJ8wyAWwR2syE82lfF68VYt38851+rCk6M7fBlQFSuCuRM0OLxD0Uvag8HQxf2jHqibFBhQZmwrsein3I5GHKxxwOv614y566W1zVulzZv5YBnXFov2pyvee0E20FIIdgWBiYIiUMGewkj2tHHv9yOsbwdiVP2tp1wb24kA==;5:OkJRQ+8XRotibhXqkLF47+MSq1fjunaYA/kE3bosyXsw4tvXYo7lbjb5qvupzhD7cxfSnMYmR7rInmhana8h1meCwZOG/TnbA6bdC9sHpwuqDHuI3cAhN2iqZZHVO7Utgx5fNnY3RLAX1NRCB4RR0IQ4peMuRuCJmbE1jRhCAMA=;24:Y3N94TmBxiKmAqTD+RNjpjIxCNGRd3LwiG9Isi1UkSoPRK0o/R/+SAfFCvPOKGYGStTZjbOlDG+SFVkTrsVFewRrNR8GMmVaEvs3wNmKAJ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:5zeYoH6a/AOAT5gFesSEtteDplRx7beU8hFVlzrTxXJ6M7fVawurSpoYQgn1F6woi3qrPlVqcCm1PEAhB/JmbBXN9DsMXXiUvD2cCmfJu2UFur9z0km5Lb/ylEInNCTSLbQjX0u8WzBQ5e/G+G/EdFr7DL0iWUVMQuB+K4IUfQmKXdVeJni5xO7oIyloJyxYkWMGf1kU4W2g6bmzbpocgy39PTXuKUayfj9JFEHcwH2gkzJs6zFjklkZza8gG6SX
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 07:35:12.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d360e3-875e-470b-36d4-08d592ec1c69
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have an sama5d31-based system with 64MB of memory and a 1920x1080
LVDS display wired for 16-bpp. When I enable legacy fbdev support,
the contiguous memory allocator invariably fails with the order-11
allocation for a 1920x1080@24-bpp buffer (~6MB). But this HW can never
make any good use of RGB888, so that is a wasted attempt anyway that
would also waste precious memory should it succeed.

Sure, I could rewrite user-space to go directly to KMS etc, and that
makes the (attempted) order-11 allocation go away, replacing it with
one order-10 allocation per application restart for a 1920x1080@16-bpp
buffer (<4MB). But after a few restarts, order-10 allocations start to
fail as well, which is only to be expected AFAIU.

So, I'd rather not change user-space (which was originally written
to target a smaller display) so that I at the same time get the
benefit of an early pre-allocated fbdev frame-buffer that can be
reused over and over. But to do that I need to tell the driver that
16-bpp is the preferred depth. Add a module parameter to do just that.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

I found some inspiration regarding naming and implementation here:
https://patchwork.kernel.org/patch/9848631/

I have found no feedback on that patch though, which makes me wonder if
I'm perhaps barking up the wronig tree?

Cheers,
Peter

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index c1ea5c36b006..f0148627c221 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -29,6 +29,11 @@
 
 #define ATMEL_HLCDC_LAYER_IRQS_OFFSET		8
 
+static int atmel_hlcdc_preferred_depth __read_mostly;
+
+MODULE_PARM_DESC(preferreddepth, "Set preferred bpp");
+module_param_named(preferreddepth, atmel_hlcdc_preferred_depth, int, 0400);
+
 static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9n12_layers[] = {
 	{
 		.name = "base",
@@ -590,6 +595,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 	dev->mode_config.min_height = dc->desc->min_height;
 	dev->mode_config.max_width = dc->desc->max_width;
 	dev->mode_config.max_height = dc->desc->max_height;
+	dev->mode_config.preferred_depth = 24;
 	dev->mode_config.funcs = &mode_config_funcs;
 
 	return 0;
@@ -658,7 +664,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 
 	platform_set_drvdata(pdev, dev);
 
-	drm_fb_cma_fbdev_init(dev, 24, 0);
+	drm_fb_cma_fbdev_init(dev, atmel_hlcdc_preferred_depth, 0);
 
 	drm_kms_helper_poll_init(dev);
 
@@ -756,6 +762,16 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
 	struct drm_device *ddev;
 	int ret;
 
+	switch (atmel_hlcdc_preferred_depth) {
+	case 0: /* driver default */
+	case 8:
+	case 16:
+	case 24:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ddev = drm_dev_alloc(&atmel_hlcdc_dc_driver, &pdev->dev);
 	if (IS_ERR(ddev))
 		return PTR_ERR(ddev);
-- 
2.11.0
