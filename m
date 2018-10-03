Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383C0C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01BC20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qN0lHFrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01BC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJCM0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39437 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJCM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so2873168plp.6;
        Tue, 02 Oct 2018 22:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=rhaUw2vr+1oEhwDIxV+ggRivRUm4V+5UiVodftIxguw=;
        b=qN0lHFrj86BURnPbRHZxjqJIylAVz1EF/bPgemozpHJLinT1US3FNecqlevsLsklHI
         h5rz9nMNzol2ZoJ9BMTFS+HzVRDUhBx5OQM7kXNaO3fd8GjyU4Z0LV9dS5sUV1jKtPyS
         uWyrJL5Xa8U/i3rtOEdMweaC4JGnd/50qH6ECdI1VrlB1ceqvqna1E5M3Tq8as/5sTAi
         09hXprDE1jrfM0ijBcxncY+a7h7JX6SVA8BAk5fSh3yIYgzOMM2qjcPdeZHDXUivj65G
         MpizYz2cBeYGbqw54bytwzG3/0zaTh9+6bqMAohUnJnqzJoEVARKicz/5EhDT1CXLkil
         XwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=rhaUw2vr+1oEhwDIxV+ggRivRUm4V+5UiVodftIxguw=;
        b=a5dWBsSBgAAx4zjffaAqUkVf13KQW1UAHl0sFTOjSEU+zx1LfIwn3IbP4guPjqw34f
         2r7GW2ajeqTozor6ChU/8GOnpEeJkakWg3KckTAg5vCJcHUDNEJA0NImPshqLh+Ojsgn
         JJ0F/OJeGhfVruvcThnv3OOwKQlRCxHmDe7/tWC8vhaj+MvtbGvbZzSIIBte+LqsYD00
         rUU8QQJ0HrPD3wDp0IhxWNgsXiVA4hUf1k+lwO8CfGS0fWqg65uh6KP1N56095ZpLSBm
         +Oyx2aoE+VcjRbUksa8uMJhIhD9HLkPw1HLKrn+Ybdu9x4kZoQOx4Y7qhIqiyRgSA7ac
         kBeg==
X-Gm-Message-State: ABuFfoiLg3mD+h69w7R98EcaQ2IR5S0bjRRKcjd8DdLh/zHYibZDnktO
        uXwKO3VZxEusyP2m9lCkSrsB78NdMMs=
X-Google-Smtp-Source: ACcGV60MTyeirxKP9DUYMpVt6SDxRteOV8sfe6IYbgvz2FiG3Sy97tHa+j2M8UIX7DaVtp6HeKfUsw==
X-Received: by 2002:a17:902:1026:: with SMTP id b35-v6mr20125938pla.283.1538545200244;
        Tue, 02 Oct 2018 22:40:00 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id u184-v6sm864190pgd.27.2018.10.02.22.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:59 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id EEF151643D0; Tue,  2 Oct 2018 22:39:58 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 07/16] smsc: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:53 -0700
Message-Id: <20181003053902.6910-8-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/smsc/smsc911x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.h b/drivers/net/ethernet/smsc/smsc911x.h
index 8d75508acd2b..51b2fc1a395f 100644
--- a/drivers/net/ethernet/smsc/smsc911x.h
+++ b/drivers/net/ethernet/smsc/smsc911x.h
@@ -67,7 +67,7 @@
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define SMSC_ASSERT_MAC_LOCK(pdata) \
-		WARN_ON_SMP(!spin_is_locked(&pdata->mac_lock))
+		lockdep_assert_held(&pdata->mac_lock)
 #else
 #define SMSC_ASSERT_MAC_LOCK(pdata) do {} while (0)
 #endif				/* CONFIG_DEBUG_SPINLOCK */
-- 
2.19.0

