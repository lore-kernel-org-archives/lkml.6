Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E8C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C834E208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="SHQMZIPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C834E208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeHYMfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:35:03 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com ([40.107.5.133]:45123
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbeHYMfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8dx3ikHq1lAPBAPRfDK4zQdrGBsC3Qr4UUUVmTXsIE=;
 b=SHQMZIPssprZ0r+V5Fy2caU+07d+55+5ZWRTZ5PzCGJFzHSnz+Mi3Yuc+NRmjbo/54CGv7cFxD1YdlzLnvCSLqXPnvVXyLKLx2hgywb0uokaqKvkrNbUrYeSz5FGw0ZfPp/cr7hybryfWow11zxiY8TlQk7Qk6Esz/JdkMqgpFo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Sat, 25 Aug
 2018 08:56:40 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v9 2/4] dt-bindings: display: atmel: optional video-interface of endpoints
Date:   Sat, 25 Aug 2018 10:56:18 +0200
Message-Id: <20180825085620.10566-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180825085620.10566-1-peda@axentia.se>
References: <20180825085620.10566-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::17) To VI1PR0201MB2463.eurprd02.prod.outlook.com
 (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb0721a2-ce32-45b3-a839-08d60a68ad5f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:8Ff8S2igJ1ydad+HqeEKCxFv9q5Kee4Tbjq2skMT3jEecXLWva5Q9aH5Unl5So/0+OVz2yfKmPb5uSV4HiTIvB0uP7jJJtnKOKgStNWjzo8QeSvaSHYxsdH4sdKE1YlHTcBrChs+UE1FkaM39k+6zJBgvdMjphv5GqHqdf/pmdtwZyh1lQw8N26MwFYbp7fWBYV7fQlI6Mc4ihSyAw4aXyOQksfjgCfAqf1gHzrr7UHfQTpZ4fXAeGTrIBOyRC4L;25:zFep42WY10tJH6547SxFxXfZc2ipPA7mBG7pGKpVfx+GwgVURspzSutxWJT2vnE31awmq237q+GGAP9u5ZeVS+zCFAyoa9mTYHYVG7kuimqEY+pL75mZc9qdPDq/uEJllQWmZH3kDLQzN/TAg61axaKTpSuuAtE5v/3N0e/nqlI1p24v98/xwpZVHCfK6cF9d/ONuN8i9tfOlt6Z74dcE1XCv6bX6lznlalyYQ1PBGrmY17PSS9kE4Co00uGtSQT6rBcFhwcvKByIgd8YqlevMjCyjzpL3LPwceg3wsGX1eUgJL1w2jI9YCcxIvXfVta/wmKoVyjUKrQ+/s5q/FnqQ==;31:Y6fkPda10OVtY7Ns04QuoT5bDsX8ziZutfR1Fr9x3fznNj9HHaoiyEzUYvekU3NkoF85JWrXJI6Aqp7iamaKgN2d5daFpLsZgqQ6GRooeHqbkVZHnBPsXdvFLgVY1rat0QYKVQKhI/Y9omXZ1cixfSM4UO9Pri92EMhNTXyLohmaFuEb2tqVNq7gdDCxLSCNwO4jdqFaaIu4H1/vmfw2hFNh9Qz2WnPMeWpY+fEE62E=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2463A7358FFE86E880EF5454BC350@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:xfiD8uv2NC/B0Z/PQPWV3LTTgjcmXaa+0GKdZ3U+vnyMzxGO0nCXJs0fOuYPkM4r4Vfo8ghwU6QCRRQHFJ0KnUo6d+T5qoGSU1BgHtDCSxCJCVj8OYt0aMCZN7dN7WdBFg/mm81lTS8N++rKsBAHgFDpLw2c4c57GX2lSzQ5rT5j8iIQwec0hIVt4Lj//FDyQVhw8aH3lApra2gKlNBAY8zAnTOESzqLj/ZFtsSQvPU5WXRLuqtMULtJZiCC/8ZjNc9ljBNn4TEik88kepTJDg==
X-Forefront-PRVS: 0775716B9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39830400003)(199004)(189003)(52116002)(54906003)(105586002)(50226002)(478600001)(476003)(11346002)(446003)(2616005)(2351001)(956004)(106356001)(316002)(16586007)(74482002)(486006)(6666003)(6916009)(81166006)(81156014)(8936002)(8676002)(7736002)(7416002)(5660300001)(2361001)(305945005)(97736004)(386003)(186003)(68736007)(26005)(6506007)(16526019)(47776003)(50466002)(51416003)(6512007)(66066001)(48376002)(2906002)(53936002)(3846002)(6116002)(25786009)(36756003)(86362001)(4326008)(6486002)(76176011)(1076002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2463;23:hPSbNzk1HzzAITB7bEDJhA7NQD5zQlzNYLkphML?=
 =?us-ascii?Q?f0mqkuR0UXt2gcSe6QrlU8jf5fHAy50FJ2bOKeq3nplkZgYzmDltGbdsw/Uq?=
 =?us-ascii?Q?Q1J0jZooW1vVUEzxk0/gLoPQB93s3lMlc3sWw9pG7qHcsQZwqG0M2vkKt2CB?=
 =?us-ascii?Q?zymVpNAwU+hfu4wj7dZ9LBHdu9ndpGbF0mtrC9GYeXKbWGOPJrK9WxFK1Sru?=
 =?us-ascii?Q?Td9eVCOrYiL9iERZoqw8VniG/UKkXgE1jRmWcqBS2niCmDhPerhs0P3x5aOQ?=
 =?us-ascii?Q?zBm7dVjOSGlTeV2EPYRNlvV5xr1xPOZydBr71J53TOaUdGBUJSkUSHxjZsom?=
 =?us-ascii?Q?Nd3Yg3HgTadmANDmj/TIKIWD2L2579lOHl2TqbwD+AwvgVBHXRS+AMAKWeFz?=
 =?us-ascii?Q?Y8spCYCw1wdwVLKK16+NO1BE0b58KmD+qs3Yl1jb0WmTmLIBZvhJOUwSlVTi?=
 =?us-ascii?Q?r1pT4FF8ntT1kKraom1G+l6IZ07bwlRDGd2i5E4NrOzkh4G6lyf8+239Va4F?=
 =?us-ascii?Q?3FdIxJl76K1m7VPvge9ALobCSmPj9hYUEPHzE6W30PP70Knv/NucPJeGhmoG?=
 =?us-ascii?Q?lTswo/qkFVec45AcaYNeWUZy6dEWHrEFuBHQ1Uy12jmUSsPhyXHf9ddAYxS6?=
 =?us-ascii?Q?NIugTLnJQjOiFl8oLnSdZKvJ6yJaAWor7rPSZExP61g8IkxVDIefoKHDRfe8?=
 =?us-ascii?Q?nOmgQErf5UbBrVwt/J7ik+xUs6xrUnfxLtTtM4gK7xRigh+TmQoWg31yb7a3?=
 =?us-ascii?Q?jGUdsSSb/rvp3oOTUZ+J6yq59eE0n3Ntf87eEesX10NP1RJCIyNAfe5qU491?=
 =?us-ascii?Q?8s4YmMM1Sggxa4v89dqWv1NDZf02I2k/mVjhXjip2dRrYz567FcsAq5lwFwp?=
 =?us-ascii?Q?644U0nMdnSYj3ILn2E6mNY5K7WD2GwhbXnSZz7ziZzzjOCbOEa78qcwtvKk5?=
 =?us-ascii?Q?hREEUodyeL+ar4+k2W4R6wQANaZ8DcjJRXViNWqtDusz0M5/1AEEnA5TAZLO?=
 =?us-ascii?Q?o4RVCN15IPdVpOACvPnu8WE3hWaJ7s4KhtwWXCD0Sv5sbumxamy+8LlVYt+L?=
 =?us-ascii?Q?mpkO+e4PE3K09XboCO44iEGIWEI/Oo/OJyX5HyBrz/cMiCf2jUWe0MaNd1dA?=
 =?us-ascii?Q?gDctt+79FQth7zqqMxYl/ZupmLwydst0GuwLneEy14HXA/ggir4q8ewNYVxX?=
 =?us-ascii?Q?77OWWFIggQFgYQ7Vof/DKEHVebsLyM2LuLy+03bkSrFsWJyIEDAqN5cQM5FZ?=
 =?us-ascii?Q?oexNRnuCGzgXwM8a44Fz7tA301uFiqZkEiuvp6LDvETyvYoq9nFNT9/pifdg?=
 =?us-ascii?Q?P3xtGoyRpl7qaSYUFIqh/qzE=3D?=
X-Microsoft-Antispam-Message-Info: +S8bsXI8ACReGJE1JU+rXGa0/lZ46f3xWGPrQcm10AV+PjINAOQHr57LguUM8OzDdFqYoh0WnA7J7vfNaBUOsWGbyhb/9fLHNe0whW0OUSzH3UpTlucKGtCVBDos3PtInKFE4cvUJLFTcP5p3T5y+SFl9H8Y+71oKNvW3AsEvnR03gjuZtmzZk0vLiyaizqEUkXIGAC2u8H8dMhWzif1iD2nS6WV4/qyJhZs582nxHuvTRNFu6ZnGFckMZnuxqoTwZ2nBDh2gtJ2RDnYl7NA1lpZU14U6+MxbA8YZrGiU+CzNVQ+vn2S2+Dosj9zjv5c9mE7zlIdjG4nc9KK7otQ2dTSNIboMB2VAyufGhjkf0k=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:q/x5zLj/g5gYapaqrXJsZgBGj3HG9C7Uje3e78vfCDCiaZo6QAJxa0Y2vyqA8XOVIM7WpybWtY1lIRk7Cub2W0Aw7yzNFn7PEfeGeaLJqTu4YX6S4T+B6r6oZTtQ5sFTO1KXALan7/Oe4+UkVaroChTqAU2vrlgvVsilmiemXbxqonAZ/BFHEem9AVRN3a0Mnuw9PrA67Vnb0Adbnd5bE9S9YrMQ4/T6iO46sMPU6iNNcnTOlUZvZbB7YJCoDHyvYyDQqoORDrkxqC1sKlORBWFMFWh9dp05yhdhj7JHkC1KoPZfmJvBzQlB9opzW5pv8dvWRscNslFdy6mEI5kKONOIKkkjls+hfQb+zW7dFSsKFe1z8OMTvWGpPtW4CKI6HwrobugN2eGD3ew9hhEfwkxPlcs30gFKVgCJnW4FqWIAcp3KGFua/ZRZAVh5F+ldyznrFYRyBBYxL+Sroksf0A==;5:Tqxf+W5ySHEwUF8f4hNdId7Rn3nKAIZsepT2SHY/hZEQbpiZ6sb80yKE5R+Rpg5GhCCwawRlXIVoSNwIqeRtgkdteSn2AifA/o5xy1sjiye+Abput5IA1ShiiIQAwOLkaPFyszT8PDmwyKW5huwVXLxw1K2AvytVCwOvwZuNzbY=;7:tqayBE6EhfyfYO+J2NAGIE3MGDj8oeKFgkggh+660kz+kC2yizEn75AT4YPpn7s/cf6S5XUsBCzImEg7ZIal4yCJtgVdmK0OOVjFB9pR4fRmUHe/tf+43+FDm8wWoULuolyhAL0Y7uqlOpi/cRJknrrgeNIuNnMXFob2DTH+kaCDOhkjqpnMPJ6VvMmbq8oh2Lcu6KyPCaOh6/btUcYSC3T/Rc1I2Ol5I7D491mIa/1K+qO2vCpYBIVqSM1lEWXU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2018 08:56:40.5169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0721a2-ce32-45b3-a839-08d60a68ad5f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With bus-type/bus-width properties in the endpoint nodes, the video-
interface of the connection can be specified for cases where the
heuristic fails to select the correct output mode. This can happen
e.g. if not all RGB pins are routed on the PCB; the driver has no
way of knowing this, and needs to be told explicitly.

This is critical for the devices that have the "conflicting output
formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
RGB bits move around depending on the selected output mode. For
devices that do not have the "conflicting output formats" issue
(SAMA5D2, SAMA5D4), this is completely irrelevant.

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..0398aec488ac 100644
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
@@ -15,6 +15,13 @@ Required children nodes:
  to external devices using the OF graph reprensentation (see ../graph.txt).
  At least one port node is required.
 
+Optional properties in grandchild nodes:
+ Any endpoint grandchild node may specify a desired video interface
+ according to ../../media/video-interfaces.txt, specifically
+ - bus-width: recognized values are <12>, <16>, <18> and <24>, and
+   override any output mode selection heuristic, forcing "rgb444",
+   "rgb565", "rgb666" and "rgb888" respectively.
+
 Example:
 
 	hlcdc: hlcdc@f0030000 {
@@ -50,3 +57,19 @@ Example:
 			#pwm-cells = <3>;
 		};
 	};
+
+Example 2: With a video interface override to force rgb565; as above
+but with these changes/additions:
+
+	&hlcdc {
+		hlcdc-display-controller {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
+
+			port@0 {
+				hlcdc_panel_output: endpoint@0 {
+					bus-width = <16>;
+				};
+			};
+		};
+	};
-- 
2.11.0

