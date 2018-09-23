Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18FCECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C997214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMdfo+2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C997214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeIWPfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:35:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33202 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIWPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:35:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id b97-v6so7853526plb.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VbLzPlQjsWA4JCTT3aiFe3CNV1WKKq2GIgPBsKYer3c=;
        b=HMdfo+2kwxZkKczSt4AUAEuNUtB5maadoxYdcYGmkXi3TgHgfGwvrwm1j9/+LTGN0C
         4CPnl2VZnHw10yUF/fVd/ZHDyS1M01lCEav7rPad7fAfluRRyHuPHuZ01vLMfUkUfd2a
         rqG+MikCaaR/SyWNdM64oXe4v9cI7tN1jS6lYEiKKSbwsO3jUQkjqCdgK/Fo4FsPx4o6
         b/uS0HiowfqyujxUsFO1xNEq+GpCxsMnImtuhWw887grs+Us22zDMlptIYzEYk4iIC6C
         8G22Te06DuHy0ipVECCeS7NhT7mvBAFdps51h/jiIskVEar1UgDOdmjiaSHQ9JyuTF1o
         wEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VbLzPlQjsWA4JCTT3aiFe3CNV1WKKq2GIgPBsKYer3c=;
        b=lA83zMNs1id1dl3cQAUWm3gWJcp2CEHzkQwxbio687oC55i8Edfc1vp07B1sDwpTyC
         1cKPPu6KX1HC//LfmM3puwHBZvBDAAQA3BtvO8xbcDiFwctMo9Ez8A9KGtcbzreJyh2s
         7oIusbTesRvizICKbQXuV4PsnxmU6HAU5h8jDZStraYQe/BJA/FoPn345tkV7PTX1AKQ
         zDK0pQuzPm8lwuk/TYFQOQgy3xhytcHpRV4Y6AKPYUVIlHTbSSS36ZJnicsRMJbDGuGz
         CEe01Mgjpv/cWVOvTnG3qF2WUb45C14QbjzquuNf6JQFgaKQgs8LOK3e3FR6vNv6cQJd
         2HqQ==
X-Gm-Message-State: ABuFfoiKeepTF3a+E/1jeIFhSxtrP8JQV81Hb1S8T2FnC73wOV7FLWIa
        CTvsqWQPzyfpCyDTbYFKrH8=
X-Google-Smtp-Source: ACcGV62U7+Gg2f43T5S8okwKVZXHb0VbmEImqKzgioDQ/QLfzW0BO166jtBq3C9O+p/5clX9Mef8TA==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr5803177pla.325.1537695495333;
        Sun, 23 Sep 2018 02:38:15 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id u25-v6sm44168618pfk.177.2018.09.23.02.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 02:38:14 -0700 (PDT)
Date:   Sun, 23 Sep 2018 15:08:08 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: mt7621-mmc: Fix single statement macros in sd.c
Message-ID: <20180923093805.GA20870@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a few single statement macros in sd.c.
It converts two macros to inline functions. It removes
five other macros and replaces their usages with calls to
the function being called in the macro definition.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v2:
  - Convert msdc_gate_clk() and msdc_ungate_clk() to inline functions.
  - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
    msdc_vdd_on() and msdc_vdd_off() and replace their usages directly
    with calls to the function being called by these macros.
---
 drivers/staging/mt7621-mmc/sd.c | 61 +++++++--------------------------
 1 file changed, 13 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 7474f9ed7b5b..c36884e33a50 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -103,15 +103,15 @@ static int cd_active_low = 1;
 #if 0 /* --- by chhung */
 /* gate means clock power down */
 static int g_clk_gate = 0;
-#define msdc_gate_clock(id) \
-	do {					       \
-		g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN));	\
-	} while (0)
+static inline void msdc_gate_clock(int id)
+{
+	g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN));
+}
 /* not like power down register. 1 means clock on. */
-#define msdc_ungate_clock(id) \
-	do {					    \
-		g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN);	\
-	} while (0)
+static inline void msdc_ungate_clock(int id)
+{
+	g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN);
+}
 
 // do we need sync object or not
 void msdc_clk_status(int *status)
