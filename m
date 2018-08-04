Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77BCC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2F217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="NGBSfbV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB2F217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeHDNP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:15:29 -0400
Received: from mail-eopbgr50090.outbound.protection.outlook.com ([40.107.5.90]:42739
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbeHDNP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZCxZiPOq01DgtqeNoBYvdYLNpkWsLWQ+UV51mXhsgw=;
 b=NGBSfbV+6S1WGZTFbZcIigsXSPAX0yz8vNB4eMszhdZf84XJOv3qzMPXINDzYGS4AXk43YCPEvxiQKXPWt2XBt5m+k9UFxmWtIbYr6gJg6bIcyXtkd+ilkHCgxsYQhNOfDy9LWbf/R9ZwG+aJ1XD5cFlR+NUJ1iUU1WVRVPR2kM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Sat, 4 Aug
 2018 11:14:58 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v7 2/3] dt-bindings: display: atmel: optional video-interface of endpoints
Date:   Sat,  4 Aug 2018 13:14:38 +0200
Message-Id: <20180804111439.7455-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180804111439.7455-1-peda@axentia.se>
References: <20180804111439.7455-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0301CA0043.eurprd03.prod.outlook.com
 (2603:10a6:4:54::11) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbc24798-23ab-4fb5-6320-08d5f9fb84a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:jkm84Cr3jDCPjM0nEQrNKczE+9E7Bqy3/q6Exj5IquLg7wRoZHuBT+uL4eaOMjV9hE+XYjHqias3xESF7H8CLsQH76bdYfNDWGpIwV/5X/ejJlTZ5F/30IN2Qr9gLjqMYPaCsy4whHHznyRw61MSzILJt/gQYxQNMvrr1gtdPukYC2/4x/06lwGfFqWpB78WzneOxlMmWF0loqQtYZWloQ+HqCEyu3fh3KDduxZSnUhRnmIvI3FAKPaSZzR3+bdn;25:YdjXVkkNAAlhDld4exzglZN6UIoPXCpjA5nqrw+9UN7ulZJ64iIsVYmbxey6BgVJ7P+SgkXdH1Adt2qXCsMtmVuXYE4wsjLltrBn2LyOqEXP7t6gqhlp14ysWxEoxthaqetNuUk1KvOoW5UYKgk/XFNJf9RKLYPOPI7aIftWxfjnt4U31trE3uqHdhkLYxA7Hje6ybqWorEv7bresLYOUZ1W6QTNAFEIY+s4ixYUgfeAWVHHFVvJtJE6oAW0tLzrG6M+zbJAIdzydlL1tU654vMpVkE65uvlNA2yKVZOJPAixPKgsgMojise3CCc3H683ap4rVqOfjhbm2W001pYRw==;31:0O2rHC2vNNyfBnh87giz2QA5AqAyzbgdewwcVURKaXUWhIyPUrg6b4uvUcRrhhTLQMktL6252ITZAh4FDmdjIZIoYYTz8TXUgTFesTkaHn4cgpIDCYtYx2YWWbARA69vQeKeIXnNp+71UHxnQgEA3cQEi+l0vv9ljbG51vmSEIzMsJ+NCTF9twrBLUXHuitRbsdIdtkLrRx2F2mvnyNfw1NIO5sV5/rco7q3+txAvgo=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2451B5A923D2D4D2BFC45E91BC220@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:vpCA19LkGxmMQA+/2/UjNGrhTztIGljCwYfnQkWMMduDDL9bRksZfyZX4Y4LSMkhFweMn3OwtfU/U/+gsO6cZzsSgkkOmRxOJgx0DTMal3RISQ8ihK2Z5ozBfTRq1EBqbAskMZWkg6JWyolmiIUrpGnn8oKrdynOeiy2obuBpRDqU/yL1MKTmXWy2R39TjvgFMpklYXU9XnZvnKNKCbYSQybLs9Ev3jMpGoDhEgEESibssH3kEMVbD59oewmGo2kBA2slHb0/EN93HClHwQ7ag==
