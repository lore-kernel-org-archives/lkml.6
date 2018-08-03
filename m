Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27099C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2C621717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="WLbfndPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2C621717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbeHCMHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:07:25 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:5472
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732090AbeHCMHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtZ0lXRRKQ2UBpzc49H2a2um6NSkQpYLcHdr4J0Q+bw=;
 b=WLbfndPHtSs2dZoG0lZOesd8gH7hErEkYT/MgOyE9BrFaLvE5jW94ElJBA9Mh6cExHiDR+bcIxiAdVpoCPKdgV9wfoZYkTn9mqWEgUFcfhrqIXcUOZUTWOf0i9dhNGXvRTwOSWW1tWJrWTN23A3DwXCTdhXdmm5Dw+DgKFg/m+k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2456.eurprd02.prod.outlook.com (2603:10a6:4:35::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 10:11:42 +0000
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
Subject: [PATCH v6 2/3] dt-bindings: display: atmel: optional video-interface of endpoints
Date:   Fri,  3 Aug 2018 12:11:23 +0200
Message-Id: <20180803101124.4622-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803101124.4622-1-peda@axentia.se>
References: <20180803101124.4622-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM6PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:209:15::16) To DB6PR0201MB2456.eurprd02.prod.outlook.com
 (2603:10a6:4:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 976120e4-2108-4209-91ba-08d5f929830d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;3:H8SaOlmqxId5mYWlBYKLP55BSl5rkLZJGOfi95oakmhQSY3lwwbhMJFntX+gfrYhwssVwjLiuQEBkFQMCbojtxm516ouW9Pq7nRg8UK6GQWMEKu3Adk1c41bj9wDeoAsU/lB6SDZzZInv9P8CK6Gck2PDYK9eseU41awqd+OJuTKvl1jFeqaxHH9LWioenFvHe5wf/0tKEUPincCuhqfcZdo4pQp0p/ov5JZ49PupcD2fWCHnBHlqYNOoO+wJbu4;25:+rpqo3tRboE/R7Z5ozvKxBB+228CyqJA67mQLP39Xz7u+824gidh1pyUN76dUuz3WmgPRj5LqMqKgCzFfdIQ5Nu88d1ZWCtFu5ebGRa1PanqgxP41ekS3lR/RGzRB1QWv/QatG1tmueTtZrE6gTwG0m+v6LFpsm3KXZr4oEIGdjBuIbvr/HqDQReR3qE2sZXwKfzdHt49T6h48RoaLPvJ30DTlg8YjBzQyejq1JDZvyY0irAbDpwTRpV0eSUX28w8RCUUF1ClhDdcsKB4LuTbHuvkpNoBAA1HCANQeDR2c2GZFQ28JHfTSTbKVqgk3g09btTOGONw47XZmEVfq/neA==;31:AM5nlC+iJM7lCO1MeDsoADd0bLyZ/xafS514JKyajGL23y0mNSzGL+/FOaDsTSr1TJVR+IqUV08a8N5jNrDsvBXUNGMBAij/Bf1dN8N9u44qxMD73JvUg9OIp8znhSRNXZRphnNynntOWpgv9MutxcNwby3StlyA43ZW+RoNct5xfgRlYESxayPc3nKWPXJO9a4+DvzEMchkq6HaBNzO5npPxakKdBDEvIEJ5+m7HaA=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2456:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB245657E16FF79223BE593FDDBC230@DB6PR0201MB2456.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR0201MB2456;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;4:21RefTENq+edUjjlEkK9r5xLF6KaskllNIKBQTFuu2AbNC14raHvnXs6b+ZwRNmfnkUH/VKWCNupb8YY4xPvk9eDm6pUdSwbO3VPI11O4mSjKHC/nFJF98mCTUxbnbxu4uar9eNwtHWL4it5Ut2fYdCW6yCZ8a9hKxsogsNEUpaa9L7vI+QaoI4l0jzEbUroKX0AfE913jFpDOhVC3991GRH4m8rvCHavVhdyYOtzpsROfKUIfTLWs5uNPuBSDp8AUL4dTmWjlZNlxhgOiRJDg==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39840400004)(396003)(376002)(136003)(189003)(199004)(386003)(25786009)(3846002)(476003)(956004)(2616005)(2906002)(16526019)(74482002)(36756003)(7416002)(1076002)(486006)(446003)(86362001)(26005)(105586002)(186003)(11346002)(97736004)(305945005)(106356001)(6116002)(6506007)(5660300001)(66066001)(8676002)(2361001)(6666003)(81156014)(6512007)(68736007)(47776003)(7736002)(81166006)(54906003)(478600001)(2351001)(8936002)(53936002)(48376002)(16586007)(76176011)(52116002)(51416003)(6916009)(50466002)(6486002)(50226002)(4326008)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2456;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2456;23:BYet07jSF/ylCHM58E2/bs2M5c6EmKFv+zy1VIi?=
 =?us-ascii?Q?Amw7PGn1/eo4rfZIhukuLEDr8rK9b4B9fZb9rLnlxa1/NfrCE+wcPdFtxCp0?=
 =?us-ascii?Q?sukM4mZwGqIf4Gs3RskB0rO1E3//n0Stkt1DCdCQdXLM6GkrlzODE2M8j+fZ?=
 =?us-ascii?Q?axsDEgzdnBAMFkDh5G4BbcyiWNW4LdxLHZ74JVtUpPVFyxCoUdMzT3BThvXk?=
 =?us-ascii?Q?n20Y00Nl2HkqnT2RuC7ivZmWmmIzvHCQ9PHAT5Xe/SvDaMRMF/CHlOtaYTb/?=
 =?us-ascii?Q?lYiddN8m6EjRS5Q8cYpRspXP5IcqDu9LTNoR1G5NBogFBNVx4GiZn5y+V5dd?=
 =?us-ascii?Q?NSdsxwqjg7VL2VsG54ArdShR3HgkPKD4vsEz8Ul2op4+PpZpE3DAtK9r/CRa?=
 =?us-ascii?Q?pXulrm45H91cUfjFBRUNXRnzdPynwx+WijqGKFyVhDxkF/cNY0Es5FSr8sP8?=
 =?us-ascii?Q?3bIUY9/ZislXVJbKSV2fW/fJpI0AEIz4xogEpzAJt/wrN3YRbzAb/PzqUUdT?=
 =?us-ascii?Q?7ngK4Vk6LBT6i9LrloUuFE6wQ2eDJ0WCXhW1bwQ4UtT63glqeImVAdnK7C63?=
 =?us-ascii?Q?rBcMsfeabRikDSgWtL5FamY1RNui0j2mqOxyu8j7+bX7+OJEqA0C2wgu4Jk6?=
 =?us-ascii?Q?I+6GJ24W0OpZW3UUneLFXRVo6tcw5r6CPE/1C+THFtIaRCQ4lB70e62ExF2f?=
 =?us-ascii?Q?Thi2i7PGxXxYI2UFSAPiR7pOztrdpnJUd/hCYL8H7bPUCqySWgYv60CcP1Tm?=
 =?us-ascii?Q?Gq8Hc6/Au5LslPBC0OgAJ+OyPaA/Q57WDxIdAw7w5rVpn40YUlWxyk9xGD1d?=
 =?us-ascii?Q?MubyWAmjowBMIxWvTD8XSI4CAYFGHaYv3n9CWAkfiSVrN6+hfkwtx0FjZOJw?=
 =?us-ascii?Q?q3BrqfdR8V5BkGhl+OxBMH1fo7VK/UB5ejdeOVe5rWWbdgg1TUVERsqjsCcG?=
 =?us-ascii?Q?Yrt+EKQ6r8nLiKuwkDzXF3RxU7qmmJ0DKduPGl5KO5qdFs+LXwgBroO71UI2?=
 =?us-ascii?Q?8XWMH34Qmxztl4UdNAHFPt5CrzR+9VfUgP7tj2IezOB58b+zyD76XibI9trl?=
 =?us-ascii?Q?uDC2PqhV31XwkZpAqxKkJyL5xYugIgGJ0FcrxLdbdtUuxm5mLUvIPif74k/8?=
 =?us-ascii?Q?GuIgAdBm7l8PgumHvgGQJVRDxEJIAUSiOJCjvjefGNgp/CCbAc1lbONzCvOj?=
 =?us-ascii?Q?eD8hrh0VUFjWtTe8SZj2zX6kzyQix+LvzeA4ED5K7WQcWcVymSWW5Ikhfrqf?=
 =?us-ascii?Q?0LDTb9zokMTsNTcC9ch1m7Fb10rd09q10/RS0EqsPeWy7EWv+eYOpY3Mff8C?=
 =?us-ascii?Q?rwVN34aW3u0mJRQCeLJTgfeM=3D?=
