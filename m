Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeBEJdq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:33:46 -0500
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com ([104.47.32.48]:7146
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751705AbeBEJdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:33:39 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <rui.zhang@intel.com>, <edubezval@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux@armlinux.org.uk>
CC: <Linux-imx@nxp.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V3 1/2] ARM: dts: imx7s: add temperature monitor support
Date: Mon, 5 Feb 2018 16:12:26 +0800
Message-ID: <1517818347-7436-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131622968174276956;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(36756003)(104016004)(305945005)(107886003)(450100002)(51416003)(68736007)(4326008)(356003)(8936002)(81156014)(97736004)(81166006)(8676002)(72206003)(2906002)(48376002)(105606002)(50466002)(26826003)(50226002)(85426001)(2201001)(498600001)(47776003)(106466001)(336011)(26005)(77096007)(54906003)(86362001)(53936002)(110136005)(16586007)(316002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB469;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC009;1:L3g5ZdqOKEjJTsA3zVd13cecGSDR2HZ6kr2QCirHBnINNzPB4NamYoXe7aJ8rFm4JOZulD75oW/k+y3qszEzDcXmrCuVHe6tSVNcmykGBFj0qxPjmu6CICLt+p3pTW6m
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8394c50-7d6c-4fcd-0ffe-08d56c7b88c4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB469;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB469;3:DkT++lRxQS+4UOTxXvufyLirjeaHFlAPvdSvXsissfPnQUEiTeorRFZj2albwOgZHvotcYaFY/HhOd4gSHNZnbHK8tbjHNFCZi99Hr2Gj0fv77bEMeVZpwwj/HQ5emk+kSVwe5pRXu2yLVcgoBwfgPh1i4Eovq2kHQcIo+N3GJKu2CZQRE1yp0WMB5y1Wc3OZrU7Bsn4XJ1WqpyAPymkC5Zahn/Y98NC6dCze+HvcefyjMu4pphK1vKTkbDsuGJBCj4c5w9SSXfNQAsrlyxhNSeK1AYLvhf+BXOLL6oRfs++AHRExiffIEk04i7Tb48g8mTu4VkQi5gP6D1gAURJEzfnBlFrjs078RqcYIik0SQ=;25:HsKHD/Z+UUIKuDpWNgHcirdS8DVjmD4Pt84jI2AYM/Km8uLJfNxJUoRTnWeyyFKbiaBU9LzVSVzL+0gGlwTCpusnWpqgiiBwUs9PYU7haEtQ2ZHh7VrKArpBpczSIK9xkeOGz2wi64FGjihu4KAcrktYEFLhrmD+o8VwqH74zmcB1pyJ+d8pss1eSSxvms71nWqGcZULtdJpMAKq9TJI/CVh3mNzRzMywENnuhX/AbXg5BwniHwFu9Lbk2MZ9CLCOAggKjxQIRxgfyHENSwCZeljSQyVlp/0BOMzddMvBke0CppP1xhk41vU6MUQWmYRohZdN4mKPYCzR0i5EvZR5g==
X-MS-TrafficTypeDiagnostic: BLUPR03MB469:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB469;31:Tob4/govB1O3fsHNXoHTAPXYXe0Evk6SBWs4qo5f4a1FzIDrxsMpMTTTwMO1QkIc49REY7AqCHOb5t3zetYnEcjNcS5rtANQrhCLyW5wRicnAhwDPbu0YQgRH1uGE4QmAu5aPAvz7yxkPfBG/YAYWx3w86kSmjTGq6JZi6VifuQVHdeEBMiR+1XtnN7HApqqnP7M0Ih8p0V+wPFoTxB6K9pnNguc8yRVhA02nEBM/HQ=;4:mS4yhPXmHnBHw+hObReMRquq5tbYQqd5qk1mXjix1LPRCaW6b5BLmiPTo1ycAYUp2idJCP28KXvPx4FTZZuVRKq2GoAV9QEZ/Mqwycip3oYUoPnLzse7WEJ01yVxDW5b4JLOZZEOPzdltLziZLIBuIcHkHSAe4nUfx4GeLG1ZNGLtXfwHt2IUzISgv2gOYVb+ubQ0oj7nR8xAccKJ0BXxHjEwFaC3r+mJ42Dey8KKNHtpsARg6UnKL502uQ3j/YQK59/5Hor6gPqnJkjfWClvGhifFrqlojkWJOC4cHeLej7wV/xWFEM2H3Dfx1S6QDS
X-Microsoft-Antispam-PRVS: <BLUPR03MB469B601D55F72A0FBFE147EF5FE0@BLUPR03MB469.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231101)(2400082)(944501161)(6055026)(6096035)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(20161123561025)(20161123556025)(20161123565025)(201708071742011);SRVR:BLUPR03MB469;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB469;
X-Forefront-PRVS: 0574D4712B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB469;23:fzJeBklnlKZYVnYnWeZrGckLA0WpE7bLfwQmH9RVeJ?=
 =?us-ascii?Q?uTp6o7+NrwieVzGKhibLMIT/mHpP1OcAqLWgVCvyi/KZWy7pYMp4nfb6+UYc?=
 =?us-ascii?Q?oUVRjy/LvD3XyqUfzCKWsDBlgeBjYtA6Kpk5IlDkACpHF5sAnkWXHxhLyuCb?=
 =?us-ascii?Q?xzKa16iZ77v+79tigN11MNx4avu/lYmYkZRf/ldwGSFoHaWyAl4eczB6Vsp2?=
 =?us-ascii?Q?AB7TvmJv7ZqAxKSYrspEt4Z+biKbKRMgIKcCybCvyKIw8+oUuAtMb51F4dZe?=
 =?us-ascii?Q?dBicgqre1bUuOkCJuOH2MIAM5gZfylCJ4r7ppK6YI8tMPbRdkUs8xnkAGvpf?=
 =?us-ascii?Q?PQXIycGgxIBquGe/y5t6jQtg6sFl2M7PQJg4A9Hs6iwZXkTBY5j677UzJaOG?=
 =?us-ascii?Q?z9AWxT2cy3dbmGbfZKjmh7guXyxbJt5MisQIj9zar1vuIuCFb9IhYYRYttl/?=
 =?us-ascii?Q?Z5SknXKlARA3/6MGJUShUzaiHYxTnCaF48OLbpNhc0ybHng1k03dm6mhcoyy?=
 =?us-ascii?Q?Fj9ybC7UHnEisLe2QUDpAM0omR/Zavid1GfIkEV+DCatPZF5SV7Y1Cx3oYKX?=
 =?us-ascii?Q?AifY1UmaW4yTgbwodOdwyh8UQG0qKRcAtBrntbTG2RnmTJ7ZDE+ExH2sFD7Q?=
 =?us-ascii?Q?2ZuRNrP6cuxhzZp6IeE5HJa9n+ldubz6KLv8i7jbxE0DEYLvjkYsIsQicXSZ?=
 =?us-ascii?Q?4sYbh8H0XqxYeFql786zvXdyVHMR8N0uBzRKaWBhy/xAkQA5vSazb5cQXqME?=
 =?us-ascii?Q?49O9CottA75wJ2BjFrmt+cHNUXIwLFVh8NbvWpePTb3k10qsCEWMlDWURb/K?=
 =?us-ascii?Q?2w8cn61r4gK7kfIvI8s6KQKLDsze9ejXPPWse5Jixbldqt62suMWuyPVZeQu?=
 =?us-ascii?Q?5GO1tQN1qvEJg58tazphmvn4kGnliHX8dKTYai4uc9TjJkq4cU1XaDsGaapu?=
 =?us-ascii?Q?kcIBUO4qYikJHyht5Kew5E1033bJo9gaGINcFJ68QWmPltrLTPNNo1EeCsrM?=
 =?us-ascii?Q?ZrgvOi9Q2H397jzUi80rHPilgXSAaAelku6Mryk1ZAZZ3d8aMgFS41jE7/0X?=
 =?us-ascii?Q?4AeIJf3PaU43MnG/kpcJmi7V7kn4HfXKVdQPM622jM2d4MdA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB469;6:sIjZDLkkEZhsLCGavfnCssSNKNC7iopJFi3NolKsYo+LCNQl2dYEA/wRYRmBmPTj6yKrb6013u43ztSZLcU0BGNWOemxTuAjsm8Lrh3hH9DVV5PYkwoGQs+LyljpeOzQcMhB0pxt9jK9FKLmLCimoWlpTMkCgTdbB9hbtN/Mcx3R/IV6gytSBUQSlGKypuXOPRpMfnyfLA/wiCoSs57QyiF3w7Wjf0x83gAimSvLluzfw1dpcCaHUHEulnFph4b8DQEg/rJLZIuUrzS33YzT/5o2DqZ+F45Bs+kQm1lTKRH4h4v3Hbe/jWk6UplM/wij/l6nwp3cQxTwda5UJOKNCEsdqvOwPKQGFxE2hJJ37lM=;5:8L4+usgh2X+2g5gAsGyQutAELIQV2fqW3VFKiwehgjum5Sf87Vr71O+9QqhtaeS1gFyUwUwsetiC/53Z3NLAXfS9QljyrkJp6Ar2NZ8Gi167nwdTsCCi0s8kFW8+4mBHLOXXsyFN1EXjJrZi4dC17xZGeQwRFPB9kv6x5HA3uCg=;24:r647fEjS3BZ8ae89NU612gQT9FlI7DCEQKDs5VREHMuz8PQ/ACkcG6ks6Rqt19uz9iP3hu0imsYPrD1ltDP8AivxK1h+TBF8aanHLBcw4NQ=;7:BrLIdx5pvPXsrUAUp9+XPcdhFl11OIMU+A+UI3pbDzfvtdJdCUHeLJGmkv3ufWWMkzx1AZYVZyTmj8Hs5zJjzwZCZHSzvUfHIlQVAY+XzDtmN+fb/eSrhHxNWZ0ntFEyb3oFd+nd0PeRRqbDne22vpzs0aBqKjiEP20xF3/5+tqctMoEfh0xNwe3gIHYVf695fQsBH5bxUwc+ftdDFo1j8eXPFKSI0UJ2H9GIiKoLDuBI2S9dbKz1exwyq+aYO9m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 09:33:32.7321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8394c50-7d6c-4fcd-0ffe-08d56c7b88c4
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB469
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7 temperature monitor support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
---
changes since V2:
	Remove binding doc changes in this patch.
 arch/arm/boot/dts/imx7s.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 82ad26e..2e2eda53 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -497,9 +497,29 @@
 			};
 
 			ocotp: ocotp-ctrl@30350000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx7d-ocotp", "syscon";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clks IMX7D_OCOTP_CLK>;
+
+				tempmon_calib: calib@3c {
+					reg = <0x3c 0x4>;
+				};
+
+				tempmon_temp_grade: temp-grade@10 {
+					reg = <0x10 0x4>;
+				};
+			};
+
+			tempmon: tempmon {
+				compatible = "fsl,imx7-tempmon";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,tempmon =<&anatop>;
+				nvmem-cells = <&tempmon_calib>,
+					<&tempmon_temp_grade>;
+				nvmem-cell-names = "calib", "temp_grade";
+				clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
 			};
 
 			anatop: anatop@30360000 {
-- 
2.7.4
