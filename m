Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBEFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14C120896
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ae94tq8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14C120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeHTWJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:09:08 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:28224
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbeHTWJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaDiJlIYnfjlDPxPYby383KqQPKNcP+PPIQNJh8mrZo=;
 b=ae94tq8r1UhVJOBt7yTR+ZmxqinhA3wCcuNuJ38KMQTWgx1WBB2a+aILnGFJMwNbrb2aB0/aH1eLXWwh1kEffk1bQw+vMqu8jl7naa0cmC6ZctZkda1Y4Xn2Hctc+CpgS7YXNZEN6OhVTiDrW7wUVd5qgJ50Anbuxu/itqodHhw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 18:52:10 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Ramneek Mehresh <ramneek.mehresh@nxp.com>,
        Zhang Ying-22455 <ying.zhang22455@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>
Subject: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
Date:   Mon, 20 Aug 2018 12:17:15 +0530
Message-Id: <1534747636-20064-5-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::30)
 To VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06cbe479-3e9b-4dc6-e2a4-08d606ce0bdd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4799;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;3:Mlb7BKwr8Grb6lhlAg+1zOb7lCnIOKj6GQjgiY7cs1i/206xZrAz/cLNdpGV+UjG34g/SBMIsxUWIQuBOOYtuB4zie10Q3z+pjDz24Hlimpi2pwFhZS0e9YJoDr2Ax36IsWcnZhKe8Z/JkdSUcYAn6YZeJtJXz43HJ2nHGTH/b1ga672eQ/anLfuoCaOMQCIlpZ+WBK6y+WcqmXieeQix35sJgrRwwvbFBZVXRy1aulK9ULxwy4EAlTSeOfR9yJN;25:zh5MWxqUv8U/vrswjtQVsJMGvFqXsVpaEPKqtQiGkDVRCbBbSdSlX90TTwCeuM/0vZ2j9EhUxM4t+rtGktNq654h5Vw9bz44xRrZjfjUa0ZYo+4iVf7x0I3etKhlYrUNnAxT/lXedfpPDWX/kphJcxE2ltNLYRMjckxKqFkTdlD+WHVmG635Qh5ol3eqIvc9bGMXIm6IqD5/wnPSx4tWHhW5NJAyBzS9RsYFe6+Gt/WO0lu8xmk784OISpJs5YMoSRdCPkTa2+gNzKQJI38UQm45tm6n6oIIFoNdD1eABxsYI/7BU5XKS9owM6OkGJ9NPmyuoFvX7HdaoDSqs0pUYA==;31:qGo8jHNnrsBS+t0xNtTKthgUPrdP0dlmsWOVpw1sxooJakW97K5caFGl6ZQsw5pn6tgutRQqwLvgO3RJGPbQhvCdoOJs4Z5fROfb+k5ICsRFtCCu34aEczLpWxMDhWQrl4kN+w69b4nK0aEPDckVMo1/Tsb/YokYo/pKu000woPGh2NPcYnWRc2v0jyZn8zVusUP1QmO46Y7Pb3te5ni0AWZLB063lv6nrpaoyeYcus=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4799:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;20:memyzQQAXo1AdbgkXBngSGWcFOQtkH7Ghdln8VQp/Ezy7+dcv14WaXYDfCGxi3gKh7YRD5uueIjiGNvLN2e++d40OkKiLFRe4R89IC8DYwpYQsquhqbuYErSmPKKnE3KPZMpoxiBLhRhSR2eFgo+44mutnCfMozbBicgxNjcsCRTUOsPdqeMDvAdvyRLLWOlroXvhDTPXXJuSxBj3CvRT/WDrDdAlX+huIuqw/M3HO/dbmz7tMJBwUnUMM5/jbr8tEjRjzoAsuiiN4/i2eyNtwAc4bPHUls8Miyzv7ZHGLpJ8W2yIE69SdA2zbuu4x17F42pQ+M1yxrwLgD6m2+WHHwjejKtWalgLcIBR/41XhGvFB3F5vvtqHzW6d6P7Q2EcNaB1M2zNo11pJc7IHttrlKkwc49Af925tljem8xbpjZFijSq1NY5XwbZGI2EBjPPUbqk2fj8IgYCaB7N2cjhN/446zhxDIldd/5RIxeBSTluuJc6zUttzoZ6MHKlBVf;4:O7P2Cl7f5hxWEUZa1Dezar9o7316Z39N7xkxvvnXiIyjUzu/KvW9gE7V17nKPOqBMooGiZsOs7k367akUEh+ldMz+qRW1ytTxy1zQe/jkzi4/ZfmVHu1FtWnoNoyAgDyr63WhMQbb2uaTQ3k3FBWt6vIkwKMaInbcmZqLhw2zICa3kUOm3+bDkKzgvXM+c+HufXYTdMT/UGN4cFtHW8FhPj9XhmsIR1HrrPFCTmtdmQu8dqBAxQnwqmvt4KEfnX8wsuRefwUattiNBO54dintK79E/CN1UtEMDk2snXyIGUGb0EPieDwZGVxKWBm9DPG
