Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F049FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33062171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lPczBkvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeLZCyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:54:35 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:42780 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeLZCyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:54:35 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id AE65EBC9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Xvy4Oy4KWXz for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:54:33 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 807BEBCE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:54:33 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id 135so18622551itk.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Hi1WaWFF9Q9te4wz4HnCZv6G1koFXgSyMoUWP6/BZHI=;
        b=lPczBkvzZxTNOh8YfUDZWfoGmFi8WBuyPcbo87rzY7nU7lvTkvrymqY2LJdkv4E5OV
         87egBKy7Xs+F1RKUnCywaj1Ft7yIHEsP1wE59I44dTKl78A8YtoS398aHsiFVGMQWKE5
         IIGe1Hh7/COTrrz7NPFG/6ZwOExKT6oQMlVIwIi+escWUul12IAvWKJPVdCz7mbxwbFV
         d1clGSE5t8NyvlB4aTE+ASDEpg7ns7zkGAWH6ygOmvEUQ/zJgAL0BWRqqWojlRuxPGGs
         OqZCxnkNq2CNd07OjGKHPu+BjQkg2sRjVXYTEKqDSaolTXuDZazlD8BrcnZLHl2JDIZ7
         Isaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hi1WaWFF9Q9te4wz4HnCZv6G1koFXgSyMoUWP6/BZHI=;
        b=n8z4ZsCTBB6e9PGgI9UB+zl0KG/u0l03Tf9w33Xs9tE4AvoX2ZHIg05j1haUG7TySO
         r/W2Sjw2Cs7TyOJ88DeV2/pQUHu5JCLgpFncCbeqToYGt5MVk9Jsrugtqb7sEYy7WFAW
         Z3JBLSIn2EnqIFErKZ9ljlr6iskIJIzdaCQcypTQmvayKGuPnPsd6LwMB7y34G9lqwaq
         1kBOY8FzuHD/QgiwO1MXe8tphWGvyyLHP8qsb886DroCY2mFYMHpcN9Ujmf8qmpf1FIE
         uWepUqbI6YUxbSC0gFk8PzinT5KCnKy2wxRancBvAWW3Gkabi7tAOSXTC+7d2lCbJ4F8
         Dikw==
X-Gm-Message-State: AA+aEWZELKM4e4aw4oKanTrm4Ne4ZBYSCXiM67jlB5jUMcXVs6YVtbaX
        5QzAvkKS7qyUmkjFzDZl5AlCVkkWbmQNMSlvjLZAVy0LmYaQd5i0iGq41dNbXRxYBAYVvu8lcXK
        Z5ymA7S+0rZeLaeykdGpC5Ys4x2AB
X-Received: by 2002:a24:1fc7:: with SMTP id d190mr11074925itd.126.1545792872690;
        Tue, 25 Dec 2018 18:54:32 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VG4BDwEHGMkGYlMA0z8SX+L4UK20udAbjIt5b5fe1zIoYJ2ZbB5K/zP5FQMUhgrk/yB8R8Sg==
X-Received: by 2002:a24:1fc7:: with SMTP id d190mr11074908itd.126.1545792872479;
        Tue, 25 Dec 2018 18:54:32 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 125sm14397722itk.28.2018.12.25.18.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:54:31 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] atmel: fix a missing check of clk_prepare
Date:   Tue, 25 Dec 2018 20:54:05 -0600
Message-Id: <20181226025405.72480-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_prepare() could fail, so let's check its status, and if it fails,
issue an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/misc/atmel-ssc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index d8e3cc2dc747..9e69d0585f49 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -60,7 +60,8 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 	ssc->user++;
 	spin_unlock(&user_lock);
 
-	clk_prepare(ssc->clk);
+	if (clk_prepare(ssc->clk))
+		pr_err("ssc: failed to prepare clk.\n");
 
 	return ssc;
 }
-- 
2.17.2 (Apple Git-113)

