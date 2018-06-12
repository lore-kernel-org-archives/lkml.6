Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 417C5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDF720693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzNB/PWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDF720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeFLETm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:19:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40349 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeFLETk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:19:40 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so13577580plo.7;
        Mon, 11 Jun 2018 21:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F+GFV2KjdqB0bR40IfmTpZtntOLDxZbv1eGUZATGvUQ=;
        b=tzNB/PWK+sqmOwMAXvDTIH0IZyEcQV6JZazPi+1yATccYhqAyOdFOHtwCxm5q4ALZy
         k23Pp/3tMQZ5nMsbo6gi9d/xUkPiFBzihOAEYqNFGDrYr4EQ8gFHWdLJSJzTB+a5Ug6x
         gYfPKxOMvd+OTGdjnTLEvBeZvd7Pqx7QRco4B2Bp9aghZ7LBsRhNEsboSyhBHC0D7qj2
         TtHdDrfQKLU6mE0svvl2VmElHipep8k2k9wUgrm1jq+cTH1c2q1Oo81B1l8/ThGn3Ajb
         9TBiHq5XpovSNpThK9uCxGNHPdadMfQ8pwrbqC5IwLtB5n8ECA7tOJwaSNEFkpQpkDFH
         GYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F+GFV2KjdqB0bR40IfmTpZtntOLDxZbv1eGUZATGvUQ=;
        b=Djqo8LFZysIxkUB/ELzSr3NAwyr5IW4G0Z7ubr51GPfGxPQQAyTc+qI4z+AZ6jI/PQ
         O1lTmgqyWNq2zJimJMRDjd/4atzHz7yAtxxlOshp7YKzMQtn5bjCUUImIxe+gNj0IQBi
         b8/jlb8wiIPaUjg6sjC8UgRoUc7/Lek+AwMDF9VtCz0aNVFf6dmSOS3BCAD1GMxpK0qK
         6fsUG8knRPCTm9mIn/3vDmqnFJjIhpa9/i0Wh0HkZsQZxrC693mHjpqsYtF2sC48mAeK
         uI67FKnF472qoLB8lbHku9lrj+w8Kd0D9v8eklvSieezI9PZbKOkZyt3re+jxb+p4m2w
         vwQQ==
X-Gm-Message-State: APt69E3PldcNq46HP//s5ov8BEHlvFGcglo1EeCjoSPBfBCkfxF5YW82
        FPPJHxVgtbspXLvIExOXKBk=
X-Google-Smtp-Source: ADUXVKIQwD/vLkhjnsZKGOJ6jB1ZX9aS7A9JajMM9GzDquqB+wP15ObjUMICSZtFjvGUtg3mv7xRuw==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12-v6mr2150507plk.159.1528777180237;
        Mon, 11 Jun 2018 21:19:40 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id o77-v6sm84856375pfj.0.2018.06.11.21.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:19:39 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fanotify: add error handling for kmem_cache_create
Date:   Tue, 12 Jun 2018 12:19:34 +0800
Message-Id: <1528777174-40045-1-git-send-email-jiazhouyang09@gmail.com>
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
 fs/notify/fanotify/fanotify_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ec4d8c5..e3fa861 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -959,9 +959,14 @@ static int __init fanotify_user_setup(void)
 {
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark, SLAB_PANIC);
 	fanotify_event_cachep = KMEM_CACHE(fanotify_event_info, SLAB_PANIC);
+	if (!fanotify_mark_cache || !fanotify_event_cachep)
+		return -ENOMEM;
+
 	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
 		fanotify_perm_event_cachep =
 			KMEM_CACHE(fanotify_perm_event_info, SLAB_PANIC);
+		if (!fanotify_perm_event_cachep)
+			return -ENOMEM;
 	}
 
 	return 0;
-- 
2.7.4

