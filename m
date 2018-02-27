Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeB0X4S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:56:18 -0500
Received: from mail-by2nam01on0070.outbound.protection.outlook.com ([104.47.34.70]:58784
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751589AbeB0X4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:56:13 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
Date: Tue, 27 Feb 2018 15:55:49 -0800
Message-ID: <1519775750-21297-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(39380400002)(2980300002)(438002)(199004)(189003)(107886003)(305945005)(478600001)(6666003)(81156014)(50226002)(106466001)(50466002)(36386004)(110136005)(2950100002)(2201001)(36756003)(54906003)(8676002)(47776003)(26005)(4326008)(63266004)(336011)(316002)(72206003)(2906002)(9786002)(186003)(16586007)(5660300001)(77096007)(81166006)(7696005)(8936002)(356003)(51416003)(106002)(39060400002)(48376002)(76176011)(7416002)(107986001)(921003)(2101003)(83996005)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1309;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:b51Vkxu2FIwVeG/wrZB/Y3H0jr3xQ5WsTrNWR+CJPbnudvHojwx7P4ZTryuBfwChhx6tHtoUV+gHrI6zVzO2XvRVzpvbFP9563hum45IpS44ujfdKuLLtdxUHnUQFS6q
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 084a95fb-599d-4997-e6bc-08d57e3dacb4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:SN1PR02MB1309;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1309;3:3sItCVEeXcMhr/R/FvLekuKJMjj1YsvNrbzDG0My16oRrlYC06SYm4O21jGH5Ebc5h2pn9ScQAc3yZrLKhNpAK/AV/u5Fo+nPQ0R/TiQN318n1g7ZlwZA2tZQIzFb3ZnV2w73RNfIeDIlV29ixt2PhUAV6Y0mPqpUBttfSWVne+hF/ASPsBX+uhyFyi89+JoPciUmKv6eDgh+vmWgnuIIGXJUQzFNbuoA9yJ3uXIM25StqBFFzcn4rpkCEG7ahcEh22PThGebRxwfBjIDRR67yTXAzATDPKJkrTQuAsYHAQjqAABxm7wJ6m1lm5sI/N6kMV72m7ffVHRE14b1yRqbTZ4JchBGl2umbm926zz2yE=;25:wJ+sbLViYYu28991WjStlHoKiwoesMjvQX4z7ydxQzbBmtUmAXGW09Wf6Xi0tNqlFMFQDk/zgzY+wFQLJxvoIXgad8E3Ss90izxPTnCxhuIfOf1eaxFNX6wGHQZX42harmNUrQishmvibxVYXPykP7CACfErfoBWUWKitC6rLTEmLL7+O7Z6VLPt5yS6kl9NoQRcLBhUqogo/EopjSYLgPjzsFUbwlurqx7vFM25T1l6Dzj3xWc6RV6RNrHziOTOLWeB5uzVeS7L3fnkwaK9OueFX9jCelMuKK/zXXlRlcUR3zhom7ACekrkHZOLveNtEf3plHbMI98WZt9PwuBoqLOAN1dKTn/Mo5T2BAsB5oE=
X-MS-TrafficTypeDiagnostic: SN1PR02MB1309:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1309;31:/Ina6VbVGGov+IRwVOqUrrXf6yoJZAlBt+zUTs3xm6RWkmA7iShnB+KXcJbl5m9sawJwnsamw9qZNTXXxaCx+R43MTWF/zEwyhdwJnEdFt9Uuc5TSYMxk7N0rldBcNoyZLONekILMCnRsWwLQuOWsSri9WPga6GPLTcZ1dpsW6qHpQlHRtih/xACXiKspNcpeyD1LrX3jS0ugcy5E1GNloZztE858HOQNsyiUzEGzxg=;20:nHSEohTHL2t5e/LY3K3rGfsFf5A+XeuYH64q03Ggl+j2lzkUp9mSf8LqNjsMo3Hqxe6KgksxmXSd+vX5trLF5QNdsGF6/FuwRsMGlVTVpm8m+BOlBWHaZ7hWp4TbVuTl+iSIY2ee958aiHoeMljq7O1j/3J0FijWgLaSckffwwW4P5+ym7EBN7rwXUDo+EOFbCQEBwrThR0r9cUtpfFarhalOn/mQxhdYgscRMvhl+XHg/ySW2JBX0uG+Vtq2gV0N0JekKXkbUbGXy87JgR0tn/5lNwrD0LFvPtq58diDwL9sL/1zrx5yXyj6aQ0FU7w3h4OdySoCyY54RMwG4T0OHmhXz/GQ9A9Mhdqw0jy2C5k1yWFtGQQEsqxxOB1z7exxweWVrXJKyOGz9UlhcaF/vHh1rDI4xnxNi9WMqAg3yz5z2Unw88O+pKwrEbcsKDLboAes9km3QU9wba76zoWvetQAi35rukvhKh8uAoShTPGGibcwPeGv5ezeY0H6t7M
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB1309CF56C3B258C7AFD6B8A8B8C00@SN1PR02MB1309.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR02MB1309;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1309;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1309;4:kBlgQfuDbxzvO0JUhtaNmEv4QiaNW3BTZMgP6hGXFDRaWnfT6NXGLkvb9rFIVMulsAzJMRSLmE3ovXyklbsRiNN1weEZnetxsyHVDxAzjGc5205jgl1LBrUGkJ+sCG9KZWxS7vDyCwGgASQYlEagTcqU/H07qLleE6ElqSoBidAy+XaDklKBcnrseiemN6MItq8oPXut+Bi5ws59ZuNs5gsqpykfPmyTOKl+ycCDWakAAZfY7s72y9UnJirm6NxqI8kQXsW0pVjBOxnwRtxfu1MH9p0A/7EalWWXGeQmwIGsstJ0hvpYr46RDnERcMFG
X-Forefront-PRVS: 05961EBAFC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1309;23:x35yFwWdbYz68zRU9AKsGy2q0/72g9pAyvVUTMaBw?=
 =?us-ascii?Q?X/VfS2cxrm7dgJikbyNvTo7pcvBStyaKdEdSjbDjiNo7MBDB2nP+nLpi7RpQ?=
 =?us-ascii?Q?2pVBy0oiyroqsHe/hDm4T/vYqZ675GW3Z3XEWUtg7Rn1K9QMA0e/NQfX/NLA?=
 =?us-ascii?Q?YP1j+H27f3dZAqFBcqHJbaKD1x1VvxCe8/6VHtrkkem5x85ZDh47SgTZC52e?=
 =?us-ascii?Q?d/rOBDlv2PoQwgq9y8eIXQ+LQTNEBKsXAuGw1r4bhEaltYrzmMX0XVMfDdF9?=
 =?us-ascii?Q?C6/4PBj/FCtAo0yxTCHv48P/lixVipEPi3WQqvdhT19B8E4Xcyg1Ukb8hdRY?=
 =?us-ascii?Q?BvoD0zrO1m+Jk84GQ9ccxButEyTrOoRO+XaClNJs1Kv92MGlwPSuHgKTYhCe?=
 =?us-ascii?Q?r8VdyLosz/ZoJ03LWvyHaOPRR0K7tVM0k7z3myOTIn65i0TyBGMIOCWmuALM?=
 =?us-ascii?Q?SH9yaRRgoi9Xf0T4M0NUORRg0CJ7aJtbtvuPyHcDae/SmuuwaIsy7SEHUumB?=
 =?us-ascii?Q?dMunv/dizERwb3GZhaGgMTK/ZC8w+r+dSVxWliWbCOOz9np7eGuPkreQvwMj?=
 =?us-ascii?Q?KWNoCqVCF9JQlQorks2npfhaQGftutVCM5D24tUxlKJzBP3ihB4Mzq5cTWgt?=
 =?us-ascii?Q?lFwpIw/ryiG0nZvhqYQB7Ulsns7r9x/6dRvAmnbGeaSPwXcX7HU5QunJtGup?=
 =?us-ascii?Q?MXtjUfjonkQsQqLb3yfAjmf2A/7zYMFiDTmG+Xzt7K460EoGRjYYZpy7pEBU?=
 =?us-ascii?Q?QfZD7cuKleKO9gjT4ZPS1LEyakyVjKPm3VniRDF1Bz7YHYhI6iPYQ9sEOrbs?=
 =?us-ascii?Q?pY8LkysbOpYsLgozVDBAq/oixtDZMaIb0BMiqfleey6mljiEwqOXU5wjEHK8?=
 =?us-ascii?Q?pPWNPgtg3gyud5q1NnMeOgIIgfV7kD9vwro+xcFtz8YyKZ176l53a28zPcOX?=
 =?us-ascii?Q?xfwN/QBoNtji0waIj8Wv2hRlkXQb8pBHv3nLw9cS4JLYMd9n4f2MUF9Npht4?=
 =?us-ascii?Q?G8Y53Cf8TFFV5ewIK4hxZgcGjT79whBwDZZ15YmcM7kQuLXyYMPsm1Ja+2jN?=
 =?us-ascii?Q?SlN4lF22v2y16eEZZl0yfhhb6zkjSUwroVmPpO1DaWtCwsXoR0bux1a/Qskx?=
 =?us-ascii?Q?KwewBif1MbMEOIRHfDy1HiMHV7CmmCkRVMDJFseosf4ea78q+XCSWzzswm3+?=
 =?us-ascii?Q?SNlkMJuw6AtsQbvu7YtEzstI9qzAOpxeIZE9Wi5RzOjqHWfZkd6/WyNXw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1309;6:NYUrXqbtcw+O7Vj28XmiyrCiNGtSyLfjEb1dd0HbqJO1lIE4SvEu/yxcbEZNvqnTIMy4TssyDxGO8K8B2om6/c8oS5lD1j8sibVYgG55d/NSM+noOe14urh99xLEOEj8qj0qxowGk+Yr2fMONMj8AiloWhSEZ/OzHk5g54bb81N9BFZ0jg/ybiJhQ2qou/jR+Cjl/Oi6CncDdrRyamk/OrIZq+2XMopMELIoV/UiMqNF0EMFF8s+Ma8PLFn9PsVC6wyWYb1Cdm0Pqec1TzYNh4BxkQVJRz+mvsX3N3ZpaHSU45DwEOGe8xf3/q2kl+rFYWMYB04LuzKOoxjlKy3LIsxiNaj3FcqqiWfKWI9j3z8=;5:yMGh7/mgRYtGf0rBaVJeWVdmgJs1s1oWKO+JmAop+qtBG7hMISjZcJNV7tKVBNmVrI051avii/76jqNRvitS9AE9Q7VZtMwuG9m5kGIbSjOhy+QXpsj4la91pojj2bZFmPArPQ7WTmr8uvg0s8JNOnPxPthzq96g5DPk1Q5Y7wg=;24:VxmbhZRWRE9WeMU0Cw0VUFpdDzNHBts3xH1g60ZGqlrsv46/Kwd+kUTmZ7SnbLnZ2ZSZ7Tjr7OobxoHW9gp62GM6zUNREKm7dCmOE2id9cA=;7:z+LFhfDB3mfHMNe6SPyO0aSovniJQ4x7jyyViEy1akGKMFevsJ/8ghgjlGgb7Cn/RCqgDRtEFLvWHRcHBEHeTM62Qmc86K4g+acohT9KYuiKnntmjpuBbGzKm0TIdn7Is/3vsf0wbKS/3M0WlEaaheXXUGUMoF+J7Vzs0Jhcj7KNbEiNSAGmsOJsMXYpvI/Jj4CA3J8Ut9ZwtM58/woNYz3ajrpOHgfL0OMO8hvHJUnniYd54FjeonA8AEc24jFZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 23:56:09.1559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084a95fb-599d-4997-e6bc-08d57e3dacb4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1309
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 .../devicetree/bindings/power/zynqmp-genpd.txt     | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/zynqmp-genpd.txt

diff --git a/Documentation/devicetree/bindings/power/zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
new file mode 100644
index 0000000..25f9711
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
@@ -0,0 +1,46 @@
+Device Tree bindings for Xilinx Zynq MPSoC PM domains
+
+The binding for zynqmp-genpd follow the common generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required properties:
+ - compatible: Must be: "xlnx,zynqmp-genpd"
+
+This node contains a number of subnodes, each representing a single PM domain
+that PM domain consumer devices reference.
+
+== PM Domain Nodes ==
+
+Required properties:
+ - #power-domain-cells: Number of cells in a PM domain specifier. Must be 0.
+ - pd-id: List of domain identifiers of as defined by platform firmware. These
+	  identifiers are passed to the PM firmware.
+
+Example:
+	zynqmp-genpd {
+		compatible = "xlnx,zynqmp-genpd";
+
+		pd_usb0: pd-usb0 {
+			pd-id = <22>;
+			#power-domain-cells = <0>;
+		};
+
+		pd_sata: pd-sata {
+			pd-id = <28>;
+			#power-domain-cells = <0>;
+		};
+
+		pd_gpu: pd-gpu {
+			pd-id = <58 20 21>;
+			#power-domain-cells = <0x0>;
+		};
+	};
+
+	sata0: ahci@SATA_AHCI_HBA {
+		...
+		power-domains = <&pd_sata>;
+		...
+	};
-- 
2.7.4
