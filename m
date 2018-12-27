Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD902C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2C0214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="oUuWXCTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbeL0U3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:29:10 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54802 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbeL0U3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:29:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id BCF11148
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 20:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fn9FsSTG4EW8 for <linux-kernel@vger.kernel.org>;
        Thu, 27 Dec 2018 14:29:08 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 96E53607
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 14:29:08 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id p4so23092620iod.17
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 12:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qjUzW9f7/4yeimAegS9XhZOTjFBdcEVLwOSIBSJ0prc=;
        b=oUuWXCTpnteBWnI7shWgSBR6/dafAmlge67rmMw8AoI0fYVSGB+vMFxmNnSDgZzBqW
         O8OiIPO7JuAvHiCDL6TmdY68CRnbQ6Ll3+GYvs0yq4DYHdMZ2Kn+Q/DwKoLGvyYsJIfH
         8M82wut5lzjcXbYgCUEm3XpzccArpvpZtPq2SLUI0WJbDoJKcT62MI9+lvAqnMtgs/l7
         ukGYreIYE/t55c0lqqEuSfTMLQNzHp+Ero8wAqSL0DO/M3/ydOeYP2pJpM+SkInJcfYf
         CfIslQ5mndO4jLwByaeZZGAen7TD6umUdBCJM5UoebdqJCJaym40Szuqlkxtgi4vt4a+
         RM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qjUzW9f7/4yeimAegS9XhZOTjFBdcEVLwOSIBSJ0prc=;
        b=Czo9MBIghZliUpXMGgSZm30/Edh/4s0QMhQnTzWHjtSlrCoZE03ARH/rjigewn+BRE
         R97hZYOrFDNMXZo1A4yvZ4BFv/1kD9+fRRoqRZ4cSfrYzFybEDR1q8eb4dePFYCWf0yi
         X2fjv7xPW6CjkxvXZ/kIUAAt65o4sB8u67bv0ti2BSH7/kKyTnJnwKr8xiYSuA0C8iVF
         DAVOdawxTmecYmPXJ+i1jVAo9d0ijAUpscDvGyM4ATS4wOcWWYNep/7HHivZdEigKvzY
         hN91D48jgimeiNLm4lc9qDTMEjdkZDc4sCusgNPt0iF/RDs6SYHkwTE32fjCpkjvbhm+
         dJBw==
X-Gm-Message-State: AA+aEWaja8sjufZoH/zIvVCP0Mk5cM8OkTjbmD2XWSx+f1jV2XL2yuQM
        hzSURlNzQG/cHTv0dH88ktvqFS8t7dTuVaPKRAWWvFE3nawynj9pep/o3lJdSFiQiScX4Iqujit
        1dlUriAgmXfWka3O9a8Hw1JWhyc86
X-Received: by 2002:a24:8e43:: with SMTP id h64mr15070165ite.26.1545942548193;
        Thu, 27 Dec 2018 12:29:08 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VD7S7scoxbvijQJ57zJIpbBZuVTH+RSgqsOE0jWcyAHMojgpEI41XBpcaw6fJooQyYfnvKeQ==
X-Received: by 2002:a24:8e43:: with SMTP id h64mr15070154ite.26.1545942547933;
        Thu, 27 Dec 2018 12:29:07 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id j129sm14939661itb.41.2018.12.27.12.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 12:29:07 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rv8803: Check return value of rv8803_write_reg
Date:   Thu, 27 Dec 2018 14:28:55 -0600
Message-Id: <20181227202856.27408-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rv8803_handle_irq, rv8803_write_reg can return a failed return
value when attempting to write to the bus. The fix checks the output
and throws a dev_warn notifying of the failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/rtc/rtc-rv8803.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 450a0b831a2d..5a19d5ecbf57 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -180,8 +180,13 @@ static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
 
 	if (events) {
 		rtc_update_irq(rv8803->rtc, 1, events);
-		rv8803_write_reg(client, RV8803_FLAG, flags);
-		rv8803_write_reg(rv8803->client, RV8803_CTRL, rv8803->ctrl);
+		if (rv8803_write_reg(client, RV8803_FLAG, flags))
+			dev_warn(&client->dev, "Failed to write RV8803 reg.\n");
+
+		if (rv8803_write_reg(rv8803->client, RV8803_CTRL,
+					rv8803->ctrl))
+			dev_warn(&rv8803->client->dev,
+				"Failed to write RV8803_CTRL reg.\n");
 	}
 
 	mutex_unlock(&rv8803->flags_lock);
-- 
2.17.1

