Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KckeA7NiHlviVwAAmS7hNA
	; Mon, 11 Jun 2018 11:53:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E7BA1607A4; Mon, 11 Jun 2018 11:53:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLSiZxnu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5FFDF601C3;
	Mon, 11 Jun 2018 11:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FFDF601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeFKLxS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:18 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44599 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933096AbeFKLxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:11 -0400
Received: by mail-lf0-f65.google.com with SMTP id 36-v6so30057620lfr.11;
        Mon, 11 Jun 2018 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6kY9iPXwrCpJV3OkX3TsAhO1ij+vSNHGyg8hj/QEdR8=;
        b=ZLSiZxnuxE+wd5wgFlIPmpGay+FmNYP0lqbY8hV1qeO3SBnCGZit67BDAfLI3NfLIR
         W+CvT0UfhbNPFMmkNakKv2gCUP5TNCj62s7XUaJCwKPlICN2JqLsTaDhpLCnWs2sg5Bw
         Hwwle0NSTmEd2RhUbIFLtjzaWOKWNtsex9y/yRRoqXC+VO3zmv5LvpULN1/GMvpF4psR
         Frro8qqbF13w08pRtbuBPMQ2/7PD4Qz2Ur7gAfw0XUvGX5gLSPW5/N/+5lCNMwVRIQUm
         /Wf91Y67UBYkky6ki+f+ziZea5HzEce8RWFtESVVPKwshBIQGrcY0fDxi6NCgT7cY2w1
         DjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6kY9iPXwrCpJV3OkX3TsAhO1ij+vSNHGyg8hj/QEdR8=;
        b=OHzsMSTMae3QWkYbZ44OlRv0FG93XaH3m1pYRrdqwnK3+gKAKWeR5pnMViqfjF42Ly
         3VP8ZA/uZfaCBj0sAQLRHTD4U9mxhHTgE7Qkxmw5ElUDTjbga87o13W4U8YqlRv3etfh
         64gVwsfrMg3i9+XdkNs0yWYX8kzwGy0YcohG6W5btGAwG5C9ZcBxIqCRGE8mDmLJJzR+
         GyjjIcqIqNNmZ/pBXpS9XGkMIQWCtH0TZuGo82CGw+VmEUjEhVDRwjaD24dlpbCIF4Ac
         uPOTJaMCwX+Ly8+ZDTxWOemiggXVbXpmFrOfdr8ho6X9McaY6nljbGv67wRiLxKGf0dr
         4x2Q==
X-Gm-Message-State: APt69E3ML9mS7l91f3DYgoNfBxxlXit33vV1x8j2F5uorICqkVapnc4v
        ORgrymm8BcfSvu7iPanHwBLzGie1
X-Google-Smtp-Source: ADUXVKLeo9FsKGBMvGbsgS9jvB/12PWBlTk+A/zFykucnOwqn4x8QuJhIj9c26pX7hkDZvvQV8+jIw==
X-Received: by 2002:a19:f611:: with SMTP id x17-v6mr10498982lfe.116.1528717989123;
        Mon, 11 Jun 2018 04:53:09 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:07 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 09/24] serdev: Provide modalias uevent for modalias devices
Date: Mon, 11 Jun 2018 13:52:25 +0200
Message-Id: <20180611115240.32606-10-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the sysfs uevent for modalias devices. This is required by newer
versions of udev for autoload modules.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index b9bb0c0ee319..584cb994213a 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -46,6 +46,7 @@ ATTRIBUTE_GROUPS(serdev_device);
 static int serdev_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	int rc;
+	struct serdev_device *serdev = to_serdev_device(dev);
 
 	/* TODO: platform modalias */
 
@@ -53,7 +54,11 @@ static int serdev_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (rc != -ENODEV)
 		return rc;
 
-	return of_device_uevent_modalias(dev, env);
+	if (rc != of_device_uevent_modalias(dev, env))
+		return rc;
+
+	return add_uevent_var(env, "MODALIAS=%s%s", SERDEV_MODULE_PREFIX,
+						    serdev->modalias);
 }
 
 static void serdev_device_release(struct device *dev)
-- 
2.17.1
