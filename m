Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E780208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfbe7ab2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E780208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeGNGQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41708 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeGNGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so4184188pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BrWKVTSWP35nfIfmRiFCqAiR1XL1rxa34t3vQmXlXu4=;
        b=Mfbe7ab2oDLiN6MQxuMJ1CZsIxxYmFwJJphtcyGUifEyCWKet3156jtr79vtLmyWki
         L644oE3pAifKDDI9mNEnqVMz/NnWj5te1y5cap7QdoIzJxAuKpyIa3EX9/IIZpr4VHgr
         xB9k/LrWCGdsWAr83KnX33vE9XLLv74Zk8HDh+GyUWNjLiDgxSSGiuWo4bm7pljTekdd
         w79gInudr7z+mb0TuZ2NCiDqcvPyaeWm5qZHquJKyJ3fVt9qoj2oXp0Pvwrb+iR1fqzz
         OSLkNN4A8+XTvv39LtXVtdOi80aQkplPKiYN9VDFSrJ+jC07KdrOwxR8phT5RixrBQM6
         xVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BrWKVTSWP35nfIfmRiFCqAiR1XL1rxa34t3vQmXlXu4=;
        b=nn2JutHMUHgmW9M3OHq7C9Zlh4NvaXKWm0JkbFZk4N0gEOJyEywEt+IovYYOEWI88d
         MItQ7t+tBWPnPVF49uol5ZVi/tD+OkJASSE3zvcJ8DHE3/D9WkEiyNqWFV9hD16dh6Be
         1aJydPZJTVSONKqPy4Vu3yS4ZWdfG/kBWhHtSw0XNmEMTS8OLvfaRgwbw+8wueId0UTj
         4lQSr7TXaGFHAGUq/6nSoAV0hTXR1MeeHTXqZ6KFcYUeRuOj/r9JNSO6Sern32J3MusX
         2I4hkZQcsmFWSKll+cTVDJq2bzyO7IIXWp503vOzuK2mqFkXNbly/hQsXhlpcpAFILoe
         Zlig==
X-Gm-Message-State: AOUpUlH/UU/zlodlFltNL4GWXRQWibIH/SV/w5/juJLb0/ZugRnjzIl3
        6TDeoqfj47iIATzQnX0wWIfQqpUQ
X-Google-Smtp-Source: AAOMgpfj9ZY/4my3VY2hAfdJqluaIHducmWeFGpabK1tB8IA59osmlcADLTIO7Y3eCmvEhbRLiH7Dw==
X-Received: by 2002:a63:5b0d:: with SMTP id p13-v6mr8700735pgb.202.1531547934060;
        Fri, 13 Jul 2018 22:58:54 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:53 -0700 (PDT)
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
Subject: [PATCH 10/18] staging: gasket: gasket_open use container_of()
Date:   Fri, 13 Jul 2018 22:58:08 -0700
Message-Id: <20180714055816.223754-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use container_of(), drop unnecessary NULL check.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index ffd6ce801313..0c45c54254fb 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1099,12 +1099,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	const struct gasket_driver_desc *driver_desc;
 	struct gasket_ownership *ownership;
 	char task_name[TASK_COMM_LEN];
-	struct gasket_cdev_info *dev_info = gasket_cdev_get_info(inode->i_cdev);
+	struct gasket_cdev_info *dev_info =
+	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
 
-	if (!dev_info) {
-		gasket_nodev_error("Unable to retrieve device data");
-		return -EINVAL;
-	}
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 	ownership = &dev_info->ownership;
-- 
2.18.0.203.gfac676dfb9-goog

