Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeCZV0B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:26:01 -0400
Received: from mail-he1eur01on0134.outbound.protection.outlook.com ([104.47.0.134]:54180
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752021AbeCZVZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:25:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, Jacopo Mondi <jacopo@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] drm/atmel-hlcdc: take bridges into account when selecting output format
Date: Mon, 26 Mar 2018 23:24:47 +0200
Message-Id: <20180326212447.7380-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::27)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 937426de-e648-4fa2-e6ef-08d5936026f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:/pj7HrtR0Z+YDtx+5Iw/l7y4d//JkPsOZDAGr6PKzQUAi5LdASbRBlnuJNUsLnv7Bk/i31xrq8JcCeHO1FGWaJfkRABp0DKj1Bt0VQEnL47lakIAZA2Aajw3U1ufJLmvSYHB31EEDqGwZS5dT3ZhlJ2x+W603px5gzchM1xp3ZRXMX4RAk+ASnRMKULvsaxZshA1bF2Y3zykzeCpzlX5Ly+JeaStwO/Kw15TbBjiP8olXSxbqOgGaD6K1fxPOIYv;25:ypFg1tNGrfRJRFvX1lbI9TCWYV5NilKna7ED391sbot+vdzimubqFY/p7uf09S3IwmVhXNv3EPrgP5Prh8QH+5DDoi6aceLaqr+R1CHPiLfD4iJr3g5JER8WOiSwCNt4PVrSFG89CxnOssP3pQRpR2wLhDO3DljScjkehDZsCV6h+SuXmQLXTryUjsTEAQSnPPqn2opm7fvuPj0aPFffFPBZ0siGYa+Q4C1yulxnqmik8p8KPalNKZ+oazmPNIfidSjuOUlm8plcIFyOifSa2abXLowT4EFpCkDUWslF7az/ItwlnCwMRi9YMN/E8UI8KPAvS9gyESMgSeWc8Uam1g==;31:2ls3aNR2y9/2kw0Ym8kNx2eS/fMNvkLIH7I5eTHmVshsjWZRVsxO8NtroGXnaG+00zV9/S2sVBw799MyK/tC3yRVpZnhxhds76rP1CxwDa99gns0z8LOy4WIyX85oMY7IcTt1+rVKKdOBLG4lq973EJp779Ao94a2ME+pk+6zqfmRKMMtBck6GnuxjoM9rvESbLs4Nkt3J2bx/fZbftz6WM0VoHkPlZgowlA7of1BjQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769665E3C32F04F58173898BCAD0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:KNGqsX7rJ3EKZRMYgjLSFwwa7PEHoubFJxmBjHY3lQnQG7IbFdnRXxwrqe81wlVjH9Vbnt9rqqTETjjpE6Om+wWBJGNATpd5oqn3xi8Rbh/sI5sUd1fOC1gZCMiU21KIj80IonKYIpH0qAZdb5rhsCSnMSjeZRQUTuw7IPQ0P2HpIpkr+iWWiv0INw/GnOOGgv96Ak5JXKtWrAogAGTTy3KhbutxqZBR9W9GUChjja1o0MX1mgWmOXlxCUdIaAOuMs0yAYmEtONHGfzI8A98DQ==
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39380400002)(396003)(39840400004)(199004)(189003)(446003)(2351001)(316002)(16526019)(186003)(54906003)(16586007)(11346002)(2361001)(97736004)(105586002)(6486002)(53936002)(956004)(6512007)(2906002)(2616005)(1076002)(68736007)(66066001)(51416003)(76176011)(48376002)(486005)(486005)(52116002)(6666003)(5660300001)(106356001)(86362001)(6916009)(50466002)(47776003)(478600001)(386003)(305945005)(8676002)(25786009)(26005)(74482002)(6506007)(7736002)(6116002)(36756003)(7416002)(4326008)(3846002)(81166006)(81156014)(8936002)(476003)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:1woNjwdJxb4cz64NTs08XigBujB1B/sb/4dKLka?=
 =?us-ascii?Q?rWb82kt+j/E8R1TvbWhaGrDHcWWuAUcEmlHnETJArY5hU0v+jRUrFh74lxUs?=
 =?us-ascii?Q?dT6c7hg5ErS8dmCizqd3IL9/HqMLlqdSBeY71+gL3IDFUJpneEgLrhi6Oefv?=
 =?us-ascii?Q?CCcicYMXsKhdhu3sS37EEuNxmgqJwpvlJB2fXFfH8oRVsV1Q1lpaGJv0ILGz?=
 =?us-ascii?Q?x1l6TcrHVCWCNXPZaUrBVZ+gsvZ2Zd6IJ/WtiHkg7D7cf4zvaJ0Iz9BYOSIH?=
 =?us-ascii?Q?C5TypFEdfdjob//6Ic3TIBmoRol48YXX8B7GLwilhQLTBUE19L99pf2BpYCp?=
 =?us-ascii?Q?V/x9ymlmB68/1gwEsbE80NEHlYAjkF+EbttKkAU/b0jJkpgN+EodhMQhChyi?=
 =?us-ascii?Q?nk2Nd/xQQPXWOHsv3rKXins0KHrrseX4LP1eH580eDqOg+0E9Dw6L4zFjTb+?=
 =?us-ascii?Q?cKGc7HnBOPF4LDeBkkRSPhi+wppcI19JtO1xPUWiMbdUuD4g05KU7Hp5nNgE?=
 =?us-ascii?Q?9KJqSQpHAGK8ROpjbFbO+2G91vK/jHQqj6k+xwh4HhZmK5ZzQjcLAuBVt04+?=
 =?us-ascii?Q?GpNBmCuCOkr1Y/VasAU3xnChVktBmKSJrUJnVFKST64JFUbkXciIsRoyDPmX?=
 =?us-ascii?Q?nhrYjOl8dNgnC8nuk9XtgVHiBPJLE5ra7SGZkQrsUyKa7th6R12Mw0JVrOly?=
 =?us-ascii?Q?pr9RYAQeStG5vZp9cjifD5FVQwY7rLjlhoHIDRCzOWnXZ+xENpC2EvasBgkh?=
 =?us-ascii?Q?9eAJQeSA4Lbcjx1af7GHLJx2QkU3vV/NdcobDWwwRoAypprykEMXi+i/gg49?=
 =?us-ascii?Q?SQmAAb3TPAYBn4uOSNLNMNhVXTF/dQwhOjdjTXMaywHucd9Z8ml/ho8WALob?=
 =?us-ascii?Q?qCFpMiwSYHWZWBquLziaEk4bbIPR9Xkdo2DdrurSXTQM5YU55B7gOjCI+9Rj?=
 =?us-ascii?Q?MruigSCKGOi21i5LOcPlImj/z8GeRZxn9aGfYUgQXV9XigDYKlMFzcRMaRbd?=
 =?us-ascii?Q?bBaTgHIZVH7qk/HPR6PyfO9kNX+mh9DgzYSGbTCGxf1sbDqe3iK/ksUI7wF6?=
 =?us-ascii?Q?Q5VhboLA8LrW7kxegpXGoav9iwfrADaLZ6FswMTIkMaSm9mfz9fTRufoARcf?=
 =?us-ascii?Q?5V8nbv3I+oCQ65nZYOCmczRI+DO6eL6WdaLazMmA04ILa3smDFlax12iBt+o?=
 =?us-ascii?Q?RFo0V5lj937+0pIkKsxdxAvzCy0znj9CGond14qq5h/50DniRM8krtIspxqG?=
 =?us-ascii?Q?LwylCTbeJMbL4EjL05yFrJau5TWHCUZel9hr1UyLVy2MkCufonRjlQn7g/sZ?=
 =?us-ascii?Q?1Cd52qUcTCfZVMuTWVWsnGA6I/UQysiU8kqA7mm7W4BXj?=
