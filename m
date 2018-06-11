Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bZyrC0ViHluOVQAAmS7hNA
	; Mon, 11 Jun 2018 11:53:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 07A96607BB; Mon, 11 Jun 2018 11:53:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF228xrf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77AEC601C3;
	Mon, 11 Jun 2018 11:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77AEC601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeFKLxW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:22 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37385 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933151AbeFKLxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so28111372lfb.4;
        Mon, 11 Jun 2018 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XNfhu7uXwhrvFzGOIoFdDoFjyRco9xidHWDg5YHJW/c=;
        b=IF228xrfMTOrdqh6XXCA/qxmx48UsnM8hEZCAVNUrXLqsQRjKTNZ6xvMQ5VsfkSC17
         +a6L0tYPugw5G1myjMm28rTz6vCsbo5s3ZFqi2DBoG4B0bgWI97dk6WsuzYu1gCLpnXU
         mYoeaJKSXZnOW5Gk8Ln6HR13t4WSlxdE32lKuE7wJabw1TRNAAyFTY+jYiuDGx+OH+Mj
         v1BfK/ZuyHT/G+IUD7cXHgXk45rlS+uy+barUXceJOM6eZ2X3ZSlHZZdF6W3rZtGlgBF
         rU+vjxx8v05nMVz5maq87liuBet49DVbfdOz2cutO3Pf+X6EtGXUGbZ2fWaIqo6Z8Pi5
         fCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XNfhu7uXwhrvFzGOIoFdDoFjyRco9xidHWDg5YHJW/c=;
        b=kBo4LqgVzlmXQ+7gtFfGCWot320C7jCs+4nifG3TAKPaxdBZHgamucegFeL3Kl2FP3
         6ytqKvoDCAk0icvyS8Hs8tpsRSxbw8E1Lrpdo6sxOHxB8oUH6V3gsolBcsVM2FHzjGAN
         xaE0zvZ8SV6Kdgg3RVRkNCWUkxjSulQH3SHlQzRsXktHm8e3xmZsECNqKp1cUWTHehXz
         vZVdu543+oDlYxg/FZIi381e3HgGwpoSSfh0j1ppYoWbCsb2JWAckUm1ADaaLkzqERIV
         Q2ZdOjbhhnPuDiA//uivYCu1/EhO4fKdqOZJyy2EhrTG1kMHTVOK87QZZsbt5445r/PD
         Dlkg==
X-Gm-Message-State: APt69E2B7KNhNuOrnI4GVFe/9JKtSlw6vfEvaFRaRFP+4+a10ho6hcfR
        Om4EeJ3nxjM2SBOjCGDaTFNrFMQw
X-Google-Smtp-Source: ADUXVKIHLkg2mOUQYuwiB17BYvx3NwXg9c5i2fWXi++5KYcy+y6C1J6IOPxRSZYE1tqFe/GXMV2UZw==
X-Received: by 2002:a2e:458a:: with SMTP id s132-v6mr11074628lja.92.1528717996749;
        Mon, 11 Jun 2018 04:53:16 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:15 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/24] Bluetooth: hci_nokia: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 13:52:29 +0200
Message-Id: <20180611115240.32606-14-ricardo.ribalda@gmail.com>
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
 drivers/bluetooth/hci_nokia.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index eb3d59894aef..fef285608f10 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -803,8 +803,10 @@ MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
 
 static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
 	{ "hp4-bluetooth", },
+	{ "nokia-bluetooth", },
 	{}
 };
+MODULE_DEVICE_TABLE(serdev, nokia_bluetooth_serdev_id);
 
 static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 	.probe = nokia_bluetooth_serdev_probe,
-- 
2.17.1
