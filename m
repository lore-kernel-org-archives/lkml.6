Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeC1D0O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:26:14 -0400
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:55476
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752199AbeC1D0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:26:07 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <Linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 4/4] clocksource/drivers/imx-tpm: add different counter width support
Date: Wed, 28 Mar 2018 11:22:38 +0800
Message-ID: <1522207358-8388-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
References: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131666811645766454;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(396003)(376002)(39380400002)(346002)(39860400002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(6666003)(54906003)(110136005)(575784001)(47776003)(97736004)(68736007)(316002)(16586007)(2616005)(446003)(8676002)(11346002)(486005)(81166006)(486005)(8936002)(476003)(81156014)(105606002)(50226002)(86362001)(50466002)(4326008)(36756003)(48376002)(106466001)(76176011)(26826003)(508600001)(2906002)(51416003)(336012)(450100002)(356003)(53936002)(85426001)(305945005)(26005)(59450400001)(104016004)(72206003)(5660300001)(126002)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB386;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD018;1:cRNFttkb6O8tbN7nmVzcBPBpzbTecIXlPORlpdNJNuF2C0SkgC8M9iumm6mLl5B4dWG/cW5Qi3Fy5NZxEyXLpHJgdpFWbMLPMwPenp2SMF/syegVRImY4CdWhBUeMyaN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9273ee94-e6f3-4148-ab36-08d5945ba351
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BL2PR03MB386;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB386;3:LXqi6eT5xJb4L+78I+FKeLwuVWVEflFZqz5TfSmI193NsdUjx3e5CIpLJcvzUUUK8wD8qvHvtlBFuGV7/eY32WQau35o7p7Rx0J+k3xt3pkyaVoEM0Lqf3P6SSzasDkgDCL/QlHpCQqXZPYdxx4TU23Blh7f99N1bK7tY4tmwYC53B70mddeCOXE8OV7+jvtVYnzFtlWYwT+NH0A6bWwAa6tewaECDK1o8PXtTvH67U6yGp3fIW1IBDc/T/D/n+uI7n2v2M+Jos7ev7gDVzVEF6xokWY/j3E0wT0v/YHSEnfIUjMddda61rhtE0WFDAaR9PchYjeXmyZLf6x4k0XSWC3QFLm1y80OtS/3HLY0Bo=;25:jkyAQtU2ucM6wuJD1R8ef5NT55cJteLsnfASrMQhQgePAjFpSw9A6Jzw+BLnYfj2GOsCbila5Rkd1S6kcD4ulDgfcWkkB7875lMeYA1KIgyYUW79n55HaDgoP4tzB72y75Lyu4YM3A5XuOEtViZr2AFLvwuzbp41WSKR2FajQuYB3hULUYzXJFghO+W7vhuMQrznfdOctr3eDkb2ey6jgmlGLKOr33JjZBGKwUPiisKG577cYV/Lyk2X1g8eBqJzRaan7hciF5N5hY5pcQoZoHB9yKIbvBUE/5RXLEbC0NB22hTh3V1HuT0/Y/tPqUE7586cG5gHKCPsRORb5QaB8g==
X-MS-TrafficTypeDiagnostic: BL2PR03MB386:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB386;31:0pTArXSHskXHV1kN344sYpnC4Yuip9BKqCIUt4w9/DRTSa3fJEqX2vwIDOehSSEkAJ9C+z0ol3AzvMwkojVj0t4JTnWqCBToSoreu+Rlk0ekU22VjxjGq7kDVXThUUOCr3Z6jc8GlM177DYfKt3hWURW4Px+FVJHhSbOeskVpZWPxoSbz4qukZxYqPj2vNW0wC/QK9NE5ylQPTsFKviqTmgKCi4lNzCMMJ+UvOM1Hsk=;4:rXNXhzd3BryECyDFI6jacaHoDVzHVt1HcDs4sIxdRzLtMRbnZHN3dCHORT5k9guv4yyZt6asBU/r5Ge1M0rAYEKwZC8h2Fbmsp45xN23y2kfd8b09dIcWHczmqQVg5vl7hUdO1m8I8eQZm9zfCg5MdIxyBJRowg/9c315h4i1HoY13u/Qxl1UEspfmc/2Rll2+iYvtG+I0+iZhJokrzHC+Uccxv7IwJ20hNjOOPcDZ8UJsGg25VSXpdSCma08MlQsW1KK4EcOovx0lwKwRx6OcbbBw6JFYyqx8ImdJ9eNC6TXtfgBgSBwEAfWMoe5Q2V
X-Microsoft-Antispam-PRVS: <BL2PR03MB3865448F30E7444B7156CD6F5A30@BL2PR03MB386.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6096035)(20161123561025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123559100)(20161123556025)(20161123565025)(20161123563025)(201708071742011);SRVR:BL2PR03MB386;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB386;
X-Forefront-PRVS: 06259BA5A2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB386;23:y6TQ4Wf6cw9m/IF/pVIJju2jwJlbW96YFLOH/2ziYO?=
 =?us-ascii?Q?PoWLGq3p4bRYmsVv+/1w+2CymYgfC3PIzHuDoXztr9iBmDhteTw0IriS+wJV?=
 =?us-ascii?Q?24mOhCyaGaKGNvq3KaRABoNNGfIYiZVBO1eXZplo07SV1rTU0+HEtp9BwwKw?=
 =?us-ascii?Q?dVxClhyPEJezCh/ZxbfRaIMhcSSrUIYjiPJqB3jVmdgLPKrAlUUEO13+yBaD?=
 =?us-ascii?Q?Om3wRvy1kLVMoJdA+qrLoFE+YvawVCV7/ySx001Ddp60BGhZhQbUb7/4Yhhk?=
 =?us-ascii?Q?GoV332VrEEqiENnhEOndy7HLsGde2D9EOzh9wDKysPSQ6X/fBW0xCU9xbJcL?=
 =?us-ascii?Q?FAFpTz1MzSeCWnazoicJtXp5xx13+lNDS18MgBr6VBGOKgnDGHb/SXxPeE1m?=
 =?us-ascii?Q?nOcpoc+mRA8c4jysVfyfY8iHodzYAEYWXs1NQ6N49JmTsW0PMV7O4laeo8VM?=
 =?us-ascii?Q?fS+YQwZg9kZpfWVVWToRGAptrETUKLnoAF2H3kuKOiPZtmver5k0EgIoMXCQ?=
 =?us-ascii?Q?PCsXwBQKfcZGVFDP274wN9wrP3YqPKPJxBTA4cG3DbTYouEVyps9ri8AXH/t?=
 =?us-ascii?Q?c1x0+eBhTeYB+WAG/AtfCAwkgPxH6uMXYzzL/ZwLM1Aj93x2blPHMj1DZyfT?=
 =?us-ascii?Q?i3kSG+gFdYrYIJ3YACPXAoudZ/QXQHo2t/X30JcEqmzJpBNmu0xcvFzQhBsl?=
 =?us-ascii?Q?TOhXDVIp+k1KdtAr1qt4E87Qfb+QtwRjPLr8GSx5jzmL0kgKoHu5kGlLoyCG?=
 =?us-ascii?Q?3lwgp+ydblUcjdzsaqP80fPNIT+S1+jD7LgYt8tPitIElSV0/SUKxoojZwui?=
 =?us-ascii?Q?fcE0MrD6ZS6AftsJPx94VfxXGEpqs0ilhx1UNpC0v81HLkf8W0n9wSukn5Oq?=
 =?us-ascii?Q?3sY1t0p0D9ve40Engh5bUZNtcXiyUNSARynIA/NCr6KP68v70LIbZ+wPu6ZO?=
 =?us-ascii?Q?7EodA3VGQO78MJjRGBUA3DYkiIupU9hP74LiN8nEdc7JJBLjQQ6W5t5gJSv+?=
 =?us-ascii?Q?I6NUFap8L1GnSCuJA8J3h8h0zlxPV3F73QIOjVxo426Zao2W8bW+g6CKePOP?=
 =?us-ascii?Q?ktvbeYTapKAoGucJQFgU8Ju5DLbDsRS39BPvD7O/hv8Nz/N9liSn/+CTaKES?=
 =?us-ascii?Q?wfhxAO4vT5btAoK25xZ/0TD3YuoRZKNfuTvOORgVk1zmFpID8CKLsMdb+Oci?=
 =?us-ascii?Q?qblEklEiweHck+rKfovHQ0AIFMWqOOziVWzNlVzoQxyMh2+qnGYuZF6v3EF5?=
 =?us-ascii?Q?SvJTQhgWu8cjz9GD2anBHpe6Vyi6U3inubVw8IvtJo4/M2Y9sTo4MimR2TMA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: kFs2VPRAlNge3VcwogPOrkT2dOv0aCSNqR9yf+cBQ/lcKeLxlPMUW2zwh7tMkh7F4iT2bfAupeiRZ+rN60iYZer+QErZf5T//2sygvNSKVhaFqjQR3IbT9EV11Pq4yqkVdoDzTX3MalGQoWO3a1EYftbnA0YepitGnv90T7DhMn3mbaZn3QbYAi1Qf5kuLuu
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB386;6:B7KRs+/sQ+yyClGwzeZLVJ6VfPhxORr4y+JymjI/9i3dxegU9qEOYnguIJkkSXq5T9NPDgXqSvuOlvTz/P041TZKyFmDTKOUhr1gCXQhYwPuns9mEMq+uIS6qKzXPbZLHeij3BNEGG5nfABUxS9Gso5eqFI8YDWrVps4NkKadx2X3SE0LZR/CgrgxVJwaKTjPZ07kpiCVqrZ/x3fjvzOwsAoPe9lKTFj0bkaY5a0P8vqOSskCSgmucQNBi1Ovz9+N8GY+4F9pYNq0P0GVfaVXn3ucCb1PyXIu7gsEF8rE3P7tYTqYq6GE81nsrPMsyMOCh4RPHrmTEB7N6HfEf9idEFZ08GzoVUu0nzlN7L/DtfCV4et64f1QjWFeLK42rRonA8+DtVuSYtqVZ0hrt8zXfn4gID+U4wYtpEfjuhDoXe+OBLJMCEwq2Ux1F5PX71m+Z3NdOmXy/ZydAQJEct41A==;5:RKx+N4spRyiu0YFowlS59XTgJzLOzTmeR5egmscmfWHmwUKNEmG3SrXzWi9ph4Kib4tu1KKoRPEqNKFSbOasTlQRqoO3Jwxx+EN2q7c0TI2/XWsY9QJzwTL0TsmeGS9PyhjSJewD2dVHHUuYtREaLU91C9O+gX9A4X7zm9iOh9w=;24:nGj2ZM/02ieNr1diO69hdclLxp87r3k4dN/QqBe+U0BStMYA6Vf1PPD2rB4tb/A0gXpPGj3dSMnFWCMPmdUIselAJ1MumDeUH30+tXvbXU4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB386;7:gw+fFvyQTAURyAJIzyPoTJzjotJu+fbX+hemAQ9KgARPYr1jGxmGHQbwbPm6fF3l9Q9SReLtgtZKKXK8GWRK/C8acVvB+oVfflUuFskktU7bA/ETpvjfv8ZVFEoDtI4mBgWu0v3qUcMz24GCM/rD53JvhHlC1VAQzFYtlB1ypo4FWnI/IaibHneeOWQj1UFQ53JJlTe634/SlRZajFxKNDEQ8KBNv+juZoAuXWHKglA0bXRgdEb9q9p/yAKQu4Lm
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 03:26:04.4050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9273ee94-e6f3-4148-ab36-08d5945ba351
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB386
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different TPM modules have different width counters which
is 16-bit or 32-bit, the counter width can be read from
TPM_PARAM register bit[23:16], this patch adds dynamic
check for counter width to support both 16-bit and 32-bit
TPM modules.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	use largest prescaler for 16-bit counter;
	use lower rating for 16-bit counter than 32-bit;
	remove the computing in counter read function.
 drivers/clocksource/timer-imx-tpm.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 7403e49..05d97a6 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -17,9 +17,13 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
