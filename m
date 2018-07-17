Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1978DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C966C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlBYk+dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C966C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeGQVjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35697 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbeGQVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:41 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so992193plq.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qz80zVkuKpz7W0kC7mrhzKeZLZuO6eoQhjeHFCDfSd8=;
        b=hlBYk+djUsWIcSSP5jm/3N/tUvADnNh7A/rLsz7jrN9sjzfM2K7WFcLu7Q+FLEKU+1
         k8h2aUhrQ+lQdi5AI1k7Sk75BfUsqR2y3+h84sCi1g003rlDVHzZBc6sknTK+mQpB1S8
         cqbrD7uKda7f8fZkz0ZGMi/FDZfPejxuu1EcHn+6Y4QBk9LWNzINNnlXBOQIwiBMQtjL
         FBWPqZwnMOplg45mVtMAbmHfwx/aERKb98WX8qZHaHE3gUH7wG8n77rKq6N3mNXze7Kv
         Daylx7RR58102lpr7bsWYLrBwWnif3XYSvv4XR8KjyA/2QE04cGgd47zJrh6UjjaCrBP
         VTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qz80zVkuKpz7W0kC7mrhzKeZLZuO6eoQhjeHFCDfSd8=;
        b=uSnLKM9PgpGpKuKB+BtnNUto0YV0K3u8NMdEiDd24EHXHLcI5XZ3CJONjTEHFXc1gJ
         8Vj4zB3JJps3VQ1CbVwhzsowdWuK+kSjmNNDESKjl16PBtXe2LqaTRjAx6iVBthfVu3t
         kq5pL1lniRVzRs+p/kiqj7bCTyPL7SGwuCyj3SDMKOnnY13ay9c2NBbT6q2KKMnjMBPy
         xmyQ/GfZYmkYNwUwZinD2QnCslRodVo2F9GdbdA5nmCdkdesPl09J00QPfNIXSlekODS
         +DOJJGpdYQ/C3Foq0mSCMol0dTEjw/jg3YKWZOnhMqFRyr2b/01hJIyqWdPpFTYCQh/S
         GarQ==
X-Gm-Message-State: AOUpUlEF/CnZKfkBUOe2D7Q8wVvzcbWrYFo6zf1Y91Sfsia/WHkDdZYV
        m2SkuDwrN+XPgLGTcBebwSc=
X-Google-Smtp-Source: AAOMgpdOpLCkaspZ0mM2Xjn9t3BzHXV/OYRCuofZdQRvCj9Hrv/WaDpjz6EMjCuh6Sqph5l3FOzOag==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33-v6mr3147572pld.118.1531861514104;
        Tue, 17 Jul 2018 14:05:14 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:13 -0700 (PDT)
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
Subject: [PATCH 22/32] staging: gasket: don't treat no device reset callback as an error
Date:   Tue, 17 Jul 2018 13:57:02 -0700
Message-Id: <20180717205712.29495-23-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

It is not an error for a device to not have a reset callback registered.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index b7f34576d4b3f..09b3a3552ade0 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1840,11 +1840,8 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	const struct gasket_driver_desc *driver_desc;
 
 	driver_desc = gasket_dev->internal_desc->driver_desc;
-	if (!driver_desc->device_reset_cb) {
-		gasket_log_error(
-			gasket_dev, "No device reset callback was registered.");
-		return -EINVAL;
-	}
+	if (!driver_desc->device_reset_cb)
+		return 0;
 
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
-- 
2.18.0.203.gfac676dfb9-goog

