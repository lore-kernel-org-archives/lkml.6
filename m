Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FDEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA62466A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8zDZyBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAA62466A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964802AbeGDJGf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:06:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44627 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933889AbeGDJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:06:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so3117660ljq.11;
        Wed, 04 Jul 2018 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sp9/OHYzR7gMFUvLxGSGmDbvqa2/KSYEDBrVZv+QrDU=;
        b=I8zDZyBOjzbcBntjcmfM6m1kuYefU/5+LJLE8Vr4lBSr2mu9yg+IFBnfewhL9iNEZI
         xxSj/LN5ju6dh9y4oGKr6kCpI6W8kr3E1EwC81dgWzROBLfQvnYBfRwkU6IPjQlgmgQd
         aUpWjTUhZUbfmRYzlb912ejo4eIc7Y6T9lN+th7tgC4c2xpRuaX3krSNr8vLGoK5QRSs
         nXUnZA70Z4WYe4mdJIXKEdX/p/mMCvmOo45A23xhJFiRix3wI8hpnRhRJY1xs11CMsAh
         XfRm/1grKAk71O+HuAv6r0wqNKh581AL3W1cGDSQoO+xknLhzGXLbDkJBGb3vz2naNfB
         PRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Sp9/OHYzR7gMFUvLxGSGmDbvqa2/KSYEDBrVZv+QrDU=;
        b=K2X0V+hKVk1QNs/Qu+ZXJuDQs2vHwxl6xZAng34nM+BnpKbaBe1VMucClxA6KDcvEL
         zUJKa418H6NCwcGUjmOkq+GvkBTuNsyGF4r5NZeX7L0ysVA0zTOF1tZAgykTceHjNX+O
         m5BetvofiqMpgZE0RX1TE00WodYoTiumO/DePmZ8vvPye/AUaayz0i1DTQlRXHJepYBk
         u56oLSf+FpjTxQhH5/cz82Ibb5uT/zzAynTuATyVQA4decE4nw6NStcxSfrBeFMXwp1N
         gn4Y4DW0MZe73sZxV4NgVGG6RMUWuZtuJSVil4ypbnr1yI6jJ6fJIggaYD6hc8mgzYBC
         T+sA==
X-Gm-Message-State: APt69E1Hb462HCr/9wPQVaQyxS8HX59vBSiXNyyrWd28+Sfyl5SK2QXd
        WxEk2JaW+fowP7xaYuZ0U/o=
X-Google-Smtp-Source: AAOMgpdUoZinmtyUOscMKpOUuAsRJKKjwN7rCVCvfbAs9ZAnG7OIWD1Kxa+SEPgs2Inw6kiShmr4EA==
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr889152lje.70.1530695188822;
        Wed, 04 Jul 2018 02:06:28 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id v14-v6sm498480ljg.66.2018.07.04.02.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 02:06:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fadjv-0004LP-I3; Wed, 04 Jul 2018 11:06:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/4] rtc: omap: fix resource leak in registration error path
Date:   Wed,  4 Jul 2018 11:05:56 +0200
Message-Id: <20180704090558.16647-3-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
References: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to deregister the pin controller in case rtc registration
fails.

Fixes: 57072758623f ("rtc: omap: switch to rtc_register_device")
Cc: stable <stable@vger.kernel.org>     # 4.14
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index c214b69a8787..6a7b804c3074 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -873,7 +873,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	ret = rtc_register_device(rtc->rtc);
 	if (ret)
-		goto err;
+		goto err_deregister_pinctrl;
 
 	rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
 
@@ -886,6 +886,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_deregister_pinctrl:
+	pinctrl_unregister(rtc->pctldev);
 err:
 	clk_disable_unprepare(rtc->clk);
 	device_init_wakeup(&pdev->dev, false);
-- 
2.18.0

