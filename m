Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33CEFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F3B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCQ8e0M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F3B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeG3PZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:25:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46434 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeG3PZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:25:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so4562790pfn.13;
        Mon, 30 Jul 2018 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tCz22AsCObLojGGLfy1+GWdAdICfkV4UlIXdWEY5QW0=;
        b=ZCQ8e0M+aK9Qh44UXoAV5jMs2VUzcqp6Qtm+neCSxBWio3dbobSJ9EInBFz/+iBD40
         UZFQHw+bpqRtguAflJhQh9W/hUOSRbVskfP+0eRE8hA23U6usYegl9xRU3FWyUB4ToOr
         JevYwOD/vKuqaEwUxdDsN1KuWLbCoy9/nStfhCt7DDQWveCGh8BEGpQ+kJoChWrs+3xO
         2rI3tNGwC5EvF10seDucHO2g6VlEGbFAXwQjlbgq+IVwi5mJPfBDQ5+eTaBSSnbXJYo4
         3yMqg1IO6egyXO6poTEOiuoLK+xa5XxePR6gQikhdAoqU1gur5gVGZIH7RbIwWuv3MNS
         Nk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tCz22AsCObLojGGLfy1+GWdAdICfkV4UlIXdWEY5QW0=;
        b=KcYiqOkpG+XANOtKL1Cnn8ZI5Fn1tK72fPyLISlPHrGXeBGdT7Hj4tdlGu47G6Pjfh
         j9iZpkv+kuIxx1LgaBeGa0JpERgX1WV2Is1vxx1u3PqoQjwJEyr5QW8A0WBoPMxjMaaW
         0gw+wNMeYiZ6KNUt/tLBhAEid5ex7HD3EA5vGxsr/IHqTTLpdRVlUR4VVE583oeM8hf8
         y1oLgZlrGJDOQt0iNHHW6CxAbIZsobwvRTML5lF7MLzhJWD2g9ZefqVhi7Ky0S1DBaTd
         ni/XPJuEO+EPl66cFcMhT7FWJ7iUX30j+9SqsC5x0oy1P2T9G0788FJhW5Aa4GTi6J6f
         9GHA==
X-Gm-Message-State: AOUpUlHjycucKkpJ1Bd0UfLMaDEJw7d6VY3acyuwHq0mBRzlEEbAa5PC
        j4NE/HAICFBJkhF2TGVkJoc=
X-Google-Smtp-Source: AAOMgpcQy1J8sEbsvkwCybk6TAjlIqR3KRDPmBGhg6enS66l98ymf0u9mDFb7FHY025kIXR94xE5dA==
X-Received: by 2002:a63:b95c:: with SMTP id v28-v6mr16428265pgo.162.1532958634867;
        Mon, 30 Jul 2018 06:50:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id r22-v6sm20270696pfl.112.2018.07.30.06.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:50:34 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] power: reset: syscon-poweroff: Replace mdelay() with msleep() in syscon_poweroff()
Date:   Mon, 30 Jul 2018 21:50:29 +0800
Message-Id: <20180730135029.9228-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscon_poweroff() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/power/reset/syscon-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index f9f1cb54fbf9..b8b154606dbe 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -36,7 +36,7 @@ static void syscon_poweroff(void)
 	/* Issue the poweroff */
 	regmap_update_bits(map, offset, mask, value);
 
-	mdelay(1000);
+	msleep(1000);
 
 	pr_emerg("Unable to poweroff system\n");
 }
-- 
2.17.0

