Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA86BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645CE20854
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQU/mTjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645CE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbeGNW7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:59:47 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38589 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbeGNW7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:59:46 -0400
Received: by mail-qk0-f194.google.com with SMTP id y4-v6so18911551qka.5;
        Sat, 14 Jul 2018 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=V4t8xCZbaMrcVF77zdK4BT5UQqL05PHE5e150afrJoc=;
        b=PQU/mTjbPylEn5aaselyoLwgsc4k/KK/2xA3gul951gTMb0dyghAlFPpYEm58lCQS9
         LPzRBz6Z7Phi8Z9XEmRidWMRjWLFk6lPKVxuCzic9tn1/4eXx54OERpXOvrPJevbMx7i
         sTx0n+vwSIyTlpbq0z+X/Xr1kUdx0VPMSEeP0I096rxH+KobOBTmU/FXr2fhlhUyRnK2
         b1rwsGdANu0qaeXMqxihQ/r9Mdp5ZeTNEPPoreQq6/O3tIsZ5a8lP77Vj5oOIqpz7654
         Izb91sWR1fF0kakRPuzwkckgBg9k3uIqzSz1TsS5XD3LpnFKp79ryQr+WLjCKGSTPyiG
         H/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=V4t8xCZbaMrcVF77zdK4BT5UQqL05PHE5e150afrJoc=;
        b=ESHV/znM8HlnVvQ6JyCGhKA3FpILOAXJLLzixy2hVe0JGQV4dxIpWY9ZDiH+pGiJk8
         NItZRyE5bh0c1NvfM9zUt1SW9+ejH8ya97bDVhmpX8EMTLb4XOKCZLK1ZLX3zAQp6KxB
         y4/tb17xsVAVtTOaX4vkdTFO78qOV8DzYGpZpnEKz6Au5DTJ/kWoenYpbZ+v0mnrZApl
         OpEYN5XqKVhQ8NtJNe+oqGmCk2hdgHv/QqJrXuoyTbCP+ieLUGWUVBDwZxGlnP7mC27/
         QB54UrVV6126tVFA3tmjIBbWIRCEP/HXvRw/rQ6VOey/vcov71wOp3aC21vrY/3EMmmS
         GyjA==
X-Gm-Message-State: AOUpUlFOkiCUZ9zL0p4iwOWEWVXFYrxfUCdQffijmC3MbcBbuZE/jRmt
        a3k6yv/Bl+jxQ4PKw9iFWBXRsg==
X-Google-Smtp-Source: AAOMgpfrOIguHfvKSAM2l4kw9MCg2Dmj/C59/o+7LQMExzukPOeSqU3bYVP4cFeXk4+SGZmOg0W2JA==
X-Received: by 2002:a37:9242:: with SMTP id u63-v6mr9489629qkd.189.1531607951676;
        Sat, 14 Jul 2018 15:39:11 -0700 (PDT)
Received: from localhost.localdomain ([38.82.195.110])
        by smtp.gmail.com with ESMTPSA id v88-v6sm23691873qkv.63.2018.07.14.15.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 15:39:10 -0700 (PDT)
From:   Lucas Magasweran <lucas.magasweran@ieee.org>
To:     linux-acpi@vger.kernel.org
Cc:     Vladimir Lebedev <vladimir.p.lebedev@intel.com>,
        Lucas Rangit Magasweran <lucas.magasweran@ieee.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: battery: use cache_time as cache "enabled"
Date:   Sat, 14 Jul 2018 15:38:29 -0700
Message-Id: <1531607910-4975-1-git-send-email-lucas.magasweran@ieee.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>

When battery state is not cached the module parameter cache_time is 0
and battery->update_time starts at 0. However, it set to jiffies in
each call to acpi_battery_get_state() and should not be used to
determine if a cache time is used.

Using battery->update_time causes the evaluation of time_before()
even though cache_time is 0.

This is a minor issue as the behavior is still as expected.
Even if kernel HZ was very slow and jiffies remained equal, the
expected branch (false) would be taken because time_before() is
used instead of time_before_eq().

Signed-off-by: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
---
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index d79ad84..f88bc9f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -549,7 +549,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	if (!acpi_battery_present(battery))
 		return 0;
 
-	if (battery->update_time &&
+	if (cache_time &&
 	    time_before(jiffies, battery->update_time +
 			msecs_to_jiffies(cache_time)))
 		return 0;
-- 
2.7.4

