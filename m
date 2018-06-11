Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vkAYKaViHlvWVgAAmS7hNA
	; Mon, 11 Jun 2018 11:53:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A5472607A4; Mon, 11 Jun 2018 11:53:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kixDYZHG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 092DC601C3;
	Mon, 11 Jun 2018 11:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 092DC601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbeFKLxi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:38 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:42396 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbeFKLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:35 -0400
Received: by mail-lf0-f52.google.com with SMTP id v135-v6so30073563lfa.9;
        Mon, 11 Jun 2018 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Suyinsj+2DMcJEI8FsGWk1SnNxmOdY2jzBHLWvXZJ0g=;
        b=kixDYZHGRg4sczrgAUfqqfQhh+KlON4rmOrbmoIIKV80qRPKTQXjoz6TvYI5tnFqsG
         BlpShuv5TyvH9jKA4FJNCa/ZdlJiydYF8nDoKo65d1A7/PcDxr0CKIc4+I5WX3tAtweH
         yWGMR9cYSesKqLnLqZi7Quo2LLfCpfdbAwPR6+F9K5bxJK9FgZqK10eaeK/SuJ6VDSPV
         DlqL16o8X8Ttw1QGWFqFIXypvzOu4bDpHFAoZKX1IZ/wBMzB8DbMONTZbXQcbE70Z/O2
         he2eHZ6TvwRiDoY4xIVoJmFoHM5nUXIWC32CAs+Bm6PPjj+veerffPU3nL3TERz0GaAL
         lIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Suyinsj+2DMcJEI8FsGWk1SnNxmOdY2jzBHLWvXZJ0g=;
        b=hVaQO1GYJpX82iBdtK7lsyj+QUVgNV2a8d8TAoTJNf16rjbE1fvFur/8mIRmvD4vvK
         qju/yl3uOFRHaCRA98GU7+6ZZYW04QSuReS4K6cO1K5/Y2knKrWnDPCNrjaffq4/iSFk
         pdqRzKI5IvOdb/rkTdzjOApxOTHiernjD0dV4X2UB15j6quLGEX6ejgXBwvLsIDSG4vr
         yKJljvVhd7BbIgMlfIRbr57CRB3rAtFwlUNCAYfyyqf88nqf+0q6zPF1GTZeo+4ICR7l
         XYXA4m6mq1hhTo++1Gmlr6W8ZdUOg9L17mNvflhyTf67M5VAkWoITwe636pMJQi/+4Pr
         Cjyg==
X-Gm-Message-State: APt69E3SimrAgythCkarGt3d0pMCKUczxHyoQ2ToMhmu25uY17747tAe
        GdsBFGIp3+36sX50VXO3hurJtqcH
X-Google-Smtp-Source: ADUXVKIlQ+UVLibl4aCdlTg7mzUa3RzcWb0YM4rQHpesuKMcaffe65GsI+wweP8RgV0g8w4Kii0dYA==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr11109487ljh.1.1528718013720;
        Mon, 11 Jun 2018 04:53:33 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:32 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 23/24] serdev: get/put controller
Date: Mon, 11 Jun 2018 13:52:39 +0200
Message-Id: <20180611115240.32606-24-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow access serdev controllers by other drivers in a safe way.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 23 +++++++++++++++++++++++
 include/linux/serdev.h    |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 6b24b0a74fbf..06310110104a 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -724,6 +724,29 @@ void serdev_controller_remove(struct serdev_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(serdev_controller_remove);
 
+struct serdev_controller *serdev_get_controller(int nr)
+{
+	struct serdev_controller *ctrl;
+
+	ctrl = idr_find(&ctrl_idr, nr);
+	if (!ctrl)
+		return NULL;
+
+	get_device(&ctrl->dev);
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(serdev_get_controller);
+
+void serdev_put_controller(struct serdev_controller *ctrl)
+{
+	if (!ctrl)
+		return;
+
+	put_device(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(serdev_put_controller);
+
 /**
  * serdev_driver_register() - Register client driver with serdev core
  * @sdrv:	client driver to be associated with client-device.
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index bf282b3781b9..1ef6e6503650 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -182,6 +182,8 @@ void serdev_device_remove(struct serdev_device *);
 struct serdev_controller *serdev_controller_alloc(struct device *, size_t);
 int serdev_controller_add(struct serdev_controller *);
 void serdev_controller_remove(struct serdev_controller *);
+void serdev_put_controller(struct serdev_controller *ctrl);
+struct serdev_controller *serdev_get_controller(int nr);
 
 static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl)
 {
-- 
2.17.1
