Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeEKDhJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:37:09 -0400
Received: from mail-cys01nam02on0091.outbound.protection.outlook.com ([104.47.37.91]:20140
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752357AbeEKDhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:37:03 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>,
        Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        Meng Yi <meng.yi@nxp.com>, Wang Dongsheng <dongsheng.wang@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Tang Yuantian <Yuantian.Tang@nxp.com>, <ying.zhang22455@nxp.com>
Subject: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
Date: Fri, 11 May 2018 11:35:24 +0800
Message-ID: <20180511033530.7931-3-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(39380400002)(39860400002)(376002)(346002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(76176011)(4326008)(44832011)(106466001)(105606002)(336012)(51416003)(110136005)(54906003)(36756003)(8656006)(1076002)(7416002)(47776003)(5660300001)(97736004)(26005)(53936002)(486006)(126002)(2616005)(7406005)(11346002)(305945005)(81156014)(446003)(498600001)(50466002)(8936002)(356003)(85426001)(86362001)(81166006)(8676002)(6636002)(6666003)(50226002)(48376002)(2906002)(16586007)(77096007)(476003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR03MB2180;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD011;1:t9XU8zNtrgr00ZH8ZHeqLc5gaC1aQofrimA9GC1JgEf6dPZhQIAmn6Ea67KchSjqPkI4hdqZy62nO9CQ8UgOM88/p0Ni9+cPXEAfV9PipbY4euNafbADXrIPRiBzHKIR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(5600026)(2017052603328);SRVR:BN3PR03MB2180;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2180;3:Y6E4VJ0rRhPHN3IrIlGHJXp3CMfObWWv/BCxbBXeBDTQi7KO243PTuV0OghJmV+fccELw+lWt/w9ZiG5/do2hO/s6h7kuJCbX13ERtCSJAhoxBkMe5x+4t1zxcvpyKzKqt5UG0i9w0+5j3D5Wc5/kIlp+y/e7E7ukq+ys/Nw1UuGmMzKYFX7TfDXiArMEUefov54wlxlQkKEtV8LWyahTS1qqrcEvOO/1aMh1OgsMwzCpi/nVzTCNtTtLe707mdoxltRznrMuaa+fAxgokiSR0T1PA1WoZ79rcrFZa+sxBzVXJB1jC1BCMCMr1K41ZWJQjPMJOWecsGHaQKGNf9hTCNQkuHz9xs37YNjnNs6mLA=;25:l5ve9yKhGPJjIq3WGljkVKevlDPnJOCVIRkMPJYOGn9aNEh3G0Jr7I7Av0OGGHZxWScUOw3wfJcFM08U+joKpb6PWqZ1vQf8UDGP2gV0gWTlQh64P9yHuOYAfgkNjjO0Q/aoV7DqyV+dXa4zhVDpGW9XE78SHMfE/Sr8u3St05S/zalxb7AEoiDwiGrSR/R1cBoLM0RchCZY3JL29V7zzItIm56IDuaBV3ASLZsMgmnREHfW49g25vetbfIkm82wdnkigwb1SMHPoXqIrWukLFgB1DRb/qAMP9/xx7i8LB6OLdBvPdzBlPDsqB68640R3U0gAZ/A4KTuEhHN2VKkoQ==
X-MS-TrafficTypeDiagnostic: BN3PR03MB2180:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2180;31:GuUSEJ4e7YDjIv/WdECr8/IVqzbVNDnTWQb82g5e9++0VE8i7xHrw75PWpos1hbmVTiI2JG/CR+81moge+ceTwAWgwfjHwaIntWLCGcjOtXFSWoqtE6DasLw7JJpWDJQycE/3sGR/ihqCq/aIoYOIgeYudOuyPuut+2dOUQZ3Lkn/nM8NuxqoKBZnNwXsfiy6Buh1EWrGGLb2nViyFGhjuNi1T+Qmq6hGBzJ4xf2cRE=;20:Qo+KVIrQBPaSbmPf5wzEJhywgaH0xsYP4kZGYFYEU8U2eeoNxnpsin82M97TyAc+8vMMxXLpQzKm/GU3mzuAA559qL9BnPNACBA6wnLZP8GL/LgiGMOoSiYlieL03hAIWv+Dj4J6SE+M9cgz+k7KO+LSWOmmoveou+JGxpMQlMy443+XkQxSRMCfGWAr+EK9LxjTpxF2jrSg3Nwa/sskREXZYXh7MPPZu9aWhwSdMn6en72/eXMcSQv3fL414d+RRSg70eCdA7Ray6hhw4AFTyK8fBT/FRtHr1jevX07VIOAvpN0YvJBsoyOTwLfhy+75MKHIGJl5J8r21bS3HCLA2OJ/PK0pmzQyMNdlZ7M3hXIyy0IpmY66UycVknYgKmSeQFVOyUR7YGRRxPkdEeIC+BQdkBYvxpjnih5bgNB2SXIl5OxR1U3zUzRastlHf1MiU1aaWboxmDhritXv93wVDiTk1BuEGgk8AZOxBhP4H9bziUyWe7kP0J1dCij+ZQpoOWbKATLMWl6ALjnpBVdAnhdb5gAPwuycJIUv3eOc4PnCM1mL8JWU+b6x6TZZBsuZNWigilRzGOEZIR2WxYF+a1BF1afxJ6H7I7TCb8WDZo=
X-Microsoft-Antispam-PRVS: <BN3PR03MB2180AC18066C8B0C316B51B5E99F0@BN3PR03MB2180.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231254)(944501410)(52105095)(20161123222025)(6055026)(149027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);SRVR:BN3PR03MB2180;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB2180;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2180;4:bOukIAiDeXsV+5gNTL0zfl9Bn70AJszyxBHZl3tHqhGx+yXo08p3RXjF5HqSA18GTaOngkaR3l/UhKp0Go0PtmrcCkQxZMV2GqZEb6CHTbHsTe99/YuIwmvoztST8ktLp1skyF4GxtGkQeSe7f2kkpL8gyQtKNyg0EoKg0ua6d0kutfFlzTt2gwmTR6YrTspdVYeKuyBd2BSNKkstRuHUTlU9KY32w9D7+DhA8UTmYg55bRKECezlCi8uAaQBwTQ7mQtmFLyvB4dbSp0aZ0jFjVJpY4bYMz5sg9AZxKOAxSo1OAksVPN+7mXv2VGVLqL
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB2180;23:ry4GsuALEWTjtSivreFggGky1xCVydulKwuTAXvs0?=
 =?us-ascii?Q?Hv+nQcjARwWJMOQF0J1uGdcD+k/eEeY2ZTyBBHuiWU9ZfXKN+B8D2O72M5JN?=
 =?us-ascii?Q?waAXAyvF736qAzkQLjGjfj/qVh939RimM1TV2f0yEdwF+3trb4BVPaqdYg2T?=
 =?us-ascii?Q?RwmPmja5JMEVLmoc8AsEBFDgeK0jl5b8l2KdF9PJEsFmF1TcIi/mkEUZAAgc?=
 =?us-ascii?Q?UH4mDJ4MQmok8PzTjBMYu7cYMV9d12YBBud/yOZpuB7mOWxgjYisP5y4s05z?=
 =?us-ascii?Q?SJqZwVXvoPZGA6lTQ2xdfGY951BpxBHwQ7b8fmmgc0Ab0dQgJppShXYF+5eG?=
 =?us-ascii?Q?Noe8HCFUrCj1ddLn4yYW1Fc4ULh9ztg2XYVkddwp2ofYxEzll7QwtvJOG9R7?=
 =?us-ascii?Q?PHsbJ1CIsn8W98Qt4foGSyId+Jm718YJlJZgv6q9wkUsH/ZwCkfiYu2SbYR3?=
 =?us-ascii?Q?0Ffvdpw1Q5C8U046YYAdrE6lcTgVsok8SL1vXEm1a78mYsEDlS3Ew0OK5nrX?=
 =?us-ascii?Q?OvvoyS3Xb8MMv79j3N1GNMSHJNCj7N7Iv/+bZUG3hjtBSrUkUE20JeYIDECK?=
 =?us-ascii?Q?Tpo23HMx4WFBN06agDOM4Ln8zmnPv6Z7q0Ro2JQebfEOcYKjJEkPBjPBDZeO?=
 =?us-ascii?Q?dGmKVF2hecWygPVWs2ScdO4+BY+YJw87vgS+mMuFttaVVzaC0mlItMOc0hb9?=
 =?us-ascii?Q?q9B307OlXjgvpp8o5yBTljCtb01y4QJ6IKlBZJOU3XGIL4hUodLOm/66vKdc?=
 =?us-ascii?Q?yGOkzMCtwHdBBefzWmdz3UaLpTsXySfSuhZv8vm9j7lMSDv6HlzHKCAY/kfa?=
 =?us-ascii?Q?I5X9fOoYj0NMwMUg7Qiir+BceZQtZUJtjKKRPd2mX84rKOHO5wsrZvQ6sShA?=
 =?us-ascii?Q?gVW0jpBZM8ETzEeMV0DRI3e/TCRcnINKX4otHDD/ybP0GHNTUEfFhF28Kef2?=
 =?us-ascii?Q?e8WNIJYz2dtFAgTinW1qfmHwoLmu8nZGqHBgS9rRY3cuU/UlMv+oo3FWg7eu?=
 =?us-ascii?Q?4S8TJwd4ybYCl0P4hmE5gEDQul0osJv7UhUdkeqvX3zJCyGiRNSy/MAEZL/+?=
 =?us-ascii?Q?P/jBmORywnAijmuUCLd02u0O1IIDITJ80xv/lyMkqjwdJI2tBME/SanVWqba?=
 =?us-ascii?Q?2EXQ0uHThqp0Zxsvg5ddDpFH0uVASiP6n0hPrrBgGhTe1wSM1nSpYUeY17qH?=
 =?us-ascii?Q?AWv8+QM8No5OB9WCCIg8sVtQVO31apyBEq4eElyT1D4pRyMt38C+dAJKQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 4mEPtZXYENWJMC6h7Squw4M4tspkEjZQMTP2ONupfT1virXAXEChOHKArqyrFh5+A/sxzwhh/AxAVyLm5sHlNZzRLqoZzgqKCTx4J2XGLb1jKSfHukuA/GEXqSuEl6kKYJhaCb6Zyf4F1ujlGuiMW/1wvgRUxvVtuWdmebl9x1vyB0HKWLEqd1xBKLL2ttNK
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2180;6:ro8lKnqTzRJjorZLNmTGzKjw+7AcM+v96t0vwoZ8u5KgpeT5YVajlRZFVBzSxQ0e2Synsi1yMy6Ioq7A2nWsbyYuYUJ1uzdl5h9kdNovNW1H+IzNZ2XdiMh+upKTeG+OvtJdY3LTl2zhaQMEnnSBj6+2lFvdYjkmXoKkUwiog6gz3oHoXxu2+b1XXvcFEyLRW0IodQmXK3BaEjVP05JNzDTzDNEQzyt7d0OBcSNoniiEfy4O/moo2O2euCxzCt/M3ss5tIbG+f479IBx1WHSvli2FyjE7aYJwt6eCwxzDrUiyPYK4a3YG+HmXfrDMI6mqsWUsvoMJQWkg9LwTnR1MDPecWUMtyk7m5TT2LRWxQW1eiDCJzuUuzsTBtDOqvBOlOu8uukaSKvOG+iqosRFf5PKdvCB7SL8yt9suQD/esOKER0PQA9MShaqdRgseFDxySAQP4yN/1xVC/lGotRYPg==;5:SCgktQUJq8iHzTQ6rpVWlgw0hWU8+k354C0MYzPH9YNIbW38tOTdYvvTFI0EPmdyVPg5UtHD4KAlzh0ZQgXuOHNVMqTTCQPmazD8RW+a2sX42ea08LKzRfo2L5z2HooIVEF2cGTSiBfo3lFMnxu2IxaGVzRRXKISookyFSHbs98=;24:YBHtQdkfo7xo2A4cA978wUHcJX+Hc8uURLNZAc4bjPJD1JRQEn3eUMXwD50v2T63mhbCLmyifre1dXrr1lsv/6VD/wsLn0w0bnO7/6V3VJ0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2180;7:SgLDFtLmF0QjwXXXszrYJuVZQcYkOg3j/5pgK3IvDZoz3B4HnLnz+zPxXvMXjDBw0tG9vR5q9dbYURutzrDVYFuUDIjeEPxMd+Odb+x/Yy+rNH+aEtWyNW8jq+g5Y2/ahJc+H+nMxGKpxPrYdUkiIJIUyuirJpMUj+QiEXKOSBoRdvhgVoQ8AusP9+m6Aaogp5/exE6psEPLzvDzi5buYFpZfzT/0+MbYMLKhKUhozC2xZE6sWrfm2/WfCFO4Z9U
X-MS-Office365-Filtering-Correlation-Id: 3bedce20-b2c7-49c3-70df-08d5b6f070ad
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:36:53.6934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bedce20-b2c7-49c3-70df-08d5b6f070ad
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Set RCPM for FTM when using FTM as wakeup source. Because the RCPM
module of each platform has different big-end and little-end mode,
there need to set RCPM depending on the platform.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 .../devicetree/bindings/timer/fsl,ftm-timer.txt    |    7 ++
 drivers/soc/fsl/layerscape/ftm_alarm.c             |   92 ++++++++++++++++++-
 2 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
index aa8c402..15ead58 100644
--- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
@@ -3,6 +3,13 @@ Freescale FlexTimer Module (FTM) Timer
 Required properties:
 
 - compatible : should be "fsl,ftm-timer"
+ Possible compatibles for ARM:
+     "fsl,ls1012a-ftm"
+     "fsl,ls1021a-ftm"
+     "fsl,ls1043a-ftm"
+     "fsl,ls1046a-ftm"
+     "fsl,ls1088a-ftm"
+     "fsl,ls208xa-ftm"
 - reg : Specifies base physical address and size of the register sets for the
   clock event device and clock source device.
 - interrupts : Should be the clock event device interrupt.
diff --git a/drivers/soc/fsl/layerscape/ftm_alarm.c b/drivers/soc/fsl/layerscape/ftm_alarm.c
index 6f9882f..811dcfa 100644
--- a/drivers/soc/fsl/layerscape/ftm_alarm.c
+++ b/drivers/soc/fsl/layerscape/ftm_alarm.c
@@ -16,6 +16,9 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/libata.h>
 
 #define FTM_SC			0x00
 #define FTM_SC_CLK_SHIFT	3
@@ -40,6 +43,59 @@
 static u32 alarm_freq;
 static bool big_endian;
 
+enum pmu_endian_type {
+	BIG_ENDIAN,
+	LITTLE_ENDIAN,
+};
+
+struct rcpm_cfg {
+	enum pmu_endian_type big_endian; /* Big/Little endian of PMU module */
+
+	/* FlexTimer1 is not powerdown during device LPM20 */
+	u32 flextimer_set_bit;
+};
+
+static struct rcpm_cfg ls1012a_rcpm_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.flextimer_set_bit = 0x20000,
+};
+
+static struct rcpm_cfg ls1021a_rcpm_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.flextimer_set_bit = 0x20000,
+};
+
+static struct rcpm_cfg ls1043a_rcpm_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.flextimer_set_bit = 0x20000,
+};
+
+static struct rcpm_cfg ls1046a_rcpm_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.flextimer_set_bit = 0x20000,
+};
+
+static struct rcpm_cfg ls1088a_rcpm_cfg = {
+	.big_endian = LITTLE_ENDIAN,
+	.flextimer_set_bit = 0x4000,
+};
+
+static struct rcpm_cfg ls208xa_rcpm_cfg = {
+	.big_endian = LITTLE_ENDIAN,
+	.flextimer_set_bit = 0x4000,
+};
+
+static const struct of_device_id ippdexpcr_of_match[] = {
+	{ .compatible = "fsl,ls1012a-ftm", .data = &ls1012a_rcpm_cfg},
+	{ .compatible = "fsl,ls1021a-ftm", .data = &ls1021a_rcpm_cfg},
+	{ .compatible = "fsl,ls1043a-ftm", .data = &ls1043a_rcpm_cfg},
+	{ .compatible = "fsl,ls1046a-ftm", .data = &ls1046a_rcpm_cfg},
+	{ .compatible = "fsl,ls1088a-ftm", .data = &ls1088a_rcpm_cfg},
+	{ .compatible = "fsl,ls208xa-ftm", .data = &ls208xa_rcpm_cfg},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ippdexpcr_of_match);
+
 static inline u32 ftm_readl(void __iomem *addr)
 {
 	if (big_endian)
@@ -214,7 +270,10 @@ static int ftm_alarm_probe(struct platform_device *pdev)
 	struct resource *r;
 	int irq;
 	int ret;
-	u32 ippdexpcr;
+	struct rcpm_cfg *rcpm_cfg;
+	u32 ippdexpcr, flextimer;
+	const struct of_device_id *of_id;
+	enum pmu_endian_type endian;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r)
@@ -224,14 +283,32 @@ static int ftm_alarm_probe(struct platform_device *pdev)
 	if (IS_ERR(ftm1_base))
 		return PTR_ERR(ftm1_base);
 
