Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeETNvO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:51:14 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:52069
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751597AbeETNvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:51:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com
Cc: hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 7/7 v5] arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
Date: Sun, 20 May 2018 19:19:51 +0530
Message-Id: <1526824191-7000-8-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To VI1PR0401MB2429.eurprd04.prod.outlook.com
 (2603:10a6:800:2a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2429;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;3:dE4JfL9KbMf2TGLIuXOpVefZqO6268McfSCcN/LQSCxqxzMj6laYPI78wAPtucoGJdF01RabLP7phxFEf88GJz/NiDxCAEukJkOX4Pf7da6iMwsAtYS+kcYHb58x4tHJPjIqRx6Osnv8fYlf6j0IsVRp77trPHlOsY4qJVohssMDcUXSDQujHidVGrDyt11PvdycTO50LmPd0Il+ITFFqmEbdp5UQDrJLxQ5k81uWP1kf+4/b+Rx5fT2Zyt0zwt3;25:7pMn/H7nOrmVAf9mUHMM/6PzhTJeDcAu1jpRFTSZiMJLpxMLmUUX8bK7nY4hNyWyUkW6d4H+gcCW0CIAK9qqbhnri1ODpgRw6C5EzhjY70V3qqiPfzOW4w12ih/q4H7Y9Q0OwbZlsyaRTauwyoHS2w8etmCT+o/P8tEafHPbejNvZemevsqk6yy0/pjaH39Ob2X+LBn9ZA6i0mj1NV4mQ41buPMuwhONnkD52387f3tCRhzIughTzVsfksq1BcR4nolPjpPpQwDtGUBudD9iOTOmQJyIMVKApyNR2GIFe8t4FuoQm0iTPg+FG/995xR3Os59gmXVtoOnV+dSUHUclA==;31:Jsto3q0IdCbCJORTD9FJRQjB6VugFLMlWDbvc37IcpUhSMn45oKd5sKRWXF3I2tcU/ynvno07Q5/b5CfpnRGkyK2YM9IKBN8CdVf59boTwtvqlDZ8FQc4NnI11YxBg7pm6VujjrxXQfPIMw2tPzuJ7uAMa6YWR71icRkp194PgXYpnqX7jWu0oPj1HREJaL6qAqr/xVgIexyrRbd5oazoDu0opSbRbQFZJl+3/lD1KM=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;20:JUHhwRiGBhIWyPM46cT4NOVm3Ue64R6ArNcmNBYN9t9KwYsY4O4Tg7HC4FrQNhWIlGeViONZ8lB69pkZbe9EOOQh0I6SXuSC8Gjvrx7U0S7pu6OCzgk2+D/TlYu7ailnt5/e0oLDDOFH5YOMpBRKgMwHuGQiqu6nviS92FWkn3ra/2i9QdWXlN6FZifkIjhtPcoQHVe3F8DMkIa3o0RTcGbMlA3xcWBc23DQz6RR1u8oy4gRcWHgUWHoSiMzvf8JIKCRM3SOxWYLM3KjOEXj4MszI2CkRirYZTYT96SRoim+95Cfffuf8weYyjlG1HbPdLS1o+72Xu73/T2VzjAs5wzG1xbfG5EXkjQLSb2aMDJqHNC9+mv1NMclaK3Xx5/STk8lIKOLcGfcZm5oFWSDehj3zViinDHv/hXLj+NsX6qQqcbT9s8HP72pmKl4a9anwo5iAXwn6tGVrAvCzKb/UfekriiNXxHD2tCAdqT0/Ssd8QCvdULcjKmQSC+BsRzf;4:VfwlPbVtBH1D+XaYuQJOBcs2ewsSzrVck751/YeHoxssruZttFQo0loV+nsJ9fsIa9MJMXmZzfqFcgSU1tR15Fd+cdTi1qwbwpw6tCHHj8fq1MvPKRbsCsotp37c1vESisCkApBg0DfSRAhegxiHKuxpbDxIIUnWK46DhcCz3K/SLlMcnl2fswz6bRrOufwyS5cxi0CjfrV5RF5u7yl5gg4Os6gawyGBlk1qi3VUvWF9Hp2OnsAUm7/0nN1Vg30X3aZT62Oh93nZSZFxCfb+jwRJ0i0hG3M7ThaKPX3O/uWsppqs64CKBClLnB5/TRkS6+sLG2RHOWwPDp4un8yZJBQ7+effxeuP4xG0coNcaK0=
X-Microsoft-Antispam-PRVS: <VI1PR0401MB24292CBC49EC5301665F97C1E6960@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2429;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(316002)(50466002)(50226002)(47776003)(3846002)(86362001)(39060400002)(66066001)(6116002)(8936002)(575784001)(16526019)(8676002)(7416002)(53936002)(6512007)(48376002)(486006)(186003)(26005)(44832011)(478600001)(81166006)(81156014)(76176011)(5660300001)(7736002)(52116002)(16586007)(51416003)(6486002)(97736004)(36756003)(68736007)(305945005)(4326008)(106356001)(446003)(25786009)(5009440100003)(11346002)(55236004)(6506007)(386003)(105586002)(476003)(2616005)(59450400001)(2906002)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2429;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2429;23:khBVxrty8CNTb7+jhLXCI51+KMPAy12wdumsUp6?=
 =?us-ascii?Q?plUhuYU8ewT53DsouVWi3jkMVmzFusJJ6OgByiyXulCnMunyFnJJcEDSchSf?=
 =?us-ascii?Q?zOifOvBNSEUf/HNWGoz+frntmcJlwFRYqtLBxP1C277ReCe9mbXe8EgJ8oW0?=
 =?us-ascii?Q?VBr1lrjBQsNvLP5FZ86vo/ZVhd0QnqCQIN3u+tU5SuVNT5vjrER8v4AyuS+q?=
 =?us-ascii?Q?+F4PuJfU93aHAff3uw1hprMGiZnP5iUeq31vbNOZuYgTO6eBwvPhraq7Qz3Z?=
 =?us-ascii?Q?r7MnHSzG6EA3//lw65itv03ECD7Cm7ltxP1m06u3u3xXevLw5uazjM0AuooO?=
 =?us-ascii?Q?d9MVilxXofa8yeXOwN8qofZiBXKWBSe8ejl7zo3gvUWNHbPHJCqj/cLq2DkE?=
 =?us-ascii?Q?bWmSoJHuR26Yp9s1RM7yZZ5WZdpJ+f292L7ON+CYra01GNtZphGBQM3dLmg6?=
 =?us-ascii?Q?fRh3WnCN57gpfm4HVIVcxc5Vh81VS2jvv8sgCWoJiBpfMoQN0TkeSseMp65B?=
 =?us-ascii?Q?AwSYNZVbb56s3bFmJqVu9GcZrMRw7ypZ8GbFzeZQZjEiEQykAtUFJqd4s5dG?=
 =?us-ascii?Q?XEl7ZYSL7MQFccuo7cpaP4+pIY4fxDGCClakVYsftBaYdYm7DItNYaiZoJnI?=
 =?us-ascii?Q?pyN28NACl5IVKaM47FDsCIsJrv5qbOcGiqxIru9OCAV99XwLPiiVy+9wYQ7+?=
 =?us-ascii?Q?opxC0n1RSooS+ofiXfTpYkb+quqEkSTUybfUvuXVJQ2XbKV/mNbpJcUOKEQ0?=
 =?us-ascii?Q?mwHW7k0m7UxOY9Q+/grXJPrbAjDQimoLeK66/E+dhjxQbgo18/3bx4UMMvSx?=
 =?us-ascii?Q?pU+uTCh/z/EqCZo3AvIJxh2/4RZ2wpzlyyrzaQKNgqf8ARF/JBpHfMFDOXy2?=
 =?us-ascii?Q?gK0s4H/CGBHdZIDQjXeiUW8sAmn8Iyk/Cs2w18YUCvf//3RTuAhlUturg8Jy?=
 =?us-ascii?Q?euR3lhJrywBvtQP7qhkHYe/TLH0dRqGHcKRp9eqpY5p4u0S6okhcpjCC80mP?=
 =?us-ascii?Q?NA3YBmASBAUvswvdwtGFgvmFVqhVbdnGVmBGqYwvsbOhd28orjZTeRlVXk3X?=
 =?us-ascii?Q?g7zZO1zy7BJ6hU9zxtMu5S8QJnR4WKtrTTelmf4Fz/ZhHvpXCfYmFdz5Dfke?=
 =?us-ascii?Q?7ilCi6UVNSR+fNvqAmwnVbopRuR7E9aN6ZAAIpTIrWSma3TyPrbdl+H8oPpA?=
 =?us-ascii?Q?1Xn8S9LZTtTJ46xWROr87nOyeL7EH++QxOjmefz+v2M/KhZ4tGVmRGEMS3aY?=
 =?us-ascii?Q?0AclXE6tbCo1GicktKp3J1wJC4j7wnvXm17Q4VOp+8Yt4K9vFEqTtbqHPubJ?=
 =?us-ascii?Q?JJAN+hWuynoLsfV9HN3sx/PVFA8NRl0Lvqun7eGQgK+it?=
X-Microsoft-Antispam-Message-Info: yx4TnyveVVvi3PBol6SBCvEh/Pn0jijQKMBhjUAJjgNGdZpPuPQfz57ZneuRNsD7EtaPSTMcXpr+FrNVrFpOiwv29u2MbOCPn4Wv0E07D0pHr3fAOShKvNaFl8lbE4zbp4sS0dEOiOSPlEszfNa0Itz7nhLtaWAbbMStLZvbk9NH8d+bKH317QkqTxmRPN+u
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;6:Ra34URWLJS/DloWWwR6uqYtt/w6f5klU4eqRjRpyvFZi5JWDQYD7Kui/Uv/X3hCcvIX0d+TxngBFb1llx4+fAVZkZrpXPCgE6wVRiAEKg2vA+pLLz/ui5QNZb42gsA6TBfWCJQHoDzvY1/Qj53s2qBCo/trlDBEISmnK48w7cDhrAivy6vcn3CKECcgBiW2+JFUQpSaqLs3K3Yu8x/kJHFJJxBtk7EBVqbx7vFmAq65wj2RQ9ZeZlVJpOA15v1VWgGxaoFJRL9dam1qiYGfC+aTRRPZ8AfpOUaeEYSR+tTLjKcpHBKyPs6BqvraIDrn04+X1HLJxjrNOrrbisVUKzKCckTynMZJPZqxf9k7lyD3j7wh474Z2XCDq8rhbwVJxOmThA9QbXolXM1H5IKuKJxP2i80gLdY0fzycWKsKvZ10/Uc562yMhg5d61mhH3ZSWuGMxfj70XJ5LApTYgwIww==;5:S7lOFglQFVN2LG2UhhMHGq17Fq2m5OnieI0Er53jqJCrnIN/HCxD0NxHRZo6/7GycX0Gc7obAvd/Uz6iTWgd+5igBnaArW8HN/Dc/5rIOkRri0FDLkgvOg2Gv1rChxbFauZHObtWhLMxEE9QU/E5SrCNN38trESwnnBCJNLCu1M=;24:K1bZ7XftMXEg2aRLUXTP2ZVmySQdb5QzySjj8v41QI+6L/yjyQDWjnKFmLvj8IeMkkHPmj2yLAOayAy+Qk+fThRTzurPsHY9xoQJKFPF8OU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;7:eEp+XM72wdr3FQaOtebsEq9TalKv2i1TY3bKqGSr+7daEkvpsdauu8Yxp5tvxNov09Q5BOEuawQ6Ha0G+w/+cEc3NhFtZ73i3sEV1eHH4TBUwPYupfvn5IHCgzpV7AznbIcgNFHjHVACAGdqzXIX4nAnOVQRCQ4Lyy6o+42+Ewr6sBguKc1Xb+gRVacHAcf21O9tyUau3kJm3MJnXK4n35atkvS890lInEadOBfkxXZ+kDnhQbk3VyM4jouhrgS4
X-MS-Office365-Filtering-Correlation-Id: 2e2431e4-1371-4d14-1d0f-08d5be58b63d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 13:50:52.9463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2431e4-1371-4d14-1d0f-08d5be58b63d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl-mc bus support the new iommu-map property. Comply to this binding
for fsl_mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 137ef4d..6010505 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -184,6 +184,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
 
 		clockgen: clocking@1300000 {
 			compatible = "fsl,ls2080a-clockgen";
@@ -357,6 +358,8 @@
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
+			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
 
@@ -460,6 +463,8 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
 			#global-interrupts = <12>;
+			#iommu-cells = <1>;
+			stream-match-mask = <0x7C00>;
 			interrupts = <0 13 4>, /* global secure fault */
 				     <0 14 4>, /* combined secure interrupt */
 				     <0 15 4>, /* global non-secure fault */
@@ -502,7 +507,6 @@
 				     <0 204 4>, <0 205 4>,
 				     <0 206 4>, <0 207 4>,
 				     <0 208 4>, <0 209 4>;
-			mmu-masters = <&fsl_mc 0x300 0>;
 		};
 
 		dspi: dspi@2100000 {
-- 
1.9.1
