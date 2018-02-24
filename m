Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeBXJ4H (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 04:56:07 -0500
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:51584
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750964AbeBXJzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 04:55:49 -0500
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
Subject: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
Date: Sat, 24 Feb 2018 16:02:49 +0800
Message-ID: <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131639397454586322;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39380400002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(2950100002)(2906002)(107886003)(50226002)(5660300001)(336011)(450100002)(54906003)(104016004)(6666003)(356003)(68736007)(110136005)(2870700001)(50466002)(77096007)(26005)(316002)(305945005)(5820100001)(498600001)(8676002)(72206003)(76176011)(59450400001)(2201001)(106466001)(53936002)(105606002)(4326008)(26826003)(85426001)(8936002)(47776003)(23676004)(97736004)(81156014)(86362001)(81166006)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB473;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD012;1:tBZ0bZkvUbQ6in28MQwuNy2ETNFEsfkuYhK+YCyMeixp3LQ4SHi5vhN65qylIPPhtQwb4s7ydyP6fkkKSdsdn+xBXNXl/gG6Q2PtVt2MWzjYRSR1LutnBt43TQR+GHqs
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e37dd90a-e824-41d5-c071-08d57b6cc62e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BY2PR03MB473;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB473;3:8EDgtojdudyBFQc4j6yTmJAN741q9LVN0Fy8KTGlbXEbf3B9C1dZ1YIaEagR2U9d3YRffVtAGiQMDtGj86jUlL3Nu+RD1jQtjb/VTiF/7ZnvL2xzjsZ4ejJhriT700GG6c2JnQYlnsJ8qBzgew/mM8A4AlLJ+OB39hTVNVzEdjxdBUUv0/Lfy4l3ecqaQG8j0RLpIVvcXWVa8cVKfFk3MVitjA6gBsXUSdV7sWk6xD6DQ8KTicI653ZkTanuevhbijYBpXuuOLQLEbIxgHzIDyox6OJpCzRhJIHANQLfM9DdiMROyLOl9E2wyLd6vDvlmsLpma9tCmRf922IOTs2fuJXfiHu+4BYOfRhBO4F/Jg=;25:Xvg2CP5L2twV+FSBldxzDDw0dQSJQWekSfyqHsM3K+r56V8nOysOAqMVY7/xO8s/f2k2lad/ljVSV1At+czMrpqWHIsdYakfG2nxp/J3IgUJD8TaSol7zV8SqhIsHgJ15YfDl1XhCMF1b4/ZsQbVeA8zAlMJ8DfhWxkRZweVOGjDw2dAJwWE4Z/agYeeXkaKrbMtpFwGhPticDL586/2ZnBFn7FkvsxvaJtqfhQKqumGW4yIBai205j2PdMphnVGy00/dgoAyDJU5+Of9bV2V1ELUeEo0hX65ySbo5N9SKJq60Y0kx3THCCLpCEkw8eznAS0iw7KlRgRuFKU/dcsow==
X-MS-TrafficTypeDiagnostic: BY2PR03MB473:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB473;31:vVUyDhk1bAPPc7mROqG7oEMMLOoQKBJYFscdKAm+TreWzNbk1qbWac1U0OpAVDPfYpyILZVz6vxn9KVX4LbuuMFFCPRt275/lu0NaoErw/4w/HBB1NWyITHrsfh96Eit+RasMMcZFZ6qyJZSgCY+BQECRSoBx1oa2hDypC+AAipVxPqSaM8VJF1BIFh5abYP7ZmRz9v/pBVAFSlVKAD5V8CZDqSM5PQXhhv0tlEiE74=;4:y4KLtakMNoQOaOIQUm4uD+hEaB/Wa3rgVz0UISqBzYImPVqHARTeBqY948HAkOzi1afD3NAZ6fbP3xdzL12aLx5m2Nvrfpw+3msm380x4UbV+32HKtijW4u8SnUdsjsO/QEDRGSQhjsavIlHWFqbiOQtJy25Dvs1qxsn40TxcadITHlWxUyRY3bf2pOuKma59v77uA1/KcbeF+TDsE9FmvYZH84qewHu4PZce8dVEqXDuMxp2nnd+ZI5VaBZ4FdKt6OZJl8UdxsF9kbBN9xK4hnxsutEeuq92xZLZu1jL4Ja8/9P+jWWBfK+mqgoLJw3
X-Microsoft-Antispam-PRVS: <BY2PR03MB4733503E3418C566D0158D5F5C30@BY2PR03MB473.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501161)(93006095)(93001095)(6055026)(6096035)(20161123565025)(20161123561025)(20161123559100)(20161123556025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BY2PR03MB473;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR03MB473;
X-Forefront-PRVS: 0593E261C4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI0NzM7MjM6S0V0SWtIMTg3K3M5STljNEVZenFZR3F6Q0th?=
 =?utf-8?B?SXZsbFJRSmpSS1BGS21kWXkxdGFOZkFRUDdoK0t6MEdVeVZHSDlXUGxLck1q?=
 =?utf-8?B?d2N3NitMbmlNZmgyVmJQbFNNZ2JHTEFLT0FrOUZWS0JtN1FtUUYvZGczNElF?=
 =?utf-8?B?QzR6ci9aVTNENlJxbnJ6TGxhZENTRUVUaEZockVzbFpZc28wejYyKzUvZTFt?=
 =?utf-8?B?aklCRVpUbDgyd2EzazhaMGx6Tyt3VXJTbkFmUUxGTjlCdkc3VEs4WHRWTWRz?=
 =?utf-8?B?azVDdXhuL2c5bElyRklXWmlSam50UVUzSE1wZnlFK1FKUVl1SDMyWm1oVjIr?=
 =?utf-8?B?aFVKL3k4eWJpSFF0MjFCd2w3Vk8vcis3KzVCQnV6c21nb3Q5ZGNpeGRlMlV0?=
 =?utf-8?B?dzNtQUNVSno5NmVNcVNFTEdybStiM1lpVklGSkJwSXZFNW13d2U2SVJaMHEx?=
 =?utf-8?B?by8vZDV5dFNVNTdVeWJkdTc5R2EwcitEVnNraWZPa2tZSndSLzFpYXdxSDha?=
 =?utf-8?B?OCtiai9mTUo0Y3hkT0diVit5NGpYUlRwWGh0WXVDMXpBSSt3VnZPNW9YYis5?=
 =?utf-8?B?Y1JyWC93aUtUSElWSmlpZUpkTjFvZDNIajZINEdkNU1PUDBuSjQ5WDh6dDFp?=
 =?utf-8?B?ekcxZnBjWkMzNGgxcHc2eWlMWFMwRXZ0TExuVFgxMzhLeHc5WEpEbXJ2Wk1p?=
 =?utf-8?B?cDFlRzJudzlnTnFORUx1akZFOTd0dzhsS1I4YUFETTlVZWNzRXpwVDJ0ZURU?=
 =?utf-8?B?WVA3Wk1SZkp6NzVwQU1YWXZrWG9lTUttZG5QUkRab2tRcWR2cGRQUVVoUTBr?=
 =?utf-8?B?R25PMUpnVHFXRDcyQmVUT2FHZ3RMOHQ3M0Zscnc2bnd1QmlaRFkybXNqUlZt?=
 =?utf-8?B?Rnc0WjlxTkFLTUlCaDdkdkpwd1pHSWdrcHA5NjJqTVMxNW1Lby9oNWV4alBU?=
 =?utf-8?B?QU9TQllFdVMxRW9Jakh5SEpPM0FyLy9nR3F0aHF1QkRrSCtyVXQwU2ZEck16?=
 =?utf-8?B?ajlsaExicVA4NytlajdyMnR0SW1YanFmZUc3SlZmdUlyVFA3SE8zekt2dUpM?=
 =?utf-8?B?RW9ITTBJMXkwT2hZMWlzSG1IZjNFMDFWL0NMa0I3UDExZ0hRRWhVamtxeG5j?=
 =?utf-8?B?bmRRTDN2RzAzZkw4Vm1yYzVYZE1uRHhDWStVNzRIeGI1NmdPR0RUMlFBeTQr?=
 =?utf-8?B?VDJ4M0J5Q2o5SXJVcktQZXQ1aU5mTVRKcktuY1k0SUVHNXg3dXluTkdpNE9R?=
 =?utf-8?B?Zm0rOGxtY0t0Wm4zdVNSa2JrTDdMZW1sUXFFQ09NYnhVZ0plOHI5ajVTaTFN?=
 =?utf-8?B?NFNHQ0xHVnkvS0x1bmN2UU5ad0lSN3dyUjlBaWY2bzZobC95NXpqYVUwaXly?=
 =?utf-8?B?WFpPc0lSZlZoaG9EZ2Z2TVJFblZSeEdRVzc3Sm1lWkRuZDhxUnNvQ09VOThH?=
 =?utf-8?B?aXIwKzZ2Qy9tdWtmZEpxSEdSRWI2YnlMQytrUi83Z1VVNC81SXNrNXpUMEk2?=
 =?utf-8?B?MFk1a3NSa3JqYkRhdjRZNjJ5TFJMQXRrMFJuR2VoT002ZkE3ZG9TRVpiWFh2?=
 =?utf-8?B?MlU5dkNZUWNWcGc4d3BOU2x5NVZpYUc4cGpZYzFtMzVtdXhYblhZSjJZYm9s?=
 =?utf-8?Q?lSukOG2rZ0KoCSn930R?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB473;6:GW9mKN5L51dUDEZDGjEFq1SKpAX0UTMkaJFZmFfaRJLOUPNODk54vXRR4Mjh88gF7YwA7sBxF4udNwoNCWqX4XAgjO5JDGDnqAnvDGDph29CcWJRHu4yljktiBsaPdb5nN9mjOkEFFLVFagh/xxeolhyESZJllOKi+639C5M8wG58LJ5JAXJfssRqIkH6Egsa8tRWAhu6VPWEEhF4jcEZ9yf8R6Gq98hKl5uIv7KmUO0or7m2au6zblBipGXck/GI9/8u4dveaChCmqA4iDajXb0HLPFyYQSfbItslP7dTILn6lJf9YBuestlyPtJ8isUWb6XvhE0FSPAuwP8XgtymZxsX5zomycU5F9FwSlthg=;5:REDapfk0/ZfNV6jT5t5eKbgejJphXRRyw2OI9HFnFDeSaLUaeIFaUUQMg7QjZdxSbfj2eoPayEzIktx+8J55MmTADRv2p+uOb6kDp3DvRoPbrDC4DveX1YPtbM8odpgKdS/ZuTcTofmexo2j+KR13bsuPY1mknKevwNniEmahEU=;24:Wu0i7nZ1yITF9tqjl3MDmIi6mP+GZfNQrMmRZbpgNu5PEShPgcvrH/sFyO7Oh00F24W4JFh9F2ZYLgtZyGLRglv9h/VmgshQU2eYD4cElbA=;7:HkjYGSfevJg1pWecUv4cmOK9wyQfdF35SdHMf2fyWkUeQvxqOgRRC8t4VrDNVqxVLYR+i8/iLDAMspQKUNV/7KtH/ftgcpF119P6kQAJE3OT9o6iCkOYGqBXmJGwPwuyyuu51bUKLLRvybA95+0GVYDEN3CPWGKxaeIyrzxHmUeSSPir/N9GPSypj09FiYJTbKylPz04Ahtli7b7ExIzON/qqSSD67TKWHEa52CeBhoHlV2lcQQvBySkRNuKiLUo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 09:55:45.1622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37dd90a-e824-41d5-c071-08d57b6cc62e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB473
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7 thermal sensor support, most
of the i.MX7 thermal sensor functions are same with
i.MX6 except the registers offset/layout, so we move
those registers offset/layout definitions to soc data
structure.

i.MX7 uses single calibration data @25C, the calibration
data is located at OCOTP offset 0x4F0, bit[17:9], the
formula is as below:

Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
changes since V3:
	use "fsl,imx7d-tempmon" instead of "fsl,imx7-tempmon" as compatible string;
	rebase to latest 4.16-rc2;
	improve local variable definition sequence.
 .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
 drivers/thermal/imx_thermal.c                      | 314 ++++++++++++++++-----
 2 files changed, 254 insertions(+), 69 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
index 28be51a..38bffcc 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
@@ -1,8 +1,13 @@
 * Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
 
 Required properties:
-- compatible : "fsl,imx6q-tempmon" for i.MX6Q, "fsl,imx6sx-tempmon" for i.MX6SX.
-  i.MX6SX has two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
+- compatible : must be one of following:
+  - "fsl,imx6q-tempmon" for i.MX6Q,
+  - "fsl,imx6sx-tempmon" for i.MX6SX,
+  - "fsl,imx7d-tempmon" for i.MX7S/D.
+- interrupts : the interrupt output of the controller:
+  i.MX6Q has one IRQ which will be triggered when temperature is higher than high threshold,
+  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
   when temperature is below than low threshold, IRQ_LOW will be triggered, when temperature
   is higher than panic threshold, system will auto reboot by SRC module.
 - fsl,tempmon : phandle pointer to system controller that contains TEMPMON
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a67781b..3928e2c 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -31,34 +31,58 @@
 #define REG_CLR		0x8
 #define REG_TOG		0xc
 
-#define MISC0				0x0150
-#define MISC0_REFTOP_SELBIASOFF		(1 << 3)
-#define MISC1				0x0160
-#define MISC1_IRQ_TEMPHIGH		(1 << 29)
+/* i.MX6 specific */
+#define IMX6_MISC0				0x0150
+#define IMX6_MISC0_REFTOP_SELBIASOFF		(1 << 3)
+#define IMX6_MISC1				0x0160
+#define IMX6_MISC1_IRQ_TEMPHIGH			(1 << 29)
 /* Below LOW and PANIC bits are only for TEMPMON_IMX6SX */
-#define MISC1_IRQ_TEMPLOW		(1 << 28)
-#define MISC1_IRQ_TEMPPANIC		(1 << 27)
-
-#define TEMPSENSE0			0x0180
-#define TEMPSENSE0_ALARM_VALUE_SHIFT	20
-#define TEMPSENSE0_ALARM_VALUE_MASK	(0xfff << TEMPSENSE0_ALARM_VALUE_SHIFT)
-#define TEMPSENSE0_TEMP_CNT_SHIFT	8
-#define TEMPSENSE0_TEMP_CNT_MASK	(0xfff << TEMPSENSE0_TEMP_CNT_SHIFT)
-#define TEMPSENSE0_FINISHED		(1 << 2)
-#define TEMPSENSE0_MEASURE_TEMP		(1 << 1)
-#define TEMPSENSE0_POWER_DOWN		(1 << 0)
-
-#define TEMPSENSE1			0x0190
-#define TEMPSENSE1_MEASURE_FREQ		0xffff
-/* Below TEMPSENSE2 is only for TEMPMON_IMX6SX */
-#define TEMPSENSE2			0x0290
-#define TEMPSENSE2_LOW_VALUE_SHIFT	0
-#define TEMPSENSE2_LOW_VALUE_MASK	0xfff
-#define TEMPSENSE2_PANIC_VALUE_SHIFT	16
-#define TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
+#define IMX6_MISC1_IRQ_TEMPLOW			(1 << 28)
+#define IMX6_MISC1_IRQ_TEMPPANIC		(1 << 27)
+
+#define IMX6_TEMPSENSE0				0x0180
+#define IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT	20
+#define IMX6_TEMPSENSE0_ALARM_VALUE_MASK	(0xfff << 20)
+#define IMX6_TEMPSENSE0_TEMP_CNT_SHIFT		8
+#define IMX6_TEMPSENSE0_TEMP_CNT_MASK		(0xfff << 8)
+#define IMX6_TEMPSENSE0_FINISHED		(1 << 2)
+#define IMX6_TEMPSENSE0_MEASURE_TEMP		(1 << 1)
+#define IMX6_TEMPSENSE0_POWER_DOWN		(1 << 0)
+
+#define IMX6_TEMPSENSE1				0x0190
+#define IMX6_TEMPSENSE1_MEASURE_FREQ		0xffff
+#define IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT	0
 
-#define OCOTP_MEM0			0x0480
-#define OCOTP_ANA1			0x04e0
+/* Below TEMPSENSE2 is only for TEMPMON_IMX6SX */
+#define IMX6_TEMPSENSE2				0x0290
+#define IMX6_TEMPSENSE2_LOW_VALUE_SHIFT		0
+#define IMX6_TEMPSENSE2_LOW_VALUE_MASK		0xfff
+#define IMX6_TEMPSENSE2_PANIC_VALUE_SHIFT	16
+#define IMX6_TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
+
+/* i.MX7 specific */
+#define IMX7_ANADIG_DIGPROG			0x800
+#define IMX7_TEMPSENSE0				0x300
+#define IMX7_TEMPSENSE0_PANIC_ALARM_SHIFT	18
+#define IMX7_TEMPSENSE0_PANIC_ALARM_MASK	(0x1ff << 18)
+#define IMX7_TEMPSENSE0_HIGH_ALARM_SHIFT	9
+#define IMX7_TEMPSENSE0_HIGH_ALARM_MASK		(0x1ff << 9)
+#define IMX7_TEMPSENSE0_LOW_ALARM_SHIFT		0
+#define IMX7_TEMPSENSE0_LOW_ALARM_MASK		0x1ff
+
+#define IMX7_TEMPSENSE1				0x310
+#define IMX7_TEMPSENSE1_MEASURE_FREQ_SHIFT	16
+#define IMX7_TEMPSENSE1_MEASURE_FREQ_MASK	(0xffff << 16)
+#define IMX7_TEMPSENSE1_FINISHED		(1 << 11)
+#define IMX7_TEMPSENSE1_MEASURE_TEMP		(1 << 10)
+#define IMX7_TEMPSENSE1_POWER_DOWN		(1 << 9)
+#define IMX7_TEMPSENSE1_TEMP_VALUE_SHIFT	0
+#define IMX7_TEMPSENSE1_TEMP_VALUE_MASK		0x1ff
+
+#define IMX6_OCOTP_MEM0				0x0480
+#define IMX6_OCOTP_ANA1				0x04e0
+#define IMX7_OCOTP_TESTER3			0x0440
+#define IMX7_OCOTP_ANA1				0x04f0
 
 /* The driver supports 1 passive trip point and 1 critical trip point */
 enum imx_thermal_trip {
@@ -72,17 +96,114 @@ enum imx_thermal_trip {
 
 #define TEMPMON_IMX6Q			1
 #define TEMPMON_IMX6SX			2
+#define TEMPMON_IMX7D			3
 
 struct thermal_soc_data {
 	u32 version;
+
+	u32 sensor_ctrl;
+	u32 power_down_mask;
+	u32 measure_temp_mask;
+
+	u32 measure_freq_ctrl;
+	u32 measure_freq_mask;
+	u32 measure_freq_shift;
+
+	u32 temp_data;
+	u32 temp_value_mask;
+	u32 temp_value_shift;
+	u32 temp_valid_mask;
+
+	u32 panic_alarm_ctrl;
+	u32 panic_alarm_mask;
+	u32 panic_alarm_shift;
+
+	u32 high_alarm_ctrl;
+	u32 high_alarm_mask;
+	u32 high_alarm_shift;
+
+	u32 low_alarm_ctrl;
+	u32 low_alarm_mask;
+	u32 low_alarm_shift;
 };
 
 static struct thermal_soc_data thermal_imx6q_data = {
 	.version = TEMPMON_IMX6Q,
+
+	.sensor_ctrl = IMX6_TEMPSENSE0,
+	.power_down_mask = IMX6_TEMPSENSE0_POWER_DOWN,
+	.measure_temp_mask = IMX6_TEMPSENSE0_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX6_TEMPSENSE1,
+	.measure_freq_shift = IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX6_TEMPSENSE1_MEASURE_FREQ,
+
+	.temp_data = IMX6_TEMPSENSE0,
+	.temp_value_mask = IMX6_TEMPSENSE0_TEMP_CNT_MASK,
+	.temp_value_shift = IMX6_TEMPSENSE0_TEMP_CNT_SHIFT,
+	.temp_valid_mask = IMX6_TEMPSENSE0_FINISHED,
+
+	.high_alarm_ctrl = IMX6_TEMPSENSE0,
+	.high_alarm_mask = IMX6_TEMPSENSE0_ALARM_VALUE_MASK,
+	.high_alarm_shift = IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT,
 };
 
 static struct thermal_soc_data thermal_imx6sx_data = {
 	.version = TEMPMON_IMX6SX,
+
+	.sensor_ctrl = IMX6_TEMPSENSE0,
+	.power_down_mask = IMX6_TEMPSENSE0_POWER_DOWN,
+	.measure_temp_mask = IMX6_TEMPSENSE0_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX6_TEMPSENSE1,
+	.measure_freq_shift = IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX6_TEMPSENSE1_MEASURE_FREQ,
+
+	.temp_data = IMX6_TEMPSENSE0,
+	.temp_value_mask = IMX6_TEMPSENSE0_TEMP_CNT_MASK,
+	.temp_value_shift = IMX6_TEMPSENSE0_TEMP_CNT_SHIFT,
+	.temp_valid_mask = IMX6_TEMPSENSE0_FINISHED,
+
+	.high_alarm_ctrl = IMX6_TEMPSENSE0,
+	.high_alarm_mask = IMX6_TEMPSENSE0_ALARM_VALUE_MASK,
+	.high_alarm_shift = IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT,
+
+	.panic_alarm_ctrl = IMX6_TEMPSENSE2,
+	.panic_alarm_mask = IMX6_TEMPSENSE2_PANIC_VALUE_MASK,
+	.panic_alarm_shift = IMX6_TEMPSENSE2_PANIC_VALUE_SHIFT,
+
+	.low_alarm_ctrl = IMX6_TEMPSENSE2,
+	.low_alarm_mask = IMX6_TEMPSENSE2_LOW_VALUE_MASK,
+	.low_alarm_shift = IMX6_TEMPSENSE2_LOW_VALUE_SHIFT,
+};
+
+static struct thermal_soc_data thermal_imx7d_data = {
+	.version = TEMPMON_IMX7D,
+
+	.sensor_ctrl = IMX7_TEMPSENSE1,
+	.power_down_mask = IMX7_TEMPSENSE1_POWER_DOWN,
+	.measure_temp_mask = IMX7_TEMPSENSE1_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX7_TEMPSENSE1,
+	.measure_freq_shift = IMX7_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX7_TEMPSENSE1_MEASURE_FREQ_MASK,
+
+	.temp_data = IMX7_TEMPSENSE1,
+	.temp_value_mask = IMX7_TEMPSENSE1_TEMP_VALUE_MASK,
+	.temp_value_shift = IMX7_TEMPSENSE1_TEMP_VALUE_SHIFT,
+	.temp_valid_mask = IMX7_TEMPSENSE1_FINISHED,
+
+	.panic_alarm_ctrl = IMX7_TEMPSENSE1,
+	.panic_alarm_mask = IMX7_TEMPSENSE0_PANIC_ALARM_MASK,
+	.panic_alarm_shift = IMX7_TEMPSENSE0_PANIC_ALARM_SHIFT,
+
+	.high_alarm_ctrl = IMX7_TEMPSENSE0,
+	.high_alarm_mask = IMX7_TEMPSENSE0_HIGH_ALARM_MASK,
+	.high_alarm_shift = IMX7_TEMPSENSE0_HIGH_ALARM_SHIFT,
+
+	.low_alarm_ctrl = IMX7_TEMPSENSE0,
+	.low_alarm_mask = IMX7_TEMPSENSE0_LOW_ALARM_MASK,
+	.low_alarm_shift = IMX7_TEMPSENSE0_LOW_ALARM_SHIFT,
 };
 
 struct imx_thermal_data {
@@ -107,31 +228,42 @@ struct imx_thermal_data {
 static void imx_set_panic_temp(struct imx_thermal_data *data,
 			       int panic_temp)
 {
+	const struct thermal_soc_data *soc_data = data->socdata;
 	struct regmap *map = data->tempmon;
 	int critical_value;
 
 	critical_value = (data->c2 - panic_temp) / data->c1;
-	regmap_write(map, TEMPSENSE2 + REG_CLR, TEMPSENSE2_PANIC_VALUE_MASK);
-	regmap_write(map, TEMPSENSE2 + REG_SET, critical_value <<
-			TEMPSENSE2_PANIC_VALUE_SHIFT);
+
+	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
+		     soc_data->panic_alarm_mask);
+	regmap_write(map, soc_data->panic_alarm_ctrl + REG_SET,
+		     critical_value << soc_data->panic_alarm_shift);
 }
 
 static void imx_set_alarm_temp(struct imx_thermal_data *data,
 			       int alarm_temp)
 {
 	struct regmap *map = data->tempmon;
+	const struct thermal_soc_data *soc_data = data->socdata;
 	int alarm_value;
 
 	data->alarm_temp = alarm_temp;
-	alarm_value = (data->c2 - alarm_temp) / data->c1;
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_ALARM_VALUE_MASK);
-	regmap_write(map, TEMPSENSE0 + REG_SET, alarm_value <<
-			TEMPSENSE0_ALARM_VALUE_SHIFT);
+
+	if (data->socdata->version == TEMPMON_IMX7D)
+		alarm_value = alarm_temp / 1000 + data->c1 - 25;
+	else
+		alarm_value = (data->c2 - alarm_temp) / data->c1;
+
+	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
+		     soc_data->high_alarm_mask);
+	regmap_write(map, soc_data->high_alarm_ctrl + REG_SET,
+		     alarm_value << soc_data->high_alarm_shift);
 }
 
 static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct imx_thermal_data *data = tz->devdata;
+	const struct thermal_soc_data *soc_data = data->socdata;
 	struct regmap *map = data->tempmon;
 	unsigned int n_meas;
 	bool wait;
@@ -139,16 +271,18 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	if (data->mode == THERMAL_DEVICE_ENABLED) {
 		/* Check if a measurement is currently in progress */
-		regmap_read(map, TEMPSENSE0, &val);
-		wait = !(val & TEMPSENSE0_FINISHED);
+		regmap_read(map, soc_data->temp_data, &val);
+		wait = !(val & soc_data->temp_valid_mask);
 	} else {
 		/*
 		 * Every time we measure the temperature, we will power on the
 		 * temperature sensor, enable measurements, take a reading,
 		 * disable measurements, power off the temperature sensor.
 		 */
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			    soc_data->power_down_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			    soc_data->measure_temp_mask);
 
 		wait = true;
 	}
@@ -160,22 +294,28 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (wait)
 		usleep_range(20, 50);
 
-	regmap_read(map, TEMPSENSE0, &val);
+	regmap_read(map, soc_data->temp_data, &val);
 
 	if (data->mode != THERMAL_DEVICE_ENABLED) {
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->measure_temp_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->power_down_mask);
 	}
 
