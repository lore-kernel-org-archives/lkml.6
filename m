Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J3RPDIViHlvYVgAAmS7hNA
	; Mon, 11 Jun 2018 11:53:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 585D7607E4; Mon, 11 Jun 2018 11:53:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvTq/gJl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A2B5F60351;
	Mon, 11 Jun 2018 11:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2B5F60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933047AbeFKLxB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:01 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39856 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbeFKLw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:52:56 -0400
Received: by mail-lf0-f65.google.com with SMTP id t134-v6so30094774lff.6;
        Mon, 11 Jun 2018 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/S43JM0aR6vOjw8Olf0gQR7oAHEIWj9FfxhZtXD/Wz0=;
        b=MvTq/gJlNEaycTKvLvHp3NlZrk2bIbZ3Q9xR6e8JUbAen1LFEiNaIIvTfuXLBExCj/
         Pj+ZFCkZ/LNa3BjdzoADiZcrvR7yiDnI421iy8eQGcxlWu+BR5wcvALWhb0oWt+FjLAS
         72DnXN8KSykFVdtXTtu+AT3lTaKDz/Hlea6f7uNytH0jBABgPgjQINHNJ2viFluFXpDb
         YsqEatymFjdx3ZdPWXDgIIURp6V0etrkU/kaZqJvOFN3hXSL0883FEZLhhM0/I1yPBCR
         sBfOFWoDlKt0iT2+bb4UhrzuUjcc5D4YH218WY5ksJ+jw5vraUuTBFxISv/Igm9vbZt0
         /baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/S43JM0aR6vOjw8Olf0gQR7oAHEIWj9FfxhZtXD/Wz0=;
        b=BUOIrzK4sTJj//QAXKOejeFKPbTwku/W1er8AH8TSgXUnAEr8sUsE2U5T4zSj2Opo8
         I2GTmBR4dR6ng8iSMYaqcrztAmGxHlcMUsjGQb6/7sBIYFo2UcgFEVxom+DPYXyylP7p
         WqEG9p5fZ62moPELrI13HQRg3Xx51CbcSqmLD3I11Gq7CRp+/79b4H0iDlzYPTNfVpuX
         ysGX752Wq1cjVWYzYWIlVMgB9QG1aJqauYTLJkVvHsgKHCZYeM8pHqNOFJJiNLwGvEIH
         qdiwmyrKl9A8p41N2JfjQqgl2X76etCfL+i/cM24uoScV2RfnBSUrodmpr0Syyyb4rDL
         HUOQ==
X-Gm-Message-State: APt69E3wy84ryMfKXHG0d1WrcaD2mLM+6UnqhkUPli53Y9k6DDDVptES
        0Qyu51Ab+zUvW91HKF7zZYaZz51m
X-Google-Smtp-Source: ADUXVKJOTg0pfpkPy71Fk5hdNz4XL8Q/rRFg9/fpkTZZOALldFB6dQ7e9it4RrEXN6JzcOd7DXM1zA==
X-Received: by 2002:a2e:55cf:: with SMTP id g76-v6mr9165066lje.4.1528717974087;
        Mon, 11 Jun 2018 04:52:54 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:52:52 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/24] Bluetooth: hci_bcm: Add serdev_id_table
Date: Mon, 11 Jun 2018 13:52:18 +0200
Message-Id: <20180611115240.32606-3-ricardo.ribalda@gmail.com>
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
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 441f5e1deb11..f4d7846c06b8 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1325,6 +1325,11 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 #endif
 
+static const struct serdev_device_id bcm_serdev_id[] = {
+	{ "bcm43438-bt", },
+	{}
+};
+
 static struct serdev_device_driver bcm_serdev_driver = {
 	.probe = bcm_serdev_probe,
 	.remove = bcm_serdev_remove,
@@ -1334,6 +1339,7 @@ static struct serdev_device_driver bcm_serdev_driver = {
 		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
 		.pm = &bcm_pm_ops,
 	},
+	.id_table = bcm_serdev_id,
 };
 
 int __init bcm_init(void)
-- 
2.17.1
