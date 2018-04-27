Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZqhTAeHXjkVRf14sPfl9C4DqaR/widjHevwVm/2e5wFVxhy95YRSW2WOVR+LvGIQskXmCXj
ARC-Seal: i=1; a=rsa-sha256; t=1524824896; cv=none;
        d=google.com; s=arc-20160816;
        b=syfRsh1S5XXyUrxta/dQ443pt1BsvoRuox709YnMBAIcxlXXj6D+gn3ocai9oeNyWK
         kEaZoVqMNhjgBg4pHOKNAWx6tJ37u03/e4isFqzgdnxt1aA5hSVTCC41/CqDp6BiFiro
         Va2pROiIP1co83ZuxSctMtLkw/fGo1PSGToO0VgcURUupywJ3rTDcaKKPI+kgUxapOmt
         XlvGVs9yLiDPYHg8POzTbfoL63TQ99R7Wvm8q6RE3Hyn1+si5WzK5r33LoV7Mjzzi8tH
         WPpR4gPfcLcPa5MH/pyH6RWwVZnUDABcBUVRaWkOtI6dDBoaSEUHpekc6prVkBXzoVGA
         h7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=VzZe9GHE5YOeD6SErvlgjuYTo+SX5eUYyDYJPgPkgO0=;
        b=AlxTmEBOxgoBp1j9ZBj1WLlC+iHEli8wsaBgP5yeT9pAiecZBksijcMLNE9q8USJkq
         QseQ0bFVMPMAuS5fD5DEbvrqVwU56EFpZntu3Ye7xPm2Vi+dECgKnb2x4Qh6valEw30T
         TVK1xdiYbQqrzMv9Fy/kVsVLGBStQVceBu+fRtrgtxHqwTG+62+44gItBlhg3muEMsBr
         O9sQo/qECWsuhzfhHQHhYxlRB95cXnruSrnnntBGp+l54CvJdHZuCPhEgAGkGImEzJ8v
         SwWchQoJPJtxCN+ZFkrhIbLbCskT/MfnIYDpffUNuo3KxjGj9XZhxl59lax+wquSfydm
         gkFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=b9G9GBxg;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=b9G9GBxg;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 6/6 v3] arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
