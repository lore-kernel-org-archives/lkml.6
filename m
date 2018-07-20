Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B767ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10834206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVd2cnRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10834206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbeGTNgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:36:14 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:15725
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389545AbeGTNgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNPMUKXocvP96g9ZKtbNa7Q7xyE/0NGp3VueT5OBo8M=;
 b=RVd2cnRDP7Pmg1sAOCgbukiH1y+UIbu6n9sOyafTGG4y6o4iA4XTm5JUGfUr+GRIh2ZYaE3uP4XKqwZGnthIYgoMLG7M5f+kVPP8Jud/UrycDaoI5EoryI+Kt4/U1GLW8wvWTM92zHQ/emm8mgyqJ3w1Oh7bdJoDKvcmE2wNGYU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Fri, 20 Jul 2018 12:47:59 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
Date:   Fri, 20 Jul 2018 15:47:42 +0300
Message-Id: <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1532090446.git.leonard.crestez@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR06CA0015.eurprd06.prod.outlook.com
 (2603:10a6:206:2::28) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37835fbb-bf68-4ed8-ea6f-08d5ee3f0667
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:yDly7s6iNrzgKjoV6yF+2omfNj+zxa50d29GVAFQYUTrkZ5hs2x4ky12SMxgKTgki13U5Hd0TLjQNuwOsah9FFaCk0jQ76GTx+aM+KiqZZNk04m9XhtpA3VSgVzPkVbML/TlEYRChyPrKnbmrbbsRLa193wbriOWUZfDjpd/1HDe9PTo2hVGwHrwI2b+IcYSgXEzQvpuk+0FvIoeJDKZ+dXc+SIrmRN1nEI5Px+ZCW3CB6NNdqjqVIvWYWdc7CMq;25:7jq0vo3rYn/h8zBXoDaKqSVLNHNba42kAsyu9eNDds/C65x7FpG4W1hQROmhoKitrMAQ8022VXiwL5iXpnRJYQDRDrQD64/uJ/9AsNFOlEI/8ZPEezqBhneqNVRxsCDp0T/+iZLuta+WwHNj1mamoBvYv1tCy1m2Q1ffuh9jFEhVBug9OqEt56TCAuMrGqvDeuo16FkCqKauLFT7ZOUTYj/39qeVvP+VALvUrJprCFnOIujekdPdK/Bz8b7mT/phnFHzh2Q7MqVLXfI0c6Mv6kf+O1195tLK/LAUSXzK9zNh2IcXTKYJ+bB2anmXJxc4eYMuwndU2/m3Y/6nD1OUgw==;31:CGleWtbx+/D+67WK+srCeE34bwyidrG4n2QG5vx1N57MlmNlumhSByhFBTy8RDEPnNwu20ptX4PptgLW/1xVkdBG3JLjH6ZZzIRJU5tDGrt8Rz2PUpwsJckaCj2lW9jJDUOo9vK7fne10tk82eLA4gHDFghm2Jh0L7/PnxJPS6UjXitwD49ssvd2xZHdpH5u5w8XFMA+LlUvLBHjXph8vgY+JaC76yMDRjDAonW+M0M=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:ZhzO+BcSy3ivmF0z1QxuUAcHeMMkVvsX4siMDXM2H1u8VNvXUyNIGp9fFbdd1khRI2LDa5N9GAjSpT6I7KlF+zm9TMcHHTRpo3PbqUatklU2Z9i18qVdAnyMgAJuqSZuKG75k6a9eu3OFSjdIiMEIPVw6z5yRBfGLt1+R8lGrzZaR3dq0pz2FimmwK0b3FT2KiSAedMeAY4DZLW0vWCpx9JmCq4ncU83XUh/ZWLTFg6TjvI1VeojT3dQmxCHonRwiMN0iMYVfHT1RUtGujt9VE+UbfAx1LuORxznGoFdGvi3W2FDyWJotcob52UbMUNB9AASygu4EcKIfr5D0tFc58vUHklbPCAyE+HCk2Wv17L4YD/XEDj4EY8LJL3PQVjk8qIOVUzIKiTFzH1EHgaF2s1bLTOBLNY3YX6vh408ss8uROmirH4IVRpUcwDMlS+H4aRObwVgK+VEWq7HEP/x6p9+ejAYldp/9tWtyD4m8XpoZ4VAEHqZjgSJFyd9Io4g;4:dW0RHBQs94wWmNjE0XznZegot8OmHIhZoSx4N3DfLc9zoec8p1WLPKsbgel7oayauHolDt6riQ3N6TriwATTjHp67BPuT9qgVHNnsu0oS9mjLu/TjtqgS7ylK5xYuC5Rob2WRI3JE9wmzzR1ahxyxscHgv+LUedRuUxfwY33Hm7DXASHrU0Gl3Hyru6aWUOnV4z1nVqtpDnhDy3OS0msa9qDff861V3O9SRLYmnXTp1rmdV+gd5xjHi3LyGsyq6zIbdVu+WKkz1T/JijvCQ7N/dThsO1UsR3juk0kMu3He0Nk1llCxQ8/52CWAxCh9EU
X-Microsoft-Antispam-PRVS: <AM6PR04MB42932B0B2CFB1D3186BC58BAEE510@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(2616005)(39060400002)(110136005)(575784001)(54906003)(50466002)(86362001)(4326008)(305945005)(8676002)(48376002)(7416002)(8936002)(105586002)(81156014)(2906002)(81166006)(106356001)(51416003)(11346002)(486006)(53936002)(97736004)(52116002)(956004)(25786009)(6666003)(16586007)(478600001)(476003)(76176011)(316002)(5660300001)(3846002)(6512007)(44832011)(36756003)(6116002)(6486002)(26005)(6506007)(50226002)(186003)(16526019)(386003)(66066001)(118296001)(446003)(7736002)(47776003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:nuhhaoTqbx8vmTDO/CM6vVyU717fXZcRjixcjnbCF?=
 =?us-ascii?Q?hSUEqPRZGwNNKvANsKfuu3X48jVtEyXLpChUgZprgdofq4E1kyuvIbNDLTMT?=
 =?us-ascii?Q?MB1jlULXxc8c06bAaU2oQTaqsFm72PDABfrgwNpKUDifBE3NQQAZ7RDN5B84?=
 =?us-ascii?Q?urFiuaquaLa6pwMLMosvvOGsSI1pcMIFZN467bXGBPNlOAIbqw6wXm5WObJs?=
 =?us-ascii?Q?bpgVF70Oj5sRx04VVXT9HjG8yUNhglpHrckXcFbtMXgYRbu9wRxacyJRGyjW?=
 =?us-ascii?Q?+CmT0/io6AFdIJUQyMK2upODrkRZOxj+2/M+xLZKLP4PsgO9ZPcrzojb7/ei?=
 =?us-ascii?Q?lGd7K2uB+4Ol/8DjvYQ5mJZoq0vQSUqpKNE/TUcU0HaCNq4UM1dSkQN6sytn?=
 =?us-ascii?Q?b0HhQ8r06b3J/v77yJYHMWySota+9xcQ1aQG348IBeO1x0FouVD3IUZiv+XU?=
 =?us-ascii?Q?1DTjlIrSDsGx8dYrw4p9mgU5qeiq/aAkuRpBFabxZXX8GOPIBGPxgIDkoWBn?=
 =?us-ascii?Q?PdyWeWLRBVlZwXUTS9QL2beh4AvTlk4IgejmkPYUDFmY+BlWKVo8RLwRct5L?=
 =?us-ascii?Q?bZZ9wr2IHt4P4uhNEYuvR0g98sOPtgfkjpb0PBhWMHyER7GeuEn55IsZbzwV?=
 =?us-ascii?Q?yc7iMk6M5pmySjIKpcqY32ALTCEefViq1Y9BA5h6H8y3UYxFcgDDUB+z7bLv?=
 =?us-ascii?Q?AaDmRzXA+UfkXsj5PYBMjK9IpUbw/DsJZtV8S+Gbvj3E1O9E6+ESSAaHY+Mq?=
 =?us-ascii?Q?D4FFO/pPLnwZyFQyqVzvXl0kMCdDV+GEQyJZKGKnw3VdJ+hIHn+DmX4yByVS?=
 =?us-ascii?Q?zlpIbOckVOG0McclDgYYT9ICgXxt9ExMWHEV4GOeaKAxEzf1XNUN5LvrpTKV?=
 =?us-ascii?Q?TF8F/tVMEXbtOwiK/cSG5eWa7UzfjgNERviHFrHhSpE9rxUPOHT3G/c8E7ie?=
 =?us-ascii?Q?M0cPDpdOO/n9iLy4idVp/qEKiDPX6N4gHVufMSCPFj5LSndHxWlrDSgUHXKb?=
 =?us-ascii?Q?W1QeabsXHe9a28bJzQAbXZZ30dAihU+Ha9kgIDKG3ph144GJSblaV2XwFAF7?=
 =?us-ascii?Q?L2gDHYl8r2847KjDRxOdgXRztlZ1yCWuOPk3XKF401IzK6Cgtn9Ma1Fp6Wte?=
 =?us-ascii?Q?E78/tfPAOrjEGGWkFLt371oxJlhmnMycLcAlpkoytZwktWGtVI1knRR3MCje?=
 =?us-ascii?Q?lK/9tDelDxErLa89vksOLrBLizE4VfQDJxnjzdhJ1wjIQraWurfBdRVqm1Xz?=
 =?us-ascii?Q?a4MZN2iujV9slpXSk5DcG/XUYbjF2mGmrRfIkOIoln/6cORYm7RKsMlMxXiV?=
 =?us-ascii?Q?JijPPtcf3kdBetambvNjAQ=3D?=
X-Microsoft-Antispam-Message-Info: DFBAkEWtr3HM5XyINll2Olykr1x3vxq1dX30miEmrd2YDCvWqk8DBBUgUgJE8AxGi1XvKOzLxCfDsSn6nbBt/uPOEiti21EJPF+iZOe4pX/slfS9DAqf9Wg0oqRvBnogqKMSnbf90bsn83FVW+YEmHf8sUZbOLUVDq5fqocvNH9IHtNPfr9SyjIxiNaNv/PWqXSAtsO3YoYfvI48zij7n03ThX0HlMUD0Sc6cEvZ3Lmc/elQ6HfJSwG4BDnYf/v2RZFjH5EATDkO0Yxsj/0xs93mAWAYZp91M5NTGYX6aS8gr8SqCuAoKOLjVqTjILaVRx5zWGsl6sok0CMnkr0drgQKqK/xBcgJ9ITp4gQgPIg=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:3UUAGGJGIIBwXMy/6rH9BWbWh5V6EjEM4C32PkSFDYhe0bCPDy2495kB524qIQOGj+9QPasd6mTgqRdDMCw9XRK2JEaKaltqtrukxq8Os/H4OqKmQ4CA9ZUPYRIqwXGZYs4SNzOR76e6rloTtorzQyWUkLG0n/m61F/HAEaXgM/c61YsD5CYf7gMqhvFigAe4BkzLiQTEj+nlQ6gJZLmFT9KdBj46V8XwXX1vZFtP/dInLtD0qTUiaAuKOBKDHnkbtbolMeLut+a7Q1XZ/ApvCTSPMo7V7TyRAQBx51kvDlL1ylgSkzK3U96rPKqwDQf3PFENXBIseF0WAhoomhCkFYqynhlILwvedFYd27n5sj0L84y+LK9fru8T1BkYRAzpLeLT1sdBXpvOLzTPptakEZTHURYo8N499yz87j1HuhTNsy6VB0WdYtkt9iAaOz/ZP8nZwQXoL5SVVWCEtFDvg==;5:j0jb72DbRltkiUyJDkdMZrRlGI5RXTRMSSLuh/5zZ/RlVerrL43S13qDLKUYMdeJHh7fjh0pUi+ce8filOu3RbWzxu+Q0EhfdkWwExhspjZIV9Gl+wpBLcMfVhLdu744IT1texIDM5C6wpI3YQyFckijZqrHbx0sPcU3Mo6lylM=;24:eEFwq3rga4fgKbn3tCiMCMYdm16GwtmTtRlV8xnL9oTsNbaK7gHYLsH3pweE+xobE5NplaDwZP3U2QIgW8qFmuQGcZVgyjbpbUkfoULbbjo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;7:iiDuS/jeM/KndeJssFmMb5HPgiN3oP77Q58ADF9xMRNJaitqKxxKrhXSVN9IbjdXb5YO5HyXGDNuIn5a3RChaIJU/8T6FNP2cwIHEjF0SRrI878AGKN5NWtyzRsq0msQlZU29WcW+IrzHk5/WcuLKo5u9qdXs8SznUEUAQHPjvGgaK5s/HJi4dE+RIBaj0cF3guHc07zPRDoqih1jCAWRiTAx/daJNAll1iZ5BHS9+5iOXNfyZAlowcES7BrM8SZ
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 12:47:59.3429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37835fbb-bf68-4ed8-ea6f-08d5ee3f0667
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
---
 arch/arm/boot/dts/imx7d.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 8d3d123d0a5c..12c5ba7e9f1e 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -123,14 +123,14 @@
 		num-lanes = <1>;
 		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 2 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 3 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 4 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
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

