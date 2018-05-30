Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932527AbeE3U6a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:58:30 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:1920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932289AbeE3U4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:08 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v7 09/10] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date: Wed, 30 May 2018 13:55:24 -0700
Message-ID: <1527713725-1086-10-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(446003)(48376002)(316002)(44832011)(72206003)(51416003)(2906002)(50466002)(486006)(476003)(36756003)(76176011)(50226002)(2616005)(478600001)(336012)(47776003)(11346002)(5660300001)(54906003)(126002)(356003)(426003)(7416002)(305945005)(7696005)(36386004)(6666003)(110136005)(186003)(39060400002)(16586007)(106002)(8676002)(9786002)(81166006)(81156014)(107886003)(8936002)(106466001)(59450400001)(2201001)(4326008)(63266004)(77096007)(26005)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1498;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT059;1:FYrOzJXAR6dCFAtOOAeLdT8KyeMWjUyEWFngCdkfXISKc56Le/ZKiNT6Vu15iMnID5U0WuQ2Tm8+QBJhV/i3S2jlnQKhQXleKLJx/NNoHA2MX0XWUVQBpyGR5iQH+5lH
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR0201MB1498;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1498;3:al6Vgwip7SMjqg+0L3MhKIHZSIUzn+CT+6D9r4YuNvgLIwjqZEqv99yTsEFdzz9dzaj9hpVCvTCC169L8ZZ87bM1saoqdya7oHSEWI/cD6piwe7AleRWuf4Dt8xEt6Pw2mwOdi3CjcJvMl09m4hFeKV3vx9G3VH/blx3f3NowpX828aRLQO+vsWn8UAfq49tXparad8OdJWJXdJf4rjx226Z7op3zBcXXvnp2NokPgQtmwz3gxbgy3VqblaGfqQywPilNvvDbJNyQik8w64Ldk2fG6VuXjI1yJ8Jc2fcCk9MYebAgVsk1IoUWIArXPLnuzyZFhGMlpV/uUYwDz3d38x5dc9PUwV4Zta5mAhikpw=;25:ZhyPS13wsWH7c5ylaOxQFmY+J4KLCfeE/6rH0WJB8JUt+tFK3qyw8fwXNzzzPS2mxhf+GtsiCj+/dM20pF6wII5GAa2pxRisn3dDVtJhNlgIbLT3zhCWgR+xSRtvjSaxe86fo45YWvL4zQp71UY2Vz/zjTNlSpz+9UTgGEh8VNxxzjCA+Ef4aztVTgwbmRlfTCSL3On46vFcxHbvF8zt5OfsbYLbUuhHgliSzqYPxakSsWlU2tdZs3VS/ymwBEL6456yjzLcZ0KFuncnrs0Pf4h20sXV8k6rLq+h/xJyxxfcdatPL+iv/h5RwD4uiMjXsrBDzL50ngzH72t8oNazUw==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1498:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1498;31:OfHNB/ADqi70Rbd11Ju4OwQpfORIviEVKffzAk1zdZrQjfn86qUJiugn4oLDzkfSjZgcSwy39I88slB8akg/9ah+hkBxsDHtDd/QqZVpjpvTaxAY7+t56WwyGRXvmmTW3DRE5ibf0TKnHqw7L5WKQlQA9hNeLUpYXM3HO9c5ZZAaSlK65k19Ly/RI3n6fPldkgan/Q3z2JQK6s/4A+R5WEFDKV/xnhv2wTW50T8LBi8=;20:wmrjeB3ijaZFU9EjcVcJo2/TQPBHTTzdb7BtWpKVK43BmFiWzA03saYuPvyyRCBqNq1Iwv3zPtLgh2xDIX6tNmbNzPWYsFakLn/OYK0oofwXsm3lRmEBAlOM1fw9UeH3rfTvs1pn8M20PXywCTOs92juPrmdu1zRpIlO+v4lTZgJ7s/A3imDJbFiaoXskU/qSOP+sCdt2gvAiwwLjwRhRQUOZ525iu7a4ITtkj+MMoHycNHpzoeDzUjExkjYuV8SO3d2Lx4vj9588ztw3hcpq992hs2cynvYgz2dYLboEXtGQLTcOLJR6nNQdFvQdta4IWGc6iGsPNRfdNTAItxXUTjhZs4U0OA6uiVezpI0LX9RGdn7S0UN9BpLWok/tO4z2EIbQDRRc/KPTS/DtzKUyYTiOZPutdmqlCJrLqNg6VmdLlooF2Ffw/qB9qnBMQsmvYWmoBuOPBEolDdpwVABXZ/NecmSfDIAY4uWifBfi2SEmAoi/UoiDtHibOR6PuYY
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB1498978849D00C77CCFC90A6B86C0@CY1PR0201MB1498.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1498;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1498;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1498;4:udv9yHqu9F10vsmtakdxbIYE3vP2k2DotEQDqAapFokTHtcyU7PQ3ID8iYHYqjQ6tvUGj2tAD96RrxavVv8Sly+ExvcXTtMMl70wQ3BHmlIckCYsXHZTIoLMIblNNsAqjZeVmJXsurJn0Ekz4lj3bkSiMWONjsBxKcRPggBUhsv5tm9jl8vZ/30D8BdBYTClAyzVO+dbdRBEUETsO4VrfohGIIQ5RPWJjD0hk9tkeg6rE7qDiOYaHylljP4T6hGumT4cLzIFYyd/XwOw4vLsKgYpqjHzwdX/NMksSslZGls68cwQFH6/nPYb62LNMKQH
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB1498;23:sRgMNlpoUxAy0ZwZg4z8o+gDnMpMzQ1eCT2824t?=
 =?us-ascii?Q?FMemA2sJQhakEp2f4EutivfTB/CVQRKTk7JSampWz1SIGi4XNLfisxjsNJbM?=
 =?us-ascii?Q?Yv1qxybLYSf20IDR0UgCnvPWmS79heZZLrV1MsJJ9T7wMiTQHhWhAhdzhjdB?=
 =?us-ascii?Q?IxLpIdUezBCyqG80am79qS6ZJ/9yE7McHBJwFUmbvqPi5+jWua1GDTdFJOEG?=
 =?us-ascii?Q?fT3x63H7rVvxQjnq3/lp8ArAlOHswNVs8SNrJUJjGhHSZ095C93PFqtIuZfj?=
 =?us-ascii?Q?Fm1RdKfyp15HtrlltLmf+y2Pvrb601mK4mbcVynt4gbXinPaPuarUQDgk/6/?=
 =?us-ascii?Q?scaQWn/gFWZMWAhopuzxTPGinY3SxLFJLPw/5a/40XwPi7AMv7heUqd30ory?=
 =?us-ascii?Q?lgdQ3RtFF62a9XXK9jvdzIARToMCpwMz+KSAUZJHybDM2LbuiJtmQz60HaIg?=
 =?us-ascii?Q?X4Ss2oUfYzOVdAjGf2Ct7G9UC9FTHMO7SqrgTnM612pXmtuWUN3igjuEm9aJ?=
 =?us-ascii?Q?znsJ7fHbSgdQtYXQdqr8290hBG0OCBl3GkyU99LsloPFrP70Jxbxc8v8iYwj?=
 =?us-ascii?Q?gzQC6wyHfdD2HPjTZbkd9HZHOqLmcOOI1w9a9t1C+naEenP5ueSKs/rrptkt?=
 =?us-ascii?Q?rx2JUd4nLQlB/CGGfMAAfbH2vGOpyLBGwxksteBcJwZf5iZeSEPReP4Xh5wT?=
 =?us-ascii?Q?N4DbMQyRNK790NvpvbRlQHT9O/VwhHxVs71nDEgpfVTT6baGWHe85MrmUS+X?=
 =?us-ascii?Q?ZnNbLvwNfPe/3iH3dneiw+xzdw+PPTh04eX5VnyUl4j1UVBqxh8t70/JGtyG?=
 =?us-ascii?Q?/FzNKRkN5X7T2y11Ec+d35PAhZvnQq/1xXDNp3SdYC7QjgTboW+NfPQCdPRE?=
 =?us-ascii?Q?3h8PGYrQv6bzYPsv+yvGvNOznyS1XGWIp9CJ4A/ojcUwbCKw2AW6/JvFMWTT?=
 =?us-ascii?Q?vnIErPxRn5S3R3RBzGzjCmycelf2h4dvAxDH326Js3IO47/1DR3q/+3/IeB2?=
 =?us-ascii?Q?Jtr/JlnStL1/vBSeBfNiaTfsJZ8bUSmbqQyLxIQZzfqsMi0O6CdFZWShu32t?=
 =?us-ascii?Q?uqF0wcVWV/BpZIODF8eivllTwRA1jUsZeezKODukF6o2VmizDfx6sSnlkVX4?=
 =?us-ascii?Q?rGU8BHuOkC/tbWd6a/tllr3Zmp+vGraKMbgCD/S67CSW1/7h2+ItnH7tppdZ?=
 =?us-ascii?Q?vEys9yPIHgvkuZ91fRuLlJr7d8tK2k8D+6RmHU8vgCvOyQcZyVQY/hrdxQx0?=
 =?us-ascii?Q?3FkHAntbfZPzmnjHJ3AXTQHGJ3UHB13sdY+k8UjhumwDBOEDJz94MWwe2hnS?=
 =?us-ascii?Q?EZR4nObMPI1CYTkYJ5UpX9U4=3D?=
