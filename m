Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC5C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0132186B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="pobS+05p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0132186B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeHJPeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:34:14 -0400
Received: from mail-eopbgr00138.outbound.protection.outlook.com ([40.107.0.138]:13072
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbeHJPeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZCxZiPOq01DgtqeNoBYvdYLNpkWsLWQ+UV51mXhsgw=;
 b=pobS+05pInyk9L0WmQE/6lD7BApuFPhqZeNTz6r+ngRlt/OmxfLBVLCpwLA7uCaQxxd8bcs6JRX+4Q7QewxDgK5PKvAFNiApEZFYmrrmTVHS1k0GJM4V5gNuKz4yfhZUsDSnhrm3dOj38eP87CWuqCPDi3zNje8hW9Qy0Me2YXE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Fri, 10 Aug
 2018 13:04:19 +0000
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
Subject: [PATCH v8 2/4] dt-bindings: display: atmel: optional video-interface of endpoints
Date:   Fri, 10 Aug 2018 15:03:57 +0200
Message-Id: <20180810130359.9882-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180810130359.9882-1-peda@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR07CA0241.eurprd07.prod.outlook.com
 (2603:10a6:802:58::44) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b7cc891-e4e8-408e-895b-08d5fec1c941
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:6m15ST6OpNox+LEb4ILBXc4YE8fb0mL1iCN0vwfPKdrxu64ghJ03YVn/4qJtpAu5HtakDtLDVrF++rWYHZxei+dxLSJaG+W8auVVpm26OZ7zEVLJvsuZrjwgy8HYTWiS1SmZM1PKkGNi6g8uxsYwwVoXVTyNM+KoxaIulR0aahfep49zx6+yiBxP6M8rexdxDbroAEVeaN1ycrEZDJ78pxXfPBF3Z1czad63QmkVQ2mkViiSeBRpvQnxm77i9oAo;25:6PEnp+jDS+sV3j8dXcq0B53U1EvAaBJRy3QZrYCo+HryK6zKFHS9h6TbOlTSdPNgOWtMPbNwuIP30IwR7vdkV0QcvZPWMFKac8yDAMxt9PbwiYbBGgutldogTtWoD1tSssQLU55hbxigCcoKPISoVJAfbZEt2v5WhUEYY46Tw9NjsnUaDG4jNL17P0fRyAgbw1ArB8MRL6XCiSoTiXTCsvSRE/Pse7qnoW9bZOtqdwTXEJb1IftoHrAT5Rrw6rDbeQmQmU/a1XsERKivLnz2Cci/b7zI0GwzytMxmjcz1VdqedW4UPpnvEnqTIq3Ja8pE5ZdbNnHYx/dNnFCVh+WRg==;31:2Ank5urEubIVNDaqEig7QtG/CTINRK298PYSTo8mq+uwKPOF6DQSsJMp1mdMaAzg75MDm0O0G32Y0qQm1bhNBahK+vpaVHjVLhYRDdb3qjAo15Wh1vdR/VQMr1CqAdiTM+oZG7PD3LXb8IxFyfv6NqEP45xU/e513D1qBPUZbPV47Mm7zMZ+mUMyhIn4Niuqqe1+QZeSQ/A3X3bdPS+AIxMlJPFbRFhYCPqVW8Vrul0=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246412383CE9DD28EE41008EBC240@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:WuqNUpfrHMg5UvdV4/p8Gp/+f6TfqzIUBhwNV9UcA53/kFOhOzLolVcudj93F4CtNdUTVg7/HhMpLnDTyPpTqkuZHFtuwOxF7WaA7baGAf4XJLl1CziRleyBlWHZG9ab64HQtfIjuweeXVcF5y1wXSqQqONE8EM4erKyo1VD8E6V52d5T44iNhtKllF4jGpMF3Gy9uajyOXHyFUHw9Qx+r/OMRmnzdJK/ljz+9DTF20CC6CD1lh8tYbtej76gCMYDyR5SJnRgsTMpBNFLL0r0g==
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(3846002)(16526019)(50466002)(74482002)(50226002)(36756003)(305945005)(47776003)(8936002)(186003)(4326008)(86362001)(26005)(54906003)(48376002)(1076002)(6116002)(68736007)(6486002)(7736002)(76176011)(16586007)(25786009)(7416002)(6666003)(105586002)(81166006)(81156014)(316002)(8676002)(478600001)(6512007)(476003)(53936002)(956004)(2616005)(2361001)(2351001)(6506007)(52116002)(386003)(51416003)(5660300001)(106356001)(6916009)(11346002)(2906002)(486006)(446003)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:dGT7XqxOcuN6YwNIq8n8ivlLfYaMLC6Kw/8KhuT?=
 =?us-ascii?Q?d42IC9s+6ZSeL12m9Xw70GQmslAP7GdmdfYWavnazzaS2xIlGdYlt7TWK0UL?=
 =?us-ascii?Q?bCJ9LG0sNJVXJTlg2KmeswCU5E6kwd9UYD+ecCsdjFScZpJMNyee3RXDny1T?=
 =?us-ascii?Q?OVoTmen4XZXXg2v0c/ZExYvp1YhBjjcfFpWUTxPWRJlN/L2tDJY0bB9Pw27C?=
 =?us-ascii?Q?TVs4gYRQ6XXwzXFq698/3C3dVl7Zbf78gkgcDu6ShVgnn4of0s4R/0NOkbtN?=
 =?us-ascii?Q?uobGNl7ZmY9ChDIJq9El1ZOQ7nXAwJJrp7KvAC8rXjusluWPCw9ZbYY0gJYp?=
 =?us-ascii?Q?cmb9CFMWvIAPZIP1y9EZ8e4gc7sB5aipYP2WMdimeOrBETbJUkP1zwQaKHMa?=
 =?us-ascii?Q?zfF6PON3xNpGyw7Sfad0cCQFtM1AJbFgK1IgTXpQm0K+wOK5eDm1LcHXaZv7?=
 =?us-ascii?Q?JdvbVfHH15VDiQRqm5NWSq4AtfnuR7jn7x5jIC6EPH3yUs04e1FBnZNB9zjf?=
 =?us-ascii?Q?rENCwp45ciqHZAWLo4yqas4MTtZBoVGjVIDGDjsYK6XC4OPx6Z5Ng3SfD7PR?=
 =?us-ascii?Q?+wimhkThRVPqBZGO0/+IXqkud+hindmO/l0bU1iBDZPqn5En7Eo0IhTzpkHz?=
 =?us-ascii?Q?hS5sjpTBDV7+F3oyI7iHV7147QHBOY9Zm4Eyecuf/47KIBYr5B+HkaBIe5iz?=
 =?us-ascii?Q?KzZUdhXk0jp1+lsy0i9VPI5O637tfqWnYz2f5/ieYdbVjmoFX1tGFffUx9E7?=
 =?us-ascii?Q?mOQr5cPfqWOfWZrNzm5OUl8/DeUHPokFMrSji4YnwfQF6RF1cCJS5ikVIgjO?=
 =?us-ascii?Q?rBY9Zg7nOOqjr+AP/2+O8R+8IMUck/VFKGLaJZwc0kGpOAyPoeOsZvpWluN8?=
 =?us-ascii?Q?UVLJEr89HqXzzfXRb+P3OKZsqD9/zLD9msek3zrj07HmF3jwJMiVYOkEImK9?=
 =?us-ascii?Q?E28O348XMKS1HZF4AmvzHIb+USgAVIQpe+1YEFaG5aaja0OF2pRn5o+5y65w?=
 =?us-ascii?Q?/OiRhpWidWaLteuRIA1teEnMqME60GakoixNfkjDw7FSqu6mt/NcBueb7Y5C?=
 =?us-ascii?Q?OzQXLCd0b6FngY82kok0ffGbUabfz/WVqAoxLFC237pbt4SWCD8/frPwhVkg?=
 =?us-ascii?Q?xdSvDlNz56oLfR3/X2kh4tzvWuLyOrges9/rTO/UeuPq2QOrwlAC3AoZ552y?=
 =?us-ascii?Q?DKcrV2b0DFPqFm+2nacRDwB4Y+0nA59APcnnsSEjv4WiWtyFoiO29F3kqaCC?=
 =?us-ascii?Q?gUAPmJ5vmDujv7ElLW/zr1sEgc6qrldQ32Csox0xbZ/sl3756wFmTmeKWzXd?=
 =?us-ascii?Q?v7t75g3rDwe33jqjr9Z2mmEQ=3D?=
X-Microsoft-Antispam-Message-Info: pSL6X6TgQj8toyQNgzCsNcAqGCTRa4FhPVdr57wa4kCkMFdYqAWcLYCdoiQzfHUrNdjsVc8ORI8cqQ9iQB7S3X161uLFkE6OQRRWpJ3/xFNDxPcxzXSTILQAiFE68PYgB/mpYjSJkRttOA5bS6aD0zxwPzlWT/StnnR1bJzH2BpDao0/d3nbzm/Gaj2TS8aCFbKn2G+fM7WXuqmEzw/Et5mkxI9/gVpEX/CwCearLNBt8qqukQtT1+ds94FVcjO1IXp2rtTxyrJvWiURbqDOxBEwDs56IFO9R2gDT92QBv9UHISvarXblUKMrBUCdIxWImZwKbRfwJEMe6lIIpTyQJMxlDPbOQe2VJIdvpIzC64=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:m+0l01ocOLjmo8QWIttV7B4EK3IlkhuSN5Fvfz2EbkboaplP75G39e5EjrFOonu+KolWx2C6l5Q63IxavxElsDl2adFL8I3TO6ZdeA++ApQ1PDPmTySiSQPTQmKdV/VrVXT3ckBvhrL8n+lTqqZm9UJ+AH6roB4lqM9Hgdm0nTrkFFtcwSuip6fQSAtMQt6d9Mh6R7ly3isKOlzbpSRSPz4KMGwN5R9A+JI3DNOSc5Eh9PAHgw3pKj02FhWP6XtNrhpEN1HPvpAtYTAE3XAxJUcxCfjawc7fErx69GGVOzFCbN364cEZVDrs2et5cMUvaH7WvDC+e5c1+GST1us382/wlQdK9NlVz+2WWmMsydHsSCNCv5uAmc+m8ZIZ+yk1hpwouR0WhF4+MeeB6S2FL/pKw9FZp+toTTH2BGpl+kV1r6ulFhLrKwipDAyNDqA+T+R6gc1gkoGAAMHK5C71qQ==;5:KMCKcV5XpvuYKxK5aWxWStcxEYvEwFyWmU9Kf7lDpGp6Uh5RNxcd0SnnA2+Nc3aEyUL5K1a814COXw7QCNKoskhRNkfULzZPcM820GZCGpN3pau4UcgdtF1w2OiGs10MwedY+1Yv/FxFlvZSwJYNvtnjrdApPeEKpjOcvibv6LE=;7:jWeEO8kuRAnd1CyGPA7nDHbCf/u5r6md0lC6/NEl474GQXRHbQc+9tniZIfq9oBN0iaGFsucjlI0axuzyBHzEq7/yG3y2liy8+zwla6ytIYLeCyMBxBGPJRlxUSiEGPFm4grZHpeY7P11j1Q9wP7iryheTmDqiR/e7H23SR496hw8dIUIcc5JKZUJ8tdoa2qQfJUncfivsfOwa/L6jLijSWoODNeCPeAxeiP0rhmKAOiR74u2hp6Fm5h6oYUtolA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 13:04:19.3326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7cc891-e4e8-408e-895b-08d5fec1c941
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
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

