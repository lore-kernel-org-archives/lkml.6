Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC1C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A2520833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpgShnnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A2520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeILWf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:35:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39874 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeILWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:35:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id i190-v6so1406520pgc.6;
        Wed, 12 Sep 2018 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Az0caEh+bwgshqAM5OQDThQRfUn6aoekzTL94w+i5F0=;
        b=WpgShnnIJrxcK+8QV/x0EsXhibZkIa88XalMqUT+biJSYEpXJjhR93VB4+kB5dIQ5E
         Cy7gXFOL9gwbASfWG/eyi8Me9S78n4b7aYOUZgYLz8jIq7cEYw+F31bl6Zcdoldw9auk
         +xwBKZLFQRN4qZIt/WH7u0/PzscuSm0ZQEJsqHTo5CpPeis+1S7Tl6pEBKkVNel3lQqe
         pFNfKHBy0wiqSY4+RHEHc7eLUGw1GKiuW9/z4sh2ufJGTvh/5gS0qDNW7YmBaNYkebc2
         tJh/fJgvNmZUHO/Skg6HZ/iMsQb2C1n+tW8lhs4D6Ge3cZ+zH1+GR6aUxpBgCs5RQ/in
         ARmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Az0caEh+bwgshqAM5OQDThQRfUn6aoekzTL94w+i5F0=;
        b=S1SSzssc3z2fOx1q3C2hfCRok0Y1SFxzkMMr1TmObimUmmXG6E9aVuy9N8Jqe2Hz+3
         rd6u1iFsX3PSD0HzuuyC5nYTAZLd4Sdng46TK6o/dARWBYTiKWdEZrvdLitRBm5ICcT/
         K3SmSIaX5t1MA+JwUBMutA6xoM6drCN3mBZ/k65m5Q1B9cu5KjFiUqx5z7Ow8jPb5plC
         Rg+/l1ynli6q5K9Ena47bVI9CUrG3VgYvTnft5LIPe4GpHleVJ68kKEKqDHEmGJlch9O
         +ka1auvAc4qOjslZHEQ+Zm/o+YylOQAdfAG+MvR/QFlJPdZJeBOYFnMr0dkUMqKT59Zh
         TZ0w==
X-Gm-Message-State: APzg51Ci26ycjGI1XogpnNt8e4SgRYdnN1ufaIvUX/YTy4iIq/Clp20x
        qrm/4dMW9VSFA2G4OeUeRGs=
X-Google-Smtp-Source: ANB0VdZmm5nLmUKvzsczguK7/fLWNhChGSjA9J/UiR9CeMghilsQa4cQPkHlvHBnIQnc/Yx6mZ7mRQ==
X-Received: by 2002:a63:f002:: with SMTP id k2-v6mr3458614pgh.8.1536773394109;
        Wed, 12 Sep 2018 10:29:54 -0700 (PDT)
Received: from localhost.localdomain ([103.224.155.47])
        by smtp.googlemail.com with ESMTPSA id t12-v6sm2322054pgg.72.2018.09.12.10.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 10:29:53 -0700 (PDT)
From:   Jagdish Tirumala <t.jag587@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        yamada.masahiro@socionext.com
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: diag288_wdt: pointer location foo * bar should be foo *bar
Date:   Wed, 12 Sep 2018 10:29:07 -0700
Message-Id: <20180912172907.1802-1-t.jag587@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: pointer location foo * bar should be foo *bar
FILE: drivers/watchdog/diag288_wdt.c:202

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/watchdog/diag288_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 806a04a676b7..046333d1beb2 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -199,7 +199,7 @@ static int wdt_ping(struct watchdog_device *dev)
 	return ret;
 }
 
-static int wdt_set_timeout(struct watchdog_device * dev, unsigned int new_to)
+static int wdt_set_timeout(struct watchdog_device *dev, unsigned int new_to)
 {
 	dev->timeout = new_to;
 	return wdt_ping(dev);
-- 
2.17.1

