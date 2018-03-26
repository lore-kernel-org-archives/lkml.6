Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCZHvK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:51:10 -0400
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com ([104.47.41.73]:42336
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751750AbeCZHu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:50:59 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <aisheng.dong@nxp.com>
CC: <Linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] clocksource/drivers/imx-tpm: add different counter width support
Date: Mon, 26 Mar 2018 15:47:41 +0800
Message-ID: <1522050461-19043-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522050461-19043-1-git-send-email-Anson.Huang@nxp.com>
References: <1522050461-19043-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131665242569699890;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(8936002)(47776003)(53936002)(68736007)(6636002)(316002)(50466002)(2616005)(11346002)(81166006)(446003)(6666003)(81156014)(72206003)(336012)(26826003)(305945005)(498600001)(104016004)(8676002)(85426001)(2906002)(77096007)(26005)(450100002)(4326008)(54906003)(110136005)(106466001)(97736004)(59450400001)(356003)(105606002)(5660300001)(16586007)(36756003)(51416003)(50226002)(48376002)(76176011)(575784001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2303;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD022;1:t7HCfPdlv0EgCloLqqjzArGBfBNxzoNKSYz0DxH0/7ttoA9+Vkc3vf3u4BqdUZCb/XmS4dkMM0IA71HAC2HYK7sBVYTH6WHUbwNVA8Bh3/VDu4l9uAOCpmP7TQ9tG+1t
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a46627f-fe4d-40aa-90d1-08d592ee4f16
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:SN2PR03MB2303;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2303;3:NnajKZj0SVO7ZThuWcRLvy9FaxCNceDHrNNZwPeEK1rCxj4/xgrYyNumAPHDZkchFl0BcnCtvIyvoBdPRKJ9YqXLejiBv/HgyYLc7z862WrJonZsYKXO4H2cT5iBoC14HUdJ85O4opp9Z1t03x8xM5o6IctvdTKTBNr2C6CYLzb/tEBPZKe0W0z+9EMqizkVhnLFNAPX9FjNagCckWmuhIlAQrAIj5DIqhM5chBp2b9eTvnKuu1hzxdDSSTr2l8IXqudQ/YUFO0btLATg0zaIdBwpFRXjaIydifQVqbOc/twmRhNlpF30bQCKEMCzXKTcfaL3xcps2gXgHjsTscXowH5Mqu2J5hXHQj7bf//7mE=;25:304ZYbGHQe3OCsl7oWfznBxWZc0hK+sxVosRysFT9eEzZTLUC2MOrdCm4/mjMVKPEjifcgdTFZLaoMhWAR4jpPIUm9MBj4zYla1CdUzvFRa4SkOpPROwNSQJSXVQU3nBN/AtPGnkCQCcdk24w1bCs+e0HfOJGlqMlcS5Sp9VFr5czY0qTwUzzoSxHUOLdWQVg35TbaKdcwELyyab9HcZe7pwL/qk7NdE9Q507AWHtU6LYc0KgEmyYmpJwwjl2BBmUuCj5a3/hpPPE8XKblMMPqrc/wrZ9PUvaCN+B+zqYrNVVCY4ndckXdppAkTGirCzoAsK4Io3C0NiTQI9JHYHng==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2303:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2303;31:62Ei5m8Wj+E8Oxxrnwh3Cbnv3Ejd1QaY8yNGtf2Rj0EJZuJXx/ayXT//NS3HbberHv7jLZ3L2EMLWoTBEIOC6EArk42wEjzuaUGw5Q6OCb2OEYXNHeYmbNINQfhHgXZYRXoo23wmnrGpHSW27MwD63kW9/GYCBsNku4JN/JdUPQCdQacS4E9c2Zh6ULMhRlDjLhZ2DVw1JXx6jmQQm26bAm1Ij4d+T/pzStEJgzindo=;4:uDWyJdXhfs3V1uHo9Qx3pkDkO2OwQMhFaTZeXNuG6PtUNnXsoAXSJuUF2y/26zz1xbllYQBpOSRLuQT+DWoqnr6+s1KYj6iXeGImpkEg7V8h7X2X2nSH4LkgkViVnjlCX8XzhAPdt/PiIMxbCCiZt4sYHo+8q0H9q+T6B1UtCJKecE3mWd9Fyc8LX9GDu78fjK54xhqLy6a9oI/KJMdrzhg4c2hCoGZYKEzJSp879KFCgg3Yfnr31pEkv9WWW18wszdVeotXqx24x89Ucvyr9OXNtFuwO87SKBWOyDXZr1EuZaUY/dHIru635bE0VoEv
X-Microsoft-Antispam-PRVS: <SN2PR03MB23034B1D66675D6FD9E915F8F5AD0@SN2PR03MB2303.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123559100)(20161123563025)(20161123556025)(20161123565025)(201708071742011);SRVR:SN2PR03MB2303;BCL:0;PCL:0;RULEID:(400006);SRVR:SN2PR03MB2303;
X-Forefront-PRVS: 06237E4555
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2303;23:b4fq+fL/Guhu0yEzhXJ6Xg21N30NXvcFhlKTn51IK?=
 =?us-ascii?Q?Zrh1KznQQ2YAw/qfSxxe6cHcOseajtS0OZ6M8KkFmRDLC2yaio5D32KIYkPS?=
 =?us-ascii?Q?QR39oTKxqSdFt5B86nnU6mAuzshwiSB4xwvzRa5m7L9agmhrHIwyyf2mwi7Y?=
 =?us-ascii?Q?BvdZSx0zWyeEDEJGjEn/l/tlzlZN63d1/Yhg9XMkR2W2bfPcbnFWvrKKj3K/?=
 =?us-ascii?Q?QbhV2VP/2oGKvWLlcpbj4HHylDf2XumY9RNae/AM8Mne4Nx7+YG94MqxC+h1?=
 =?us-ascii?Q?odslWp3DRBZ4FePO9IBO0EJQ1pfbmwoVGsynSn8kWzHILNdq1q3Ryrm2fTjE?=
 =?us-ascii?Q?lxepXfhWm3bsh74vTSySk1MqLmB9RRCmPFly2fjaJkPNZAkxOsrLRnRSZ4/l?=
 =?us-ascii?Q?j2CAX0zKBdYCrLGXW8Q8pMepHrtHJPz5HGdIZqCfeMTToMfrG9ApZl47OCGe?=
 =?us-ascii?Q?+S+x1KO1zld9cP3xkIdp6R09VbEvewpnXqK3YqJqj+7tDfOiAJMxeOakR1Gq?=
 =?us-ascii?Q?hxTU+Vijcmcdi5CFBSy18I75Ep9DCeC6x+PEAWJOVDMUmbLyETafOsnZ81zv?=
 =?us-ascii?Q?ByxBQzo30JGfwH+TUiHmWfzfXBi6pdznZF3IzKL+WQ1ARN+2sgn1EknWmIcu?=
 =?us-ascii?Q?TZZPDeS2PdbQo5DNl7pPpql9xGcQ45AeleATh7kW23SyX2QSsKRUherbnKOU?=
 =?us-ascii?Q?kdn9Z5ldNEWt0t4s9wPBJf2OHWQaFG0bMJ4n9TD66sCzXEkKUuN9QOkU74BS?=
 =?us-ascii?Q?Kwii87zJG0IlcngNbBIbrB2N38uAA8xWmq+cWIceEMci1Lt7sXRWk1wU/Kev?=
 =?us-ascii?Q?uHKwAEWTpYzkHmUV4Y4rnJvRuiba2nfAyVgRqZMOFMF4xfKVWGKN8BH6KcUa?=
 =?us-ascii?Q?QOhsIoiHLJ0fgQBuBhqdE2yqBeaNHbY/g7F/zv5El9k7CKpCV763UBGs3Smh?=
 =?us-ascii?Q?3o74o7XGh5/SdxxMJzpcT3CM5VoaA+zbPnzrL5NUCvmdUO3rVLJQh61smvXr?=
 =?us-ascii?Q?utW2z4vQzLKx1S2RFD4Y++gQgNmhpIagHhGgiV3R5162z6gca6M5ZJrfDaoD?=
 =?us-ascii?Q?jxAohj/blUWqAd7VsX0b0NlqakWSSV35plaa6Y7mxZwXf52tXTJv5rcFK5sk?=
 =?us-ascii?Q?f3zy1Feq0GrkiDZrUMdPtafPt/y5fY0cIU9aeV7tOxag2iVhEOYPT8EdjLMC?=
 =?us-ascii?Q?76FW66ohI5LuRgXs3p1ib3K8yC7t6b6z4gPSynP31s7Z77ZZMfX9qbn6A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: jT163y28bRY4feHjzNqNeowgG6k+9YLE8/9MN5BKB7B8fOAE2kWazY2lIl89YTRKXz6AIIDo/Tcvwzv6buv50NyrJhVrbu+uMtWcljNKO1WuP5Mo+zSL7Bj+5XT/tedSRrx0zbRIFhD5RoAMhKJn0oYtk4KmB8bpNgU9KZjwnMMug19Wsx2TsIqSJJ3A0AXz
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2303;6:q1j3QNfnMB0xaGJwLBczgZIXKcLElAu7nH/0t2x8rqHG9WG/veL8afXouQBEJiCOImJFPS/O5LChHLQ1RpeXyBvv4y41XDN/L8iU58E2jKbfZwC2jrQfDHvXvOyIgJ1UuL2EtggJPlPnb+A3w4LfbeHgrrVSHOxCXWKxhx9QWvkUksN7iBd6S0hDqLankiLsKdwlUw80kxVxNl9079MfOdmLg4Vxch+rOqs3OIdJ5RfFIPzzwfGrHcMe1sRrkac67HKlbAcOZMVIFPeQ0m1Gle1oG3flpIcZB6JijX2F2J3KgK1odDYqdYhEfYzJbvn4lZPuDt9ks+YdqgLkiBuKNPjAzcrzMC0EDmp3bXRdeLn5sH+RNaLZfjEtHMKpqemc8MPUF9vKlEUdQUAK11hmxkmzNyIz4tugQ6tv6mv/uC2fv9LSahBEvbKECSIcz5iI/zK6bE+j1AMvmXzhBaQVMQ==;5:bKYHu6ce4G34xDfeM7hDgJ7a3YshnkRqLDTdmSgdSALlPU8p58r5nYq7LkHVhZgqEihX3ouUEimvWvBdG7xWaWcNIyKqDl/SxiFo6keojUc8mlJpLuF/GD2FIEZ8mudGhm5h14eOJrgddXhrzkjywwfO5FHGDkCjGO8wDqq/oMc=;24:XA1yW6y3goq/Bf3gAYIlqgyoU8QOjcOh+EroOqIB8nCSbNvx6KY84jVVfUJTAbL3ctDXRGMlFTlrXUc32F7Up/FdtDHgKW37sapAcTdOdUk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2303;7:0XhrzXbP86Um00IerYgLmn+MmTWtNDUnYAPlH4MBK9/c5aq99g7j12+tnQdutFn2Jom4FrhjDsZWHUxNWIbBEy2XKRiFVesm96dQz/DLb7S3qxUpQMfWCy2g7Z6/wY2iGw0bKIX05OX0DoQRNimfWpGEIE/N+0DrwxOfSSJeTNpfwz+upDBsJLd4v50ofJeXjDpjhxPV84oyekBL4lRBxe4CLjLgSfVQZ99znBRyJzMrNfEkWaMRlKY2PgxLUdsM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 07:50:56.7983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a46627f-fe4d-40aa-90d1-08d592ee4f16
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2303
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
 drivers/clocksource/timer-imx-tpm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 7403e49..5063b77 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -17,6 +17,9 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
