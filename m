Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeDILAA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:00:00 -0400
Received: from mail-db5eur01on0131.outbound.protection.outlook.com ([104.47.2.131]:45133
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752498AbeDIK7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:59:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] drm/atmel-hlcdc: add support for connecting to tda998x HDMI encoder
Date: Mon,  9 Apr 2018 12:59:17 +0200
Message-Id: <20180409105918.20792-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::37) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa9f1ad-f62d-4779-e1b2-08d59e090451
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:h4i4kq7VyVCOF4/iwkAWCYvS5yUEUxeQ1QaX2feCQoad1oAhLTXvc5ekFhLmMNIJEdWkkhNxsZabRDy5YRq8GMoisCsLPJGpjWndnaFHMKa8tOAcq4n7dMhYOObz2dNMCV3fX0JHSjQMK9XRElW7/mr60jhfBlFAxUsiiv5SeLpDPM5VBer/Qf1zSUT86vtwznhUkLjei6PoTvJWvThDlpWnwtFntZTwE4VaXQ24RgVXvEqvUbrkHOliS0wA/ibi;25:6Or24rkHioQJ9Luv+Mfq6Kf/xqb+EHVYJPCWJXP6nOk5Nxc7hizuGBwPnYW+WE5ijPHGurDhvOWBUK9A3mbHY23o/F3Vh7FuUuAsIvFqM0V6fkm5xZJsUkPrJ9NV0kMG+4x3nOhDwCe6ljjn9hNUhWD9r2hvGZmbYFjBvKkZbErXY3HzOUvdJOZ8TANOl+QoU/dhFJ1YvyCCQQyzUbWVXK1yukAzi44zytRWsoaDuPYk4K2+6Bv6yInwuAP3eEZMIMqs/YIICmr4wfqxtOWZLdFQttbUkWbwHAU3u2X79toSXq3O/4UPPfN7FXGocZx5VwXib1mZfsVJPqz6AOBIbQ==;31:nIpXbzZscDdUU4ju6aJcV8Pe/Cp0Om7VKcJ2G5QF9ld5Vsg3X6a7L76mVhHsL0izQkHYkhPclGHIqk+3hJo4i9kgphyQCLScDArrb+SeoZXfNyi/MLnyicoF6cAWmcEmrbsjyRxilbFc4XZBqHl1v/CU+vk7dB5I9kDE1hu9s4tc/AAt1e41dd3uByu7A1h0ZraehjOzvX45+ozkrgWUfe2bVLeSA2sYtXEKdA1ucUo=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27759E78414B64C5CCC0268DBCBF0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(31051911155226)(22074186197030)(58145275503218);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:QArdugtRzFGUAEQ/iPWZ0GFF3SKVwJH2d2P2hhorZw3sgLTddXKF5kphmn8ZC5jf6X/zlGTbkTNWQFZ80iPnNuHWbX9g7dN9B33kTN4DqcQtmNi1FPVwHAWLQZ0mL7FQc2tFThRd/M7vZV/b1b2rcfpKzV83QrMvtgApZJeKs/z/gpKeVZHpxZj4JA9QkWlOy7HJs2J3rC+ODCoJyJTt3LDKqPEHQjcTABGYa7H4Iok15w+kqt/1K2sppiMBChkAzryqSALqNRiYQqbmbfcik+rfFwTld5OueKgSDnQ0d2IscZsRLacnGX8QdxyKSgKDIk8WB+QjbrXogheDxBStHBqTq/jDBh84rqEL/cuJbPGZ6phCH4antDYwP5pF3wYDgPiaatSKh+zYXMweATK8HMIXHVs+51zYR8Leih99NzI=
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39830400003)(396003)(366004)(199004)(189003)(575784001)(86362001)(68736007)(26005)(106356001)(478600001)(186003)(2351001)(16526019)(2361001)(74482002)(446003)(48376002)(16586007)(50466002)(76176011)(54906003)(386003)(6506007)(316002)(59450400001)(52116002)(51416003)(6666003)(6916009)(2906002)(6116002)(1076002)(105586002)(66066001)(47776003)(97736004)(7736002)(6512007)(7416002)(305945005)(11346002)(6306002)(53936002)(5660300001)(8676002)(3846002)(81156014)(81166006)(36756003)(8936002)(476003)(2616005)(486006)(50226002)(4326008)(6486002)(25786009)(956004)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2775;23:M/9wuWskMnMi1j+jQhjGGifOctHgCKI3xFLk4md?=
 =?us-ascii?Q?bzYz8BB7RQybEJBuDtkSt5GD/jFVsBobiPbMYmjSp4p2iKo9+4NtGqVwUAJk?=
 =?us-ascii?Q?9AvS0qo5I34L5wnUOVy7xDk5dmUZSXfClbnGLshGoUs2rWQeaP2mi48Uff5Z?=
 =?us-ascii?Q?rGc5SR2usiuhK8rBUdOqbzSsLbAdGZ793Gev2SOHmKoa7czMYcnnHRPzp9Mu?=
 =?us-ascii?Q?Wjow5HNXqwcPqfzTMQmZgCucxhYVGfktiOrKnLuEG8DrXbHRiZdcVRf9pqD9?=
 =?us-ascii?Q?5OB32GSq1Yg5N/jbtMnlMh0YX+J4hvZb46cOq4X0lzvuPwknofOZLZa/eYi6?=
 =?us-ascii?Q?p9dvx1EfgE/AhfY7N4No76Euw6bokm0tpIVAbPW7PAfOQ628o+GTcm+CjfxK?=
 =?us-ascii?Q?1x2yaKhL7DPQeWWAVx1btCBHOtwcYwRH8lR0iKdblb+KYryShfAsLkniS+8i?=
 =?us-ascii?Q?pU7F4qu4wj7HqAo9nIh4ElGshWfKlRm2q6JZWr5eS3xjAbopcZaV659JomRn?=
 =?us-ascii?Q?Zmjh0cMd+1OeTi0De1eApUSXQ3rprOKUx9DYADmsbfGSHWseRbOGWeTeGYZS?=
 =?us-ascii?Q?v/9Gc5OioekXl3nVjZ/vrgIMKc1PmGwDmLJ7x7cELZWjC3c9i2NBRbEIrjCu?=
 =?us-ascii?Q?j9XV+tUEfcLWNb38SP4JG/dQ13IjGXIO21/n4v3fwxNcIeMIIc/d17dYN7n/?=
 =?us-ascii?Q?pQWMGOdZfyPfq490IVp/UgEMygHPe5hmWKLnejqd++mcFBIYicosgHbP/F18?=
 =?us-ascii?Q?4Bq7hIAkL+1On3FNc+2zLx0a7pEpsIhVYn+whuySO9OTjwiVAEip0cNO2dgq?=
 =?us-ascii?Q?pIgNnOXJvSWa1DJDM71ecRArhapolZrmBv0B9iYeM02E71kxUPt9GOk1yJFl?=
 =?us-ascii?Q?iKT2dulO6kMM2XepHucsekiBK6Lna462DKbqr7SXAJPJdTG9AvaZKixNai52?=
 =?us-ascii?Q?nvmJXK4GuJtaF9JTmsoVCSvpx+gUH1eyIAq9A37p6ONK6lLggaqWXr1rWNtV?=
 =?us-ascii?Q?t/YCxXrsLhRbvk/OUrcXt6JFHegh78VUqiPCXNE6Y8w6kUlKEcnI+ezOn9Zf?=
 =?us-ascii?Q?MU4zgKGkC/7poS+KZvo9RYxNSrsX7gybKVPh4sc4e8EXiKRleww6XCzYI5VE?=
 =?us-ascii?Q?bHFI5g9twe4e29/mFOf2PV/t4Eshic0cK1oN2H8ZcX9iA3kjnZhlj4cdKab5?=
 =?us-ascii?Q?+95Q5eu89jkG13VUeZSMWUjb1xF7as7aUdKcag4XVEvKwW9A18a5HXCRF20I?=
 =?us-ascii?Q?eJyMVpDsWfyIMajOc1lsJDCuQYEd1eJyLXgAc0SIKClqaGKD7KwEzlAjp2ge?=
 =?us-ascii?Q?fviXcf8rNq1Rm2fNEuprTu4m0eteUA6zXpYtx8HH1Yfa47+lkxOba/vLf/4B?=
 =?us-ascii?Q?JrE6j8Uepn0qy+y058hSXok2GZ3Y5VPLHEJQ1Q/Vk0/zgOoi+?=
