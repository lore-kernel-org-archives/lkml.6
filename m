Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx4+KCLfDJJ4jDyO2eIo2zoMBUVVBNOC9RbeZl2DTA38+QFV1R5s6bE5A8aGlMFgDP/Rr2/oB
ARC-Seal: i=1; a=rsa-sha256; t=1523960844; cv=none;
        d=google.com; s=arc-20160816;
        b=B9a5FrSuqZtBs5lEk/yLdhNfbOwsEJbZrc7PsUR7dRTVc4T7f0OsQHNnGPtGC0pzMN
         oIdzU0iTN7SJWPXBlm/AFgKEyWbCdEvW0M0n2VEBZOq4RptCv5fWa7/GOziHb/LHklkU
         A83f0ORMgxaOKrht3vK/2j/L+AkgEOQAxlMnfLIMo4/nC7bBmzqDhSxz5PXI57bP6WXR
         kYCous3nL3xKKUFKowqOP3cDE8JvbYN/g18GKu+Yu7hlOR2VxnuhcJVndm+qBZI72DTH
         zBZwITumAM9vVDjPHvW+nYq4m1ZfoI7Caik8TQeTcyrPzUXM7YIuzIWu0cfkBXFlgxR0
         NoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=8JU5uW3CNNwO/cYCM5A5IjSqsXmxPuzV4kEcpdmlr5Y=;
        b=etMdrDS5FQDVR08mdpSxGDZRGRdHDj3/W8JoxGqjRnCrOLT8kvt05UUW0AG8Y65vTn
         F8V+QD36vX+3n8uYkxiHiOc7Gv2DM2qIqHGHtirBiMOQjyvLOMluLOGlMsJ2JUcnL4dk
         KEKm1Z70PMCD5fif67pCT6lDeykNZLSBsQgxbYD9OwKQyvrUdNr1hfLtee8GkVneKWKE
         NHL2CJXkWp4HOzRoGKUr7i//yRjsSIKF92lD/yNVdrSDujIe9AhkOGvtRr8C1r6t2vVk
         k1RLNTfwXaKHSF/XLhyTViRM75vlGwGBKrJmdtzTFzSx7c1X7bbxEcHifEb5T5Wemag+
         0dMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=bc8Ef94l;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.44 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=bc8Ef94l;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.44 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: hch@lst.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	robh+dt@kernel.org,
	m.szyprowski@samsung.com,
	shawnguo@kernel.org,
	frowand.list@gmail.com,
	bhelgaas@google.com,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 6/6 v2] arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
