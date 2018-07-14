Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F964ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A658208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGcb2tkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A658208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeGNGQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37182 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeGNGQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id e9-v6so370590pgs.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9SQlgYSbuwlgfrkvTdMEs+Ge+wzrAL+/KdGEXLwJwEA=;
        b=fGcb2tkRuS9STwVNACf9q7LVKStUV5FNt+kGNIv5MexYHJH0Mi6RbmFnF08JHhZcoM
         6WSSuzbKBpCxIvpFcm2BBw4OubpDEq6FXXAhkbW2vFd6xzjBSI1faC0fODr/CacimYiR
         IkQmiRQppu0LXxNe2qUNsvfTA9zTwiy3OhnXfZmAxE13nC1Jg58H9pXtenvTq6joJsPd
         MyRCwi6DVdPQk8HHrpOIw+A1xg3LDvMoI2XCW/oID+caUYTwtdLaOYX0rhZAh6c3Qqk5
         jELyLobIWjh+qqXjmqSNVb01oNGxYyYeSvJp7I05SIcm3ZS8U+cYu7NWHHMbB9qFmhOm
         RMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9SQlgYSbuwlgfrkvTdMEs+Ge+wzrAL+/KdGEXLwJwEA=;
        b=MOoeSq7HYBAUFsXKUxYoOCjoA+56wvjzmJ8GcWFUY4h0ywP9O0/VZNuW9ZMVQm8oeo
         z0da8uL9w0yj1zPqiLDxi1DVZwQKsTePqIlHhdXmplGYxKvy3t7cd4YJB0nzxPh4bbWz
         8wlWOGxiWAs6TT4dSgRKUPLdBCQ5m62dE2lqX1URgEfunH/V9B6KtfgLqLW6CgHeRno7
         Nds30uT6VWJ4evXHmIq4ZcOLr9VIdo/3Udfn9f4jwlvbUPV3iuy4xiQ9pk84wNdSKWOC
         8hdvumHmxtXyil8ffNMBwGwfaXM/58/FLnqiqByGZDTdU5gZ4tCix/XWkD/ohs29z+EV
         4HAA==
X-Gm-Message-State: AOUpUlGk7Kk2t9pV3mTzeuB8XEtHxoN0pMEKxq2UbzmTYzhozrncaHYS
        gBGQS078jAb55632PlxfuOU=
X-Google-Smtp-Source: AAOMgpeq8VBcWTIWRidAhTkke+Bo0STktYFKwMALEsPDJc2zVJLbxrQdlfTgIvi725BdRocCcathwg==
X-Received: by 2002:a65:5a49:: with SMTP id z9-v6mr8563468pgs.244.1531547931234;
        Fri, 13 Jul 2018 22:58:51 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:50 -0700 (PDT)
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
Subject: [PATCH 07/18] staging: gasket: convert gasket_mmap_has_permissions to bool return
Date:   Fri, 13 Jul 2018 22:58:05 -0700
Message-Id: <20180714055816.223754-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_mmap_has_permissions() should return a boolean value.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 6d240dc59557..155c69446f0b 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1245,19 +1245,19 @@ static int gasket_release(struct inode *inode, struct file *file)
  * that the provided descriptor/range is of adequate size to hold the range to
  * be mapped.
  */
-static int gasket_mmap_has_permissions(
+static bool gasket_mmap_has_permissions(
 	struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
 	int bar_permissions)
 {
 	int requested_permissions;
 	/* Always allow sysadmin to access. */
 	if (capable(CAP_SYS_ADMIN))
-		return 1;
+		return true;
 
 	/* Never allow non-sysadmins to access to a dead device. */
 	if (gasket_dev->status != GASKET_STATUS_ALIVE) {
 		gasket_log_info(gasket_dev, "Device is dead.");
-		return 0;
+		return false;
 	}
 
 	/* Make sure that no wrong flags are set. */
@@ -1269,7 +1269,7 @@ static int gasket_mmap_has_permissions(
 			"Attempting to map a region with requested permissions "
 			"0x%x, but region has permissions 0x%x.",
 			requested_permissions, bar_permissions);
-		return 0;
+		return false;
 	}
 
 	/* Do not allow a non-owner to write. */
@@ -1279,10 +1279,10 @@ static int gasket_mmap_has_permissions(
 			gasket_dev,
 			"Attempting to mmap a region for write without owning "
 			"device.");
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /*
-- 
2.18.0.203.gfac676dfb9-goog

