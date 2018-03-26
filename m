Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCZHvA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:51:00 -0400
Received: from mail-sn1nam02on0057.outbound.protection.outlook.com ([104.47.36.57]:19264
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751692AbeCZHu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:50:57 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <aisheng.dong@nxp.com>
CC: <Linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] clocksource/drivers/imx-tpm: correct some registers operation flow
Date: Mon, 26 Mar 2018 15:47:40 +0800
Message-ID: <1522050461-19043-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131665242544418866;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(396003)(376002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(51416003)(110136005)(54906003)(97736004)(48376002)(81166006)(81156014)(68736007)(105606002)(36756003)(6346003)(77096007)(26005)(305945005)(498600001)(6666003)(6636002)(356003)(336012)(2616005)(106466001)(8676002)(47776003)(50466002)(2906002)(450100002)(50226002)(4326008)(59450400001)(16586007)(316002)(86362001)(575784001)(53936002)(8936002)(104016004)(5660300001)(26826003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2293;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC009;1:kKxG2aBDwDnEyiSv457GCA4idisfDoj34J2e/kx/O4GYjLsIMwWOGJg9o7GcpfU7TNoCpExmZz5cq7XVmhQiuFDbcb4CxG7JDAmGLkyrJjsg78VnGGHEIYcmC+1iaHNP
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 417c2e59-f6fd-4189-2542-08d592ee4d84
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CO2PR03MB2293;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2293;3:Qt2vBVxzrtzc24PSQF56y7QsqryFZH7bFEjUGv8Fu0YzuEwnKk98299pcft8g7uee3/k6ANuhqU9cnp6UGB+3vAdvxogSYsaQtkkbyE5KwFHo+SQ3LsGxeKFvOO26ySxc62DHaDpL5bS9DQoLTQ4IueITY3d49FRWnb2WjFFlBhUyhYgdJgP7a54yl6+POHzOH2UJ5fLhorsKVxAHspTWqz1xW1pOQkXuZoXN2puxZzCHoVxV1vElnbXZlZgyj8IsB2d9ZEhRXN7ROVBo8RHlZHR1yjuo9zltFKrzSImFPypiJ1ZOlpiOF+9p5K+GexPBVwV9VogENqe8DKm74hBxMNjZz4I0tOOWFAf+Fkj97o=;25:J/nFk68vHomGI3kIZtQA8+WUUCVuqlGAImhrRyVmrY2tKPhqdds72yL+mXP/oUUwv0S3XXcekc/qCOxsujPoOUzVSdVelvs2WPxIGtEyCiCJjKps4P7vTY27AAS+TrCSVHJ0midvakYwpm9XLABAMfxQmglEeVpFqbSaJG3aXNzvGWUC4X7HOgQobDcu/iPCBlDyUDApbBoN77s0cGusyPeKUFNy+CRg0kZfj+2gm/y/jPhV7f/19m3z6ApBqb2wP4Yf5QhzvsvU3DebAGDz8VRwMLrURLk1faOeGPkiYnPHbva8WbWQCU/zJTcG5hy7wbSQ3iwzHymJsEUgHjPTQw==
X-MS-TrafficTypeDiagnostic: CO2PR03MB2293:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2293;31:wmLmmf4+HGTiX6gWBCwvXv+MSDubNEvlb756QkzlD+mF8hM82GtP5rPV/apNLKeln1LxmV8nkoyxgYukMd1N0GlwCJoIXkIPRWscLjirMUrpmeHc35dQy4RgZLA2PVbu6U5WlKwrGLfoUAEw0b6891kbM7od9PTetWS4Bc6ZygzHWHYmmRrrQPLaFRsqzWnLcJjT0QvAtVVpsbJ6ukF3KVttSpB354nXpOpBItPqlD4=;4:pxGDAZAD+7blCt7P82P4uW+y0+4Z9Tq+vRkYRzQdDQk+6pUzEVUm4iZn7+yWCvFQkfe7FywrvvxNo+CY87FeAnPT6CCQI5NmSTjFDyZOxyQnQDL0bXVHz82fMQuaGOT7lR23AxCnDfwhkkgBB+cGbER18P92pv4AJAcuhvw+YVP1MuXxNfZKvg71Y5MY2x0tv5VPJZWQIAq2P2AQdz6XGSNi0QFKmfFVJA5Bu30YZoUebvYYNam3NPS3WJaACgzdPO61hCtsra37C+mJ+VIwtL8EaREQE+qMlCzRN6kLDSU/6aPXx0Na1sWZYZ37KO0LVLYEJjMpFU07bDGkQIOfD7zyWiCxDBNSV7704cbG4aY=
X-Microsoft-Antispam-PRVS: <CO2PR03MB22937E952AA5FB7A1CD4A8B1F5AD0@CO2PR03MB2293.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6096035)(20161123565025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123556025)(20161123559100)(201708071742011);SRVR:CO2PR03MB2293;BCL:0;PCL:0;RULEID:(400006);SRVR:CO2PR03MB2293;
X-Forefront-PRVS: 06237E4555
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR03MB2293;23:P0RHlEPt/OkjdYRp6Hg5VpypECmMMqhptFgBcDSqF?=
 =?us-ascii?Q?6tngLCfUbPZxhHdeBeSoD8M+HP+YgJ3GyNtojb3ou8HoAlFWAUxGanP3oIxD?=
 =?us-ascii?Q?G8ci3IEVtxM0KhtFNLl+mZdQKjFxIeK+oVFSsWzE0U2H382dGKHOSiBleiiy?=
 =?us-ascii?Q?c/oLwBhxdJMtrHTnHSZc8ai7Em3Zj9M6XwnlBdIcz+yVDRwCSPHywsE3/L1N?=
 =?us-ascii?Q?ASkPfsbM66nXElJE3DLt9EGlbDsCYW0RAIANXtLcYvyZ6tm/zyOv1nLd+OhH?=
 =?us-ascii?Q?Siq3oUklMynb8psPY3fC4u7skxZBfEYZW4gGyXGoUxvJAlNrnBqO7Wr7CNrw?=
 =?us-ascii?Q?ihQ/jhT/KUiqL4EpSSTKU34qyMhL1zT0omUaX7cTeCPJ/3O93PC2lBZ0KWC2?=
 =?us-ascii?Q?pP11otmmsdTKWI+XL/y2xMwuZ1VDnSSDkUsm5AWbLBGES14TcmVfewm7eBn5?=
 =?us-ascii?Q?stUywDSEkpM7QEF89LZZeZ7NC+MUTlhIwmfP3LqAJatxwREbwNR0xjjtuM1K?=
 =?us-ascii?Q?jFUafFslb4jnYP7wxzVZnSn8tcC1Ikwqi6MhX72gQm267CnYqNxzFkpWClmK?=
 =?us-ascii?Q?wiF908QstaiHpRRZYjklBH7Zwui3KH3jm8IsNI2x2JJDwKPcNGditH9YiYrS?=
 =?us-ascii?Q?FMjp9kcxI613o7mwxYtxz43vIWe2zvUnbqwMZdZesBlfHMZTLAy7uOocIMP6?=
 =?us-ascii?Q?qLpgrsjL0AiGpAVDsqM2HQdjVDd7w0TzxvspCEGg5o5z6X7zTpYXL6rd6jv4?=
 =?us-ascii?Q?h/E3VZ4DzKOCnobhCK6VRZQuguVSWea3FAjjq3ggmzCDQByHN6G9YtEhbTI8?=
 =?us-ascii?Q?k6ErHv1rrlxRrR1pzMWPvPz+8nNOgg4SkTsy1s61/ihCQ7jms0fl3WcaM1kN?=
 =?us-ascii?Q?/f9SiSGLfB3vKnqcLHGl4+B/TdTIQxCxS0IRsbOizOzjiAjuTms9CBmZHX1n?=
 =?us-ascii?Q?G6Ki2e8gJe0YvqRPWEWr26lCdiQ4WJ0E1Co1Uec9UUcunI3lAwP7Cf0G4+JZ?=
 =?us-ascii?Q?G68NuvCHVxg/pFe/nkVi+1QMkIC5lkPB7QV3ykDKWCWzvyYroCg20kLnJ8Nl?=
 =?us-ascii?Q?FYhQRi0ylPi+NH8XVU8042J92NnV9/duR6vy+dqZe/DbSsEgE8rdE+hV5iHR?=
 =?us-ascii?Q?TX+gLxRhwoATB40OqUwRaO443GvUOFrKCirQDGJrExGpgDYZsjceA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Dk4NgGaBXQE4MDIfqxKbUNgJzaZnslVbUBZZgJB/BwjSeJVMZe4BjwHZhcchkSkX5RAv9ORFp2KBCnBdwsgh97Eozyn5g6eVcDQidY1T0Kmt2dRCQMk/6uLRGBbOEHTciNBSoTvUzL8Ix/HCNxwKNPgx2lVFJA9VfxFh1lSNu7M8ZtNsB56aLjCQZ/Hndrr1
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2293;6:R+jQtwyuNcSTx61FLXsOwFcmjc0kz9qxBBTG7oZlShX1r5/huZ1/7ztmEj+D3mSBpj3KlYcBTFkysbH/n+alIqGYuPu2UOoGsZr+mPKVlzu+jTTmumZCU+9W3Yxxi7pOIn34vbz7y4v0XY5qDGeVyZtc0x0viYkbRNR2JFf0zhTzBaMNPQqp7S6Ns4DnM0Ln5Rg4EWXLUShOtpDILv9m+sj5AvEu6TD5PjpplNxh11CLVP4AA84udezvrzN/Yjs0IXPm7BgQD8eac7WxfEGE0Ilc4Pd1vVbbjV0Kw7njhka3WdJ67pZD2cueSh/0q/jDpUyglwqg29AlB8U+zaLCWZAFo8pqXTTtOZi0lPGWAfairNdAkSF1TLdKLeyRJjG5wTaIofUcapDckH8LtYarLSr9sw6nACk+649vwC0H6YHTgkKBn9fzv3zph7yIAw286Lejbxn0XI5LXBYJp/Cu+g==;5:v5tQToTpXEzcCHkId5U4ZORF10ZhopzbPg0YVJlc0AxkzeHFjAUVFjRKJGpiN9wtzrdjQO8NEq4f89Ll5oNCwcCcBihkm8erXPVfw9bnNi1tcyv7GU8bXydQXDG8PDoT1qD4n3K+r0qtmD/39KUPYFABs0x+Z2xgtfGdPbunatM=;24:LFIbQ4GeDLFYIYJhwg5GBZTBd8uEld+U+DyfMyxeCdR/FaMMpBIeR7qfW815oyTYL9dmXPE8UMO0XsJHCn2gzqfKxbcr4yzmuMuJxYOPjvU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2293;7:Uy3PqQJFXbcOUGrU6Gpo/4CARPhP72BSCfEnkfyR1DCTKqCQ3IFvXgdetCXE96RGjFLJ7w+WJ5SE7k9Gdv4svDOad5UrQ7AsRV0EfgHvvVvbRrJRw7fm0vdR6k0o/ON5Q7MPRD5gmSwWIhoCPPQ9v4xhm0rCXeKU5gineOhKy6bbHjWbHCn2k5uuUGT4Mh5/IkpPNCVwDA5y0tskdKlYrI4HwLnIpatw2afiXDgFvvnOtntWogJ1LkOkRh1t06tq
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 07:50:54.1610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417c2e59-f6fd-4189-2542-08d592ee4d84
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2293
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to i.MX7ULP reference manual, TPM_SC_CPWMS can ONLY be
written when counter is disabled, TPM_SC_TOF is write-1-clear,
TPM_C0SC_CHF is also write-1-clear, correct these registers
initialization flow;

Replace incorret clock name igp with ipg.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt |  2 +-
 drivers/clocksource/timer-imx-tpm.c                       | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
index b4aa7dd..f82087b 100644
--- a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
@@ -15,7 +15,7 @@ Required properties:
 - interrupts :	Should be the clock event device interrupt.
 - clocks :	The clocks provided by the SoC to drive the timer, must contain
 		an entry for each entry in clock-names.
-- clock-names : Must include the following entries: "igp" and "per".
+- clock-names : Must include the following entries: "ipg" and "per".
 
 Example:
 tpm5: tpm@40260000 {
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 21bffdc..7403e49 100644
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
@@ -179,7 +181,7 @@ static int __init tpm_timer_init(struct device_node *np)
 	ipg = of_clk_get_by_name(np, "ipg");
 	per = of_clk_get_by_name(np, "per");
 	if (IS_ERR(ipg) || IS_ERR(per)) {
-		pr_err("tpm: failed to get igp or per clk\n");
+		pr_err("tpm: failed to get ipg or per clk\n");
 		ret = -ENODEV;
 		goto err_clk_get;
 	}
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
