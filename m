Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EB8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CEA2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Wh2HGGEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfBNXXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:23:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37723 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfBNXXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:23:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so3878709pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 15:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gi8084Kn3eEIKgMHpWvZVtQxWRoLiKu3wXvuwKoFSPM=;
        b=Wh2HGGEoC2qPhdE0mvBmKVFAD5gc0UomJU4jKb9jmPCTtTJsuVA+2q11clWYPvQYZm
         ghH+jhkLycg4NNkSFV8D+pFje5q1UhR73ti9LVEXFJBUBvb48eF5csPaNmmvJkVuWzsW
         +O6ju2yrWgIYvad4DI06JwLSiH/4GLXAl5HVzC5nMICEPy3GIU/NgW13ybQ0mkZDaJ/v
         yLsbh4a1viWqDwGTmqpnIdDYfx2pGfyDarMbSmfp7oBT18bN8OBaqM/PtdG+lApH+E0W
         bJgq5+nIoGaRGnzsDQqiNhOmMKMH3wMTGogf4vhTmQolkzpMma29S7uKZ4FY5FOB2MQ0
         wQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gi8084Kn3eEIKgMHpWvZVtQxWRoLiKu3wXvuwKoFSPM=;
        b=JYreZJXiGdO7TlqEx6mYM5YhNMA8Gpz/SVF8wWs3I66HcwBQZqulebrYNdVlgHKTHn
         mmz8gtTMnUs/c3hNtkgmJwlcVquriyNpQ/ipMcmbIxEl7wXrfXcyHGXZWtOzBX8uNP+K
         iosyCvdPzhmofv2hfN/R0nHkRfUvJZB7lvtEscK4GTAFEt9+Z5Pami3NqITkx3PdhYpP
         brnB0vnSPz0QjTI/vgeb2IrRhgoU65TKXr6ez7RXEvMkHiWFmmNVWwXjttqQdkLrMYEl
         gB9hAUCFZrCX6tDkQyeFZkYzKShaybnRhTWEt6MgcEr2ahzKAty7ahEtmSai+yEJ5/u9
         tVLw==
X-Gm-Message-State: AHQUAuZcQ3owanku3i8PFffPbo89Rcd03B2MIopGzyA6epeFvYYLA5Q7
        Wp6T9PZ6ACPnvzl8BQ9vYgkRHw==
X-Google-Smtp-Source: AHgI3IYFkyeW2txbGCwU5Go+KRObreEKmn9aNcoo9DTnZo6NX4CCg+dNwIlDpFHc5hpP1yhwyez5eA==
X-Received: by 2002:a63:61c9:: with SMTP id v192mr2436919pgb.120.1550186590066;
        Thu, 14 Feb 2019 15:23:10 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id k71sm8792680pga.44.2019.02.14.15.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 15:23:09 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com
Subject: [PATCH] binder: fix handling of misaligned binder object
Date:   Thu, 14 Feb 2019 15:22:57 -0800
Message-Id: <20190214232257.76856-1-tkjos@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes crash found by syzbot:
kernel BUG at drivers/android/binder_alloc.c:LINE! (2)

Reported-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com
Signed-off-by: Todd Kjos <tkjos@google.com>
---
Applies to linux-next

 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 2dba539eb792c..8685882da64cd 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2057,7 +2057,7 @@ static size_t binder_get_object(struct binder_proc *proc,
 	size_t object_size = 0;
 
 	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-	if (read_size < sizeof(*hdr))
+	if (read_size < sizeof(*hdr) || !IS_ALIGNED(offset, sizeof(u32)))
 		return 0;
 	binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
 				      offset, read_size);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

