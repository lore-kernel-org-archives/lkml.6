Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PsEbBthiHlukWgAAmS7hNA
	; Mon, 11 Jun 2018 11:55:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4C25C607BB; Mon, 11 Jun 2018 11:55:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPD3aETW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A927160792;
	Mon, 11 Jun 2018 11:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A927160792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeFKLzB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:55:01 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41893 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933180AbeFKLx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:28 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so30064521lfa.8;
        Mon, 11 Jun 2018 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+iTzy6GxF7nlLzaK9mrGK0H7l/tRnY/YuNETVtzJqwM=;
        b=uPD3aETWiVInccKaSk7/m3KwlvINA1Vw6Xvf4++5sOW6xJVAF9Yywk2A7PW8bac5G8
         t9c6XfJ6QeRdRV9wAaIt8W/MjnX6IaCAaZ+708CsNx4X3fdTr8GSKGUUtAKP+cqVZ66u
         V7uB1I3OSGOy8pq7wJQrUsxeKdFXkhiQrRZmLmFhyRZ/3bFViVtXBmQKt2teQn5p7/W0
         dDus5e6MAykEUhvH04Ghx3hb9Ci02FOFO70HcLHyQxswQZSFLW7YqXr4EWDn9Jt4eZNs
         JO3bcm8TTk0wuObZII9RUWPDaWxbVErpqqdZ4MhImnGnkAFS1DXjHtP5vXevghlfjThB
         gKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+iTzy6GxF7nlLzaK9mrGK0H7l/tRnY/YuNETVtzJqwM=;
        b=W0D7aZWWHBQl/Ke80IjAYgbhxPBA+/KmI2v+JCCA1dBgjAHTNR3v97dpPPpDUZdHF5
         n6kIc1wmyausBK6GoSiy2G6RdCTXyDCIsczwleF9oCaR7ZzcHFFQfks6p2UNqzVRWn1L
         lVdHQFjR13UaGf7yvmu4ZH2jm1CwDTDsxfrCc+ZjMHn1LiVafdJO0J18ZwyxMQJjnnxt
         WNZOO0Wia8rU/w/ZYo2nwLkObebKxpZ+/nA8ybXDcCe+4xDROx8JGweh/gm0iivfTy/J
         n82eHvBc8U5P5HLudhYJ4f3daXG5rccA9iNbTokRZJ2EXk3jJqrZzExqqLtlSG7Nygf8
         +GVQ==
X-Gm-Message-State: APt69E1g+zmZH2motj2PdOW6OhcX4vITb9wtrI17cBzRCi0H2u+5C7EX
        aUTD7zIPZ8D3PV7UTR7JVkxXuSDX
X-Google-Smtp-Source: ADUXVKLMD1t12GHIUBUXB6nkk38Im91eSGWzR1K4LboB4gWLFdW710x9OiF74BikAJ88cOXkIWg9JA==
X-Received: by 2002:a19:1099:: with SMTP id 25-v6mr9908292lfq.112.1528718006903;
        Mon, 11 Jun 2018 04:53:26 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:25 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 19/24] serdev: Instantiate a ttydev serdev if acpi and of fails
Date: Mon, 11 Jun 2018 13:52:35 +0200
Message-Id: <20180611115240.32606-20-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a serdev ttyport controller does not have an acpi nor an of child,
create a ttydev as a child of that controller.

Doing this allows the removal, addition and replacement of ttydev devices
at runtime.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 49 ++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 584cb994213a..587d2796b3d5 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -628,6 +628,26 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 }
 #endif /* CONFIG_ACPI */
 
+#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
+static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
+{
+	struct serdev_device *serdev;
+	int err;
+
+	serdev = serdev_device_alloc(ctrl);
+	if (!serdev)
+		return -ENOMEM;
+
+	strcpy(serdev->modalias, "ttydev");
+
+	err = serdev_device_add(serdev);
+	if (err)
+		serdev_device_put(serdev);
+
+	return err;
+}
+#endif
+
 /**
  * serdev_controller_add() - Add an serdev controller
  * @ctrl:	controller to be registered.
@@ -637,7 +657,7 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
  */
 int serdev_controller_add(struct serdev_controller *ctrl)
 {
-	int ret_of, ret_acpi, ret;
+	int ret_of, ret_acpi, ret, ret_tty = -ENODEV;
 
 	/* Can't register until after driver model init */
 	if (WARN_ON(!is_registered))
@@ -648,21 +668,28 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 		return ret;
 
 	ret_of = of_serdev_register_devices(ctrl);
+	if (!ret_of)
+		goto out_dev_ok;
+
 	ret_acpi = acpi_serdev_register_devices(ctrl);
-	if (ret_of && ret_acpi) {
-		dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
-			ret_of, ret_acpi);
-		ret = -ENODEV;
-		goto out_dev_del;
-	}
+	if (!ret_acpi)
+		goto out_dev_ok;
+
+#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
+	ret_tty = serdev_controller_add_ttydev(ctrl);
+	if (!ret_tty)
+		goto out_dev_ok;
+#endif
 
+	dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d tty:%d\n",
+		ret_of, ret_acpi, ret_tty);
+	device_del(&ctrl->dev);
+	return -ENODEV;
+
+out_dev_ok:
 	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
 		ctrl->nr, &ctrl->dev);
 	return 0;
-
-out_dev_del:
-	device_del(&ctrl->dev);
-	return ret;
 };
 EXPORT_SYMBOL_GPL(serdev_controller_add);
 
-- 
2.17.1
