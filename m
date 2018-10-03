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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FAFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691DA20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roO5FrLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691DA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeJCM0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38139 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so1026499pgr.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=uJYZzACrqvzATTatvGUYsDZ71l09xOMCA8Wn8dpDwDY=;
        b=roO5FrLlm7MT/Ms/hie/C8qhVYajGqGbxQSFzkQANd4HK8+X437lAb0nrbI83I85vB
         m2o5dUt293fNaQYaA5XT9yjfcOkYHCM8DYIpZp7KZV3NLxCjWnccgJyvDUWcrUwJCLL4
         DAypkM55N1egx5LjDImsax+xWEG+1Jm6SqNUKxzG48YY/TWXhKomeqx05wGiZRCSWzDi
         8zOXS0kY7C0I6DnFTNPF8VVV1M23FFkng6g8qNDl2x4QeaIEvoi3ajzfyijJS3KORDVD
         z+eQoH8zqc8nYDa4PYyPpxfYtKdWeaLYZrZ+s4yauKXQ4FLPvU5L/T5Y1hx2OAmB2jCI
         qhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=uJYZzACrqvzATTatvGUYsDZ71l09xOMCA8Wn8dpDwDY=;
        b=Bb/CJv9Tt8n4Z1PYkqixFtdzwLn3Y0wo6adnGUzK+4yasVWinY0TaUjkKmsyZ8D7m2
         meBQIQnqWX/Ij3RjBFX4YQ5lu/p4aUYhzEgAI3J1vTW5YCpSsPKt7B4KXHt2gpPZ6UCV
         SeE2R7bCW2JSKHc4X3/4Gq9Py087m1wkAXo2xkl1We+pj6cUKsJS1eQbPP1ur9RpSlJS
         Lh0OkKwtuR6OexzpsHC+8F0hQDkD6CoJ5Ggf1vX0U/199ehtgf3NtYStVfgDvx7e3it/
         vU3bK5ijG0oz5wed3k7phI3rSj8sH/TnE33+tmkmhD85qiv9FA5P4ZCEdIQAgc6pMKbc
         9mRg==
X-Gm-Message-State: ABuFfogYRibs/0pRFg3cYD87bhfC0M+d0Fi5dN3J6lPHXxxBMHSg0Q/N
        5fZWppJAGM314kzG5tfApW0=
X-Google-Smtp-Source: ACcGV63RHh8ZT41VmPLuY09/HX6PACjJLqpnT8XsOOD4Xe7RBbXcTqdlsgtFzjIAuozKYZJ/S2rLVA==
X-Received: by 2002:a63:1d10:: with SMTP id d16-v6mr7956068pgd.228.1538545186776;
        Tue, 02 Oct 2018 22:39:46 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id p1-v6sm504458pff.128.2018.10.02.22.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:46 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 5E62D1643D0; Tue,  2 Oct 2018 22:39:45 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org
Subject: [PATCH 02/16] hv_balloon: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:48 -0700
Message-Id: <20181003053902.6910-3-ldr709@gmail.com>
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
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: <devel@linuxdriverproject.org>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index b1b788082793..41631512ae97 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -689,7 +689,7 @@ static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
 	__online_page_increment_counters(pg);
 	__online_page_free(pg);
 
-	WARN_ON_ONCE(!spin_is_locked(&dm_device.ha_lock));
+	lockdep_assert_held(&dm_device.ha_lock);
 	dm_device.num_pages_onlined++;
 }
 
-- 
2.19.0