X-Microsoft-Antispam-Message-Info: tPG+1YGLnnzZO0kmzKrvZD8xwGqLDY7OvAGktG/7d8GR1wizrF0A4KY5ir3oKq/8wwRkAhVIuZA3vdm4eM/wWgIXprF/59A/BXQYfNuKbiSrNVP0UMSNbqBrsRGpEpnGK0kYfwO2/+CUIfoD/zqXNi6beSd8w3k8tHv1NTerDIIUPGv6BQbsbMoLnXmdkylA
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:H4y61LPXrgAGUqBxUmKvgGJ5dlJ7+h5q6OYXy48G8XUow4PTTQvqP/7TKJRzNsl3I2h/j7vAO05oE2IQR2D1HATk+Wc5MFjTZHxGvNd/48CHzk3OtZ5TOFfSNO0og0O3Of42T0gyHqiVniFDLU+VTh6KtlykzidMo42YMRntcXJJY1YVeoQWFVdjf23u0YgN7gM1cnUVQ7CpcvKhBucbQG7BFdbTvqoK2ct+64hL/C8sGhBiHjkhB04Ononef7VcXF4OmyfQ7mNDRRkKNh0AEfKC5wXCHHJ+7V0iOEnJH8NswRoi23G1uSbBZUD/PZPzuuca2s6PnYjYkXNBtdLUlsb98mM5fD9OqGAVanHXpNCnusss7qEYoIDunp9/+Cp7vBrVmSLMabGGpmWo4pJ64Feg+ziAz+5/1eS9BvyEqVosrKEMiw+XIVUPBpcnCV8DPs7r5Kqkd7JW5EjcofbadA==;5:hVEsuSoCq9Ka+DjAS7Y+lCmZh1HMb9t360WqQzErosXFgJeMiqe6fxwcblVWHbmR2Ha7XfKf43ocy5q5gPu91Gx+F0r9IxSIOGkz2p2DNYt3iv1OOvXqxBGETTYidFzCKhsBC4WwM8qGhBVg0mSDxsvxdzBYaxu4t2tTAwMxnS4=;24:3cIVBtcJL2FeQDVHWGahdXNN3gz0IihHHYzdb1YWOLs811nKo7k9h3sIR2X/HGvKq/tEO7rntUujJ89UXPK0gf/RU5hfGsXwzkrrOGh6ExU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:oKx9JUYSDCB/ydVLFzLRyTEwT4Pd+xZZH5/LpmH84SXFdB9Z3a+GVwkDtwyDQUYUgppKbq5z7f9ccrPR3gJuMiyqJeK5qJeWbC87ws3PECITt1DLhP+M9roL1ViDfFXUIosCyJjZ9aQdo6IeHAZiud8NZDmkuJ84hsAJ4fLZcQQl1ZU03CDLTpquTwqHQG2Uml6aN9+1AYHIXrosYGaDGNzawcqt1f3lOQIHtIPSxebnC49k2zNMGmih0LHoOKFu
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 10:59:50.0917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa9f1ad-f62d-4779-e1b2-08d59e090451
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the of-graph points to a tda998x-compatible HDMI encoder, register
as a component master and bind to the encoder/connector provided by
the tda998x driver.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     |  81 ++++++++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  15 +++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 130 +++++++++++++++++++++++
 3 files changed, 220 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index dccd0be548a9..b411038890a9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/component.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/module.h>
