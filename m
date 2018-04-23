Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeDWHYl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:24:41 -0400
Received: from mail-db5eur01on0096.outbound.protection.outlook.com ([104.47.2.96]:14240
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754268AbeDWHXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:52 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
Date: Mon, 23 Apr 2018 09:23:00 +0200
Message-Id: <20180423072301.11962-8-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423072301.11962-1-peda@axentia.se>
References: <20180423072301.11962-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:TmUcfR3BHGXuHa3zm3DPQmO/uBkSzTTxdnbwceoYVFfC2Zr/O/HtmdHY37ETtFNL+oCO4/B1tXJhE7Dquvdp9i29kf1H0qfptAHPlOr5JqV73R2U7GKFwe5XpbM1sdXKvmyqYQpYyALiHr+jvWkHpmYiPO8Zp5mTgGFcLHEkACkI7jt7Pu4hudjUi3AdpgbXnzLN75OBzb6LB4RjLP/tPrAAD8+f9QnSkMa4KwiLb+OFGynAOCADMhVXz8kMRqYa;25:SZIOE9DpfDSzkPGS4+B1OV6V+5DjlIILVnSktVrp6CI7B/LeLLu0UQ5v3rgJGeqs3PENv7uuOqz5dKNgG1kyxRIVuYGClMQI36XG4ZK7OMrCsOMIwd79PuKafDmdfUVf9enOr1VGrc33+O5W9HlzqJaHtJHl4Na6p4S0oj3eOZ9YkYQ9DwD/3QZo78gTRiIEV5jM4K7WGUpiK9qzgzMuwqGdJ/Qh+ll1ftBQIrFShNOKK5MjJ7Rg3RMeWbVTdvC7rGnmmCwXY6xQHdIAFqtc0xuBbayuTbBNgllJ2cz2A15sR5a1/Az1SYopMuispe30v0nm7tR69fEf+u38vEYrGQ==;31:Np5/h/Npx9asP0oQHhN6T49d0BHfW2BMMaOqGqMzlGtS8NrnmOrJiigxYn3geDtn+9PERLIEPojlY0kk5/wdg7ulIlqYEIM3Gj/M0UcF/zDcUG2csA6rNc5QHJGtL95ihisKnYZ8jyIRDhiNf2HHwGCvdVkcLQY33s/o89jR7G6P8p9hDLweS5gy2TR63J5laUXuEG/oD9U0iBraNakcDSsQZxGWg4NlVyfSw7FKpRI=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2774FC5BF29E9CFFCD7085B2BC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:bXdmNRP7k6SRM69GE8ZYqoIa09IW/b5mv2VE81BXOnuUhig8dmTBYMDXA+nHwiM0WpRvfUrpJnPGERBU6E6aU9w+HNNmq4FTfX4Lnmb427tiyMTcHv8Sf9qM4/HL4OhuUV/aOVsgt3RqQg7PiLGTShBp3Wz3Zwsefaxl1qTOcQGZOjufx+TgL7Rgl9PxKcXRmQWVP8+b0EMnkJz41IIrcbLAULQ93celIolZ0I9QAItEvHApe5IljbjyrskJJX8o3RliUSgZiJsUX/d53LJONVqjl1PQLg5WrCdHVnWgI/cWQrDA2y5Gjq6UXPvEalr8
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39840400004)(6506007)(386003)(59450400001)(2351001)(25786009)(2361001)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(11346002)(76176011)(478600001)(52116002)(66066001)(86362001)(575784001)(2906002)(446003)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(5890100001)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:iSM0c6GUutkOrzKfM83mpBvchkzxJk9YNvj/12a?=
 =?us-ascii?Q?IRyTjKFX3hNF7qV3zBEqebmseUgHVst+5SpYOSURyEoTxtdI7+W/KFkyv8W2?=
 =?us-ascii?Q?Fb+yLtB9uVRHaBvxFh9fm2ErPHU34HHZOmydA+TZ4fAcmKxjqHIXgFg2vJIZ?=
 =?us-ascii?Q?as3RRg5aHF/fxmWejzt9SZNL0kkjcQ69AwumhunzBSfmaJdPVbBiLm1FO+Ui?=
 =?us-ascii?Q?fQbCdF6nmkKysQI+yFygwBZw+NYXuboHedFY+g2oKAvKtvT7BN7RHJhOODre?=
 =?us-ascii?Q?KN4SOKZXM8vzRaT5Z37EjbxEkC7wc3r0UjyqHLqSgsskRXsqzj6neJbv1Xio?=
 =?us-ascii?Q?b7rb4CG7CDo1KDYovpvVZc4+xTVuFkJfQ3pSNTTxN7YXwOCx5Di21euU1ISW?=
 =?us-ascii?Q?/XNenWpit3xJf7TwAjDibhW1oAAYy3ujLCoYzPwtQ9YvmHBL1Pf3XgEvMRff?=
 =?us-ascii?Q?KwjwiJkD0M4SXfHpolB7PvOBGchwA+bEntsMM31pJ2+G+ULOaG1ppTovVu8f?=
 =?us-ascii?Q?KBQiDvSOkNz9ssZzKdVGU947cZpOMpoYILRy31gLqewbIXfApURwBStyLJXH?=
 =?us-ascii?Q?+VUj6uZ1mMden33Mu/WiSTTzn3jPdHR/0MfgiGO3kmx4YM4upu8Y8caRW78P?=
 =?us-ascii?Q?i4vAkztRVwS3TjNfXOu/s/QjslDFzd/eOWKmJj22u1A/ycg/rdLCsFBNXOiR?=
 =?us-ascii?Q?1wgVeMDN0GWF3tlA2mKS0ttVCi/5RILIa5y5LnbNb3Px6N1WiqRJ2UjYEFeG?=
 =?us-ascii?Q?uwhTKLeUmpGxB9DuGMJ1DKQDloGkPkpbbgAn2c3GhA4iMQh0ITlPJayfnPzb?=
 =?us-ascii?Q?m9oiZxlhg0nrcjQMmh1J2Ne0Eim/WRhojmmRYKCevsqoo5f7sQcmn4b5poiM?=
 =?us-ascii?Q?iSAhpr52B+9ls9iRBizr3fIjMv7yvNDV7cnDh1hGfPJ1PIQjA/FK9Px9PDSV?=
 =?us-ascii?Q?PterImiip7G/7I/hVfGmnj7XXbqjHtYFOJBmhVMLmMnc9MfkseB8lXgC/apG?=
 =?us-ascii?Q?bGqzt0Q2zPO+WsAviBxktrdmEq/YBg0H7FPfm30K/l53V8rUx4R3fGLrOCLZ?=
 =?us-ascii?Q?o5ptVZ5EYP4uO0646wHYdQ/kvECfUY8BpE3V9V0THhc55C8MYGoi9TJnqldF?=
 =?us-ascii?Q?c6lOIeYtMAArAJCjTRypN0n5QiSJKEaWK2Whcw5t4aqjmdDQ33qXVlExqah0?=
 =?us-ascii?Q?6y+ngXZmMUk927/WPhWRAuRKRUS/5PUmH7OFplU/lNpkitMTIGyGcAYIzxQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: E0bDmcfoZsuxkFRGBNgBaHWGGmeAAXLxh/WZ8mFQFGMC/pywuXyzWg987Nh8YmI/FT4PoNJEsvuaTYJExuCPKxG/i6qEM2rxOEP9dbIKJiRSOGXb6iTm4Wi4Nv8zK/tfGooFBdTbxeybC2apRw7p/yaC5qb/Ne6/+aHSJU2s6+7dEgrFAC61Ggo2YweJUGUM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:g5ZyRSG4o8QlRc+5TSQvqjgHvmShsYod+Aq6fwA8HBhbaGuoNB7ONv3YAkXeauRCDtELb/SGOedaE2+M98aVZFeWepMfwtUO1Xf00pM7Ga9Cx/5h3+EpcBPmA2nCPg8nCcmW47cZmh7pm8HHagnBZno2rWnA1byEo9vvMgjSVZ7uLVuYbJerAX/oa6E1EQhJJTvRT8C3g8LoOlPiYlTu1wOX3qL5q53HW4EjWRzmX7lb7Ajm00zq0YvUlMWRZJECo3HnBtQtdyWNAIMEdGyJ8byxr1+rGy7ZsP48IArSbVnwoAuMIygejSWC5TGidjgs1yV6DV/5yGLaoRAGmVEryMaspp00RbD107puS6D6dX2SWmI7VW2KBkvb2QsD3tsc+XDWu5LJ/F71JB/0ht59xSYdQMb6j+6GbqvjhD1O+DbqmVQSMiv3E9i8o0Vm9RJGeoW0eALynGKxaT4Y65qd+A==;5:xZMlmIXKizhHXZ+nBd3v3UrQcEJF3a1uEpjCWY8P/zEDke9XmeeZ/gF9tdg75dsiA10LB1fXBLP8WI7BHWXG7JhNNzARPtcXYhO1fKfTXXkliJDGOv3THSU9vTuxVeswJr9q1tdpR4sgwaziPwvdNAEdGYbcUzfCugUsNFKvLGM=;24:yy7U6Tp1zjc6KvsozujEoV/ZAWlsQ1Pb/531W/jojnId5xztspe6fBo+SkeANym6Epza1KoGlVtMmF1kAS7bLvFU6wfZXZAYFV4WDU0dj7A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:lfoiI5idIfv7axLrRQ1PghDtFgnv51YWpFTp2PGCdXd5OV8CWerE2ZRbDdTGv8hx/hD1O8FLT1SPs7Qq6S8a36EfXbBJmXS0PDPu8JK1OCI1RZOMxu4hETpsBva5VL+aWdzSV9rlpskpjN1VekNjUl/3phAO8UzPOelBLK6DCqmXvUyFmZ6hd9hy2htWGKmIi0QFwtEJcbJEZAHKZwWIfUK8xn9akO2avzziraDYj4DDbr3NPO6A9AUpXkYcVJyr
X-MS-Office365-Filtering-Correlation-Id: e43f0457-84c0-47ee-24b4-08d5a8eb2936
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:49.2956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43f0457-84c0-47ee-24b4-08d5a8eb2936
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
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
index 53fd0be076b4..b8cb6237a38b 100644
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
@@ -1672,8 +1694,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
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
@@ -1684,18 +1708,22 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
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
@@ -1704,11 +1732,15 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
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
@@ -1717,7 +1749,8 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	return 0;
 
 err_connector:
-	drm_encoder_cleanup(&priv->encoder);
+	if (local_encoder)
+		drm_encoder_cleanup(&priv->encoder);
 err_encoder:
 	tda998x_destroy(priv);
 	return ret;
@@ -1725,10 +1758,12 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 
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
 
@@ -1736,7 +1771,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = data;
 
-	return tda998x_init(dev, drm);
+	return tda998x_init(dev, drm, true);
 }
 
 static void tda998x_unbind(struct device *dev, struct device *master,
@@ -1750,19 +1785,100 @@ static const struct component_ops tda998x_ops = {
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
