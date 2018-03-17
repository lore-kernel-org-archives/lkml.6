Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeCQWQS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:16:18 -0400
Received: from mail-he1eur01on0134.outbound.protection.outlook.com ([104.47.0.134]:7790
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752649AbeCQWQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:16:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 3/3] drm: bridge: lvds-encoder: on request, override the bus format
Date: Sat, 17 Mar 2018 23:15:25 +0100
Message-Id: <20180317221525.18534-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180317221525.18534-1-peda@axentia.se>
References: <20180317221525.18534-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:2e::34)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6877a34c-d77c-46e2-3ec8-08d58c54adb6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:4/5zddHAvezOFqHEsIMt191tTA3rxLgwQ1UGrepIuHeuuV8EsHgtlHt4BNVBAqJSWgBBjbief1/vMq8CfLKCNSoV0BCly9vpVLQa9ZIagyRTjoJoVKb00cA2iigD43vcOlZQDjCwoKMNX5lBjqqxaxk1km3LeTht1bOUp3T1bu27AOUlZ/OfAA0xETegs2Sd4G+hSV7DKeT3F1ACBju7RhUNzEOeI/nIoF0DkLL9eWLLGbeW2YZ9AXKIWicBM1NR;25:sLpgl85DrsyCypbfyX49WAtkxd5d/88ZWXC4Z3uJoB+H3BEoCBnvDkGbvv+TZMU9W6RHX5soOnSVrstrigEY+2+ZsPrEFtEh90TrygghlC3gzBQt0hXh+gSglKm1VRlgUaV9PDNot+R73YE3arh2svhFjrttpN1agBppQXXR+lT8dN7+/YGcSE65bR1hnrn7gO6fs7Mgz7Xbe8k3UWLI0ain4HxS652XolWFRns1NdZcr8au4lEbrlfeMG+mazX/nJZcdGU5iXfHmBJdkz42iSgsRuUNhx1sX3caNENCdd4rLLpMIdozfNdVP1Dqd/T3oU7I6xP8EF6DNeyDaeSvmg==;31:Dccs23j511rPskpjYFWepI9Gu2t9x5C3XxLQqfFzuoLYcth25IMBzbGzMV+0IUv/BM0r9DPIap5tJGhzFfCl6txjjoeTkS8QGAeSWRtfuVilYV88uBnbSu7y2+IPsHGy7ntuQ6nGsLZ2cO+JNdKlijKAV4TwonzDCi6ApY7KHvQYEHbEtcbbOwIgHS+o6O/tqh5G19hwCxVQHK6L1/KOceWggdbXm8QSazbqA78ASUU=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769D5D7922A03FDA9734834BCD60@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501300)(52105095)(93006095)(93001095)(3002001)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:KHVAJ6lg3im4eSdI2IZv18rZJwQxZ2rVhJcaReqKlvD7o2vFltMErq2+H87viP1CKFUVUxEYayfHJU1dhv5fJtPX/Yf/dHCRQzXm/g4dxCfEROvxKNAZ3tmTXqNZonzKfMljAJ9fuJKDKE6QgT83KZ+MDsK1Ar+rmw6XhakLhWMojk23ZNM4AO1ftCC0Kb4B28u9ochJNEfztLQH0E7NrzLIgnHdo0aoXFhlLGlU8bW/Vl+X/ZKaY7xEIpDAPqWRgyhyjSwSL4jofzsNlwQXlg==
X-Forefront-PRVS: 06141B80DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(376002)(39380400002)(346002)(396003)(189003)(199004)(26005)(25786009)(4326008)(86362001)(50466002)(316002)(575784001)(52116002)(51416003)(76176011)(5660300001)(186003)(66066001)(68736007)(105586002)(97736004)(16526019)(7416002)(48376002)(386003)(6506007)(47776003)(81156014)(81166006)(2351001)(16586007)(6486002)(478600001)(2361001)(8676002)(6916009)(53936002)(50226002)(8936002)(6666003)(2950100002)(6512007)(74482002)(106356001)(36756003)(1076002)(3846002)(6116002)(305945005)(5890100001)(2906002)(7736002)(54906003)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:9kmDumSSsB4VpcwDdQ87IsDETAFc6hMEi4n/kMU?=
 =?us-ascii?Q?Vo1xt4SvjbfCgep7UVJzR8kElSjyS85vU6JQTpHiNLkXj9nWEYniHbi0Xp2j?=
 =?us-ascii?Q?s9F8D7fFyTRZzPv1jiZRiKDkmXPavCWbO2mryOmDARQ6e7lx0OoBLjCCqwwk?=
 =?us-ascii?Q?RFkQalhjbbHNTKtXwzdYcteL8TQbN3v42wSYYqkoNDP0xeSwPRcMlQeS612O?=
 =?us-ascii?Q?f3ejjrJ1Bj0ok9yoAwTi5n8tJRmvskGG2WOZEooGOxn/GIfq6lhgKf4iMnam?=
 =?us-ascii?Q?g6Amo6ix674Vc1gSo9Fs9YLor7DH/b7gl/9UflMLAk7CEu9gf1gN3PGauz0w?=
 =?us-ascii?Q?7a+B5nA7GjQJMcPXz6nZ4MinIpMDhrxkSmPHIGziDxJ7hsW1W3yzAHlK+U+e?=
 =?us-ascii?Q?AMnZI+WbEr2lKHgvJVwiWB2U9+QoRDaYOpXMzJbO5/1hgI/SEmTN0uigLPX2?=
 =?us-ascii?Q?8qsTf8NzNJi4Sv6Ftr8DeKGevT0G4fD4b9gznB57FGGpV4EgIToo2CwoRuVD?=
 =?us-ascii?Q?StFdzcQ3o6tTP+3/iF4NoIMtJ9nRR4qRMEOlutK9J5VNqwBvvOT2GOhal4aJ?=
 =?us-ascii?Q?v442PLC7qVtgVfjyrpAQTpETIsEuE3eFCloK2WAu8+4JmV9VvDG12MbSTknh?=
 =?us-ascii?Q?G4QF0LfNFPICtXlbOzkHsoHGxEN+brTu7rJMRbB9IV/2NZhgW8UBEoa1IXry?=
 =?us-ascii?Q?UF6PD2N2ChhrZUFAmWJa8MsyHNU0k/qcp7Q19r+3fon8dUWWhcJVhxecjOrS?=
 =?us-ascii?Q?Lg2/kGmANXj2/KAA1erqRrVGguzmixX09KZcioMhvMPYiBo9AHaAoz9fGEvV?=
 =?us-ascii?Q?CknBKtDGdEky9pQnEis2ISlzu2Td7TnDr3MXgFSxwR1NvIZAKzLSJiAhgNWf?=
 =?us-ascii?Q?Gp3rNekVp23B/63eKrw5+n7BsyWg+d6xA33zqYodBh72xqCZZaGWuVyI5FZe?=
 =?us-ascii?Q?W0T7kAeYDet97sQxfFVN70BGOup8d3cf9Ox5g3v3bT8YFlk/OTKjiMrgA3og?=
 =?us-ascii?Q?hJN1izBxrp1gcLGOIt8FEsKf2hl2uekUnP9lC/rRaX41PWtE4AArvmdHOKrd?=
 =?us-ascii?Q?me5U4evHWMFmyRaJYo4A/TUnzPwHslooJOeLkRVN7LhpBlcoLEaMpOSFZhjl?=
 =?us-ascii?Q?sVyy84uQHbhAHPbZ04/svEhZElye3e5d0rPN1uP/zOzqE7YgFLw7VrzGabkm?=
 =?us-ascii?Q?0rgAffHfJ/Z6YMHUuG4SGZesio67+iDICIIaGmC0YnHIqX6Qu6ibBa6r1R/F?=
 =?us-ascii?Q?4krlUMFEnXb8VDRuHTmcHahMp9NCkbAFLFYET85KgbqO7lrlwzIip8PlFmzK?=
 =?us-ascii?Q?e/eqDujCLphBV02yi/J5U9JM=3D?=