+#define TPM_PARAM			0x4
+#define TPM_PARAM_WIDTH_SHIFT		16
+#define TPM_PARAM_WIDTH_MASK		(0xff << 16)
 #define TPM_SC				0x10
 #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
 #define TPM_SC_CMOD_DIV_DEFAULT		0x3
+#define TPM_SC_CMOD_DIV_MAX		0x7
 #define TPM_SC_TOF_MASK			(0x1 << 7)
 #define TPM_CNT				0x14
 #define TPM_MOD				0x18
@@ -33,6 +37,8 @@
 #define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
 
+static int counter_width;
+static int rating;
 static void __iomem *timer_base;
 static struct clock_event_device clockevent_tpm;
 
@@ -85,10 +91,11 @@ static int __init tpm_clocksource_init(unsigned long rate)
 	tpm_delay_timer.freq = rate;
 	register_current_timer_delay(&tpm_delay_timer);
 
-	sched_clock_register(tpm_read_sched_clock, 32, rate);
+	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
 
 	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
-				     rate, 200, 32, clocksource_mmio_readl_up);
+				     rate, rating, counter_width,
+				     clocksource_mmio_readl_up);
 }
 
 static int tpm_set_next_event(unsigned long delta,
@@ -141,7 +148,6 @@ static struct clock_event_device clockevent_tpm = {
 	.set_state_oneshot	= tpm_set_state_oneshot,
 	.set_next_event		= tpm_set_next_event,
 	.set_state_shutdown	= tpm_set_state_shutdown,
-	.rating			= 200,
 };
 
 static int __init tpm_clockevent_init(unsigned long rate, int irq)
@@ -151,10 +157,11 @@ static int __init tpm_clockevent_init(unsigned long rate, int irq)
 	ret = request_irq(irq, tpm_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			  "i.MX7ULP TPM Timer", &clockevent_tpm);
 
+	clockevent_tpm.rating = rating;
 	clockevent_tpm.cpumask = cpumask_of(0);
 	clockevent_tpm.irq = irq;
-	clockevents_config_and_register(&clockevent_tpm,
-					rate, 300, 0xfffffffe);
+	clockevents_config_and_register(&clockevent_tpm, rate, 300,
+					GENMASK(counter_width - 1, 1));
 
 	return ret;
 }
