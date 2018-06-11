Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Sw0SIbVjHluTYAAAmS7hNA
	; Mon, 11 Jun 2018 11:58:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A4F0607BB; Mon, 11 Jun 2018 11:58:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQIxJ2ee"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 065AD60351;
	Mon, 11 Jun 2018 11:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 065AD60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbeFKL6I (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:58:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45294 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933058AbeFKLxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:05 -0400
Received: by mail-lf0-f66.google.com with SMTP id n3-v6so30078657lfe.12;
        Mon, 11 Jun 2018 04:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y+5GKTpgMCdMxyRxlBxs6bjclVa+cCFGKAw3dcGnPl0=;
        b=dQIxJ2eeqbGd6GjDKjKk1aITeyJxzGmVVE1/nyBI4/mv44D4IEgUetdCVLl9XaQTN5
         z8dfIdhuKEmXnn9ifNEVnGo3BnlHmfcmRgObgJKkeDQenc14QlsH9IrT/iP1bgrmpYDx
         /VASPGdVRV+mnGanHze5ikzgE7x05GtZs0koN+mtqJn9HeaDut5ghtr05nZU1cIPns/+
         S8NfoHMGJULCfT/638gxOHNxYIGXM2altkh4+l8u1aWSU0j+Kr5CIcfLdL/vDKvIEy5D
         Jis1FEYGk5g75e1nYuzVCDWwKkwyyoiEVC3IUiIu8xVZCeTD0AGkmbIt75UM07eCmU/a
         uvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y+5GKTpgMCdMxyRxlBxs6bjclVa+cCFGKAw3dcGnPl0=;
        b=rkAddzqfnjkTHF9ACqrfMCyw3MlGb1t7AdQr2PRLoAeZQRdG2/2g19bjPaLI1BullH
         19N4pqehb716nQUHASX69K3QuRzQC3McGh2zTlG7eEyh0zdB0XpimY3oNirdSMbQ2YxM
         Eqc5tCGM63Xh9bzxaw1P3rr5yAU1ptvhocie82MKDgzHaozqOnixdhJRlexZAUuOISrJ
         KLmtaQzKq9n0zrfy9rMO+18694o0kwK/guV43/F1F6744dhmvkSiKtmsQsa3YxeoWBz+
         OiEzAW+pSahiq1lR3oTaB0y0XNgbc0TxwutLH1NUmBKJhR1zqk4bvrXj4Nd4MrFjVMgp
         5SNQ==
X-Gm-Message-State: APt69E2+0PPHXFVyGaitI0Nohk++8bEQWjtVyPE2taeJcwAlNmeXR955
        7xS4BKn/rJtWE4IFDoZwNwwyqWgI
X-Google-Smtp-Source: ADUXVKJBYD9n9DdETVruAeMJm2e2z8Pe/uxocQE3clzsMbByXizSzEkaowF3TGuYL2DxPC6+YQhH7Q==
X-Received: by 2002:a2e:5111:: with SMTP id f17-v6mr11261891ljb.16.1528717983291;
        Mon, 11 Jun 2018 04:53:03 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:02 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 06/24] serdev: Support bus matching with modalias field
Date: Mon, 11 Jun 2018 13:52:22 +0200
Message-Id: <20180611115240.32606-7-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match devices to drivers by their modalias when the ACPI and the OF
match fails.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index df93b727e984..2c79f47fc0db 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -79,8 +79,23 @@ static const struct device_type serdev_ctrl_type = {
 	.release	= serdev_ctrl_release,
 };
 
+static int serdev_match_id(const struct serdev_device_id *id,
+			   const struct serdev_device *sdev)
+{
+	while (id->name[0]) {
+		if (!strcmp(sdev->modalias, id->name))
+			return 1;
+		id++;
+	}
+
+	return 0;
+}
+
 static int serdev_device_match(struct device *dev, struct device_driver *drv)
 {
+	const struct serdev_device *sdev = to_serdev_device(dev);
+	const struct serdev_device_driver *sdrv = to_serdev_device_driver(drv);
+
 	if (!is_serdev_device(dev))
 		return 0;
 
@@ -88,7 +103,13 @@ static int serdev_device_match(struct device *dev, struct device_driver *drv)
 	if (acpi_driver_match_device(dev, drv))
 		return 1;
 
-	return of_driver_match_device(dev, drv);
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (sdrv->id_table)
+		return serdev_match_id(sdrv->id_table, sdev);
+
+	return strcmp(sdev->modalias, drv->name) == 0;
 }
 
 /**
-- 
2.17.1
