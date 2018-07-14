Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16825ECDFB2
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6E208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZJif1Y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D6E208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeGNGQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42696 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeGNGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so5603236pgp.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gv/ttk0trQfJy55MpeX5eeNTfG0G7gNHcKCzMAUbWkg=;
        b=EZJif1Y5C56ShllWeVsvKlW+AaTWtTY3VxaJH+zd1qCtGboErUNF4BjMkd76hnmtYX
         o6LTPnKL2lJGJKBNrlQQ4wBMwAHAIq76XmYYOjC8T300OD7wG13U2zPMTRsGSsEiiatd
         2glKIRFSuInF7HVLjtVlTT3uCXsnWhOuvlew8bZrPmWZXlI/MpA64Kymq+Rzxd5RIsxk
         DHeo3NUnU4eS230Q6IMY4QY1vfbVUKX+yJCOY+r6sfUr2NTnWKKVVqwTjZ0hG4FHnTpe
         +kTTkr2agNSAssVkcxdS+KktfEFhqIuaKdAVtjC0DB8H+IXq1qe6h2tYXgb2+WAQs4xs
         rkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gv/ttk0trQfJy55MpeX5eeNTfG0G7gNHcKCzMAUbWkg=;
        b=TYkP7Go3iL2hBYjlhbm0rDjDpxNi40k7FZYZiJ9QojYucQMHyMLyj3eVT+9Nkrkbjy
         3ZFCF+eMLeDJVTFdgrTzShjf9rWyiqw1vFTFvY6hMwA6fO5TBq5TyUxbJi3djdp3b91B
         taqfUSXzB/xhcOabqUl038E0K9wueeeUS6WymbrKz67whyLOMDao/iYcszgGH/9ABE8w
         +MVSJvXusqbA+czDT5/Np6dutSdiUUKUXHu7hYqO0Ag28SCRh3/JQwSIohbEf/POa7cS
         5byvL5msGPDFVAncEBWRY4N9MOzfI+0EvPx0eekyUVmiEQWyH28/kn0z/5SL4diGpMNG
         Yrxg==
X-Gm-Message-State: AOUpUlE4bwTnzcta11SXf4csR8l2WmH9jdu4/dL6x6Q0yCyffi71Z0TZ
        KzLBXI5/NT8oXXhsKQVeSHI3xWS2
X-Google-Smtp-Source: AAOMgpcKu13C1TfvIhTxvLpH+TxZYaAjEmMGFyFXxrmt75Z/9/Wgh7SZcmBtA69tqMwfpnSrQ1N9rQ==
X-Received: by 2002:a63:175b:: with SMTP id 27-v6mr8488284pgx.31.1531547928490;
        Fri, 13 Jul 2018 22:58:48 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:47 -0700 (PDT)
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
Subject: [PATCH 04/18] staging: gasket: device registration error and unregister fixups
Date:   Fri, 13 Jul 2018 22:58:02 -0700
Message-Id: <20180714055816.223754-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove device registration on class creation fail.

Hold mutex around device removal updates for proper ordering of
updates.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 45914ebc8f44..3bdf7d36b397 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -342,7 +342,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	if (IS_ERR_OR_NULL(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
-		return PTR_ERR(internal->class);
+		ret = PTR_ERR(internal->class);
+		goto fail0;
 	}
 
 	/*
@@ -376,7 +377,10 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 fail1:
 	class_destroy(internal->class);
 
+fail0:
+	mutex_lock(&g_mutex);
 	g_descs[desc_idx].driver_desc = NULL;
+	mutex_unlock(&g_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(gasket_register_device);
@@ -413,7 +417,9 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	class_destroy(internal_desc->class);
 
 	/* Finally, effectively "remove" the driver. */
+	mutex_lock(&g_mutex);
 	g_descs[desc_idx].driver_desc = NULL;
+	mutex_unlock(&g_mutex);
 
 	gasket_nodev_info("removed %s driver", driver_desc->name);
 }
-- 
2.18.0.203.gfac676dfb9-goog

