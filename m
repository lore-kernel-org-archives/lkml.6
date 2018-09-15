Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5030ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738E02086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3ZRCnuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738E02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIOSg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:36:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43743 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeIOSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:36:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so5629466pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yM0LivsYZLSLtnGOvLUn499gfGYDXlR38CBUVaDn0ko=;
        b=Z3ZRCnuzzN8Fa8HkY8aZqye7AlY3Uwtzq96WoXePG8GK51clbmbVMAbR/9cpdzfq47
         DT+97SOtAEdx+vCREvrSFv2PlJZ+Q358sdDdWq2maqEP2BQyuVO4wkfAqMMX3yBMvjMZ
         NPqddgClU5+XLz3w/0H/pquEEI0kEtuDc/qNe3bRh+BDfCiaCbJWVPjQHuBuSwoFRn+n
         7iJyfC1PX5zamc6k+ZijRO08dul0eIQiWddG00gGsoDPJKGyQnkDq6UOhzBjDNweUxZB
         iYI1rfevoQ+j9MlceadnC/0T6y7Z34MjJBGl0JXE8cUTfLmaBJVnKP3Rx+NI0Jc/uBkx
         AZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yM0LivsYZLSLtnGOvLUn499gfGYDXlR38CBUVaDn0ko=;
        b=owatqVcqaHzyDpIPt3TEylNlSx6/aA3N7APkFkKX73mmbruqJnyWGy6FC1KudGs4JO
         bImyvyw8zbjSgbRaFVxNwp3XItdVWnzqBL8fgXPHsj7ra5KPGPDQ2yQVk8tfKujSvHBl
         6X+qhV7QtUZJk5nyjl8wU3noyMJEo1hCTyJISY58SdmOEAZlxz0uYO04Zzs1oqpjaCyB
         r3Gvlp520SZPJaq+0SumA1V0F8RSQKfqYwn7W8ytLcDzMarR0aOh24RkkPjV4ctZxjn5
         M/rChcAdPfWSChuo5YVGgwRRd9goFGOVRKDNBIX4fZFS4ALdM7DYsoqxr1LiuPBH/oBW
         FQRA==
X-Gm-Message-State: APzg51Bsu2XK8o9ePQ2xqQEdmXMWRssgLmO2454IIUeVYYn7lnDh+Z20
        IqrJaLGxJw/EszXgiHvA9u4=
X-Google-Smtp-Source: ANB0VdbCLRQ0/4mMbIAKUzedT70uf3mkJLLsh2z6arH9YEXMfMi6sPKJbFuwPBrl2Pam0uKeW7cb1g==
X-Received: by 2002:a63:1f55:: with SMTP id q21-v6mr15844084pgm.88.1537017478974;
        Sat, 15 Sep 2018 06:17:58 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id u184-v6sm22382353pgd.46.2018.09.15.06.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 06:17:58 -0700 (PDT)
Date:   Sat, 15 Sep 2018 18:47:51 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: mt7621-mmc: Remove do {} while (0) loop for single
 statement macro
Message-ID: <20180915131748.GA19661@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes do {} while (0) loop for single statement macros.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 7474f9ed7b5b..ec12a3a5a926 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -104,14 +104,10 @@ static int cd_active_low = 1;
 /* gate means clock power down */
 static int g_clk_gate = 0;
 #define msdc_gate_clock(id) \
-	do {					       \
-		g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN));	\
-	} while (0)
+	(g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN)))
 /* not like power down register. 1 means clock on. */
 #define msdc_ungate_clock(id) \
-	do {					    \
-		g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN);	\
-	} while (0)
+	(g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN))
 
 // do we need sync object or not
 void msdc_clk_status(int *status)
@@ -170,9 +166,7 @@ static void msdc_clr_fifo(struct msdc_host *host)
 	} while (0)
 
 #define msdc_irq_restore(val) \
-	do {					\
-		sdr_set_bits(host->base + MSDC_INTEN, val);	\
-	} while (0)
+	(sdr_set_bits(host->base + MSDC_INTEN, val))
 
 /* clock source for host: global */
 #if defined(CONFIG_SOC_MT7620)
@@ -186,26 +180,18 @@ static u32 hclks[] = {50000000}; /* +/- by chhung */
 //    always keep the VMC on.
 //============================================
 #define msdc_vcore_on(host) \
-	do {								\
-		(void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD");	\
-	} while (0)
+	((void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD"))
 #define msdc_vcore_off(host) \
-	do {								\
-		(void)hwPowerDown(MT65XX_POWER_LDO_VMC, "SD");		\
-	} while (0)
+	((void)hwPowerDown(MT65XX_POWER_LDO_VMC, "SD"))
 
 //====================================
 // the vdd output for card: global
 //   always keep the VMCH on.
 //====================================
 #define msdc_vdd_on(host) \
-	do {								\
-		(void)hwPowerOn(MT65XX_POWER_LDO_VMCH, VOL_3300, "SD"); \
-	} while (0)
+	((void)hwPowerOn(MT65XX_POWER_LDO_VMCH, VOL_3300, "SD"))
 #define msdc_vdd_off(host) \
-	do {							\
-		(void)hwPowerDown(MT65XX_POWER_LDO_VMCH, "SD"); \
-	} while (0)
+	((void)hwPowerDown(MT65XX_POWER_LDO_VMCH, "SD"))
 
 #define sdc_is_busy()          (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
 #define sdc_is_cmd_busy()      (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
-- 
2.17.1