X-Forefront-PRVS: 0754F7E325
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39830400003)(366004)(346002)(189003)(199004)(76176011)(51416003)(106356001)(52116002)(50466002)(48376002)(2351001)(50226002)(4326008)(25786009)(2906002)(68736007)(47776003)(478600001)(5660300001)(6666003)(7416002)(66066001)(11346002)(956004)(2616005)(486006)(476003)(6916009)(97736004)(3846002)(1076002)(305945005)(74482002)(6116002)(446003)(7736002)(16586007)(316002)(54906003)(8676002)(81166006)(81156014)(8936002)(6486002)(86362001)(2361001)(26005)(16526019)(6512007)(186003)(386003)(6506007)(105586002)(53936002)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:Pt7R5hl1BPa2pHcIhhWHlQdNg1Zkk+Skev/zxDm?=
 =?us-ascii?Q?zTCmgtffcuUUoSGibTn4NePSCeZCm4CWihDePzaPvIaghpE3PjpsB7FrJlMu?=
 =?us-ascii?Q?8Dy18rC0l35/coLE4FFL7woQIUv8Ky5vkfIwlW2O+ueqHLPJ85gsElzt6EYH?=
 =?us-ascii?Q?Ia1eiKjwlYkqbgSobPJGcl0NK/DtrRspvI8rAAQ0x6Uf7048X/JWDEtji4bs?=
 =?us-ascii?Q?R7+zXOiEZAZ9SCCmLPTbL12tZ0YoMtkTgFAUTslvNeWcYDDhtjpKd0+PAiqS?=
 =?us-ascii?Q?0FcLCjx8mhbT8QAdkt5B1MDAesjeAkSt9+zHyyi8/fymQ9kkR+y3tuuioon7?=
 =?us-ascii?Q?Wfaqp7JMsxAF/3eSV78K5TCdo6G8lOGJMRhhD124IIqV7Qthp4Gj8/xrfajR?=
 =?us-ascii?Q?I1xxLsmBJ6ayVwAvcNecpldNkp3lizs0d6sFBuISMBjywCos4Z78FxAU1Bpz?=
 =?us-ascii?Q?yXE1QydDg0I/NAgB0WsiOQOa3wErnMIsOXP6zI80boJhMFHustd+L5Jfkxx6?=
 =?us-ascii?Q?tD3TWK5QyZWRfWWfZgpkJrIiwG8mNs88z8zaTuZC5atBliHVvTfiHXnzdwJF?=
 =?us-ascii?Q?cvwJeIGQ1ROfpSwbfzrAmN2F7Bg0rLaKRsQc8keGdxaORTsAoFW17/MilatF?=
 =?us-ascii?Q?kUy7XzrslJJgIWYm1iuNDp80GELag9wVyIhM84weihQhz0EcjyHMQMofeNvd?=
 =?us-ascii?Q?V6CJ2rKh66CCM9VhTuROCgLJMs/JXMto0elESQNYTgk5EjNkPDEDRguCGK6E?=
 =?us-ascii?Q?7hl5cV5cuhUZD8EupA8GXYYM+FvVd5Ay6lUl+GsBjqaQnKYRgyFdab4dCxj6?=
 =?us-ascii?Q?wXke27h2jjrcb/4+dGuAkVmFd7Q5nTAV2MC9HfcFMUv/JcdoErsTe5kGkWUy?=
 =?us-ascii?Q?eu/Ol4soGg1QUU5i2OqKokd+JXaJpLKLQ9K8kQR75kfVYtnUY0zlHBPvv2tu?=
 =?us-ascii?Q?jMcbjVCJAgyXz0I8EP8UndhsyZXnUGwKulvnhp54yaoOdIT/4OMBe2i5UAYz?=
 =?us-ascii?Q?kgp5JgRxXC876PeIA/mpNuMUDLVX0HRhR4WjVT/wNjCGW+TLFAS8WbKT/mP9?=
 =?us-ascii?Q?XTtyekpPG8knAAcJrWI1yldUXLwJp3Iow1VRkkGUtYBHP2wnbMAFiYKD98Vw?=
 =?us-ascii?Q?fpQMp/XLry19mHynF2/mx6w2mb1eyu0myBWw1hcW44elzkP3q4yAquj+wgqx?=
 =?us-ascii?Q?rEAoyIvVOYwgCVzi1nAAJlnfRp5HplXA+aniEgy3uqr1VDE8+gKpQ7vNH7Cw?=
 =?us-ascii?Q?w+DoHdqPdjQUiIsUtSBHgJPAsSzOzMFiOyshMtOiCovEASwBDL8aiB9PrvaU?=
 =?us-ascii?Q?JPpcsVY+1OyUmnlEBvK6UbXs=3D?=
