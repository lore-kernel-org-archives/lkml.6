Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeDSQ2y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:28:54 -0400
Received: from mail-he1eur01on0090.outbound.protection.outlook.com ([104.47.0.90]:39733
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeDSQ2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:47 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
Date: Thu, 19 Apr 2018 18:27:51 +0200
Message-Id: <20180419162751.25223-8-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419162751.25223-1-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::49) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:H1ZsPSVLksqmxzfoOcqHThTwFmk1prR3hf7b0eIsq9ZVMd1E5j4j8pM85Qu3Ka8OxydOwwDNumsw5NkY6dkQfa02EIr9HCTw+JOyyIHQxl5WaSBXzoYp9P92KkvisvQSlixRbRyn7CMRtTyRboK4QJdjNNaCXKZY5UNeUR4Iyt1Y3/G34j/Y8Cz3kIQcmI3RnpXaDHVqtEkV+SN0a5BtIjoaqCXzj1o/eB1tHYcUcAmKfATv/t7Hy+/hNFpkVk/t;25:dYQcyuNPEx9PmYKzqqIdNyO6ntp5JORxJJ7OTX6V8RM8I+D1F9uefGGuna6isxo0+i0C5rWS9fcslRr8DVYzKsppDj7OgyGe9+BZoDR19DodHwA9OCEZ+VtN9JJEp8TZ1NBmrajP4lYfbHdiDVeGLXlKJU+IVJj6AlRgASKezb2E8nX2+AhUBFVcIZ0WPUubNpot7hhdrw4dSYgcqOeUC5UB6GCDAZfGyu5vVcm9QnfuxvjmkO3VMlE9FlAL0Hrqt/ccK8WC5xbjg6VBgRVTsXhLgOYvXkAE2It2ZPrP6m5A6nTtwYkOb8Z6ExNkPHolcATYSAJOCb/gjICxgziAgw==;31:Tv88/qy83K34dTEOnCzGFTWpANLdDSLMInpzqQsA4eH3t+sGQYFGXij+FUGVt99q+uGrpwYT28x9ZrrwxvSYqJyCt3Aq3L3ikjIKHG9xuhtFJhMxpVoItpTh4EA+TVkT3mAtCDIIn2s2W1tMibfoF9XXPfGkDt2IApV35rL6u6ZkiIC5mmtfFB7jVORnGurxJtmaHNYjbkx4yt5IhVYPs3pIhrzFBV8PSgIxDY4NNQM=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784E055D07E6154CCD662C7BCB50@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:XhWsVWj1W0svAUV2OUocxLXK3QMO5wUnoZs9o9AMBRNgU5U8wyh2LoVGxwOwojoZon4p2vSOxf8bIuGji+nxBEzF4kJ76n8gi/7nKcnMAW4UV2wR39z7wwWDdAOPDzSc3fjvyVaRR/noTXSbFdJ/gin8cIRjzeOvW9eIqWcajOUocElRjEMuoLb0PHowA25JkhMhd0YDxPgceHbMm/ulSyrszv9D/6Et2KGLHKXGCgNGgPgINZNA2IaOkpxcmTMxG6fqe2bC7tAXbsAqmNa90tkjWBSbXcob6C3MEo/naHZd8kkWJtf1Mf2zF+FQYk/t
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39840400004)(26005)(86362001)(50466002)(50226002)(8936002)(6506007)(386003)(76176011)(47776003)(1076002)(59450400001)(2351001)(66066001)(5890100001)(6116002)(3846002)(2361001)(16526019)(305945005)(186003)(74482002)(11346002)(956004)(2906002)(446003)(6512007)(52116002)(53936002)(6916009)(6486002)(476003)(478600001)(316002)(8676002)(4326008)(2616005)(36756003)(7416002)(7736002)(6666003)(48376002)(16586007)(5660300001)(54906003)(25786009)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:gpMym1mV6c7POQxJlNSm9Rkwev77Lgl8sVkdeMV?=
 =?us-ascii?Q?DV0IMvPY4IewC12AscTuMg+RM1WfR9HwH6NttKmzL2XOAwspdyHM2PAF0ENQ?=
 =?us-ascii?Q?XHZE56NGcGzxCdKGI7ZMEdwVIFyxVzHvc+thW+STOO7BH8RV0WDoonkvsc6G?=
 =?us-ascii?Q?d0zZ3JBIJdXzVbqAueXuuL1FL4GaPKuw4AsdDVJhWAFJiejILZf3CUArpcpB?=
 =?us-ascii?Q?IjfP2iYqgQa9T7hIeRvOlCq77tTXWwBi0ICVY4RHp+GHJZzWpETUOW8Qn/YJ?=
 =?us-ascii?Q?7bpgvfcWPIdjdUD8WkbfYc1rv5lrAsokQQrDJLf0qJ+ydhxGNmbgK+uGUHJ1?=
 =?us-ascii?Q?TYY00LxyQc+S+9aZdxns/R6vLdpTKymZdBkSVzN14lc1JSVU8NU2wgDjnNH1?=
 =?us-ascii?Q?Ne7RKM0xGZ3KVgjcQNauKF8vY23vJkZ86vxrN+cxfSqqfP34EgVmjNPfqjs5?=
 =?us-ascii?Q?kVtRgeGGIt/YfT8Ru+BqXhR3JDEyayrDbRpOJ6zVvcLvGuUQx02tAtDXqiSq?=
 =?us-ascii?Q?BsHdZ4X1jOv1InR+dUvejD4SUbAT396HBFnfyccoUg4FrQDTlS1WoYkXmr8N?=
 =?us-ascii?Q?mfrxvtHxOUxCuBsT8vrB9+lmrIzpU5bttI383eijbAPQ+m0J1egmOgutIoNk?=
 =?us-ascii?Q?gEI+4XZKCJ3UpgIy3fcDzhiZu9j1i6ucaZWMdy0G5AOddBxgUJjSWpDEBZXn?=
 =?us-ascii?Q?9tmYWLW23e+y3hkk4fwiEsBgJSGP8GpoO7+u4wpNa9UtCud5BVU3FzT+e/mc?=
 =?us-ascii?Q?mkfVEh3zboUKuR1jTp9MXhO46UvcGfR06LvIynLUT8GfoEdv+35bLICkJiWN?=
 =?us-ascii?Q?26H4luSCJ5ZG0xcny+9FY2y+hRZF0wJpjie7ikeE9Qdy7JwZOx7CYfQTWEYB?=
 =?us-ascii?Q?xwR7OR2c/nxs06sUeoyUywtt/tNtq1lNMAJKNau0Dvoq59BPDvRh6Dnd9F/3?=
 =?us-ascii?Q?5TZhXN1Iah2kxikjo6iapZDL1PkU/JKaEO+wHlIGTPRQrUPakdxZUxxq36Bc?=
 =?us-ascii?Q?MGvQnfqgx/9s4dcnyMK0PlXc3yTMEms+i+EIkDvHSyrEQKTxNcUlA9tiOzA7?=
 =?us-ascii?Q?p5wnLIe3EjPcU8dtxEgcu0RUk8zXdHFhzlrjTuJytkVHQjglKoGslqi+7kgZ?=
 =?us-ascii?Q?W4wFADDtX3PwKpfFubBp0Sa/+i/bkN2K32SckiK5S/+wLPreTyUX8zqH8xQi?=
 =?us-ascii?Q?QXo+lmGQ0NnOmUmM=3D?=
