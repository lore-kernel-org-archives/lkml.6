Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935483AbeB1W2Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:28:16 -0500
Received: from mail-by2nam03on0051.outbound.protection.outlook.com ([104.47.42.51]:63051
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935317AbeB1W2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:28:01 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date: Wed, 28 Feb 2018 14:27:40 -0800
Message-ID: <1519856861-31384-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(376002)(396003)(2980300002)(438002)(199004)(189003)(106466001)(107886003)(48376002)(336011)(47776003)(63266004)(50466002)(316002)(8676002)(2201001)(36386004)(51416003)(81166006)(106002)(16586007)(50226002)(8936002)(36756003)(356003)(2906002)(7696005)(76176011)(478600001)(6666003)(186003)(72206003)(2950100002)(26005)(77096007)(4326008)(5660300001)(9786002)(110136005)(305945005)(54906003)(59450400001)(81156014)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1311;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT006;1:Y9bbc9GxgduaLiu/VL7j3bmt3Sc4hFp0bRnnj7AQ0JvpkBhkkWmGT/m1E13B99g5ez10JG2rNkdwm0o+p0JZ30jVDBJWijuBjenu1B0+vUzjqvR/vQVnx1xUDDzhKSv5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b647b962-4788-4ca4-1280-08d57efa8545
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:SN1PR02MB1311;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1311;3:qyMp0tY5vjlxFrEskZw9dWQF+RTWsMBp57QGFzbOIwgXDEOoLm4N3EsGSWqrdS6UustVdi7ZlHekJlKnFLYRYGV0KzuptTSTRtqCui6lYk/IPjGtXbOt54rxBqFtu0RF9WsfI1xiS5gvAvPAkm94v000Dy6mZuWA0Zd70oolXV6SvxsQ+Y3+u1Y4VhJuxcRQOZH4KSBwaMoritvEgU8E+hRZ8X0d58NxDasBPxKsFVRKileuYy6wXypQbXnqokDQD0knCOCyAShqoT7p92y7Dq9Yi9BvIDTv9L49L3ManLqE6pGmvDnHleAnSioM4MyLA4ol2KWruV/TX5W4899kS33kNvfJGRYrev0frOYUWE8=;25:nuavrEj2zULrhQrhwLpyKpF068hGwnqxqTSa9hQ2TgwvFUs1juJgAPeZdksvn0audtK5cMNrSxGp6IiN3LNeWOyVZ9p52yUrlf4Fx7OSb+/GVN50kbT3OQ/pQPbYceCPShKi7hDJWm5WMZ86S89vFdJyLhaDFjl2mZSJfV325g5+1NlmORzxULPhCYhlwwoK/c8B2zQ8p6jEGy/4eSPKhgwcyVlhXqWIK8kp87kxIY0TTnTx/K50m0RLnBZX6iXA+JjJ0dAaayqj8HGLcf/Fo74/gJISn4sXZEu0LYDNIUHcVH/qhCqFms8oALMFJY3AtEd4EAZgt1fUPio2XC+8zTleqEHpIWqb0GdvG/8dDO8=
X-MS-TrafficTypeDiagnostic: SN1PR02MB1311:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1311;31:2BgQJhp9EMjMXFaC3ADOSl1GHMwRROh+X3PO/N1nujL4rzv+NaeBlIvS/vphWZ7ro6lyLW+PenJkV8rTyAUAEIN7DELllrDMkEfHPOR1fR/ugIi1EXEbvpaCBgvoK8o3bVrvnxslCyvO6Tvd3zJ/fo+JWGmY97/+pTWc8LZsyUA8bjLCnDCT9FofcxXifxvR34Rp6B0YMDPnYemXOK3pF7QENPLXTwkI0cN5vc+FnBc=;20:WQCRVCrgBd87LxEe0+xdWBQ6yZ+QWbIspW41UAY7pWiywDSRY2BQZJ195CbdLp8qmIzOCFMB3kkUeqnSrug/NgRSm1DAbpd6DMO9im1JGouEhN6MpofZH3H+Mi02MINJupY1Ui+KIcZi56ugjFAetsz7gqPEnaguJq36CqcIPpkB5jTyrW7I4diRJgQ0I5K/avieIPjL4S7s4f/sSrTUkM4PIXoMc0+VN7NI3TCTlcZ6mntqZxmkO/ak4gC1fuizuPi5EN/NoTAUB8xp3ZLMs4rnrnObE9qKYQarpwH5Z9yCWCF9foJVw24uUOWdxS0i2k3FSz5Kkv5mRTlhIsvCw6JfPkFCRCjgJucXYeKFHK7+eN4Np9WMKfR0+JljcmyrWnGH3dnr/INOMlrgSnl4mlSLxVq5W6GCNOcQLxp/cFS9fFlzvp+ZeB6wXUa27hdOcpUMomjzAbbXBA0J3yRC6hYfjom+/IGFFqj1BW1Sy0ezwct2IT4GWp/B4DCKz4nv
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB1311242E3DD5CE6F752E3B66B8C70@SN1PR02MB1311.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501220)(52105095)(93006095)(93004095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR02MB1311;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1311;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1311;4:uNltzaWFdqDzLbIziumF2bjdEPUvfKRDozTk3lzGIV/tRef1XXuGJgyKCSdvpNYls62IZApla8rgR9xL2yn2eCgqgVkxxIISC1/Q/VCy0eH9SakKv29gIjlRVgmah7ZrgquOUoWBox0PPdNTxeDzVa4i8vEdjNvcbADwnTCYjTNF5E4s8tqFzg15zU9/euT8CByEiiRYrqEIQck6CWcjEtadPkrWbpgZ6WPF2M7KlZamQxdxxGew15FpvTMN2UBfXibeOzqDBMqw3adh/Sa+AytuvMEzvpsaMLeZeGcNts0Jv84ZIXX4oQXjFwq3i2/r
X-Forefront-PRVS: 0597911EE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1311;23:iDEhdkiX6TsxujzrzuPPUb+b7qxxcjoZZ47rf9KHd?=
 =?us-ascii?Q?IUjAzjMLfXKvFHxefH54ZKJWyjazIbQgnVXCc5HXnPAdmrSTmjWcVxjGXmp5?=
 =?us-ascii?Q?eYfVtMWkNJb5NI4yzjS+D2Zj4sP3cI6lcAx2Durm4pPQ6Hqpl38pqNOo6w9t?=
 =?us-ascii?Q?AY+kSjtfyDoXd3ang+FFQ0KbtlQs8qiuCYRriLdpOjdLdNSpLIcyBsp9SmEo?=
 =?us-ascii?Q?sCHyqVkmssAKMFV20GrftVWMSHjQQb2kxfsxqrSzUPAp6uLUc4tN94f0AI4X?=
 =?us-ascii?Q?BeeDVtFZUEyBRrLmQ05MqwPRBuSob+wMRSk/MfMSjJX6zrzQjQcchnaliiOH?=
 =?us-ascii?Q?NBCoGmguqVJ0BiEvjo0bdotrLOT0VCPj8SIneMYU1XQUgsfX0ZgruhVSZTlF?=
 =?us-ascii?Q?rZxdk9JpVC5YPtD+9WBR9tSmefHiCnYOKs1veM7bKuOH1jlJyLQQJM4cK+9z?=
 =?us-ascii?Q?It5mdDIMX91xVl6Qm+2wY9//Z1uzXIP69za0hxUtznDFCZqmhjbjmiSE3YdY?=
 =?us-ascii?Q?8012s7L8A7jc4Q17V2esVECy1l16UzlFHGtHrixEYUOdhC3jsrZTBP+3rZ6G?=
 =?us-ascii?Q?3T2HApSLC2513zR8hEiD4kYhXXDagJXyP9aURy91S2kByFFrkXwwCA8yitMH?=
 =?us-ascii?Q?D4nnL341toCGz0m2v2dsajLK3MDISlnkIOyDUQv5/CGbHKJq4zJjaGULQicI?=
 =?us-ascii?Q?31oOgWSXIWdvIj4MXnyQ6eVgrRoX9WlU51LsgzHS0jWlDDFyM9Na+t/Da/tW?=
 =?us-ascii?Q?LgZT05NXox6l2ohr2PGMp31ti9nHjZT3EOo1fbR4Hx2hbFvWsx9JhFBwAvmF?=
 =?us-ascii?Q?MYlQvRE6q/ubEC2MZOUFvLnnzngxw/DGWwZGFq6XlU+o3ZoCkNyns5zkQwJN?=
 =?us-ascii?Q?ocUVJzXZK5dkVJwneh6hhCCu+lgWguvVI5vloufnuoZoAsyxfvEg36K6H6e0?=
 =?us-ascii?Q?NMdYHj4plo4uQIDhJA0gJ6Z25+zsnKJIIaT3S8YnqW5YaEeJZDi7pLdRGyA3?=
 =?us-ascii?Q?rh10DVBLR8ZnRlK212wHUo/ask5P7ZG09XuSiOz0t34fi75+DMM19IIMjU4H?=
 =?us-ascii?Q?6GA5LEdvw4z34sE3GifQmkUwUqhHyjKs0jsP0RLdrLmusjiTbgUcQniAxC8J?=
 =?us-ascii?Q?h9fO/Mrm/s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1311;6:bbCqf9sYN5z7gofDaD5wzyio7yvte0cGWJm4+Bw916ewoSVxHL1XokzcA6PFJfUgS7ikDiQ6BpPus34hMOw6PkD6nXidlE7FpQhkwFZwD76j2LHpE9J1oASwfe40Ow2brHeqwi5iCcITkNfRR0uTLrHarA1H5n3Jx36B0OhJmqNcf3GjbIrCoD2GNqoVdnZY2+qtGaTbXTb3kiv3qeSff1TfzK6zsmLPRArdmUj0izrJlAL9KAJXgO0RAhRIH6iCeC582qXfJAKrRK29WD2bYVzyAnuUSFQR0c/7ZNkpBrohPyos3y0BmL2Ab10rbfIAfqiOygDdXRCQVu2YYh4SxuVp5AeKeIkb36pg8TjSIIA=;5:kN7XhFwphGHYGW80hMfZq7B15tApy7lGbJOmCJG9BhC2jS5ZijRTsMmn91loclCPZwDOnQGmujIqDPzpU2BQS6w+A9qMR7RlU614R7ypYSFVUDEUdMb54qQeAoexOQlXhW+jrbh5G7VnVOsFCabiEqIGtMStTZOnVY4i2jN7Bg0=;24:bcqX3X4IUbzT6pyDkCvk4a5JPbWpmROfzg6uTjUMthMzY97MdUs7Di53bJO7DAUvn1g5wJWxvFZQc2ksgVBBmYYuLkY2g/ybroNZZYR2Kjs=;7:t93V/KGvudP6DPhoRTn6JmLGQCN6Ouc7ci51QaIUt/s0zw81WF+nvUloC1bEa+hZXpt30m5zLPQ6on+xhmt5LKUmGJUeRLZMhf8W70lc+qzfWGFx4159Er8Ngu86a2p90w44WvkLbnyGZ9DhrLH7ZopJv/oZyDVm2TLwHuvtUfbYWdUw38XERGUUGHeaRtBhP7nTOJvJf0fh/Z2I0T9F3yIvNNWmBJaXoyLvN8iRT2oy3wq8LLR6ihuD2XtkcZt/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 22:27:58.1863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b647b962-4788-4ca4-1280-08d57efa8545
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1311
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  | 163 +++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
new file mode 100644
index 0000000..d590330
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
@@ -0,0 +1,163 @@
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC
+
+The Zynq Ultrascale+ MPSoC has several different clk providers,
+each with there own bindings.
+The purpose of this document is to document their usage.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+== Clock Controller ==
+The clock controller is a logical abstraction of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+Required properties:
+ - #clock-cells : Must be 1
+ - compatible : "xlnx,zynqmp-clk"
+ - clocks : list of clock specifiers which are external input clocks to the
+	    given clock controller. Please refer the next section to find
+	    the input clocks for a given controller.
+ - clock-names : list of names of clocks which are exteral input clocks to the
+		 given clock controller. Please refer to the clock bindings
+		 for more details
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs.
+These required clock inputs are the
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source.
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
+Output clocks for zynqmp Ultrascale+ clock controller:
+Output clocks are registered based on clock information received from firmware.
+Output clock indexes are mentioned below:
+
+Clock ID:	Output clock name:
+-------------------------------------
+0		iopll
+1		rpll
+2		apll
+3		dpll
+4		vpll
+5		iopll_to_fpd
+6		rpll_to_fpd
+7		apll_to_lpd
+8		dpll_to_lpd
+9		vpll_to_lpd
+10		acpu
+11		acpu_half
+12		dbf_fpd
+13		dbf_lpd
+14		dbg_trace
+15		dbg_tstmp
+16		dp_video_ref
+17		dp_audio_ref
+18		dp_stc_ref
+19		gdma_ref
+20		dpdma_ref
+21		ddr_ref
+22		sata_ref
+23		pcie_ref
+24		gpu_ref
+25		gpu_pp0_ref
+26		gpu_pp1_ref
+27		topsw_main
+28		topsw_lsbus
+29		gtgref0_ref
+30		lpd_switch
+31		lpd_lsbus
+32		usb0_bus_ref
+33		usb1_bus_ref
+34		usb3_dual_ref
+35		usb0
+36		usb1
+37		cpu_r5
+38		cpu_r5_core
+39		csu_spb
+40		csu_pll
+41		pcap
+42		iou_switch
+43		gem_tsu_ref
+44		gem_tsu
+45		gem0_ref
+46		gem1_ref
+47		gem2_ref
+48		gem3_ref
+49		gem0_tx
+50		gem1_tx
+51		gem2_tx
+52		gem3_tx
+53		qspi_ref
+54		sdio0_ref
+55		sdio1_ref
+56		uart0_ref
+57		uart1_ref
+58		spi0_ref
+59		spi1_ref
+60		nand_ref
+61		i2c0_ref
+62		i2c1_ref
+63		can0_ref
+64		can1_ref
+65		can0
+66		can1
+67		dll_ref
+68		adma_ref
+69		timestamp_ref
+70		ams_ref
+71		pl0_ref
+72		pl1_ref
+73		pl2_ref
+74		pl3_ref
+75		wdt
+76		iopll_int
+77		iopll_pre_src
+78		iopll_half
+79		iopll_int_mux
+80		iopll_post_src
+81		rpll_int
+82		rpll_pre_src
+83		rpll_half
+84		rpll_int_mux
+85		rpll_post_src
+86		apll_int
+87		apll_pre_src
+88		apll_half
+89		apll_int_mux
+90		apll_post_src
+91		dpll_int
+92		dpll_pre_src
+93		dpll_half
+94		dpll_int_mux
+95		dpll_post_src
+96		vpll_int
+97		vpll_pre_src
+98		vpll_half
+99		vpll_int_mux
+100		vpll_post_src
+101		can0_mio
+102		can1_mio
+
+Example:
+
+clk: clk {
+	#clock-cells = <1>;
+	compatible = "xlnx,zynqmp-clk";
+	clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+	clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk"
+};
-- 
2.7.4
