Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="e5f/E7hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F4AE605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeFFHvV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:51:21 -0400
Received: from mail-by2nam01on0058.outbound.protection.outlook.com ([104.47.34.58]:45952
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932208AbeFFHvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:51:18 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To: <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <wmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller devicetree binding information
Date: Wed, 6 Jun 2018 13:19:39 +0530
Message-ID: <1528271382-21690-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(186003)(478600001)(486006)(26005)(126002)(77096007)(7416002)(7696005)(76176011)(336012)(50226002)(51416003)(446003)(5660300001)(476003)(11346002)(2616005)(426003)(36386004)(9786002)(63266004)(106466001)(106002)(6666003)(110136005)(54906003)(316002)(16586007)(2201001)(8676002)(36756003)(47776003)(305945005)(356003)(50466002)(48376002)(8936002)(107886003)(2906002)(39060400002)(4326008)(81156014)(81166006)(107986001)(921003)(217873001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1448;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT019;1:hLxai+WmccwsLrVPylgbZ+HUkUG11dPo3UWzhJFd+7Kx+H3n6Kv1CQGalZxja1DF0ON6htcpBhDO869q4Ve8Zpmd80PLaPQoLBaLdaP6W8GxZhgYEBMA30IAKAqscZJR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR0201MB1448;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1448;3:9/tcnlZkMDFgMHCmPN7zaSude+/YLWoQVS4YhGcekiZI8HZizjknE2OnYBJ8A53FuMT2+QiLfIK/R721CZ0y428pxK/tBbSib6tkpSrEpmdBPuggtzflUUc8bav1ZLy135exriXmwvCCyMZzad4QbCpziAphR+xwfIG0tinSqFB++PhLKQJ+c8/oxpmaZkmrDZyoucRTmjLWeIBXwJuE3N561dbJ2mgLrwTy9HbQbU820LpDjghRO6pA2TLnofZgv1RAxJpEhW5XiuocN5jhbBchBCDo1YXZYz8n/llatXQBjcZ0ehq+tuAuhMtWye2BnK2A1iIDdQPiH/THRoY2mEp3Hw9373rqFZS8nXpdLZI=;25:FT9swXlQRf/GJvJjdMz1alAtcQ/4jaao21HnPjGb8tttojoZJXsZLagJcWbBi7UHA9HzuqMNcvovxvn7nxtSAuQYqPmJJ5n+6X50vfKu35DBwapYhypMHSljd4CAKmSbJBze82lnHTpdi02oNVl8P0aZc8lCYXdV/MMDLG/ygGEYvY+TTb00AMMZhMquJVeAHaS6B4o++09FaI4RfEwNxo0O7rUEGkVqGVEHMhngctFCFsSX0SMHU/IlfEalg8cQqqGAIh7kn65oOR0Jzdv205ApYgi7yMkotUwgdcphZkiQrG0Ui6BRkYKXHW/pNG/3qNU5JvbZ/nb7Lx9fbGxEMA==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1448:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1448;31:mWCXXwDyduwVqCFgWYs9mLQYRb5QW/4Sz7q6nrVdgg4hn4f7jYvrQxQuWZCO1AkgY/I1w0Z1NzVMpUzF9chBz8WkB+ds/t3tQcar/WCBhT3kS5GnO98o1SELfS5c7vihMt+k/TrfzWUMKpLaVAsTgwFv6i2sm7PTjaICrVc5Au5yrSMhUuzoGzOWH7EEAHtgeGBOwF7q4kqXJYHCoorl1NIzdmLOzIh23UuY16alGt4=;20:HkCyGJehPhi1aNbPz3dIJMMcqhF+44q4QfhpyUUtBjxQ0f3wPVnzCPAI2ttGDBU+KBDCtI8rM8ewDhawK6x+pyS+vfQnv7gG8D8yXOVx22eviP6c01B688kEQtRIS/6Pc9/byqw5vaBH/3HQq8vW9mkxQFzbP8Wnohy5kkm15e1fmmBw+/5v7pQYXiKRJWno1MtovXcPrEApS1/Lh04PexeBgpU24mYjzvE9bW+axqTNcHozT6o/ypSyFKdGt7pBY39IiC5BJfBmnxHA3U8yPlSsJD//Akc9yVFUp97qYwc2rJwW7m3qlhDanY9ysaA1XeyMpXBhWxU4RiXiFMvAhFBDnoRjNSnsg9yP7G6SJErMbs8iRh4JT6u55eugWnxvq1nHzYo+l01uwnaG4Q6NKpCSEA15fgeLbgKh+kDo1TXKiuT9SQEnCUd6yTSsdHyrIUIy2hNqJma5n1YuGN6fGYqz839zNht8s4fuvu4XT7+ibbJ4gMa7E/dIKkAUQ184
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB144856100AB9C3E074EFA867AF650@BY2PR0201MB1448.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR0201MB1448;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1448;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1448;4:aPlGrTwOgXVETXPeAQdu09kSUQuKtTUPRCV8WxLJp2Fvk14KKleS/4BZ0zdS0+/T/gmUDWvmMALAMEsaEvoxI8rshLb3qnvHCXIamn6xRnrJ7xloA8HsfUFyqH3xtyLU+kUUeHwuHbNWRqZ4ijvn8muCZfZ1AIkG+axxj3VnteeA2dCbtIPqAj12sLcYV+if1xynZt+fuA2aSeYDeyvTXTZltGCZug6Rtw1+GXs1cmwNK1a/hEHEt86bFD0o37ygawj4fkm53azOoEEgXBlaJEiXakyby7WiETbggvco+9FwLIYsWTnY0SiKoDEndtd5
X-Forefront-PRVS: 06952FC175
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1448;23:vzi2yKeorcSjVrc1al+wKxrwfum55FersZGSfjP?=
 =?us-ascii?Q?lp7kUz9RjbJwGpIKKkfp93dBnkyCVUdo//wZMJeT4DjgS7yj0uZX3v1wVqjo?=
 =?us-ascii?Q?9tEZVvrD9hTKsnrr4D2mTL3A6qEN+poiVbuXSvNomJgo65uV0QGdRKExziA6?=
 =?us-ascii?Q?sL1MZvfcRdaMF5QbVb3OEipYztgJkxlwafo2xZSmOk9ybVZkYXdpIDPj1fO8?=
 =?us-ascii?Q?5ReY9JuKV52zmFtpFfYzPBelcVCWiEz3exu5ZOCs3LUmpBXrlzbQYMSCj0Qg?=
 =?us-ascii?Q?65nJrzdj5k1GfkPtT2ChysmE7iZGBU2fZLshQAOuT4CRJaF4W28hKIY9Znk2?=
 =?us-ascii?Q?uOdLUvyUqGeLZiyhmYhE/3kkXyJ8GnxzGIBUzErhLZv546yucwbbxx3v52gM?=
 =?us-ascii?Q?SMb9r/SkM8rMwyDAhAj1Fc+7+4eR1rs/Z+hPNIxYrkro2EX9ySshPQ/Z6Ula?=
 =?us-ascii?Q?cI9KjYpoZ4NdThglVrdVTcyhyzr26L+ZHeCdMxQZQAhyoGLTzzvm+C2Onfl1?=
 =?us-ascii?Q?apFLzieoRo7Nymp4Liv1SNrzC9FQE33gYJrjz3wkI6qm69Cih/bsM24cNV/W?=
 =?us-ascii?Q?2eJOzN8AM0cHwV/bkB9Ad0VTwAjJxQ7Gt6vG5brdNp24yW2x5SW/PcDINcN5?=
 =?us-ascii?Q?+gNeCU3EchlrTZD3QPYH9d5q46FWUDm0inKKT/ml1gF+3QwXQdK4m+DCX1EK?=
 =?us-ascii?Q?kb3uWWi+gYH2DyKhMnq8rLxuWRjclV0XQETSpCadYla+bmvYf+1ewfSHyHMZ?=
 =?us-ascii?Q?RoPPJj6sgCKA5fiUF+9U7Mb9zH+1AmVdRytqRrpAWvHZUpsZ8PY01v9o3SHL?=
 =?us-ascii?Q?VZRuL4hjMufgIKOKlNcKoJ8knV0Mxs6VDOEjzVQoACioVkaMgDWzoi6Sv0N/?=
 =?us-ascii?Q?S6x58JiAUWha0ycxLTRsx5Gm1lW48UD1le0TZhDgWFHY+XnCbLSTBNMFeQrj?=
 =?us-ascii?Q?j2qxlQsVdPvwDndJRrhbTtNBU2y14tc/qCvfEs4RcdQbZAtMEjYtvCiq5bab?=
 =?us-ascii?Q?cLpJWuzWz0kg4KVKBV3jmLMMluI+TrT4syKbtgGLBCwXAVFo62PvHHXwVt4q?=
 =?us-ascii?Q?JrNXIozK111dwmsO3IFnqWbHG6P9rlDc+6RmbSzF2TB+oFeS+ijKZhxDHza0?=
 =?us-ascii?Q?tNkuH7GPUU6Gj7JRMyu/gtbW51puodYNGlikP7pnzQxjnUtsXPFaSt3yB2bY?=
 =?us-ascii?Q?7yeMIB0FZeSTR9gGbXqQEfTh7mKev59qOwQ8eKi4ARED2J26qr2iZ/NIu7+0?=
 =?us-ascii?Q?BqoIbcOGV/LIIhJnGeTmOiBiaYsoVU8TSOsHK7wgQ?=
X-Microsoft-Antispam-Message-Info: IRBfXRJBUHrf8PbbvaX+YwxUDG3K8KxEv2iu27W6ZLERynKoPtWCExryNVNqyuE3oBd0a5gJYlvWesqyNxBNiEdQdKubN+E2gLEHRazbMImrAns/MWKTUmg25+Cl9fVX1x6a/ptZUilHbHwesrexG1in0LEYOOJOACDxhbsJVyNL1NKQJsmWHWq5EyxChCFU
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1448;6:LWXWnbeu3vKcwj7ATbOm4sgDsuzK+sCV6QtVc+00mxx5UG0MWLRaC/7UVn/hLLh6SvP8IujMDwuiH//Rlw9hM+9vO5hvt6goc2vCkZ7ohsuhV9FhaYcu8wC/a7DywVl6/fb8TiMFrpBnC9b8b89u8rfqSnVmN2OfcYfwHvSQ9dpWWN/1WJW9rFoUW6QnKHJcowQl6KrAv1Kb0nTOD7nlLr5oNjmZ2WU9Nao2t5PhI3WlkNVxUHGPH5XZchsDydqp0EPIynVBchmEl9eU8KkgOSJ3Vdb+9auA/xiJB4WVSjgxGTFgDckLoUZhQ5WJu1J2dOiHpadSycKgSckX70J9WKvWMFkJCsKFrnfSwzqerkt2ne0wrDgly0O2KUhiZh0nvkw4IhEjGlUS6gwCgknJ4UEKUGLtF3ELKNBg46EQUNRLSSLDs+xIIsafEeSCZ4Bh9pd0fiHYVD4bIqSFXxDCEA==;5:BhC1NIgcdUZiLTj8R98ETvgtQWEBzDwlOg5g9AuPgV3fHgyp56Ml5IgHegNue7RSr75yOg7rkC0Ohp8MZ7idc8bA5expWfVMXB+oatWHxN8nYEbGGmWcARl9dpniM++FyUAky+4Af+wzszkHroJ2xLOgPCFLEYeNsPQQLic2558=;24:eM5xk9WrYl14YWv6By4dwmKZwcStixjZVDEKROzvZvS1xwq/VT5qUN/VuTaHaim2VqfFzIUI/CXOHC505X6zzvERaINRw4q55XTS62+HKIk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1448;7:C8mHQkU++eyDHDTGpdNw06hfT/IjLRR3XoVIcqRhj6aUiMkqGWVC4ZFNS5fd94SLC3g1QOjH+BikmBI+8gJY3OBLSxsqly5mW6QiFAEOPpSR/evJL5t6Ckl0CDz0Ap+vO19G372XrhX8luNxs7iVO0lY8MLwlKcJz6CK/uiLtLseYqoz9dxJcSjeX+jhCOAB6gOS2g1xH+yZgC5B5keL3xyH1Zc5OrOzh/Dlzvcz4Uhr7tFeS+6t0IGEcecBF52Z
X-MS-Office365-Filtering-Correlation-Id: 74df07b0-a1aa-4059-e558-08d5cb8247d5
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 07:51:15.1678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74df07b0-a1aa-4059-e558-08d5cb8247d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1448
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pl353 static memory controller devicetree binding information.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v9:
 - Addressed commens given by Randy Dunlap and Miquel Raynal
Changes in v8:
 - None
Changes in v7:
- Corrected clocks description
- prefixed '#' for address and size cells 
Changes in v6:
 - None
Changes in v5:
 - Removed timing properties
Changes in v4:
 - none
Changes in v3:
 - none
Changes in v2:
 - modified timing binding info as per onfi timing parameters
 - add suffix nano second as timing unit
 - modified the clock names as per the IP spec
---
 .../bindings/memory-controllers/pl353-smc.txt      | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
new file mode 100644
index 0000000..551e66b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
@@ -0,0 +1,53 @@
+Device tree bindings for ARM PL353 static memory controller
+
+PL353 static memory controller supports two kinds of memory
+interfaces.i.e NAND and SRAM/NOR interfaces.
+The actual devices are instantiated from the child nodes of pl353 smc node.
+
+Required properties:
+- compatible		: Should be "arm,pl353-smc-r2p1"
+- reg			: Controller registers map and length.
+- clock-names		: List of input clock names - "ref_clk", "aper_clk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+- address-cells		: Address cells, must be 1.
+- size-cells		: Size cells. Must be 1.
+
+Child nodes:
+ For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
+supported as child nodes.
+
+Mandatory timing properties for child nodes:
+- arm,nand-cycle-t0	: Read cycle time(t_rc).
+- arm,nand-cycle-t1	: Write cycle time(t_wc).
+- arm,nand-cycle-t2	: re_n assertion delay(t_rea).
+- arm,nand-cycle-t3	: we_n de-assertion delay(t_wp).
+- arm,nand-cycle-t4	: Status read time(t_clr)
+- arm,nand-cycle-t5	: ID read time(t_ar)
+- arm,nand-cycle-t6	: busy to re_n(t_rr)
+
+for nand partition information please refer the below file
+Documentation/devicetree/bindings/mtd/partition.txt
+
+Example:
+	pl353smcc_0: pl353smcc@e000e000 {
+			compatible = "arm,pl353-smc-r2p1"
+			clock-names = "memclk", "aclk";
+			clocks = <&clkc 11>, <&clkc 44>;
+			reg = <0xe000e000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			nand_0: nand@e1000000 {
+				compatible = "arm,pl353-nand-r2p1"
+				reg = <0xe1000000 0x1000000>;
+				arm,nand-cycle-t0 = <0x4>;
+				arm,nand-cycle-t1 = <0x4>;
+				arm,nand-cycle-t2 = <0x1>;
+				arm,nand-cycle-t3 = <0x2>;
+				arm,nand-cycle-t4 = <0x2>;
+				arm,nand-cycle-t5 = <0x2>;
+				arm,nand-cycle-t6 = <0x4>;
+				(...)
+			};
+	};
-- 
2.7.4