X-Microsoft-Antispam-Message-Info: PFfAs1XxQRlnUZbzTWW3Ra9jtwlaG3Mlok04FcO9HhRg0/wB04p6kNOHbH/6oQIEY3f15YmETzyLkkkwEs+GPHfcFOJCNf1PU2SLuftkyiW/16XzqW1VApXhF1gIiPwFE4Ucq6VIDThWHYrt0TIY8Z8Ftj5fJp1HflLLYVytK46zi0lBlDjH0D3ByazQQ1zF
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:AujZHcswzOMy5QtyG7tOuoi+xoVFPEMvCtUTLhNEEJz5q/iadLoghs0lchxzcMzsz6DThPSApdW1Hq5WVNdvOaqJZNqxgaalaKPdEvlutNqq2I2uDBuAwPZM7cO4n02YuqdGZD9W86bpBpCmtEsHl73BcdL24LSJL0TzHZnsToDhb0dxVjnMhlCdiQVAxo8wTkItRfrA1l8kmvA3UzSrQN8cXsG4JI2uHZ7PqFnpXL9cTE/7/zDdvfYdvB1vcSspLd23RW0WdEj4zmCqAPgy83eNWiEcYVSHDu1QKYsIdPxQn0fplgU9FFWl4hCgRLuWpU/2IGps5fIhh/NTkN7nO2yxBj2rS66QJFEERyQTigc=;5:j7/lmbIM0wolhfEK3V56sjTfuRMHv1C/7jj8mKUjyQiWuWtZfq03exFn2zFRYqDLuGXkIdUuZutoYHlb95jJjMW2y+OSKAIcJ1zjx24H6T3MvgZvxqNNEJ7r4WDUQNzZ7bgfhXmpULaTeT3mOBTt4GE4zwTnPBq3FwI8TyH39wo=;24:mSkdnXY5z77D9XwEp2FiTc/ooBkLdQedsSsFtsOeBKsA0agH9F8uQxoZ5SeSYXRn7GVhFctyx/552jhhwIZl1bdaKSx5wyy8YT6JtwTiG3s=;7:x0jOwHZ+DUk76PzlSz6vuKDsRLRyrfUQXKAfF6YlGflKowM5Yen5VxvjUrW2FToxpuoBV9LQcOspGu4WiCh4/mTXjQiGdGwmw6ShZmDUdlYelIkEa4ayOtLYCY+UUpTIeKMThTMxBMkvRHSrrbKcbXrl9vONEhwAaf53U/JmKeQnAZcydMkJ44gKtBCkk/EhY1wrgd3KSAN1/V1scx8kz9ZODZwYXcvw2LX+4l7mQteOuGUDO4ORJPI2GY+s9LkA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2018 22:16:05.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6877a34c-d77c-46e2-3ec8-08d58c54adb6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the bridge changes the bus format, allow this to be described in
the bridge, instead of providing false information about the bus
format of the panel itself.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/display/bridge/lvds-transmitter.txt       |  8 ++++++++
 drivers/gpu/drm/bridge/lvds-encoder.c                  | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index 9d09190d9210..c0fbe74272e7 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -29,6 +29,14 @@ Required properties:
 
 	      "ti,ds90c185"
 
