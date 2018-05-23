Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbeEWJcS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:32:18 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:55616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932337AbeEWJcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:32:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>, Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v5 7/7] drm/i2c: tda998x: register as a drm bridge
Date: Wed, 23 May 2018 11:31:22 +0200
Message-Id: <20180523093122.27859-8-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523093122.27859-1-peda@axentia.se>
References: <20180523093122.27859-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::23) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:5R+kk/CmcJ6Rm7fBDDG99uLzNDRfG5R2NduPXrIhXvcpsOBUxGAGjk6UjhpwyTAjAlbjA2ZG1j21X2PEM84RDTqmxHXu3NNZuEHKmyOqn4FOKp5GoQvA9eqKr9VcyjNC2hK09C7CCikBgIDXw3dxDSb64fezaSFfCPR2FEZRJORI7Ko9/hHtI/EhQHV4vOZrfMpvKp1ZYWfOnQ0G4InNJgaEVXRcc6ZxXET8v4NI4AaZkfT9aGZ/hHHn2uGlIwTF;25:Nv+n0AxQUhvMwLCor7ZN8yO65h6FvUsCqV85EOBUxil3Iw9ETQ/VRvnJO9lc1NDhBIUfLjTJtYWEkloIxszPWKKccFBjdMl0EBWV0M8FLksjrPVeAfzxfGY28djIqXE2NpdGeuis3deEIL792v3smTihDqIWQ4vzaET+/JfMFpboY34b5/L6v2hTiM9qIY5TrBLtJv2e7JgLPdl39szL0Wd/SFZr+RAybfWEZNjA/lGek9aNUbIXLhMzbNzPg/DMRW2XpqlkVlirnImwNj8tKdzi6vd3ijYyCiR31KkxJiBhBnrOZg7DAG0VWqbeT822oPHN0MnoFoLOPC9umo2aWA==;31:zDgUgKYP2gVXwGPqbONl+iIr2wMXxatAPiAYIk2tYFzEK4c1ikj3iQt4y4bHV17ANGf/J4+WdM+JSM+KZfABbqaPCmi+VtOe+8mN7ePZo7D1ANRqv7Oc1edsN5LuR9BY2Y6gnrJuif3i10wJJSFaVvEjfCA1YSXrecaA8zNSCUdgpB2qPA+fG8X1M6e8229poMkQaCLcm0SSzTu59cEGHhjyPyVl5j33bYXqi/wnY74=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27824B4A6C03FCD01D557EF0BC6B0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:8yS41JmK4Ug6yZnr0fAKx/iNF+17xwgp29px56TqGbxPsA/mdaGmayrwcfX2HnRF4WM9AtvIADq8d2CzV8+k0m8i4FFN2gUjLwDyMzJB3+qec2g3JAdVdfoTrhiBhpyo+o9mQ+LbL7GbZhrARfIT44+a7zQy/bLo7preR6v3ZgiLEdu3A1eHmX1PJDVfu4Tp4addJnL7mqe/iipCXphuzhQwNwTN8FRWl5jQGmF8CsJ7QdvfA8vLiTuM5irib3K9ywnWQs+hMW9kuoxSrC28mkP6R1HuAiYiNJSK0Ymy77sD+EeKbgRAQjcUY8r8YRtX
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(39840400004)(366004)(189003)(199004)(486006)(68736007)(956004)(5890100001)(476003)(3846002)(97736004)(6116002)(478600001)(2616005)(5660300001)(6916009)(6666003)(53936002)(2906002)(4326008)(11346002)(6512007)(446003)(1076002)(36756003)(86362001)(16586007)(7736002)(59450400001)(76176011)(52116002)(51416003)(25786009)(7416002)(305945005)(8936002)(6486002)(2361001)(48376002)(106356001)(66066001)(74482002)(50466002)(47776003)(26005)(316002)(6506007)(81156014)(105586002)(16526019)(186003)(386003)(8676002)(81166006)(50226002)(2351001)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:ih9Szgagk2d1wJRYkfIpP4cSOPN7/B9NXaFM41d?=
 =?us-ascii?Q?Dkuo5ChZIbX6hhC2NIRo+JQ3yYLSECk59VWqmGa68dMdagoOdfu9pCAu2wiY?=
 =?us-ascii?Q?wJ07nUKlPsHr4fXTzhTi9DV8/7ih7WIT/DbVm0mmLAe4VBydVwUd++zC7BBv?=
 =?us-ascii?Q?UOgobSOM3c0hIS0KN4fmteptfwQ4JDSnudhmuGocRjOiYppz181fAJL4K2/d?=
 =?us-ascii?Q?arG/agti6yIWXbINnQYoXqRIcJ5Y8ejHHTeUvd6SiOu1toFIU0rs7mkqACX/?=
 =?us-ascii?Q?Zr8syyXqtxl6YHsZOk78lTUyKcafcoKILlH6XAPjHVD/KooP+aCQ4qsAfbm1?=
 =?us-ascii?Q?WlCmWaCTRZ0YgleIusDTIwRy/rTgkC2ZSBA/u2hhzvEuriurGo9bsmjuvWQz?=
 =?us-ascii?Q?Q2psPWMCwHnbdCA0NB72nrFYDP0hQ1l8e79oRtInVMJSD0pAdmitiiLwffLH?=
 =?us-ascii?Q?dnA8ub15UasCvqdOxsHYEVmkYjeWjXBGpLVYEIEh0YdyzFvN1C3aDcL8YoQg?=
 =?us-ascii?Q?6rZ7m18rRYoysdizLNA8HxE7oTLcF+trpz4mw9noltsUKvqTVib3t9HBkOgQ?=
 =?us-ascii?Q?GVI9kPThUrkoOJrc7YeQkfn4fLDDDbi2fcJW7inJIJKKL67h7Y4CNt7w2hc0?=
 =?us-ascii?Q?kIZtglaaLO4l5M9sU2gXhwEvp3npBr5ihfDrG4xRZtn/nb05YIVlCL1nrZiB?=
 =?us-ascii?Q?6xAWmoa1NknJhQfSQ0lJ/rXwU9uS1tLzJpk+RHgJoh+bJ8rHO9APSRb89hpc?=
 =?us-ascii?Q?G2zW4s9gVEvBc9Z+az76cH9MwA5mHKHhdAvYo+pEx/Ij9CE9I6vo7j7sGYlb?=
 =?us-ascii?Q?3jnit9lMUHotYScRWTWKCk5PDnzK3WG5UXp6kGNHsOOdZc6uwne8z/9bCGPz?=
 =?us-ascii?Q?WMJaRTDDmpXBA5mrWrysnFyjqfoHTSwHEuaOAAzIcsE3GkrCHtAmIW/bF76+?=
 =?us-ascii?Q?Oz8XPYs3mm3gvjaSLc4Wl3tTs4MIAkME7538EmVj14W7UCpOVaXlc7TyxK1o?=
 =?us-ascii?Q?vAalA6BFWKlo+n2pFw5/Y56VSQ0hWWYq/bmmVqh7XYGiJaseoQRkq15jso2c?=
 =?us-ascii?Q?e3zW9hZmEFHlWo0JcIFSfOC2smZ+7VAmSa374r0ZcW8QYuizVRE+FvMF38M4?=
 =?us-ascii?Q?iAVvs77lrckn5zw484u938i0a58ZvfsSmkKkk1iPkjC4xzkfPigUVAgHaQMg?=
 =?us-ascii?Q?+BXeXi0URmu6bu9uF8gdUdvpXkC1UTih5kWCab7NdYAYikbXHsFUvVcGnYuy?=
 =?us-ascii?Q?7rPop1qeb6Pfn06JKut5qANx5khq8i2nJ8f8srnZnBiPu0MWN9Eb+dvZjgcl?=
 =?us-ascii?Q?JGmgePsT4sD2pj/XyEyzAzfFSou0Tx0hdFPnvwCeQrcNxKgGDo7hMu9FgP9X?=
 =?us-ascii?Q?8ESF7GSpfH9HbP0GBu+YvvKOC20s=3D?=
