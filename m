Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A735C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA01024207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPeLryOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA01024207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934523AbeGDJGd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:06:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41094 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932835AbeGDJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:06:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id a17-v6so3717259ljd.8;
        Wed, 04 Jul 2018 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zL+w8jnXxeqMShYHqxk6vuzkjVixFp3e8TW9Stxhqs=;
        b=QPeLryOK4yZ1WoJVVynIBPN1SVE3rel7pf+iQ2532J9QfzeBSREsIYSOBotCsy9t0m
         ABvWRJnyec8xmhmxt/2X0ftEIXzJ6o2aDoI7kMVrYGNBagpdnOYWpznd5T7SZ27nMllh
         gF2/hgcqOCiFM18RUBMtI3VwR4UpZkokL/AN7D8OSdGc1SkWX6e8I/wHpuNsW9765+j6
         Do6Jbizklw4efZZxjVLBfVlwhwcHnvgRhTYMftC57UgRXLiWpIAtxBF35RySdHX/ysJt
         ybfAOVr3lsfVT4GJPZfn9kpXXphayVrWFJs+bjpMbVACINXIzoefsxeBBfNxAB2hquff
         OJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+zL+w8jnXxeqMShYHqxk6vuzkjVixFp3e8TW9Stxhqs=;
        b=JoBMvH9TGzfoAqbvYyRa0g9yrWOkDmTCvMlbmeVJbZPMG3yjWwEKv6otAw0Nf+ebD/
         9C8jSdI03LfmNzEIHxVGi8bTsZ68Ixg0f52bik5XVB+ffzAydb6uMAFq6TEloubUrTUw
         wQt1eXRKKkRihodXFbcsF0DQW0eWnfDqiwEPqLZxzLInzMfKpTA5TyfE4yTpVFdXcm68
         9OWqi2chngEOJ2G+i7ow/Ic/5DX/CRS7NrZQABhRVLXZAfz1+PxWXx4QSNFXCKCpA022
         T5hAMPDGVd6blK3tfhe7xOBa2xJA9q5MEiWfe2kZmmOT3J1uyAJCRSy9Cmc+8izSQixd
         8jiA==
X-Gm-Message-State: APt69E1H4szRaMOdnAXVUfQRWknP5go371k+ng1ajHlvWjHEoikLLKoh
        F7lNNfl0tMoNlyossBrSOJQ=
X-Google-Smtp-Source: AAOMgpc8zlORnq4H7uheYGC8++y/ZfUzQKZ9HvPJQU1DJwsu0a2sHML9EPPbM3LMPr1i9yGejBgAww==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr972049ljk.133.1530695188237;
        Wed, 04 Jul 2018 02:06:28 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id k10-v6sm509636ljh.5.2018.07.04.02.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 02:06:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fadjv-0004LK-Ev; Wed, 04 Jul 2018 11:06:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] rtc: omap: fix potential crash on power off
Date:   Wed,  4 Jul 2018 11:05:55 +0200
Message-Id: <20180704090558.16647-2-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
References: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not set the system power-off callback and omap power-off rtc pointer
until we're done setting up our device to avoid leaving stale pointers
around after a late probe error.

Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
Cc: stable <stable@vger.kernel.org>     # 4.9
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 39086398833e..c214b69a8787 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -861,13 +861,6 @@ static int omap_rtc_probe(struct platform_device *pdev)
 			goto err;
 	}
 
-	if (rtc->is_pmic_controller) {
-		if (!pm_power_off) {
-			omap_rtc_power_off_rtc = rtc;
-			pm_power_off = omap_rtc_power_off;
-		}
-	}
-
 	/* Support ext_wakeup pinconf */
 	rtc_pinctrl_desc.name = dev_name(&pdev->dev);
 
@@ -884,6 +877,13 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
 
+	if (rtc->is_pmic_controller) {
+		if (!pm_power_off) {
+			omap_rtc_power_off_rtc = rtc;
+			pm_power_off = omap_rtc_power_off;
+		}
+	}
+
 	return 0;
 
 err:
-- 
2.18.0