+Optional properties:
+
+- interface-pix-fmt:
+	      Override the bus format of the panel, in case the bridge
+	      converts the signals. Recognized formats include:
+
+	      "rgb565"
+
 Required nodes:
 
 This device has two video ports. Their connections are modeled using the OF
diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
index 75b0d3f6e4de..acff3a5b0562 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -39,6 +39,9 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	struct device_node *panel_node;
 	struct drm_panel *panel;
 	struct lvds_encoder *lvds_encoder;
+	u32 bus_format = 0;
+	const char *fmt;
+	int ret;
 
 	lvds_encoder = devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
 				    GFP_KERNEL);
@@ -79,6 +82,21 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	if (IS_ERR(lvds_encoder->panel_bridge))
 		return PTR_ERR(lvds_encoder->panel_bridge);
 
+	ret = of_property_read_string(pdev->dev.of_node,
+				      "interface-pix-fmt", &fmt);
+	if (!ret) {
+		if (!strcmp(fmt, "rgb565")) {
+			bus_format = MEDIA_BUS_FMT_RGB565_1X16;
+		} else {
+			dev_dbg(&pdev->dev,
+				"requested interface-pix-fmt not recognized\n");
+			return -EINVAL;
+		}
+	}
+	if (bus_format)
+		drm_panel_bridge_set_bus_format(lvds_encoder->panel_bridge,
+						bus_format);
+
 	/* The panel_bridge bridge is attached to the panel's of_node,
 	 * but we need a bridge attached to our of_node for our user
 	 * to look up.
-- 
2.11.0
