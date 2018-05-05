Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEEIe0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:34:26 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:60192
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751248AbeEEIdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:33:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, haibo.chen@freescale.com,
        fugang.duan@nxp.com, aisheng.dong@nxp.com, yibin.gong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/7] ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
Date: Sat,  5 May 2018 16:29:18 +0800
Message-Id: <1525508963-7986-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:eQ63hAArZ0Imy04vqxd+CacIgAgjBG11NJvKogoXvgxn6megL98fzALgOdR2Wnmgbdk/ryDEFVK148zSWVy3WZCI1TjbxDKWRTkXoXweM4l4XS1k6UPOlYdDcL7412b6q6GccJklpgSaGJI6mNQNGdNIFPWppRoOOCtoQHhr6D3OSW8Vsj7K4o3tqoWerg8o0VDVpZgn4eLVKqcNPSQlN9H83k7FyyL0R5ndXk7pkzRCkB6rjI5+BHZ3pH8hHJhy;25:4VoRdeSLzT6qazw3H/Wc8X/H5eXI5ncndjw5S2VR0fmXG+ZdFNbHfKqSTkfsuG0pr68OtRWPb8TYMLYNh0dFVajmKQq8oOAIo4hBWUjq9POr0VgJRBifB7Z1Ele0G+k6EMtsjm9g+7XrJEZL7fG9YgK4UHqHAHkDriH6QDUcsljSDcfm4phBKgPpsBW99Y9A9vLVX7GEIP/XZxmqEKhRLoUOuFszbHbwSRhvJ+sNP9tjW05ewenTlZRnk0Jj+vBITaoZyCV6U8l04ADvsmXbFHNRrAvn1IGBatEXS9ad/KZhBmX8zqUITkkKDCyammfo4sKiFqhfPKlVbOR5wS2JrQ==;31:+AOhzAQSch9gZkr9pmelf5+UqV/qMeCLu5uQhwHSUfVd98Aw6Ztpu1Ug8R4gTRdNcQZg/waSy0KxplNjA8kwHKR8IE0P6qQOLf48X38DsQaNIrIFOOp3IEZHJH914OX6ZyqByAgkj+yKbx5UfHI6Ju3++nzGPjZ+aDUHN1SZFqzj7EXg6N4LX5g9RySyGgB9mxIEvUVa3EDbS9BJSEae5HT2y9ivJXOiOo8ce9YYQss=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:sG15fWr/ikwaHze1XeSiW+Ne5+ZtzxaeKf9BJenOviI9vUWeyS8Y/TWhvsCPt6A8jhU0f9rbag02DKhMN/ZKOiNzKscg/LP2mFpGcq7PbKqgoVZlXCRr1ya8e8DkfnnzkKBBuIrpQG4++sX2o6QJMOr9M9+hmPhBGlwK1kzz5yoACmxhBAtriQNvtqennkIwjTnqf8BalnmONwGpd2kAF1mxLNAw107F8BuWRj948/d6S2fGWAIyV/O1Vs7yZccqzIbghwNtzBHwTFPOXywCV0D6thw1a+Jeh3Ii2W1cKbxSgI/vxpsvZ7a1bi6Uc69irMH2WX4uoJ7dPh9Vrint6EC25zFLyrGRoGkc+wuRjtSSgdKYv/aJS0C7pCWDBKvd1o2WdwU4K47lX4vDc1TIvqrntUa4sh7E0rfKptefcsXKnIdq5lpFBOrdK00axQQZRKlS4kc47CsbHVGRBOpKMe/AZfB1iWC7d1fuYcWHe9vIoLCSGUx6SnVuogrPXnjZ;4:UYNDU4TV7CX4m3Pu1EL8Ag+AnbTqT8cvqxxvEft2gKQbFdz/gwVdM54GsY1pf83VOIIZm4CDxkb+nhUjpRv4asX3u5P+ACyIv9lK4367Xvc2XRiQSEY6itcbJi5rvdi1anKDqb16H12lOPNn/QWCp2Vgazcx3twOaHiestH3Bw8sCA3g8IWhK8kgn4yPDU9q/7uqfUV5VNKatn87X+zSEklUzbxFHMtsSgpolrlQQXfPW7KyW4TQP0xKHaGtlU2tDNuMTqNY0CPCJCig6tn15QC47kVmkrqx2o+BpW5cWyJbo52uZktihF8xhI2cIxuX
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315D9BE3FAF05C23D4B2671F5850@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0663390E1B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(6666003)(53936002)(81156014)(68736007)(6636002)(7736002)(50226002)(4326008)(6116002)(16586007)(6512007)(3846002)(8936002)(575784001)(186003)(86362001)(97736004)(8676002)(25786009)(16526019)(66066001)(50466002)(52116002)(51416003)(478600001)(106356001)(105586002)(26005)(956004)(76176011)(305945005)(47776003)(386003)(2616005)(5660300001)(316002)(81166006)(48376002)(446003)(6486002)(6506007)(476003)(2906002)(11346002)(36756003)(486006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:35KGcd8TJJvmu+Npgf6LJswwZBEsmiXfGU70eITtv?=
 =?us-ascii?Q?5fw6l2UzNCuca2jtpk0wWVIwIWf5ZrN5HIipmxfHBhX6KTA3nZslOevkzXWG?=
 =?us-ascii?Q?FlfCzbcBwuLlqLK/hyfb4WWIgPdGN5b5KlLeJ524kYMtmoFg2Pr24xsW+wYN?=
 =?us-ascii?Q?MUjM6PdmDxXjIFd6bm8YOMpnEv0pOuWWfaHIsOhm7Om7ETNKv3keoIjPYU9m?=
 =?us-ascii?Q?cXCPhC8ukYMw25KGe9Ty6z5WUUPIXj3lBVLO41T9xwkB82VSNUKENuLCtn2b?=
 =?us-ascii?Q?WlwgfY/dszsoZkzM5Y/mo1ckgRXi32kz4H2kJCy1R9Slk8F7KLoWPdEbry42?=
 =?us-ascii?Q?apC63jlrOgOn42dTXYzKys7TglFVVtfMe970Fu3JpqYl/Xm6SwwqYwVFeBi9?=
 =?us-ascii?Q?1fyZd7Ov/cr/5Cm3gfymU6fL4tKwMapiQq8dmHybJBK+yaZFI+pShJcnhRQR?=
 =?us-ascii?Q?iy09r804dXLzi2wBt+eY+bKJiH0mTYOKETaMMjGyrwGal/ncorHxdYGyZcld?=
 =?us-ascii?Q?FlXI9CmD6dSMJemInnyfSBt47oBY9a6F4N/k2bygvNXG/u9uM8Wz3qu9jT23?=
 =?us-ascii?Q?XNietvDexeV3Q2ekYcIzkC4WzxSYRrCNats5VT/CW0p7ITpSjSSOcg/ne/Df?=
 =?us-ascii?Q?zFw6v89PpSWnGb2cxiU5m00YsvHXtyAHmGONxDRzC5f9/sFgXKh011eRmUPB?=
 =?us-ascii?Q?nMHrv9UgVwlPKtpP8keO5PN8dl8yTSGIZXCNVs5V2aaVPPc33TWEtJYSRn1E?=
 =?us-ascii?Q?wfyPTH6FvSclQvR9vdoLZmBupcMdAc7fy9KkNAS/lYtM8bJkFim415NntwIe?=
 =?us-ascii?Q?8Jne5QVj6QgzffrtYlYPIPCMu97XWp9veaQP3fCg6cOWbbUth4k4Ho/Le7VO?=
 =?us-ascii?Q?TSABzbV7Zxm5q42DsekRYnbaRfb0T44xWe+DJ0Gmd/dHJOIYLC1I2Keigom2?=
 =?us-ascii?Q?H08YwnS1lhG4rrYnw3oaQRcXh0GhDOIY2LQ2SnG/Oc7PcTW+gwXWUtZo/7xZ?=
 =?us-ascii?Q?QMYjZc/z9wfobbIhSpIk5yK6F5A1c2qh8Aryd5KMCXTXsoDbr1PKjLp/eiss?=
 =?us-ascii?Q?8no6JklkrGF2ugyAC5JKjKGG4K1KLMbML8jkLsQ5Z1kAYh2XjrG5WvKNTT8q?=
 =?us-ascii?Q?wDjouXfEmm67LeAxmEsvf/mO5oESSuMkpfIcOZFNKzzpyuoLzMwvh9TAkMa1?=
 =?us-ascii?Q?EnxYYJaWRi7npreGGPHUjelhUw+knv8a4lT2XoMeIOD+SllSja8NDqvbQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: /n6UeURMnc/BdJblitk2O/syTsPuGzLIfKhasqubnvYX1SuNGsKmP+aLH4VMPVvSqPww5NOpaLO0KCpoKD8xMuuM3YnBwq3D14h6ZA+Hf7HD2sCGOYkwRxIOuG1burr2+bYMcfrnpouJtwJ+VhBqzwyTzAsr3XN0CoDc7zY+1oDUAak3vUOzADMfxD5vCvez
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:vcTE1s42KpjqrkSYAQKcal/6/oD+tAsUeIvLlb7sLA6CzZpmgQo06V7zunAWyEtHnaEjEO9ICQLKtqWzXvLQ5mYaLr1QL2zWk+agncEogvDPtPpcrPZ6Sbd9cW7MUogyh8F0cLCPPc34rMD2gknGR3ZiwSfMdnI/3xIA7yawujOVeA2TAV1KFohKfP73wwGfNNMBMZcsTpgjQe/w2MdNQAsM02rO7nAxrcCIXSym2dRjJ7sM83UTpb7ntXM75KtWX/9yyPlkdp7m8uTmohaba0cHM0Ut5ioO7+nJMnR3W5FqToVjosrQimGtOm/zWdU0ZCmvTBeAUm5hJnRWr4DotnCDWf8+6Rp/R7V1p+2OJx7X9ayPvnxNVlDVMfZw2tzL8ytEJ9mZ+gfUxUezl7FNU24aZC2Ifv/XsnQc5eWnVMnEygfgOPMnEk9KCczkoTBxYpsQhRD1yjd9uYs3SOCWsg==;5:cASKwNdAwiTDJ/Ay3o3fMl6q87+vHC5kL+hS9+2ot6eOzQCe7IgLTmLgi7eVKtPCjS2J36JGjiUUa0TCd8tzGDEN7ABktDc8JTJdIPtIy5mpNQ7jZu25Sq1QlrPOcdVXRPLn7WNNjLzsMYiUcH8z/zlLNVNlwhbUqsrKSEvOWgM=;24:CdZuKPUgNHdQPkIxjN32P3B6EAVy3RaDzXDUfZ+BqFd+QvgANpHVBNEzIfnNKPuQCFx87gV/+WgI4lm+jNg/IMPwuTsha8WcJzJJI0CmRks=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:8iW2Dt08zfClnKdHK/mekWJHeEjMckNtyQNwGnYx7oatHVzRXiwsi36GhOCVUgUx1LFdnW/onrvWJnKbIaMuHKESB25Km6DxN3k2xl3TThUzsmceuDl8NmqneVl37FKodJCK0pdTTGr6vvSQUAigzdQJISqhwMDv5QMjigQXmzkyFrf0BvOfMbzp/goGEwpC23O08hrGbaFJ8Y1vrJs1yk6mP3kH5wgUo34bBKxn4976nYPlPjbTyx3NTcUPAFF1
X-MS-Office365-Filtering-Correlation-Id: cbf0a41a-875a-4e19-6ab0-08d5b262d008
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2018 08:32:56.1569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf0a41a-875a-4e19-6ab0-08d5b262d008
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX7322 IO expander support.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 1d8cf0f..ae253af 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -254,4 +254,11 @@
 			};
 		};
 	};
+
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
2.7.4