Date: Fri, 27 Apr 2018 15:57:06 +0530
Message-Id: <1524824826-29473-7-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12)
 To DB6PR0401MB2422.eurprd04.prod.outlook.com (2603:10a6:4:4a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2422;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;3:FiO+exACJmg5oASZ33fYhfu++DpLIbkG3Nzcc/DEe0ri8B7go11MnQL//PIix4mQc/IOoOXAlmhGQd23MC62nJeh/CZf74DobPcTieQXFfZXC9jFaA+m3sDH5sOyEQ1ryYH3zLn0WjbBi4B0z5Et1V5YjHjZTVLb6qCwDGSCcNK3/BD9ASwfeqIL2WxZzPv8/QZ6U9N8vTAf93ApxJ2tCx7CHLbwTS621QA9buPE+f10mi/NOL62uTE2oOP8FFnI;25:hbWhnHVIQNLBjs2CHxQQdoqJBA1LuzLqn+C9cIAxUdpx6v2PLOY6n+7M32aqYHFzY8kQIH8XsJ+6GN5Cil46NgrLWh/AvZ2NtUhMSpK8lWR/mxABo3nFPMCF/gmCA3vJOJMPc12mg58I3J4XqEBOvwB8dX9swcfWyBpW66K1Z2GwP5tR4KGeZCvp2Ds7wJQOaP5dM1bRsNaYla1/6mg5qJZGoRVs1upbZjGQ/MF3aq0liLxytiM9AI2RL67I5vKY70Kitlq7vI0vRk6h+eCksyL3hwdcpqjA5KVLULRlciP9I4PuqsQ/gP85jZeIvD/1vEmYHuFbrjJRRQ8fgWnUgw==;31:BqX2clBXk7BTM/WeVczssg6N3kLvCtOMrb4PZRdVOu7VhSYYfdxgrBtoeQd+R6RuPFytTwuyUKHWXhad3KtJ8O3QtRi5F8GRi0wbhB9x7VR5uXpvHxqAF8g9wSb+TzHfWaSULGbIf1eWHRDWrmmPmfPHk+H0C/YT1feeSuYjR7uJBQ3KMSjgq6hV3/fW4kLIjGse6JoazPgIGF0nGnlbeAH3o4ZtecKO1duDX8yopWw=
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2422:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;20:xNiGDh8cuiQGZpQIqVBRI4LrAYJE53x7CdB/a6xQosQuG13IH2ZDxsucefN3gQRD2nGnwKUnvBO7H7jaiaMtX9jxjipXDRx1qFvPYHQe180tSuKVdC6b5Y9DUxVFbIPaaiDnEvBv0YSN9u2ATeC6tMJom88IObdiecDjng6y/cS66HOsSe+z4HdDg4iPnrPWotLOuanyWI2XT1ytHZ183LD5x1JvOm2GcfQ+ofFjD5p2/l6w81wwamOzb3TXiUIwtgdS1aicFkYqXoaDkMZLwtLvbLiu1/HU9sgDcv2VRcf2QQSKXhXjcVzea5Q+wAegoAEykM7tlIkqMLRvY6VH5fQngDfHr6OgN6aNf78wPLwPrCPvG/Qpu0L3Rj/DIEPxVQMtVjQDRZPtam7u0YqyvkqViW9hqkc52xZBJqU32HOyp/iWcZV0hcXwusKYn4ouI2I7YwcuDTFTr02muKzqanjj/tj59WvOnttzQjAx+Fu6ZKKtmVkG1LQfqwPMKerN;4:wi/se+okYO6ABtP0PJEFlOWv5qlxiLmE/WSyV8Iq4B6INqcD7DilKI1aeoNt7hTqlQbaUm09Ldr6uvAoQ1v2Vts6RtXFmaq1bxn6XDEUOqgPG06GjviYCvmPZ8E2dsHynKluiSUKbO//+rOZvOQU6bZFdP42obz252NHmpVJgaJj8rcxweFIzDaW03Hpkf6ekXlEPH9/xnfrDlxljrGpZN9+VIEJ1lLeSdmBPE6xMANyVkyuLeQLssjZdtHE8MbtZnhWWvRiOc2UM8yCvjnVxEfQOmerMiTy6LnAWKSIcj2fwRbi+6PiqtjTbAUn4iig0CI7CyFbVRFbsvj9sqVH2fSRpDjT1Ex0ZeBMrKPJU94=
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2422EE84CFEF28317F1AE705E68D0@DB6PR0401MB2422.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0401MB2422;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2422;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(2906002)(86362001)(8936002)(6116002)(3846002)(53936002)(25786009)(5009440100003)(305945005)(48376002)(6512007)(6666003)(6486002)(4326008)(39060400002)(16526019)(186003)(478600001)(76176011)(52116002)(7416002)(44832011)(26005)(105586002)(2616005)(36756003)(8676002)(81156014)(16586007)(486006)(66066001)(11346002)(50466002)(51416003)(446003)(956004)(97736004)(106356001)(386003)(575784001)(68736007)(81166006)(5660300001)(47776003)(55236004)(476003)(50226002)(6506007)(7736002)(316002)(59450400001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2422;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0401MB2422;23:6oDFdy54f9BDldG+GUhgpWlHmDNXn/8aY4+bpjH?=
 =?us-ascii?Q?aC6M13AQmLnAHEEEkmFwqGyAT+0Z+amtFZfSi2nMjqxWVytHdekbg2xQp/it?=
 =?us-ascii?Q?FLo/ePjYcFfkwl++ttIxvBpXKJJkN5T6hWNn09gey1yjDv5FxkSZ4bIR+DkC?=
 =?us-ascii?Q?E1E+MbqS7t8LqbN8qLYJMyDyRkvS1HOinCkQt7p0WfGOQ4EFN4ueBr7l4RnS?=
 =?us-ascii?Q?753OSPC4zFJteFzRk0S8Kt2SmCGph0SrJ/NiVu5ULWSjRb/Ykre5zEH5Gj3y?=
 =?us-ascii?Q?YMn8UKGQBs4xDJ+/TqdVGrbHiC00+VJgLDKLNgVVxAgNn6noo7NMSIIbXygG?=
 =?us-ascii?Q?vHm58LQ1DUO2HwPHjrI3ERqzT0mfGJe+w1/Aa5w11kNJqAGGWV3jZllY5+75?=
 =?us-ascii?Q?bEmoRPMZhfZkvgaX0hhNiKTzPcltFY91QYpIZHF1CJ1Wnv19tEiNyNH42csB?=
 =?us-ascii?Q?2z3cXexNuqQY0hUnk/GoX3DaW8atRk/2cm/sB0TWFXDYUXqxrbCcC0i1hstl?=
 =?us-ascii?Q?CMtnmqqS0ZLNFjqya2exJUOjEGY+Xk6u24lImFGluTx4CqDTIX1x/VG4BSRK?=
 =?us-ascii?Q?XZOHONJKhKBxgq5JxdCtYooRm2mrrKel55PLW3fzbMCJTKfxPI4R8pjKKLWk?=
 =?us-ascii?Q?wNRdppGJAKuWxsuFFfgAwVPsc2tt7d4cj0brgdOx/LtoeJnLTjBOOaDQP3W3?=
 =?us-ascii?Q?bt5uO1Ue5ca5kBhPm1dLdRCI92NMAzoqnactN8GbF28OXrF4ycnawCiE8IT1?=
 =?us-ascii?Q?oF3okfLoX7yKFHWu643oBpuksfF/q9oGngt7NF/oIizOPVv7d6MmPrB+GqMi?=
 =?us-ascii?Q?XXXTE/0CTgMlrBDoAV/xfgb5f6pv3JOerqIOmL9564cVpzmLYT+idVmmldOj?=
 =?us-ascii?Q?xDJMF+f09eTZ1NXvt4H/N4IT+d96f2oRBr2V386LmlIaI+M6ZpYlnxtVskzT?=
 =?us-ascii?Q?zc/y9PBJaU3sCYCQaBhI/3LUdfkeGHHOY24XPOCCtIctUZUGveBn3qI7WDBE?=
 =?us-ascii?Q?PoeIq7NlcM6m922MvEmeZT1vE5dGavRAjk4NAQSZV+oSDTvKPX6J2AVV7eqc?=
 =?us-ascii?Q?sonr6qaK2o3yELxaD3EGudR7hl/hGP2KT8QAI+yiGFOgL0za3cUWe6isKJw/?=
 =?us-ascii?Q?hmIHupSpAckwsu4fJLJF+tYaK+U8PfYgHJjWvqDl/vlo/6odgHghucHz5muc?=
 =?us-ascii?Q?FFLJi8Hj64eegmpDz0mZd2yx3SLJ5LpHV9062d1Il9hVZRAthqSQW9rwh7FV?=
 =?us-ascii?Q?0dyVFEb6lMAhQOG6L1K2Tbez1J9zmBTI5dptewCzqi2QW7FRNbUsOGKhAmct?=
 =?us-ascii?Q?xpo/9ocAb1WFVXt9qtnZEDb4yKNJpDu6hBp5Kv7tchot8XZgWBTlxusKCbkZ?=
 =?us-ascii?Q?sN62HyA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9HiyYEeSn9CObzOdpRzrFcH8x4V/VYRGIKf2b8RfGbb1Htt8jVN/4jmqQni7W+V/Q0if+IQFxWnRpiy8iPDKma6p12dxsGRxOigU8CLzcORWINEK32oQM0aVidgutvHWY+YMgvvXgTnUwqtjsddza1hWRpPFTUXiYbDVhZv02l09ts8Axmj/elnzKzQHSoxF
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;6:KeBRy3Fp/VP2xP2dPNsw6skAoFk7eoIi0YCaV7akKXXFKJ9ETRLqeB/YbKtm+sflqyugpYfOmsI1uQEM/RCgu8UrevKtbSFqgyqqQZD5p5g7DpFvKPKCT3jN7jCOXIZJKXLPMuPylYmMB42UeHQSzoOiGJJGXFFui4YoI50llbclG2Z0p4Tq+t7bTvsSld8poYCTK2nbp8rMHb/i4C6uwM8JBN0po9gqiwAFCV3X6vMosZN08+JMKbyA06vRa3lrcZ28c3CI9PGIbZCim7zGC9qA8r8mHi9vBMLKplkrfknSVMMIMtfaUhhDSpdUOUABeGQuc7LKtYW0J1GDPZ13j/nZsgR7+PXjWxZme9Rt9B+/bE+ZWo9Zw68Hmscj21CwObqQSTfQ1IB8EnqTspd8fO4xgLVU06WOTJNyaqEqL4wFw6pJQLEsX/rhsuYnYBR2p3i1VJ3xj2n3oyDZ4rVNqA==;5:Iy//Mg98y+2ZmZcyE2ZBf0Ar0ea/g0lRbXJEq4q1bvaf+dPaaSyyMN6OByeGIykxrfpfTrlIEFtoi0J/z91x2ITA6xdX/4mTr3j2Un2LyC6DWoVb3+YRFVQ95z7GvmhL58XEcXgp/0h+ZvCg6ceuzaqcRwoBiGHOTPRV7DQnO8M=;24:j35AiuNNsKjgY1j2r1dHZqbAqefWHdxC5n4mYFntmv4DmrgNcuqL3rK/yP2foeVbmslJnas8e64cQhlr6tEO1M+VtmZWJgq82qgazWajruU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;7:uoFa13W9AN7I+JcFvMtCYl9/+7NGa5Ddw5QWH3DYo9tMPRPoU3+suFy71AVoZdHOubXvEEu9SxuUWlBQ2rwHSWN6Or9VeUgZ66Ik1YM5yNvB79kwqEZlWohfdcvmkgJQ4rkeOj61pfyLDszG8P1nFou8p0paXbCzY04ln80WLJvOH8y2KNLYVifYifTpAzlCfUHgFivRtpTYs6iRa9lhpSHqZc1hFq8HCPw76WHFtwyBWSoOou2MZMH9zuV7hyTs
X-MS-Office365-Filtering-Correlation-Id: 9a2221d5-a5cb-440e-c906-08d5ac299490
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 10:28:09.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2221d5-a5cb-440e-c906-08d5ac299490
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2422
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894790375923530?=
X-GMAIL-MSGID: =?utf-8?q?1598894790375923530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

fsl-mc bus support the new iommu-map property. Comply to this binding
for fsl_mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
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
