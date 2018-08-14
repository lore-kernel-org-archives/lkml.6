Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C71C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C221729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HZkGl0o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66C221729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbeHNTjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:39:13 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:35184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732411AbeHNTjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH7aqyzZbWgcNnGArOFBNQgCsJORGQ/zmm6yBNgOv/I=;
 b=HZkGl0o9zCQ+zxYnM9aSealTF+MdcC3kz9eaumNWfKIXbQkZ5xOvtIQ6kvLNeQFNQYqGzoBfJzf27LP6xwAwCiNDO1fmQvd4+m6NJu/xTzFyflko/77ya9N72oLigewRIEsrrDyjsSN5Rl5hJp5Y5nwXcKhfC7qZLKxokcCdyvY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Tue, 14 Aug 2018 16:51:04 +0000
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
Subject: [PATCH v4 5/6] ARM: dts: imx7d: Add turnoff reset
Date:   Tue, 14 Aug 2018 19:50:19 +0300
Message-Id: <c305d4da96ead7d570bf755fde9f0e0cc68f88e0.1534264292.git.leonard.crestez@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0033a85-f55b-4d68-44dd-08d6020620ad
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:ZyEF6sr+IPyLihAaisFbMMFea3wxLU9Wevv0SFBLUEp04e5oIsTYcyXCpMC5Tzg2QE5GmGJcANTl2gRTqkRHoBXNO7ebGuUlmUEJCTFpJ0cxa2m3X6UvYH8UHT8x92khCSSwBxcH2+GL7br5oANiuzIccn2vKmYDJT10ihgkKcQ+dgZdLArw2i/rJPSgFOOyaktB457l+FVRVMeVTfN9OSVyaoyZiyUXSSWI+xCxjJd84LfeZKLV2OrjiK1G8GOs;25:eMP5FF11j+eFtZoCGdbjs7bHDJBpwHSHkA96x8/vfMINDgi4Dzv35W1NATIjI+47xTwe6Dnwm+uWeMWuU262fZ0rltM9Ca3A7KkuHCJZZn/XV0YVo0qhlkqsK5vBZk82WUM13FnD97YQSwNH6UdFPkl5YKJfSFgFrzVnY4NCM5L3pyxTRJJQf8NarK8HwBqaawHwzv44ZYzwtHOY7utoaqT63tPjmdpNabChVmgsgHofGmOF2mx356+ohTCxx2DYsyougTaVtSg3ARtezu9oEQMkGk6LVEEu8btM3pxq1W1moVyjHLDyVHL1g/OoVadyqvBD9hYZV55cfwxSWP4Mfg==;31:5ZXJAYWCmhxTAiI89xnnYav19j74IJueBF8iaGPp//BSuFu3piXWbzgg5M1IfB3lEEnkKtw0BMG12gEwNzVERqZD0hLJVN3jwxVkSkwEcfue/VxjceUYEIXq4/uckz8A17A/pe99fefLeENKrzq1+4vDIYqlKzsl3BcV18Tk7pYNn30ngGg6FP2djcABsdfJDxR7xws0qXi4iQSYIXEiIzd7AQz4MfDXApTsKL66+Lo=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:TdhwX43fwVfzZy3LWluLH6bySEDtZg8mSgrcDApGpn8huJPjMdNrFrCaVIJb8dYynhAuR/BmLcftSJn0yamI1Z/eWndSpFgG2GDCctXWm8DZzHxp/kDaSf+eDVTBEKN/zEgX8BWfkw6++1wQvNp2Nx2nQUshkjE3xbX+YDYE9i49q1qqgvCRjO1Zi54sjMnhQVlZiboJNVWl1K6JeZ4k/BMBi0lpW41eThO5Dxv5L4VqN9ilBfKDbQ65s8dZHnfmkfheo1iC85pz7rWtRfabP921WEWN1wBKl6uKQMqlI8bFe2iC2kHsZIavjY9uvfX6oXEF5hWqUqrs5Dqyx5rAfZhsNoLMALuCa6uk/qK+17KdEPSMv3/tYrbE03CjjvjlJjWPX+Mna0tGB6pCJT7GOoPiy5K8prSxXIvxWuscac96vK2X4AdDw4tXN3oPAWe1VpWAKkEaDjLO8WzinnG9nEGlKJRLCTx8IX5BSYBQXwLsTZljVUqeEICi+UWSKKAI;4:izJOPc2MngfWEtlIwTeveNMB0WI9uHZsEmxvFJkrUGDu8BoRHilkhPwPeBHJ+rCSYcCUX4Vp/yPugYc9WAbFWChREf0azlG1THZnMqfMRzXw8TObni6ZjvYpUh5uOvn+RlqPiXAj1wTcUU9f020IhclVhjThNqGEDn1K4DSJJ135rFx3MtfS0qJmqjhG83KeuHxz2f0DcHJlS0d5MRF0PE27H9miJAK1sDQVmyDP8EerZGN0VaAu6W7j0fwb/JwrMv5UbYR2nJCG/Z594B+Gij3cqfD8U/KUULfOTvPRLdvgEWRNObqg03IHtn2y7Fek
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293A50D8151F3336AE57B38EE380@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(118296001)(16586007)(6116002)(3846002)(50226002)(478600001)(36756003)(16526019)(316002)(386003)(26005)(186003)(97736004)(6506007)(86362001)(2906002)(68736007)(76176011)(54906003)(8676002)(81166006)(81156014)(8936002)(110136005)(66066001)(25786009)(50466002)(48376002)(446003)(11346002)(105586002)(106356001)(47776003)(486006)(44832011)(476003)(2616005)(6486002)(53936002)(51416003)(52116002)(7736002)(14444005)(956004)(5660300001)(6666003)(4326008)(7416002)(305945005)(39060400002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:rJz/JPrUR1UOdDKqf06oxtiWTxnAyfVh1h7hib/K+?=
 =?us-ascii?Q?/21V4B3pr99GN3pohicvxaMVwKaQpjOXmwTeW7tozkg77ojAyrUhgVHE4Jc5?=
 =?us-ascii?Q?8A351NLF+uiPbwjnwXIeXbmVL3ePEZfYLang70SMTFpXrbSBN5qYFxqKTt78?=
 =?us-ascii?Q?YvgThz6JYdl5tDMU0BdCC83awubpezDiO8QHynXtb/yPydpC/LIk0R8R7G5G?=
 =?us-ascii?Q?kFjz2j9y7CTGeGWzHZvCRwYfq63bNg/vhDMToYl0UpC8ZWmN5l8L7B/Ss9Em?=
 =?us-ascii?Q?ulb0RvwVXtENh0VPIwNx3Wo816O8fu0JXnCYaXgT1Ux8fuRb2VX1hhpmx2Ga?=
 =?us-ascii?Q?VmJaTx9lNwGdXEkXT3z36irNmHNC94m9Na26X8JorsFdPlwA+R91kRYYxj9a?=
 =?us-ascii?Q?qAVSNCGoxJzizOvW8jaoM+0k/c9/gfMolcFTp7wfg3uo8NmGv5Z0BrZKbJ9e?=
 =?us-ascii?Q?J9ubwpouakAdnVJgNAM6hPqjeuMkPR6l7gk/PeXDAPIeYy9padr5xTiKySJP?=
 =?us-ascii?Q?kAAwzPwLTAq1l01pb/vAeI2YqpioyktYtyq1b5FxAPbm8uTGN2EJdDKGYDv3?=
 =?us-ascii?Q?aC4KyAn9kOtKzzqaq1qsvMjWK2+ykDKTgEAty33fKguUsDE9zffiZwhSE78h?=
 =?us-ascii?Q?anGUIY2TcakRovsGX5aofngpCDnscAVH+vtR1gMytB2/2RY1jRdxBjuL3J4C?=
 =?us-ascii?Q?1JZ4gnkZ41ziPEADK5q5ZTs5zBwlznejGgu+uxv1d01Y7Fi8uEKiPv2dc8k7?=
 =?us-ascii?Q?NVgNRRUq2GuXE8gELE8K4b8V73a1K5PxDRj9fs+9KMk+xpJeXhA0GCePyVFa?=
 =?us-ascii?Q?bQeOSsAvKjt2w2F68I9iws9oTUkCWSU4/ZyzPHg602kWuH+k4XMj3C2Hw1is?=
 =?us-ascii?Q?8hUcOqph7ZXZgazKJICyNF1j4CHVo51/uiNwCC9/dWVpOCHWinNjxhhOnz52?=
 =?us-ascii?Q?ywLyK/zHwkLXiCQB74VrZVOXys7f+w2UBzyX/uLf3Z2/NAeR87hzb+lyBPTH?=
 =?us-ascii?Q?Tcek4R4LB+4KXJoYOkYLLQ/Jol/VsBNqST3hZokPgy0I0WZ5grbD6SpV5mAM?=
 =?us-ascii?Q?ynlds9oRkzYDvukw+pmzi9SXaLK7D3E+IPcXUTLpHZFz11LB47P1ShggLTe8?=
 =?us-ascii?Q?tJNcYI7St8QArxU/X89/96toPJHDygbQdEWyLKxWQ8N9dbEeWLw0zWp4XSIP?=
 =?us-ascii?Q?9AntAJI+yMGOSZkxzmeX2Z3EFgVwH8zRNCv1n7dj+fmlZby8+W2iFEA50V4Z?=
 =?us-ascii?Q?v6aGoYa9ZN/LPzyOI5dWEbljeGBmakgo7Uhh/xwr5Ur0PScfhwJMU4nvYnda?=
 =?us-ascii?Q?dNK0d21vcAtGVYt4z6dbBs=3D?=
X-Microsoft-Antispam-Message-Info: Tc/qaDpQNWJUYufmdgTi8dejg9Qc2PDT9Z3ezwEC6pYzyJmXMO3RdKe7k8r7FxZYgqmXsdpQxQVpqKO2f1u8BLtNdHUKsBl54UKAWvVxwI8vLO+WiGH6hIcJXuIgO4u55c/Nod0qT1SoZRO/Ug4nzxag6vstKjJB4ucMvo5ewyNJbPX3dlXxStDD7iU6Ik4ryCZ0kJwxphe72u3h/Bc21kcHyRBurfq8Ry5I2Mh7SfSnjnW9EqcYKQo5hoLHnw4Sh5v65w5lEL2+HgesachioUCZQNY/ErX2VhQnYuTezjrnw6k6sldUWipsxM93SCXcbzZo+cVrnRPaaS1gHy/2fBct/h9wlysBTOHEs5dAnw0=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:do2GLVtpwZiNxABLlC0uBiUes/zQ0mdJhed41Eh84tGjlfHGEColymeQR+q1n3YcwdJm/GB1sRrDKkrKOr/CuLFmqOi1D6dBAvVp2JfeA0JL9rTY/IetuaRZEaD3luYvUErsplR5egSi+UMfkcqXjotdk7jpGiDDnQQtUmJ0bnZ7uJ7hdqpdoKIqsC8kCN397Puojc13WF5OVgPRmR0i3+XYdBADPC9yLBK+tt5kQDxGtI5eijMVKnVAcPfYgnGaITYP/3F2wG2nqkKHSs+wIZic8kgYpH8j3+wkn0eELP6syC7n0nv0gR7GVbDh77dgKwDuEkIZ9d9E/yvo+880XekKBXZ1AHbHJEHHLnfpiosG+cyuqkUoqzpoxHBAv/98R5VsefaE1a34MtMclJOu9Sk9IcUhswlxxbNeW9u4WF08ZThqJW9IMPpEfQgZ3WKHgiae0lPzPXfS5nXHozaiCw==;5:4/RsDCd9fTMxGXZzvfR1QkxK8H/ATmedLp2fcDTZgZcFhNlpet6GADjdFIgnNiB0D4ykcLRatU5GpmF8FEinCK33h+PI8XKj6omn1+W+EWHwJbMUayfmn0aI4lk9RH9Zf3owU4VpTL6jiyUceu2q4fvyB++r8rTdTs0O2A+fML0=;7:9GFzMSbqO56FLSUTeDR53phLVQXRrM180C3QIzs92Bub7+AfE1Tn2irTXktSnOTlbYT6Ae3H2Mfjdhpxi2vgUMsy3zxaj8g7Sh1M1pvgM1sEVinaTpLzY3YHO9rEm96/AgU+tXvwns0Aeu2mUqUd+sJsmITmNnyBCgAHhLCjfNhBJmprjs9SIKOv6eokiNlj48uuVuC6V+sRQYeYghB6wZ+Ih5PHO8gsl9PUjdKJIrPD746P1BMGd5jk4+VPKe/s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 16:51:04.9631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0033a85-f55b-4d68-44dd-08d6020620ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for the imx pci driver to send the PME_Turn_Off TLP.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7234e8330a57..efbdeaaa8dcd 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -144,12 +144,13 @@
 					 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 
 		fsl,max-link-speed = <2>;
 		power-domains = <&pgc_pcie_phy>;
 		resets = <&src IMX7_RESET_PCIEPHY>,
-			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
-		reset-names = "pciephy", "apps";
+			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
+			 <&src IMX7_RESET_PCIE_CTRL_APPS_TURNOFF>;
+		reset-names = "pciephy", "apps", "turnoff";
 		status = "disabled";
 	};
 };
 
 &ca_funnel_ports {
-- 
2.17.1

