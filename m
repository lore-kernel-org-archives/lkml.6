Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E791C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E18D208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ID5nxHYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E18D208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeH0WLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:17 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:51679 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:16 -0400
Received: by mail-ua1-f73.google.com with SMTP id 71-v6so7760025uas.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bDcAgwMONlaqnekTjN+US6r3exoKmiBrAX8DbW4zS0w=;
        b=ID5nxHYp7UGn9rd1YDOoFRyMgOgBYWhQ/lIhTg5nHozqYPCge+x2k0V789wl7e2lYt
         aBja2sve2oA9uGyH/5BEe0AjKrPcjfdhWvI7mftRxnsNayucWK1ypjMEHEE8PSwgav7J
         OF1VZJ+3qVuyxirLGcNF6qcXH807rHZpgJr0wQ/epJ6WCqkX4TNBlZPle3qIscN+8Iwk
         iq7lIRhxq0BaT3yWK7vc1jrx/8YSJKlFydASGIqETDfwfQu9v36jfT5QrfokYWK7Iirv
         upwKPBl42gLS4+Gp8o2pAiR8hMNz8I0zFjkjNM2Zc11NkXpL7JDY9smaKl286FwNtKmY
         R9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bDcAgwMONlaqnekTjN+US6r3exoKmiBrAX8DbW4zS0w=;
        b=LACFxH9IueSef+VObt+EmaTRicbwIrGOfqT1iKr4AkxQDwFf6iAa3Rdxnfc2tuNBEx
         eclABkSDIYKCtxXqoPj8/LH+p2MckrUTRwurgieLH3TMp1+u6Im0vUSwOOx7uFCrTz0b
         Q483guW+UrguGf7uXiw014lAkv+1X3E5NMXukcYjaoNDuM69hetr/5NFxTsSZAP177at
         lVnL1uTIO1Phsdy6FBOcqJsosYg0R8zhaqm9FaeHton5sjw9ZUfPTfU0oXRTWN2puRTv
         +mmmwz4nD50o1ZyXNtViowDullX1sVT5Fl0q7PI+Zx0jqnCSJ6a+9mMG61S3ka09f1rQ
         hMgg==
X-Gm-Message-State: APzg51AlICro2bM/cmL5QMmuuZ9HaRctxApxN4jS+dljAZZNTyaNlW2c
        2kC/9doQa2TejGjq9Zze7fuQSEyj
X-Google-Smtp-Source: ANB0VdbE7jUPpODlmM3SP5jLYNbByO7LcaSia4SOwvLaJMzuKlAJvnorKtj7YxCJYpeOt3QA3dfhpc+I
X-Received: by 2002:ab0:7353:: with SMTP id k19-v6mr7044466uap.56.1535394214672;
 Mon, 27 Aug 2018 11:23:34 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:22:57 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-2-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 02/20] platform: goldfish: pipe: Update license
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

goldfish_pipe is distributed under GPL v2.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 6094ca414d9a..d2f0582f445e 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2012 Intel, Inc.
  * Copyright (C) 2013 Intel, Inc.
@@ -984,4 +985,4 @@ static struct platform_driver goldfish_pipe_driver = {
 
 module_platform_driver(goldfish_pipe_driver);
 MODULE_AUTHOR("David Turner <digit@google.com>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

