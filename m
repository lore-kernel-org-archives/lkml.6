Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDYDfU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:35:20 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:42634
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeDYDfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:35:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
Date: Wed, 25 Apr 2018 11:30:31 +0800
Message-Id: <1524627033-535-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524627033-535-1-git-send-email-Anson.Huang@nxp.com>
References: <1524627033-535-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYAPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::13) To DB5PR04MB1317.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1317;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;3:ba9inBECX63rw4J7UZsOqGIJppbTHeCw6B8Hyq7QHBmm9KxhT9rPJj9W/xDa0QmEA0fe1mnkHkAFC0LACS3ZElD9S5grwm9rr/vKJUFMsM3JYYyhtb1QKJf7V1xFUvMaUYsEJtXkvBYq2rj3gbSxvjzlubRxanfTEliMUqai2p1HuyGVkQttCXLwyMm9bxLfZwSlIufztlLq8AXAf98BOVfxxR9GyVyYgLX4Mqe0jIrjFCYEgvs3U8IRyRMqoHXR;25:rHEDvZXadyXpYaQILMm3rQgtf372mujZUFPRM+P+fzwg0WLjqPjdY5cDfag9RhM8IMkrHwFdXHAzgJbxw1iBDCUzcjf10hIDJIP1W7oGNSguf6qX4lFm+FuiIOZ5NyUq5Ueg9RnnUl585ChxyEz6vylU/mMDMM7nfOfDiJnAKUCqcPth64EMOh917GsfSz3uywwofisZtv6fWgaYzfDc+Y7cgVgyMEgCNYlBuwU2smCp3n0Nb0tXzw4aehO2jxvaiXoVPZLkE1tfrixLQRU9Yszj0GC29rFRKGaF19UWMApx0p3ROgyyzSPk0GLQ5XApL2TVK7zegy68B219VyQeZw==;31:XkACCMWoM7gBxb8ha3RVoJ2o0QN4PtP0hwh2nIGYxamPQF0oDCTP2P3tjVl1xWhjEFQ3ZN29wyhXlqo2QJS8kesVNIPxO9kG9uiU1RcUEwjTBCcuRyzcfamkWRI6Ta2qz3AvStlb37lV6kSHJxOghzjOROaXa9A18jzcdIBfP0tBpqnJ5uiAjv0KLy3pLIS5xpkp9i5/hk1RrnYSfRG6rRolf3nz1MQ0zBsw/ykR130=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1317:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;20:RPVJ/rZg4cXNK0et6p+uiiqENjubsxk/II6J6V4Xde0QNOw0P650JzYryVqsTZe0bT+3J9XW7+alnnmL43NZ37fQTnU4D0e90xoCL3VJV8dfAzdN9jSwO+OgmmPDL8clayS9/de8KG1gF8k3C2lyCibKljNtRTgSfgooTNjltDVgi8xOLFje8JLRNQqw/AXbBcfD1WsoEIsoI9mO9h2cfS+9uk86oUBo9f4V+PCzbBw9q0L5r9oo/aQw9Of+6PEvDvAg+tRFQ4eR18cpZ+HXQVFDEKxXgV14CjkFE1Jd3D7171T56FIQHVpYyPmhnAH0JvZ0vShQ8eNhaVx3X+3u5wXUTSHzOMUi+HQQv4sHSevVl3EFnvFItMPUGQ23v7XmtLw24irTOcOAytrMgS2ute1yGmarDC4lQU1/+K8Bv18VtQ1NGXgeaFP3NTfBgy9oj3gYMU+1HFim17Xi6ha8vO4c5mxR+vt9szqwHHIcxvxMneDQBj1nC5Cdwe3Tztdh;4:FU9polnPmXveN5Nz1QFS+WUGhcdvQAjBNQDkyNBRp/poLaE/28E0h/QyX6cBbXCluFZ2bO0oLRu05v2BbaiKvCNEwsVDT1ak0EKMQ7h1oTbYrlxYo/GfsKZ/fljNUM8rWhDmNW9ZYHvbr2AWxEXrWNcvESGqnQLJIShiGy06IOyFF9rmiCbsDTYz3VXEdfj9K0u5z3OjlMr80F7YrgSRkzpZu3JstXWb1IFSmxqKpE35TZTrdVGgrksUit52cgm6fliydyNdQHnRUKgTzFIsOh/DSo8Hc9efLJKFnIaaOG8tYSxkvgNg8KYDpoTzVms2
X-Microsoft-Antispam-PRVS: <DB5PR04MB1317BDC6F954276DE83BCFF2F58F0@DB5PR04MB1317.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR04MB1317;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1317;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(39860400002)(346002)(39380400002)(396003)(199004)(189003)(36756003)(478600001)(97736004)(6506007)(386003)(4326008)(25786009)(6666003)(53936002)(6486002)(6512007)(86362001)(8936002)(105586002)(66066001)(106356001)(47776003)(68736007)(48376002)(81156014)(81166006)(6116002)(50466002)(5660300001)(2906002)(8676002)(11346002)(2616005)(446003)(50226002)(3846002)(305945005)(7736002)(476003)(956004)(16526019)(51416003)(76176011)(52116002)(316002)(486006)(16586007)(26005)(186003)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1317;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1317;23:XNWclvK+URSuN2K3lEvHSTa2KoLKGJL5mPuM1WhUP?=
 =?us-ascii?Q?wv/rrRQICv44XmTL2xguZ2vXr+64aT9EkPOo9Bf5NWWgz2zWqKI2j3AwC48h?=
 =?us-ascii?Q?AAD+fD3QnTPr5wlVqIbmNzrgfVleV9xDcyquyecD/5PliB75UH0/Nvmqx/7F?=
 =?us-ascii?Q?zNRzLIN+UcgJ0Qf6hfpQqZ9ykCMbIMEnCIdTctDSz7VbYqNKbZ1ZR8owbIci?=
 =?us-ascii?Q?g75RHHlYoiZgwJ5VSbCGdEQ4ugWXEUvdIJDbke6htxWjwiGnPpqGawQ8rryI?=
 =?us-ascii?Q?JJsN5yAUwstfvtW8MCeWTSYctpsokeQesaB1tv3vw8sGTO/tJxciawsQgrH1?=
 =?us-ascii?Q?FNBtxrUL5HNEB4f7mfBDvBifLxHSBdGMZTKHp8fbH/6zMkvuX+1cGlzMuU7/?=
 =?us-ascii?Q?wFaod8CrpicFG92fqwdWkV7ZFan+y8EhJDGa2M6jDNe4mjWU3ayKyjcM0j7i?=
 =?us-ascii?Q?U5n5vhstxKNyhD2GjxIQpalUS9f3++tEiFqQNQxEpvXRLSdFJ09tRw+expsL?=
 =?us-ascii?Q?V5odHtU90AB4GPo1VlW4i/DFCfM5y7SVodmPlUyU9xToegEpbK5LTa3ciICm?=
 =?us-ascii?Q?sn0Hq1G7UACaXDzoBuR/XnR4FMrnFZkoPbcmjgFItAXA1FjAEINelENquj8P?=
 =?us-ascii?Q?LA9lamfEy7/R6JQn9E1cvtgTB2lMnWUaVD8xSgBiiApFV9fqTFQb2QX2RcKV?=
 =?us-ascii?Q?W91alaHGRxAzXsvIMpVJX67PUyWmb7cvvU91JmbekAfkR42v73S7/2gx0OEU?=
 =?us-ascii?Q?GsQxrZGKPudA7P+xn+cLzU5XlMNtQWf7rkIj/f1DbxKuHr62SsvLGGoxJuM1?=
 =?us-ascii?Q?MeWj2WWkkKH64I3G5lUf9AF5pzLBaV144z18kxvaRi8rQug6rcFBQABDhL+1?=
 =?us-ascii?Q?hZICJl4MU+qyFqH+bEpETC3IOBmEkjUscrh1p4/NRrhHzoDiACRO/5wNeV+w?=
 =?us-ascii?Q?hNkyw/tEWNodRPovBTdaEUxr0T0id7gC/+3PiXiL7Cl/0NQsd06XBs7sP/Jl?=
 =?us-ascii?Q?txM52JPO948HH7pu2HfqEbTRULBAsyMzOt2NXPhnZNkVn5cvtDWXI4kl1jZS?=
 =?us-ascii?Q?zNa52h9KNeNUbbTnhtZMFJiyifopjSCFyJq6OkCegFiKTp786OE8lmppOY4P?=
 =?us-ascii?Q?6LNcaoPJV1gq0nzcFIyb9A+ggWlVHUNXxlloF686ep6VnqBizh0HSbxdKkm9?=
 =?us-ascii?Q?J4JA619B5kqbq/mXFtXzeLftt38UEn3ByNoE8EHa6AP0DpJGSgBDbxKkqSMW?=
 =?us-ascii?Q?uACaSTnMohDi+aR0YppP9wb2CQ9+BWigidNPP3B?=
