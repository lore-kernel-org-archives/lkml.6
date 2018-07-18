Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F67ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7540E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iC9rywJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7540E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeGRHgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:36:12 -0400
Received: from mail-db5eur01on0060.outbound.protection.outlook.com ([104.47.2.60]:11232
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbeGRHgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2JlQLy+mnsBfXZno4oFAzbjvoU2VHo8T4SzS2qsw5U=;
 b=iC9rywJdXQmj6I18n1yF+280LcGsR+ChPaErkrOyVFNQycqKhJtHbqTtEFkmtOw7LjjvJLvX+vjjrt4Oc4d0htMsO87cCGK68DfVeHnVOOcWFTh6vt2vFPLQ4qmR2klzJfxh8eI6qFRQr0WSnpBiqg5UYH357RWF9LqSA+Th9is=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1328.eurprd04.prod.outlook.com (2a01:111:e400:5188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Wed, 18 Jul
 2018 06:59:35 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
Date:   Wed, 18 Jul 2018 14:54:49 +0800
Message-Id: <1531896889-21377-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:203:72::34) To VI1PR04MB1328.eurprd04.prod.outlook.com
 (2a01:111:e400:5188::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e360ccc-f96e-4dc6-71ae-08d5ec7c0a19
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1328;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1328;3:ZZkO6Tz3WiDGPpzFdw2vw1SiFJpuRVG+T824+Rv2Man/YJLiEE95C0eWcNKbIXaLdpAbIev5oQPfNYzq4HjpK7VqDaFoNiXjEYBq1LMeCawRqUx/99w5H23QFwNbCwjSwnCPkWY6VeeWHSWJ/KFY5z6OsZFaMk8QR0H466J5uHVZaJ1IGPW38II4/njQ54CUfq5vSaNvVQl5AlGE0jsGQTO1d7vXMEPHPmL8+yMLGbXVZ2InXcclzx3CiPCIR+m1;25:ThosFuxkQnmbCOC74Hcrz/5MGKL7Rb1GXJvQSQUfiYqUfRG/bdbMcOvt7vfq2xnbETExDgVnEnbO4mAlVvTe/g/4wRNtdyoJ5hX7aG/VIceBam2dfQKp5Ek+rlOrqLy5hSOs8br0DBKcblUdGfm448M1z500UXWkk4JdRNhESFQYzUH/9WN38NZGo9evgY48PRIW5pG+XUs8pHY5kMoCd6k6jQjsR4xnFjna9Rqr29kZMk0kGdsApb/FQnfRu9ayhqWeFGNoXG8Wfgx3pi2jiowFEDFt7CVzv6Ywx00HLKbRisB4O8csntylmQpL/haALHnA2JQAA6Wi4G8KPQGTfA==;31:qD3mwXEUhM1qR3QAFE96KVnMMc+FtE9UalCwlWvCbmizpXjv6IDdN62mk0Md/RHkbCKgsQxC+aSp0k0q7BkTPJRXGy6jt4p57mtRu3AD6IgxjezCKWTvA8P745k0SUCZjKVCAOxo6rTYOmlZm2v8ga6PoYlbE55/k1VnVHfk1LJvTn/ShWtBkusILZgW+h2xxUusVOT9jSYLfrLOLBgToEtCZG686/oC4bUu7Oxqk5c=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1328:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1328;20:Ih3X1DcOIBIX2AbRgLUONDpKJZkse2WmsKivWuGwA2gzxHnfTN5f2qkFMpvzjb7RwySkizr/g8VBH5CJYFNXMZ84H54XOl4hJLJw5jK7guPhd3VY10Tia0HHtHfFM/IuJTLIdnTtTYtESkCdfHKlIh0ZTHDrsXaV7hYfhktfLIpYNLRnjk+qtMvMuH1T6Qrktah+P+lX0z4IHDrQhk9b86Q6Vs8N+3k6lFujxojlxgI9vOBkQcIebhVoYhF6/ueNEcBxWQcKxU08zfPg2g+zIYIaPqj1BM2YPFi06CtuAl6iNTdXDF2pI7X64lvBD7+wmeIbftATaPFDmDJH2jZJKoIubYFgVXrp1+jsQSPf6BbO+WevWJgPiGAhqLRqknZNxcstH67tdGzFIYzpuPWpEfgM6utNjPVsMbeF2Cf0BxXDq5FAkzB03d4cNUCnZqjLAp97I/WDaJiPWy/7gM5zgPtJ0O+fvurmZzqBQoXRz720yfB3OJ2JnF330Oi69Ktk;4:0hYniOrOo4vgJRanWnDJw8gkhs9U6IGcVedLdZ89NZ8k27wzWn6y7C/XI7K4JQG5sbeTFQJVNuYbWkWoGw5WFeQYXgcQYXr37QaVtqPMXgmxVH+3K4G6qYN1Wb8jqVLPmjuXGrrJFYp86MSbl+eDb/LHK1POLC4fZ/Xu4A9j91cdYBWpKOjeMUpZmu7KSK8kYlB+LWc3Zk0y6z99j8Lw1rhOtKd/C8M5ryJQ4AJWA7QBU+85vxmkf0us/VrWzr67o5CVOOXrPOfl/2gUIrZNaY418LYOdKO35Feo70Gtqor0zpl5ehxslWA2eZY2af+D
X-Microsoft-Antispam-PRVS: <VI1PR04MB1328973BF86AAA73F9DC8A4BF5530@VI1PR04MB1328.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1328;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1328;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(106356001)(478600001)(48376002)(105586002)(50466002)(25786009)(36756003)(97736004)(6486002)(6512007)(6506007)(50226002)(6116002)(4326008)(47776003)(386003)(53936002)(3846002)(2616005)(316002)(66066001)(486006)(956004)(476003)(6666003)(305945005)(86362001)(8936002)(7736002)(81156014)(81166006)(26005)(8676002)(1857600001)(186003)(51416003)(5660300001)(16586007)(52116002)(68736007)(2906002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1328;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1328;23:zAOMRGJ5aj6y2483hdYb3q7KjUKmcNXfC4uwcse+F?=
 =?us-ascii?Q?jk2k14YKlUWMfvH3R/MxiNSo+pGjijvzuCaalfvXNiCyy3DtfmJlVKPaZAfZ?=
 =?us-ascii?Q?n2fMuxq7CnTn+C8VILkrvGBzngn6zQ8w7x8QhrWBRG+QU0myroLZs+xGfVR7?=
 =?us-ascii?Q?cd1RCfSOsQ6lJfxjDU6Ub233lGL7HBvQxlnsTsUjXrYxxIaSvmzeKWKieLxZ?=
 =?us-ascii?Q?Hb6dkZJGhBNcVnUz+NPZfya99xpMH7l5OJxwY2ix3QvUGfzZOPgcq8MfuhNP?=
 =?us-ascii?Q?v3gAadHBbTlxLsIQHut/jNLk4bDP7+CBcVAcqYo3X9G3ifHYFAR0sk1J924b?=
 =?us-ascii?Q?YEiixQJCYZ55EExG1jB/sO+rjP64vongcF39/43fLIoBeQyV0ZhovYzeTkoC?=
 =?us-ascii?Q?0xn0dwUfUV9CrQgpfx+FT9/qCfMJyAxkUJLFHljEjeqmv4I94hlA1IEA87cq?=
 =?us-ascii?Q?F+NQgNmjUxTdvuRkBlS6K051Wx9Esntq070iNti3/L4Bnly4MovyDdowh2pj?=
 =?us-ascii?Q?4yDQexOGf03fwsnagVElif9MDvEK+z+/ElG79TKVF+ukf3LmDM9sO+6TTkhC?=
 =?us-ascii?Q?vF/32DaFUKq2a5GylQxcBYz6e5MXrYvMuLcFN7rp3XvXzlsRtvEjD0P1IKmM?=
 =?us-ascii?Q?VM/6p9X7jrqw8yiTM1zNfnU/JTW83Cs7n+HIw/KpyWMuRw+08xz+i3RsIfsO?=
 =?us-ascii?Q?AApjEYQLFNkpwV01SmJGVobZVz3ShCt+4COTVfeknggj3oKT3PdQZqJEIgft?=
 =?us-ascii?Q?SxvhqmHrSIpRHQMVTwbsIkhiOnSgPqzmA5xfcinBkggyNp0KGlT0pZYpFkQJ?=
 =?us-ascii?Q?c6lM15KnTf5Y/T6j31/ESsjy1c3qbLdFIaHuuijB/nVpMSachofWz1j7Tl3p?=
 =?us-ascii?Q?6GmgxQvXcWWudukQI753QTxbaTgMt9MK9eFep0s2cJFoO4/GZ+tMm5WC7m4I?=
 =?us-ascii?Q?d0fb0C4lp7fwRlRYn8XK7u/cIofEQ6VjIP3jLrnTjJTcsoAIr4iN4lEYQj4j?=
 =?us-ascii?Q?kUjzeTuzb0h4UyLfrxNL1igO/BJIbIp0XcJoD1U0VFeiegGr8fZKW/IGOQVG?=
 =?us-ascii?Q?0tTZntwPPdJZZvaSPhbQEzT5e7oydv32qIHk76kPhPWK1g9V6ruRs8qMjlqB?=
 =?us-ascii?Q?sEx5XE/Gf8=3D?=
X-Microsoft-Antispam-Message-Info: 5rsa+8vw/5EFBBLl7a6si4aKxa5BHuZm5oE/7OklVTTT8z1teUU7cs1rDbHvZcWvypZM0xLTri3aqwO9JIJ9/BQAFitHB+FjUbXNdwPf/SmyPSfRyF1sGEJ/h5K5LO6IUDB7kna483faunf+M0QueUUoGG9Fp0zmQ+n353Dt/weZmfxXWojN8fRHK5IlfHKcmJzuJAs2GRcpVavO6oRdT0ZGI9z3G4WRI4pD0t6pvKCxvO/0DISK88Y4zTWb0t9j1lJT2FU2hKzOR9AWJFjoe/g9svgGiIZtDTDt17pKTBqn5KsjkuIO9hymSTs7nIj6LSDvO0KKckDCu7oyaSe7qXYY0EL1ieURfiz3sUisiFA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1328;6:HTHuruTjG8aiIeVyBqTMSSOtwutnfq1wCSmPZ4Z3QA5absUFmwNbVndKTb9ee/V3KSTSGGkaBK3cs1VXkvPdYavpXfY0zdguLubp9vAWJkVxhhr0yMrFoR3guh8n6tlKUUVOSDVJ6wGYhRvHK9HCL0h+hC1/eVGmxbFQ9TijPtl+WGLxCW4rXNdiS/B7GeYv/pqnntWwR3Ra3ZL4Wij9LPz/uXAGwchrfOxALvKfgPAkxfYxfPz3E3UCtu6WoT3cHH2REQmf9X9HqXNHCPYi5m+6l8xiGRJNk6elte1BjrQSAnfmfqYeBZnxve8fII18sDPepbtUr+D7M9HimErSN5+0oruX5PnPhjC19PSuHbnbK37nM4IAKj8kkjSDIzYhJZ+NVfR7d8KUF02HDgoiO7sSmg6fJG9nYg5bPf1M7kiXPlvsoK0z4/G9OG1GXnDXonO9VBEVkLlarP+WZfw3eQ==;5:6eBCTln65lrseLQkDkHmOs6VfRJIgxaplofhHz+IR7Z0YjpwIhPpVaDUKUKAeUpgTATR96cFtxMvJhPb1gS5iQA2m3X9DJh4RXgtlnprvKyJw141IdvQpxQri6ro9PL22Rwn2Ih9HgwfNF8BEu9CuhKVQ1INJOVbx2Ny98r7Y0c=;24:ILYvYvK2AIgB2RqraUIces8cNrTln5cFbMvzoxtpEFJnVjGpkKehNaryQZgZiCNxMZ1eGeKj3gKZqTTJHXCgz+8xudpi4LrEP3umIQAbdZo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1328;7:7ykkbs3r46PdAUhyEZEi2UPTNdmuWXej/yin0SkkwJT2afn40akGjqUwHBO/ePh1a6uqYpjiv2dsIRsUXKyLRUfUa7K8Chtwn+5ddG1B7lMVXlMkJ6+UxI496pxsG71HT9k9PrMuMauOfKKSI/Y3QyanDR5FALo7EnWQhfBH5k+hyVPIrXIUlPuqXSpZJy3wD4DX8iOF63KnWUe7Ye2wUuVYN33yuJAxmj3q80CBJodKNUjFDVcaXwq9VhdPGLqC
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 06:59:35.1807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e360ccc-f96e-4dc6-71ae-08d5ec7c0a19
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
added "operating-points" property for all CPUs, but missed i.MX7D's cpu0,
this patch adds it.

Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 9a772fc..30a1a73 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -9,6 +9,11 @@
 / {
 	cpus {
 		cpu0: cpu@0 {
+			operating-points = <
+				/* KHz	uV */
+				996000	1075000
+				792000	975000
+			>;
 			clock-frequency = <996000000>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>;
-- 
2.7.4

