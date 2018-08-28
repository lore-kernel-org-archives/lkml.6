Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E282C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFA02089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Kaer8+AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFA02089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeH1NkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:40:25 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com ([40.107.7.97]:45072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeH1NkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=673bZPMVZlLD9nyaDWbXtKVoijY+QGzXH9sR73vH0ho=;
 b=Kaer8+AFBA0alzKHLfHTOLYgrBz/Z18Xskdn3TYpQbFZkNmyCDpo/j2SeX2nTo5AfLMFjdDQkVzQ7jtEH0VmrjHE8iMdOYwFzW+80J35d45nCtTgg/J4IHBcpnthk6BWs67qLBItWIy/vzFlPiOKqSYeTM9CZEvGWtku+lnqMDs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 09:49:30 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: at91: nattis: move pinctrls for the lvds chip to the lvds node
Date:   Tue, 28 Aug 2018 11:48:43 +0200
Message-Id: <20180828094844.10018-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180828094844.10018-1-peda@axentia.se>
References: <20180828094844.10018-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbbc5cd-88f5-4ce2-5cc9-08d60ccb8d73
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:LdrVhrO+0h7hSXDLsuC4sn/iPgz2zWYl4UTz2FFisqB5vih2AMCSWgkFAaBLC0Kko5/4Pwzlw1avd0grOv2MEUnBu3J1jG4E6l6qZjNwiQ4/HxmToPujJZUR4LHpGhWMuiktdKOuVp8gbtVx1AlTFfxlBgDsqZ3drikcOV1Aa9VP+0yaRI5ah/0jmlepXeYC/hRkIto6cobIjbkGr1KPVUu5RieltYweUlG3C85DxLwfcHafO0mwCRwWnCL+v/Ee;25:PyHhK4gxLJCDC4uXZqZGt5nD8wcsTfR7WNHDr+6L5zZR8ra93eAJXggCZC4iq/yZ8tgF9SMshVb+E20dxyGrUsmmNxmGytyXutzVFT1smvfGMVdKRuwMpvtY1vV0WALt1ahT6/Qm8HaGPfHSHywg1LCkGd4kFCZQoD6cfXKISvmMEnyF1OKs48beO/qjNB3eyfjRHsbbSj8gluYd/u3xcQEzsxo/1e7rpc1ZMi2GicSN5xLgqkPTahPvgLp64Vy8IuQv+Bl7N4hVEB5c1HftLYhnzMZPR9AFacQL82+WtjNURqQN0oZHWdYaDnI+6M805576IOuN26zTsjLFfM0G9g==;31:+Rb3jhskPAnav9ztMHkc8B8mKWDV2PBX3qtRhIcAmkkkAFgfVYhLu96lzpzblVPdjHdP87ODuamMBC5SYiEVj43tjqZd/YPYsJsjGsETEMFWTXofpdZ1CCLOCoxX0E86dibqz1X4ZQIJt7gqSQhTvRj8JeG7TjJiPXcb1kZ/vHilRaYKw+bxENLlU+Mz+phu3vX7vLb4rIYjh8yarlvaU+lFL8IS+2rMPOr9iXuLdUg=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2449C5DEF05B784536E4AFEFBC0A0@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:1F0TLd9NVg01pU9QmafGSXOks9u3UOJRM9r6suCVyHesrAMd7+10HdsnuwtdSgPs1JQEJNZqgxe3eVgYGpTIvphbbtKCxUPVHkGheC1j2DmstAnUOzDvjJFLftHtuh5b2doave0ht17K9pIlm2DhZ1zqTZhw097BgHR50GlhXmpNYxb8kikyNubv7552qdPYShkZRCPLUN2p4djjd4IFGOOnZjVRitV5gZB1Hutbdsl1e6B/C1X+4KwC8s8ceJeoFBnY7m4bZMelZkyhK3GzkA==
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39830400003)(199004)(189003)(74482002)(16586007)(54906003)(26005)(4326008)(2351001)(6506007)(478600001)(316002)(386003)(16526019)(186003)(2361001)(36756003)(2616005)(476003)(50226002)(11346002)(956004)(446003)(6116002)(97736004)(8936002)(3846002)(1076002)(52116002)(25786009)(86362001)(575784001)(51416003)(76176011)(6916009)(5660300001)(6666003)(486006)(50466002)(48376002)(81166006)(53936002)(6486002)(6512007)(105586002)(81156014)(66066001)(106356001)(305945005)(8676002)(7736002)(47776003)(68736007)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2449;23:UJsoaC2K/oETqdHQk95ah73t0dFJZCCQonUJW7b?=
 =?us-ascii?Q?d8q7EsiVieMMinUe0dG/g8RqAM4wxQ32a1ExIkDxZKC2qOqvdsGS59KlqoTY?=
 =?us-ascii?Q?CF1UcY4VfGe9ZdGpK1hWk2rTi4UqzS2VXub5fSi0qGFtOhQu9QGDaeoL60i6?=
 =?us-ascii?Q?uhnj/Pr3dNRc+DYwC9g4OLYRfJ8ILSuCWRSe3esn1XA5nbJCVuRYZNPhA9sQ?=
 =?us-ascii?Q?fPD/IMC/XCtf06XZiISyQtvDv4XCxHJwBcIQDGk3/04N392rGNe9pWq13PZI?=
 =?us-ascii?Q?SMEpDVfu3ao4pg3u8271UyRakwbwqFPATQvQ0S/RgC9LQS1+cDjPoSwUS4YT?=
 =?us-ascii?Q?US6bLSElajqHuQqdwnrrsYVPEHhtJLhrVADPrH+ukk1gAcazF7vDeUTn6uTV?=
 =?us-ascii?Q?skeZB1YXR5SuexILnOO+a8+XVtcLAYOr/1sNRk2Iwx75ou+JTYH6b6vj/uX1?=
 =?us-ascii?Q?7p22maZSk17Ug946fgj+NoIBEGg52PWuw5znQHw2zLRSndg1DWLlnJT2p8zg?=
 =?us-ascii?Q?GANdqMWQIhO525jDHBtg8SrPsjUUPWOX9u3SMuazQ7oaH5pDQXXpBdyGLysh?=
 =?us-ascii?Q?sOyRZEyfnQfnSHtNAnhCcPC9tvVK6jT85UaEaI2Elr/VGpdLQowSqdYFg+9K?=
 =?us-ascii?Q?OMjucOGuPX/4TpN+eCU84VhxQBwwnV1y6hqMM7tMOOQGmeYVLzRvE6RobI3+?=
 =?us-ascii?Q?mnhaNWHf06U0yOVwrmtuOqUxfVmbVuNa9K7KEKYOyN6O7gZlz97ENtY+UDzp?=
 =?us-ascii?Q?VkqjT3fNyNnjyV9rpHDeoD9KvrEjwqjD26gghIW6FdCYeZ731x8dGjaBovzt?=
 =?us-ascii?Q?IFuyeVOtmUO2ksFFzULNXuutsPtvNV7hkDTvUB2tAjPngVozXPbCW9Ig+BX2?=
 =?us-ascii?Q?B3uWt4BK2Gm5jdD1oOuW1rvlvslWsc4xr/sJ/YE3cd3gchnVoE2Y/qKMzedk?=
 =?us-ascii?Q?5a3wrfw063VdB6eW76qgIT9cEaVUod++as+q5KLpRJ/qbJ+hZ96JLo6NihNp?=
 =?us-ascii?Q?QFePYp9DSMJvUnsmbiOkp6AFVxSslDP0x1W4Ga+lkSfRymrSDk48eAfS0oQO?=
 =?us-ascii?Q?2iteirKikZTeNWcUr1B/hlJiz5G0VyTPpBWmg2pSRRCIUFi2hINnEzCkm2ZR?=
 =?us-ascii?Q?cA+9+S3jkoR34NiVwQHPyKSYnrj6v4yKoG2YQs8iZpvULBJWJwKsv1WjoaTZ?=
 =?us-ascii?Q?qKGsm1V5nPA7L7WN23dRdPxz65L45ds7w/TH4vjq0vqqfa3QO7LeAY57XdlU?=
 =?us-ascii?Q?EgCj8t6ZSOVZ9n0bwFLueBmWOnRvnbF+fk0E4q6MntZiuIrAU4R2e1+M92OT?=
 =?us-ascii?Q?mUj6aWg4gsiPVLIb9Lrm9VrI=3D?=
