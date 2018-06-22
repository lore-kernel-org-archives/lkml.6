Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEF9C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FEF23DD2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K0V1VbrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FEF23DD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeFVGhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:37:04 -0400
Received: from mail-db5eur01on0080.outbound.protection.outlook.com ([104.47.2.80]:27168
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeFVGg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g4qNHOUOKTf4B7CAKSyXlheK2hH4w/Mt7uLON/XdLM=;
 b=K0V1VbrFmSObGBb7yLS1Nov572FOgpte98re0NwuijWis9R/9SzFqH+ZN/e5VEFt/25ycjZ9emC2ur8MgtgiP8fnPAIfACtFBVmh2/Re50cLa20OnGATndqgEcQzZBj+hu4Jakkcrndn5glzIkj9XeHV55qcd96WnDSYkPyTv6w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB1321.eurprd04.prod.outlook.com (2a01:111:e400:5889::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Fri, 22 Jun
 2018 06:36:48 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, aisheng.dong@nxp.com,
        ping.bai@nxp.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
Date:   Fri, 22 Jun 2018 14:32:34 +0800
Message-Id: <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:36::24) To HE1PR04MB1321.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f40325-7b1f-454c-1583-08d5d80a8ae5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1321;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;3:oEf1ePvVWw0Fp9ZsmREQxiQwS6fQupHs3QaxmBZRfJhRqguYguiGy52U1fqyZgpMP1ea1z8Rr4spcm7wewuLa7GR144XjJ5F9SARvERRKF/F9MgOFRLOxiwoka2S5Xpa/KZ6QkfWVdC7sfsaC/u9jID0GfY9d7c/GFn1YWwfBakgBMTAtI4YpVwaOVWR2t4QFQlDu+XEwwGyn0O6Devyz3zUxXmNuSBxK4bVFr/1HnSqprV3z97jYnlK9tho57x+;25:cXgJnv12I6YQQJggdUAkzu11v2xa4A2JYoUgjcwqw2BCZ4m1DH4KPn2JHf5vPXbXIJHjNrqv/YEkk/6TfvNPAZPzr9mS9RgmwG8SmOhM16QJv0hwv8Y3wcdjiwW25+aIA6z7/aQkIX7hHZvc3bEWssFCEy6XeHCR1smk9ZVz7JdywqB9AOcqbxcqR6FQ3LZv6BakaNB9jFCWQgeOKIIvRtM1KAzeNhT5/HFjaWtYpuHD3pCizo2PiiaFgCp8lcpGc5R6qfZYQkR8WsLBFxgZOFJBe/eWm6Djz905erGwyp0rNPhCy4I15kHpvYEbHL1fbIrWVqV1FPCanmEghpK69A==;31:zRmKFqjp0biRskz9S6fq04kOYjmVpCMGrt6NQGn1h9xr7w3B310w4sJmSqYUTqA6s6IN8Ynmu/NEFzxGBG7jdc33dxF5Jb+ta29S4kjAvNi/ZtCZQosbFda4h38ySMzaTOuNOMDl0zCnAIeu5IYskbansTMc8ZoqjeLqOkZzpxiHr8Pd2REm8yEMua6l5oeRMtp3voJKYEv7pocmn5/kk1fTpSZ5rX2yfGHClRRppa0=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1321:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;20:6azLvzbLkaL5piXgB3r3VNiyyXjU8k+qjY/Sy+JEt+rMkxorTZ6furt1Bd6wXDUEthGNlCrNqTHp2WbzuYFHPI//ujWnK/cRKeWp4Qwcv+g00oaP4jg/r3lxHHs4I+H6vA5Xktz5hMp7iwVIBKDjcCjAC+2DeoBKfpU5nE6ttKq+POLjyOjNX0EP+E8kZz7R1aNgz4P3P2HjrjlJ4jaOcpzDWIDwqo/4QdrKWKhLIBfajEAy+4UQkTtOm4oHnKp56sizPb9/XgW04AcgzTIdk9i8pxRqlVfQuMmX00qHgokN6U3bURf/bMQNnban4t9WmIoK1tbfN2VNhSvXdWV0Gu4XF/EN3oPbuC/cTFABAWB9hHIJlLusbS5Gg4KDq7hlKlAFZLIyCfQDLgVpkGhAZ4MoyWvQl9bRkP7XxKBqKxMbU+8cj+HEgA9pF/fN6KvAZqCR5LjrWdmuwlcs/U/8N3u8Sstot8ffEftBLLOMxQDMv2BeLKHW8qbomRNIOL2f;4:nuspssdrN3OdxEa7Uj/IRzzsRDmCjbDZnLCw6bLWzcV5xLujgm585XXq7zj0P9FRY4iOt4jrbvT98Zj2SoHGvDRYS4M5IxBBLDHwbP9P4GoSoxSeJ9VZbKj7NBTPGhT1Npss/Den82spvVnhU1cEkYJCplo6rsKH8VyTVir1a8a3xvKBMFU4NWSx64O2dGdZFIFoTh5Xlacbu96NOUQWGdzIHdFfrahe8y7uClJPiXHgSGC+02hYArDJvpLIJ6JVyzlghmzqJj6FbK/CMeMuY8M8kGQq0kox3HEGcMxz6SIZYMP0Eqc74s1TKSUI3cO8
X-Microsoft-Antispam-PRVS: <HE1PR04MB13218A52BC66ABCB8CB5E016F5750@HE1PR04MB1321.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1321;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1321;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(16586007)(50466002)(97736004)(956004)(11346002)(2616005)(8936002)(476003)(6666003)(2906002)(76176011)(6636002)(6486002)(48376002)(478600001)(50226002)(316002)(446003)(486006)(305945005)(186003)(5660300001)(7416002)(106356001)(6506007)(52116002)(7736002)(4326008)(25786009)(386003)(36756003)(86362001)(53936002)(575784001)(47776003)(81156014)(6512007)(3846002)(8676002)(6116002)(81166006)(68736007)(26005)(66066001)(105586002)(16526019)(51416003)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1321;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1321;23:i/tggfg7cjgV1c0n7AwO90MM4pQYva7w2HsnnkOAc?=
 =?us-ascii?Q?WZU/tgNX9tPbjVa9AzfKAMWYihwhXRPjqRiJWNkCTrzxSHgf0bqKKQJ4g9xc?=
 =?us-ascii?Q?s+HKk1H8SmV04oWSJNf05gRCbu39Jf/O80/NEwnVVpvNdlfHOKH2X9lgIeza?=
 =?us-ascii?Q?8WVvq4nEBiGImk9E8G+0k3UgkIdljFGU4wVoK8IO1h6E7HhuCqrCXypW2R6+?=
 =?us-ascii?Q?5bjwgXueCZJV7a62M0hWmLyUynCkmkSBuGerSdnIyvCqbTnLy7DJXPe7JMOs?=
 =?us-ascii?Q?j+AenyaoPf2+UYXwHowDWGdTro6rE9JsV72qOG0XwcttGMRPZZ59qmGXeew/?=
 =?us-ascii?Q?Zc5Mhsza5XE9mlFHrtW/k9RNJ586UapiECyPTjP7fCUbkQQH8aJBpYrNHZCi?=
 =?us-ascii?Q?Ti3+duvmJfWFZfKSW7OIezHUjkPDPvl1IKDHKRBXk4nBNyU3FQ3woerzcXIL?=
 =?us-ascii?Q?4qgcQxaDk0xiUutkmYM1DTXh2A9V3NB/Anf99TtKCF4X4sXyqvgqVSwrZR8I?=
 =?us-ascii?Q?cGkZ0IokY/QLeIABwpb5wkSopa6U3Um0VKNSy3rG0IyXoDHRfcjbJssAqNC3?=
 =?us-ascii?Q?obU7ydBBERi0Q8wfcjPfUdItLKaWWJmPkolgzNQKGQXo/6v20tFd8IdlfuIw?=
 =?us-ascii?Q?qQHXgZ4wVjr28QPAOLrOpypb8GWDBz1ZCbui9TGPfs91FCsF8HHv3x0tv9dS?=
 =?us-ascii?Q?u3Qiti5Y9Gshgh/JnK7RYMqNmhIg9xZvO989F6BDfCGUqUTLEK7Dhr2fL4Xj?=
 =?us-ascii?Q?52V2BaAwB6ZVQ80Nket6nFOPLFC9YuBkjDm7BXqOGxx1lhl0oKDR7Wp10bjm?=
 =?us-ascii?Q?XE2AS8iR8DgCt49s0GDuQXTxkbDfZgPocXZ+pnnyP0OwqW47LzBQV/WVwnxH?=
 =?us-ascii?Q?IEbi7bPc5ztGfO6CXFJmBQjUG61s3OMKujYu4T9ERJKgU7LpPw4940S3eGtw?=
 =?us-ascii?Q?KUMinUJVqTLDKGP7ac1+vYghPBBdHt96PP4heiuTgs8LXNsh+GDteLe035O2?=
 =?us-ascii?Q?u9yInqj1yFCI41uYf8aOMe3d9fk9Hd6RFuafO6rO+9ThlqT7+JgwyXSorH4j?=
 =?us-ascii?Q?r1MCv1iB/eGwqj8nxeChfCmPaah4LoK1AES71QI3YitldKMkErscSdSBAwU9?=
 =?us-ascii?Q?c5xw2rI3hmxFSInEL+QswmAzHu66+UhzjCxP2MrZJVPSR6ZwqNWrgV5mg6xX?=
 =?us-ascii?Q?g9pBFnU2KshGtrjuZBtHBN7Rfel9EiLy6ge3Sa/rlYAG3FdrFX2tk2kVNuja?=
 =?us-ascii?Q?F3AwUVBrhJoMkJ9/wgoCEA3x2qj39FdLlHRANtI?=
X-Microsoft-Antispam-Message-Info: GVnrmVjpnS362rqO/ImRXPq4Jn+xrTtOIm0HKpgbazxEwTVuylmwwtE2UDW23oP53Wlh/Pto8VAZBdAZoOGHQjczT89hKwIJzPr8o1ctvqXM8FyGChjosSMXQwaqUCMZhjOXZsyLqjcAp1nlErMsD+j1JUWDW1kkftT1SUQ1kS5qaGBjzpNQ6EHgEy9UcAgB3oBeE9j53pugH+Vp/SdVihzFO3UJriNMa9xJWSKP5sSvTkX6PuH75fh+1ADSFqVIy0eCwdiUGw/vvN30HqaHFSRS9tZfehS9pcaZOSdG750laiSOtGqhwpMiJwpIZ0uD
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;6:OG1CTSxx9J8YL+DJMCs7tnlXGQ9EzleW9S+whDaQ25ns1VOn2Gw3eVsl2O/zUPmnh9vdLviA18XXafVR2IoyY19oPjywTP7bzsGxYfdEAqWBldpUkedvj9Sb/G1sIo2Aau7uhV2fk6IYpUSQaicpp37u2g/y4bzvlv1BxI05zf9qrZ/nTk0EE8vNfFq0gxZlRJz9cfiBBekXEEqrGD/JxOdr7zljnf+u2iDhLj6JvMaJFS74bjBtCANOCW1knG6npf57JiTcidbDW+LJv4xGoVIkY8N5gNNjAdgrf0zMW4QanpREPnHnFXxFcE+lFDqp8U/zXaWd5X6mj8Mjppagw7NZTjJYzszPF0jGTrpahmCOIu27bnuUsmB5pMpu0poq8CfzbHZRC/FPR6evdjLqC+nUWQSqPUwTv4l5mGTmPgNGan8YQk0jG0Lq4q/iAQgCI5BRqIlpbY3IXaf3symubg==;5:x604MtDCk4Z/RlG2UhXwHxwm4N/j9LaLxqbGJbnf2bSYi1iHV2N1Tj9+jkb3zgPPekueuSLdl8LmDcN9riXfw9VUZe6Ffyo71Mv7TNTgheqMwQpy4ptNs6iAhC9HKGsKMIMneZG+ss9nX6egJ9CTMdoUTm5oTW57Vaw6ZrvTBDc=;24:t9IcnjiTbnDeJOSIs49xoPy5W0UHN+ZvhZtkUeWwvJZ/W08kIYf4Qo7YQeWK4+p7bxodrsW+amZT43C+D6kyrG7bLKqWUtBs7NWjjw+6InA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;7:GTJyazgV1Dqw1mbZkYoyxXLiv2XMzvC/586SWetKwxeobfQaU6srTlnGIEeG6uVx77RxfLP02R7m8uj+60i71ndjYp2wCR8YubtKAewo3qPdtCMo/MfqCQgxlHCsiU1tCqnIxCDQNiF2bvxMfbgHcqwX+EM+CJSCNIl4zYNkaYUhkKbbIdFci7KwrmRDpI0GQS/dgYvtUIEzIlDX//t/Qi3ou8Bfz+mDgukd2vTZW9MuvD9RTqNhZh92lHpl/9G6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 06:36:48.3799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f40325-7b1f-454c-1583-08d5d80a8ae5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL has GPIO clock gates in CCM CCGR, add
clock property for GPIO driver to make sure all
GPIO banks work as expected.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index c9b0ccc..116f561 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -375,6 +375,7 @@
 				reg = <0x0209c000 0x4000>;
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO1>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -386,6 +387,7 @@
 				reg = <0x020a0000 0x4000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO2>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -397,6 +399,7 @@
 				reg = <0x020a4000 0x4000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO3>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -408,6 +411,7 @@
 				reg = <0x020a8000 0x4000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO4>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -419,6 +423,7 @@
 				reg = <0x020ac000 0x4000>;
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO5>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -430,6 +435,7 @@
 				reg = <0x020b0000 0x4000>;
 				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO6>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-- 
2.7.4

