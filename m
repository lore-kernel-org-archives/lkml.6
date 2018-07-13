Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93C7208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="GyTQjMig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93C7208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeGMJmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:42:25 -0400
Received: from mail-cys01nam02on0080.outbound.protection.outlook.com ([104.47.37.80]:10385
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbeGMJmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIcHCgYTwiDP9hr/qfZMTg14Ufds7yGW/udZ7U4m45I=;
 b=GyTQjMigokaLQMzrwzgA/OO47vEc48/cDzNuRb2ur3Nphr0zND85jjneHlvEIUbHYByQ2hLFmpwLbEsqCLZeskF3MAl1MiwxvPGWdX9+KkMr8mkXRvB1ouAFoFRoyv839iw9rUbX92KHzlW5ubAiCVf8X9gH4HUY8DLTXfCm0xI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 MWHPR03MB2640.namprd03.prod.outlook.com (2603:10b6:300:46::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Fri, 13 Jul 2018 09:28:27 +0000
Date:   Fri, 13 Jul 2018 17:26:26 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 3/3] arm64: dts: synaptics: add dtsi file for Synaptics
 AS370 SoC
Message-ID: <20180713172626.5ca0e30f@xhacker.debian>
In-Reply-To: <20180713171712.05f58a74@xhacker.debian>
References: <20180713171712.05f58a74@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MRXP264CA0031.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::19) To MWHPR03MB2640.namprd03.prod.outlook.com
 (2603:10b6:300:46::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a2ab78-c2be-4c88-a02c-08d5e8a2ff6a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2640;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;3:N7O05wVXJm0GRGCQsXbuytn5BGqi4YUJ4RtY/ciqCapZeA9HDeYev+4b7LIPM9bhQp23zYnifN2Pupf0JG8ccyczRDeQMHovNGs6uf0HlYcwg5fvgCWqmlVB46ObJy3Ecf+76RXE6Km+48BmHwZrNlTXP/N54i1eGKRc7MhBRGFXPDS7v9m3CuJcJAM80OlUgzR4yfIhtuCvp2DvPwf5TCP4b9B+TgmNOO6XIFy6xwEMbBRTt3ahuP0dqdNkM4PG;25:v/1m6Z658IFrS1p9ycysImc1boXSWJlVDWN7pJTeiJbqUPRdn9yZ8xPq8YYvKvjxQmGSWNzQ7vkj8llJrAZdNNV9t0wdiGtUHDwNBQCuMPAooh4rB9sqyXumyrhKpgeF4vYyZWD9kpk6aIqWYwtiYcpSBX2NhGtUswAvtezWpvMRZkgl3+aneK63eUbpYWeUj69LQgLEFmO6m825Mpu8jqtUp/URREhlrsgyNAHNXKIdAsV89aQ7GZMuJPj6sB/IUZ6Li+P+Rv4e+INCvPFV5KxHuKA7OKV26qaUJOleErRe5opC39CUDf5ZcDw76+9jkZYC6+92KqQgZQOe557MOQ==;31:sipmg95lKj2MEHFtGCCzK9TIoF7i83V/z+Yu6q0k1pbfKRqIYeP2v6SL2Gru2EkRQElPj9vTliiV3dVjyBytwaeJlXQyqQaUYeqVuRfTz/JNAeJq8zKDO+cDDNwHZFOeH20GHvGKcI07vMjTLJmgvi8wSCJ6OsLnnrYG0COAaAlZwHQ8UqIAkp892FhjLuHfr8B7B3SgKDP3UgTL7ThIjrqIH7K8ofzES+SDDbRu9xQ=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2640:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;20:4fQmMrHvuTryEu7oZP6Tv41LbZyPJkdqqjFLlDinbbc6NHeaIT7mL9m3om2iFbeqcBrriZD+HbjBeppAqI3c49o+8je4Gcf6qwUdgpkaFBywXo0xE6IX7+NYgaaDXHjCuvABsAIP/pHl/r2OGRsYLAUTE4IekaZl4yCrImfaw74QTHGu7T8MgHqyPvQZeDfXokmPTJjdY56YdbymYBix8Sq0Jv0AXlZ2qbS8fq9cOOKmVjqGjW2+h13JotvuhDiaNK07TLappzXFfg0r3ItTSWwORij2xt+DN6Y9qm2RVoPM66BKcEbozr3GfNndhUysrRqDMXAygKxEuCyNaWoDooU3wceqmUXVe/3Geh5DOTEEmDyFN9TS/T5IEiqDvqRfneaJvW1cWvDFSI8DxC9ARj1Vt9LrGvglp2TIHAh3w34/yo/0MWQcAWAv2+slLSSHK+duAhUmfBbj3vpdBIFhaed4AL3iFX2IDN2BElTYQpQPAKOh3m26hhsDsPD/319+;4:fuZnbf3kzNhEqFWwHtaGzpErQy2p/+j5uf3+vaQ+fgFVJS0xog7/1vUY8nbHN5zsfVQS+STfd2ZEeaSatAb7Y42ccXJfLp1HjvpUmSDNnSNN3qRf3lxrQ0JrVGfCL1QSR1b7yyz/vkFiccQUuFPPBVgLhSEHwL0NH3nYShSh5263A+Lh09VkBpoNG9slazoInj54caxWItw3UwnWbGohOrp5QyuS0u9pZTKVFIJjwUXKT2klr2cct8etXQhYunRLqwrx7e/7JzSW5/rFt1P0LQ==
X-Microsoft-Antispam-PRVS: <MWHPR03MB26405FD48AF6D171C05B12E3ED580@MWHPR03MB2640.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2640;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39850400004)(376002)(199004)(189003)(305945005)(47776003)(39060400002)(53936002)(478600001)(7736002)(97736004)(446003)(956004)(9686003)(11346002)(72206003)(476003)(486006)(86362001)(575784001)(50466002)(55016002)(105586002)(106356001)(68736007)(66066001)(25786009)(50226002)(2906002)(4326008)(230700001)(81166006)(3846002)(1076002)(8936002)(81156014)(8676002)(6116002)(23726003)(26005)(52116002)(7696005)(6506007)(386003)(76176011)(16526019)(186003)(14444005)(33896004)(5660300001)(316002)(110136005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2640;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2640;23:2oe7cwQO2Hmm0nDYH0+XSRa8ORuAunWMH9B6lirHr?=
 =?us-ascii?Q?DH4BgMmmba6P3NVsBWxl2k7hymNdbIUgK8ISrImq+4TJhrSVT8GrgnRAKAf+?=
 =?us-ascii?Q?qivT8lSVpxd1cTFpu3d2SXr1bLCdySJAyQH4Ua4/5nObcAJ7CU3ta0sH60KK?=
 =?us-ascii?Q?IA4gDq/tZvjkWQneBeUhKYEVXwDMhAVblZ3UxO0UkGQdUT8iUcB0atl0BDoj?=
 =?us-ascii?Q?Tm5O048dfF5+gWATLZ8VgEOrh6OathxQPTGx99gx0zexpOWpCcfzMx2Xkhzm?=
 =?us-ascii?Q?Rm7n6wMGRWcG0CbExZ6s+j11ZB7XbIoMvhToqByHbdOPQz7/iSUNKk2FvWUn?=
 =?us-ascii?Q?5fqlNpDaX8ED96q1MtOSauhNXGGEEqkYLbp2JmoB0kHQrBnfo3xljTfIbD66?=
 =?us-ascii?Q?Hwbxjo/XnFOXC3SGHQCB4mV2umlKCCZFEySKLDgfhcrkhk8soZSiPn06E5V1?=
 =?us-ascii?Q?u6ixabAp5lk5yoU8+AulaUaCbmZ05KUg6CLXyymXn0W4mwzn7ayRQ/LhP9ij?=
 =?us-ascii?Q?wgvGgXFg1QWAQPryDaMEN/kAVcaPy0RrlO2kN/WUsxJkI5b4UkrdkcXbh5iq?=
 =?us-ascii?Q?F1+CuvaSDXaHe2Rz6HhPNcI7zqDaiwmd7DOFOd2ptleHpA2XdcS3GZGWJxwS?=
 =?us-ascii?Q?W49lFfRmuLX8rxCC6qU0OU1qMgjN4cGaTr9URg/i977pSQXWaCMU6QMZtWl5?=
 =?us-ascii?Q?Zb2pZZ8SoKBLOIb5z8vCxLsr9f2OkplajpakU+fLerqI4HwBnCiTXsvc+EnB?=
 =?us-ascii?Q?u0mqwqCe06utNJ6wLhiunHMx+G5ZOUB9OCO+3L4TIsUXjJObBDGw7AX6BPtm?=
 =?us-ascii?Q?vxX03pskl0fBKZ7gw/Gsdt0TSR5uw5UHje/W3sX9Su6lGGewCnlWmalZkEbl?=
 =?us-ascii?Q?WuzKvYaj+k1S1j1Pda5bVAY7OCLv9s2Nqi3wwdClcksnZ6IWaEMdlQmuNTia?=
 =?us-ascii?Q?yJfahRcXRxTtYYGYg+yJqNw/UGFK5Cw/Ew0xy23XRxYyvXz2+898fNVjA8Lb?=
 =?us-ascii?Q?9zERUuIcZcmsgo6/yNyk8hkvT+mL0jTWq+NRufUexYDU1n3vrK2WwbJon+v2?=
 =?us-ascii?Q?3UFiRVM/TyEBLBWmqImtgNKalLn7v4gyCtXhJBbNKOaWCfgPieLifcSbZ8RK?=
 =?us-ascii?Q?d7nQ84fKYa5vtz43qdAZX/D/5Hn8fe6PofSjY3fluu64fC9XT5IkR60nLKUn?=
 =?us-ascii?Q?OlXbAvQtgFE3ZbpxxZQOuZyx3rS9puL70bx6nNtc4txBftr375KxqHoxfFCi?=
 =?us-ascii?Q?KiSam6VvdJx7p7j9DFtnX//fEswN6JL0ktemz3b?=
X-Microsoft-Antispam-Message-Info: 0AUM35OEj/9vQKFkMmUnILxeqshOKUAXqb+gfGHO3BSH/5VwIWhSQh32099/K/d9Lgr00PsJ4wmJwowGM+DxYuOS4DQv8TdkZzZsEYWjSBa7hdosjTHMchJobGzvGLZ1oCuCExLk4IoFZ/mEfMXpQpxcbD3kIa8sz/810KfJjGWNfZNp7iZk5ZQZfDZfEyTCDUTD7PLIOCrXPHM+saPMcHEjU7/47kSzFUDqYxXvfBDH5FMvzLKxiLjymJ7mPdX+UQ/t6GyHIvViyTPUHdTIpwVU9OT4jjLIjxzScupDS7qFlpeReAL0cn82Z/CHdfmxpLTw3UScmt0g69BybKv4GlbmH/U7rnDP8htLotqgIxk=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;6:nnSEmr8zGIM3y3JoxJxpi/2m11z5M8Xlg2n0iXkVDWYMarVI9ShmCs502uVhU48qJ+6QfZxWQ1WcLHg5LNSq1HhlNOX4gzLwe2+PbtcyFQ6lLz3qcBvVLk60LBEt2GTI8jyiAk+lED6Rg1YJs//soTYlY0gzzNSyJEWtoNZhAwOJM6NmV1WviHYbW8LzIyYolWyNIj7jVXlPC8C1f5aMlNOKa069Ov/bnMMUTilKQoY4tU8NXPL2Gj/6u7FUqQ5QZPUV84P5bLbWnich1MZCJwxOYxKfwc8S+NT8nzXRzu2f7KpPd2jiUSdr6LkyNmIkcJFWZRnhY2fJVpkHN64o4IUHBr0Yhsv4XSml5qkCYe08xO0AgP1YjESSIrwXuEsjlKNapKS494hMwsLJaaS8OPX+SKL4y4ITPiJ89Wwu5p+kwf2ik16p92lNfZsDpNxn0FFO/LhYODJ4q5xfFa1EDQ==;5:mJQ2zC/UrCAZYpVLnosuhlmzZSf7E7GffvuLVosAbSRXhQvS684dEQ3e1jGSNid397BsK2ErPb1v3dBnt7Bw6Eex6CmUwRxA7qiYhAP6Co4do1NeODkPc7pG0V3UnV4yYqC/tVxEGH7E39C9DRuLTqLYrH9NlifOyYYgE19MNlo=;24:3/GxDn41NmoPq7A2qmNbE6UslBxiQT//tOVbELjkJuGbViXsJ8AfPusE81g53shHmBIOnLjgsc6ec+OhKcAxNl3TKuWVdgX+N/kcz+Xl7Pc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;7:SZEQMhw8TwPtVnXs0M5YmPIJNO0Efz/4OycbTvjcaDLEIjIweL58L8oTOpFRp5S9WiV+e6Wg3zDQjcZNL5/iQ9IJ/WW9lrWm1leCdAkBQDyUVA+50JwHJ3QYhFo2LRE7PAmFiFoJb9CZrZ3LUV/twTglKqvSPLi78t3SEi3he1IyDLMSQI0O6N5ENBz31nzEgY0W9qALUrLog/GWX4QKPoZ/Vs+IfsmS7ZSFD9nN6XQBiRISenW87pUoxSwG9jlO
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 09:28:27.8241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a2ab78-c2be-4c88-a02c-08d5e8a2ff6a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial dtsi file to support Synaptics AS370 SoC with quad
Cortex-A53 CPUs.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/synaptics/as370.dtsi | 177 +++++++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi

diff --git a/arch/arm64/boot/dts/synaptics/as370.dtsi b/arch/arm64/boot/dts/synaptics/as370.dtsi
new file mode 100644
index 000000000000..20f3d658c566
--- /dev/null
+++ b/arch/arm64/boot/dts/synaptics/as370.dtsi
@@ -0,0 +1,177 @@
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
+	aliases {
+		serial0 = &uart0;
+	};
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
+			uart0: uart@0c00 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x0c00 0x100>;
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
2.18.0

