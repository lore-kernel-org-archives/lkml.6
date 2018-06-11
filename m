Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8IDVCapiHluoVwAAmS7hNA
	; Mon, 11 Jun 2018 11:53:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0679060850; Mon, 11 Jun 2018 11:53:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmeSkH4a"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6589560351;
	Mon, 11 Jun 2018 11:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6589560351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933129AbeFKLxL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41837 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeFKLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so30062966lfa.8;
        Mon, 11 Jun 2018 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3a7NfCPnIevWIbC4qU4vMXgbHo9T8sfI/vmK4xaIx5A=;
        b=rmeSkH4aRMK2lxlsvn2Zcrorq2SIKtVTV8QM8/zqJ6AUE/YzIcbftY/xjkkZQdEvgs
         x0aI8E9ppn/Lv19mhjnaBORxFnO1p0ZA80Jb5Nxfuk0djU+xU3EsNhtzRBgFO2sw4kbK
         X3jRaPtxINgCNzRGf90rKcKIhXHzQyIf4rGTMnwQJEBpiZonsgSHVgl2G11y2tyytplL
         CngXhAJQ6hCKZ9r6q83xK8tot91zZk6KLU9rXeDf1YUKEtwMR+qAicy5unq+S87lukSp
         nNSVmZSabj8qSKtKoyvYIGsjyxH+cIsOnmiLTOMa/AhE5KbxdjePEFSKykKY2NkzR8+P
         hB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3a7NfCPnIevWIbC4qU4vMXgbHo9T8sfI/vmK4xaIx5A=;
        b=H9iiMm2n5UBtJQfb7imV/42F2UKxptUeMJaT3ByDEL53w8Qu115J69f1qgKEkH+L+w
         JYmeyofD/bEYVJXxM2afZ9ZUWfXeINr1endhKNltPGKPGZQ5o7YqoNt0GTs/jjBXFEDd
         sxWA8t7q85VMxEv02RZZFEx+W6ZWFcVNCZm18E4a1LDzD5J8oxCiNDuz1UVZ6WU1agPQ
         cPrg7hJjteR5rJnPCj/ENY9Fcy7tm6pfLPd3U5EFDg45UncDgPHJ4i66MP2oE16Y79F9
         WkBX8svHDr6BfpoA3PnWXuZTfx6OHa44gX5V1tXQAc7gqRAR530WiFxJ63LWVVO/Yvkm
         2Hvw==
X-Gm-Message-State: APt69E0UdcrlS8u0AWKUgoNHog0gv93cMe5bwTNoedKfQiZgi7gS7sDC
        7oZNlYKz10mUYkXPSp+2jkoTsUSB
X-Google-Smtp-Source: ADUXVKKkHbSt0XV4QD2sgcKk3Ij9j+En8ZHHii/nfoPghds2V2fljJEUMCCBQ/66QCdcTBYwFx3Adg==
X-Received: by 2002:a2e:401b:: with SMTP id n27-v6mr11811887lja.6.1528717985269;
        Mon, 11 Jun 2018 04:53:05 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:03 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 07/24] serdev: Allows dynamic creation of devices via sysfs
Date: Mon, 11 Jun 2018 13:52:23 +0200
Message-Id: <20180611115240.32606-8-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow creating and deleting devices via sysfs. Devices created will be
matched to serdev drivers via modalias (the string provided by the user)
and deleted via their name. Eg:

 # Create device
root@qt5022:~# echo ttydev > /sys/bus/serial/devices/serial0/new_device

 # Delete device
root@qt5022:~#
	echo serial0-0 > /sys/bus/serial/devices/serial0/delete_device

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 69 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 2c79f47fc0db..5df01d8cf307 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -75,7 +75,76 @@ static void serdev_ctrl_release(struct device *dev)
 	kfree(ctrl);
 }
 
+static ssize_t
+new_device_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct serdev_controller *ctrl = to_serdev_controller(dev);
+	struct serdev_device *serdev;
+	char *nline;
+	int len;
+	int err;
+
+	serdev = serdev_device_alloc(ctrl);
+	if (!serdev)
+		return -ENOMEM;
+
+	nline = strchr(buf, '\n');
+	if (nline)
+		len = nline - buf;
+	else
+		len = strlen(buf);
+	len = min(SERDEV_NAME_SIZE - 1, len);
+
+	strncpy(serdev->modalias, buf, len);
+	serdev->modalias[len] = '\0';
+
+	err = serdev_device_add(serdev);
+	if (err) {
+		serdev_device_put(serdev);
+		return err;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t
+delete_device_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct serdev_controller *ctrl = to_serdev_controller(dev);
+	struct serdev_device *serdev = ctrl->serdev;
+	char *nline;
+	int len;
+
+	nline = strchr(buf, '\n');
+	if (nline)
+		len = nline - buf;
+	else
+		len = strlen(buf);
+	len = min(SERDEV_NAME_SIZE - 1, len);
+
+	if (!ctrl->serdev ||
+	    strncmp(dev_name(&serdev->dev), buf, len))
+		return -ENODEV;
+
+	serdev_device_remove(serdev);
+
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL,
+				  delete_device_store);
+
+static struct attribute *serdev_ctrl_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(serdev_ctrl);
+
 static const struct device_type serdev_ctrl_type = {
+	.groups		= serdev_ctrl_groups,
 	.release	= serdev_ctrl_release,
 };
 
-- 
2.17.1
