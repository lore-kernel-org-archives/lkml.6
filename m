Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 27S8MfFjHlugYQAAmS7hNA
	; Mon, 11 Jun 2018 11:58:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 77A43607A4; Mon, 11 Jun 2018 11:58:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahfOeVR8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0110B601C3;
	Mon, 11 Jun 2018 11:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0110B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeFKL6r (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:58:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37342 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932978AbeFKLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:52:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so28109921lfb.4;
        Mon, 11 Jun 2018 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZJrLI/VuqBYag/UozRd6+0YNWDier7XViH34iN010c8=;
        b=ahfOeVR84gvf5MuZ+MyooHku0ulk8W7Wgkp8m6kNXQBML0X/H7urIWHwwo1nbjQFch
         t0OOl2WezbCdV7DPY1rLag/5t12WRfBsQNvGov/Qc/LHS6bInMKxj7C+DQxjx14xaeyf
         bg+Q8pvRX0OhU3QAU+41txq2jMQ61HpI7ULlPsOdhjPk9+g0e+oAeyHH1EGbBtPVhJ+R
         BfTW5XHSuaeOJ2kP13Ozq44UvHri18aQHUScSxpSQPdJx1y84ZKr+WnKvidiN60lLICj
         JvQsz9Hs4ktxjB36DbSbMl29uDkmqDowh1/GUMBuD259Mj6Pe6hIViXEtTytgjEaMTxo
         M+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZJrLI/VuqBYag/UozRd6+0YNWDier7XViH34iN010c8=;
        b=OjKoP3rRXDKvdthLNcZfz89dh5EIk0GCibU5lkvquIehc8l6FWXzdcGH0c1IFdNr/6
         1iawGnJlUBZSAI0ELtsWFQWQIzCuo+ZnokAymfaQa9a3ohONHEFCpgNTp8j1xSGMVxXT
         43PCWDGYeltGgX/FcVnXlSKdTypfbFElrPs4gzDr8VwhzaIwyRUovAVylNp2Mguyv0jM
         +N3fEMaDokQ/JU1X/i3ZIJ0UpiBd7OFPkPER2Buo2BNrixO8uLTaR6sozWNvBwIykMLT
         agVcVeYD2BzsSIPcZu1stbm7ns5iic74EuL33k6ZrNFX0Wbdb1MaPrJlFPXCg8nqyjGK
         sqtA==
X-Gm-Message-State: APt69E3+AgJzmNIYtNvcu2xaA3H1/BtOOSduSXsT+3QVjvmSadl5cu83
        t6ZkoP+ZgdInoVlawbVEap4/7+iN
X-Google-Smtp-Source: ADUXVKI9rQjGv71F6Zfg/540Y/hvIUuS++7uHq9eUcU8AOKCUkLmHMMKZTyhLKvXEgg3ohMdynFL6g==
X-Received: by 2002:a19:15da:: with SMTP id 87-v6mr10733932lfv.136.1528717976978;
        Mon, 11 Jun 2018 04:52:56 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:52:54 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/24] Bluetooth: hci_ll: Add serdev_id_table
Date: Mon, 11 Jun 2018 13:52:19 +0200
Message-Id: <20180611115240.32606-4-ricardo.ribalda@gmail.com>
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
 drivers/bluetooth/hci_ll.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 27e414b4e3a2..276fdf677df4 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -776,6 +776,23 @@ static const struct of_device_id hci_ti_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, hci_ti_of_match);
 
+static struct serdev_device_id hci_ti_id[] = {
+	{ "cc2560", },
+	{ "wl1271-st", },
+	{ "wl1273-st", },
+	{ "wl1281-st", },
+	{ "wl1283-st", },
+	{ "wl1285-st", },
+	{ "wl1801-st", },
+	{ "wl1805-st", },
+	{ "wl1807-st", },
+	{ "wl1831-st", },
+	{ "wl1835-st", },
+	{ "wl1837-st", },
+	{}
+};
+MODULE_DEVICE_TABLE(serdev, hci_ti_id);
+
 static struct serdev_device_driver hci_ti_drv = {
 	.driver		= {
 		.name	= "hci-ti",
@@ -783,6 +800,7 @@ static struct serdev_device_driver hci_ti_drv = {
 	},
 	.probe	= hci_ti_probe,
 	.remove	= hci_ti_remove,
+	.id_table = hci_ti_id,
 };
 #else
 #define ll_setup NULL
-- 
2.17.1
