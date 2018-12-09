Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7BC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DE520645
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVBUmyak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DE520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLIStw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:49:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37326 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeLIStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:49:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so9014748wmd.2;
        Sun, 09 Dec 2018 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a0tgK3X3jWZIwLyGCzz5Lo612Z9PUJ4XNGmpU+K4v/M=;
        b=MVBUmyakJVJsvKCu6O22J1qZUVVFWSBXmS4gEudtN8kXoYSkSJAcGztOTKH7cWVy+H
         3u1hZNnCxc++V5W2v8gxSqXk+wn56C3QemWZClm+lpaXBfn6apdF8QTEhecytIKXmwkr
         QeBKc+cI437ACFp+pGtf0YiFVwBeQazAnuUjLdGdpvQlrca3fG9jvRze2dIXFW3oFzP/
         tb240TRXdBFGneI29Nr7agZgWy3BuhHFiWw4X7eNwKkKILepU51n+/jJBfAZhlCi7vtK
         kmWmL8IIHm/yBxv1G6x+sEccqfaI+jBFWKndPSpq6UHNLeM6/Ccxu1yTndcK9a0td3MH
         T2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a0tgK3X3jWZIwLyGCzz5Lo612Z9PUJ4XNGmpU+K4v/M=;
        b=Z65v/FKhMbP4l+qjktEUPt8LUy7BXAMJzPUcl2/q0nViAoH5h1eU61h12LP3UzMZep
         U2yxQld4H0Q3aXBnQQqmvft5efep3qVyEP6bOo5wuaxh2faMIHOHURxU/O6Lj//ifwnn
         4edEgheZ4rGekw4jgSDoSbc2aFfaal/SCv0mjMi0O3uJMmNyK1BZVVaZoU/Z/Smgbgr3
         4UlkCiRfJGn+p/hEklaT3lHFNzgCscfgt8TypLofwNKLWu5sEICXcTgLVSWaCbe630Ea
         CuZaeMwVi5TQ4FTUIRa6bDAkoT0inU2F+dY0UGOAtzVhOdd3f+vPs13VGJpsGflRHtym
         0VSg==
X-Gm-Message-State: AA+aEWYeff9bBJssC6xzHO59dtVRAFo+VE4CbQ4TtuhrBTxm4pYe8JE8
        wy8i3QFnPtQpeqpslYMePha4Xwfr
X-Google-Smtp-Source: AFSGD/VvM+PtxCfviLMlQQCOOdxIynbuVZ4EQ+Q9nzW7adL6mddJ9HZFzXvR4aGiY11/1AGtFFbu5w==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr7658074wmb.127.1544381389936;
        Sun, 09 Dec 2018 10:49:49 -0800 (PST)
Received: from myhost.home (cit97.neoplus.adsl.tpnet.pl. [83.31.43.97])
        by smtp.gmail.com with ESMTPSA id e19sm20009021wrc.25.2018.12.09.10.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:49:49 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com,
        krzk@kernel.org
Subject: [PATCH 1/2] led: triggers: Break the for loop after default trigger is found
Date:   Sun,  9 Dec 2018 19:49:41 +0100
Message-Id: <20181209184942.22391-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is of no avail to continue iterating through registered
triggers in the led_trigger_set_default() after the trigger to set
has been found. Add "break" statement to fix this omission.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/led-triggers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 17d73db1456e..52b12e601ebe 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -200,8 +200,10 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
 	down_read(&triggers_list_lock);
 	down_write(&led_cdev->trigger_lock);
 	list_for_each_entry(trig, &trigger_list, next_trig) {
-		if (!strcmp(led_cdev->default_trigger, trig->name))
+		if (!strcmp(led_cdev->default_trigger, trig->name)) {
 			led_trigger_set(led_cdev, trig);
+			break;
+		}
 	}
 	up_write(&led_cdev->trigger_lock);
 	up_read(&triggers_list_lock);
-- 
2.11.0