X-Microsoft-Antispam-Message-Info: WHxOHsvukjZTxd1t41Y5KBEjGYKIjIEntPjv+hZ9uhD/loHon6TsrNIvbJJpvXLocbgeuPry+jfIClGjLOM2BMDVEed95XFeB60e8xQpOGzbI+miHGkA6rAOTWUJGthLUF9AffjjcM3FWyc+0kRL7jd9nbOpIGoNpKUWGGYw7/8H+ojwLEvNpA3zFiqNFt2v
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:IQ/DmlU9hvGOvJTLBN+8mTG9YMnhwlK8LIpUnJo4+Ul9s3JAVuWElJ/BWoBxVSCC4svbxLHarY6awmJHdTmQ9o5mRMI6js5nF1e8dX6m/2CA5HwYGShLlTjIAQ10AI3/TJ8BRXl8cI5GBMEwnTLdwxg17EPX3wDTybZti40YJ/ISMAs083cn1xqMa9f8NteYTArvLdbgLy0jwgsQ/1Iz9TOnBvdMiV+OG8qVBdCTCl5blMObBXvCYgFYu+gAS0DZOn3Nif69GaonTgWjDKSJdyri0i0ahzOeSNiqDrgoIdIVcKtw3fiWm44rmlD7YiBB6pkRt9kHj2CHLjhRC5HoIPAIpFGTm4GrSwOfAJjMWQbdVOvcKwFN+CRhQPnIvFzXMjyBBfIua++NxnQkVj98n0mr12YuarrW//NniwGlU8Os7oz22zwWkdMpGZs38MV1otAnvLMJWF378t7WjbFJ4Q==;5:1z+2Y1d5W1R0HOMmvUhT9ZaSuMjSMJ2fvsJUflO7M82TsbBqtNRh0TYiZihQJoUhQjetIayDYQH8Vv5EfhjyFeDfYGXNHik7eTSOKLqePcJeIHtnI2cVjir1WTbAM/N+Exb/GpYc8WIvOpkm4ymMMWCkSPJpqEiXKJiR60RGdio=;24:TdNtMQTK7rHg251qWTcch9oRhEn9Ex2mXM7hAy1gXE9OF29iubTvMmM1m/M/7CI1/GoJTaGpyN0fdFn2CGDdXgda/PvjCSHXLy6rxA3zBoI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:5S6D/UtBAyQA5HIcUWHyrie4Bz+YtGTfOk/Orw5VAkgYIsYC03xaKT970KlAQtQb5+eLtHWCivoyone8gX/5Q+rGA6pdbVp/s6ftA4vkwnI4iuon9cNGscChL+lj10nMy3ExTSNeq/jjKFsqh+MJIz3Ns3knriLv2Xclasg2lAau/lVFPR4jBulXsRXEQ3/HqKSPBWefBUeSWhbsvWn6IxWx8K8FbSO70HVX6hKUniMKIRuoQ3DTCMZwNMwTPJGX
X-MS-Office365-Filtering-Correlation-Id: 7a3323e9-c787-4f02-66be-08d5a6129eb9
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:28:43.3647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3323e9-c787-4f02-66be-08d5a6129eb9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes this driver work with all(?) drivers that are not
componentized and instead expect to connect to a panel/bridge. That
said, the only one tested is atmel_hlcdc.