X-Microsoft-Antispam-Message-Info: wGgtBpAv3SLMgL6PGwkL4dWg6+KJcaIUaHxIeos2o/cEveP8eF2SyMxToci8xdtntmwi97SvLdkLtWZv9901zftM9GDv8p/Q1Hk1eB8YI8wQfAVf8I53c33jdF+/pJMoJNtGLcoiPM2qSFuVfB4JzMFlnUfJ/ifeqApYILo7EfKddD/NDmYtH5OL/sSXAJiP/B+Vovg0RzLgIDI7SNEOJu8pFbKjtci90VexKef6bSaBdkQMkNu9M1ck9cXcClXChe7v/m2Pv/5+3ieOCGMyvoK1tj3ZWMOTWEqiNlTlnF5OcQshVqdbD/OhSFW86F/4fGOAkxsqSWzC0ROATuy8JcNxB6G48qePfDw4EReXf60=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:SlCfImbtrb3HNcuJmFFJryC59TB3GABKyhLiqR4EaCl+gwxjCZ8k8bw/gMDkSpT+DCHs4GkFsH0ePzQz62GJxvcZZQ/QLSm1ZQZ8iq1RhwF+8VtEXzHxtsUI/GOscwY2hGlnPKG9NKclnxzFxUghzQxDuKYPKxzntuk5uDA4BeheHuof1NXsvX/kI7diIbLSJ8rjEB4DuwGC+Pq7M5JV+x3zPwlkJqni25l6xm2vxfrM+7U+RMUTK32rWyZUOAH6cDgdM5qsAZd5XCPNp3S+NZm6Og+cNW+Dlb6yISxTej5zlfEw0nzD2XgjIrx+dVKRgt7ZxqonAqDARsWpuCW0cBY0f5vKYSKUtbzQ7/lJcS/qBTJ4J6p03Ukloz+MmVXuJeNhffqMgKTJF9Z7MwgfN7iu2QpQ7XZNNPEGCZ6H8ArU1Ikc/jHLrhCcqlN+zF/q+0TvkBxqxRRP2Y8tyi4fiw==;5:XY1c6oW3NLOc+ZI3mqIaAVnmyXbMkyup1Dp/CbbhWX2nKoysTBKjPQr+K3Z5QbdY6+R5EjAC0es9xGQSUyZKXGL+5RBvy4uCo+cf5XkUzmXj8YyE27NShl1N3OX1GVjjNRJ7ebw6VCpvS39mpBL8nmtM7ZCWuqW8Fqo7D/sEGLM=;7:OhpGVV34N6/+rWpqLWqV0BTWD2Lvt/c3xgXvo94h7JmeXSmWLFyfLGt+RpW45QB+JArelp9Vqql/AIANYxIE8RaZGf63HQ+u97werq6bQwRvEP52JDUOVIUGY9g5OjgEdYt8QfBjVMTZVJsPGZdHVR4FSaS2OY/9c8q83to+mXz+F17Db6E3mOYkXJYpymJGwFPnEGlbVdloxwj18xrFpJq22nOK+VCVl1qQcgdgPvuUE+uzGau3y4iCPierD284
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 11:14:58.8803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc24798-23ab-4fb5-6320-08d5f9fb84a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
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
 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..d29e1e425518 100644
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
@@ -50,3 +57,24 @@ Example:
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
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+
+				hlcdc_panel_output: endpoint@0 {
+					reg = <0>;
+					bus-width = <16>;
+				};
+			};
+		};
+	};
-- 
2.11.0

