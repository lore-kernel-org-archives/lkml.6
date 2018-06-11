Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8qkmMxljHlvgXAAAmS7hNA
	; Mon, 11 Jun 2018 11:55:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 92475607A4; Mon, 11 Jun 2018 11:55:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZkRtpBE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 06335601C3;
	Mon, 11 Jun 2018 11:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06335601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933314AbeFKLzi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:55:38 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39923 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933163AbeFKLxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:22 -0400
Received: by mail-lf0-f65.google.com with SMTP id t134-v6so30096670lff.6;
        Mon, 11 Jun 2018 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Svktzbq5FqvAsJXKO7DKQjyta45taZAsN5SjSbaMVRs=;
        b=pZkRtpBEQWmOnaD5hjbE8S5pjp65XKIzZbMyifUaNOaWxPRhqRHBw2SaaUdBMUZIPn
         DpDBXCKg6zffLwAXmVhnMh1BDrIYZ802QygSytJuCBxmu541FrjYyzMswMYQoAUIbtNi
         1moihbiRuNoEGX05Ys5sPUMo7+4zHQfl9tGStzJRhSqCiJT0hsfAqsUu4sO6PW/XpqKx
         wp77E5hzIBd78LNHEhHv4Vv4PyndcmJuhwTnBXG6/MdJuTX2/StdT8HZrlIKfx332ic8
         g9ivjMsGfgtgJ8oGZJ58cnXX4AVZrU/cgZB8XoJdvI5C5CsEcGRhlH7T7yZC5cmvAvuB
         G5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Svktzbq5FqvAsJXKO7DKQjyta45taZAsN5SjSbaMVRs=;
        b=QrEo5AxNLzpoaLMcSGaA28RhIs0rPD71yJl7xxm8v7Q8l/i2BfQchO5VBNJDy725r7
         YvYA3B6Zoc61TDhA69smSvbD3K46NZSEU9Rgvh73BROSjtzmM2z1ESaSk5YnkPJHmuY0
         EBuYVZabaZej/IOsQnzW6ypqnUD+2EfTlFb53pyA8qxpOkUoPLlEdvkoLNqPIYRCdmQK
         FGqozGt2PosdRh1zm8EXvXddW9wVtrUJv1+M6bu+/eDzx12ReHm0r772AYj5Ao1qdpW8
         f3gN7A9qhnzJv9PxSBudqQBHaIbzIM1yoU5CzrkgwauSwxHdku84E4pqH/EWofSGlOAl
         x4LA==
X-Gm-Message-State: APt69E3aXunav5zrZk1ZK36V/5wl0ar7d0bG7BK9SaST+1Lc4xvDyYOp
        CIHSivRIhpVOkAiB1+/8U+s7SYPK
X-Google-Smtp-Source: ADUXVKJoFtJgaZtfWACaBl6rMqO1LR7Apc/sgzDYMeItwq3BOfLb0WahX/XPFRT6UXP2HnR9sV+0rw==
X-Received: by 2002:a2e:5818:: with SMTP id m24-v6mr11974291ljb.84.1528718000271;
        Mon, 11 Jun 2018 04:53:20 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:19 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        netdev@vger.kernel.org
Subject: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 13:52:31 +0200
Message-Id: <20180611115240.32606-16-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export serdev table to the module header, allowing module autoload via
udev/modprobe.

Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/net/ethernet/qualcomm/qca_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
index db6068cd7a1f..6d2ac6cae63f 100644
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -405,6 +405,12 @@ static void qca_uart_remove(struct serdev_device *serdev)
 	free_netdev(qca->net_dev);
 }
 
+static struct serdev_device_id qca_uart_serdev_id[] = {
+	{ QCAUART_DRV_NAME, },
+	{}
+};
+MODULE_DEVICE_TABLE(serdev, qca_uart_serdev_id);
+
 static struct serdev_device_driver qca_uart_driver = {
 	.probe = qca_uart_probe,
 	.remove = qca_uart_remove,
@@ -412,6 +418,7 @@ static struct serdev_device_driver qca_uart_driver = {
 		.name = QCAUART_DRV_NAME,
 		.of_match_table = of_match_ptr(qca_uart_of_match),
 	},
+	.id_table = qca_uart_serdev_id,
 };
 
 module_serdev_device_driver(qca_uart_driver);
-- 
2.17.1