@@ -169,11 +169,6 @@ static void msdc_clr_fifo(struct msdc_host *host)
 		sdr_clr_bits(host->base + MSDC_INTEN, val);	\
 	} while (0)
 
-#define msdc_irq_restore(val) \
-	do {					\
-		sdr_set_bits(host->base + MSDC_INTEN, val);	\
-	} while (0)
-
 /* clock source for host: global */
 #if defined(CONFIG_SOC_MT7620)
 static u32 hclks[] = {48000000}; /* +/- by chhung */
@@ -181,32 +176,6 @@ static u32 hclks[] = {48000000}; /* +/- by chhung */
 static u32 hclks[] = {50000000}; /* +/- by chhung */
 #endif
 
-//============================================
-// the power for msdc host controller: global
-//    always keep the VMC on.
-//============================================
-#define msdc_vcore_on(host) \
-	do {								\
-		(void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD");	\
-	} while (0)
-#define msdc_vcore_off(host) \
-	do {								\
-		(void)hwPowerDown(MT65XX_POWER_LDO_VMC, "SD");		\
-	} while (0)
-
-//====================================
-// the vdd output for card: global
-//   always keep the VMCH on.
-//====================================
-#define msdc_vdd_on(host) \
-	do {								\
-		(void)hwPowerOn(MT65XX_POWER_LDO_VMCH, VOL_3300, "SD"); \
-	} while (0)
-#define msdc_vdd_off(host) \
-	do {							\
-		(void)hwPowerDown(MT65XX_POWER_LDO_VMCH, "SD"); \
-	} while (0)
-
 #define sdc_is_busy()          (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
 #define sdc_is_cmd_busy()      (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
 
@@ -364,7 +333,7 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	host->mclk = hz;
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks); // need?
 
-	msdc_irq_restore(flags);
+	sdr_set_bits(host->base + MSDC_INTEN, flags);
 }
 
 /* Fix me. when need to abort */
@@ -453,11 +422,11 @@ void msdc_pin_reset(struct msdc_host *host, int mode)
 static void msdc_core_power(struct msdc_host *host, int on)
 {
 	if (on && host->core_power == 0) {
-		msdc_vcore_on(host);
+		(void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD");
 		host->core_power = 1;
 		msleep(1);
 	} else if (!on && host->core_power == 1) {
-		msdc_vcore_off(host);
+		(void)hwPowerDown(MT65XX_POWER_LDO_VMC, "SD");
 		host->core_power = 0;
 		msleep(1);
 	}
@@ -478,10 +447,8 @@ static void msdc_card_power(struct msdc_host *host, int on)
 {
 	if (on) {
 		msdc_pin_config(host, MSDC_PIN_PULL_UP);
-		//msdc_vdd_on(host);  // need todo card detection.
 		msleep(1);
 	} else {
-		//msdc_vdd_off(host);
 		msdc_pin_config(host, MSDC_PIN_PULL_DOWN);
 		msleep(1);
 	}
@@ -1750,7 +1717,6 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 		 * shouldn't be turned off. Here adds a reference count to keep
 		 * the core power alive.
 		 */
-		//msdc_vcore_on(host); //did in msdc_init_hw()
 
 		if (hw->config_gpio_pin) /* NULL */
 			hw->config_gpio_pin(MSDC_CD_PIN, GPIO_PULL_UP);
@@ -1773,7 +1739,6 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 		/* Here decreases a reference count to core power since card
 		 * detection circuit is shutdown.
 		 */
-		//msdc_vcore_off(host);
 	}
 }
 
@@ -1783,11 +1748,11 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	/* Power on */
 #if 0 /* --- by chhung */
-	msdc_vcore_on(host);
+	(void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD");
 	msdc_pin_reset(host, MSDC_PIN_PULL_UP);
 	msdc_select_clksrc(host, hw->clk_src);
 	enable_clock(PERI_MSDC0_PDN + host->id, "SD");
-	msdc_vdd_on(host);
+	(void)hwPowerOn(MT65XX_POWER_LDO_VMCH, VOL_3300, "SD");
 #endif /* end of --- */
 	/* Configure to MMC/SD mode */
 	sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_MODE, MSDC_SDMMC);
-- 
2.17.1

