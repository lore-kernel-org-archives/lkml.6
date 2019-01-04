Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E08AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6B2206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Jq17G69G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfADKcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:32:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34490 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADKcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:32:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so31474158ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 02:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7Tq00l7wWNWOl89qXOwwWszuHIS8h2UPZc8Wsx1Tm4=;
        b=Jq17G69GlQDs5iEy+pEl7M2w3hhTEjxu0taLEdfdRB7nS//T8Lc/PvnGIYTogwGvg+
         E9k54b1VJq57eTnfMeJKXeWT48YSBpms2OTvL9SWEj7zLiXbbmCIcU/Ra3j7z8xzO4rJ
         +RM3KgEm+5FcOQjDT8KaxaiqtI+28bqznxZmBOmgrR4Ahsti8mJu7N//06GKCFj2wRPT
         xKqHDN+IK5I43TDHKAIW1BmATPkdJscK6kjZKIhahuLcmUbmwVilV9HA84WA9MaT+viq
         7koCKXWxyTLj8TEqMz5HxS+ofzFIDJx+Zlpeg6gggctCZW/Fk4mfl6FY0xwq1r4zhqkw
         qjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7Tq00l7wWNWOl89qXOwwWszuHIS8h2UPZc8Wsx1Tm4=;
        b=WVd1b7NvJipGPKczo/kPfImkSpOucqclWGHRfC+SuKs6ntG22IH32PlF31Cc/qaYDU
         0UAj7ujuxTCq392sFQXFfRR2n68CqDd3ThSJzfb6vgPy6JEAMOELOSCgeEzodXLtmhOF
         yjQIrIPby9g/Hknc1R/+T50U2kn86pzb529oYM7LdXzse6y6YWTsxMAI8d9kBK0/CiZX
         jdbyDsqUJfFZ8HHAei/rB4rGaNOtxlfeAyTkcro9vqGRAvWVXPfQXIpXO33Kv8oFOwqR
         A5hQM9C67d6mhSoIRQNn3mEvjUVwB7sToymPww+n4F/cVlkZYupbg0O9RbNaIbDTXQnf
         Arww==
X-Gm-Message-State: AA+aEWbheuMROLlUJfMqdkB0YVNSHXvHQso/DfkHbuEL1TXNnQQTlWCF
        CcQ/1K3DNq9q3ps8H08CnCFFcA==
X-Google-Smtp-Source: AFSGD/VDVPBSs7Zs/+ABzNMU3x7dQC8XSn5hDO1vD//VXZC1CONJZG8TO31QWqTx4e+Y2ithtjf4gA==
X-Received: by 2002:a50:ad97:: with SMTP id a23mr43655819edd.128.1546597949472;
        Fri, 04 Jan 2019 02:32:29 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y26-v6sm13580744ejb.24.2019.01.04.02.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 02:32:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpiolib: fix line event timestamps for nested irqs
Date:   Fri,  4 Jan 2019 11:32:26 +0100
Message-Id: <20190104103226.2878-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Nested interrupts run inside the calling thread's context and the top
half handler is never called which means that we never read the
timestamp.

This issue came up when trying to read line events from a gpiochip
using regmap_irq_chip for interrupts.

Fix it by reading the timestamp from the irq thread function if it's
still 0 by the time the second handler is called.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1651d7f0a303..330c52e19b7e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -828,6 +828,13 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 	/* Do not leak kernel stack to userspace */
 	memset(&ge, 0, sizeof(ge));
 
+	/*
+	 * We may be running from a nested threaded interrupt in which case
+	 * we didn't get the timestamp from lineevent_irq_handler().
+	 */
+	if (!le->timestamp)
+		le->timestamp = ktime_get_real_ns();
+
 	ge.timestamp = le->timestamp;
 
 	if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE
-- 
2.19.1

