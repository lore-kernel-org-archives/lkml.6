Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF30DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAAD206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmH84o/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAAD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbeGQVjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:48 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36368 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbeGQVjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so989265plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=punzKOgQJWZXZO1PYnLV+M4OJnrd5Skxgl0DZ0aQtI8=;
        b=qmH84o/WQfjeSFguj9F3CfraZwPN00DKpQ5BKnhrp7kyuri+tK9zRHNJ+0i8y0ihgD
         bQQwwc8J6cm1cdhRaYan9nsY2FD80SDD9dWVNiDeO2lqjDbN2hbvUZD/P9Dne+L5XjL+
         LHg7LDHclCLc219adr9ucvxQYSeR9pkWcWe/RIyUC+IHhO1/uaguW4GxQhQX2RTM1NaV
         UR+TRXk35Qz9eexVVq+L2f00ZhVG1Rw1+3YKL5gFcicZDI4PJ/XeoGu+z9cldJCiqlUt
         yPHo6m8fUHZcpD8Eyc6CbUiiZBAff+/Bggi2vxjBnEj0o8RBaUbKXTw05rcpYan2Gxvb
         ab8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=punzKOgQJWZXZO1PYnLV+M4OJnrd5Skxgl0DZ0aQtI8=;
        b=ng7gqZSuV/dSpKcsdt0GYm4/gnwYqEz0lpZtCRUZQ9Zsq0ayHsmEAbXnAVnwMaaj0x
         cCm4BVlat3VBET3uvM+498j/noOT5ENuJ4KW5uD1MoRUBL2UUUzENDIU/JyxWZuTS7F7
         qbnfgmdiQIR3fP3jO7A4l9ao4RSGfhaB9beFQynWWydZWXAP+12NIFYkZ+NqZvFhqcVI
         tAH8JFM4rdg2LEaLSWbPhyreVp2ZHPH/y3jXLegveKgnGO2tpIU5x/qSqk+iHJoz8BYf
         f7EpH9obrssZh553faq2l8gAiGHkc3I+VTh6KPoqiPS64X5gdHFWiBe5Ebh8IyjKcd8Z
         vq4Q==
X-Gm-Message-State: AOUpUlGCIg09kzOuE1mZLnXXcpmKLS51wubhEPBSj66MU4uNhlNwfDdi
        zM9LzNO9/oSzambjyKCOGs8=
X-Google-Smtp-Source: AAOMgpfQie1wVI5+H+TRXXZIfdG6FzZZr5+GMagKEmvDXeDJm6NR5oXXPAGiBK9b5gD6wkvDAoyNug==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr3078769plb.274.1531861519497;
        Tue, 17 Jul 2018 14:05:19 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:18 -0700 (PDT)
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
Subject: [PATCH 25/32] staging: gasket: apex_ioctl_check_permissions use bool return type
Date:   Tue, 17 Jul 2018 13:57:05 -0700
Message-Id: <20180717205712.29495-26-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Convert from int return to bool.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 6953b3b35ab50..a1113c9faee9b 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -141,7 +141,7 @@ static int apex_reset(struct gasket_dev *gasket_dev, uint type);
 
 static int apex_get_status(struct gasket_dev *gasket_dev);
 
-static uint apex_ioctl_check_permissions(struct file *file, uint cmd);
+static bool apex_ioctl_check_permissions(struct file *file, uint cmd);
 
 static long apex_ioctl(struct file *file, uint cmd, void __user *arg);
 
@@ -626,9 +626,9 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
  * @file: File pointer from ioctl.
  * @cmd: ioctl command.
  *
- * Returns 1 if the current user may execute this ioctl, and 0 otherwise.
+ * Returns true if the current user may execute this ioctl, and false otherwise.
  */
-static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
+static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
 {
 	return !!(filp->f_mode & FMODE_WRITE);
 }
-- 
2.18.0.203.gfac676dfb9-goog