X-Microsoft-Antispam-Message-Info: QRjRgLyDyNogZscfGKSvTq5cgfi6MTzNbixxoIoiwbfqs6vBqOYzhzoLF+sRshhAUrmSnH2ZsLyVr0cBPqWMqpbuXNCFTrysnD/cKJEYK9lLo+txppTFuh/vNa9eV9lnKiVC1wNajTZfvRp/QjIn3D/iDDgcNfyVMOiHXjC/tIfhSCkG/sLrneo+amOg5MCcJMgwA6Ma5j/VwMje0x1nh26CcyOhcQXrJvqVYRt85nbhlHrhkMJMd1KwNd8CzhyYA1deG8tTV/jkC0Mi7oZ0WzSpaI+Lncr3z1y3GzcwAJMK346rMnpmfpGobSM6g81XfFSC4bzPgpayc/q/GGmfpGtuePdwDTkKVMYB8i5uLJU=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:tFIP6pNzrC66f9wfvF8C9VyvuPiSKznzrGxXoe9mpLLp7p7WS+adbjB6iEBMDgaisiiHHrt0UVK62jptAD+kJQiEdymlCWr0vHQx3ZNsr5AP9bbJtDJV0Lasj6blnJDwb1GDXP7Ws5eJj7t8mFQFurzPp8c+Po9T8UVmsWVeD0+x3glZqPQ/kaJlkn8PcSK3zy5iNMa7EVCbXROc98s9ev2Ii12BYEFuKkS5IqmhjApxeWB559kBLVwsJJMASo21sPkvvR+jeic5YvzPonBEzxyNESsLLTDnXjXghUNuiH4EBCW3bCjl/yD3152E8PqwKQwX2c+PzWyR7jp7zOostyCAQN7AXqojTkIzBgtJJduL0Y81+dHceW+6IXFqUjxwOSQfHojnI3k6fZU5uLZPHKaWGQmyzSmIFqfu3J+tlutFlgUMru2jpl13BEBYh7bXq4JU1dZxLDataouyCby0jg==;5:fWflZePT5PMKtwD0zR9VYby3F+mZhQvNApqebSCi63wolBYr5WjaAWLb+TQENTnNZRCReNmpQpPXWMno1sCzl0tWy+ceb/watYxhaTENpMUawSclihWOF8ZeQEz0vbH232Ef3ndQeqRnLqD53oXaOlvSwNVza6f5W3UZxGwdnWQ=;7:VJfCUPk0V63r+CDNLvIth0TeY9mB0nlrQh7R8SCF4bRiQRl3EtQ+snUbJYU2zDolrPhveiyMsUJ34BXAVyVmt0oP89EluTFBxSeV59FIJ/jgZ0sUv4Uic+trCenRZtGqPLwibNrOon5xvU6irumLZ6eC5EnqWs3jvfHgt/L1J5gzHa6hhS8Tm8nWsDW2RtsLBh3IfMBApFICVQ7lY2n88uapIWojy6amID2DLXVhrrbbjvl0WZEfrLhbF6xcCDf+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:49:30.4811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbbc5cd-88f5-4ce2-5cc9-08d60ccb8d73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atmel hlcdc controller has nothing to do with these pins, so move
them to where they belong.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index fbc796125c56..2eb0f947ab86 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -34,7 +34,7 @@
 							 AT91_PINCTRL_PULL_UP_DEGLITCH>;
 					};
 
-					pinctrl_lcd_prlud0: lcd_prlud0 {
+					pinctrl_lvds_prlud0: lvds_prlud0 {
 						atmel,pins =
 							<AT91_PIOA 21
 							 AT91_PERIPH_GPIO
@@ -42,7 +42,7 @@
 							  AT91_PINCTRL_OUTPUT_VAL(0))>;
 					};
 
-					pinctrl_lcd_hipow0: lcd_hipow0 {
+					pinctrl_lvds_hipow0: lvds_hipow0 {
 						atmel,pins =
 							<AT91_PIOA 23
 							 AT91_PERIPH_GPIO
@@ -119,6 +119,9 @@
 	lvds-encoder {
 		compatible = "ti,ds90c185", "lvds-encoder";
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lvds_prlud0 &pinctrl_lvds_hipow0>;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -197,10 +200,7 @@
 
 	hlcdc-display-controller {
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd_base
-			     &pinctrl_lcd_rgb565
-			     &pinctrl_lcd_prlud0
-			     &pinctrl_lcd_hipow0>;
+		pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
 
 		port@0 {
 			hlcdc_output: endpoint {
-- 
2.11.0