X-Microsoft-Antispam-Message-Info: yEzSTwRENC4t74y7rkPxT7wQ1cWJN8T/YSvcLgFq1eSqM5YrmjWLdsLRWHsgp/p0w0dypF/tJ6ISLN4hvWIBVPxT5YC7o72kG4nuj3g4UejTkGoeSsUW/Abv4H2lZrdMCexpYlku9AHM10HnIOOH4vjLCnYTlbpEIMBHlLDdkJmmPD34e0YHCwoRR5uFxAL0
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:DxTYL9uWK8zCgJh1DYnhrNWmc5x4JnEbYs0NauOlOmCK/1aaL8z60zaWnjTB/B5kgT3u26v7/cziDt+loaMM2wqwEylLysnED1KjuXXqCbJmruZj6B8aeb/2DgsCB8Qe50YAiIKQCeUkL+Fgy+6UK0cTm/Qba0Hp02JrKIvNf7pfAQ0MuWiTVwkqWwEJLWMqFBfoelorVEuHLAINcuzqhV31l3kQx2N8AsHDk+pz/wutE9GTNm4//vEaAtAYNc39L4ZSw4zzyJXAdGVAUxjXcCN0+itEmFnH6whr6dG6je9JoV8xuoxVXC0dAi8dzPU/U5EhHuQy+wovsiG3VXVOMqW0B+rSKKAxfSdpLX4RC1SY9QKdyuBw4YKwFwnc7DhASCavubo3Hp9nYijN2T4QocdeggkmOcmwHuRG6LutFBhr0w8Jko0YOCJ8oHh06fldTBzDQwCyNL1/WF52eV/Jww==;5:V+K/iMlLe1Sg8h+7sfw6ojpzhXre8RdSgpwi/7raeN1vP1ki+GBfjg2xJLFpp3FvTgm85G7vvoL62SnuALaZdZMhZS9f/h5FvfaR/9qUeNbjqjJYsxiKVNeMzGko/2K3eKO5lsL5BIps9KdVPhjW06iAShT7ArKsqfM0v8lcs0k=;24:a0LZZDAAvTr36H4NUnFdRPjI687Z0okoURUPRvdatUI2eDiP6WkqfUti6qdbPrqua2hn4NyOjhh93g+/AXQb8uzN1ctaFrylQ1zdB4J4OF0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:4gPRna8ZnM2FZpoOqJP1Ht6nG7oYmHgyqQgVTwManrC066DIrqa0RoryzVq0aUfgzaAjtCdBELdVBxZ2vlpPRXabLo87EioWZuck7FfSy2sWvukxHuFJeqMa/YJ0HRjrQSozGS4UY8+tsFJd9GLlbZBHgAm44XjbXMSC2rePIKxKK/IAo+xq5uIoxIyb1dWxFmwPfeExKtFTHRzVlo+p4LHmFXudz+pUBz9628p2a7yrMK8Y5TR7Thlz4/oVURbP
X-MS-Office365-Filtering-Correlation-Id: 33797643-a8be-4e8b-f9f6-08d5c09009b8
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:32:00.2015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33797643-a8be-4e8b-f9f6-08d5c09009b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes this driver work with all(?) drivers that are not
componentized and instead expect to connect to a panel/bridge. That
said, the only one tested is atmel-hlcdc.

