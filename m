Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KbLHNOZjHltxYQAAmS7hNA
	; Mon, 11 Jun 2018 11:58:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B22B9607A4; Mon, 11 Jun 2018 11:58:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgxFCGgh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0985E601C3;
	Mon, 11 Jun 2018 11:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0985E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933247AbeFKL62 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:58:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:47057 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932980AbeFKLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id j13-v6so30070751lfb.13;
        Mon, 11 Jun 2018 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0stxgmqK9cnJJLzR4ilGdNbg/585+rnol+96qrFt52Q=;
        b=fgxFCGghVwuKzvfCDyExUkl0u7lRa2QZiu4SEYnJKsDKedjrIM3QR+wpSSEgpg8GNE
         +x/B4i+oMTVc8etH7X/BAtm7/Wb2WyL32ALelPBBYUsyuwxFzfYbZnIrCi6jC50AYzaO
         hsTIxZAeKv4Yxg6HXTEKAm2t8hpzRwsasc+Bzlgj4LxljRw7rUDDEDMSS1ZWg9N3GfK7
         iv6MMKGPISEOIfVZAVKFzYWOywgU37IPd7R4cpR4LpZ2s7yoOSn/cI13tacPn3OBmtpv
         oZ19s2yL/jySB6t5Y2ZN14DSelVjO3sSRChuKjhURwj/sBGJ/1HIAwib+bZShnIMsb0c
         FuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0stxgmqK9cnJJLzR4ilGdNbg/585+rnol+96qrFt52Q=;
        b=uRq0bFckU4ZjH0MsSVyxKtjHbU8w7q1I6D3nd2F/t34w8H2NQ7DQlqCrMt2a6onNhD
         KWOr7zgLjGtflGruiX8b30zbANPXe4+xwbQ7oeL80DPVd1r+FsxNMQdPz3V5ivJsZ495
         uypc3aN6PDMCf5CjT2oZFiOm4rxq16jUByonaxwl75JvdCVCVbYcRje+KPrC7GYBIWJv
         x5/VMjKUKqg/72L0hTWHmQFeKdc2rvw+vMTfZ6tSsOQdMKCgaA8RGRvO6uVPlE4YL298
         ANCflbzmFxZl6lLzyoz5mOycyxSf9taHVc845szmON4LWMR7saA6MHT3wseIYAa2DXde
         jLmg==
X-Gm-Message-State: APt69E2nBGmDRRyzMOy3uleWaZlRxKJa0VHcA2nbcfsUfB56zV7u/Lyz
        f1Eno8Uo5DFcGFpRb+jAKzebFQw/
X-Google-Smtp-Source: ADUXVKJHVJDGZ0hI1e0Zag0Q+8RVEIV7r2A3SXRDqj11A7Pcb+tVUbGL+o39FwN2dmaN6Lp4nDgq2w==
X-Received: by 2002:a19:6a0f:: with SMTP id u15-v6mr10673902lfu.81.1528717978672;
        Mon, 11 Jun 2018 04:52:58 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:52:57 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/24] Bluetooth: hci_nokia: Add serdev_id_table
Date: Mon, 11 Jun 2018 13:52:20 +0200
Message-Id: <20180611115240.32606-5-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe which hardware is supported by the current driver.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/bluetooth/hci_nokia.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 3539fd03f47e..eb3d59894aef 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -801,6 +801,11 @@ static const struct of_device_id nokia_bluetooth_of_match[] = {
 MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
 #endif
 
+static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
+	{ "hp4-bluetooth", },
+	{}
+};
+
 static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 	.probe = nokia_bluetooth_serdev_probe,
 	.remove = nokia_bluetooth_serdev_remove,
@@ -809,6 +814,7 @@ static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 		.pm = &nokia_bluetooth_pm_ops,
 		.of_match_table = of_match_ptr(nokia_bluetooth_of_match),
 	},
+	.id_table = nokia_bluetooth_serdev_id,
 };
 
 module_serdev_device_driver(nokia_bluetooth_serdev_driver);
-- 
2.17.1