X-Microsoft-Antispam-Message-Info: XX06n4HjxtsLvJGzhS9QIK7QB+4T5yHOJZIH9ySDJTyCwFFy8mYLgvfVkQOurprcXBhyOgSHNmeHlXMPeBMnKOeFy1A2tBOjVyJG8F94aWVQW3hf7qIwvNglvxS2oMAO11fYD6uK18sctOF1JHTqEKSBJCi84lNL8YYWfosYzqohohxxxMg3uvRM0t9lAidL
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:O4I58pN9Gn4c7k8GHv7G/fJpkCCxIN2R1DaAiTbo4Ffa67ZQV6BD8vFQ9xkhk4i5aKShV8HV1vWDyrlg+Z6fA7qe44fsTj69qWJnMDC1IIatDlGbjr/mwrDDWDYrIzhntuuYw2jmg6O0zyIlF1+gQ+Tb6iGUHKzmzcLJQMKr+EDj0iawQzp8zEhqaNDd3mDA17nNCab9pQfN+IEAsBvAy04MsPuAW9TtskgFC+N58cuvmPhKLeesk6/gKpM03QWOfu7Y2wXOOsfD/f7ZMCyKImap/9O7Vz1G7Sh4OwRE0faqsrIMTXa/kk6/MT/2YOS4L333emHjAkN9TDzJY+AZn6+DLCEq199yjTEzpe7uFXy7MdjZmey1fDsuwXAB59QL2Q2gigmgTOV/sESuDuA7iAVRgY7iiBX9B6lIb0u6rDvoHzshr/r2FBAi59zPq9rfs8RoBTKyD8fqTBWnUbdMbw==;5:zw2wEtXPb188zSOyf9tFAOPQZX95AaejFdRehhR0KPsh7Ok0HigYZPJiwl9BkofEvxN8naVnq3S9a8sh0iwzMQ4IKw6xb88Rwy/ZEpeKmFGlvOnohGUOIAu5dde9WxSMbf3VMbcr/u0/QlxGObqiQ9IFjSDsO4/jQdbUhQrEmPY=;24:t3zaTHUa7uNSytjdrWxuO6737nsp6TWc01co9Xm6WbdfaxvqVGAB8q6IZdeGnuB7W6jaTfGh6HB1RsRairVhNWjdHmFXQoESci0vRBRVrAE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:7dao9ESn65+W4l/xgSC/qv/NL9YTWSC7bqFWGDWOSnDM6Awa3lU9DCxZ0rzEan+wZ2ICJ5vY3cOsDBzgBT2LJV0OCMjU5CPg4KuisCX61ZI1HLZJEbES8vrHgU8BojFEtiUrT/ODwFQW8eGXqfdXlJ2Y1JesjTysAbegj07eq5f7fxFQkK3+QDp83OoW++yFCiItde/NzHs+GR8IsrbnHclBuiBZiS4KQuTCwiQNzR8iYYsWxGy4aty6saByeFiu
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 21:25:51.2048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937426de-e648-4fa2-e6ef-08d5936026f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bridges may affect the required bus output format of the encoder, in
which case it may be wrong to use the output format of the panel or
connector as is. So, examine if any of the intermediate bridges needs
specific bus formats (if there are intermediate bridges).

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 49 ++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..920eb16c0213 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -226,6 +226,45 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
 #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
 
