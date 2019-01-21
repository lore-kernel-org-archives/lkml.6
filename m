Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29371C26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7D12085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ItRF/LF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfATRjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:39:49 -0500
Received: from mail-eopbgr790049.outbound.protection.outlook.com ([40.107.79.49]:24320
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbfATRjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUjINJxvo5p9HLvLov+soBaesrPPbmGloxdhhz+PRd4=;
 b=ItRF/LF9bZSvbedmF/VtrjeEs42QeSTWztAHu1F+ThfJiU8fhratekUFmzzuQcH3AdEAOkKtcu6d9UKjf2pkgr+vVU2x7JaXn8TEltLH1h2ed9TtK73v704aPQvFuC6koa2RYP0hsfkDu4BscTdCoSADE/31ol0v5rJFVxird1k=
Received: from BL0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:207:3c::39)
 by BYAPR02MB4326.namprd02.prod.outlook.com (2603:10b6:a03:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.31; Sun, 20 Jan
 2019 17:39:44 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BL0PR02CA0026.outlook.office365.com
 (2603:10b6:207:3c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.25 via Frontend
 Transport; Sun, 20 Jan 2019 17:39:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:39:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56502 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4R-0001ke-0U; Sun, 20 Jan 2019 09:39:43 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4L-0002uF-Sc; Sun, 20 Jan 2019 09:39:37 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHdTTM027267;
        Sun, 20 Jan 2019 09:39:29 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4C-0002tH-Nr; Sun, 20 Jan 2019 09:39:29 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>,
        <robh+dt@kernel.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 0/6] dt-bindings: Firmware node binding for ZynqMP core 
Date:   Mon, 21 Jan 2019 23:08:29 +0530
Message-ID: <20190121173835.21173-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39830400003)(346002)(136003)(376002)(396003)(2980300002)(189003)(199004)(16586007)(356004)(316002)(106002)(7696005)(110136005)(4326008)(2906002)(36386004)(2201001)(1076003)(77096007)(4743002)(39060400002)(47776003)(48376002)(51416003)(50466002)(106466001)(2616005)(478600001)(126002)(107886003)(26005)(81156014)(81166006)(186003)(8936002)(476003)(50226002)(63266004)(426003)(336012)(305945005)(9786002)(36756003)(8676002)(486006)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT059;1:LC2bd6kdKQskTQXDDyJJ5QT4nf3OvqhINa3OCA4mF6006InZNupOy6p5zP8wsf2WXkEtJBLRtRgjUA9H/n8aujdJkvfKVlZjr1WdStu9lLB+0tnbsjKonlYD+rPqFIrVU2R7dUj9+zFAgBR6zDSj0cOyPnpeH5Qp9MztqCjqsBg=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f5cf06d-6cfd-408f-7969-08d67efe4368
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:efdACvpvE8Ux8x4HhJeYqttSwi2DdwTGMYatc9IV5LCGjgeXgZN101dMdfprl6wa+xR42u6FstcCrhVeFRFr4oszG1ezf3z8gDLbWQ75w85dagmP8biIgC9eUp2PIjU/JHrd6LsWPJPYLFPehHDXPJ0tYXDogEsmBjc0f12gr3lRuxs1aQWLVdGuOs4809BBCCJ7d9wMayOkfjbeYVo4qyDSpj8BeviXPJmSAa6ZYHAUtJanED1zRV7oTzVZ0Mo1JV8fItUGMp6GodVAqu0DNrarNzF3T+XL6RxrbFCX8P6g9Un3WwV9HGgRCo1iarQVO4V33UoVeBXX2tIsHNs6lbLrnHZA9STGAxDVnr1wAlBMn2atgu9AkFhSZ1x2GEY4;25:gJFD3JpOKm1MwCpu0M/w6MHNgQ/5iHflBdguIxFbpnfgmyEdAbVxSZxQ9jYKwZqla4vd6YBnQB6NLGFkOYWLTYNZLUCPX3u6EWOG7szQooyZdkxarrJAVLyvJ9QaLVoGxnL1kn9n3Cb7HSiTxEnYTFsUu+IQb6ES+CHFtJAA1TO5+wDeE+rZzGv0xGYT7qwLLmRY44YNsTY+x5YEXvdXAjLF2gE1Z7VID1GRAw8wUvufM3kRyLpqXe45NKUgrTsp58+FjmW7HGGz6fI+gDpxy89oci+Jhtkj0YyL6RKUN7hy2mbWX9DBNxXx0wHCiLslxev9DA4u2IwM1JQIkBHRQA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:qXU4EsrHbJ5aGALvdgPknP87N5es8uJjVN6l8EydoNo/zj6WGKvSxqz0x+Dks3MTvQ73iLHvqcgCriEZlqG7Ch3fka+h3vM3ZIUzGIah0KHI1WpfTLOPaPYII/aRh7rvIhQwVRgYjrGFZdXW04NTX3zjCtDEe3EnTmlMzKPbEHo3MEX2reTM+swzd2ndCQoavYPujn0UY6yYjyOIMu9Ly3x8iaqE7oHPKYgg0TrLkbs=;20:Z89FXn0dJ9ytq2LC+GGzgmiZI8VNJzWUwUXid6gm5qmMoC5Sz1E7NiIaWwvWiBX57EH9xQr7JzxqhwCReD96yH8BPwPprUdZdrgm7CQETR6qAA19rwY+OUC73DHB6JyffikzH0le4bcX51yf4q1XFPAuv2gVoibA7EIfWrWuJMPLmTq6/dFOzMu4VR4ldcleq4r7tC+ZAmh8f8xzHU1y2EDROmI+lYxTjXIRk3+SCfYf2OUlwMgj8MAe7C8bbLC+VqCy9YhONQlJRNMk05JhMPospsEm2Ac/g1ntBKyO8nmNzRFxx3kts5cA5RgP82Pv2mhmm5urQ7rsaka+FdlBacvWIHIKm/1Nti6xbctqBfCeoxzMX0N1BDlxGuhHAFbbGF/7LvbnrBcaVUf7wPuCfBPUQSJUXfQzKVwnhmq72XGXvGObH+ANhdyeE7jdkTgsDhzZwkI72Ge7RCPt1wwlY84+PlFMnXpULBmDHFI/YDIZiq0Vd0pL/zW/UZL87iQj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4326F064BF04A02633CF5595C29E0@BYAPR02MB4326.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:C5LDDHPpmgpJ4W9rNq3pWuXPo0E+XA6Ah/h3DCjZypu0gptWbjE3b42tR+R4VCGCdOmU0U7aN/OHXAkcp2dIteTjBvQjiIrLXDwExP88jYNGYOMcH4jwulGy2kBH7REY15cnxJDUpFKNMlnjtj5sWK9LZXti9tPpQuzMgvgmGNIBWkGafzFS3R9moehe9vJOH5qbpA6YDppieK+MvpMmmZqLYZoKAaFzi36ILGHyVJF6HZ+dd7nuTfKhEZ5VR1JOE6cm3n7jZ8je/+4bxhPlvmiOAeRoXFcdrinRte8+jGlCStq7X6385kQ/yZU8b0k7
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4326;23:XHUV+CJR1yjp1m+NOayfCWWkg2+MJK1BmHEdOXk/Y?=
 =?us-ascii?Q?VFBuOouYtkNeM+fsbKPgOU15I+QfolM1qJ1mB2nnsUls97S8q4nJ64YFj8gU?=
 =?us-ascii?Q?srbBmr/GyBMVnu8lPs1gcA/X9Otu8M/qHElzHUC3pDWLgRVmTQDxiFFvcWN5?=
 =?us-ascii?Q?6PFeitlUEefm26j5s50ZvZaHfaKDN8ktHTtRyH18txOHjGGkR3d/1jZcmiTo?=
 =?us-ascii?Q?f6T/n1ttt8adZzhCfkDg+LCWizIcLuYYkdrZNC9HzF/t2Ee+42f/kzwh6QVe?=
 =?us-ascii?Q?3y47kvuJkMBmTtj9/lrBnl5ro082NVcHsRTbMeRVf4l2ZcIgHRwmBMwMDCpP?=
 =?us-ascii?Q?30fImwcKzUqqEYH996j3x7/2H6W5DVANCKvfrXNyfz40E4JTWc48N0rPGmAX?=
 =?us-ascii?Q?MWfFfS6XjcMOBb9YHqIn3OaduleY3kvOGIJ8PvBqKntnekQuAH4ncMPXRwCB?=
 =?us-ascii?Q?spZX12IHF0edeQeDWYt3wkAJFB8ERxSfJID45V0ihWV2CAIZMD87Ldp8QWg2?=
 =?us-ascii?Q?2gEF8Q0CsMH7iX+IrKwt38V1xswew7srsiTTzx0bh8ZDZjBEkO0Wr9gLlXWw?=
 =?us-ascii?Q?IcK1bmLAMr5ezGB1/FfwkIqUbFD/cT67XTwO7bdGLIY8fN6/feHhxcMxPGWL?=
 =?us-ascii?Q?OUTJNB+UOTapSxNCR7YivVsqKqDUdxi8EUxDGGjXm5MXCqJTF2n/gwLK+8fH?=
 =?us-ascii?Q?rnJfKFORyNrIpG7QRqkSZq/96fT1DhdehB5m/J5/UZm0iFnuXGDGcdJ4vYM0?=
 =?us-ascii?Q?Ftauc3m1fJsCkEAxUe+PGGCRlpQcrRV8iRp8BurbF23lAtmhssGilPiw3dr+?=
 =?us-ascii?Q?Q9vqNPsEMprnEsibHnj2OZAj3Oku+eDF0lQGvJdRa2+BSBUYJ/db0TBy2vgR?=
 =?us-ascii?Q?J/ZMVZIRKcjRsdIT022Gv537CJ40fpy6N2iBg+RQiVyBw6L1RT9bO92ghMyN?=
 =?us-ascii?Q?38AUQG/hkc+4Vl5VWoG/Jt20r4zWS+6gZfKiRf6994ww/7/gmEWmIeHXgog8?=
 =?us-ascii?Q?uWYWD5KKFwX5g+adj8vrlRPXy4JpdfH3YkQtUpUinBl+TokI0TMkW/Nyuedr?=
 =?us-ascii?Q?7PuVd5vMf42zx4dANhsDBjT48Bz54DS1SVJjLd9PAUIBgR3nQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: te4vK2sqAlyRgXuKi8+gBiwIL9xRSn2g+5jGW3FErDndJyFGMxdAumg0BSTlBuXzEIbfzBKV63Ww35BlRmNthUI8Ocq4GO48izLyTxkGMZs79W/paJ8ZLpOvxT9q5m4VGIBpQn3NpAnU3Vfryi1SK3/e5tIEAUlK/14bu90oP8IapM8BRyMZYcaEI8/fOkRRLeklLZupRGYOIOAidaIYDVozYtFi757D3WU+OavBbQAXVNmvsmIh/WxQcuA1sgtX321wT39Txro8I1CjLlKq8g0EWa1OpZVqgl4T+ZiLAMRAzDz7dWMlUYod/O705/HrpcErFwmPJn7q+I9UoBKmBKdT0lqUlGErWR1H+/iaRo6o2FdbrYhjdClXVewulvz7eT/mj1YAzRbe6wy6jwMQKOSipFZjSc18GJztjy9ZBtE=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:UgAkdvsVj3oenTpvUKGkAu51h6RPlJcxg5a8IAk7gbZv/+CDTwWKelAUby65MCePIfjK+nQKU8jU8tZbIrhell8fg5uV+kYvTftjdad/i7TxP3TgxlOMx7GcE97Uxt8/eyBQn2Uo1zWjLUaQ50YNZ5cT19qC/PcupJKoBdUNRhD6d+QTwhB9fvkMBfYkdvHyxedxX430yRTn7rAiFcpNR2jesQRi/Lfnd5xguK5X9kRpW+m+1g/RN9EGxOFam6N3t7XVxt7fw68soKK23vXfaETabNJlUK4wuln9VAH2qmErGUW9ecBsNRA9winmdiLFLrUM9lZHkdU3VUbuUU4gCnS+nLFor4ONVQAvK8q9F+gswUMAeZuaalc8h3pdN9ja1T5O7n5tC6YtzjqxLVhJx3wRCeo/MuhZkjIEkyixjIzCRq0GV39M/lpW/ShHY62bTNCYKhTkvaQVQ8Pdrd6cgg==;5:NA1twS7XGoXRISAUbjmXW9YGwYQj5oBYLs7gMKYXxXmMU8OpWWp6R0IIhToediCX6Zg/5lI0uoVCOua6Ps16EZy2BebI33RLXD5/fj7vyL5LZKPFSUSNUFJyAFPCtHB/W3lZvlk48/sORkszYfDwrt5yV0u3Vp2uMJpiao47PcqdZSWCuboHEqXmIgtffVtHKBexrJEX9L6YWBRXrMo2dg==;7:0eoEb1lhrNLpeP2KeVBs9STH+saPcG+0eX5XOr8s0K4AR0KRi+ByskjwFPI6DaoCFOXuLKhGtp70M/9TxLJ3V4KeNwjh6EUQqun0lY6zqDB2DrUEkTuFScqkVLtUBxvHhZk6lFCl/QaHQzvWba1Emw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:39:43.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5cf06d-6cfd-408f-7969-08d67efe4368
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Base firmware node and clock child node binding are part of mainline kernel.
This patchset adds documentation to describe rest of the firmware child node bindings. 