+	of_id = of_match_node(ippdexpcr_of_match, np);
+	if (!of_id)
+		return -ENODEV;
+
+	rcpm_cfg = devm_kzalloc(&pdev->dev, sizeof(*rcpm_cfg), GFP_KERNEL);
+	if (!rcpm_cfg)
+		return -ENOMEM;
+
+	rcpm_cfg = (struct rcpm_cfg *)of_id->data;
+	endian = rcpm_cfg->big_endian;
+	flextimer = rcpm_cfg->flextimer_set_bit;
+
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "FlexTimer1");
 	if (r) {
 		rcpm_ftm_addr = devm_ioremap_resource(&pdev->dev, r);
 		if (IS_ERR(rcpm_ftm_addr))
 			return PTR_ERR(rcpm_ftm_addr);
-		ippdexpcr = ioread32be(rcpm_ftm_addr);
-		ippdexpcr |= 0x20000;
-		iowrite32be(ippdexpcr, rcpm_ftm_addr);
+		if (endian == BIG_ENDIAN)
+			ippdexpcr = ioread32be(rcpm_ftm_addr);
+		else
+			ippdexpcr = ioread32(rcpm_ftm_addr);
+		ippdexpcr |= flextimer;
+		if (endian == BIG_ENDIAN)
+			iowrite32be(ippdexpcr, rcpm_ftm_addr);
+		else
+			iowrite32(ippdexpcr, rcpm_ftm_addr);
 	}
 
 	irq = irq_of_parse_and_map(np, 0);
@@ -265,7 +342,12 @@ static int ftm_alarm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ftm_alarm_match[] = {
-	{ .compatible = "fsl,ftm-alarm", },
+	{ .compatible = "fsl,ls1012a-ftm", },
+	{ .compatible = "fsl,ls1021a-ftm", },
+	{ .compatible = "fsl,ls1043a-ftm", },
+	{ .compatible = "fsl,ls1046a-ftm", },
+	{ .compatible = "fsl,ls1088a-ftm", },
+	{ .compatible = "fsl,ls208xa-ftm", },
 	{ .compatible = "fsl,ftm-timer", },
 	{ },
 };
-- 
1.7.1