X-Microsoft-Antispam-Message-Info: dRnw3q3aPPu4Xk0vhbA0Vd2N7YCOf/Fhgy/QlkJ9mvYQP7OpJiyUlMzZF2hpCbofB53nYPDDMZIo7Rfj0ibTfrzDUmuLeRpXEakwIT3o3PF+nR4Djg5OsKU3gY7ieYe0smcZNr/7XpX2hLwOZCWJLEQBcHDhyBFte4lr+OUjfFy72+tDZ/4IYI/uWCvEIMs7
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1498;6:69ciPahkfGMQarfQXKm1jx2GtVd0wV3h1EKPhIXuqDbCBpZr8EmQxn5u4hwxLB1JPPeUO4Ijffh+qiEbd/jQ7l8x8s0jrT+xA+RR2vQ3RPdSl318nMl66QsEngtSmmoE8AeO+A6ozL5nIugIVr67E8qLKRuHk1w3zzFSm5rnutr4BEIJPDRWJet7M8DjWhG90pXniMGTFY7p4FgALxVsEbXtOWLXmbfJyUFmKcTryDU2nZ/eu84Y2ghJCnbhCnDabfGC1sNzlzvJiYJuplNgkcOR803X+0NHRYDbDCntRKYyiA1V13nVLoUF215X4ewSmARqtuwGcaEdE9k/buyBF6DuC+5ko+wqiGp2kkLmaiIb92Z5+8eWuM05rBuoMQkKK/Tka25h5AkG6gYLgBQt9pRnB3HlwFxvwU5gYNRUjTdeM7XWQ79XMBTeO3YTK0FscsdwYPhkkGwov3fX5v71Gg==;5:ptn94yeneXPexYVxqmJT9/sGbGnfUT24hSNQjYTRhs8ehjy1kBWzki4ZKCbBgj7gxr9bwbzBLA+o4cpLSDMmKbjRxqXiMhq/SWo1Q+ajV4j/524dACM2IFRIVEePF+LUKXL9gm4RNW5M6PsJ3LjeMkgnbXBJGDTmMg+3UfRATKo=;24:lvw/7rIQdOzC5kj385IYBdUMQZMz/wJZfAdg9Us/W6elPaFuZLNPKgiHhKIb5w/Y7cJEgNTZt/Ydg2u06BnCz+z0N5UNNtUEDV5rspyjGBs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1498;7:vbYoaweInQwXNHatwRKSoinsEo6e0Wf1sdetZWUkSmeuphzxRPT0hX16d9SZ8YdBQNZbXeIdW4ZOuUXIa8peVwf+szwwaZG+MerYVRAIYUIF3O7UxOB+XMug5HuNLlAirc3WzxItKsKdX4AV6adtSmKNHSKR8gOF+ZroQawtD/+IuNsJ9pdAbGQAFhcQoE2PG4D+7CYczR8HoumsOqHEWnnI/ueJlGaWvz03ve94ADQ4PfQsHP8ysJxouIUn9e0v
X-MS-Office365-Filtering-Correlation-Id: 9ba8a7b4-de0f-4917-c6cc-08d5c66fc2ff
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:05.5505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba8a7b4-de0f-4917-c6cc-08d5c66fc2ff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1498
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..d215d15 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk : clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4
