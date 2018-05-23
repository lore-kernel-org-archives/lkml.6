Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbeEWJeY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:34:24 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:55616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932287AbeEWJbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:31:52 -0400
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
Subject: [PATCH v5 3/7] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date: Wed, 23 May 2018 11:31:18 +0200
Message-Id: <20180523093122.27859-4-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:3qSHW6/sJPq2cFF+9axB8RqesWmDszh4vNFNwBqiTNj3enFeLRXpAefO8q7HcOTKgAPonGkd4xwsc6eY+QJwMq4OTsn1r/8Pj6juGIcn+NJ7gY8fulZtByBdLh+u8GezcIB4+UolulpWy8rhGdaPdkiTY1vyzmYtYW4BI0sYv5PLILO/jR+IdcQRKF0GeQYmn7jMJZlVWCzFkFvjYqzAxSJoBG0genbJiblDXExUywueg9K4QiFD+qNFIgDGDTM1;25:C7tGVf8ix93TB7NUWmK6tYdziRMVdUvCbkWg/hBAP5kST4x1YRacNhnwnj99ErebWVoqzF4tK0y0Rnlf7eRR5GJiPT/RYn6rn4NH+EgNfN5+Zdpuux/zOX0hq/84uuqY6ycdX/cT+zgTp0qtMjajcAOSnIRGg+nL6Q7X4uPA2KecxChqD0m7FKNn6d77RhqShMaQUimgvLmjO/bAogezx+KWOA5TJ5pCzLWxk99i6EyXG8e7vZhpBriw85b00GHCkpsPzXTxg3/u9VWyoHq/p5dawjWtn90G95qpxzUHBAF1bqZyF9H6OCr58qQC5kjkzA+YOEG6spD/iILbGTEuNQ==;31:q55gBEKKbn6XixFjUruM5M3WOyfIxNG6q+zYlO3s4LawU4Z8RpF4qb26S4KDKhR4cBTMv5gDn3fljR84y7770ffPW2P+tD26GD7S2Or+k50V1kjqsQkbnEz5HYP/kwvihAp845jShNWfMyJwNCYdMCcIsmVcM/BRQn+h6/M0MfzDTNji0iLlne3hOtwMvJcRXCR3SlUiOl3eXuH/3z1EcRI9mJwxQ/YFC2tWPa+4rSQ=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278298EFD28C6B1BB4FF41BBBC6B0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:rr+kDSYzaECWu/7ZsgBqFhX7/gCD0a+NRaPkkUCR6v9SwqubXab1vOELZ/zsRp/vJ1aP2rHeXrCvVjgX0AZ8QMPV/T5mNxhZouPzsVPW5XJkuiNk6+Ow1v3dGzPq4yOt+VWY9rxSbs+wZJ3ag7bU5Cy4sfJcolFDYEpUEk3fAe+EOLprkD9i/RV1RI97/e2k1XuRV2RWKODZrIqcz0UNE4Mz8qpHtAlWzwC8ST0rlnLGF7azC/TrdM8oCefCIuFGoWqMGPWF1zEmKvpv8s2F5A==
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(39380400002)(376002)(346002)(366004)(189003)(199004)(486006)(68736007)(956004)(5890100001)(476003)(3846002)(97736004)(6116002)(478600001)(2616005)(5660300001)(6916009)(6666003)(53936002)(2906002)(4326008)(11346002)(6512007)(446003)(1076002)(36756003)(575784001)(86362001)(16586007)(7736002)(76176011)(52116002)(51416003)(25786009)(7416002)(305945005)(8936002)(6486002)(2361001)(48376002)(106356001)(66066001)(74482002)(50466002)(47776003)(26005)(316002)(6506007)(81156014)(105586002)(16526019)(186003)(386003)(8676002)(81166006)(50226002)(2351001)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:LHcu1f90p2ImcB3m4dj9bY4sIjLmkQKg9PzGlva?=
 =?us-ascii?Q?ansU4n/J9q9deQCvAFFbFQjGb5EY9trVuVRXKdhlm4qC1kTH/r0INljKGENW?=
 =?us-ascii?Q?WvEMP1GQnShz30SZ/0yTV9N4LunU6sE7UkU758JyT8NuaWhlA+L4D1voq22l?=
 =?us-ascii?Q?VWPHm/a7VL0DeZDgn0P1hS1KjJLdY/nu0ClJ50K23D/gHB95KDf3LASfWc68?=
 =?us-ascii?Q?IPYdGZAijAlofgeXcHETfF08QoQMdXHtLXobIXXnGNinfAe0c4dz5vS6FWT4?=
 =?us-ascii?Q?u6QSR9F6D22l2ijNKj+7wwOpYjzuqeBzWUm0wlopl5rUzs5Y/QpSC+TLYdIt?=
 =?us-ascii?Q?mtuPn49G5Vf2ycc2RpsLT7bGUWwEGYZDnXMuE1UBtt83gdXDHDQUSaSxIrkH?=
 =?us-ascii?Q?XUAQkwIvuDWS+0XJjWFRo2kBkJCwson6pGGsI/1HFZgh+OGiLFvhBC1rJ0mQ?=
 =?us-ascii?Q?/yTcNC2tCeGG0zGSzcFdd4Qia8nv3WdH5kzwQpk6x/VJM6YqgsN4yBOSifUX?=
 =?us-ascii?Q?W9OCpHYcjEyk6fzCMoL7MyytVCfrW5QnViT7vWgO2pIXngf3pxcMRPJXDXLm?=
 =?us-ascii?Q?qmRmkHqfvfacrWDoJWleRrlmD7v56UXk6q2TIupm9zFCTPZ18SRw+IcX/dfj?=
 =?us-ascii?Q?kZ4Tcb2zpprUJzW982OvMa3lbCWQuFicN0/qa8KLTqGhayNt6+s95CSlALHp?=
 =?us-ascii?Q?Ok2ySqSbDXIduMUk/XTMSs5clViZWB3hybYwcfZGHhIjy7hTjzTmAPFVWcZL?=
 =?us-ascii?Q?I/C/nwddndtMFLWmM3uHakPZRr+5QmM1bfPMIohoGNOe75du9oOrOb9tTBfA?=
 =?us-ascii?Q?Kho5I6ohoK9avMrFk8A9CBUknVfqe6UNGXyuI0rXipKzdfxIZ7q4CCioW4Q9?=
 =?us-ascii?Q?es4owex+XCLcDdakwB9utnedOB6IT7frSQ0wWSyP/On7kuY42RqWasvQ/Djr?=
 =?us-ascii?Q?d1mEhZ4D7EXW/J1y7uH2GpEEIWEB4HRNoMKHmW4b2jDAeYNb942SLGghq3ps?=
 =?us-ascii?Q?ASQtf4BXK6v619qlUmc8WzfJnTh/ZpEnYYADNmR0Do7n5yzIglSu73l6/vta?=
 =?us-ascii?Q?sP0aDyTPhUIMRUvcScmyb+uhKRnstXmtOtlk+P8juz1BgM8PYbkcDFu3Sbtq?=
 =?us-ascii?Q?zylX4OJFsWr/exaRy/UbZddQ07AFME1cPBdFOOZb3juS5Zoxcwud+0uLqUCl?=
 =?us-ascii?Q?m2iZDoYqropgK4OTeXPRGi5XDUyzWDrxbmNx/BblNDC/xf+sy+/mIQlYeSQ+?=
 =?us-ascii?Q?NPOI8WlyO+6jGUznv7Ee5BxghfiLhdW/AucQBVBlLAKo9Gp5Vnn54s6WaLgI?=
 =?us-ascii?Q?IzxpqNpIDiZFjz1la7BX8DEVl3FCM1gmctND1dzIGRk1VlJKZssduMbLVEQ8?=
 =?us-ascii?Q?lxSI+5tgejgUjbNmrDpjwpgHNo+c=3D?=
