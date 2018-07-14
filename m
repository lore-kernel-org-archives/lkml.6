Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88770ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406CE208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrvxjOZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406CE208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeGNGQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38559 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeGNGQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id v15-v6so3748044pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gx9z6Wrgu4Yfox5q4ztlpJjirvvil7nXZPI9+apOPSM=;
        b=HrvxjOZfRMcsbQDuRX1PxPq6bZqQ7WPOGpAybfzaeysQj8JlfO1iLR5Ec/CXV/rOy4
         MrlYAVcgBQUieGHApQT6ZRR/1Q/awKDwK4fBRHQSMcm44MLhIrMvqc61qomSvlmUopK3
         pyRIlJMeA0JHGGdqqkwZpz5im+dEOoFf5z0MztjcNpl4NkP53y5PddGjUZYGV5UWu62h
         E8qoFFzFn41hNHlXoQPVUoQhK48xqHFwGTTUZKFL8XJC8BQprQ2MJ8aaqaxIy5GORiMx
         DDnfJ7+M3IiG7t0+JxLkeR0TIZ6R+uVjV7Th/ByTFx7YYcWLH4B39PFgvRdgu11Emzi9
         aEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gx9z6Wrgu4Yfox5q4ztlpJjirvvil7nXZPI9+apOPSM=;
        b=JDSHQ5uvvp1dWthOCWj5szC4h3m05NN587Xp85lIonrnlHzyg/3LemGf1FuFWBRoGR
         QR4dWYfMTitiqYKziJvyQYLtJdvip37FEBdRY9jfTCQFzp8XUYkFyqBh16FQyJLhNQMJ
         WiUSaz8ifuVKhRNBmxUlglQuq4CijWfT0khPoYc9DDHPlwyDdmnL+l9c/JTw+N5Uwybo
         U6hoFiPL0szh28RlBST5pQSSMDT61O1hJM15M6QisLepLIWYJ+4WiqLLZgsDORHndbks
         wDMxtg5Skgou7ELGiQfYTXZm+zAa0cZZbSq5L4LReFtzb+WSnuXozPU1WAweR5doFNtL
         JwYw==
X-Gm-Message-State: AOUpUlFUtCcaI+/+CY4TtXp6TOkxIKusLQcYBZiAzUp/yBOB8iIZxl94
        S/j8isr9251uYqC+czm0eEARrIt8
X-Google-Smtp-Source: AAOMgpdGwkLZ2ddkMRAI84noLY7PqCJcErhRFMR05H1O2y2WOBtEMBYJT5w2qI1f3UMTRDMkXBG03w==
X-Received: by 2002:a63:2506:: with SMTP id l6-v6mr6731030pgl.237.1531547930259;
        Fri, 13 Jul 2018 22:58:50 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:49 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/18] staging: gasket: fix deadlock in pci driver unregister path
Date:   Fri, 13 Jul 2018 22:58:04 -0700
Message-Id: <20180714055816.223754-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

g_mutex held across pci_unregister_driver() call, also held in
gasket_pci_remove(), which deadlocks.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 3bdf7d36b397..6d240dc59557 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -668,13 +668,10 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
 	struct gasket_dev *gasket_dev = NULL;
 	const struct gasket_driver_desc *driver_desc;
 	/* Find the device desc. */
-	mutex_lock(&g_mutex);
+	__must_hold(&g_mutex);
 	internal_desc = lookup_internal_desc(pci_dev);
-	if (!internal_desc) {
-		mutex_unlock(&g_mutex);
+	if (!internal_desc)
 		return;
-	}
-	mutex_unlock(&g_mutex);
 
 	driver_desc = internal_desc->driver_desc;
 
-- 
2.18.0.203.gfac676dfb9-goog

