Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23425ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE6220666
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yGITmzmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE6220666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbeIXSQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:16:35 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:43072
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730171AbeIXSQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHfTce6XIrUNuTpqs821HkOHevujbW8EHLeERjp7C44=;
 b=yGITmzminRlP7aHBflvJL00h4kqT0VX/feyT8CGiVu1dImC4QH7DrtYvxHijElpu6kYY6//qIIRraSURuwLaGQxSILGkDvKNrXf6Msi7BUmxSA7LeVIh2P9As2wciBFjyMzsCfPo6UTxn0YszQEli2OvwbDxdu2jtWP1gDLfYCU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (2603:10a6:803:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 12:14:32 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
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
Subject: [PATCH v3 5/6] arm64: dts: add QorIQ LX2160A SoC support
Date:   Mon, 24 Sep 2018 05:39:00 +0530
Message-Id: <1537747741-6245-6-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::21) To VI1PR04MB4798.eurprd04.prod.outlook.com
 (2603:10a6:803:53::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986476a9-f80f-4c52-bf21-08d622174c2c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;3:wXn/+9BrozLirmZjjWZpG4BBhcDrv0+M+fh2E+FqT4rtKRFMFLuN/AW6N/2SlrXnvuSSVNV063NbxBIYdDvdowSODWGTB/gLtXx0zu1YV0OAp6q5YuAPvk94gx74OSY/4Ra76muISsQAD+bS3w1iU1hgBancecbDbk4SX5w7CpaHY2D7rBPVooWxN6ZbZUMv8zfAlh5Rp+06Qlw98HxfUaU1SyAdP5PEZXY/XisiqfmCFFmFyAf6u0dHfMkXPtRt;25:MdojyOodXGEkFYOFerw/GXRa3g2E3kC3Fu6tCNoWB99Dm/Ce3BUJ+l5ssYxHPHvyKsvr4+AO9iZ1fge8SY3z1Tvh/1Ssx+Zgqe5WZjYP2kRmSj7ilsj7DpaNgkQlNQl39HF5MiiWI8J1AQxWrCtCjtUrZ+0cpRykSXbs0iziA7HoCYyjltMFh/koZ/ufdUp6ZkpGFNUEwf7eNzlZpK1+nJZc1thMnJCjAB9NioL+yxEEiJn4BFXmx2YSYYURsuCIbYF3tLbncJS0N13QJD/Ibo+3s5QYhSpL/hxiVnV3YZF/QdFq6JFIQhwxdeAC+pxCOyNiTz2LSbTSxJ6BfLsE8Q==;31:B1VrKidnQDekW7lwFYG2ve/CVPPXwi6fLmyPBktNvF35YUbqAqN/qnbGU9ySLGTGivKFKL1PURdcokia0OyLy/irbp79ccVkk7NW0FtqfKv1lpvMyHOcH8TUpD37BsUifosUaprKUuuzSFwwiyxXw/65AiBxCYi7Uyyqh0fwf7jwKZD8uKPCg86QvByzIy5MzXnGpzJALHJKgvhsIplxcQ8BlGlzfnPwy3w6dRBM4Cs=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4798:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;20:i/IAUHiB68gTylMuWxZcuCX9sy1zvvfq1Xj8552cyvtw0Kq7EeO9MpD3HuuZ+zJbvOMZp+0Dyaq0Y+JSHW4nWhdXP8KAM+vC0KwsxdHICBB4CAqKT88HsOHHrDLNPVtDmK3GwVfc/vxO8jxFJIcP76OD6zPkmlSYd/dh0hcK7pcofuvVWHMUFwwueaSlYw/fL+soFAahioCOYDbINMk0J6J6SkVssmnvDJTobAxNvqyfkdTllOvSCJsif5AULyAJFRd7oJtBMg+Tm1wDkfQdw5wxMCXq1Fy36khVPsU8YxRMjy/YejUe0VcRvcJo5OdVWcRKtdGxyUMC2jabZ1vtfE851osGbK5zPRm1d2O8cHdfv6zLtip0OiHemj35GR2gH3j3vBRhoK9eRNT4tMq+TwaxhePPww6lrtAJj8C+lp6xXuRMcMHkC+XOtdD0Hq+9ALGuib4C5E4mYJ18njUgki2BaDtj1w/bX6fBdP6sKWDpGVvlGoxjGIG0tLpkFT3/;4:ZLGbmbOXkmETx9qy709LMndKw67wBOFS038r3XcYSKd2cgzpcRqrb68AyXavlBOqr9H2nYO+I/9KhTz3x2JlWedl7cmX8gyQxd1vsTjkkh/oeCf41tyc0VpVR9jYVtNO09oCoo0d2xH6FKQvApPkTmHuDqJ3aGadjPnXGxunMKvcskQ0bycW0D9MhyS/SwC1FnhRUrMLP6G3eR6B/KAKf8h2I5N2oxa6hCn53k7hIhRGu0o4pEKoBgZKuY/OERLlElKiVnVfilNzvS7QPWNnUg+Qv+PIkd+C6h/TUEmbrlJH+woBB6RR/fyx3TTXXVuI
X-Microsoft-Antispam-PRVS: <VI1PR04MB479817F6E30144FCBA30368DF3170@VI1PR04MB4798.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(97736004)(5660300001)(6512007)(14444005)(48376002)(6506007)(86362001)(47776003)(53936002)(386003)(6666003)(25786009)(52116002)(76176011)(51416003)(956004)(50466002)(186003)(7736002)(54906003)(81166006)(16586007)(7416002)(486006)(36756003)(575784001)(50226002)(6116002)(44832011)(68736007)(5009440100003)(26005)(446003)(305945005)(11346002)(16526019)(2906002)(66066001)(478600001)(106356001)(81156014)(105586002)(8936002)(2616005)(316002)(3846002)(476003)(8676002)(6486002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4798;23:2V83NRF6JKw28KzPJSUAcWfVmRu1XGIAJ25OmYdba?=
 =?us-ascii?Q?h1OecFbaTyEkhNMuwDdpvQFCqb0+raaxjKi/uqUs8gNgp5LHpuWJ4gfAs8UC?=
 =?us-ascii?Q?NPXKBu8JpSb5nMopMhkPlBHRfNEbmfZji2ngIXu0xZ97NmdtL+BQeqb6gn1f?=
 =?us-ascii?Q?T7T4OP0MQKebvAjqjklUyZSwv94al6fGWkNXXmdwlNsyEnDqjtLw3EGWDH1K?=
 =?us-ascii?Q?G7ab+Rr1ojMwtwEyF0pNxN0JeiDSsONYh1/3vssVYbLfKfoHVgWhkx/E5esd?=
 =?us-ascii?Q?RFxLiK98NG2JvlgC1nUMLwJ+xLGmOU7Iwvq1tVO1HCRDdcuJes74CadCI4i2?=
 =?us-ascii?Q?ARRbGMs61Nn9ayStV4Fg8v813CxVEEGxrPMruNpbohxOVbfBUeTV2+kEwQCX?=
 =?us-ascii?Q?vyYn6Dh4fjPXoajUu7vr2ZuoTdUpZbxk+9U+GAvmQU+epAUvn0R+nhKjBYF9?=
 =?us-ascii?Q?TMctqcnkEKNKDSAorrIyzywKFrjhmnQt+CSjhi6llwSCyjgy1zoV6y/Rqq6F?=
 =?us-ascii?Q?ZPOCUStKKqqcPDhOPo9fZ+6exTzOmPNs1pOMGyE2IIVCVa2eonN0KswoGrN7?=
 =?us-ascii?Q?oFTprf/qQ4vomvmbH/wKqrNRnMEvgvnXzrGzZAzvn4JLBS9YAfr/uPiPiwPY?=
 =?us-ascii?Q?6gs6AQxxpcKiFuStCMJ0qBIIy+BKwpM3RH7VLNqZkGzl/RvbMw/zLS5e39WV?=
 =?us-ascii?Q?YrivcHyHat9j5H5sf+xD7AlUXm21I9LZ7xXzZmZ/bvGcpLir2/5XZwQt6lKi?=
 =?us-ascii?Q?4/HYRMzR4/jFUicLrRwJOttqg3h05O3Ls9acyw5aDa2a8Evb1ZtiVTZgVPKp?=
 =?us-ascii?Q?s7f3DCDFUNb+4dL5fA8GZeoObxzJhBIERV+6sfiUHpxP3sEYLlfDNyosvKZH?=
 =?us-ascii?Q?lunGVDcPb420cQhQ8EoqcikYg2/GBhY3BAtdTKWDekCzio/pAyMC1c+rnGye?=
 =?us-ascii?Q?lNCBczTUetx/F5tzDSm1V7alhn8ww9xmgWgExUy0L4Im8ensdEsB8HwpZv/u?=
 =?us-ascii?Q?pmLf972XHa4bHKaRVt/yTjMP3uOen463qXNO/OCh3y6/x083eZVXkQfkxbd7?=
 =?us-ascii?Q?V+xofLrMpmDGEs3PdgwgOuT/udlEl6RRV7JDnHcINMCBtJ+I0fb9vjV4b9+a?=
 =?us-ascii?Q?PshncTWwuHzebEwNuutazXG1QfI41lexyBKlZemS8aWRXhUcdXqkDpN2l04f?=
 =?us-ascii?Q?4taiMl6aKysPGWcOfCzitOhVZH1ITttMYt/28o5Gf2Bsi6Ki3VxI4I1MbHlx?=
 =?us-ascii?Q?kqMeROIS90/cvv6DXt+7uVU7LP1XOTHwuwDtsR8Hj84rb9GUEEcuxebvnrwx?=
 =?us-ascii?Q?7D3XsWV38joCwwofMtLBB3wRMLXIzL9qUruwrjSMINC?=
X-Microsoft-Antispam-Message-Info: oMcfcKSljgrnNzAwD132gEatunWn6pApAxq312dm7ujN6TS9fJgOoH+fKY3mdWhODRqQuGgWcNsIgEHspbfLa1Zf/Vy7dpzpYwmiYz6dLlKhIOhYf9Pkkl2bT6Zc39WqLjIRlCNva7bHMoG7pasM65ozmmuB2X68EoWJViMAsJkTm5IEcu6/NoJFj0QZdJTaX4v3RQ+zmXcmz6Q50q/cnZbdbrOW7PGuqj/R+ZHYt4jMruS+Vh52k+5E7ZLCklPdKZiZ1ylZPwKo8vlGAqY5OTHuKCEktQ8V0NPMHdqsoYbc7EiEniEqm728erpqLLP6BCWfNV0FcWqaBn6EIyBTMNlYiH/IaMnL1jTI5Yoy0Nw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;6:ECwgtKnBXSe6D1srHF2tCOBSkDly7A3je/Sho+Gh8ge8lIFndXyWj9uxzTmjGaIV2M1+kkkhZN0SftDL4zrlSbNYdNChqeK+hVyNX85wxM4tFn+OIgfmZ55KjZnqb/iGukFaR/uvB6CuUoW24xDpKNZHuM4F/d87WUROma7K/XU5atJ3DFdrMOMflQ7+mcvtc4FGig1sgQ4nK/bgSaFTfVU0GiaDIKuE68wAxkg43NUBCq697P/tpnXVV2ayb0OqePRIYM7cEHDijUxHtVeXscm4gjHHKNbwYxvVsaOCrqfLeKBbuOPpFXNv4hUEEOGwbowxcobm5JvOXAGJ9EiE9wVJ9dRAid22q2B/jucCwDsz+53JRyRq4Wm27d/BU+b7V0iAO9qrRjOjYtU/YDF6ykBs/QughaepK7GmQghKZojK5xbh+VIyMGjlxw/nlhYrjDd+nHXQuqRhB4Vp278QlA==;5:DN8ZnlcoR1B4NAejI5fAWBjaB1VxygQOo7gwxAANh4RFgbMEguWMlOtwptYlY3snl0nJeE8Jdf1W4pRWOTosTc1uDHWih6rVPPyk8wziiJKqqR0KN397MUNW/pswtPlp6UXzsgOJmAKeRQWPcWd5zm8RcAVo+cZ+LasUzYJ+hd8=;7:vFA5z6jGVL5BXC2a9FarDhxVeS76dZ/rEC0dynDcAV6n249Pd4p071iLINgFT4l2mS4BEI78uUdxH94Gv5KCwjibwkaAO0a5ob0s/IBpf88HEPwsEKxk2mPfxBs5ga1H0kuxq9IUorX9dvbtviqPCwAqityoxnkwc1DinwzbQGWg82vNq6jy3YrXJgp/2Z+UBNg2nrdLYxD0CQNJBWgzsBPjWaPyJK2uqMpnNZOSiSsh9eFY8+PC0OoNRKEzveOU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:14:32.5845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 986476a9-f80f-4c52-bf21-08d622174c2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4798
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
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 693 +++++++++++++++++++++++++
 1 file changed, 693 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
new file mode 100644
index 0000000..46eea16
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -0,0 +1,693 @@
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
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x1>;
+			clocks = <&clockgen 1 0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x100>;
+			clocks = <&clockgen 1 1>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x101>;
+			clocks = <&clockgen 1 1>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x200>;
+			clocks = <&clockgen 1 2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x201>;
+			clocks = <&clockgen 1 2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x300>;
+			clocks = <&clockgen 1 3>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x301>;
+			clocks = <&clockgen 1 3>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x400>;
+			clocks = <&clockgen 1 4>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster4_l2>;
+		};
+
+		cpu@401 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x401>;
+			clocks = <&clockgen 1 4>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster4_l2>;
+		};
+
+		cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x500>;
+			clocks = <&clockgen 1 5>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster5_l2>;
+		};
+
+		cpu@501 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x501>;
+			clocks = <&clockgen 1 5>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster5_l2>;
+		};
+
+		cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x600>;
+			clocks = <&clockgen 1 6>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster6_l2>;
+		};
+
+		cpu@601 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x601>;
+			clocks = <&clockgen 1 6>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster6_l2>;
+		};
+
+		cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x700>;
+			clocks = <&clockgen 1 7>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster7_l2>;
+		};
+
+		cpu@701 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x701>;
+			clocks = <&clockgen 1 7>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster7_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster4_l2: l2-cache4 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster5_l2: l2-cache5 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster6_l2: l2-cache6 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster7_l2: l2-cache7 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
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
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 4>,
+			     <1 14 4>,
+			     <1 11 4>,
+			     <1 10 4>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a72-pmu";
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
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <0 80 0x4>; // Level high type
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status = "disabled";
+		};
+
+		usb1: usb3@3110000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3110000 0x0 0x10000>;
+			interrupts = <0 81 0x4>; // Level high type
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status = "disabled";
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