-	if ((val & TEMPSENSE0_FINISHED) == 0) {
+	if ((val & soc_data->temp_valid_mask) == 0) {
 		dev_dbg(&tz->device, "temp measurement never finished\n");
 		return -EAGAIN;
 	}
 
-	n_meas = (val & TEMPSENSE0_TEMP_CNT_MASK) >> TEMPSENSE0_TEMP_CNT_SHIFT;
+	n_meas = (val & soc_data->temp_value_mask)
+		>> soc_data->temp_value_shift;
 
 	/* See imx_init_calib() for formula derivation */
-	*temp = data->c2 - n_meas * data->c1;
+	if (data->socdata->version == TEMPMON_IMX7D)
+		*temp = (n_meas - data->c1 + 25) * 1000;
+	else
+		*temp = data->c2 - n_meas * data->c1;
 
 	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
 	if (data->socdata->version == TEMPMON_IMX6Q) {
@@ -219,21 +359,26 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 {
 	struct imx_thermal_data *data = tz->devdata;
 	struct regmap *map = data->tempmon;
+	const struct thermal_soc_data *soc_data = data->socdata;
 
 	if (mode == THERMAL_DEVICE_ENABLED) {
 		tz->polling_delay = IMX_POLLING_DELAY;
 		tz->passive_delay = IMX_PASSIVE_DELAY;
 
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->power_down_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->measure_temp_mask);
 
 		if (!data->irq_enabled) {
 			data->irq_enabled = true;
 			enable_irq(data->irq);
 		}
 	} else {
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->measure_temp_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->power_down_mask);
 
 		tz->polling_delay = 0;
 		tz->passive_delay = 0;
@@ -355,6 +500,15 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 	}
 
 	/*
+	 * On i.MX7D, we only use the calibration data at 25C to get the temp,
+	 * Tmeas = ( Nmeas - n1) + 25; n1 is the fuse value for 25C.
+	 */
+	if (data->socdata->version == TEMPMON_IMX7D) {
+		data->c1 = (ocotp_ana1 >> 9) & 0x1ff;
+		return 0;
+	}
+
+	/*
 	 * The sensor is calibrated at 25 °C (aka T1) and the value measured
 	 * (aka N1) at this temperature is provided in bits [31:20] in the
 	 * i.MX's OCOTP value ANA1.
@@ -418,6 +572,7 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
 
 static int imx_init_from_tempmon_data(struct platform_device *pdev)
 {
+	const struct imx_thermal_data *data = platform_get_drvdata(pdev);
 	struct regmap *map;
 	int ret;
 	u32 val;
@@ -430,7 +585,11 @@ static int imx_init_from_tempmon_data(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regmap_read(map, OCOTP_ANA1, &val);
+	if (data->socdata->version == TEMPMON_IMX7D)
+		ret = regmap_read(map, IMX7_OCOTP_ANA1, &val);
+	else
+		ret = regmap_read(map, IMX6_OCOTP_ANA1, &val);
+
 	if (ret) {
 		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
 		return ret;
@@ -439,7 +598,11 @@ static int imx_init_from_tempmon_data(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(map, OCOTP_MEM0, &val);
+	/* use OTP for thermal grade */
+	if (data->socdata->version == TEMPMON_IMX7D)
+		ret = regmap_read(map, IMX7_OCOTP_TESTER3, &val);
+	else
+		ret = regmap_read(map, IMX6_OCOTP_MEM0, &val);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
 		return ret;
@@ -492,6 +655,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 static const struct of_device_id of_imx_thermal_match[] = {
 	{ .compatible = "fsl,imx6q-tempmon", .data = &thermal_imx6q_data, },
 	{ .compatible = "fsl,imx6sx-tempmon", .data = &thermal_imx6sx_data, },
+	{ .compatible = "fsl,imx7d-tempmon", .data = &thermal_imx7d_data, },
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
@@ -523,14 +687,15 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	/* make sure the IRQ flag is clear before enabling irq on i.MX6SX */
 	if (data->socdata->version == TEMPMON_IMX6SX) {
-		regmap_write(map, MISC1 + REG_CLR, MISC1_IRQ_TEMPHIGH |
-			MISC1_IRQ_TEMPLOW | MISC1_IRQ_TEMPPANIC);
+		regmap_write(map, IMX6_MISC1 + REG_CLR,
+			IMX6_MISC1_IRQ_TEMPHIGH | IMX6_MISC1_IRQ_TEMPLOW
+			| IMX6_MISC1_IRQ_TEMPPANIC);
 		/*
 		 * reset value of LOW ALARM is incorrect, set it to lowest
 		 * value to avoid false trigger of low alarm.
 		 */
-		regmap_write(map, TEMPSENSE2 + REG_SET,
-			TEMPSENSE2_LOW_VALUE_MASK);
+		regmap_write(map, data->socdata->low_alarm_ctrl + REG_SET,
+			     data->socdata->low_alarm_mask);
 	}
 
 	data->irq = platform_get_irq(pdev, 0);
@@ -557,11 +722,17 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* Make sure sensor is in known good state for measurements */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
-	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->measure_temp_mask);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
+		     data->socdata->measure_freq_mask);
+	if (data->socdata->version != TEMPMON_IMX7D)
+		regmap_write(map, IMX6_MISC0 + REG_SET,
+			IMX6_MISC0_REFTOP_SELBIASOFF);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 
 	data->policy = cpufreq_cpu_get(0);
 	if (!data->policy) {
@@ -626,16 +797,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		 data->temp_passive / 1000);
 
 	/* Enable measurements at ~ 10 Hz */
