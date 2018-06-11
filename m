Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Rw0SIbVjHluTYAAAmS7hNA
	; Mon, 11 Jun 2018 11:57:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 86BE160792; Mon, 11 Jun 2018 11:57:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovUCe3ld"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 06369601C3;
	Mon, 11 Jun 2018 11:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06369601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933288AbeFKL5u (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:57:50 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38426 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933095AbeFKLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so30084576lfh.5;
        Mon, 11 Jun 2018 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/tVL8GHbt6YzIFcBgCmNQJSQkm00CCKS7j8Re6mrh5o=;
        b=ovUCe3ld0nR0SFJVdtm33uyWSFAJ0ceuaMwVTxu7WQxD+cPeKqGrMz+MghOBcPD/PE
         ugCq7uRIfYezZyG/cDcvTzltK4rFr9apsEHv5a0lFl4UA2KWyGISr7k0EkJa8VXFHq/5
         o1tgbH+lN1CWF3k8O+aLr1uzarw7m1jYcWUcQISm7iJAoWlMN1afcxxOsFt2/m5+Saj8
         2eqNjDdy/irLGC0S2AoQY6L37WrZ2mhJhPN91nqPK5g1KnnYHgVd/ajUltrt8PUHX32f
         CANLJDeVPlr7zTfIQzTcoYVjQt3onlR58fE+5Uh52tg4XHXbExAsZNFzPeqZVKfNYxYj
         USBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/tVL8GHbt6YzIFcBgCmNQJSQkm00CCKS7j8Re6mrh5o=;
        b=g8EyaFgRpYksn22mQEz/WguchhqHCcr3zO1jsobFj3nS9jI9FzY3kZpU2Gx9bX90hi
         PktL7REMjDa47vCj2sAtQkKkiqBUTZGCvrSN2PkV+/0IoW2CxozhKBiwUHlEjhIP40t9
         KO4rHdEO0szTQUF7YH6BaEpNA+vi3zVISGMPMvY+z23XqHvnlqlt1s1iaORpeJ3hQVpg
         u5nRjZoh7P+Dg/3x6qypEJuXLDRhUpmQCZvxr7sjSkW20qhnT/zjAJVA1GUa682sqGGa
         m3cWFhfOxYn4e0iCEcMT3jGuSSl2obcM4GsUJBUcQbp9s10NlHLspp1ElpZYcUuIceNv
         dU+Q==
X-Gm-Message-State: APt69E0Bg86mYb3RcKZQZb3a2/eAZHhWyK0yoYtHgyt+9JOL6KGTFNnb
        j/98h8XTDTMz9tiVcl9fkwwtWy4x
X-Google-Smtp-Source: ADUXVKJvT0BoJjcHLOghCyW6ra9a0Wh/4uLSaQUoGFgHvf3GiKcQy9bNbsfaDrc6XYezDJPMe89E+Q==
X-Received: by 2002:a19:8d15:: with SMTP id p21-v6mr9150449lfd.99.1528717987320;
        Mon, 11 Jun 2018 04:53:07 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:06 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 08/24] serdev: Provide modalias attribute for modalias devices
Date: Mon, 11 Jun 2018 13:52:24 +0200
Message-Id: <20180611115240.32606-9-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create modalias sysfs attribute for modalias devices.
This is required by modprobe/udev to autoload the serdev driver.

Eg:
root@qt5022:~# cat /sys/bus/serial/devices/serial1-0/modalias
serdev:ttydev

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 5df01d8cf307..b9bb0c0ee319 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -23,12 +23,17 @@ static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	int len;
+	struct serdev_device *serdev = to_serdev_device(dev);
 
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
-	return of_device_modalias(dev, buf, PAGE_SIZE);
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
+	return sprintf(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->modalias);
 }
 static DEVICE_ATTR_RO(modalias);
 
-- 
2.17.1
