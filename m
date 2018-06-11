Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yo2pN1hjHltvWgAAmS7hNA
	; Mon, 11 Jun 2018 11:57:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9A0EE607A4; Mon, 11 Jun 2018 11:57:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2LKF4Ys"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 12A2F60351;
	Mon, 11 Jun 2018 11:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12A2F60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbeFKL5G (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:57:06 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43496 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFKLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so30069819lfn.10;
        Mon, 11 Jun 2018 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G0yQFClwEcblIZB8wuKheaU/5e+e9n0CQyeJsCaU38w=;
        b=a2LKF4YsGOyFzcE5jt1edNQeswxiTnFcaaPS3Y1Oz46svKsn9nk61cBAzX3OMbij59
         JH2WPLKr8rHu4oX+OJUQYgVXFKTa7eYY1spOtJOsDHyfaYGFYqhocuTgT0yjOPfJQAnb
         MrCb9bR799xmjVXDaJrbdATrAbenXx/2fpqk2OJ4LkiLftY62y+bR/+Jva+zeOwLq371
         4T877TZLGdPC7epKMxKcPX3ahRkBus4La6szT00R6oA8NW5FM+K7eB/X22p1bLz+2bOz
         0rB0MbC74hUZ0gl/JmXN3ykKaJpZ7//uMDCLU8/LBGT5dyeRdGA+JKSKr0FT8v444W56
         JWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G0yQFClwEcblIZB8wuKheaU/5e+e9n0CQyeJsCaU38w=;
        b=DZWIfF2rA8sYzZw2HsYuqwiR7ojnFP+clEoUSksuzVmrzS2FR5FX7zipUPBBcE1e8K
         qmVRJxvrVsvhl1LB2rdWp0tDZu1C/dfUzWXuOwNXtRs8LJGsIUSC/gc1SOSjpj5F6dwM
         DEAaCfpdNdpLm8XWWgN1DI/UL7GK2LxCsWcOPx9uxkXyt188fJIFi5Xw4Xj3cFPfe7aN
         RPN+Jp1TiX7Fk9oowSXXVDzqzCHTG6YnPe8bYN72/+4OeS3xIWTOD6tVUb/qfvEHcvqO
         OO5hkGnsnJAO/tGsGEV62hBGF8NvWY+DaPB1WESE4ASoK1Td/slq368p18DF0ByvYmbL
         ugMQ==
X-Gm-Message-State: APt69E3r2dWduLXfeuryMdF1apNohi/R0Slt4EJr+48Fz47hYoQb5QNc
        v7MzK5dcdzf+yy1wvz5BCZ1dyl2K
X-Google-Smtp-Source: ADUXVKKwzQeN9u7n2c0xgVEzaPi2GhOgqKInp15Vu+gXgw5cUClEtGnwbalTczcMze19MSM4Y1AhSQ==
X-Received: by 2002:a2e:889a:: with SMTP id k26-v6mr11239310lji.54.1528717993334;
        Mon, 11 Jun 2018 04:53:13 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:12 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 11/24] Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 13:52:27 +0200
Message-Id: <20180611115240.32606-12-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export serdev table to the module header, allowing module autoload via
udev/modprobe.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f4d7846c06b8..ff0fd3502a90 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1327,8 +1327,10 @@ MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 
 static const struct serdev_device_id bcm_serdev_id[] = {
 	{ "bcm43438-bt", },
+	{ "hci_uart_bcm", },
 	{}
 };
+MODULE_DEVICE_TABLE(serdev, bcm_serdev_id);
 
 static struct serdev_device_driver bcm_serdev_driver = {
 	.probe = bcm_serdev_probe,
-- 
2.17.1