X-Microsoft-Antispam-Message-Info: Me/2Ddyp8/YKB5uU0QQ/M3LoY6RbjcE3jXarNaHLc8x8vGAdshB5Mjol7etaek5LBASSu3Bfj9fuRDaKHI4Iq+oNm+AaAHZTAUDEzkiF3YIcu6pPxc88YQ9tG49xnz2ehJIIEUk85wzr5Zxf660tKFl87XJxJ/prFwUJU2p0RR1YHTwgerHSW8JxitX/JXrx
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:9PebvOg6iL2IopLUsaRb07fkozMVqoNxWE2+q3slIF/yT6DWQgdC0ZSAFJiCqKoAdUxcnwA+cM/lIgt91gwCStyKVePKOwBE7uFYw2Y+W6vtQk46RaocA7v2KXjqjzrbOFHjZwQsayJtHZHK1HUsVs7JITN6MwJ9wemCzUwmGswgUTnVmk2S+XVSX89J5+nMb88qZjuNqfTgIbjc4N+X0b9wT8okdKftTF3/KcgDtDP55st+Xqe7NiuRJ3u+0A7jSettYbSXP5LY5zQ+YVMvpRYxRCMn+aHLnW4cnRokvIprZcb1RXdvuBzvAIW+vPy+zaNC9Mfqq5CDCeNrZp+oN2+U8ZlnWiFg3C9oTyJr2Pxyt4IwcPrdqsQr0m3Uuzpscpzk5X+aslPav2O2zR2mEZUKZrREjrhmP6Ss9AUq6nN/lGhGjCMdY3t0SphvPbMQPRDO8/ymxYWYl+VTCZp+oA==;5:+HNesvhh6M2SBI2VuVkCmVlBdLzALwAzqDbJfCDWIUumYqfU0z1PxIM2UeWD0FOh5sbZXGeiV6mSgZdaCPSMMQFJ+bpMeKgh343dnIZ9Kzjzr4pRhG8ChwzaJ3hoCPVL/KXlNTqIcDLdc+rFfDXAp97QNf08HP8hdrRoK4QejTU=;24:7w8AutXQkSMzYFNcRHePG3CbBBIUPq90WQ7dfHsaAdUazlfF+F55Eh608J7F242QMo9BMXMuhLVoAqAW8qXoV0t5puSbJ2DQTKAum8gpDSc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:bMpIClsL34HN5Iz5or7MiXJwz1Sw1eu1ajom9ynGZE4gBbsMfDyGhdolCGspOsFHkK3FhFDnvpy/5x8yDWB/rNxWWvsfmXlSYHVccfJwWL5bTsdgqfoFecG9qB281vWTC6wBNg3EMHhTDdul4Azweo0552F3RkH30f8TI/V154GZrqeiFxP4edrBk8gs6g0ll9nTXHcRkEvojYZ08vtnoKf6GHQNWhHvylvML/+PP2VFsv15eOx6BDYqb7teFnXQ
X-MS-Office365-Filtering-Correlation-Id: 92b26ed4-86c8-4dde-c92b-08d5c0900186
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:31:46.4557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b26ed4-86c8-4dde-c92b-08d5c0900186
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This beats the heuristic that the connector is involved in what format
should be output for cases where this fails.