X-Microsoft-Antispam-PRVS: <VI1PR04MB479990D87F5AFD5EA5217AC0F3320@VI1PR04MB4799.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR04MB4799;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4799;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(8676002)(36756003)(7736002)(81156014)(81166006)(305945005)(16526019)(186003)(26005)(478600001)(25786009)(4326008)(386003)(6506007)(48376002)(55236004)(50466002)(106356001)(5009440100003)(3846002)(105586002)(5660300001)(44832011)(7416002)(14444005)(6116002)(51416003)(52116002)(76176011)(2906002)(316002)(16586007)(54906003)(8936002)(476003)(6486002)(486006)(66066001)(47776003)(6512007)(86362001)(446003)(11346002)(575784001)(68736007)(97736004)(53936002)(956004)(2616005)(50226002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4799;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4799;23:YOZ2+vNvW4T8V9fv5jwo92t9s+8Y3e6O8686/mBwh?=
 =?us-ascii?Q?t/3iFuBWp7+EVJ6+SKX1/IvTRiWo1bQfUExdSoGx5jpIXp1o7ptneLlY9Nvt?=
 =?us-ascii?Q?vBcKqHffzKcCyD7MoqLfwvn4oa3+ouQ8dFB/WuqYyVqVEXNlDB+2E1oNweWD?=
 =?us-ascii?Q?bcy+NAIvgvd22aNN+FnxJgZOAQo3S4ZdKheyzIA5Cq0X8otHgJy1utwV2au6?=
 =?us-ascii?Q?jzVVGzA9RlliwAipcyxi20QDMcX7Y5YBVTyDTMy8VcPczhGfiz4VODEWLtZR?=
 =?us-ascii?Q?d8b7qd35GVEtUVSdp3IA+Sv+Nf4E5DrA3tNUINONx1hVKBh1QM2a+ghVZCF+?=
 =?us-ascii?Q?65deuaQ+QD2jg8dC+BeJ1BB06YEBUOqWSCUd/uSJ6Ui2Qu8bWvqHqsSYt1S7?=
 =?us-ascii?Q?aWvmVYe+gbn6JQOlmx2opihT7QqC8K9n2IGXS4/5+zSbDBAm9JiAHoitWd5M?=
 =?us-ascii?Q?Xew9O/VA32lBQyPHY2Jex69WrIbUMlxqJmtYzireMuV+XwMALxIHHWx1YqTK?=
 =?us-ascii?Q?RYgrzAiY0jnbrf99mMAJ0ML1wQmkUWUQW3EVknBlGozKmx7GwHpwPhumnKWQ?=
 =?us-ascii?Q?c4GAUw2+omRfTP6z3FAZ/jKljKstCqW3I8+G+gkYJwF0Gp8aeV8p3Hr3XHJk?=
 =?us-ascii?Q?cVvR4MuqpdTpi3c0x9wk69Hmie9z/IybiReoBAYoQzZ4sibYKBO0i3yhMdDC?=
 =?us-ascii?Q?fgIjxXtVJP8pXUKUINPSOVLA8iFT9NPrS71mdOKUdUGIDyJoHDpRK8h0TqCv?=
 =?us-ascii?Q?IkoyzKepdfh4yjDpu1dLwJxwV4yTteOl+MBB+zjBRrOzLR8VdDSAyZPcJVDc?=
 =?us-ascii?Q?Uz9KV11DZkelwoRgZ4seWa9ZxE1XLElk4wBD/sJZusaYEczAutSbAUVKEUtF?=
 =?us-ascii?Q?xN98tsdNfy72ZmHeHOMAdl/m3+XH4l2ZF7lp7F4mQBeD7q5ZluQSrkNEOv0T?=
 =?us-ascii?Q?s4Waf+w6+0/iIc57/1AR9/wwwts+OXRenx/x0X4RgeDiN8K+WWrhOFn0Mkoy?=
 =?us-ascii?Q?o/wxRYNWuvujcZtVqd1yx8cva8fih39j77B/5s1KAk44GbhiizOHluE6Vrfe?=
 =?us-ascii?Q?X/LTd60D4UC0aNQdULPKEhFPx9UyhKITup9dcR/U0uwpaorfo/vcSZdtoaYw?=
 =?us-ascii?Q?YqF0tpIQvecE3weqIm9481V3A4XJ651l3Qc4OzohYajVICBl95Ga7llvwBry?=
 =?us-ascii?Q?rfDFPu/ciTD3zVhima1oypyIerF/XtTlgRmW8xiOwf1nuxu9hqw8J4Wd+/Ks?=
 =?us-ascii?Q?E7OWomMbqI3/xEZFzDBzVMTHG7whqANuKv7Ns1/CVhPINxLd0C6V2ytvloRX?=
 =?us-ascii?Q?vLY2q88kGhxtFeNitb0ITQmac6p7QEj/4woPa/6OTOuAHxhU0BJjQwpgrU/c?=
 =?us-ascii?Q?7fQXw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2bkOBop03SEWKW80VCXdJ8rhMcyXQgDeQ1n4bN0I/0s+28nNavS4ZNLKqR/sHca/6zniPlUeNSueXWyiWWAJIvuDiCDlopI3e1WXNUJ22gWNKRgA28niMvh9bnT60m5eWSEpJMTal8MAJaYZ1La1DC0IPB7xG5c+eotLu4Z35n6e5LVxiXtXkadgutEy5W1s+csFN1uvUM1vyasyqaF/8FnqH57d19szx4BrKhgHlpEtxyhe1LqQc1zYEnZRx474b0/H+5jTQMOC0Xm/3nNhlr4d5/syLVkgNZt7GX/yNtzM0nRGNO4PoyqkkYrZ3iYsM32tN+3idNC0oWhEUFyhIiBCKmAETMja+nezaLTmL7c=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;6:+PRacPOoRksXaB6jseQZVcxhMVeli9eXvWXYGLl+lR8DQYyCiqLv1wjE/CqBzRENvvvl+5tPew47YUhzr4mcGuN9D8kWEpZ+B0H6JVLGuCoDNUArkfjgf6mISpo+NkeW8HymISkj1HZy9EWyzi5ECSZ/aF8rvMiYP1e//VGjokVwfV5L7WM/Fp5m7ZgBvjLwe2h0Cf1bed6jShiv6fxQL7rFsLWrc48s2R+t0tNHnFwbjoLlGdbZ3LVQthvN9al4lgpxOw/NMvHYxcH31yEU7kmgvqPOWykTMNe85b2wdEWO5uQ9PxpiqtvICKjFFYjIid8dU5fnKFTP71jDKAePYdsiPfOT6htZSEE7j9k/QkKo8xvh5/YHI9UjGKXZPku9k8csHKEVv+tGXWlQkkzvL6fukiv6KW7/gIiIoE18M72bimvAxHOXMghE3OvsBgL5DW8jN8qjesF29KRmg+51OA==;5:BoUciDbHdj8nrOhNLJt4vz8MnVFY9+7v0N0kKFtvrE85c/Xtpj3dxoNb4hqUWu64gaXBnjrjjEBsh5LXA4yKqgPPRNilc/iqu6vxsbNRz9rUPAvycMlmQdzMI/8kU2SEBKlsZJm+LlLpEH+ku3SXHXXDME3SaPRPWsCyIwE6iEk=;7:yP1jz01GG3JuQQSo0NeqLippsxoCVi5qMSIiIe400gEOqnw9B5rhj8k/wG14OfoiVtZCLDnZk2bz75Qe56xMsHyyOoNdfAPTr7j8JYFkaG6M/8z2AXwEPKIXZmPml8esRn0eDR4u4Ctq/wkqfegBN2c11HAM5GaUH5tvMlHHJUkNIknh+dbmPLM+yno58GGT2G+Tw4meaeM3sp64MF27johMtgJTsQg7SSid8RE3Q3rUb0jF6r+TYVTYh3HmOLEV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 18:52:10.4600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cbe479-3e9b-4dc6-e2a4-08d606ce0bdd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.

LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor cores
in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8 I2C
controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011 SBSA
UARTs etc.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 572 +++++++++++++++++++++++++
 1 file changed, 572 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
new file mode 100644
index 0000000..e35e494
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree Include file for Layerscape-LX2160A family SoC.
+//
+// Copyright 2018 NXP
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	compatible = "fsl,lx2160a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		// 8 clusters having 2 Cortex-A72 cores each
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x0>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x1>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x100>;
+			clocks = <&clockgen 1 1>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x101>;
+			clocks = <&clockgen 1 1>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x200>;
+			clocks = <&clockgen 1 2>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x201>;
+			clocks = <&clockgen 1 2>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x300>;
+			clocks = <&clockgen 1 3>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x301>;
+			clocks = <&clockgen 1 3>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x400>;
+			clocks = <&clockgen 1 4>;
+			next-level-cache = <&cluster4_l2>;
+		};
+
+		cpu@401 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x401>;
+			clocks = <&clockgen 1 4>;
+			next-level-cache = <&cluster4_l2>;
+		};
+
+		cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x500>;
+			clocks = <&clockgen 1 5>;
+			next-level-cache = <&cluster5_l2>;
+		};
+
+		cpu@501 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x501>;
+			clocks = <&clockgen 1 5>;
+			next-level-cache = <&cluster5_l2>;
+		};
+
+		cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x600>;
+			clocks = <&clockgen 1 6>;
+			next-level-cache = <&cluster6_l2>;
+		};
+
+		cpu@601 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x601>;
+			clocks = <&clockgen 1 6>;
+			next-level-cache = <&cluster6_l2>;
+		};
+
+		cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x700>;
+			clocks = <&clockgen 1 7>;
+			next-level-cache = <&cluster7_l2>;
+		};
+
+		cpu@701 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x701>;
+			clocks = <&clockgen 1 7>;
+			next-level-cache = <&cluster7_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible = "cache";
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible = "cache";
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible = "cache";
+		};
+
+		cluster4_l2: l2-cache4 {
+			compatible = "cache";
+		};
+
+		cluster5_l2: l2-cache5 {
+			compatible = "cache";
+		};
+
+		cluster6_l2: l2-cache6 {
+			compatible = "cache";
+		};
+
+		cluster7_l2: l2-cache7 {
+			compatible = "cache";
+		};
+	};
+
+	gic: interrupt-controller@6000000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x06000000 0 0x10000>, // GIC Dist
+			<0x0 0x06200000 0 0x200000>, // GICR (RD_base +
+						     // SGI_base)
+			<0x0 0x0c0c0000 0 0x2000>, // GICC
+			<0x0 0x0c0d0000 0 0x1000>, // GICH
+			<0x0 0x0c0e0000 0 0x20000>; // GICV
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		interrupts = <1 9 0x4>;
+
+		its: gic-its@6020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x6020000 0 0x20000>;
+		};
+	};
+
+	rstcr: syscon@1e60000 {
+		compatible = "syscon";
+		reg = <0x0 0x1e60000 0x0 0x4>;
+	};
+
+	reboot {
+		compatible ="syscon-reboot";
+		regmap = <&rstcr>;
+		offset = <0x0>;
+		mask = <0x2>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 4>, // Physical Secure PPI, active-low
+			     <1 14 4>, // Physical Non-Secure PPI, active-low
+			     <1 11 4>, // Virtual PPI, active-low
+			     <1 10 4>; // Hypervisor PPI, active-low
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <1 7 0x8>; // PMU PPI, Level low type
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	memory@80000000 {
+		// DRAM space - 1, size : 2 GB DRAM
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>;
+	};
+
+	ddr1: memory-controller@1080000 {
+		compatible = "fsl,qoriq-memory-controller";
+		reg = <0x0 0x1080000 0x0 0x1000>;
+		interrupts = <0 17 0x4>;
+		little-endian;
+	};
+
+	ddr2: memory-controller@1090000 {
+		compatible = "fsl,qoriq-memory-controller";
+		reg = <0x0 0x1090000 0x0 0x1000>;
+		interrupts = <0 18 0x4>;
+		little-endian;
+	};
+
+	sysclk: sysclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "sysclk";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clockgen: clocking@1300000 {
+			compatible = "fsl,lx2160a-clockgen";
+			reg = <0 0x1300000 0 0xa0000>;
+			#clock-cells = <2>;
+			clocks = <&sysclk>;
+		};
+
+		crypto: crypto@8000000 {
+			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
+			fsl,sec-era = <10>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00 0x8000000 0x100000>;
+			reg = <0x00 0x8000000 0x0 0x100000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+			status = "disabled";
+
+			sec_jr0: jr@10000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x10000 0x10000>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr@20000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x20000 0x10000>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr@30000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x30000 0x10000>;
+				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr@40000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x40000 0x10000>;
+				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		dcfg: dcfg@1e00000 {
+			compatible = "fsl,lx2160a-dcfg", "syscon";
+			reg = <0x0 0x1e00000 0x0 0x10000>;
+			little-endian;
+		};
+
+		gpio0: gpio@2300000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2300000 0x0 0x10000>;
+			interrupts = <0 36 0x4>; // Level high type
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio@2310000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2310000 0x0 0x10000>;
+			interrupts = <0 36 0x4>; // Level high type
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio@2320000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2320000 0x0 0x10000>;
+			interrupts = <0 37 0x4>; // Level high type
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio@2330000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2330000 0x0 0x10000>;
+			interrupts = <0 37 0x4>; // Level high type
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+
+		i2c0: i2c@2000000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2000000 0x0 0x10000>;
+			interrupts = <0 34 0x4>; // Level high type
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			fsl-scl-gpio = <&gpio2 15 0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@2010000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2010000 0x0 0x10000>;
+			interrupts = <0 34 0x4>; // Level high type
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@2020000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2020000 0x0 0x10000>;
+			interrupts = <0 35 0x4>; // Level high type
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@2030000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2030000 0x0 0x10000>;
+			interrupts = <0 35 0x4>; // Level high type
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@2040000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2040000 0x0 0x10000>;
+			interrupts = <0 74 0x4>; // Level high type
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			fsl-scl-gpio = <&gpio2 16 0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@2050000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2050000 0x0 0x10000>;
+			interrupts = <0 74 0x4>; // Level high type
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@2060000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2060000 0x0 0x10000>;
+			interrupts = <0 75 0x4>; // Level high type
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@2070000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2070000 0x0 0x10000>;
+			interrupts = <0 75 0x4>; // Level high type
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		uart0: serial@21c0000 {
+			device_type = "serial";
+			compatible = "arm,pl011","arm,sbsa-uart";
+			reg = <0x0 0x21c0000 0x0 0x1000>;
+			interrupts = <0 32 0x4>;	// Level high type
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart1: serial@21d0000 {
+			device_type = "serial";
+			compatible = "arm,pl011","arm,sbsa-uart";
+			reg = <0x0 0x21d0000 0x0 0x1000>;
+			interrupts = <0 33 0x4>;	// Level high type
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart2: serial@21e0000 {
+			device_type = "serial";
+			compatible = "arm,pl011","arm,sbsa-uart";
+			reg = <0x0 0x21e0000 0x0 0x1000>;
+			interrupts = <0 72 0x4>;	// Level high type
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart3: serial@21f0000 {
+			device_type = "serial";
+			compatible = "arm,pl011","arm,sbsa-uart";
+			reg = <0x0 0x21f0000 0x0 0x1000>;
+			interrupts = <0 73 0x4>;	// Level high type
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		smmu: iommu@5000000 {
+			compatible = "arm,mmu-500";
+			reg = <0 0x5000000 0 0x800000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <14>;
+			interrupts = <0 13 4>, // global secure fault
+				     <0 14 4>, // combined secure interrupt
+				     <0 15 4>, // global non-secure fault
+				     <0 16 4>, // combined non-secure interrupt
+				// performance counter interrupts 0-9
+				     <0 211 4>, <0 212 4>,
+				     <0 213 4>, <0 214 4>,
+				     <0 215 4>, <0 216 4>,
+				     <0 217 4>, <0 218 4>,
+				     <0 219 4>, <0 220 4>,
+				// per context interrupt, 64 interrupts
+				     <0 146 4>, <0 147 4>,
+				     <0 148 4>, <0 149 4>,
+				     <0 150 4>, <0 151 4>,
+				     <0 152 4>, <0 153 4>,
+				     <0 154 4>, <0 155 4>,
+				     <0 156 4>, <0 157 4>,
+				     <0 158 4>, <0 159 4>,
+				     <0 160 4>, <0 161 4>,
+				     <0 162 4>, <0 163 4>,
+				     <0 164 4>, <0 165 4>,
+				     <0 166 4>, <0 167 4>,
+				     <0 168 4>, <0 169 4>,
+				     <0 170 4>, <0 171 4>,
+				     <0 172 4>, <0 173 4>,
+				     <0 174 4>, <0 175 4>,
+				     <0 176 4>, <0 177 4>,
+				     <0 178 4>, <0 179 4>,
+				     <0 180 4>, <0 181 4>,
+				     <0 182 4>, <0 183 4>,
+				     <0 184 4>, <0 185 4>,
+				     <0 186 4>, <0 187 4>,
+				     <0 188 4>, <0 189 4>,
+				     <0 190 4>, <0 191 4>,
+				     <0 192 4>, <0 193 4>,
+				     <0 194 4>, <0 195 4>,
+				     <0 196 4>, <0 197 4>,
+				     <0 198 4>, <0 199 4>,
+				     <0 200 4>, <0 201 4>,
+				     <0 202 4>, <0 203 4>,
+				     <0 204 4>, <0 205 4>,
+				     <0 206 4>, <0 207 4>,
+				     <0 208 4>, <0 209 4>;
+			dma-coherent;
+		};
+
+		usb0: usb3@3100000 {
+			status = "disabled";
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <0 80 0x4>; // Level high type
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+		};
+
+		usb1: usb3@3110000 {
+			status = "disabled";
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3110000 0x0 0x10000>;
+			interrupts = <0 81 0x4>; // Level high type
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+		};
+
+		watchdog@23a0000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0x23a0000 0 0x1000>,
+			      <0x0 0x2390000 0 0x1000>;
+			interrupts = <0 59 4>;
+			timeout-sec = <30>;
+		};
+
+	};
+};
-- 
2.7.4