This hooks the relevant work function previously called by the encoder
and the component also to the bridge, since the encoder goes away when
connecting to the bridge interface of the driver and the equivalent of
bind/unbind of the component is handled by bridge attach/detach.

The lifetime requirements of a bridge and a component are slightly
different, which is the reason for struct tda998x_bridge.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 170 ++++++++++++++++++++++++++++++++------
 1 file changed, 143 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d401b3d0095c..d47e49c2991a 100644
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
@@ -1671,8 +1693,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
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
@@ -1683,18 +1707,22 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	if (!priv)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, priv);
+	bridge->priv = priv;
+	priv->bridge = bridge;
+	priv->local_encoder = local_encoder;
 
-	if (dev->of_node)
-		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	if (local_encoder) {
+		if (dev->of_node)
+			crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
 
-	/* If no CRTCs were found, fall back to our old behaviour */
-	if (crtcs == 0) {
-		dev_warn(dev, "Falling back to first CRTC\n");
-		crtcs = 1 << 0;
-	}
+		/* If no CRTCs were found, fall back to our old behaviour */
+		if (crtcs == 0) {
+			dev_warn(dev, "Falling back to first CRTC\n");
+			crtcs = 1 << 0;
+		}
 
-	priv->encoder.possible_crtcs = crtcs;
+		priv->encoder.possible_crtcs = crtcs;
+	}
 
 	ret = tda998x_create(client, priv);
 	if (ret)
@@ -1703,11 +1731,15 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
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
@@ -1716,7 +1748,8 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	return 0;
 
 err_connector:
-	drm_encoder_cleanup(&priv->encoder);
+	if (local_encoder)
+		drm_encoder_cleanup(&priv->encoder);
 err_encoder:
 	tda998x_destroy(priv);
 	return ret;
@@ -1724,10 +1757,12 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 
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
 
@@ -1735,7 +1770,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = data;
 
-	return tda998x_init(dev, drm);
+	return tda998x_init(dev, drm, true);
 }
 
 static void tda998x_unbind(struct device *dev, struct device *master,
@@ -1749,19 +1784,100 @@ static const struct component_ops tda998x_ops = {
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
+	return tda998x_init(dev, drm, false);
+}
+
+static void tda998x_bridge_detach(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct device *dev = bridge->dev;
+
+	tda998x_fini(dev);
+}
+
+static void tda998x_bridge_enable(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct tda998x_priv *priv = bridge->priv;
+
+	tda998x_enable(priv);
+}
+
+static void tda998x_bridge_disable(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct tda998x_priv *priv = bridge->priv;
+
+	tda998x_disable(priv);
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
+#ifdef CONFIG_OF
+	bridge->bridge.of_node = dev->of_node;
+#endif
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