E.g. if there is a bridge that changes format between the encoder and the
connector, or if some of the RGB pins between the lcd controller and the
encoder are not routed on the PCB.

This is critical for the devices that have the "conflicting output
formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
RGB bits move around depending on the selected output mode. For
devices that do not have the "conflicting output formats" issue
(SAMA5D2, SAMA5D4), this is completely irrelevant.

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 67 ++++++++++++++++++++---
 3 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..c38a479ada98 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -226,6 +226,55 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
 #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
 
+static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
+{
+	struct drm_connector *connector = state->connector;
+	struct drm_display_info *info = &connector->display_info;
+	struct drm_encoder *encoder;
+	unsigned int supported_fmts = 0;
+	int j;
+
+	encoder = state->best_encoder;
+	if (!encoder)
+		encoder = connector->encoder;
+
+	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+	case 0:
+		break;
+	case MEDIA_BUS_FMT_RGB444_1X12:
+		return ATMEL_HLCDC_RGB444_OUTPUT;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		return ATMEL_HLCDC_RGB565_OUTPUT;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		return ATMEL_HLCDC_RGB666_OUTPUT;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return ATMEL_HLCDC_RGB888_OUTPUT;
+	default:
+		return -EINVAL;
+	}
+
+	for (j = 0; j < info->num_bus_formats; j++) {
+		switch (info->bus_formats[j]) {
+		case MEDIA_BUS_FMT_RGB444_1X12:
+			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return supported_fmts;
+}
+
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
 	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
@@ -238,31 +287,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
-		struct drm_display_info *info = &connector->display_info;
 		unsigned int supported_fmts = 0;
-		int j;
 
 		if (!cstate->crtc)
 			continue;
 
-		for (j = 0; j < info->num_bus_formats; j++) {
-			switch (info->bus_formats[j]) {
-			case MEDIA_BUS_FMT_RGB444_1X12:
-				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB565_1X16:
-				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB666_1X18:
-				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB888_1X24:
-				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
-				break;
-			default:
-				break;
-			}
-		}
+		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
 
 		if (crtc->dc->desc->conflicting_output_formats)
 			output_fmts &= supported_fmts;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 60c937f42114..4cc1e03f0aee 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -441,5 +441,6 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
 int atmel_hlcdc_crtc_create(struct drm_device *dev);
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev);
+int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);
 
 #endif /* DRM_ATMEL_HLCDC_H */
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..db4d6aaaef93 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -27,33 +27,86 @@
 
 #include "atmel_hlcdc_dc.h"
 
