Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD08ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D732077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY/16HS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D732077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbeGQVjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36334 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so988709plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NsJu31Pyh6ZIXnDksma3UqLSJIlfinMap707CLDYB9E=;
        b=WY/16HS/YTjAUhc+srr9ZpT4PrncHH+ZDJ4oYwhKyfJrhDa/d6ZMg9I5sPKTPNI3zF
         F3953oQoW31vgeSuYXkfTvoTCzel8aB6uuhtKljASQJvSIXEn2QnMQHwUwZGPkzfRKMe
         6j/MOU/UZXZxplL55OtH1HxiG1R8/7cKwkEBhSCjRXQTnei6We6yaJCowvLyYeYBlndA
         f8DFqmDOov1lvXXR1Z49ndNzJJdC/X4ewGekk47PZQoRfKB22vcI/c3R1ZQntmKfyGOP
         DsLPWtAeCet/zZW2qeUFjwEqt3J3RcPaRomQzAZfIHMnz4IwMCvEhTlR2uSEk7g+S1Te
         vexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NsJu31Pyh6ZIXnDksma3UqLSJIlfinMap707CLDYB9E=;
        b=ctcoMFb5qufG5bUB3/nrHapMy7EN5ZboUmCU1W1leNC4uQCgabAwKAqpxkZxpYcTbJ
         Oc1uQFejBGT4qndd5N9RoCDIGLElmw2T6EEruByCT/mRFfe0QBZLDFlRlpE8m7pzhUyD
         6KaZJlQFpNY7Ohj5Lp0Q5tGrsLclkR8T3XZMtECVQgY3p1reP3WRsNU7r2OKPiM+RrNK
         /VapxwH069bFUT7I4oXJ1SSqw7asuTVVuMmYwsg2GRTDwZWkp/x7Ha1hCYbY3//P+8IN
         ywL6fO6J3quzh0JBCSabZtv6guebt/c/lfrDKiAAwslT1ob+UWRAV7ktowWq9W4FnY+m
         8O9w==
X-Gm-Message-State: AOUpUlG8RFVMpF54DL2j+Fd3/gBaWhjTY8pfCC6TiF9f8d5TVW3nddFP
        olac22kBTA+GENIgPydZknrHwRuy
X-Google-Smtp-Source: AAOMgpezTNtuwP1rxxf9AtVCwWhVRYTMSmfV6FIU0SzIh8599VGrUi4kWmx/vUSdV2PEeTWkWOUz9A==
X-Received: by 2002:a17:902:381:: with SMTP id d1-v6mr3110048pld.309.1531861487095;
        Tue, 17 Jul 2018 14:04:47 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:46 -0700 (PDT)
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
Date:   Tue, 17 Jul 2018 13:56:42 -0700
Message-Id: <20180717205712.29495-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
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

