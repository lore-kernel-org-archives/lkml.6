Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeC1D0K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:26:10 -0400
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:7520
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeC1D0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:26:04 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <Linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 3/4] clocksource/drivers/imx-tpm: correct some registers operation flow
Date: Wed, 28 Mar 2018 11:22:37 +0800
Message-ID: <1522207358-8388-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
References: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131666811622706398;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(2906002)(5660300001)(450100002)(356003)(72206003)(4326008)(305945005)(16586007)(59450400001)(36756003)(26826003)(508600001)(53936002)(105606002)(126002)(486005)(486005)(77096007)(26005)(106466001)(86362001)(54906003)(68736007)(6666003)(81166006)(8676002)(50226002)(110136005)(2616005)(11346002)(336012)(575784001)(104016004)(48376002)(47776003)(50466002)(51416003)(316002)(476003)(446003)(76176011)(81156014)(85426001)(97736004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB389;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD012;1:lmT4gN2hmivEQOcrRJuUCN6N9mL+ywaskkEyJZE5ZfdhiiO0B4KaeyNrTImU+4UxZ+MYMr/WhgSKF9ZEY0YzOicA6s+wc6jb7yIHVL/4rOjLGBcmzx+2ybl1yp0ww00N
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18399ff2-1c6c-4900-c1d6-08d5945ba1de
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BLUPR03MB389;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;3:rdP11E5QU74YNM88oqW3+ZsSngIAlh8I02yloa1XsoYkd6jbomiM4eMf7Xy0ow0kbBuhq49OjR3vlGmcilrmOcwcdeg9tQ3DS2htFq7mODwm3Tz+ggcuYx+SkBgElf+2n+9oiaMEaAWDRfxnni6jNndrOQ+u1Yomf3eiAqeR4IS4ZniPIVq5PpzsQ6g2bAQlDjZBknXRSgi1qnnBzgfVKgcTDyf/r1LXNdlzlNSUUOsx1UlzwOSL71apMyGD9F8Kyf1koOVVg8bbKvyvgSE6TmOYY2II9W6SaoodCubA5INu5i55TwoDnLFQhh8MZWAEal6C0hsuULAtQVmvhI+BM2DnLt3bVwJb9189sRwhctA=;25:Ogxs4Wyei4/z1gPaOULS0XFWKr8AFOT3f6Jw1IYDLmOz0JwoY7fRdHHp3LI/CcqspjZuIupeGOWMYXvAQ69MW3UaGV5w4hmXdWVNSfbhl5pCmF16xYAWTEKst8DyTz4VEsjA0b1FROaNXG0nsOp3v+dn/OVjUDLbPBRJTWuRlpehm8U7zRUomHBKXi3e/MzsvZqeDuorBlBAKhCWC234/XXgrQikqodGG9VeJqsjGrWh5EUIbDJW5v2aY9UrSI0Rx3M+/fkdcoXblQJFDcFBzvixAMJMipJRpJEQv1yGWfl3q9+qTV1z2TZHrw+mxDspfT3ZmLj6k7DAU75d5UE04w==
X-MS-TrafficTypeDiagnostic: BLUPR03MB389:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;31:ZuLE6uQu7dpoUVkspj0+YZMxSBxyF3C+sJl2/OInbqTiUvsp9zVVOw3Y6k74UBYbPYQ+AHBZegKQTd0Txzze0CqtItFRRw/4DFj9TRYQukRpOkCmgIylrsIS6DMV3mFEZZstuErnU31vJ95T2dEyRBaft+WFpAYKRTEQ9xt3LPV75GF3L51MtIVW8UEdMqGP6nwOVIXIwILDf00Bs2HnLH27FldIUm3J6nHPu6r9lxA=;4:08MrLSCLhNpqMesBqmX9bYl0ysSv/OE4+jZntPC46upGHys+2WULF/D6S2oC5p560oE2ZhLwWIoQdG+3l7sbiUH4n0MS0fJ9/AvIETTcpmpooGaK96b4/1pnOGqqDasKzbbYu/jNmeduZrx3FmXo5s3fRF6rOKIqWasABRd5lOV58agWmbe2HNSxBLiRCriuOUD699UFjqlTrPxDWJpA747T8mMgr0Ah6K/Z0PDIJHECS5Ots4qJ3xeHzehQv/NskuGm2udm84Qdf0kyGO/ifEh08K8ToLoJP1AZ41MhBXUQBR0adveWY/4LTnRyPdmG
X-Microsoft-Antispam-PRVS: <BLUPR03MB38909052D2C67E30C4F30F4F5A30@BLUPR03MB389.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6096035)(20161123565025)(20161123556025)(20161123563025)(20161123559100)(20161123561025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(201708071742011);SRVR:BLUPR03MB389;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB389;
X-Forefront-PRVS: 06259BA5A2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB389;23:n9sPQykCJ5e4Q/dy4pvxxcpDEUvAPNdtbP4td1fZZB?=
 =?us-ascii?Q?jEnF8GW7ajaBYIoTZSQkAoAXAvLculZxP0K/LpsjJ7rVoNCRS7LuRW0WG2tS?=
 =?us-ascii?Q?aSbY6HLBgsTEmLwwxIT2tKm4KvHm2A2CZTTX3p5cLmyvAb3xjgHuIyATuQ3Z?=
 =?us-ascii?Q?7a3tnuHBGbqpb/14MVjr7hJGeb6RQMMfm3PCDMTkx+EXwd7seiPO+/qwAhJ3?=
 =?us-ascii?Q?PfMu0ZeWUm4vjjKlUoYirLDjhr8TnAP03SLFsq6oSC/W5taM7kyVd/lc5+91?=
 =?us-ascii?Q?ajOqbHOSLx1YPWwS6Yh3OBCFId6tpEaKDiulAyMtu9/yJ6C/GmKgeKAsIXjj?=
 =?us-ascii?Q?hJkA9FR6Ib8ztnhUc9dRiBJ9jLEVGnppoWs0mveBIT46Suo0LHjjR2eyHOkT?=
 =?us-ascii?Q?1fx80k0Iel7wMador3ZJFo4SxX240F0FZCQAbBHhC7V4QZo84VMrgiZC1LTA?=
 =?us-ascii?Q?ZNN7YChUSxsmHQzYgkMahdDYmh4zgsGw8RSOgQuiLIDekACUav4XMGOplNm5?=
 =?us-ascii?Q?AinY9L5bL76ugnawIfKQb5qVBDGtBGZQl8Mg5rQtdvevmDMJfTwBAHH10XxQ?=
 =?us-ascii?Q?owrbfp2Q7HFL9vdwOtWlBKdTzUIidpgzMIV/7K+uoOKkFL9cVDnqNWuY9sfC?=
 =?us-ascii?Q?8smsfX2EIjHN+cl/oRiCzdKx0fFoVr4LjBSDGe0VOIEL4Kcz/8LlANgTAeCl?=
 =?us-ascii?Q?PSNqGXcHEID4NcNN/wEOghKz/FFAE5MU7k6rsoDmHT8fXuEd5rjjCzVkzGuX?=
 =?us-ascii?Q?ZXGgTTA2/BbqjLd+CbehtVTWbD32jA1vRWdUb/vHqecAby5Gd01TrOfevFJl?=
 =?us-ascii?Q?rTlOJi2MCosXJnPIi3Fhgdb18k1lQqNLh9LKpjI76wbGLCitxZhNtSmxl81a?=
 =?us-ascii?Q?2hAA/WuWNJOTB16TxVanovNFUpirbHi3wc4FlUqclAQ7YU6oA5Nf9OFj0M/I?=
 =?us-ascii?Q?nSYSWNSFjfYk9VCTJ/jBg+nSGCaXU8hnBskia9XekEYar86ZW/PbgsbHO2ST?=
 =?us-ascii?Q?O7a6C/wn4a5Q9arW/fhjZAcIn84Yu/dOX4DZF0rQGpcz2C6mAXzt+ufdnTqY?=
 =?us-ascii?Q?nX0iTo+/s83LmCwkfO1S8bNctcqKdaFV6Jz+iv1dKcRZYJOxywQ10s6Dghsz?=
 =?us-ascii?Q?WYWkr+cukDeg0HGZUExxvQynKFRQaV8tklvjeGX20VhpdFtnVUi1Qu7YxgrU?=
 =?us-ascii?Q?Xl3A2QV6CBpWq8MsXw8xTZwK9OQmhef60PVafSksf5Vmc6i2CDp2t19wtRL0?=
 =?us-ascii?Q?P1ggQI3JJA6kCc8EHZHDrUyN9Q8gh4NykXdiuSVXH0mBQ0MlrBqdTaPSCDhA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3aBdyMCyYXNgXnBJpw9rJadQOO5v+gkaUJG+MS/3EDXs23T/tHswqHhCtlAoN0MmG0d+3+oxWv5zm1XtWAS8lu8w9nl8d95AojS8otZa64smwZpa14DNMWRZDVSWEzrySD0Lt8mjsJDUfSP7KC4kN6XBfGZAqwDxljwZ5zjrDBYNpg4P9REQbOjfGuRSx2Fq
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;6:rSAKqSvM56TGTM5YJ3+mp6CkGF45EqAzT6YKeMCzLQjFmodJrXHk3JyJbX2jpan4JqJO85fxVV3SdLQRu2VelIQPfqbs4KcjQlp6X957bzFdyIl4QYOXPk/jAroFcmhWJGRa6QZQSIKlttySHLIaGgOPuH6NGALIOWuaZLTfUDmLbn4Tz11aEGQpwO73mywjb9WJWx7aj9BCRy7nfuq6tZUiAPyBVXaK6QC/634JycEpmmjslzEnl6fZtub6utgxjINkp3V2CwN/INC/P4UnWPGnzBgymJZTPz0Fq5wAM1VLuWtP8LLvUib3i+Fmxl+rL3i/Bs9D78Rzb+NG6IvOaNMVQdfHE/JRiYyGAE4a9hiQW3+bynDB/cjsvbZ59tvFBx8brTULNnZNEtLLNrNdd/yBQdjtURFGCzLNfeKKznW0rsbg1ZwI/FKrGATuEuaiJwkp2IApT4FAUla9a6PwgA==;5:5vxWrh0H1Mb2jHRSN8VmKxeMKFQTc5kmnY82mh40OFhExUvFWvBHaHvpDyrUnsnOLGoI5rrzxwLfZxoy2AGNqXQK6agMLTHvrCQEL/BOR5vmdvsmoGTyRroldW/icojTPhIhSE5oMgiRehR8e8tEXXAxccvJiORG7sRG07XCZnY=;24:eQDwpJ3A4G6QNubP+b6bOKRcy8/RTcTf8RG8LFh6YuPpEgC3fI4TiiiJiWfks7xUsZUhL5KsYdbl/5lzvcwmtDDS+er5AsGaSGrZVJJUe2s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;7:LgPLkxCGQeblVuE8v1oDUCi2OXyiyGsfNLsP2J5+hsLMxEx5BQyTxcsZle2W0BjQfjftV5ql+KjL+nRpevJ1NtzQ1FO+2Z3ggvzFUt0coyNgF4yMiktuIzFxEM2adehkvGRvPmWh605WrilRiJ+STw1cHXUJf1rwAMqF7syoMF6V7CN+2VZTSVsEfoJ7pJK7AshOAOGwqrAnWVjtMD3+nDck13WNjSPHTbQYrUDRQMoxo0KU9CBX8+uyoswfXSUQ
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 03:26:01.9586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18399ff2-1c6c-4900-c1d6-08d5945ba1de
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB389
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to i.MX7ULP reference manual, TPM_SC_CPWMS can ONLY be
written when counter is disabled, TPM_SC_TOF is write-1-clear,
TPM_C0SC_CHF is also write-1-clear, correct these registers
initialization flow;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	use separate patch to fix the clock name typo.
 drivers/clocksource/timer-imx-tpm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 3f97d49..7403e49 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -20,6 +20,7 @@
 #define TPM_SC				0x10
 #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
 #define TPM_SC_CMOD_DIV_DEFAULT		0x3
+#define TPM_SC_TOF_MASK			(0x1 << 7)
 #define TPM_CNT				0x14
 #define TPM_MOD				0x18
 #define TPM_STATUS			0x1c
@@ -29,6 +30,7 @@
 #define TPM_C0SC_MODE_SHIFT		2
 #define TPM_C0SC_MODE_MASK		0x3c
 #define TPM_C0SC_MODE_SW_COMPARE	0x4
+#define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
 
 static void __iomem *timer_base;
@@ -205,9 +207,13 @@ static int __init tpm_timer_init(struct device_node *np)
 	 * 4) Channel0 disabled
 	 * 5) DMA transfers disabled
 	 */
+	/* make sure counter is disabled */
 	writel(0, timer_base + TPM_SC);
+	/* TOF is W1C */
+	writel(TPM_SC_TOF_MASK, timer_base + TPM_SC);
 	writel(0, timer_base + TPM_CNT);
-	writel(0, timer_base + TPM_C0SC);
+	/* CHF is W1C */
+	writel(TPM_C0SC_CHF_MASK, timer_base + TPM_C0SC);
 
 	/* increase per cnt, div 8 by default */
 	writel(TPM_SC_CMOD_INC_PER_CNT | TPM_SC_CMOD_DIV_DEFAULT,
-- 
2.7.4
