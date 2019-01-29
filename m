Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D536C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C15920870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYN0oAEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfA2Ahl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:37:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46095 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfA2Ahk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:37:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so8786669pfe.13;
        Mon, 28 Jan 2019 16:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Q0DGhxaczt609U70/kPzWdo/a0NW1iHZiBbzvJaHoVg=;
        b=hYN0oAEKnvT4L1gEod8u+6JSMVATyUTQ5I5QZGCnAQIu5/wnDVvQ6QyRw5bJhkuwqk
         YDOvT5rBeIsCguuA98Ys8LyzT0FAACaf503tWdkqRI3pp6Cp9AFNTmOluoHZ1MvLCqBg
         c4XZ+pLoKXr3JHEKLHXW5S8AsLr47StUNNJJYrn+izj7xgdqMDNwa7rFSM3TerK09pCg
         xbbNZK5OXnGZDy5E25i5debfqQ9gOEi9Uh7OjZJiHCkmw4byGvk02mDgs5aOYU2o8MjA
         Zyf189iRp19Y/T9U+VjTsuvo0ek+AfFJLGEWTg8ZXNVl48L+Oey9NQM/b6bq/nLH5HcP
         CQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q0DGhxaczt609U70/kPzWdo/a0NW1iHZiBbzvJaHoVg=;
        b=ISm/v+9+b5KOhCjSLl16ZWHXUGhLAchr3Y+PQoxAMv1ZoZDnAZyKIDNmUitqUms1Qa
         bmHtH42VIaM9nUHPKaSw/jmQNnJH3kOEWoBI5EyByiGkPLR9QGJw6uenG4o4w1opPaIU
         eQ9IIlxSgHEa6Ux3xJad/vVrqaEadYi8rE4eykP9unrt4nKKFxbHpTNsPVea0Mout5u+
         NG4caK45C+/BR0KKj+3OA+fgOy+tf7XiLFQS6Un94XqjpcCzdTwEdqKNCjiVTDBuQua7
         L5xw3r+7agIy35obKPx2m1JYjBTg0mZcaA6rF0AkWmIYrkK6cpB6nHn+nvYC0OT9mVUG
         Le6Q==
X-Gm-Message-State: AJcUukeP8QZ0uFxauBN6GGwjktIv2SpaV0jtFSAER++anS0H6tfWpoDd
        mFeAPL5OJc8CW4qqyxs7+IaDRfYW
X-Google-Smtp-Source: ALg8bN7PRUB14bvrOIiJXvjofbO/Xud3TmQG0Hq6uOgRuFoINNRr0mR4b2DXpXgFr4hkD/egmoLUFQ==
X-Received: by 2002:a63:d252:: with SMTP id t18mr21952445pgi.133.1548722259488;
        Mon, 28 Jan 2019 16:37:39 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l74sm53812663pfb.145.2019.01.28.16.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 16:37:38 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:37:37 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: sx8654 - do not override interrupt trigger
Message-ID: <20190129003737.GA80949@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should rely on the interrupt trigger (level vs edge) set up by the
firmware or board code instead of forcing what we consider appropriate.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sx8654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 1cc0e4116d3b..b792320d628e 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -403,7 +403,7 @@ static int sx8654_probe(struct i2c_client *client,
 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, sx8654->data->irqh,
-					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  IRQF_ONESHOT,
 					  client->name, sx8654);
 	if (error) {
 		dev_err(&client->dev,
-- 
2.20.1.495.gaa96b0ce6b-goog


-- 
Dmitry
