Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57CEECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C5F214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="H33yV7QH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C5F214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeIQNco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:32:44 -0400
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:9239
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbeIQNco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXkEyS6yCrEnOyFC+7O/4ze/gcgWq/5SgAGXYDnRoLA=;
 b=H33yV7QHzVzPg2JbmtPONjAyz2TPvUUSDZk2SEgrf7CjWyGrTrNE7Ujbhju6iHyVDgLpfp8bN8utGzgVeXFYib81wNGmWCO4J515fraFO8GTLnaOoTzo3n0mK1YC/tTcnyIavcIBg352d0woymjsx0gmQcedhdU8PFOGqgm9WX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1576.namprd03.prod.outlook.com (2a01:111:e400:526e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 08:06:17 +0000
Date:   Mon, 17 Sep 2018 16:02:52 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: synaptics: add dtsi file for Synaptics
 AS370 SoC
Message-ID: <20180917160252.6c016dbc@xhacker.debian>
In-Reply-To: <20180917160015.05a1fc5b@xhacker.debian>
References: <20180917160015.05a1fc5b@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0213.jpnprd01.prod.outlook.com
 (2603:1096:603:36::33) To BY2PR0301MB1576.namprd03.prod.outlook.com
 (2a01:111:e400:526e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2370efe6-13e6-466d-b743-08d61c747317
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1576;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;3:OKRun0NkQw2L5zm2JtTvcXlGct+gerj5qpvcPYIb5sRdbeiJIlN3RospJ+sHBUtto07hiuPauxSWLwRkGCTdZsrQLjrEkdYq+gvx6XIyuKTr3yjVg+sf/CjuvUyKyfk2syTpR/Z8kHQkWSVZiqTGJzq3YQ9nAQHIJe2HW/H2wJa/wd3RiCgZbr2P/RRdyFr1EnKs01zQxMC7Vso0vlmdYSjsgOMi+Wm6BI22LE+2k+aFKpPsk/LjtDkKk6Mx/OEz;25:iUUACbAIpMdunak3hgxmYXjEwhSjzLaHoj6qQlr3YmtE4DHHMoajPP/YccZnp/1w0rjaP1yYbM8TmWmP5KL/lW78TG6xe2k7l4bhKPSczrhoDW/BzXUpcHXW/N6fqCwQJS79/M/Ds4s7UlUSYJz7/4iSacdc8fRkBtwrfSH4XTs8gmDrOUXiyiBGML0jeugXR67uok/hq+Q+9uAY5wHzOKQFqd3KlDSYTYtSyW2txm7L0k+9AxCYdyovQtXLFIwOtbU4LYK4FUEQTSoKsBUV20NOkXgjIrO/uqzVFrk8Gig8QtTO+1+CIGBFfaa8uknEs8ayEzRttaxV/CVhSuPeiQ==;31:XNKt+IYmiq7fo3t3gT1uNNuiu9nijAVc92sI+XzmJgt+yNXcymNAgWSPauA3ApbVrKNAgyNRRNru123SblpJfuPY83OfGfEcGuHGRxHVtNuSl3xMvmgpz5b9ULIjX5BnloM0KVf9h8GgeJ9+E9k4gY55T9kt8HjAvdFBwUZwVzCKE82gPGk7nYYGrVPFs4XGo2irrqaMap+5dpA/oTS56d4g+TqB35hrSBQB6lhT1GM=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1576:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;20:ShUXXkgazG9sAksgsxcZ5cASy5OQlTaHjGzTpaoQ4IDlVcSW6jhspjmpRHzUf8DJqOVfDrpBIvNCF1RD57f24B35aFRoJ3C/VDd+VFd/I3w0bKjzLUAfUeJWwvFmkd1P0qRdbaDFdxmLj1Cw7bWn7pluLbwfqN/buFLuPaujj+HF09pcJH55qeUEIErRYUsy5pGwHnCkHS2q8PJ2KEKKWSwLt80dCe9QpHjcFYXhHHtmncf6FeohCtWhinEvQ9ODWnkRZ4qRUtuag/i8MVwsVGnVRGoHO4EoUrnuaFQMijXdCDIVkrHFsuonisbMMWGFw0diwDlCUDNGlenn1jqx972AVaRAaL/rvywTYrHnf4DwTOsESpsvIqo+15PQjcK4SuZ/YtBhw+NV6Y3XX1h/BCqobn4LRE1Enm4YHeh658H6T7ScO5peSJpvqXl33gO3PPJ2IN/uCIT8Jn6N1DPBywJgO8BZkUo//cWeyotGwaEBZaCj9w7fTr0MyfNVs2oL;4:C7QE6LGA/Lp9OHlLp2Qhag6Sa/KMwaeVb1p4IoylS+EDOYU4WmalWVOqhaV7ztSL1NwHNSnFQwm/rdmt4Ogn3Hdi040CR4xJ8HrMYimzcFT2BUyp9gnbnVKBnJKrOQ11QM5oVz+cwURod9d64/6EZAjFVVJoZpvCDwnaHcaMi20AHRD+QDKuwJlren/0SYOhEUkPFwY7sKun8d9opTQeploc/enaCeD7XvtFIXIqYpU6s4PR6SC3Djqpv73J9Q2gHxdUP7M28ai2fOejc/djwg==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB1576C7B8FA0CD389938DA987ED1E0@BY2PR0301MB1576.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BY2PR0301MB1576;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1576;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(39850400004)(346002)(189003)(199004)(66066001)(97736004)(230700001)(8676002)(305945005)(7736002)(50466002)(106356001)(4326008)(105586002)(47776003)(478600001)(72206003)(25786009)(446003)(11346002)(76176011)(55016002)(39060400002)(6666003)(316002)(50226002)(86362001)(53936002)(9686003)(26005)(68736007)(5660300001)(110136005)(14444005)(2906002)(186003)(486006)(16526019)(7696005)(52116002)(1076002)(23726003)(54906003)(81166006)(3846002)(386003)(476003)(8936002)(6506007)(956004)(33896004)(6116002)(81156014)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1576;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1576;23:H0rgy7pD9cah2d92iE+IfKy7ovzpwLTIe9zoooE?=
 =?us-ascii?Q?ZsRLMoAVmpEhCRP7vrlwbN7KWu1sMq6Wfn902pMp3HC/xSGKyZhK/5kK3/Cj?=
 =?us-ascii?Q?dLMGWURPVO478KmoNsqgROvZk2i+VS22EVo9ESUbT7R5kx7O3wvi6dpVYJlo?=
 =?us-ascii?Q?FrPS3gKV9U6TmrcJBffsX58GLelKRRFWV7yCqqJtYTYhDjykcG70P4QHouv/?=
 =?us-ascii?Q?jkBwyXW4wkCnEkLFpnBTj6tL9ugrOWuE2IWGAeZmfBLCbG4wICYmvvLqanNg?=
 =?us-ascii?Q?4zW7EVApR+xutUtRNVektNXMgMHtLSIFYdLuNFRV503qEy3CVwTL05EvHPhR?=
 =?us-ascii?Q?YcQ6GRfP3xracaqaCEO7BK9xr2wl+QdH9LaBzCz6ovn2riyL2ZpdVB5H1GYb?=
 =?us-ascii?Q?b/0vI+BUmmMBGaJsXtLQ3p5Bf3JIBbmvpj/r5t3JeOCJPmnFoqAW5oqi04GM?=
 =?us-ascii?Q?CWIglhRS1OXw1aDYpS57gk89h8Yn7s8D7+Pl2dpOGNv45sSDdx7GRQa3juNU?=
 =?us-ascii?Q?tD8xFWTTjX1dW6M+/DuIl5lCRBZ5y8IUNykqq81daILTJlwCrlJHWxfV17R5?=
 =?us-ascii?Q?9NZErLIehu3YHgct+PHp995DbIx7heG9HyyDuuwkS4I2UGPTWpzYDES6PLV7?=
 =?us-ascii?Q?LmNTqiiBlXoxKIim+kKK6CKrr17tLVWo6f3V3L427V+GNEg+yHTAbWALaRGa?=
 =?us-ascii?Q?fu54zy1/pWjfhWzA60WCm4NqZCvqCSm92yE0MSP0ccejC8XMgIP8lI9EidaP?=
 =?us-ascii?Q?pcY9cgBK8pcPzMMliSH/PWT9ccx325XFMvfeU75kmktXI6ttSuYzMy+GNbFg?=
 =?us-ascii?Q?r2oAvVKLVd31fwYXOEDWAVXfDaXdcRMSq8CJW4hEMGySt1dgawBjN6CIrKvA?=
 =?us-ascii?Q?jNGKJWFA82uXp+hkIzmsCCeI30hIshuGo0IDJf6XS11Er8OMIqXGzLBrLzrx?=
 =?us-ascii?Q?jwJsh34fZyad+YFRNKN8MAQPOpAd4Sp6VoFwZwsapOoUbV+9Kqp8EKpZ+Glw?=
 =?us-ascii?Q?pCLajhsLtB98qLU6oMJRejmptrkuh4IlEITuzZq5fItwm0DxYmU5koMnMmsH?=
 =?us-ascii?Q?dJC4mQ3qQEmU5kNcWUfaLsoYLzlAACY5T6HS+iZcV/YE1GQZygQsvSt3WB3A?=
 =?us-ascii?Q?bT9Kqk0ozyL78Vrubg3Dp44CjMECcvUWT/cLYf/uEp/4Rs0rAl8cm9LU4kIc?=
 =?us-ascii?Q?ZjNEB+8+YtMxHaSRrlGyCQOOpjcc967b42c4sA6tAYaogQGhZsmtEkGfo+HH?=
 =?us-ascii?Q?9j7Ja8x+76fdJSg7x9VyCLi5yLZwZeisipcnV95qDnjJmWeoyqFimtgxMry+?=
 =?us-ascii?Q?ixA=3D=3D?=
X-Microsoft-Antispam-Message-Info: q1nLCsQcwpdra8dOxBiwZU85qap5rTyvGmOokMVVchUqlrmxjFO8Dx94sLVatL5XeMkQ9ODuP/nZ+8TMC3hJgPZaKIDMS1PUnDgdb/nlMWJhDurqu8WBIR4eA6y2CFQmnU2Nb6yWL61LdYdy6Ns6rIlm78KmpgkXJ8E/6YZTRCXPHoxuJky7N4tWYi5LSJ4xVle0qoBIYtStaTnQXpSQ/5/mhQq7B3j03lIthGfvrhPSCcIcOT1JRoqqnPm/aTecrFmdpxU/0abf6Ojc/Z/9alDNZY2voz2WqzDO2cn1c652OePdgxix3m2kJCb8iuxf2g3fMpjoaf+G0R8UsCyfrRtECYKT4JVt8ir1RLc82mM=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;6:KWB1jNd3JXQnz342tPbwNxf3PnSkphMlygxoRcB798LXpi/wK2qRLEJO/NqFu8BxMyMZ1MfagBJ6EqzlSl/R1pOGhjSlwoQfH/uT7M0WIvMoFKoZAXX1Vq4g1ZaI1waEJWvq92f45NjLWCViTsJb4LntNfu18/7dEBOOEbpLsXeWq2KSa249OOrCJk9BkSjEfIBJlHGUys4gY2PfcPoEndK0UuaQZgo8tJS7DALOgandL02GCQmFk4B1HNozncjgbXZUlqPX9a5vw7KjgxPdbgSnvBEV87kr7/CmNBUy11gp867vjO2SKTo5lBit7zBruBzzP4rPNMSDj29Z1dvbCFUMPTuu0+appvjsth8qm0fE1rOTFkbiyjB5iFiDIzw2vIQMFyUZQ61EnvftURNflSV/isPJrwLldg2Dhfd0m6mxtAwgScLVPweO1THT0hrjiHqa+i/edMWdD91KW0CQ1Q==;5:4Ito4t0K/+ylHyHdIHIBjQWQjKIJq+s5W7L9h2LGXFPVF3calQhvugSoxUNgSI2XvAHFCVDzWIwu3CQgsm9OnuW8IMYUhO25BxMTtvAOSWbuHOGyiJMEPfgC6+G/bUt0bsvRc2qi+0yY7mMyriUIROSnp/q7mKmipX2lLA6frKo=;7:uQKXmAI3l7mdE/HupR2MPazMHmKhUWV+RjMwHz9c6L7OCP+PSOe9ptCKzUN7GTWQLqdS5Swedd3TdealwwHWWeEte1lruJ50MvS1PimBicDUwDb9CuPRFmGu2SloJo53e8Q/mKfbt+IIpOqg1fYERf2m1wF/9BaayfyPUWvGxv5qj6INA7FogDA+Qkxvmkvf0m2XldDukyeYwIYJZII5/1bZbxh/JEULhnMEeyPBOLQf+hmiAqsUdR9mlaSFxMX0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 08:06:17.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2370efe6-13e6-466d-b743-08d61c747317
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial dtsi file to support Synaptics AS370 SoC with quad
Cortex-A53 CPUs.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/synaptics/as370.dtsi | 173 +++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi

diff --git a/arch/arm64/boot/dts/synaptics/as370.dtsi b/arch/arm64/boot/dts/synaptics/as370.dtsi
new file mode 100644
index 000000000000..7331acf3874e
--- /dev/null
+++ b/arch/arm64/boot/dts/synaptics/as370.dtsi
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2018 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "syna,as370";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x3>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		l2: cache {
+			compatible = "cache";
+		};
+
+		idle-states {
+			entry-method = "psci";
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <75>;
+				exit-latency-us = <155>;
+				min-residency-us = <1000>;
+			};
+		};
+	};
+
+	osc: osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc@f7000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0xf7000000 0x1000000>;
+
+		gic: interrupt-controller@901000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x901000 0x1000>,
+			      <0x902000 0x2000>,
+			      <0x904000 0x2000>,
+			      <0x906000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		apb@e80000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe80000 0x10000>;
+
+			uart0: serial@c00 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0xc00 0x100>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			gpio0: gpio@1800 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x1800 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				porta: gpio-port@0 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <32>;
+					reg = <0>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
+			gpio1: gpio@2000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x2000 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				portb: gpio-port@1 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <32>;
+					reg = <0>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+		};
+	};
+};
-- 
2.19.0

