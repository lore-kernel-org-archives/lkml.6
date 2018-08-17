Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28977C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F5E21A38
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiiHDsu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F5E21A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeHQVja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36602 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id m27-v6so1620868wrf.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4f8Jde1VluNdbQ5+SFZLuP4JtycBgKDl7QeBsDag5vI=;
        b=jiiHDsu/l1psT7CUEbeVK2HlqLbaKhNSiCwB/FdzCltSAPxVsD0/LTyYXoMyCRHu0h
         OT74qk4sbvCGxIMEEeIK+Lsv/beOBVMkIrweRz7btkP/dhjaFr66NUAccAbS3e42iT7D
         cr3S9qVjDGmgifA7VXw6/9BpKXqRLUYnh1hcUyTlkIDHhQWBkQ3RnyycfvtBgOWzE+1V
         hYslODsrhQNVh7g+lwireMzDEF60SMLQxX8XuUktepZvVqJvR/SVEnOqoKPh/+xBsjTy
         3FOiBokg4bpRQzFY7Ny3WBs/Xt10zBcASQCOB/bR71P0aEY/6x8SnksElt1jYb/j6xrU
         kY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4f8Jde1VluNdbQ5+SFZLuP4JtycBgKDl7QeBsDag5vI=;
        b=X3PQbfYb/j/Nak3FkGPN8wf4X+7RuCumMf/56RG6c5qM5XD6qF/Bj9pDD9prTgkfse
         8Ly0iGL2eX9OlRIk5RXqeLe74gYcAYJdhfE7t12s0sEnaVr7fch82uqxFoKn3zsWKjgQ
         yGD/Jft6DkFwpGAXURonHglsWU5YCzhO9GVeks/YMfh0u8IthZpgKeTBagPCMD20rbNa
         tG8BKelzMOqTFFGKi1G3fK3/Aj2L5kx/hSWkqlZXV2IYoNUYWATZ6w025rkkLUap61G/
         +EV1/nelqbckbNIjQb28zZ+vjXqSExy5kO8yZ8dLsAvKfU7b9CaSNgbiKMqBJ/Pv38B8
         E8kA==
X-Gm-Message-State: AOUpUlGjlKGXAIYAGu4OF4l9XQ5R6Q6n+Nq2dgAtZtoWeK+Owjat002c
        Vl4IUhenQjfWAp2QpgvXFKt7YgYyuB8=
X-Google-Smtp-Source: AA+uWPyvjwYHquIzjGXaDr01iUMFMT7Ma0FI9X4kW1Ys7xZ03zb6xw/icmdxUZpB0W3T916cZ9vKhA==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr23547182wrq.61.1534530902284;
        Fri, 17 Aug 2018 11:35:02 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:35:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/10] staging:rtl8192u: Remove unused constants - Style
Date:   Fri, 17 Aug 2018 19:34:42 +0100
Message-Id: <20180817183447.15993-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused constants, this is a coding style change which should
have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index da71f745f039..947c381bce79 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -18,10 +18,6 @@
  */
 #define HTCLNG	4
 
-#define HT_SUPPORTED_MCS_1SS_BITMAP					0x000000ff
-#define HT_SUPPORTED_MCS_2SS_BITMAP					0x0000ff00
-#define HT_SUPPORTED_MCS_1SS_2SS_BITMAP			HT_MCS_1SS_BITMAP | HT_MCS_1SS_2SS_BITMAP
-
 //
 // Represent Channel Width in HT Capabilities
 //
-- 
2.18.0

