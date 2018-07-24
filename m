Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06020880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PTsfa6Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD06020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbeGXRWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:22:33 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:43936
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388322AbeGXRWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCE/pgSGqwU/Pz6lPxMsePMHQhWoyjIZoicl5Xr2+eo=;
 b=PTsfa6Ieory4NCpASZ9w1UvieEgdBQlImkMj07mJnruYOGUU9+6JpbthfjyTPIw3OTH2U9MOu3PHe1w2w2083IrtPk9aW0D6giZKDqHitPL5Qsz2FHw5DAvL/fklyS1t0IAAuSrAIW710iqSk862NG19nTnlpSvO0tNyZ0fsF7k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 16:15:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
Date:   Tue, 24 Jul 2018 19:14:19 +0300
Message-Id: <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1532448745.git.leonard.crestez@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:207:3::15) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9eefc66-7544-43b7-8e1e-08d5f180a2de
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:NM5Oun9ur76Ejl92/Bl0xl7RzsyMMhUqfBg1cz1fxXIUgphBufxFWMMhOXaizKJZq0ELoVcG4Acb15kx6rpMj28l6+yBxFICOXC2/C4PQRmvWkHuEjqUXRqe+Lqr6xJwM+pRTgzoRqZuk2U24qim7oxiJdL0jyyWJ7EM6bDSOOPcb+X0u677F3SSmc8zykpbORH4Nx1eSwkaF1rb23+iy9myiCnp/HHtuldOJAFI7Ud6m802hdEat+sSl+ikSPRp;25:rBeZ8zW3GL+Xi9b5jO4bfG8oa2W4SqAPJQF7f54hv5Zx5GCSyTXvC3I34yZb0t52GkRA/P+J3HrSA79VqDLGaabIGfOzBlyHvIOjdW2F4I4uqd4Rb4e3zVC/54444GqFzQuGgjupFSIxyE6FOr7M2fgcTvWJkLzl5sF+cdei2E4ZvUhXLAb3m9YlZtmVXQNf5vFUmTgPDkyOS7Jgfsd7Pj1+vLgEa08qYRU+CsnBBCo+RMWikp/W3X7n2NbSea+a5laC/UOJPeYoECkpEQ9gXCqV3grUfPwCGlPI/sy67FDMOIUCwJERFlprdRG3lfQ7tKyEKfo6jaR0itTccC1VyA==;31:s/Np+tNq1zWzEacFcFRkHRMbnl1NC+tqxD/VjHyal3Fq99hF4/0DjI2+3oL29vAwkxv/gqMELb1XzUTgNb//LpCBmGancE0w7dSgiIWCcpFVgvPoAlb5GUp0POKNo3pFu4E+gj42rsfF2dh49EVVe1ARGt11dyIWt/t2u8OOkWTs3tGnujXf9czmibYyJ2P0zAaWJh247t3c+jpe50yEqwnldYBtcfR6WVg9jZRx8EA=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:cpfq7w9kxwjjl0PmStyb6IKVLpbmwOHruCxan9eyw1s1zKin6eVrAdsQlPxxqL4oGBoMi/Hg7bG7aCRDvHTcV4TbUzqSwqUdRiqvlTD96pC6RCrfOFAZlKKeuKeBspftpCjQQ/LS/8WNFavmlKhYD3Zrz4mROXzfN9Xdl9tp/z2xHWrDEe77cDwwzO+3XQeQm3afcYUF2cy7GnZ2Z7sl/Q6ZRKxy+MXY501ZzQ99u2gKsaV74qc+aVhrpUca9BYkotHV2g5wc1u/DaWGJjErgyHcsre0qYzCvJbF5Npn8mRAN5EDsX6LjlfPayARMxpC7EJ8tvDGZRZbtlqo2gSrOgxoVIcPx/Oe4oZkl5poRBsCoBZjvudRKUj813WTIWa30wXAPFZVsbit6rKKCItbvMO91ygdaCFnAbiTos+yzSAkfrvCs/432nPz7YmUFcRMAeHn3YygqMxPosBHXSWAcSpxR6cPymA8BRhvTNfbiB01uFp7dZDhUaOTkeNzuhmb;4:edhAZIc22NG7ID5suzN9MN/51elfOMIqZviZN2wb+yJcOFzluCptcXFmHybt5EPA5OnDvzakIW9A2C0fL9pXUG8marbywzt6ogp25BDloaEJEEVXuh2mMfb/mVrmpd7QVB4f0vSRaPCeRieE/9ii/PO1oHoKedTKRDPWcN27Z4H8ffeM0bIh4RuXkYscsE4Rk2vgPsY8iF5WhHrkC4Jy8ThSB0ysO9+H6SgKMCuph+ulQgd013yyRz1cyJBeLwYJhzE+lZx2EW8dwbk75syhhsW3Vv06O94fVvOnqwkjP9b2W7wssFPeBl0DaXi4VWSM
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290681542519AF896D2F3C3EE550@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(366004)(39860400002)(346002)(136003)(189003)(199004)(446003)(44832011)(86362001)(11346002)(54906003)(81156014)(50226002)(47776003)(97736004)(81166006)(2906002)(110136005)(8676002)(575784001)(316002)(16586007)(4326008)(16526019)(8936002)(25786009)(305945005)(486006)(66066001)(39060400002)(2616005)(186003)(6506007)(386003)(6116002)(3846002)(7416002)(118296001)(68736007)(53936002)(76176011)(476003)(7736002)(26005)(52116002)(6512007)(51416003)(106356001)(36756003)(5660300001)(105586002)(50466002)(956004)(6486002)(478600001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:JcBarzoiXm/YPZTwMziMe6Ud5L7lAcKeradXIBXO6?=
 =?us-ascii?Q?G+PZCfGkhhRsXugtnCz44OTInw+qN2KwwvjedZjlz7X6rHD/aMAfFAEguzd0?=
 =?us-ascii?Q?iOm2Qqk5iLFNKJnkHFJHG+j+UWU2ZB2jABnYAOqYUMGu9YJSZJeoJNgxTiva?=
 =?us-ascii?Q?e9J+BGIs5WMPViWKMFfBCaLgJnjANMYdBhBNTzyi2X2QQwZntdQWsPxOsWwA?=
 =?us-ascii?Q?wGoGqD3VAVLUnz/IOGXg/rzT/Ke9euIYJWYt3Dh1NTRtfktJQ1H6otIC3lPA?=
 =?us-ascii?Q?BtV6QUeg0RIc/wX+F1nJHT1WphUCGkMKNPkMKSgz37V5giiU58/sSL/1yCAC?=
 =?us-ascii?Q?m4YbMxak0fDLfjpVj5vs3nc0eWD0CJn1Hsj1fzZBlB35cf1qUnXz0+3/aYab?=
 =?us-ascii?Q?f8zX2GPZYUuLL7hrdyfL4a/u5MmNLKnRKwxnJ4grl8UBMsgHN1uQQxfweEMF?=
 =?us-ascii?Q?htL5qtrKmY6aevqGqc2w3emANDz1oyeXLle4ixR2lduyAaILK4y3mWGgKdwA?=
 =?us-ascii?Q?fyY0b4XIqf0P8jrmjWilpjr3YL8HiCQVVibdzB1as572eTGRNZnfSDg5Zju5?=
 =?us-ascii?Q?sktPKO2OY4kpPayr0uMGkuX90femmh9jyvrCI0Tp7RbPShp4cqlXAnZWCmb0?=
 =?us-ascii?Q?N81DavogZes7RulOoGDe9ysOR2Jbl/u5A7cfnPPwWhgM/NAn2nqRq40/mpZz?=
 =?us-ascii?Q?J9AmhFW4ZjffkRTLNbQFmTJDtToL1auOOhJ0X75jbQGh/yHldK+B6I2RY15G?=
 =?us-ascii?Q?qr/zbq2897zbKRkQOD4z8ex6dck6Z8+N5v5HhwzwD2tjz/1XN8i/pVgSpjdC?=
 =?us-ascii?Q?8kFAnLB8gXP8qhWE13Yb8fHj+eqRpn6iAN/N+8iWSuX0pVSIfck7rr0pxdz1?=
 =?us-ascii?Q?srBLdJuq7Qvhsnwiu+oY8Bhhqr1SoAdqhxQAeWOpIyxqLuAalbMh0EtpIQ/V?=
 =?us-ascii?Q?qKgWJ0I7WpGUHkacOMENk0E7ExmW1tQiKsQpHiZrw4AXDGIjUn5enPxP8Smh?=
 =?us-ascii?Q?qR6BopYAmO+1AKYp+pJLc5oK+OZCk8C01op6X6OUX9clF7IwYR1ZjIpDhHJG?=
 =?us-ascii?Q?uGvnxBK/XLJYk8iaHvlHSgCLvWaRfG8MR/+l7y8xWMkMOlPJOON9KFN6vmE9?=
 =?us-ascii?Q?qsF8G68XQn9OTLccLZ9a8hmjd7sxAeGy7bFXB5cL4je3Tm/v+k90761WsqJc?=
 =?us-ascii?Q?2KGNikeRXXQhESsxMXinR2CK2ipu1y0C+d1KSawhdaKJNCEMYClIuxv99dSL?=
 =?us-ascii?Q?tK2tm72BwY1dPwInHTrrpIme8ilJ2q8ucjDxabD9FceDhulfoCldRrZKx+c/?=
 =?us-ascii?Q?vsFL7apFTJ+f7bQLi5XE6E=3D?=
X-Microsoft-Antispam-Message-Info: mSUxP5FoKQbLwhf0j4Rwq4HFQ79d9p7/KanGkXRy1s7zJxva6yt16sbzNnlurUYliLM+Mpypx9btMjeKdUdZWEZyiNKqPLIpYwinxo/61mWqdeuflOykDu4EK0jGD/3VEEFD849BsMavw+tIlTdD1ce1J+MnZwaOE1hMlwhxpgKsrXvvRHiKr8aI+kCMkhI2Ziwg9hn/aa4Udr4ginL8giYd8LVweSnoQPNK74VrDRbHujV/dS2JLfATtZQkR3DbiElxBpn3sXc5S6d/tLebBzcawZastinKt3FurmzawreDxRZHt07NZsTlkdf5PwEcq4LP0ee62ZTc0sX5e8LTiEGbiYTJQkoyDD43wfDUdYY=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:ot7fYbOFT6iRGIiH6euktvEwZ6DvHAd0gZxRYplO11GTJdAgV4Ed58sqJNPe96Xop53CZnEzIioe3MDeTyH1QVOuM4sDLK1vR0m5DsePDUgVX/dvtiIwhZNV43LOBjtrjKKm9r4I+wAvA/8g9roVbf2IFE/R35LvzZtsuVIuk20m4coswrk3xUGQ0WJMgl7dHMlD67LH+kTpZlxOzY6725cIAMvbWyCS6Z59/8D8E2fNUSHLbgqk06OhYgNPbq/s4YVtKD4DfeaOlVs1f1tQnnEMcQnR/TDGeGNJ36lxJpyEd+Mi/kxDn2s1KB7AaU3/NeuJAdeZGc2ONSlwKRyLZtFDp8A9+wdDQ6Z5Lndu0tvCA9ZRAfKSHP6ueA3Lk0/BH6bxl5NFd7y1YxvIzbzySHw6zC1sZwpcegS22LVcW21LKCNkARpNy7pHI+hpgyCUekYBjR21y8/fCiB8UhuSmQ==;5:/pl3RDnr6lEzTxzH/wuW8HejtrI/AryB3tIwpscu0BY0755MIQFAPtvD9d5Ol1B9MaI2ZAt9Ua/seBSRTxrkodww8CzAt0iYGB+33gSlyQYYURWQZILLdcfuAQd+arwOEY1Mxmy0A822f9CuUU4O05vUfivdIsUnxnsCQ6gYxAk=;7:20mZS+A2XnSKWMponObzHyPzGzxQ+JDpDDSG9lfNb1fQhFe0PZRgBWjRibAwrQ4F0P9LCX1Y1gXfJG008RSj+W15ggshpSni8mIXwviAPLIGpIGG5DQz6GcbT5anQWlnEIpfK/V6vk4bCDfN9AxNKcYatEVpxY6jzOLOqokDmat1y+8y7c97brtPLAqpekQNwMGhcJDoROjm3jx3LNXPVnJ71CEJxNYD9PK3ilE1l7OMSTPXzNRgPfLbqWggcu1G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 16:15:12.5426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eefc66-7544-43b7-8e1e-08d5f180a2de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.

That commit followed the reference manual but unfortunately the imx7d
manual is incorrect.

Tested with ath9k pcie card and confirmed internally.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7cbc2ffa4b3a..7234e8330a57 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -124,14 +124,18 @@
 		num-lanes = <1>;
 		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 2 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 3 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 4 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		/*
+		 * Reference manual lists pci irqs incorrectly
+		 * Real hardware ordering is same as imx6: D+MSI, C, B, A
+		 */
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clks IMX7D_PCIE_CTRL_ROOT_CLK>,
 			 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>,
 			 <&clks IMX7D_PCIE_PHY_ROOT_CLK>;
 		clock-names = "pcie", "pcie_bus", "pcie_phy";
 		assigned-clocks = <&clks IMX7D_PCIE_CTRL_ROOT_SRC>,
-- 
2.17.1

