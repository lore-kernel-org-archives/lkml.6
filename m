Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeDWHXm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:23:42 -0400
Received: from mail-eopbgr50094.outbound.protection.outlook.com ([40.107.5.94]:30971
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754118AbeDWHX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:27 -0400
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
Subject: [PATCH v4 2/8] dt-bindings: display: atmel: optional video-interface of endpoints
Date: Mon, 23 Apr 2018 09:22:55 +0200
Message-Id: <20180423072301.11962-3-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:tO6HLtPl/cb9iBXatrMaUCu8TyrRR6lWwdQrr9V/ztcB+D962zDm29X5VRTCzqTT6gYFk/NHZRFqn5uEi+3houJuNB/+P5g9FiNsa7F6wMOvwQo86982/u0/dU4eyfu/3C513iQ9t7k3wQy45YZP8ojs656jqOBKSb2YvIXDW9BDtv8Qcb5zgl9eUGvlBtZRoCVA43DvfJ13SoX8HLPw0WWxJnN97iqbWSYUNrX+M4pQ0ao73/+N0YLYu+M+b/bS;25:JPY+dGdX1vpinvQUOsCGQRLBGhrUP4IScp7F5vm+qLfaHzWyiBL3rkPDizwo4MYopQCKD0iGm6PzprBUKQpQ5KWC600zHAWAlyKo2ABRCLUQqrrcdflMUwce31oS7flfbZcK9DfTOfU1WvL6O+62UeFp1UreZx76rieeBbBFoTCqr3YGU5iHDuEvIg6tWbbji+ezSFv0kK74AhFs7zAPRm3ZLcP/oZe2krNMG0af+oo3ldbuOe92OTUPW5oo8dlWCR+KBtVaZpDROZjkq3LdDvX0zdfa7n5hi1ewn7bWyvKUSV9hTVHWGrstEpX2sr4HKe9Bh+3cm6hEokrE62Mzyw==;31:H4kkPJtXJv0syseRbreqvcu2g+n5SvQOrtD4MbhBv8FtJaEaSFt3lomVQZSgkPzkLnSbRX9x4y5t9THxNgIbpQqDvfghtCzfHeH9Eb/jwoMKWy3+JkdcyRsNlP1smjs/JiQZebtJ7+jkY7kppdGSzl7u39vmesMJfKRZMaTOdMc+zHre4kD9yF8j3zFKVv6RPa6dIQjXOySCw5h/q5IjxMl0aUtlGVbx0ObvCFxc06Q=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27744470C74DE8DE9391F5BBBC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:pBag/hh84rqa0nbGv1jgzDbFSNDIxUMh5bbbkYouK8makjD4qDddrWVIFOzv7NBDtcUGUH3scdAUY7r6mxHsdGBN5v9G3Q57odPUZIhkCupqTUUfSY+2mg4QjsadO/ArZSBBW06JWGBjcrEZvLj+kg3q9Tru3Fc74ShTdWEfHdWPdQGO1D8U1JeutV7RST0g9yZ+PBf7hB8yE1hXb6C9ynryGd93Vkcf0nXiPZQLxyAGhX9tpJEThIv3d9iSZ3c6wWT7vKqX+6JeJp2Wr12qvA==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(6506007)(386003)(2351001)(25786009)(2361001)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(11346002)(76176011)(478600001)(52116002)(66066001)(86362001)(2906002)(446003)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:vpUmEASKNZsI3GavH2rB7UcuGNNtNJ3F/PrEZYD?=
 =?us-ascii?Q?wHIvyC5jb0F3ink4Zddm1LnXzh3qteH/4bpIZyWFcJY/YQgIa4oPfgWMvXoR?=
 =?us-ascii?Q?CoxqHlSBnPsTKS7N0McUKEdRmyL1SMt8kw1Bg572etCK/80oZxxOpsujN5vy?=
 =?us-ascii?Q?IxmZkRjM06DIM15JcmpuTl2HsVwmP6HnW5gr1UdzSOetzxXezEtwfBnry0Um?=
 =?us-ascii?Q?6AEQSGUNDuBHCn8rEhEQntsNGjvARxCbcc1wV8MjNaZSWGIWsJNTTPyXxvuU?=
 =?us-ascii?Q?2CDIznA2fkBa8gyxQLfZqIbS64hLcN2573NJXh35q7roA4nlOqeXqdHmUYr1?=
 =?us-ascii?Q?qzJ3drkrcx86fFs3ljqNP2zFlEdDL8MMGZ09c90o0fZ9yu9xjO+3gmh2rtrH?=
 =?us-ascii?Q?u1IdmviMuuEkDPsaqm8EBGrQEOxqAJMBOlc+m05YBfqoWMcroSE/wT2lqNIa?=
 =?us-ascii?Q?c725HcSYwBe3sIvoUKOOdttWaXSAD7HQMSsANP7yfuE7+AD5oLOhGNbKB4fs?=
 =?us-ascii?Q?z1vzyrJP0f/iMtWcS5mXEDOgw+huqrocL0VwO5YL9y/tQDocqllA1MGWNOCj?=
 =?us-ascii?Q?CC8dHFEQsJQmCOX4y1PWZZVB5sx3R2khTD/c9+8uwu8HaDQooBfniv56ho34?=
 =?us-ascii?Q?uQM8HzdBQGqUVSuUQEuXHhg/xXKy/xI/Lfo6FSd/IoUUx+fZO66vrJ8RQr/s?=
 =?us-ascii?Q?N+fypVnJ8pCEAIPX1JC/g18l1eqJMwYRABXgGcwxZRQRO2bP35WppBLE2yBc?=
 =?us-ascii?Q?GKWQvdczzJJn6Opy0hkec5PhOzHoTEp3TlAsEeQGMDVRvK2Qrp+X8iVKgPfZ?=
 =?us-ascii?Q?OzxdTbJGaD6dXFbXPVLLkWzrT341g925BvQr6lQQ0EqTle8JvARl23hs5QN/?=
 =?us-ascii?Q?XlcadFu8KiHn35aujwjkFArOxWccluqQCZUlaOT1CxCm516aAGId78FtUv1v?=
 =?us-ascii?Q?1I6avjEl2qA3v8/xAD4I6cIdnzB+RT8FuajVJlBIJzqXQh5CPKJWnDSUJBjC?=
 =?us-ascii?Q?I29tzQuWX8PeJCt8tPQiLYe68MqME6vcS8g/kBBiDS7zE5Ujw9FdJR8n9/LD?=
 =?us-ascii?Q?eWOBP90Xe7NB2AhDZBGvqnQKo0FpuTdFU4nn4avEyIYO6bAMBEciRKVPBTMm?=
 =?us-ascii?Q?alN9xSxozRCY=3D?=
X-Microsoft-Antispam-Message-Info: CqZUumsoVRryIwiRIDrr/mDZ5f+5QxqlB+6heJDqJ6BLQn9aHdrdFu9TSLZo5lsou1kRpZ8jJCRrv1ROadvhdAiyaLLMhArxDWYrf0ymK0ZIusZLHF9Kro/yUCKLrLc63tV3tq0d2pc8fOK4NE4qLplQvjak1uSZgpASmujyeG6gxvdoVUIlw7JH7O77DdjB
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:DtSauDB4Z/ZILWpnuJbNmLy1unuPema6FJpUf++0EQv6O3imyljY1pZrRds11NAKwatjMBu06voOyu7lCgQ1y237CPLl7d0JPaYD5bZ3w9S3agdEcVTkmaIkiv4D/e5o0cq6Z4Ets0ssAmd73w+mFdbt2h0cyDLbu3mbgZLJ+16l6a0K+r8L5+BmnRnwT82Pcjuz8sOccvojfJaoRpfiDu3wTq5SB6gPeQBiBdkpY0VnNuU/WT48LF2j3aakwz9BaJLwi21LacYyl3cy09ILGKIxMZnkaox4htXIjJwT+aUmUA3FqjcCd3aC4i0srr4MHQG1ioRm0cw3Eru4LmU94DUW4wqBK4kc/VaARAF7q3YDPd+u4x/6ux6eOqaTIofdeOim4mrqKsyqDsiH613AXvoTbKV4uqdeRnq59eE+9mbc+lFBALYXLm4eihYcosvh34rri1kizwIeYBo0pWjuqw==;5:nI+x1BT5QeiB1rSlFdFi5DS+S9rQDC3Q1LC33wxSftGHugNqxbToa/6io8anU/rHurx32r5C1e6Ggl0vF07E2beOtkntvgT+jal5FBtd/ZrazYhP3aSXwFsN4h+DMlzsnzkoqLQtsQvNQz6YL7ZSKM7vumb0yNVe13BAk8GNBiY=;24:wf2Aq8v9QmTETOHIEfVuA0ObWmghOe5dCm0wd0O54FcV1fwwIP+ptaZLOzP0RE1S1uw+XmJ/xpyIQaCJ4h4twqRxDM4KtHZfjpt8VksYku0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:myCHzpYKYFxKpVjDAK21FdZFULX398zDw+qegv0mBDckBopypqtfQyBcT55stOEjpN6tY+bCihWA8Pe/Si6pWmjoUNgWmCamGmRfiHhjniX7e3rsT+dYUWjjr+ZLqWyzAkYoySuDqAD+qi1bsPlLX3SSTi4GhojwtWkJCc3dj95goDXWQIEPcj7P6MguWPH7TP3MF5wNZpCVCwXl1/UppAcgVXjioQHItMoEQUXpxp+njQkgqjS7KYNBEKMptTnI
X-MS-Office365-Filtering-Correlation-Id: df9e9ed2-0c0b-45b6-df7c-08d5a8eb1a64
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:24.4361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9e9ed2-0c0b-45b6-df7c-08d5a8eb1a64
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
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