This hooks the relevant work function previously called by the encoder
and the component also to the bridge, since the encoder goes away when
connecting to the bridge interface of the driver and the equivalent of
bind/unbind of the component is handled by bridge attach/detach.

The lifetime requirements of a bridge and a component are slightly
different, which is the reason for struct tda998x_bridge.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 157 +++++++++++++++++++++++++++++++++-----
 1 file changed, 137 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 9c78f7bde49c..012dee61d817 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -36,6 +36,14 @@ struct tda998x_audio_port {
 	u8 config;		/* AP value */
 };
 
+struct tda998x_priv;
+
+struct tda998x_bridge {
+	struct tda998x_priv *priv;
+	struct device *dev;
+	struct drm_bridge bridge;
+};
+
 struct tda998x_priv {
 	struct i2c_client *cec;
 	struct i2c_client *hdmi;
@@ -63,6 +71,8 @@ struct tda998x_priv {
 	wait_queue_head_t edid_delay_waitq;
 	bool edid_delay_active;
 
+	struct tda998x_bridge *bridge;
+	bool local_encoder;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
 
@@ -75,6 +85,9 @@ struct tda998x_priv {
 #define enc_to_tda998x_priv(x) \
 	container_of(x, struct tda998x_priv, encoder)
 
+#define bridge_to_tda998x_bridge(x) \
+	container_of(x, struct tda998x_bridge, bridge)
+
 /* The TDA9988 series of devices use a paged register scheme.. to simplify
  * things we encode the page # in upper bits of the register #.  To read/
  * write a given register, we need to make sure CURPAGE register is set
@@ -842,7 +855,8 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 				   struct hdmi_codec_daifmt *daifmt,
 				   struct hdmi_codec_params *params)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 	int i, ret;
 	struct tda998x_audio_params audio = {
 		.sample_width = params->sample_width,
@@ -899,7 +913,8 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 
 static void tda998x_audio_shutdown(struct device *dev, void *data)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 
 	mutex_lock(&priv->audio_mutex);
 
@@ -912,7 +927,8 @@ static void tda998x_audio_shutdown(struct device *dev, void *data)
 
 int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 
 	mutex_lock(&priv->audio_mutex);
 
@@ -925,7 +941,8 @@ int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
 static int tda998x_audio_get_eld(struct device *dev, void *data,
 				 uint8_t *buf, size_t len)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 
 	mutex_lock(&priv->audio_mutex);
 	memcpy(buf, priv->connector.eld,
@@ -1126,7 +1143,10 @@ tda998x_connector_best_encoder(struct drm_connector *connector)
 {
 	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
 
-	return &priv->encoder;
+	if (priv->local_encoder)
+		return &priv->encoder;
+	else
+		return priv->bridge->bridge.encoder;
 }
 
 static
@@ -1140,6 +1160,7 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 				  struct drm_device *drm)
 {
 	struct drm_connector *connector = &priv->connector;
+	struct drm_encoder *encoder;
 	int ret;
 
 	connector->interlace_allowed = 1;
@@ -1156,7 +1177,8 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 	if (ret)
 		return ret;
 
-	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
+	encoder = tda998x_connector_best_encoder(&priv->connector);
+	drm_mode_connector_attach_encoder(&priv->connector, encoder);
 
 	return 0;
 }
@@ -1668,8 +1690,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
 	priv->audio_params = p->audio_params;
 }
 
-static int tda998x_init(struct device *dev, struct drm_device *drm)
+static int tda998x_init(struct device *dev, struct drm_device *drm,
+			bool local_encoder)
 {
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
 	struct tda998x_encoder_params *params = dev->platform_data;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tda998x_priv *priv;
@@ -1680,7 +1704,9 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	if (!priv)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, priv);
+	bridge->priv = priv;
+	priv->bridge = bridge;
+	priv->local_encoder = local_encoder;
 
 	if (dev->of_node)
 		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
@@ -1691,7 +1717,8 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 		crtcs = 1 << 0;
 	}
 
-	priv->encoder.possible_crtcs = crtcs;
+	if (local_encoder)
+		priv->encoder.possible_crtcs = crtcs;
 
 	ret = tda998x_create(client, priv);
 	if (ret)
@@ -1700,11 +1727,15 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	if (!dev->of_node && params)
 		tda998x_set_config(priv, params);
 
-	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
-	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
-			       DRM_MODE_ENCODER_TMDS, NULL);
-	if (ret)
-		goto err_encoder;
+	if (local_encoder) {
+		drm_encoder_helper_add(&priv->encoder,
+				       &tda998x_encoder_helper_funcs);
+		ret = drm_encoder_init(drm, &priv->encoder,
+				       &tda998x_encoder_funcs,
+				       DRM_MODE_ENCODER_TMDS, NULL);
+		if (ret)
+			goto err_encoder;
+	}
 
 	ret = tda998x_connector_init(priv, drm);
 	if (ret)
@@ -1713,7 +1744,8 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	return 0;
 
 err_connector:
-	drm_encoder_cleanup(&priv->encoder);
+	if (local_encoder)
+		drm_encoder_cleanup(&priv->encoder);
 err_encoder:
 	tda998x_destroy(priv);
 	return ret;
@@ -1721,10 +1753,12 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 
 static void tda998x_fini(struct device *dev)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 
 	drm_connector_cleanup(&priv->connector);
-	drm_encoder_cleanup(&priv->encoder);
+	if (priv->local_encoder)
+		drm_encoder_cleanup(&priv->encoder);
 	tda998x_destroy(priv);
 }
 
@@ -1732,7 +1766,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = data;
 
-	return tda998x_init(dev, drm);
+	return tda998x_init(dev, drm, true);
 }
 
 static void tda998x_unbind(struct device *dev, struct device *master,
@@ -1746,19 +1780,102 @@ static const struct component_ops tda998x_ops = {
 	.unbind = tda998x_unbind,
 };
 
+/* DRM bridge functions */
+
+static int tda998x_bridge_attach(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct device *dev = bridge->dev;
+	struct drm_device *drm = bridge->bridge.dev;
+
+	dev_info(dev, "attach\n");
+	return tda998x_init(dev, drm, false);
+}
+
+static void tda998x_bridge_detach(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct device *dev = bridge->dev;
+
+	dev_info(dev, "detach\n");
+	tda998x_fini(dev);
+}
+
+static void tda998x_bridge_enable(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct tda998x_priv *priv = bridge->priv;
+
+	dev_info(bridge->dev, "enable\n");
+	tda998x_dpms(priv, DRM_MODE_DPMS_ON);
+}
+
+static void tda998x_bridge_disable(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct tda998x_priv *priv = bridge->priv;
+
+	dev_info(bridge->dev, "disable\n");
+	tda998x_dpms(priv, DRM_MODE_DPMS_OFF);
+}
+
+static void tda998x_bridge_mode_set(struct drm_bridge *dbridge,
+				    struct drm_display_mode *mode,
+				    struct drm_display_mode *adjusted_mode)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct tda998x_priv *priv = bridge->priv;
+
+	tda998x_mode_set(priv, mode, adjusted_mode);
+}
+
+static const struct drm_bridge_funcs tda998x_bridge_funcs = {
+	.attach = tda998x_bridge_attach,
+	.detach = tda998x_bridge_detach,
+	.enable = tda998x_bridge_enable,
+	.disable = tda998x_bridge_disable,
+	.mode_set = tda998x_bridge_mode_set,
+};
+
 static int
 tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct tda998x_bridge *bridge;
+	int ret;
+
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_warn(&client->dev, "adapter does not support I2C\n");
 		return -EIO;
 	}
-	return component_add(&client->dev, &tda998x_ops);
+
+	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return -ENOMEM;
+
+	bridge->dev = dev;
+	dev_set_drvdata(dev, bridge);
+
+	bridge->bridge.funcs = &tda998x_bridge_funcs;
+	bridge->bridge.of_node = dev->of_node;
+	drm_bridge_add(&bridge->bridge);
+
+	ret = component_add(dev, &tda998x_ops);
+
+	if (ret)
+		drm_bridge_remove(&bridge->bridge);
+
+	return ret;
 }
 
 static int tda998x_remove(struct i2c_client *client)
 {
-	component_del(&client->dev, &tda998x_ops);
+	struct device *dev = &client->dev;
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+
+	drm_bridge_remove(&bridge->bridge);
+	component_del(dev, &tda998x_ops);
+
 	return 0;
 }
 
-- 
2.11.0
