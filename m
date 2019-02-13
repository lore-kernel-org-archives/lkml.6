Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC08C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC141222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXSp1c4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbfBMNR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:17:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43508 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfBMNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:17:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id r2so2422279wrv.10;
        Wed, 13 Feb 2019 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kOiiFrA5j18jRpqBTDSiiLI1IM+ozLJzbXOSghDje+c=;
        b=oXSp1c4tKFCLPyDGrQcBh0Tg5/irFTUdK+wiZaJyM77FfK4sFCDI+ssXMJdWcMgJAX
         xrnWJ/4rufx2ry+tXUAgNwjUHl1aeOmwIIYNQPRfeWNEcJsQTB/wd6FBe/VkMCISMgun
         sqGYNAMLJLgxEWIyKY42cRJMF8p4OugR7rTfo8vIjmrhQ7VKdYM9bYBNTFiZOUrjTzKI
         OsNY2Rr0YQdBLbKrdsRLLUMx8oWM9MPhKK+XPi8VxbDm/s+dMbyC8YEGr5bLGG778Mcc
         l+wj7KqfzaWGpEag7pizScR99rxQfi1lHNWjZQRimjqCV/w3m0Xx/HJIQl5Omdv3/MLd
         riaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kOiiFrA5j18jRpqBTDSiiLI1IM+ozLJzbXOSghDje+c=;
        b=DXWcV6PmZjkDN8hhdy6gRHVqcRMuxgN46itNfykoFrzTPL46usuv5UQ1MUAxHi1B9K
         sADZeDoa5WRzkCkhZKJuYMZq+K9UjhEhfTySuTkzjIyrKRFQmkHPGfb7PXXm4sGJDIHg
         AEYVaKVwzAL3RskCx1cxCIP5gjuTGiMNSiOJsrWF5gJJVEU1nBYYXVbaoQs7i8d5u4Ou
         6MwB3/vaAx4KOWRUONbBaK8b7RCH6hKDOCyCdvMf4Ky9c2Xn1lcDPC/7tL36e3PJNGGS
         yvp/QkbnS4KALFzldy97lrReAGfpvBXd3JtLefho/8fY0FBPCKyKQuKuuJfR45RUkEZV
         qHqQ==
X-Gm-Message-State: AHQUAuaw5q9QOKm6uUxwJM8DjUCcnBGK4wbw5HDQOtF1gCuPGNQ3m0Dk
        4Tf7AsQy3f+roIE/c8xlj9w=
X-Google-Smtp-Source: AHgI3IZqiIYEf/8NIVYRZQpj6flv2zDOh4RinEmYMMHQapYFG8l9aVT2f2Bs/nzWOX9um1ZuP2HnWA==
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr382460wrw.245.1550063876817;
        Wed, 13 Feb 2019 05:17:56 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id y24sm12765937wma.0.2019.02.13.05.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:17:56 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH] iio: trigger: Print an error if there is no available irq
Date:   Wed, 13 Feb 2019 14:17:52 +0100
Message-Id: <20190213131752.646-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are more trigger consumers than
CONFIG_IIO_CONSUMERS_PER_TRIGGER, iio_trigger_attach_poll_func will
silently fail. Add an error message to inform the user that
CONFIG_IIO_CONSUMERS_PER_TRIGGER limit might be exceeded.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ce66699c7fcc..801986c21467 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -254,8 +254,12 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 
 	/* Get irq number */
 	pf->irq = iio_trigger_get_irq(trig);
-	if (pf->irq < 0)
+	if (pf->irq < 0) {
+		pr_err("Could not find an available irq for trigger %s, "
+			"CONFIG_IIO_CONSUMERS_PER_TRIGGER limit "
+			"might be exceeded\n", trig->name);
 		goto out_put_module;
+	}
 
 	/* Request irq */
 	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
-- 
2.17.1

