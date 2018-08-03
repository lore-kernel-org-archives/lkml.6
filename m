Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A43C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99A42173B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="VmrOCkUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99A42173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbeHCJSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:18:30 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:55616
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732559AbeHCJS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKsew1siSwPqW5DAZ1xy5qIjbCjY6YK/8pBCMVxUk9M=;
 b=VmrOCkUZzLezsvJVlpr6jtWHp6pyepstFT7aThhw5FkQuVh4C/iJG37PInwOtx615noVVJA+LiqQzxjdxeF+/oWlaCXzK0Mg8M3KPA/GEqSeOqMs6eC5yDAfmzBQ1MnG86DBzW97Iz1WtSoD+W+AzEVZIHT19ue7oEn6QuzG0Ps=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (10.168.147.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 07:23:26 +0000
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
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RESEND PATCH v5 2/3] dt-bindings: display: atmel: optional video-interface of endpoints
Date:   Fri,  3 Aug 2018 09:23:07 +0200
Message-Id: <20180803072308.14962-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803072308.14962-1-peda@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (52.133.96.161) To
 HE1PR0201MB2460.eurprd02.prod.outlook.com (10.168.147.8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d83d0e-ca63-4d3c-451d-08d5f912021d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:Rsc47zwWpnO0oj56BSzDMUExHyechYFlV17f7lbNitkZvXSIJXvEGXo6cI9Vt8g8u9auYqSIOaFaRTJ+eqOhBLIJ9fcmRiLMnZByIacACWJTomY7uqFuIPjI24twUnD/ncyY+gWgVTnge26XVeur9r0HwfWb7MsyMcfJbbGt8kpG6cSBp8sonh63wAf+ry2Bzo/tub7QrNeX4GvGfcePdsh6k3Z/brmvJINFXqfb8huKh0iCT99PnQLZcoBQwdt/;25:rVbQFK1tEeF+XDotAeiOszcvhc6RLMWAYVFb3FNeOMT/2/KhCviPFJ8By0GzH47R5XcPfv/sG65orhNEf6L27K4O+KaaKBh34qowjwjbPpbM+sfEmx3n7WPLXhc6iJD/tqKxb0KiXscDVlmv1I1oon53XhHhyK+ivmIAS2jnVdOsJnGiSCe4tkcjY74sLmvNUyVq9276g3Se6sbpHXZFE06WNohtsYpP5/djGiJkAYxfnUuyZCU1GwCgFUMReoxLhhazfJF4HOCl+aWWHwB63wy9f6ivxdUMj2t1sSzUR5DbIUVC1izlVnIJ8jeij5pmr8UGUykkGWVKlm1H/43SDg==;31:ng67dRyxKyQ1RdKBI9PAx7JdRAiWNWnp5MbrRKieaJBHfTT547LHoG9PtC8prI6kGweX0zjtS257kQZ/47m77K49N94vBZssfP0kUPVp+bFPHBm6BN6BNuUVi6B8NqZ9oExT9CoMooop4AlJwbIevP41rEFZCwr869TjT92QTT+GII/Us3vfCyWOg7EeE/3DIXFfYUr7ZwB9nodZB5ImQYrkpfou5k045Ivr1lhp4wc=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460906D02F7B3306971CF15BC230@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:QWsHr1ZuqSkv9X5u809MHmtlX4KAoYI2xmhraVwbg5fGbh+7nWxylaW/s2hIKka05dxSBfayXTDBuJMtNHBLa7ra2gNli53Ois8T68cBjtr6rhGUm0c2P4BmHfXN0IULgajdvLvGVLP8ketWaN0rZzA+PCumLjXt3xoaVeeUzZx6eKUleq6okCRCHRh79o2XyNtNN3oQ9vaQoEGxCmFdqzor79Ay1lmR1DugWv2FwLFRN6PFxzWIV6bNS4vB3biPmotPllhRkhwxZEJudP17xA==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(2616005)(476003)(16586007)(2361001)(478600001)(11346002)(76176011)(51416003)(4326008)(486006)(47776003)(305945005)(52116002)(25786009)(217873002)(54906003)(66066001)(2351001)(446003)(956004)(105586002)(68736007)(36756003)(316002)(106356001)(74482002)(186003)(50226002)(6486002)(97736004)(8936002)(1076002)(386003)(6512007)(7736002)(8676002)(2906002)(3846002)(6116002)(16526019)(53936002)(6506007)(6666003)(50466002)(86362001)(26005)(81166006)(81156014)(6916009)(5660300001)(7416002)(48376002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:xqpy7kvtsaTHwEe3/tyAUGPAN8TVZO4F9hrdLHe?=
 =?us-ascii?Q?xaBOhkrC0t4hpf20LOI0zbV3xXsfydS4Cxf5D8ihbqydBGcLkd9uEQouRYTC?=
 =?us-ascii?Q?DwqkkVH72J7euOYyh/e03oHMYHoA7kQ76ziXEeC1K1MP8pjpr+4pX/qjbSKn?=
 =?us-ascii?Q?h1JLEQMC0xa6gxJ2h0qqwXkE7NXBqiRJdxO60ML7p+TBB2lrZEiw+w1CqeZt?=
 =?us-ascii?Q?JvIh8wXvYKfaJ8oRmlQjuYJUc4KmxNtRauJ3F8mr2XrqQwXPxX+ySxSBNx6Z?=
 =?us-ascii?Q?iH/pJsNVeq4pkHjx7h8WMRi1Vjb50Pl38EObMZjtzfLjO7hCMbDiIBHCSCE/?=
 =?us-ascii?Q?y5b0q0QHr/5gnsHTBS7PkMDsuCS59o56uQ6WR3p9wI+iSruzBa/8huPfyPwg?=
 =?us-ascii?Q?Z+0F+jSK+qvO1NxKATEfUF2kJ55/qY4vHn0guVHJf+E3TfUL+g8UuTgc4tDy?=
 =?us-ascii?Q?lUzsEv6l8VeXICuLp00X5lFBahyuoNHonNOFwzK1I/ZtxAFshQ9RFBQASaXR?=
 =?us-ascii?Q?E/F4XXgkIuneYVt4KiN4Igmwbsodgl0FvSogw9YzPq9Zb3FzjclcNBOG4IPG?=
 =?us-ascii?Q?Z5Gb6joLkL6F0uy6nLdSpdCPjd0PfQWk+TIeeVPidWsCUSemWU3ONV8bM3eb?=
 =?us-ascii?Q?YV41DSwKHOSL+jwS7lkR6Cw3uSRkMUpnuPvvBCmcdWq+DdvER44Qh+a5qMc4?=
 =?us-ascii?Q?eZRJDMy0vkWDXWJsrQ5trA/RbRGgE2CN0TQz+BFFKAw8/5JBJA6QxPUPMl+6?=
 =?us-ascii?Q?y/WIahWgJCAXgIwikKVYdDtFSI4+gt8zPGsZQeOKeqhA1tA50fxw6nF0Wq9a?=
 =?us-ascii?Q?I394YmD7pOMXpYQWdx2TALAb252k2BBN8VBo7ZOL7Dp9RsSWRWJWYpaDHRF3?=
 =?us-ascii?Q?YiviIFVTnZPS0A7ajiwlnU0pankAqY+tyXnfGchSYPsesYa5PEpU53KfgG1z?=
 =?us-ascii?Q?ULKGvdEc8kbqoWiyVeNuF8BlAx392ZNpk7lEJkArxoH/68vyV/5uDoYlTRWO?=
 =?us-ascii?Q?Ab5K+2m33y02U2FrEAnwClbmIIFlrFLjqXQKybMUt7ZQb4q/FGCTCLKrMF84?=
 =?us-ascii?Q?+DsW+TPB4l3OB0wx10vF99tZncSpXzka9r/us/dD+H5fD/um8jBx4F+L5/OK?=
 =?us-ascii?Q?CzQmS0XDdxhFcxHxt33bhmb9dY12gJPMDKLjiGRNLD2PDxHITCENeB5oefPX?=
 =?us-ascii?Q?w/HIbBG3cqvocs4qdJmBN0z/HGbTsqkV1pn7UXUAxqBaM2pZeKHdiYO0ETBr?=
 =?us-ascii?Q?H9Ea5Yvu8mJ/wuSJ67T3FGzeWWlevvHIBdqF3Jdw1x9OYI/T644civXDB4dN?=
 =?us-ascii?Q?iaDqOwCO9XbpTOmd6hqet116crU7vxlHI1gXPKNscoyzz?=
X-Microsoft-Antispam-Message-Info: izJ5RqRgTMkLE3Py352Wk+tv4oyVO4ePPum1VcwcKmMUkAXWvoi9aVmBfnonFFE7B4TMwdAqrl+/W78zHmkFiUnbkbGW8ApZf2jEvv9+6Qx1irDeclW7VfXHj7FcGvijuWR+nka8B2Xz1l7kIzQTeTcFRz/P08z3jv31HuopHl8hVexPgzbWkLbh+fWUV5DUhZzfR9S6EmH4md8Rvz69D7XrvMBb3Lx/A4dpGmasBF9VexhRMAMAo5ZvC7ebfezCPUIvSTcbq1PtcXNKRXn3y3wK9UlVnfcbC0Mw4PjtvsN38GgF8y4SIbGV5yB6FtWi3NVKYZFqWCjT3MhxNvdeD60Qob1dg4ySAy1vwyDCyOk=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:lMkXX2nAjOFRnlmbNogtp38PN/i7/DE37phFSHcAcP5BW/Nm2867R3QHFTCCXv/umjrwrQlyX1XeIBLox6Ij27BNCDDo3s2OPVp11kxHVTlKihHspgS7hox/XADUQhiLKZpRXqXF9c0mMSgdnr/sw5tn2TjXW9uPU8KEhAf7cW5q6EpeYXpgo/xq/PMXQoJGPfyqOFZbs54uLHBHdVJl/XsJJ28P8eLfiumpnhUDgz+Z8gMGXfhK1Qal4Ie7UDsDmpenkZOFCOA9Cnde1N+7PYbsOu6Yj/NDprgra5cLNi9bFZrxZ7L91DTYUYDRB1LyqJoGYEU9j/IYjnF3ARHuuOTERGmwE4ZwDVg9tiehxb1VjeJI215xNj2R7O1aG+KxWO/xx4/gd+OXUCRk8j00FkAEfAx3X7ulQSO1xqRQaTQ4kJR8iznk2sNaTHA0xIOxUYbMm8jHZIDAKi+YzuK07w==;5:5kTR4twWB46eM30EAoj1st0eESMqIGaeuG03HI5PLrjTe1KIQ3pa84qfA9EytUJl3plutZ6zuvzO6WFMJOBj4EVH4H2jjy3WzpPti7z7jbD9eetw388l9oEwEgTC0dNiyW3/Aey6fid4H8gAAfSoYCKZ6pkELC4Z4s2wqhSjLD0=;7:CO/9abcvEAZAJq6EKbV7tGkLwupp5b8lapVRqlMRNeA0Ul2dYCPqSnLiSqDDXjlRS4oP/C41pr51QnAPMJnU1qs03/XbZLHlkT20h9mUGkkZaAPU3EecHflgNbjh9wJ3KEtZy6gNiXi+678Fedl6iDcm/EuumDNT526SmcZAkdVbD7eU7dtJuiLsRz43clYF9xZd60MzfuJP9/3AD1DbMx+4Zdpw3zwVZFc1pymo+RHQRsRH1DEewfNJ8p34c0Zr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 07:23:26.8462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d83d0e-ca63-4d3c-451d-08d5f912021d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
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
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..9de434a8f523 100644
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
@@ -50,3 +58,21 @@ Example:
 			#pwm-cells = <3>;
 		};
 	};
+
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
+					bus-type = <0>;
+					bus-width = <16>;
+				};
+			};
+		};
+	};
-- 
2.11.0

