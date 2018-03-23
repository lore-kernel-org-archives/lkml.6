Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCWPzt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:55:49 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:25568
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751691AbeCWPzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:55:46 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx: Set CLK_SET_RATE_GATE for gate and divider clocks
Date: Fri, 23 Mar 2018 15:33:26 +0200
Message-ID: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131662941441816444;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(39860400002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(50466002)(956003)(105606002)(48376002)(106466001)(26005)(356003)(97736004)(53936002)(316002)(305945005)(5660300001)(59450400001)(85426001)(36756003)(47776003)(51416003)(26826003)(50226002)(498600001)(8676002)(81156014)(6666003)(2906002)(81166006)(8936002)(104016004)(110136005)(54906003)(68736007)(16586007)(86362001)(1857600001)(336012)(4326008)(450100002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3309;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD004;1:MKCzXgGRZhuXBetCTUVYO9LvDsDJgS/BIfih24bnbVGFH8imO9k1sV5Ad2Eyh3cvAGJUH4YVeDoVmhGyuOQiCKYRbQYXKGEI6Shol582lR2Cy5PX6Bs7eBVX27fH+pjR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1150ecab-8462-4761-34ba-08d590d6892b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:MWHPR03MB3309;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3309;3:VJdByNmZgLOualxtr9FmqJCW2Xpki5KmbGahOvgMpOV2onNG7+misTREFwyJi7wxoqy3i3zEdjOmaimeDZRyZSJoeI5O1T85x4FvaZngHHMHII8nDhqVlZFEj51Z5+zJfxGmPq9dr8cMC8etu9BeuT/CiWVB7D8hQf7li695gdeXSVpGZzKLRNqcxnC/zkaBJAgLAAnus2tI4Lltmh5Bpd8vVT+MpqKAMo7f0MyP6qLAqGLZuKeHMv3np2qbA8wioevhaoAoNLWo1xfcTDSDgXiiUfAxVYROngoAQ3uAFPiAukjHAwWWmG8JLMQquIr9KjOEmPV/B/epb0/nVF3ZAffgLW8uXdbZ2kjpFJDH6Ro=;25:uH/eLSJsto/Y32gQuZ1+OVLzmZwTUd5QlVa0swLxttLyyLfGNvCRrG7A8K0XWoAeZU8/S/2GiZWztOFCRdyqveXElwPo3LiCL1KaRtDxri1QBemU2UN7HVmffJ3NvrQzauRkTpV0Y6qosj8je3iL30Kmsk/3+QAVtUCIEC0dv8Ad0HUVamiduawsZ7A44W0Hztd0ZsIYuGXPY7Qa5wFUcQW5JdFD+SrpUc2SHsb23Q+8k3B6eRvxvayzwW+jZmVseUR1lmyCo4qZdrmQcyHnxo6MtD61fEpbByKTdaq5/ZiUXsCpgIAYsmS0UVzNpU8RpECEprnkanptjL5TMfJ//w==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3309:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3309;31:ISeS1pYP7cU7qA/3je9PMHDbCVBiITI45kW1BqeRhDhnm741sQhW/hN7JwD3FZtvYLOBLBtIl9EH6Z5tUrKMk0eIIpWkPZdtZsUQ/oADUOVhZVvSlHo4tXTJwWhfv+toLDSY/oTIHSiTLyveLC/ii8LIHMEGa4EGz11pooJ+yba+ZcgdZb+xD1qOvkITnrq7gtRJVuRnoVIvU3LlW9Ede5da2SevSkUiS6Qw1r4AcEc=;4:+vMOXchKYDjH2Wu0MN6sYu7EWTXEPjzhxnqRtQfRsb+nF4l0qaSPGaxfuZLCi9NTWgRTh98f8vAIFHjt3qxOydiyhDSQrJDKqUh9nDGv8MkoWoH4smlOenvsqWAmZr5HrLmONSQnUreoy8bqmozebhosdK+FgVKQu66s+EEF6rumANk/h/AgH3/n7buZoF5S3+IOeIAazZWPwwEUk2U6Ykq8uhsB2V2Xe19lCvCSrRFOUzzXv3pZ+gMG19/qtQ/CEZyyGgZmTMTMl4FQOSOFmYn40UZ8nbcAM8yCZMivUD+91PIJZUnnPLizWa7v4JsU
X-Microsoft-Antispam-PRVS: <MWHPR03MB33096984F3156F752715C176F6A80@MWHPR03MB3309.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(6096035)(20161123565025)(20161123556025)(20161123563025)(20161123559100)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:MWHPR03MB3309;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR03MB3309;
X-Forefront-PRVS: 0620CADDF3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3309;23:7BI1O8bjJzhUrbPSVgtZtDWaK1bLxkv87emfC58jL?=
 =?us-ascii?Q?KmTfUzMjna7rsmZetbNBK0R3+NEaM5waRR3JwnXaLL0eERa000AK85pFO3HQ?=
 =?us-ascii?Q?THCiUcgAEF+N5d8HqlZozyMjA5akKC8wgqWGC1LjZdcKSn+1n7W0UF/+K4Vv?=
 =?us-ascii?Q?KQuaBgcV2dGbFyjXuFDrZRPWg5+Zu24ephJ0gtBEd1S27pKM4sQRCIDO3aUt?=
 =?us-ascii?Q?JRkTWDnYRp5WLbviuUQeUaPYx37b/MJjZLrtKlANK7OrKvKelGBZbdg9MK+E?=
 =?us-ascii?Q?6EE9LoXwdKPMVLtQC+08mp5/Aik78w+7Z+x8DTMfDYwfcj55FkiHtdmgVpmq?=
 =?us-ascii?Q?t/T4MaNc+ECX0sfrsV0cC652uVwb8+uhpfJvLtGH7KAwdfzzIZw8IDya8D4b?=
 =?us-ascii?Q?G7Sc/RHMsKgRQpXFT9hcl8XXOrbeu6nDHt+TsmDFonED7hqoAA1U46mm5n9t?=
 =?us-ascii?Q?0PdtOzr2x45Ni/UvSIw13boY/pTTRxVNKKoecYFXHyufw3IgWB9oGHW0tTyu?=
 =?us-ascii?Q?zVHKTaiTXl3bYJKTb5OteginvUJ3ajSYtVUETMeCKuOAdQLM2kpephHXh9Co?=
 =?us-ascii?Q?yjQAHxOeG/tatK5ls2U5BiuhpUheRyq8WXAry2YHD6hYD3lartSSkmHPEPMA?=
 =?us-ascii?Q?EoAP0I3M/L0IFVYIPtbZyAj5rtkcx7pl+ElKAK930vDsamhYT2QnrBWWRtXI?=
 =?us-ascii?Q?rqOlkml12++LMujvWNJG6FFdwoCNPYVU/M9v+h1n9+NwYIxG+PaNCbLGAkpz?=
 =?us-ascii?Q?6UeMbTsdBBBP+ZllMwU+suOfdA6YJTBKj+MSR8koRbgTOtqu4IOxP6ecLTkp?=
 =?us-ascii?Q?HO4AOCFs/nihLiIYchN2Xm5aFhqlzVtioYLFWvsOJtvl8cRBrn0CXt0vzQbH?=
 =?us-ascii?Q?UjxAOEdlUSg1TPULPmIKFgYDywq5tHxTedsARF0jU6kLT3UPbivXLM6YF14O?=
 =?us-ascii?Q?g2IjtyBbMXrzJxIiZnrsX1Y7VVWquH//A5hBYKTTs/H0DOklFd0JmuJz80Fz?=
 =?us-ascii?Q?mcQzrCOVNxSHu/Qky0/Ru8K0hFizFxgr1uEeVXBtwU8XTW2erbyjS1BBGScR?=
 =?us-ascii?Q?LH9L75RcfLSTNH/kpADdcRJcNisUq8ZHfTDzHbZvrUVOcm0SaUNa3EiIAqOd?=
 =?us-ascii?Q?f+h+dXapdM=3D?=
X-Microsoft-Antispam-Message-Info: c0Plcp2RuqIOL6bUYDykmA5A6lrx/RzN4OSG+ucgD86FYod5JiwhXULWJPYwrj/ROcYHesr+Xx+7xa25Zi2I82p08sC/XzaN83N4e2AkspCgT7T4bxzMHZMnG8i6bTzXh5UYfFqPQyQ93iBQEbzC/jD0v9/ioOa4dvwveEuyGQIIzwhmZscdbp1Ps2GVpc4/
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3309;6:dbAIHE+/RKYP0M0jvd+opXP3wGcgNCg/jli6L4lNu09uvw229NfFYrVBTrgszodwIHXXtSMhtwxzrWwYCU/5i0sk+FeNt57cYS/mAPT+aPdSO7E6WXKHm3z9EPkCy92wL0fPTIpiQn9CfvnCrribhA2ZirnuAdlm7UuQo8vo+T9n8QNV3dH4TKocNdF/OOGtN7gi8hBCbyVLI9uzGVb37UhaQuFBbl5HjkfaEf3jE3PcYnVdbJGeFLZyz5g5igqDaswc+8qnSEtIwhxOokO4rcelY9mWs/VNN4oQy2DbKnUw4owekWKcqvwThu+uM9TOuT69GfJO48obRd86ErCV3e/twBe3IZuGak0wSceN8W4=;5:tV6CqZU0f509YdiFY6/93e8RFbOKLhkdAU4+JtCEeZQ4rqu4JI6luuxnd016ys0M69kCdCPYmp3lAEkdIZip1BsKWfPvZNpAQEBxpml7RPdyoSmbR7mS2jqYxpioIyu25xwCFLBg0WUhciVlOICj2TsPkqY4i2muaGvDHCB2zKg=;24:aAiuDCDrwuiHjOHqrw/GzAYMFIq+QZarGAPXMKm0ebVORhmywlB/fPZtQ8loptmAmGsLjU3FACpeb7Lm5ik14K4fNLvArqvHHyqSoHz1dS4=;7:k1yMAuPDjFWc8tdl7KAiJ3phyp7dKa3U3B7THIq59WpKRxoACHCzdSGtZzZc5Xskk+GStH2mzs92yolv95lZGqwoSiX72Laz1yUzHFfKBeqBP6xh8oI2h56FiljFGxdfnp+ARzt1VBsxYfnXk5YXyPcWr9rQKgpXcD9ewniBQxlhZfmj7CH4+Beay/nfStfF3LR9iQe625kL919z4yTStVZu+qPf/ATixscx8/BUQV1DwNNMDx3epUB+IONwOVvu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:55:43.3548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1150ecab-8462-4761-34ba-08d590d6892b
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3309
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flag CLK_SET_RATE_GATE for i.MX gate and divider clocks on which the
client drivers usually make clk_set_rate() call, so that the call will fail
when clock is still on instead of standing the risk of running into glitch
issue. Rate cannot be changed when the clock is enabled due to the glitchy
multiplexers.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
[initial patch from imx internal repo]
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
[carried over from 3.14 and also applied the flag to newer functions]
---
 drivers/clk/imx/clk.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d69c4bb..4411719 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -96,7 +96,8 @@ static inline struct clk *imx_clk_fixed_factor(const char *name,
 static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+	return clk_register_divider(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
@@ -133,7 +134,8 @@ static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
 			shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
@@ -141,7 +143,8 @@ static inline struct clk *imx_clk_gate2_shared(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
 			shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
@@ -150,8 +153,8 @@ static inline struct clk *imx_clk_gate2_shared2(const char *name,
 		unsigned int *share_count)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
-				  &imx_ccm_lock, share_count);
+			CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
@@ -173,7 +176,7 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
 	return clk_register_gate2(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
-- 
2.7.4
