Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC570ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920412098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ia/bx3bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920412098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeJRQwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:52:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43916 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeJRQwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:52:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id 30-v6so14000703plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9kZYDpmsySRWfvSPa6Kfurc5wRQJDTAyv7Jhjoe/kD4=;
        b=ia/bx3bj2+ZiSg36oHYXpcIdN64t31sLLMkBnf4K7Zu5H8yJ8nnU4M2KJ0jHpLTogS
         ZeQqaH8smRzI0al7GLQ8xXfZbCH+5dLlNWlEBEBqCh1mTxqNbJPyAx6FjlQpmUbG22nu
         91w6g+AUsUL8oQG0Qb2UNWq1y1S/RBzTHKCOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9kZYDpmsySRWfvSPa6Kfurc5wRQJDTAyv7Jhjoe/kD4=;
        b=Mg/BPreuLyHshTEf+PhyzDLhV9p/xj6kKLip1/ohsx3x026LEVeK3GpzFTIKbi/vyn
         xXTEtAoWT/1Qmqbxfr2pHptM+35LMhNAYSTD1VWGKiNyXVEKI23/7f2GBjpEJl2WKTzA
         6VRp4xOA2dRpqhmnMGYRAXo6hVRuBLycIn4Fq9Ew5dXfkqzRWZKHTU/Pd565QQpVcu/n
         VXgVlkNeI9pj9KOll+aQQesRrJxDkfvGsnXCGbEl/6Zt+i6FzLkwaykj3Bt7Jcm3JGYW
         WAuM0A18SfCy+8F1ivutkbQaP1ps9Uk3tRrhYrHjSCP6YrXwFyfyvuVscrbdfuDo3l6p
         dLYQ==
X-Gm-Message-State: ABuFfoi2HGaPi8BmYPXQyC4171PDhKUKiGBg7k/jC9zNwti0NLnjKiQ6
        xWNdZ/P13vx4MoKCEAr8UhgLaA==
X-Google-Smtp-Source: ACcGV62FPmqJYXlbyV+KJ+eX7KvQFJMbIBaDS1eRAcVnBHjxHIlwUzRYzJXqxIxQfi2wMKkFJS+6Gg==
X-Received: by 2002:a17:902:4583:: with SMTP id n3-v6mr29427180pld.255.1539852766364;
        Thu, 18 Oct 2018 01:52:46 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x186-v6sm18467528pfb.125.2018.10.18.01.52.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 01:52:45 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/5] rtc: sc27xx: Set wakeup capability before registering rtc device
Date:   Thu, 18 Oct 2018 16:52:26 +0800
Message-Id: <ffd988604d5c0e92ca759f19e76aeaf69a98e059.1539851865.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set wakeup capability before registering rtc device, in case the alarmtimer
can find one available rtc device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index deea5c3..8afba12 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -631,16 +631,18 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	device_init_wakeup(&pdev->dev, 1);
+
 	rtc->rtc->ops = &sprd_rtc_ops;
 	rtc->rtc->range_min = 0;
 	rtc->rtc->range_max = 5662310399LL;
 	ret = rtc_register_device(rtc->rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register rtc device\n");
+		device_init_wakeup(&pdev->dev, 0);
 		return ret;
 	}
 
-	device_init_wakeup(&pdev->dev, 1);
 	return 0;
 }
 
-- 
1.7.9.5