X-Microsoft-Antispam-Message-Info: a8H5Fz02E+iMze9GaJ8ZU1MpLuuYB0hXtx2+cenqijtv6eZdL/GnKjdkSfksleiVBPTc5YGfHDDbh35cAhp+nsGD+5DLbQO12V7Svnxw1SulYwN5QIzLEFxJYECJqiE1V40usmHGvYkZDUBcVfQ6t85mA7tYShMhJfd8KR78HCj2CZTu0Ddd3ttvMw4oJk9D
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;6:mjUaWJv1sjQyC45RK89+UsOk/lPh+LXTbFbY5KPdeH18mt+xl1aEs9mKdGfFwvPlNiXcA7wZDmpQmy0oFCOyY+Mzl217p49SGERlGb3bvR7+5fbWXzYQZmNbHMZNnUjwiprdTll12z4srFrxy952OQilMYtpoc+ZHiMjT0kn2kn8zPmxtJWpEI6KSrlDCvoHhgf2UTZZhc9QMXXSCW+CABJpfEZhQPJb/B/nEGBi5ofKtwnSlC8YiRCuGztRXjw0U32aZVtJHummjNDfKbjAKqzCk4X5sPw91RCdLHZ4YjiFH46DnSTZVVsl1KBJeTAF3nc7gIwNHMvzoAGtdQRGemIXTsLBPzmG3kQTV5llHeCKGGjSoSTV4ifBhrDaUJwrvE/IDx8HWUBNBx97INfbyihJueDe8hsUpfA66dlEWPIGYzlxGPMv4ITxqfEWDj1EZiaewZ9rpEAqZ5roNLOhWw==;5:3ZNUKuDK/rPvCizA/pMDrp1QBYTjzOyC1oylNN9U/LsjZ0AJ1RtYqk1T6/eyBssVBdtz/skcZisGxMeBKUeNaJpYmEomDmTvWmxN104peQkmwYRFVlSbD4kpmRVCG91sKp2WymATSzYmmmvhgLdMfs/SWFpPAQsh+QCwJPaERr0=;24:mIL4o5JZP5EPAJnRZF4KsvL5AH/62lHz8z44mEUtLTFSACX0sz+fujSwioICpkoIAQcJe1jbwnafuD4H1uEzmK+3DUEQfx2aWYLD2zmvSuA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;7:agCD0x9yTkVspCGEpWDPxzSnqBJidU8Qr/wEqOpFOFXhLT8QnV4Z9UP0oqjzYPgRCs+KCsj8+K/kezmZeDae3mvylV0cDflD5o4W+W6t3pDzSlxyK+V8wGj3hc5h8/QOgL0VRoJuvNDQh7AcoCyHv0PJcF97a0soca6nm8Hj+hZsI3mjjlxab3z+epJlUlTP5oT/uOhg6sfE1JRQOqGEmC+5tqwveQjWkdMN/0HKITnq6atNoMLadZ6LZQE6IJH8
X-MS-Office365-Filtering-Correlation-Id: 3a7e3b8a-4232-4fba-56fd-08d5aa5d8ac8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 03:35:04.0325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7e3b8a-4232-4fba-56fd-08d5aa5d8ac8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1317
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX7322 IO expander support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V2.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 2caca934..d59084f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -163,6 +163,13 @@
 	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	pmic: pfuze100@08 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
-- 
2.7.4
