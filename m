Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD90C07520
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4011B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Mafaqh8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeLYEgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 23:36:46 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60524 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbeLYEgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 23:36:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 0B9D1C2F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 04:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rpOiMzXOkLHC for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 22:36:43 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id D4FC67B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 22:36:43 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id l10so2817111iok.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 20:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MOuqoXvDQR6WaOPGYewfFnRK6hqDn95BYOfHQWaJgjA=;
        b=Mafaqh8rSfeMEvhmZ/IyTFBmtjLSOWs9fSla/mTQlhJsjkCbCXFHXu0FM1u66PvTyq
         yXkh8OspUzkFn9/te1r91ZOq27oFBuEcKOM+ieMUFqKt3z6Fzc2Y8q+QjdcjD9jsxZ32
         H0RVccsosCevxPYeGplyxcDSPgfEFFfbZFBlBagxvcJUsAwoyDmylsc9/F7qmQwP0/cI
         372F4TtcdpUJlCCBznJOZVWyuSTChWcbvzKwZSsNq9eTo2assBcK+5UxpTHDnsyzj1IT
         K0TkqgNwxTbj36cGFp045OiG79/n5hOqbL5ec71dV9RSAVI4Qsedk0AWrM+vXG8BtR8C
         FZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MOuqoXvDQR6WaOPGYewfFnRK6hqDn95BYOfHQWaJgjA=;
        b=psAvLLq2V412eLTH0sOMW7W2Jd+Nc+G+D75nV94cAXSd70ECP8XpFAH2mor129oVDP
         fQ6gKVHwdI8WA2joUr2zLjrPrzerqdNk6jFeLGdWmxFtFD4reFBPZRnidEhq1Y+RpNcN
         mASjGWb3rcJfFaCCGAOtdjWXO7PSZnqGeLDPOcexWTDgS3a+IeSLhXX16LpV8d0l6gyl
         DTyyQsGyVIvozlHUN0wHb9qzoVlMc2+U+jtceKNPWzBmIpL+7uRRd9POwYOzwyM5xrmT
         xNMaKSETSLeQWCP02mLjBI3zgS0G+PTZyBBAg4ewvkZCsr+4/uVhAhpZ+awZ5XvxuwSV
         YAsg==
X-Gm-Message-State: AA+aEWY+PvD6jetEaPqLHTaaXeYQdgNjlZSogsFYHQtOVmWoTDlMFbmd
        t1yb7v0dlZRQ62ObHVt1y8dM/5qYunPcxskwAAcX40YmA+YHWBSYqAhYpJtpBEILMEpcC/2KsY5
        T76ItPOfrfCzsTIc9r/HPxyTHR2BG
X-Received: by 2002:a24:9144:: with SMTP id i65mr10706095ite.115.1545712603142;
        Mon, 24 Dec 2018 20:36:43 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5ot7t3KNA2d43rlVfJCBsoawY68ASyDlAkmtWczhvWi8utQx8ZiYXJshYcx9UpiNmWZmlu+Q==
X-Received: by 2002:a24:9144:: with SMTP id i65mr10706086ite.115.1545712602820;
        Mon, 24 Dec 2018 20:36:42 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id d9sm5349192iom.72.2018.12.24.20.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 20:36:41 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] touchscreen: elants: fix a missing check of return values
Date:   Mon, 24 Dec 2018 22:36:13 -0600
Message-Id: <20181225043616.66032-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elants_i2c_send() may fail, let's check its return values. The fix does
the check and reports an error message upon the failure.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/input/touchscreen/elants_i2c.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index f2cb23121833..8ccba4ccee37 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -245,8 +245,22 @@ static int elants_i2c_calibrate(struct elants_data *ts)
 	ts->state = ELAN_WAIT_RECALIBRATION;
 	reinit_completion(&ts->cmd_done);
 
-	elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
-	elants_i2c_send(client, rek, sizeof(rek));
+	error = elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
+	if (error) {
+		dev_err(&client->dev,
+				"error in sending the w_flashkey command for calibration: %d\n",
+				error);
+		enable_irq(client->irq);
+		return error;
+	}
+  error = elants_i2c_send(client, rek, sizeof(rek));
+	if (error) {
+		dev_err(&client->dev,
+				"error in sending the rek command for calibration: %d\n",
+				error);
+		enable_irq(client->irq);
+		return error;
+	}
 
 	enable_irq(client->irq);
 
-- 
2.17.2 (Apple Git-113)