Date: Tue, 17 Apr 2018 15:51:54 +0530
Message-Id: <1523960514-25457-7-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::21) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:btBM53tQXXWVP4hYadwjvg3Fzb7fdybmpT2SRcz3BJV9cSz8waujYfTn+f5VWwuLmUPDbJbgH20ckA8SeAO9VJrGL6UIIlQJ4ni1xIVnAlNPaBu2rr48NyTaTOq+eJvTQyBlx++SNJGuCS15W8GqAnIGz3Zz3RzjsX0rzcZrqPjQf1Ox1ujWQshyltHL+FbYb5LmhIfvGoLO36WAaknd/7jTVUQTGHZULS9ekXzymrNFx5GaoxcuQaT4HVzsxHJM;25:K6M8BMqj6TDu+S9CId0Di1qHpdICZ738lC70ERaKzWXK34aaecThG9VSYj6SMwX3w2Ams/bs4JULEihKt1GEQPGR9nZ0lJ3HTeNkzsF059hpVgpSzV1RFp4dMilga/+2UWEd/a7JvrXJFZxoVF/CxB0l7yoflgkfcXFuWFwSU0xeQqeC/xb3tN7Z5DYpg2c9Wa5wPXcBf7WnEqpqxS+MV5IdPeHIDEYmFaXo0wOgXelDYu1dbrgnHmTU1839GaqKfSFlqRUzOjxgCMBj2BFNfviNNr4a2TkeOWHouMCWiNar88tm2EDZz5xaIjvsBsxuKEhQUy037kHq/koZL8kyFA==;31:W3VXM3VVkA+WHZIsu03YYJXQoDKVjRRKcRNpZ3xZruMOdrP44IB8htu9vQnoPQggf561Pqk1Nv/EWSXbyXZxJ03HK6yaOvBLkakILMOYq5TX0ublFeEtSK2YF7baziTKwZxrYqrPhMOoiTDvkvN+U+RtxIQcUVhGBpOykEDBkkIlf/nNladSplsD0/kbkNayAUsW3cJvL0Z24Annh2S0gnd9/VXDkUn301DADjrb9Os=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:ksvyoBAFRPvRAnDFOUvjGjyWDfMysh3bQN4uKNY8tcZowde/FcjU493uJWzEjT4/Q2Fa7xUW39ZtgE/+vhXLJHut7vNls7VUMkSeJbZUmPw6d90Uckij+ErTV85QHFay0P+iqU/3qgohXUPaHnTFFUwgos4j+uG+5hLuzJKOHV01f00St8+hM0kBSesZ+ZPcsyc5569D07I1u/unAv9KwsmDk2Hrqfk8ckD2CuVDWHwu9S1OXGYwBpYuwC0duB1LHl0WcASULkKjAsLI+LnEwjfqAClNyzDyrW3YP1oCJ0AHIio/uGc0uBDp0NSMyPc9kZnn3UGXYvrCnynYYIyM/6n0QzGU1MAo4GNQwRVlSPMOpECUWf3fdFdGxkeDmGN8sgWfIIMUxnH9etkHcLczRtH6wbV9a6VQ81SRD4dtxpVABh//4KPHOfbvO6qsGvj9VXWKJDUH13l6Tsxju+ZwWqwyoAkxX0w0+XtNVrbqnupYbb5UDwJdJIqO6mOugNCN;4:dsPYYHoDfXYjCcg/mBFV6+vGmVYDYr5XoF0yiGjO+7WAyfF5xa1/5hDWHA3OYrVi9fYowQOIFUAYK8a1zT8zYyx62vcGEUSFYkbXR/nxEAdxt6DM3oG6ivzS0lGXVK1PNYdMUEm5fQjZ2cUxxnfdRuS/018sSPG613n0CBNHPJ1j9slnltSb2trI3jvaWhlFHuJgSjTpnQoI9HPiJEzK8zeE7vscX2uN3iJm6l3J7t33un33A/obvPJsd/1hHEDfauDDpl9h6qGxf55XGeKX744bYujdEmCX19uAiT1XBWIor4NNVJdzbbgbpzuE0mdjYZMC3OgYGfwd93aPgmvqTysJKeZu2FnGsSiFWz7uA0E=
X-Microsoft-Antispam-PRVS: <AM4PR0401MB24188E3788199894926EE537E6B70@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(6506007)(386003)(2616005)(59450400001)(446003)(11346002)(316002)(486006)(97736004)(956004)(16586007)(76176011)(55236004)(6512007)(186003)(16526019)(44832011)(48376002)(476003)(86362001)(575784001)(8936002)(7736002)(8676002)(81156014)(81166006)(6116002)(3846002)(2906002)(53936002)(50226002)(66066001)(68736007)(5660300001)(478600001)(25786009)(39060400002)(5009440100003)(4326008)(47776003)(36756003)(106356001)(305945005)(105586002)(51416003)(52116002)(26005)(6486002)(7416002)(6666003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:4jenQ4CUdL+NOnfrfetNw7HsG8/hLsNfOqHatd3?=
 =?us-ascii?Q?n/Sazw66TIZVQnNbNqDqPTNGPq80OfQMFj9QoatBIyaI5hRt8h6RMbEEGZ7T?=
 =?us-ascii?Q?Rhsk4Y18dcZoYcuGHP+PhWG7SjV2Ab6f67/SiHNjSx1XJIQhW1PjpC3gwbcw?=
 =?us-ascii?Q?hJ/Bqxw1CC4wOCSO3QfHdnMegcF6D3djVG41iZKZ4dJWSO9wvcFeoDw9pNUX?=
 =?us-ascii?Q?ZQLTvpove8VyHqt0lHOIetL8KitF95B6dj4aNRt5orYMCo0X60cT1UUNjqqt?=
 =?us-ascii?Q?gIexfpVBLx4Q+4VGJW7qjAZqSZZ8Ck067mIIsWDQh+9KXbyt3dBCETiX0Y7e?=
 =?us-ascii?Q?apkIOOutjC7NkcT8RAW/nmSui1ny0ypiDUiYvBe+32q7fkp6bmrfhqT9JcoE?=
 =?us-ascii?Q?749r7YcZYMRW93mvLwaEqIcVqA/Vh8jA9mtlmjAju0YlIOZxjo4FCqO7cLKt?=
 =?us-ascii?Q?semZQkloX8P6JJ3EmJUMBzebIRlUF2uClkl9IdTwtqqpHfR4zzJn7KWNGaU3?=
 =?us-ascii?Q?IWXy0ZId+Z+7SL3w9bgfjOAtIXJqEtmt8eJTh0DMUhTkXODfsGGN76uUSLaT?=
 =?us-ascii?Q?iCWuI+R0CMlTpqeOGGw4cB6ME3dT2gqtppj3zkSnJ//7cKlTWsESjQFmI2Xo?=
 =?us-ascii?Q?QpwHA74VTQ/2Gi1RgRTsJp4DdDTxi2Bg2Tsr/8FuRy2B8r+0s8CZ9SXcJRz5?=
 =?us-ascii?Q?VzycnYtb55Veg7blPaj9y0GFoxGXUBYyYhll/1kW8lKNLMiCzDGvqIPcDLAE?=
 =?us-ascii?Q?uPifCIKZkZGviKhkT9VWbuaQpQKMCzoGh6jZQipy2wgt4szfCk4RBWyheo0w?=
 =?us-ascii?Q?50/AIZAq1vSKY6HZXfSbSEmEos5p64o8pTu+Uv3qYsUwqjgv6sElfNAkmIC5?=
 =?us-ascii?Q?ZCDGfvtIDw8NaBblCRBse89ghPzqiXO8qYuT7eBHhYH/l7KhqFG+YYR/Yc1p?=
 =?us-ascii?Q?3RU+4FbWa5Y5wQC/5b4kASGQ3Te4i5+Txycf+OdVxO29WKG88eJr0TttMx+T?=
 =?us-ascii?Q?bj+00gi8ISrYqM896/oZ/H6EjtMTuIHhj+nEpiygrE1W9OcsKhGKab99dXLD?=
 =?us-ascii?Q?6z8070AkbaRkPkV1DDK69uAY3nZj54NwpHSo6jQ/tpLR8U+/OrIguVNSp2CK?=
 =?us-ascii?Q?QSui2HkjGbdCxUn9WuzzEoOrXc2AegP3AvT60KR9bMafZBGqNwtSZ+n+rPsa?=
 =?us-ascii?Q?KZsH7KR/mwOd8twaKK+g1hnYf/gLu31hsxg4KZd7IjrGoemlqh2lKUljHNur?=
 =?us-ascii?Q?HTqlJPhfIfEqVRW3QMOJ7CkoY9tf1dNGeNE1acfQN4GZukzLemFlRMwcitx+?=
 =?us-ascii?Q?GqPxlt89XuTTxMsiOyhaI9CXNs03A+b8vNV7NnTbgOOHmkQTRWVtRmoPELqe?=
 =?us-ascii?Q?FgZbkcA=3D=3D?=
X-Microsoft-Antispam-Message-Info: llMAn5E5KuSLk7N55qrl+vCIwFc3+UiGRqsuL4Aho275T1n+yIbnUKayd/FKM6L3Id9CUVTV9+3N7Qp5gTC3l/ZMnfXSdB3FO7QYb4kE/2UIZU/id8vESvm+zuWVMgAKXZrYsB37JUGXUMVfyyxlcuuUVtpgXUBNq2IaM5Zi0bl9/tbnl2nFEryJtyFeTNtq
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:bOT8fCJn7s2aO40tIeSZ0AIrvkdSc8MS6QliGteR93seYh1Qd/TbcFuwubZHERFUpK6Idn7+nYxg50j4FSISwitb3XBbsKfton5IuLvLoqD0eyqPrABOWsv0dJeMt0rNeZ0okuEPbKJqt7b22ZqVnyKFYz7QuA2/P/YaaVO6SnQji2lBVG5vCLCzbipFyv76yTD8RMcLVRpxudRB3lmEX5znSnuExi0IpaPp3BvsnqR1aIBkSrUHzpXNQ6IaA/vPkmwVfRzf58WvQm9RLV707JKblXyGyyMQkWrm9KGiiCZp5K8luj+F/ridip4Otn5lRw4EQ9CVVSY6Db4GIRftEiQ2ORksYG2fLPA1xjLG7cfhqlDH/QtvJWMpOPu8/m5xHglcHqSkHK2YLIhssXVXFEAzIZ1iJUXUXWClDzQUpL20hTCwO6VgKaviIOOGOEYm3/75Wup1nfhrN96JEmEyVA==;5:k5YtSzp76CjUiOkhAPb4VL9Na9gRs1K8SS1Oda4zrij7bp/RD9tAbIFBcT1CGbaulGe4KUrDj/hCMlVEqWzkvGiQFsiEbyJ/jmq4bN1HD9zCdZnwwExbg1HdNmx23MmXOIDG7TlS2OsX4Z1LacXUcCZUccwA+Z8cpCXLbt3C93g=;24:c/bSAzArA28VfYu2KRmsPaFIk9BWahBuLGlZHx7y0kIY+HTCAvHZhoLYiYXN4UpIaLokYfeQi98N311vleImEi8PqNnKQLE99tJSGMwj//M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:njsPYSnx7gRTearv5BaE/FOEaG54eAJ5dVUwQu7lNNvY3FCZwJv3ZV615t3KsXMk2KAZr52Ow31P2Fyxfg5uCFDNwrztv9bJddQzaZgpxDZyr1sdm24dLR3/iYlJNDi6595eljYmh4m2t9WnMmifWp0VxbE4mY/BL99bACSkvEPSYGbdegfMUqSF2L/KkmZG0z4fQ4jZ1eABh+34ZRdV5ubz6pBwd40Xk85EGJ2L4DUKgHhg0C6aJn/Tbnoyj3QS
X-MS-Office365-Filtering-Correlation-Id: c5fda717-92e7-4e8b-f2fc-08d5a44dce35
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 10:27:17.5133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fda717-92e7-4e8b-f2fc-08d5a44dce35
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597988767052217733?=
X-GMAIL-MSGID: =?utf-8?q?1597988767052217733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fsl-mc bus now support the iommu-map property. Comply to this binding for
fsl_mc bus. This patch also updates the dts w.r.t. the DMA configuration.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f3a40af..1b1c5eb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -135,6 +135,7 @@
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
