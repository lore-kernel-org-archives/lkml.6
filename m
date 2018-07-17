Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DA5208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnVmdscT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DA5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGQCj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:39:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43714 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeGQCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:39:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id j26-v6so2720681pfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NsJu31Pyh6ZIXnDksma3UqLSJIlfinMap707CLDYB9E=;
        b=VnVmdscTbW5r4ddxX+H0I+EEa/kYNetWJH9ERvaitYFUinwS4PUlqJhfHm0nclUeqR
         7kPzrBPYI4hS63E9aLOXNJHBb7m4p3dIJ7jJv5PvNb3uuYSub5YzhHwSFM73O+PguK7k
         j9TljoGSKKNu4gY2qG/JKBdFvFfWT84RaUYwyTzoBLCbZVO2o+9bICav/UkWQJL6Tfew
         J9RLyE/dK5BKspsDQCQJHJqt9gRUVe/A7oOmtp3FE1tHYp1DsdZl0Jbod2q24ZD8AfU2
         mq3k8HT+tHGkFmhg/OSywuFdT63AKiVT+a6CVG2sIsvyp/JXDObObJT9K692qe1mwQ2J
         TAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NsJu31Pyh6ZIXnDksma3UqLSJIlfinMap707CLDYB9E=;
        b=o9ezjRSmUp9B9+8MTq+8W1E+a1W3ChMXZiVWxeXSFlnFBSqCrfC0EdRwstRHVFMYy5
         +Nwpnl9W93RvemxjgiVnPJCmtCbsGTIIG4CwM/VkgyPpYCsmwQRyuM2Y6QOGegKSCHiN
         VvHStKBD7/b4Fk34MHE7hCT+UvywxDO3SJIglkZkv6UJrZu6LJx5DSVQILgs/Yzr9mYM
         WmvJbFAzVCNM6xbHxX+gnKA1Yvbj2IVa1zF+297DMDokZvqoXsxS7NtLnEd4USzK8SKO
         MOU2s+eOe0Fw+Jd2ofX8E8A/YYkiMrWvqH0MH+XYu3gvwONZIkOit9SD9asDfgYRaCtm
         LLGg==
X-Gm-Message-State: AOUpUlH5qBNTYh3CJQffdM1y9pcZVIn4u6TdhzfPvMhqgw3LQFSHC0ui
        gPfnGG3dQQdHmHDKEG5ZtFs=
X-Google-Smtp-Source: AAOMgpcyLHt/Pu4nIzJIe1gOE5c3RCZ1Hfo93bL2sMAONC3rxnK6wAHiAfhuxZbRBeFeOZR87mxxUw==
X-Received: by 2002:a63:24c:: with SMTP id 73-v6mr17943918pgc.252.1531793385222;
        Mon, 16 Jul 2018 19:09:45 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:44 -0700 (PDT)
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
Subject: [PATCH 02/32] staging: gasket: fix typo in apex_enter_reset
Date:   Mon, 16 Jul 2018 19:08:56 -0700
Message-Id: <20180717020926.176408-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Fix typo in log message.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index cca4cf491a583..a31937dfff836 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -488,7 +488,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 					APEX_BAR2_REG_USER_HIB_DMA_PAUSED, 1, 1,
 					APEX_RESET_DELAY, APEX_RESET_RETRY)) {
 		gasket_log_error(gasket_dev,
-				 "DMAs did not quiece within timeout (%d ms)",
+				 "DMAs did not quiesce within timeout (%d ms)",
 				 APEX_RESET_RETRY * APEX_RESET_DELAY);
 		return -EINVAL;
 	}
-- 
2.18.0.203.gfac676dfb9-goog