X-Microsoft-Antispam-Message-Info: oS5Pe44b78C/lVw8snoYMiH0eWJxf4Kw6fgBKXXnlPh/0uTtHq7cNv/BVvA/1b/m/04tqXjT6JcailOTsCH0cfzklUVcYTTO7HZhSS8IYs99Tx3K/BD02Zue7hUcQVwE4JJYfR02b0pajEONOPTz+GjaaWHfkPicV3huJwdA29vjnhNh5raesne84NZKuDdc8tFV9Z+SjbI6yQAd8YtSOsCBSZ+O5ws+75rMkoLnThoDgQswZeFSPwoddTJ57Zzv/L/pomxN0AfYLQvpXS9KS7jEwrEZQForeFGxs7CKbVGNfKVvCqmcJDLeO5QYArcTAzsx+CPoKiKPWNkUfhemYy4kojSTH8bQFOrQsiwbVZA=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;6:mlKX8nIRj8J/gXWZBXl5GD8wBD64wCA+U3cMyVZdZRC2Yv5MyjtCqct3irtAQ3KkBFOtgy9uVRKqxSbbSZ7mxH0tFfM9WKVPtnMTQpZKPtjudCy6M/sOSG0YWW+rzOQSRNyDOCRVArM31Pvvgo8MGghLWIB2V5urc0ZLkHYUa0WfCCjCpR4ibTLkcTktJHK4RTpNb6gj7+wC1/Bzv2wVGh/UZ6NPIN4MDUIHlewUL+a3Sq6VsEHBanq98OHLIUcJs1paOhy74yU6wh3XWAhoVBT/A8dd8Sj/NVB5VEpfRZ2osgjvErO5maE9PYCr77VwgyuL1pLzlEST+plgHO8imHSxKMZvaf0bu9RjIIyJuWhk6boitdbNIu9EdWYEkt4RMghsDnFCHwUmwmFegu8L9xSPA4R3IEzySJsJf9JNSq0Su/S2UlJSijWiKgEU3voIwlIEen8Dtn9NpKsB04gqdQ==;5:M9spCrhmL53Rfklrnq6Fb3fvH8vCeyIIqc4LG9w9P1H8X3vkRG7xPIl6R1z9QMg6ccuWu5TOR/VOqgsBAjEEYwfYaEtz+NiROtiZrEZFn0XEz1DWHmG/Kf/If8Gi4Q1C/3tRdt8rdwdOxtTkk6vyx5JdadRzg5os3vcA3gHBXHc=;7:EebYwjSCUDIVjU8pYBKSjHq5rNnfdPHjlbYPYpLtfSRr0qJsJZoUZ16+N3IN7AQ9el1mVevpi9R8HeZk7lzv526Sxf/pYeY8GoCxh86VbhpaUjwwbqAXdcJHcIjvFQZCAKIdvApRmstkkrjEz4CBuRMp5ce7qV+BxHfeUfORcoLtKIdGzyfQ4AmgbVmp+QIE75KAvpjbzjDbB1s0ovP+gnzcPLsjObxYQN+opp5jKwdXh2Py+STN7JiVA0IZvgtv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 10:11:42.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976120e4-2108-4209-91ba-08d5f929830d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2456
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
 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..10e8707d1443 100644
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
@@ -15,6 +15,14 @@ Required children nodes:
  to external devices using the OF graph reprensentation (see ../graph.txt).
  At least one port node is required.
 
+Optional properties in grandchild nodes:
+ Any endpoint grandchild node may specify a desired video interface
+ according to ../../media/video-interfaces.txt, specifically
+ - bus-type: must be <0>.
+ - bus-width: recognized values are <12>, <16>, <18> and <24>, and
+   override any output mode selection heuristic, forcing "rgb444",
+   "rgb565", "rgb666" and "rgb888" respectively.
+
 Example:
 
 	hlcdc: hlcdc@f0030000 {
@@ -50,3 +58,25 @@ Example:
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
+					bus-type = <0>;
+					bus-width = <16>;
+				};
+			};
+		};
+	};
-- 
2.11.0

