Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C41AECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DF5208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdbZKufp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DF5208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeGNGRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:17:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47020 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeGNGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so5510309pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l32dPLtYO3WbvspdL6qjUP255oOR+zZC+SxzDkRVYaY=;
        b=UdbZKufpWia3f8HCL4Ez4+08ddCco9p76kqMlvGd/bwnc0TC3zXybTtdAp/JpntQvq
         i7EjKMlp7Z2hj452PGxUi5thrAOG9xvz0ltk2q6aKxvZEqy4ZmxXbNHUq+D8HTsV57py
         xvUYjExbsC8/5cWr65sA63NhWuK2BQxf6mJczzgirglaEa0ZeR6Hhv+gX/R+Iy0hc1hN
         uyMrzpRt+Q7T7K+dSuy4Ii5glFQFIRpPbryyuRjP6BfcoW1pByBn+BDgSF4tyW934/q5
         hu2IT3/T3JyNgRR9v4PyIUQm44yM2fTjv+wQtZFHu7iIUeC5koUxC7YP3r7Qv3DvSyTj
         BW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l32dPLtYO3WbvspdL6qjUP255oOR+zZC+SxzDkRVYaY=;
        b=lXrltvMn78oellRkqg72Rppgl/vwTPN3cDA3pGGvtFAlvvJ3+8yTQiLFxnN+rqf8Qa
         d8wN+rYEkYUk/0n6cgioZv3KTXRhGTJG3j7S6SjT3YEln+fGsbnWDr5N6fWsyR6hSnkv
         8goHkA8fqqjAeL3ZEREIQVNGTBAcGg21MsPmw1uv+7I3yj9Ws5aWDhqVWoYJpnfBPQho
         FviJli/rp9Z81sw+UdmT5eCWxbANyZ0iyUJoI06NSuTr/ZLwFyprI0FKg6I21EYo35uu
         FFIYjIyi5bU6zml3BEYJvr/1rhSGcWfb56td0CoyoxvRZldwPzHdoSgaljDlw8ncCY9s
         WwsA==
X-Gm-Message-State: AOUpUlF3jQyqzflaOJpHIY7WIyVrbwBHbXg8NMKxZ+3q3JBSkwbb7i8/
        ySDX63X9gxpNnDPBdI/7Rf4=
X-Google-Smtp-Source: AAOMgpepjabrsmEYyFihkuWNan0VPNQMrtKs2NNKM5Tas1/OlGpW/K0aCodexMqp5AaVI6xjUnDzlw==
X-Received: by 2002:a62:4dc5:: with SMTP id a188-v6mr9993092pfb.217.1531547938101;
        Fri, 13 Jul 2018 22:58:58 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:57 -0700 (PDT)
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
Subject: [PATCH 14/18] staging: gasket: fix class create bug handling
Date:   Fri, 13 Jul 2018 22:58:12 -0700
Message-Id: <20180714055816.223754-15-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

class_create() never returns NULL, and this driver should never return
PTR_ERR(NULL) anyway.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index f7d8f66e8746..0ef37667e0f1 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -341,7 +341,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	internal->class =
 		class_create(driver_desc->module, driver_desc->name);
 
-	if (IS_ERR_OR_NULL(internal->class)) {
+	if (IS_ERR(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
 		ret = PTR_ERR(internal->class);
-- 
2.18.0.203.gfac676dfb9-goog