+/* We know that our connectors will only ever have one encoder. Find it. */
+static struct drm_encoder *atmel_hlcdc_encoder(struct drm_connector *connector)
+{
+	struct drm_encoder *encoder;
+	int i;
+
+	for (i = 0; i < DRM_CONNECTOR_MAX_ENCODER; i++) {
+		if (!connector->encoder_ids[i])
+			break;
+
+		encoder = drm_encoder_find(connector->dev, NULL,
+					   connector->encoder_ids[i]);
+		if (encoder)
+			return encoder;
+	}
+
+	return NULL;
+}
+
+static int atmel_hlcdc_output_formats(struct drm_connector *connector,
+				      const u32 **bus_formats)
+{
+	struct drm_encoder *encoder = atmel_hlcdc_encoder(connector);
+	int num_bus_formats;
+
+	if (!encoder)
+		return 0;
+
+	if (encoder->bridge) {
+		num_bus_formats = drm_bridge_input_formats(encoder->bridge,
+							   bus_formats);
+		if (num_bus_formats)
+			return num_bus_formats;
+	}
+
+	*bus_formats = connector->display_info.bus_formats;
+	return connector->display_info.num_bus_formats;
+}
+
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
 	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
@@ -238,15 +277,19 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
-		struct drm_display_info *info = &connector->display_info;
+		int num_bus_formats;
+		const u32 *bus_formats;
 		unsigned int supported_fmts = 0;
 		int j;
 
+		num_bus_formats = atmel_hlcdc_output_formats(connector,
+							     &bus_formats);
+
 		if (!cstate->crtc)
 			continue;
 
-		for (j = 0; j < info->num_bus_formats; j++) {
-			switch (info->bus_formats[j]) {
+		for (j = 0; j < num_bus_formats; j++) {
+			switch (bus_formats[j]) {
 			case MEDIA_BUS_FMT_RGB444_1X12:
 				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
 				break;
-- 
2.11.0