@@ -568,10 +569,13 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 
 	drm_mode_config_init(dev);
 
-	ret = atmel_hlcdc_create_outputs(dev);
-	if (ret) {
-		dev_err(dev->dev, "failed to create HLCDC outputs: %d\n", ret);
-		return ret;
+	if (!dc->is_componentized) {
+		ret = atmel_hlcdc_create_outputs(dev);
+		if (ret) {
+			dev_err(dev->dev,
+				"failed to create HLCDC outputs: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = atmel_hlcdc_create_planes(dev);
@@ -586,6 +590,16 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 		return ret;
 	}
 
+	if (dc->is_componentized) {
+		ret = component_bind_all(dev->dev, dev);
+		if (ret < 0)
+			return ret;
+
+		ret = atmel_hlcdc_add_component_encoder(dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	dev->mode_config.min_width = dc->desc->min_width;
 	dev->mode_config.min_height = dc->desc->min_height;
 	dev->mode_config.max_width = dc->desc->max_width;
@@ -618,6 +632,9 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	if (!dc)
 		return -ENOMEM;
 
+	dc->is_componentized =
+		atmel_hlcdc_get_external_components(dev->dev, NULL) > 0;
+
 	dc->wq = alloc_ordered_workqueue("atmel-hlcdc-dc", 0);
 	if (!dc->wq)
 		return -ENOMEM;
@@ -770,7 +787,7 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
 	.minor = 0,
 };
 
-static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
+static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
 {
 	struct drm_device *ddev;
 	int ret;
@@ -798,7 +815,7 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
+static int atmel_hlcdc_dc_drm_fini(struct platform_device *pdev)
 {
 	struct drm_device *ddev = platform_get_drvdata(pdev);
 
@@ -809,6 +826,58 @@ static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int atmel_hlcdc_bind(struct device *dev)
+{
+	return atmel_hlcdc_dc_drm_init(to_platform_device(dev));
+}
+
+static void atmel_hlcdc_unbind(struct device *dev)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+
+	/* Check if a subcomponent has already triggered the unloading. */
+	if (!ddev->dev_private)
+		return;
+
+	atmel_hlcdc_dc_drm_fini(to_platform_device(dev));
+}
+
+static const struct component_master_ops atmel_hlcdc_comp_ops = {
+	.bind = atmel_hlcdc_bind,
+	.unbind = atmel_hlcdc_unbind,
+};
+
+static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+	int ret;
+
+	ret = atmel_hlcdc_get_external_components(&pdev->dev, &match);
+	if (ret < 0)
+		return ret;
+	else if (ret)
+		return component_master_add_with_match(&pdev->dev,
+						       &atmel_hlcdc_comp_ops,
+						       match);
+	else
+		return atmel_hlcdc_dc_drm_init(pdev);
+}
+
+static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = atmel_hlcdc_get_external_components(&pdev->dev, NULL);
+	if (ret < 0)
+		return ret;
+	else if (ret)
+		component_master_del(&pdev->dev, &atmel_hlcdc_comp_ops);
+	else
+		atmel_hlcdc_dc_drm_fini(pdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
 {
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index a810171b9353..53f780827889 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -377,6 +377,10 @@ struct atmel_hlcdc_plane_properties {
  * @wq: display controller workqueue
  * @suspend: used to store the HLCDC state when entering suspend
  * @commit: used for async commit handling
+ * @external_encoder: used encoder when componentized
+ * @external_connector: used connector when componentized
+ * @connector_funcs: original helper funcs of the external connector
+ * @is_componentized: operating mode
  */
 struct atmel_hlcdc_dc {
 	const struct atmel_hlcdc_dc_desc *desc;
@@ -394,6 +398,12 @@ struct atmel_hlcdc_dc {
 		wait_queue_head_t wait;
 		bool pending;
 	} commit;
+
+	struct drm_encoder *external_encoder;
+	struct drm_connector *external_connector;
+	const struct drm_connector_helper_funcs *connector_funcs;
+
+	bool is_componentized;
 };
 
 extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_formats;
@@ -463,4 +473,9 @@ int atmel_hlcdc_crtc_create(struct drm_device *dev);
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev);
 
+struct component_match;
+int atmel_hlcdc_add_component_encoder(struct drm_device *dev);
+int atmel_hlcdc_get_external_components(struct device *dev,
+					struct component_match **match);
+
 #endif /* DRM_ATMEL_HLCDC_H */
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..3f86527e0473 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -6,6 +6,11 @@
  * Author: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
  * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
  *
+ * Handling of external components adapted from the tilcdc driver
+ * by Peter Rosin <peda@axentia.se>. That original code had:
+ *   Copyright (C) 2015 Texas Instruments
+ *   Author: Jyri Sarha <jsarha@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
@@ -19,6 +24,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/component.h>
 #include <linux/of_graph.h>
 
 #include <drm/drmP.h>
@@ -88,3 +94,127 @@ int atmel_hlcdc_create_outputs(struct drm_device *dev)
 
 	return ret;
 }
+
+static int atmel_hlcdc_external_mode_valid(struct drm_connector *connector,
+					   struct drm_display_mode *mode)
+{
+	struct atmel_hlcdc_dc *dc = connector->dev->dev_private;
+	int ret;
+
+	ret = atmel_hlcdc_dc_mode_valid(dc, mode);
+	if (ret != MODE_OK)
+		return ret;
+
+	if (WARN_ON(dc->external_connector != connector))
+		return MODE_ERROR;
+	if (WARN_ON(!dc->connector_funcs))
+		return MODE_ERROR;
+
+	if (IS_ERR(dc->connector_funcs) || !dc->connector_funcs->mode_valid)
+		return MODE_OK;
+
+	/* The connector has its own mode_valid, call it. */
+	return dc->connector_funcs->mode_valid(connector, mode);
+}
+
+static int atmel_hlcdc_add_external_connector(struct drm_device *dev,
+					      struct drm_connector *connector)
+{
+	struct atmel_hlcdc_dc *dc = dev->dev_private;
+	struct drm_connector_helper_funcs *connector_funcs;
+
+	/* There should never be more than one connector. */
+	if (WARN_ON(dc->external_connector))
+		return -EINVAL;
+
+	dc->external_connector = connector;
+	connector_funcs = devm_kzalloc(dev->dev, sizeof(*connector_funcs),
+				       GFP_KERNEL);
+	if (!connector_funcs)
+		return -ENOMEM;
+
+	/*
+	 * connector->helper_private always contains the struct
+	 * connector_helper_funcs pointer. For the atmel-hlcdc crtc
+	 * to have a say if a specific mode is Ok, we install our
+	 * own helper functions. In our helper functions we copy
+	 * everything else but use our own mode_valid() (above).
+	 */
+	if (connector->helper_private) {
+		dc->connector_funcs = connector->helper_private;
+		*connector_funcs = *dc->connector_funcs;
+	} else {
+		dc->connector_funcs = ERR_PTR(-ENOENT);
+	}
+	connector_funcs->mode_valid = atmel_hlcdc_external_mode_valid;
+	drm_connector_helper_add(connector, connector_funcs);
+
+	dev_dbg(dev->dev, "External connector '%s' connected\n",
+		connector->name);
+
+	return 0;
+}
+
+static struct drm_connector *
+atmel_hlcdc_encoder_find_connector(struct drm_device *dev,
+				   struct drm_encoder *encoder)
+{
+	struct drm_connector *connector;
+	int i;
+
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head)
+		for (i = 0; i < DRM_CONNECTOR_MAX_ENCODER; i++)
+			if (connector->encoder_ids[i] == encoder->base.id)
+				return connector;
+
+	dev_err(dev->dev, "No connector found for %s encoder (id %d)\n",
+		encoder->name, encoder->base.id);
+
+	return NULL;
+}
+
+int atmel_hlcdc_add_component_encoder(struct drm_device *dev)
+{
+	struct atmel_hlcdc_dc *dc = dev->dev_private;
+	struct drm_connector *connector;
+	struct drm_encoder *encoder;
+
+	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
+		if (encoder->possible_crtcs & (1 << dc->crtc->index))
+			break;
+	}
+
+	if (!encoder) {
+		dev_err(dev->dev, "%s: No suitable encoder found\n", __func__);
+		return -ENODEV;
+	}
+
+	connector = atmel_hlcdc_encoder_find_connector(dev, encoder);
+	if (!connector)
+		return -ENODEV;
+
+	return atmel_hlcdc_add_external_connector(dev, connector);
+}
+
+static int dev_match_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+int atmel_hlcdc_get_external_components(struct device *dev,
+					struct component_match **match)
+{
+	struct device_node *node;
+
+	node = of_graph_get_remote_node(dev->of_node, 0, 0);
+
+	if (!of_device_is_compatible(node, "nxp,tda998x")) {
+		of_node_put(node);
+		return 0;
+	}
+
+	if (match)
+		drm_of_component_match_add(dev, match, dev_match_of, node);
+	of_node_put(node);
+	return 1;
+}
-- 
2.11.0