-	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
+		     data->socdata->measure_freq_mask);
 	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
-	regmap_write(map, TEMPSENSE1 + REG_SET, measure_freq);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_SET,
+		     measure_freq << data->socdata->measure_freq_shift);
 	imx_set_alarm_temp(data, data->temp_passive);
 
 	if (data->socdata->version == TEMPMON_IMX6SX)
 		imx_set_panic_temp(data, data->temp_critical);
 
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->measure_temp_mask);
 
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
@@ -661,7 +836,8 @@ static int imx_thermal_remove(struct platform_device *pdev)
 	struct regmap *map = data->tempmon;
 
 	/* Disable measurements */
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 	if (!IS_ERR(data->thermal_clk))
 		clk_disable_unprepare(data->thermal_clk);
 
@@ -684,8 +860,10 @@ static int imx_thermal_suspend(struct device *dev)
 	 * temperature will be read as the thermal sensor is powered
 	 * down.
 	 */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->measure_temp_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 	data->mode = THERMAL_DEVICE_DISABLED;
 	clk_disable_unprepare(data->thermal_clk);
 
@@ -702,8 +880,10 @@ static int imx_thermal_resume(struct device *dev)
 	if (ret)
 		return ret;
 	/* Enabled thermal sensor after resume */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->measure_temp_mask);
 	data->mode = THERMAL_DEVICE_ENABLED;
 
 	return 0;
-- 
2.7.4
