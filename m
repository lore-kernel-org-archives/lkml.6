Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kSqABOxiHlu3WgAAmS7hNA
	; Mon, 11 Jun 2018 11:54:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E9C6A60792; Mon, 11 Jun 2018 11:54:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBiWNTWJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4FFC660351;
	Mon, 11 Jun 2018 11:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FFC660351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeFKLyR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:54:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46115 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933235AbeFKLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:37 -0400
Received: by mail-lf0-f67.google.com with SMTP id j13-v6so30073632lfb.13;
        Mon, 11 Jun 2018 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FVYK7brF4f+8IYpaSyR+AKXBScb7nBGjmMedpmZHJqc=;
        b=QBiWNTWJqrhS4nxbfWA6LeykeHDXaDSC5OUJElbFhadXvVUyWxG2ILbdKSbR3Qw0NZ
         DZbKQlvCr7x70tgfDpBqObK93bc85C2becQ3Z0knFVShUqMO6Exayx1ITOr53JE0mFNb
         /CsjgXvNaFFHCX2qNwZ9KU2We7rDH/U4/crb37vsBF1CO3N2ewigsFDxccrvdF23+jtr
         zHpFrPYVHqQGzKTnFc6ESw8JqCPXbL/jJNAWpWzecS+Ogn2F3e95Op9lMG01uU52MKtZ
         o7rDp1ezlQO8SfwsT/z2w733cxUk5pTpsnzL7QWhmWOeJTtCGae8pSLHP3WxsF6dJazf
         CMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FVYK7brF4f+8IYpaSyR+AKXBScb7nBGjmMedpmZHJqc=;
        b=gsrp6te+vUYxVoQNp41NVIMVSyaVujN9415ivfaH4dERNwCnXBJUrawxsUk4WxPDEp
         tn0o4ndYRdKQvIAwTWE2/hloLUG/+kYewGgGpajhepjRXui9G8jqSbgWTWXzP+5Olmio
         6N4+mSqClyyUV1AQas+0zQfTU3rvjp58idLKxk2qEERCyHjZtGxf97amDsjAA8hQ693n
         3k60b0dkXul5ewrjltIwUTd4tscqiTNmkqRd8G2UJ1oxxep6lI8cpVcVllPN4bkeRzhL
         nfaNZq9MeLymEDN6Hy9aD5N0bLsqzD3MUckQUDruvE4Xu9b8naB1iRFaG8HfA7wDJdHP
         5WQg==
X-Gm-Message-State: APt69E112vllkmb+f2gpm4hugjVWwylk0MUb3HV+vQnI5k6ZoO1bMnk8
        ZFoqXy+UadEpf6RbHCNeYPd+JT3W
X-Google-Smtp-Source: ADUXVKL5fUyfUE1j3XQz2+wb022giteonvOU+9fdnRRjD1LBS3u+HsOiTsGzitiOhzXudQcqCoax3A==
X-Received: by 2002:a2e:55cf:: with SMTP id g76-v6mr9166812lje.4.1528718015363;
        Mon, 11 Jun 2018 04:53:35 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:34 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 24/24] serdev: serdev_controller_add_probed_device
Date: Mon, 11 Jun 2018 13:52:40 +0200
Message-Id: <20180611115240.32606-25-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support adding probed devices by "platform" drivers.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 10 +++++-----
 include/linux/serdev.h    |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 06310110104a..e56a955d4ea9 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -630,8 +630,8 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 }
 #endif /* CONFIG_ACPI */
 
-#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
-static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
+int serdev_controller_add_probed_device(struct serdev_controller *ctrl,
+					const char *name)
 {
 	struct serdev_device *serdev;
 	int err;
@@ -640,7 +640,7 @@ static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
 	if (!serdev)
 		return -ENOMEM;
 
-	strcpy(serdev->modalias, "ttydev");
+	strcpy(serdev->modalias, name);
 
 	err = serdev_device_add(serdev);
 	if (err)
@@ -648,7 +648,7 @@ static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
 
 	return err;
 }
-#endif
+EXPORT_SYMBOL_GPL(serdev_controller_add_probed_device);
 
 /**
  * serdev_controller_add() - Add an serdev controller
@@ -678,7 +678,7 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 		goto out_dev_ok;
 
 #if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
-	ret_tty = serdev_controller_add_ttydev(ctrl);
+	ret_tty = serdev_controller_add_probed_device(ctrl, "ttydev");
 	if (!ret_tty)
 		goto out_dev_ok;
 #endif
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 1ef6e6503650..93f534a21ca9 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -184,6 +184,8 @@ int serdev_controller_add(struct serdev_controller *);
 void serdev_controller_remove(struct serdev_controller *);
 void serdev_put_controller(struct serdev_controller *ctrl);
 struct serdev_controller *serdev_get_controller(int nr);
+int serdev_controller_add_probed_device(struct serdev_controller *ctrl,
+					const char *name);
 
 static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl)
 {
-- 
2.17.1
