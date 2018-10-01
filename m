Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD45F20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGsvQeaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD45F20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeJAV0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:26:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43796 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbeJAV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:26:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id 80-v6so1694811pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GoaGDmVCYh7aUL4JGbCjR1d/qth1b5/rwWidg7hzq2U=;
        b=nGsvQeaD7HAaUtC0rE0SFLGYiDuFeU/O1yOVB7KWSGubRE8XR2tE6/6wY7Nt0V6j2H
         n039HlfBR+6vOI4bZDYKe/PGFDDRpI2aDRwpcwB5iWI1U2jsxPn5Cu2KwAMHc7yKJBY6
         T+jqPe/z0jVSkieQZCusAVtJivdpqB3NrfqkmC49f8SeMDqcEECL2yKQ4KWlCh/zY+95
         MzQqpmBPnBy97AMTmlg0tj4lb+SCb9UjkgxgHiuLx4Wf5SSs9sBlfjxm+e9OFFDvAwY3
         y+IgvRYj5rzhiKPAAH/0/vlNXxqU9sGK6zDcpDMu6yCzZEG5vqcw++svc2MJQhS6reKT
         FWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GoaGDmVCYh7aUL4JGbCjR1d/qth1b5/rwWidg7hzq2U=;
        b=bB0GzN2jL6nf3vDxguUuNqgg4sd/ScZFCPEJrOGQBqXth6Cs2REbLTkdMPgrEEPlJ/
         pmDKwxSYX00xKFTWrdcFU7F23YX6dgpQnfTWsJVMLy5hYjYoaEkmWRDJPl94bYvR/e2m
         qcOsBXYRxvSCiVGZ7GsmiCGs2qb2n5w4vjlanIsL3WW+kpC0e4yO9MF0pNFjorZyeIPX
         t013Ht9SJCeMJSKCb4+jgqNThaC/UFVoRN2dX6uJSiPqo8d+MkaWH0vh5bmRouqm2AaA
         Qs3xVVJL8tiCzS6Er1qV0z9hiLhj0VHMWHfLcK1Hgw4kM7c4yjIvgya2Gwy1a7zys+ay
         DfHQ==
X-Gm-Message-State: ABuFfojuiMgF2nwUVnuJkHjvSotr8pvUmdkGlHBDGZopGCrp2xCRYB1n
        o292ITyzMglfksD68GwwzdE=
X-Google-Smtp-Source: ACcGV60zlAGS1dUy6PrwrLukWJXWPP+K+Cj899lOohZ9r7WBLD9w6r2uwfxoJONGQZ71dN0W/ptoPQ==
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr12206837pld.312.1538405317427;
        Mon, 01 Oct 2018 07:48:37 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id r65-v6sm9895873pfj.5.2018.10.01.07.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 07:48:37 -0700 (PDT)
Date:   Mon, 1 Oct 2018 20:18:31 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 3/3] staging: mt7621-mmc: Remove unused single statement
 macros
Message-ID: <07e676200054d1c63d2f7ea76330f0a2d78f5396.1538402548.git.nishadkamdar@gmail.com>
References: <cover.1538402548.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538402548.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unused single statement macros in sd.c

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 29e75804db67..d42765c54155 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -151,32 +151,6 @@ static u32 hclks[] = {48000000}; /* +/- by chhung */
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
 
@@ -1469,7 +1443,6 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 		 * shouldn't be turned off. Here adds a reference count to keep
 		 * the core power alive.
 		 */
-		//msdc_vcore_on(host); //did in msdc_init_hw()
 
 		if (hw->config_gpio_pin) /* NULL */
 			hw->config_gpio_pin(MSDC_CD_PIN, GPIO_PULL_UP);
@@ -1492,7 +1465,6 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 		/* Here decreases a reference count to core power since card
 		 * detection circuit is shutdown.
 		 */
-		//msdc_vcore_off(host);
 	}
 }
 
-- 
2.17.1

