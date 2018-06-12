Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85F0DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C1320693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0NXaujO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C1320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeFLEQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:16:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33643 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeFLEQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:16:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so11392953pfi.0;
        Mon, 11 Jun 2018 21:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2e58dYCyHjCrRMzvDJHZ4B3vN5K2NBtjTra2hTQl9ng=;
        b=p0NXaujO2gFA7R17e3n4gMS9ahNGRQy4ijuKc8o2+xegxT11KFX3m/Rv4CboJfE0QB
         p1WSsJo33JB4aAKxCY5lb9Uh5qNBw3Wy2mAX85452Yk164l/Anmp2YIjO8D7QwLJMk4c
         uUqO295UNoAVxMRdPf4MECuFIr5MiW5CkxPDIo9+YnAnzr5i0YPUKXj3k8voAGI9Ndr0
         IvZ7b8hlWzCI4lp+pqrCRB9T0rP7noaUu5DpikAJMgJHGRCBVj6ZeFwwqihh0CEYj+UE
         CgG35ZNej49VhqMnRuNedfYgPv5fjygZWWJ0jY2Dq5nYl4d9Vo8vqtcXeYWoOprFZbfv
         VoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2e58dYCyHjCrRMzvDJHZ4B3vN5K2NBtjTra2hTQl9ng=;
        b=FWx6+4T2ewYjn3VXPkSf6DHiTCVEXO6riUZlT6E+4iuxZC2JoHi/uHXfj8bo6huw2D
         0ib/kiWVbW9FW0UalAZcJhVcRRqga+0XoZRKfQQ3KCuwnDFeO8V1bQTQTEXvbVLX+Fb/
         grnZT37yanBfzQnlyNVL/zN2+UtriPaoyObzO8fr2bi/gk3WkOHBVZj8iaXj2epK3H+k
         OGp2rXFkcIHpn04vZfnUv+XhUrjtQPVVQcXgh/3+7viwgKXOFtOOuvNDIVc3UFbhkYBF
         wcgL17RJoDHNKNqdI5lCvtnbZtAFJqBZApcNNonw3wR4ZtSQbfBJTT/DU8qa7P7BrEWa
         IuzQ==
X-Gm-Message-State: APt69E0wEcIYp9uM8hl82CqMj7C+UPepZv+S9hS2FIfkcXjLmvS91cTM
        mChcJqcWcIIsrQ0MfMJ25M2DMtEXyiA=
X-Google-Smtp-Source: ADUXVKIwgQkKnUqfzzLCJk1ELh0L13YYQ9beOblajiYPwd132z3Ja7+hk/QVyYwQPRJyZ/bwL4lGSA==
X-Received: by 2002:a62:e401:: with SMTP id r1-v6mr2092542pfh.172.1528776970506;
        Mon, 11 Jun 2018 21:16:10 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id a11-v6sm103315474pgn.64.2018.06.11.21.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:16:09 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsnotify: add error handling for kmem_cache_create
Date:   Tue, 12 Jun 2018 12:16:04 +0800
Message-Id: <1528776964-39826-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmem_cache_create fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kmem_cache_create.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 fs/notify/dnotify/dnotify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 63a1ca4..216b411 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -387,6 +387,9 @@ static int __init dnotify_init(void)
 	dnotify_struct_cache = KMEM_CACHE(dnotify_struct, SLAB_PANIC);
 	dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC);
 
+	if (!dnotify_struct_cache || !dnotify_mark_cache)
+		return -ENOMEM;
+
 	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops);
 	if (IS_ERR(dnotify_group))
 		panic("unable to allocate fsnotify group for dnotify\n");
-- 
2.7.4

