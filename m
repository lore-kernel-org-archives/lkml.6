Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC7CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2C42171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="eSyO6TqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfABLcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:32:33 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36076 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfABLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:32:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so25922727edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqeROWBc8NR4hPRRRZhBGhYhRi4kob3W/cJYEz0dpUs=;
        b=eSyO6TqCm0Ogj2C9sKsnETNxv1cjFXI2xMLQwcGvNU9yYiGOKeCzxTnJsq7ctiiNQX
         JqEWMkVieQmkT8NyKnha1ojFVMo9t0rv37rWBTct0ldlG7bS7EC2n2/9nmqGt98xQ9gX
         nSg+3ix1cu9+CUl6rPHQiEgHtSoEK/WTtgeOOthoHx0cthJx9HkAU6uYV0UXikrybWY/
         Lq94FYjYgw+uHqyvQFAMFlPw1toPh0hc7TiqtiKYHUHJIeRZSB0T9K1ektDESwWkB8JL
         jbEfk+6boGT8D5ZGHglIkT8LoxvEipbz1spB0v6/jipvJ26edU2ZM3CCAOUG/IWfWgkv
         h+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqeROWBc8NR4hPRRRZhBGhYhRi4kob3W/cJYEz0dpUs=;
        b=hHkHPJZwG+CiDomXxS8LG4d79g1uEc/LBhUHhNdOVwbQc/50+OPZ7QhxIMzPQH+6LI
         bqek5bZ6whjZ18pCELkrML/NJYQiTiw/SEDpf95zaX3BBhvTOkoTD2pXMOzBPwHb9qbs
         OeVfjQm3FKyGAzQEyW4+gJq/hgSDkPB1Fe5Jmims58BzVyq80r3Ynv+iJdFLzTxFgXNO
         Yid1VTxPNLAFwhBzBA5kZHRTFlQD1F6CHNiwuv+8rf/v/uhG7NuLUJPbd7zCB9XiidHo
         0MV0cmcIVovNHa4CpbsDpDkKbMnkgfDQmbzmTvPNjoF6w74gbxuo9IoU0VLMPIqGQ49K
         Ss6g==
X-Gm-Message-State: AA+aEWZHomy0Z0MjP5GpPvGW3mWVO9Iv3SV0hGgXCIohweia48maj4l9
        MolLbusa4q2LHj+hqhqFbv8J9Rc4HOY=
X-Google-Smtp-Source: AFSGD/VTaQHqE+kFW/RYBiym+jFReSatiFqjVStkN8wS6LnJWsEu2Qgw2xe4mu07Nxi8x+H0at24kQ==
X-Received: by 2002:aa7:d597:: with SMTP id r23mr39488022edq.51.1546428747665;
        Wed, 02 Jan 2019 03:32:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:700b:b2fa:de8a:175d])
        by smtp.gmail.com with ESMTPSA id a17-v6sm10690738ejr.55.2019.01.02.03.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 03:32:27 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, dan.carpenter@oracle.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 2/2] binderfs: reserve devices for initial mount
Date:   Wed,  2 Jan 2019 12:32:19 +0100
Message-Id: <20190102113219.3716-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190102113219.3716-1-christian@brauner.io>
References: <20190102113219.3716-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binderfs instance in the initial ipc namespace will always have a
reserve of 4 binder devices unless explicitly capped by specifying a lower
value via the "max" mount option.
This ensures when binder devices are removed (on accident or on purpose)
they can always be recreated without risking that all minor numbers have
already been used up.

Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v2:
- patch unchanged
v1:
- patch introduced
v0:
- patch not present
---
 drivers/android/binderfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 386e286f077f..8d54368b3c1a 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -40,6 +40,8 @@
 #define INODE_OFFSET 3
 #define INTSTRLEN 21
 #define BINDERFS_MAX_MINOR (1U << MINORBITS)
+/* Ensure that the initial ipc namespace always has devices available. */
+#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
 
 static struct vfsmount *binderfs_mnt;
 
@@ -129,11 +131,14 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	struct inode *inode = NULL;
 	struct super_block *sb = ref_inode->i_sb;
 	struct binderfs_info *info = sb->s_fs_info;
+	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
 
 	/* Reserve new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
 	if (++info->device_count <= info->mount_opts.max)
-		minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR,
+		minor = ida_alloc_max(&binderfs_minors,
+				      use_reserve ? BINDERFS_MAX_MINOR :
+						    BINDERFS_MAX_MINOR_CAPPED,
 				      GFP_KERNEL);
 	else
 		minor = -ENOSPC;
-- 
2.19.1

