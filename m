Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C61C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FED21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7Tih4Ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FED21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJDOiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:38:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37962 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbeJDOiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:38:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so105581pff.5;
        Thu, 04 Oct 2018 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFn1jLamOd2y8K8hzH6lW7ffXGGHoBl+JyIkzMB3QkQ=;
        b=I7Tih4Ecr3l4tSsP7knbGbDF+uqgFV8NmFH1xNDSWIW6To52pz0RI0gnr2rR4S/1Ks
         u5FyOi6q+4RidR59uJ5JYP8nVkMHsuia4inm3fzq+gCXn2OmFOFckLYIhvXa0Bno1KFk
         N195PLRDDCBSIEnP6Rvob1yDLYY1C6HkiqgX3PFn4NFQCHkdZr9xZC7Iw8t8FY60Fgxd
         WaW5hQRIagZoBxOVBXePRpPFgRlex3VPo75lb2azCBeFuYmY9dyre3CJy9DkxqnIOiFO
         l8raotkZr18rmyMnkjk69JlkfZxw8Re+J+LR04VvhrPW3Nh2cdoTkv+Bnlrn5eiL5GfR
         ZwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFn1jLamOd2y8K8hzH6lW7ffXGGHoBl+JyIkzMB3QkQ=;
        b=Jre/YrxK2VUae+ZhHoLt9sOis9F+XMp+hRCRuxJkWbAsutvt7ytqdGUj2PMJmAOot4
         hQTDtf/3TEEOIyYjmnaqS/B9O0vulsuXQXPf2hpVs1pE3wY0zalGEuBH7srBSLXnJwqu
         KQP+U+JdCysAMCA+Eav1kBvN8jaS5deijqPtlj8EoJQjp6VvOo23VLZKopq2Wk0Ve4Kr
         AzKR0VwxAmo1d3h06evZxdYnUVFmGzeYMvRPhRd0Y1XBWAun9UJcFeArolCp6lpJi3Rf
         Sjk8OOiOcX7dUb+v7wMSxfUyk8LwUQgVVpL+oyI9+r6NIQtdBVVJvBQrlZV9jdWR5J+S
         4xkQ==
X-Gm-Message-State: ABuFfoid0gHUWBsXFvn8gOBZKwx0gYb8oadQOQ0L2CbFV5azl+XxXHnU
        XLq4CDPxkwuUons5h2LqKyM=
X-Google-Smtp-Source: ACcGV60Mo5UU2NhneG5DRAOF6WzMBVU3EEGTwbiD8nMkXCSlyOm5rSTgSI+J38pQTv8BMSQ04X5QpQ==
X-Received: by 2002:a63:d048:: with SMTP id s8-v6mr4555091pgi.311.1538639218917;
        Thu, 04 Oct 2018 00:46:58 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id r18-v6sm2496171pgv.17.2018.10.04.00.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 00:46:58 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id C6D9A161835; Thu,  4 Oct 2018 00:46:58 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>, Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH] atm: nicstar: Replace spin_is_locked() with spin_trylock()
Date:   Thu,  4 Oct 2018 00:46:57 -0700
Message-Id: <20181004074657.17597-1-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ns_poll() used spin_is_locked() + spin_lock() to get achieve the same
thing as a spin_trylock(), so simplify it by using that instead. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>
Cc: <linux-atm-general@lists.sourceforge.net>
Cc: <netdev@vger.kernel.org>
---
 drivers/atm/nicstar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index cbec9adc01c7..ae4aa02e4dc6 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -2689,11 +2689,10 @@ static void ns_poll(struct timer_list *unused)
 	PRINTK("nicstar: Entering ns_poll().\n");
 	for (i = 0; i < num_cards; i++) {
 		card = cards[i];
-		if (spin_is_locked(&card->int_lock)) {
+		if (!spin_trylock_irqsave(&card->int_lock, flags)) {
 			/* Probably it isn't worth spinning */
 			continue;
 		}
-		spin_lock_irqsave(&card->int_lock, flags);
 
 		stat_w = 0;
 		stat_r = readl(card->membase + STAT);
-- 
2.19.0

