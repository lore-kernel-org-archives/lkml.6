Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeB0XZD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:25:03 -0500
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com ([104.47.41.65]:51376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752153AbeB0XY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:24:58 -0500
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
Subject: [PATCH 1/2] dt-bindings: soc: Add ZynqMP PM bindings
Date: Tue, 27 Feb 2018 15:24:25 -0800
Message-ID: <1519773866-18196-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
References: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(478600001)(72206003)(76176011)(81156014)(39060400002)(26005)(4326008)(50226002)(36386004)(77096007)(16586007)(36756003)(9786002)(81166006)(2201001)(8676002)(106002)(336011)(2906002)(7416002)(107886003)(54906003)(5660300001)(110136005)(6666003)(356003)(51416003)(106466001)(47776003)(50466002)(316002)(7696005)(305945005)(186003)(48376002)(2950100002)(63266004)(8936002)(107986001)(921003)(5001870100001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2271;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT053;1:+YwAbzLuH3ykcPJK09WUAT4CN/cp4H3L+wHh3fMwkgGJWfbUFtTwIfGbOwZaHHfc2S2oTcQ1L9fo8J6Z3CUMrah+8JmA7JUzhK2Y5yaCRrEBaxqtIN5kT6Z2XJJ2ksPI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8a6e03b-179e-4c5f-83ac-08d57e394f85
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:MWHPR02MB2271;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2271;3:BZCTqaIhEL2JV0Qc32xI+SM7wJkUKXJiCy6d7l7lgjVK+mZP0En2mQ0ydiW3ZFS5sMVBLe4ZP2MFJjPI9Kctm7IZclCw3eH1WubSYhZCUyZaVbgkvRQ9Tq33VaNI6EgEOuS1sFyrhSV57LasrWqjPkm2g2FX/rAG+Cmfkv4XkDS2zCkhz8FSp+vU8GID5mELThkGIVtuVwn2HuT7zWQEHedKRTB6KCPCVkWpRvjRixGW3do0ez1Ytin/X8reiqX6L5GDFuuORnDkjBCNFaxHCc5q54iprEJerTMI1BfJuu7ApOBvNTqdgxNa5Yuxs1Kr3dqvoHWjk3fUOXVtsyg668SqL1T6IgzRHlfPcvRSZVU=;25:8emKIjUnlZMBXsBfL2Y9TlS1nWmOaJZY+AWv5++Cmx8e8gOj2ifxkpKMtxGvlxJ+v0uSm89oz0qT4s0G9scv/MngvZ4gyZV1o5L7aAq+4EgS590K/APu3yZt26dN22/SI2DPkHyJXasxFoMOmJDObc1MR/WHIO45n++MafeeuSgP2bVhuocAa+7n43i3YfZhCTubkJ0uU/DVkaxfzSOMUKl9U2c7/YVxbOgzR0FI5ln8cTLlDrubDBLtzzCzndhLkyxuiDWp67XaR097imUD+cdH+2cl/jOsbABxoC9NfoJIvK3u9YgJKhnOrFT2yg7ZHZbWhgaOgcH0H2tp4J4C9A==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2271:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2271;31:ikCR/qUcLhAL8Pf7QwhrSwyq6NVXOWCv7Ho0MxyRk24EyaHIzZTc1gg+hSCf2+BuIa0endJJzdwYUrfBtNNNK6g6mY3aGag7ch1jXbJhAeQBsnhr2JhCnvEy/PfBPAFariHaDn+fzs5EdbFaW6frqOAi2+BoYN8ojL2F+TBBflWWjg6uHTXSlXrs9qi8WJ07Oo3LQrCnh+zZym/jSy+arVmMn/lpU6gncTmHZM82rJA=;20:tRSamXMH2o7Ry+4oaJev+2dXXIEN9E91ycyJixzFT4CsryxhSREPmAA7gTIk6A0wepBFBsJC1C3hXp6CAYkpyuJ++VQlLcHcLShs/nKHaxyZcn7/anQyL3VqLg0pHbXCRSqs6HK4ycCvR8Zl9j5iIiK4jAUp+ptUk/gSWCxE8XiCZdq+jXpgGE1R6g5A3VPG1i/NUxFWx5KdXaZaMSzRUz2G8yPBsvxgeDXJsN5jEcJg3WdJGBYrP6CPBHDfcK04LmUkMMQVTmxjotF5Yvwq/AVRlndl9pEt4/Py7b31i6Z6SBqtUBs8FhpaKEgdca8GBLuUHQXUpj8m52WtHJsbUE831zcI2++2sPCJZPzMVb+ws/7+DlEEwTXownDrQu05/yFduMKSgv8ePcpy/PSyCqESRWIoz9Pxu2L7DLecfki8YiYkgEGlgAo7zRRRpK1932NE8E+cHE0pQPxpV1vDBX+y/NxOuoovXHhFlqdQRswU7gQcpclGs2yQ/Wj4zhv3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2271C0DBA1E22D5849D06574B8C00@MWHPR02MB2271.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR02MB2271;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2271;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2271;4:AcHKJsYLpUcbY6UChi8OI5E+F1vml8jJlWik1YWN95N6BfA1pGPAyZ6sukOZE5ibhttkFtsYaSrS3YBugyPDsLKJ/WCVJEpEgbnuQQHRQSR5tdNZcyjvm56CyVZktBxO8gT/nUNWQQ91LoFO+eCkDbLmjzn14ZxSyjmw0Nfhbx2PnAiImYM797PBDJe5o34KDF1PTXL8xDk9Wymgz6m88vDxypXpYldlz9aXRivha98shuEp5vIc73UuYgIvnDSp0+vOX/+aI6mprQ9qfS6rIyOr9vUtFoAkMKa1SRcdclvwT4pCqY439AgPOgzjmc8J
X-Forefront-PRVS: 05961EBAFC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2271;23:YIu9asNtdmw1EPA3Cs5YO+FOZWyG+iPetrwCWlWqo?=
 =?us-ascii?Q?tefT1pwVt9o2m/8NL08sc4Qk+JyNGprrd7MjbEyeqfF4SuHZ9VMPRrQqGGL5?=
 =?us-ascii?Q?Ff/GjDyck5DaAcUPMyoUGX/QFi24Gf+VevrELigvD5boMnFDdVHurk/CR0/S?=
 =?us-ascii?Q?azk2k5JxhCxTKQufrFg/a3cSz7rwUafinML0+NX58Il/c3lMQyoVAN3Unq+6?=
 =?us-ascii?Q?Rnkmp4wiUZaGPW3sP/Peij4n+vBFb2472LcE1Bv1Turqtqku1kRjE5YZb9RQ?=
 =?us-ascii?Q?1NcrWOoVcvB5C9demz41viffGg2jd+hxAfa0WdpRm6gF47IGwrkI9sSGcnVX?=
 =?us-ascii?Q?AncAPgUc4L/ZTy6DF5Xg7M+TZHo2aFPab0vCCHXyzWm5W8YqUQsCSNZhlSVz?=
 =?us-ascii?Q?bjLUuUWQczaKmsJyR3fp10BojFawbXK4sNDp7jWKPkT/e9qRimtLjRcuai/h?=
 =?us-ascii?Q?rDXRjX9gI2tCToULDzo6Ubc6TZ7KJG45q9PAiOH4fi+mrVtFd0RhW1VLRJbK?=
 =?us-ascii?Q?857RZ34t4UAqETXF5Z8bDMu7sn4Qp4QCo5w2HKVOHZS23sez2hgRZOiw5aNE?=
 =?us-ascii?Q?KU2LTDd5yP3g80zIo1SyXHexFbbizUrLFmehQH0halidw97deFr4wWng3sVX?=
 =?us-ascii?Q?9DgzIZByCyovwIGtnojVt8C4SaxlUkZ511Fbttt4miE5fbVpeckpXRo0zrGb?=
 =?us-ascii?Q?qbDX5A1uehDkA8fmY4uES0kg0UnYTeBcXoZKWw6TU20vhMAJOUG5wRLckSFQ?=
 =?us-ascii?Q?2qNlIsiiBClg45WamF/0xCFP6DjjtjZo5ZMDXb8kvGGncC4joLEZ7ATl3KGU?=
 =?us-ascii?Q?nAn/eitMlEYl8+5mP9qNYsPvemvZAAGPAMrrumy43p/ULzR9W7epsVn2BsJT?=
 =?us-ascii?Q?TkPWe0xK8S/YYYuVy0Eh5LzJVBXEtqFsV3Tj7pZlRf57tETrQ/jfo44UoyDN?=
 =?us-ascii?Q?bGb0j5Y5Y/222ZsPdkjthpnCCjZ62/4BqpFtGAen83nZ3BsMas/PiSbiY4t+?=
 =?us-ascii?Q?Hp0KVf58KXLUtmY80Evzfhz8MRzRd+fG5F6B76p+/6CJr1ud+1OTgwG1TP4z?=
 =?us-ascii?Q?g8VtwOE6pN55YNAfSF9wFrQDq9NQXK+f2YAqzH0MZOfr2T1QjmIUIUOFMDB1?=
 =?us-ascii?Q?BTTaYVZkrFNA/fJ/OgxB2gW2l2p+rvFw2TZIvh52xK+a4FFZikpHeEUekXXC?=
 =?us-ascii?Q?t5Wu4J+iDZgejK/kIwJ0piM9a6skBxnkpBEpztnGEUHhGjjJ3fVYc6zRQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2271;6:rcIou7cTrJ+YVtmb1Wp6BpJ3A9Ax/T9hD05sId5yyityO41jk/OVR9eG03IISnwAiExLD8XxabzN4XaHQnz3Giu98bz2Y79hG5ypCsfvvYHEPD2OGYYhCjd1Hyq/ntv9hq2bGjJkQLJj7dLRAS1TdkwWxFDPIZx6XGwbp7EEY0sP5P7Pwnlih+ihduwT7dk1EMxrZi4JInPHb57cex1HNpiKIMVwQlOBMa9+yH3YuF3aRKHMFxUVVZ9tvB02T8LHhCD78CHsiT3n7OdvPHe2eEtNWmhltxOOFpLShZ78gdO9/wAw9MgtbCNrCV6Il5m586iPmbsEay1lsGhfSq64hSmMQzFN2Tv8AOPw+aH1u74=;5:DtkjlxCt1MNJrEfvdEvvJZBKeRd9E7SH8M5BUFn/olURGHKTLYNfVTEvxDdfqhHm4Zec10Ea+/bqYppeLceNV9/MPaauHxfyc7VrpQc7SYSwDJhiRc29vvbi0Klb03+yTPpyg2ULic8wE7nR/yEC3fGrCThyM9FRPrXDOD6MFwM=;24:ccj87mffMLpU12iYCN9HVG0GY4BdjyakbR6i6bQpS3Yq/Pf5tQOww6GnGifC7tHBbxo5yIXrn3xkr96WV2MsnUORcr1hFmgB3ALuvSFnW/A=;7:8UN6Uw8dLdD4buOvQhLo95w+n6JNpFP0VfHrAWUEhjJHh8syb9HqOj1YAKF2tMVZJsaJXhGh48X5GOoGteJs9cAz4GNSg4GpiIcMq+Bppr+eNXlz7xDvZXhILZIUBtWUfzty8zLTr8XfJb96Ggb+ddEOCwEYmMoO/LrdATqtuffvbSl8WPPwpcXDCyFZgv7wXXN7SyjMVYR31k0oRqYk/YnfhMNu4/ISsnmqWRUK0VNcoT0+PIV43kqkKZTfGVDE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 23:24:55.0491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a6e03b-179e-4c5f-83ac-08d57e394f85
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2271
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 .../bindings/soc/xilinx/xlnx,zynqmp-power.txt      | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
new file mode 100644
index 0000000..5b7d963
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
@@ -0,0 +1,28 @@
+Xilinx Zynq MPSoC Power Management Device Tree Bindings
+
+The zynqmp-power node describes the power management configurations.
+
+Required properties:
+ - compatible	: Must contain:  "xlnx,zynqmp-power"
+ - mbox-names	: Name given to channels seen in the 'mboxes' property.
+		  "rx" - Mailbox corresponding to receive path
+		  "tx" - Mailbox corresponding to transmit path
+ - mboxes	: Standard property to specify a Mailbox. Each value of
+		  the mboxes property should contain a phandle to the
+		  mailbox controller device node and an args specifier
+		  that will be the phandle to the intended sub-mailbox
+		  child node to be used for communication. See
+		  Documentation/devicetree/bindings/mailbox/mailbox.txt
+		  for more details about the generic mailbox controller
+		  and client driver bindings. Also see
+		  Documentation/devicetree/bindings/mailbox/ \
+		  xlnx,zynqmp-ipi-mailbox.txt for typical controller that
+		  is used to communicate with this System controllers.
+
+Examples:
+	zynqmp_power: zynqmp-power {
+		compatible = "xlnx,zynqmp-power";
+		mboxes = <&ipi_mailbox_pmu0 0>,
+			 <&ipi_mailbox_pmu0 1>;
+		mbox-names = "tx", "rx";
+	};
-- 
2.7.4