@@ -199,6 +206,11 @@ static int __init tpm_timer_init(struct device_node *np)
 		goto err_per_clk_enable;
 	}
 
+	counter_width = (readl(timer_base + TPM_PARAM) & TPM_PARAM_WIDTH_MASK)
+		>> TPM_PARAM_WIDTH_SHIFT;
+	/* use rating 200 for 32-bit counter and 150 for 16-bit counter */
+	rating = counter_width == 0x20 ? 200 : 150;
+
 	/*
 	 * Initialize tpm module to a known state
 	 * 1) Counter disabled
@@ -215,12 +227,17 @@ static int __init tpm_timer_init(struct device_node *np)
 	/* CHF is W1C */
 	writel(TPM_C0SC_CHF_MASK, timer_base + TPM_C0SC);
 
-	/* increase per cnt, div 8 by default */
-	writel(TPM_SC_CMOD_INC_PER_CNT | TPM_SC_CMOD_DIV_DEFAULT,
+	/*
+	 * increase per cnt,
+	 * div 8 for 32-bit counter and div 128 for 16-bit counter
+	 */
+	writel(TPM_SC_CMOD_INC_PER_CNT |
+		(counter_width == 0x20 ?
+		TPM_SC_CMOD_DIV_DEFAULT : TPM_SC_CMOD_DIV_MAX),
 		     timer_base + TPM_SC);
 
 	/* set MOD register to maximum for free running mode */
-	writel(0xffffffff, timer_base + TPM_MOD);
+	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
 
 	rate = clk_get_rate(per) >> 3;
 	ret = tpm_clocksource_init(rate);
-- 
2.7.4
