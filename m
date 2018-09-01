Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62393C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016262083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFmGh7VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016262083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeIAQXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:23:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeIAQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:23:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so6680650pff.11;
        Sat, 01 Sep 2018 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=urlVOUAThIo2WT+9QwQ1B1RbCWzS5jRVJWYhfhEhD7E=;
        b=aFmGh7VMR4MejHEx/7yh6o2NlPdJ2bTj94iGyVqi3zwoYHq2uOhFZF5NfJdu7d5s10
         nBDdJOzR5Dk9+gDR0hVY17odSmOYCHPKczkXxCmIMKAYqeFLWavDru0fICvbAxLNDEgU
         zmhCvXRmT34zHrXq3F9V17cmatkxFmnNiYmIqhgb3t9/JJeAzy8nwV6ed1V4gh8tk4ig
         oxPhMWljYPjw4SF2IgsTcpgXaVf6/KvsDuazMz0pwGndR1N7udzjF2U6NOk5IItU1tpX
         JD5ADq2azJB6w7f8uMXFSZo/0bK+ONFpG9w8/g0GNv0R5b/hDv9pqfNNYTIo9l0wDW+9
         nv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=urlVOUAThIo2WT+9QwQ1B1RbCWzS5jRVJWYhfhEhD7E=;
        b=cHFa0OYdqd3Wv5Jwn3iYQ0BEKCNvqKSTIrE/svZrYEocvu5adp5PQPB4yv8jzDgGmC
         p92T0KHyjz9sldli4PHyDHGsNfg4wRlReIQ/L5Me5gzm9cZH9AIrdOHn9wawCFKnsY1f
         uiw91mSSDFqVUQ7XyGRO1uceIMZW9gH5ONJDATS+IOZ+a7Ifq/wTzPzzM2G+r1aRKsO3
         rEjCxvpLVhFq1YGpFUJU3xnIYWhhdv3kR7O5pImlyngaLcDqyiCd15RtmvcrJK5/KBqD
         ATF8+18EEQR+fidlN2XtOEft8KgvV+DWB7JG2FRmIa7nvb8rc7ND0JYhAbHNF5gJSzzM
         FqFw==
X-Gm-Message-State: APzg51A9wUoEzGluPNmTD9OVzphjVbFuylfaZUExVwhKNCfOzoKI6j7a
        DSCLPPfmNBnTGU1Apo6zoAI=
X-Google-Smtp-Source: ANB0VdaoMz8afJJdPOyaCYqqpOFt0AUgOH3JV7x+Y8EaTA467H7JIUHV7luk8G6E39dXy5DAeOtuDg==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr16569946pgq.392.1535803872086;
        Sat, 01 Sep 2018 05:11:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id y85-v6sm20189389pfa.170.2018.09.01.05.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:11:11 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     nicolas.ferre@microchip.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()
Date:   Sat,  1 Sep 2018 20:11:05 +0800
Message-Id: <20180901121105.436-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] usleep_range
drivers/net/ethernet/cadence/macb_main.c, 648: 
	usleep_range in macb_halt_tx
drivers/net/ethernet/cadence/macb_main.c, 730: 
	macb_halt_tx in macb_tx_error_task
drivers/net/ethernet/cadence/macb_main.c, 721: 
	_raw_spin_lock_irqsave in macb_tx_error_task

To fix this bug, usleep_range() is replaced with udelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a6c911bb5ce2..3dcc31cd4261 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -641,7 +641,7 @@ static int macb_halt_tx(struct macb *bp)
 		if (!(status & MACB_BIT(TGO)))
 			return 0;
 
-		usleep_range(10, 250);
+		udelay(250);
 	} while (time_before(halt_time, timeout));
 
 	return -ETIMEDOUT;
-- 
2.17.0