+#define TPM_PARAM			0x4
+#define TPM_PARAM_WIDTH_SHIFT		16
+#define TPM_PARAM_WIDTH_MASK		(0xff << 16)
 #define TPM_SC				0x10
 #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
 #define TPM_SC_CMOD_DIV_DEFAULT		0x3
@@ -33,6 +36,7 @@
 #define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
 
+static int counter_width;
 static void __iomem *timer_base;
 static struct clock_event_device clockevent_tpm;
 
@@ -66,7 +70,7 @@ static struct delay_timer tpm_delay_timer;
 
 static inline unsigned long tpm_read_counter(void)
 {
-	return readl(timer_base + TPM_CNT);
+	return readl(timer_base + TPM_CNT) & GENMASK(counter_width - 1, 0);
 }
 
 static unsigned long tpm_read_current_timer(void)
@@ -85,10 +89,11 @@ static int __init tpm_clocksource_init(unsigned long rate)
 	tpm_delay_timer.freq = rate;
 	register_current_timer_delay(&tpm_delay_timer);
 
-	sched_clock_register(tpm_read_sched_clock, 32, rate);
+	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
 
 	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
-				     rate, 200, 32, clocksource_mmio_readl_up);
+				     rate, 200, counter_width,
+				     clocksource_mmio_readl_up);
 }
 
 static int tpm_set_next_event(unsigned long delta,
@@ -153,8 +158,8 @@ static int __init tpm_clockevent_init(unsigned long rate, int irq)
 
 	clockevent_tpm.cpumask = cpumask_of(0);
 	clockevent_tpm.irq = irq;
-	clockevents_config_and_register(&clockevent_tpm,
-					rate, 300, 0xfffffffe);
+	clockevents_config_and_register(&clockevent_tpm, rate, 300,
+					GENMASK(counter_width - 1, 1));
 
 	return ret;
 }
@@ -199,6 +204,8 @@ static int __init tpm_timer_init(struct device_node *np)
 		goto err_per_clk_enable;
 	}
 
+	counter_width = (readl(timer_base + TPM_PARAM) & TPM_PARAM_WIDTH_MASK)
+		>> TPM_PARAM_WIDTH_SHIFT;
 	/*
 	 * Initialize tpm module to a known state
 	 * 1) Counter disabled
@@ -220,7 +227,7 @@ static int __init tpm_timer_init(struct device_node *np)
 		     timer_base + TPM_SC);
 
 	/* set MOD register to maximum for free running mode */
-	writel(0xffffffff, timer_base + TPM_MOD);
+	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
 
 	rate = clk_get_rate(per) >> 3;
 	ret = tpm_clocksource_init(rate);
-- 
2.7.4