Complete firmware DT node example is shown below for ease of understanding:

firmware {
	zynqmp_firmware: zynqmp-firmware {
		compatible = "xlnx,zynqmp-firmware";
		method = "smc";
		#power-domain-cells = <1>;
		#reset-cells = <1>;

		zynqmp_clk: clock-controller {
			#clock-cells = <1>;
			compatible = "xlnx,zynqmp-clk";
			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
		};

		zynqmp_power: zynqmp-power {
			compatible = "xlnx,zynqmp-power";
			interrupts = <0 35 4>;
		};

		zynqmp_reset: reset-controller {
			compatible = "xlnx,zynqmp-reset";
			#reset-cells = <1>;
		};
	
		nvmem_firmware {
			compatible = "xlnx,zynqmp-nvmem-fw";
			#address-cells = <1>;
			#size-cells = <1>;

			/* Data cells */
			soc_revision: soc_revision {
				reg = <0x0 0x4>;
			};
		};

		pinctrl0: pinctrl@ff180000 {
			compatible = "xlnx,zynqmp-pinctrl";

			pinctrl_uart1_default: uart1-default {
				mux {
					groups = "uart0_4_grp";
					function = "uart0";
				};
	
				conf {
					groups = "uart0_4_grp";
					slew-rate = <SLEW_RATE_SLOW>;
					io-standard = <IO_STANDARD_LVCMOS18>;
				};
	
				conf-rx {
					pins = "MIO18";
					bias-high-impedance;
				};
	
				conf-tx {
					pins = "MIO19";
					bias-disable;
					schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
				};
			};
		};
	};
};


Nava kishore Manne (3):
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver

Rajan Vaja (3):
  dt-bindings: power: Add ZynqMP power domain bindings
  dt-bindings: soc: Add ZynqMP PM bindings
  dt-bindings: pinctrl: Add ZynqMP pin controller bindings

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  13 +
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      |  47 +++
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt  | 275 ++++++++++++++++++
 .../power/reset/xlnx,zynqmp-power.txt         |  25 ++
 .../bindings/power/xlnx,zynqmp-genpd.txt      |  34 +++
 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 ++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |  39 +++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 +++++++++
 8 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

-- 
2.18.0

