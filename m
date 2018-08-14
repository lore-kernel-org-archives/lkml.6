Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED9CC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645AC21731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YLG0Hxsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645AC21731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeHNTjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:39:06 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:35184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731707AbeHNTjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoayyEj9MrYdu4FfAXmXeW97Ff6v2RNRgSCyX2EN1uw=;
 b=YLG0Hxsgt7IBTVfVTlOldit3loIS3Zfv/3gIFbOllfSNanYt5feTldbGdcJIp/un9KObPtRe/eE3S49K+4FQIHvb1yR5QR0kNxZThwXVxG1oyh+CpzDu/YI8c22SfU7n/NTRk6LTrvcMLHGlAjVh2V+16Q90uXpHCDSLj8ZnA0A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Tue, 14 Aug 2018 16:50:59 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 1/6] Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
Date:   Tue, 14 Aug 2018 19:50:15 +0300
Message-Id: <11c9de513fbbc39a07d9e9892e7172dacf49a8f9.1534264292.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::18) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5029996a-f78f-4d9c-2ec2-08d602061d37
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:hhquarKJKNAUrD7apJj2DyxWI5CDfI2cvMbLYnNFWzUq2c3Wu5DmvOGSkN+2SSZAbXe6+tGZKtoADkLMCD9yblrLezhpZsaeiqKgbRieFNzX6Uoc0ATAfGq7aWEni45hH4PUDHl8K/ciPf77ukx+OAImBrEkxIr8rfnh6v3VFvduO78eQLqmP+PNXWEIjmGi5TtGZc4ITpap57PEkWA6MbCVvHuKUTM6ZShAcpVmOpC/RnclcKcpJXTOkv7UwzUQ;25:NCsun0SQenJkNH9B4QrufLzjiSlvY5XRmQjCH9C2qX2MkJOq62PimjCTv4d5Mht66hpel4FWGyyMJCYrCpXgqjpI3/c2tgTDxG3RYwgETDr9kFZg4II48BYKpfxKqnKAIMWeZxMbwGIectw3y6x20YTEAtOf+SdyhnWgeZ+7pXmfhs+XZ3mZ7j6LtkFq8efcKk/lWmKYnhU+dBdUmP4f2tDVHLhoPE9iYYL+ivlUSmUDm6KbkqtZwsu72v+U55F4eQEJc60xJiFX49FD1x5TPS/mmdhceSrYIkwkRoBSp0x0ViGpaXlKdO/zPDRpRPOz6GWAmqsp2+NrReoIon6kkg==;31:qipQSYrblDYSbO4yo6eG3EjOPw0gEu60nwQdKviAzVBHVe7x506V7TwGlMaiRsxGIvFA9EvlTWhcrgbosvSRICdcuPBh2QDFJACssuwiGrzhzzSdMb9VGRE26/Tmc5gZL04p1ucXvkfX0Nq8yfqHVGjFhzwUz1XRokvYMANLzyKqiCAxYCTUxeHi2K01+eJZTGNJmQVCHdpIG/76j7U7hlSdyeiVV7kOCBpUS5st1kc=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:UtDqOCjAzGPmWYl4dKLxo8cjQizeTZAZEVcjsxvazLCptNm/VbgIw+fFzHRYzXzzYwSx4VFQRcHQqpzNbsMAklfsqFYe6JqPxyqhbpbuGbLM8QFwBvk3HZ9OHCM8lI2oqEO5ESNxqfk4joC/zG3+an3L8neQk6uhvQZM35Gm38dLqOC4E5JxY3MjQ9sTq4iNs27POAaxfnRBrVOVAvIKPiWw4qwtbdNMlk+M39XNGMBb7/dlcUqxxBNqE9rZ2JEKRjhSzvur+pCGLrnA2Z0/iUPLiT2ut92HxbY0NBsPG2BE3wa6HsLGlKvSVfRqPkQuq7PVgv4cve4A+PT1QoqnAwnPQKLyLwaTd+GZfLosr0nVxvwfmo4D3LvymlexMqvcFjY9tkuNKPxZTo6mK9YNoL/kbFpr5jFBNMyn0lDyganX+befpxF6XhDCw3j8VXoPQGi199wkq+bJYSw34j+/NxJZmZoXRXe9QaY6Or6NfDt/j+LcnHoyrl2+ukIi/RZS;4:s0IBJt59g0h0Ddd/9rcYMBJ8M/2aRork+PEmB/1tCJwiUm/B9iQOIir6thGBo1Jj1Hzf4fM2Nar47BlgE6H7uuMWSkTXqZP7ntD+K47fO3hhiK4YC1X9Agfonw0iIOcELu91D1y17DBZ3NQuGzgc9aOihgcRsz+Dcn1hpkmMcnDCzxo2hvhczMQJPrAK2V3NzOZKwC/9dDDhZYVnb+saG/Lsj8+/g0jsy+FP9IWmkF/Y5mj99h9R80bx6q4E/Gqj4Q7xibqsAw2bUainvCl1tTWqE0VmyQgqWeoDfVk8zEpEsAh8podqydhPkuWkz8z0
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293740A39D31BF2EAABC4FCEE380@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(118296001)(16586007)(6116002)(3846002)(50226002)(478600001)(36756003)(16526019)(316002)(386003)(26005)(186003)(97736004)(6506007)(86362001)(2906002)(68736007)(76176011)(575784001)(54906003)(8676002)(81166006)(81156014)(8936002)(110136005)(66066001)(25786009)(50466002)(48376002)(446003)(11346002)(105586002)(106356001)(47776003)(486006)(44832011)(476003)(2616005)(6486002)(53936002)(51416003)(52116002)(7736002)(956004)(5660300001)(6666003)(4326008)(7416002)(305945005)(39060400002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:4C1qIcpvQczTcYfSuxte3L1tE89YzjJwbvWUkniYb?=
 =?us-ascii?Q?4i3jyLKivvS07+myyNfIioonw+cyKt1THOXRAsXapovHJNiE2GWHa9Q54yHa?=
 =?us-ascii?Q?VfkFqgrwmi1hgO+VpVzvSM0fh7095W1ab1XFWb13Piyu+STMFIxzO3bSGIAq?=
 =?us-ascii?Q?iOhl3wkODSWGpIAyI2bZAKxQNo/L9jKyd0nNnSzFY7QatWNjrLO5q3vzDtAs?=
 =?us-ascii?Q?TElxyPvoj27dWceDPxbhlL8z//O6ZFcZ6TDTXIb7dB26SkvuRkBqt3tSW7yF?=
 =?us-ascii?Q?QWX/WHFPjWKF2h25kBhkBsM5bJ5PScAKMkml3N2PUe39OlWTQRq/Yr4WidbB?=
 =?us-ascii?Q?yUaCIDoEhmecuLj0rK2U2mU8KKDdpYrFSJTf2HhNmliEKnokJOz/gdnZuWSI?=
 =?us-ascii?Q?j2HshnFT19TpRt4I6fbMDCP6G4W8cKtIDI7kcM0V033p6HUJLIb1Er5AzFe6?=
 =?us-ascii?Q?iRBEk6FLUJ0RXwMdVOTbvMouzFpOjY94iDU5iFcqZJnq4lytMVySX9Y/O0Oi?=
 =?us-ascii?Q?2hld67nL+1Zv2TxwUO+8HTsXaWB6ZVfoWgmWPNe9ClBWKvJHBS9QHa3S0YUo?=
 =?us-ascii?Q?yfvXgaGb+eM80Dy5nOEtzqMlDFruZ76j1Jvj24N6cluftb1ZmAS9OpssSYtl?=
 =?us-ascii?Q?VLvcH4arQY2NBpoVZpQbEv6JXCvuGET5M8mdGsC6Te0dYuJUrQTiHe7Wh1mK?=
 =?us-ascii?Q?WyMBOhJyE0bg53YYQSGDdIegn3fp4DSLj2APyizlaSFvKEjHM7aNGlQ32DaR?=
 =?us-ascii?Q?7WxP6kcOeNJxKwQB6owSNEwiadQ7LwOCCqFteRaVh4xwd4gW8fQrlKXPAzpf?=
 =?us-ascii?Q?0dgY8bBTTlSWTqomycOKrP5XVlzOoz54NLX6KRbgghBBo7KmCmUBir2PK/v9?=
 =?us-ascii?Q?nZaEDMDpYw1GL6Xjul8X4EyOlZnE0cqrYnihsci/ig9Gp4mFDh3978wxLtPx?=
 =?us-ascii?Q?WIKNmA58J1g9ZDpCxb8sqpXTsSVvKECN5PN618hT0auxr5NniJZljmvMZfvq?=
 =?us-ascii?Q?4rFNU/qj4QfnRW/TLhUvZi6uRLtuusQwxDCd3hMOvSQ6Mcy2bjX3w8RESGlD?=
 =?us-ascii?Q?zQhR/k8DZ101AnDLzphv151xIt3bBpFQcxNh2aRvXOSVK3rzNMlPjFp24Z2l?=
 =?us-ascii?Q?PIwFOYV72OCreONYIjQTfpZWdhiURa5uxwx+rzi4JivpPfbbOirdn6UCZxvr?=
 =?us-ascii?Q?kSxNXisycQQII0LCDoHFlu93JjiK60Lv0Ae3zxpuPTFcBVSeBc6UEn14SsUi?=
 =?us-ascii?Q?eacKiqp4CWAlA4IPJRtYULswIxSRlZY7g/+Tt+n+6YfXcTtePHLMS4+Lewyq?=
 =?us-ascii?Q?GEd2BC2PY/gJMCjwBYtxwE=3D?=
X-Microsoft-Antispam-Message-Info: +Ma9FnOD+PBLUjXbiWSx4NZDoc5gFkTWGdCcuY7vg9xXA5AOC7wzQh7TE6OA+XkB69RYw+gk96xjL82URteRPP7RI10q4kpqGt4F9DBuTfUhhh2QLfxjrUTV3QYlk0sH8dE8rW4nlltO6AT/OiS0Zx7PjrpdfJOvCJMfeffyx3WwQt7h/uzwmkbVUeQX62VGIiGRyBXjrSB7T6Axc80QRiV16gmdsfzgiUoiADgUYRkMcWTZSEcdPtgByy07XkOIZMcgESKpBRG21zrBq+r8UPF6CMUrIGouK/yaW4qkchuA4AW6q+V+TEH66NROAzFu2oKpwW1AT5JDBUNcn0kzOq5BQYl12CSlXFhgMb+b9Xs=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:nm0bjwx7FwUD7CbTNUG7ls9oIkiAntCpyy6A7Xrs6i3SjUdDCUSoAiST2AdUZ20ucEr+j2QJEsYe5FY/JpLDzccG/I5bW1MweXgOj+nsTb6iarG0qM9MFuFWexAmLEJ+ZnmSCA761Bc5c/cfNVrQzOmYm5lddrOloH9LMVh51oOh4cc0L+A2eDQuZ4WSz7EOVjgWKOS6Gk693mGxRq7Vvp0wj8VjthVm9Yv0OGGq244DLUVM6e3TZziCJwYLa7OufdOty/KbzLnMdF4Dza27yOqyHQ965u/lqj2ftTf85U0eWGXMnL1UKaNHQPOFwpfFKNV5NFesDLY7goumvTeM51M/xHyWzIvOH+G0f5v5zmeObFdffhUWSF7RXW6hzMwTOOoRZfdyq9kvi2xMkxL3fIVASxEyCo0Px5ypgK125+jVq0VfLfrR69hucz7ogqaMVbcVr7Alb8+5X/sbJOGAgA==;5:9XxmAXsftzp9NdOmeodjyi9/lxqIAD2wR1LhsvWwYAXu92FpF6N6RcINmFBBIIRpaeoJ+FCdbEslPArWvAJS+UxTtM8dxECwi453ZhKYWkl7P/RheeZMgLFusDeMawcu0DYG7p2/JlRtC+EFWMqYTKtmkdc8CatK79vMaX8LPZk=;7:Qr6BeX87P91y587Rk9+/g0UngGmV2AheWpGD6L4XBCW+7l9b/ip0197LoNkACcTgfp7pXO/xsBg8d9mlCwJRrU+TNIoTtORGtrR3g3Md1LKpBQ4AqEjl+CPd7WTZ+wB8kx8a2WtLcFmltu1JVPBP9ldmFABKt0peTlEoJh+aqifBDheGftRGVf0nRM6DOzcEfDQAztH3+MrKfEIy91VXhl++4VVIGIYtWI4IWjeTlEzJdAybwAjrXuGt+jjxWI7D
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 16:50:59.1571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5029996a-f78f-4d9c-2ec2-08d602061d37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.

That commit followed the reference manual but unfortunately the imx7d
manual is incorrect.

Tested with ath9k pcie card and confirmed internally.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
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