+struct atmel_hlcdc_rgb_output {
+	struct drm_encoder encoder;
+	int bus_fmt;
+};
+
 static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
+static struct atmel_hlcdc_rgb_output *
+atmel_hlcdc_encoder_to_rgb_output(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct atmel_hlcdc_rgb_output, encoder);
+}
+
+int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder)
+{
+	struct atmel_hlcdc_rgb_output *output;
+
+	output = atmel_hlcdc_encoder_to_rgb_output(encoder);
+
+	return output->bus_fmt;
+}
+
+static int atmel_hlcdc_of_bus_fmt(struct device_node *ep)
+{
+	u32 bus_width = 0;
+
+	of_property_read_u32(ep, "bus-width", &bus_width);
+
+	switch (bus_width) {
+	case 0:
+		return 0;
+	case 12:
+		return MEDIA_BUS_FMT_RGB444_1X12;
+	case 16:
+		return MEDIA_BUS_FMT_RGB565_1X16;
+	case 18:
+		return MEDIA_BUS_FMT_RGB666_1X18;
+	case 24:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 {
-	struct drm_encoder *encoder;
+	struct atmel_hlcdc_rgb_output *output;
+	struct device_node *ep;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	int ret;
 
+	ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0, endpoint);
+	if (!ep)
+		return -ENODEV;
+
 	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
 					  &panel, &bridge);
 	if (ret)
 		return ret;
 
-	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
+	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
+	if (!output)
 		return -EINVAL;
 
-	ret = drm_encoder_init(dev, encoder,
+	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
+	if (output->bus_fmt < 0) {
+		dev_err(dev->dev, "invalid bus width\n");
+		return -EINVAL;
+	}
+
+	ret = drm_encoder_init(dev, &output->encoder,
 			       &atmel_hlcdc_panel_encoder_funcs,
 			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
-	encoder->possible_crtcs = 0x1;
+	output->encoder.possible_crtcs = 0x1;
 
 	if (panel) {
 		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
@@ -62,7 +115,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 	}
 
 	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
 		if (!ret)
 			return 0;
 
@@ -70,7 +123,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 			drm_panel_bridge_remove(bridge);
 	}
 
-	drm_encoder_cleanup(encoder);
+	drm_encoder_cleanup(&output->encoder);
 
 	return ret;
 }
-- 
2.11.0
