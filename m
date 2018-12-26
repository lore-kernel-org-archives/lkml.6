Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4F6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75217214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="h7e+ESaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeLZESx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 23:18:53 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:51748 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLZESw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 23:18:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 55924279
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DJIu6jhe7wW8 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 22:18:51 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 264B41EE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:18:51 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id x82so18732884ita.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KISHaiMSEopWL9yba7zBqacYFownnt3DuK5v4mGHTRI=;
        b=h7e+ESaD3Sy29oFwqnnEoOBjFjOHV2jEqB+kgRE8mG4NoDifcVX9ifAAJAphJlEgI6
         fWN6UhHkAMgpkdUVH7y4eOfTuzDllCASD8kAcNn4hTMHwkTvAhPsP+4cxNeH6xo25+pg
         bs7+WsCSgLEQLGnfKEsQ4SFlTbN4g2xOX2vXztPMQnPxNSd6udniqkhr3LRcmC6g/5pK
         /ffCmQ5/lweVV0W6q2vj51zWqpw0rpsv7wnfbqYfyTxQU23Ab6ZcxTYSk7Sx9uH2Y0+J
         SLsZxo0IOyZELZjD5PPBa29KW5erY06bAtSKQQQ+LAIUFcxOxCJgsnqRV6J0P/gDLTLj
         cXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KISHaiMSEopWL9yba7zBqacYFownnt3DuK5v4mGHTRI=;
        b=BlklIc+9euZ9ZtocIrxXbbwP/Zwap22cWUtxDQAAFBVF1rupVOSICV36fIympPtPgW
         KW+MFRBaPKKwdua9zTD8jUTmD9XQ/VkLNLSnAKd8+pEk+xa9yj8x+3dnNDkR3/o+h0bH
         hU1lZNy7x8O+YvrQB435vuxczFRmmUc3PSqIEDYUQ+FUCQpOVrnv+fMv2GWNfJAo8EPN
         hhejTqhX1uQTizLrBWT2dlNoAqzPNTrwb1IFS+jetx9zdX2hLPTsKGkKOBZFhjzgqkyr
         duNCK6Ti6x/UHyCeOYWaTvSOx9+V6CZXBPzu+MeG7LYo6zrFZw/SGCYuA/fa7iKYwRrs
         WiGw==
X-Gm-Message-State: AJcUukdY69bPewGIwr/+cmwdL+gZ5I9YT9ezcm3OTtALtvzX76RICpm0
        i6j+yg+d+OjCrUEeUk+NOpbc3kh0B96PHQeTMQuB8DrBSMQdnmGpas0nZ8kdvrZi+WoVzlzWXNf
        RAs9mihSrxvfUhFR3DiuixBWHqDqa
X-Received: by 2002:a6b:8d8e:: with SMTP id p136mr12855360iod.166.1545797930798;
        Tue, 25 Dec 2018 20:18:50 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5+cz2meNZcYtF1kOpIOsowfvN5ci7ULMEhTTkbUoWMwCXqnCUAMkdTsBTsApf/1FKzQjo2RQ==
X-Received: by 2002:a6b:8d8e:: with SMTP id p136mr12855352iod.166.1545797930561;
        Tue, 25 Dec 2018 20:18:50 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id y3sm16024794iol.55.2018.12.25.20.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 20:18:49 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: fix a missing check of return value of lp55xx_read
Date:   Tue, 25 Dec 2018 22:18:23 -0600
Message-Id: <20181226041823.73950-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When lp55xx_read() fails, "status" is an uninitialized variable and thus
may contain random value; using it leads to undefined behaviors.

The fix inserts a check for the return value of lp55xx_read: if it
fails, returns with its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/leds/leds-lp5523.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index a2e74feee2b2..fd64df5a57a5 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -318,7 +318,9 @@ static int lp5523_init_program_engine(struct lp55xx_chip *chip)
 
 	/* Let the programs run for couple of ms and check the engine status */
 	usleep_range(3000, 6000);
-	lp55xx_read(chip, LP5523_REG_STATUS, &status);
+	ret = lp55xx_read(chip, LP5523_REG_STATUS, &status);
+	if (ret)
+		return ret;
 	status &= LP5523_ENG_STATUS_MASK;
 
 	if (status != LP5523_ENG_STATUS_MASK) {
-- 
2.17.2 (Apple Git-113)

