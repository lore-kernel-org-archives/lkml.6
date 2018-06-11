Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3TngGm9jHlsQXwAAmS7hNA
	; Mon, 11 Jun 2018 11:56:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 54297607E7; Mon, 11 Jun 2018 11:56:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atwEiMwK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D886F601C3;
	Mon, 11 Jun 2018 11:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D886F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbeFKL42 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:56:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44611 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeFKLxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:17 -0400
Received: by mail-lf0-f66.google.com with SMTP id 36-v6so30058021lfr.11;
        Mon, 11 Jun 2018 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WeGdieVXMoFbrh0Bp+q96fLe9Z9bPdAj9muQOL50dWg=;
        b=atwEiMwKbfgwh6N43plpYDDue6DEtOVelq+B/hFI5OeijjjZoXX1Hi0RXoODyoN43D
         TgAYrZ6OFbOgvZNhjx6T66gTKOe8NLDTbopjjUPgWcfoX8YFd3fy1l3qaFkvoTCsBopC
         rmnM74JGlSikPU8zGxIwKvVhXSoUyWA97Wsf/+w3wFznsW7nz6f1yBe/SixDCF0dUCrG
         Mehf302n7jDGyyL/4N7dL3eDb3OlSeCo3tmfi2MOrgFOvt/ZLyvBOB3uWYe9RMtJ31eO
         Ql4PGFTYIaFbn/RDwMcJnVhBN0XU7Rg+auxNGScGPUve0asq+1B41+CWU7MWebeutGhk
         KVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WeGdieVXMoFbrh0Bp+q96fLe9Z9bPdAj9muQOL50dWg=;
        b=sEy/LiMI2gFLVh3yElUABI+OPGimG6Jkb25wTeYFo8CTq6Ni54i1O8UwQ0maEBXfY3
         eDkuzdLGfvh5U8+Xg7/DEVF7lxYi2inB0HPVR2XXi9YoP1hZ7k9gdBFuu56u3YBpJLaH
         nmhkiVA12+mLADOXDP4dhv6VXzrPEEnaU8T/uZ2TW1hSCTDBOQKgiynAt7Hy59X5YA/2
         S1EnbpF8He8MmFyJcU90Tx9GQk9RIe5dkh62PRH0QWUTzUxtcCgGtynBNvRp1k68jogF
         Y1/PkgRjrhM40hCgvXTMOF9DH+jB4jLv01eS5jdNzVAJxloS/eyTx/qYdOB6yqrkPpey
         83Hg==
X-Gm-Message-State: APt69E0KtufbsHS+dUqyYjrwkYuorvr/lxqFQvSR6rDuVz0ImuwJG3gg
        6Tg5flEplttYR8/U1VUsCJkwtCie
X-Google-Smtp-Source: ADUXVKJo9A5Jbiy0DfhpSU0IDv1Nx1elRLS9GzJk+JtBhx+qDUOvsGpv0P1m+2/t2VBfBK4mkfqsfg==
X-Received: by 2002:a2e:1503:: with SMTP id s3-v6mr6153320ljd.65.1528717994944;
        Mon, 11 Jun 2018 04:53:14 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:13 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 12/24] Bluetooth: hci_ll: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 13:52:28 +0200
Message-Id: <20180611115240.32606-13-ricardo.ribalda@gmail.com>
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
 drivers/bluetooth/hci_ll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 276fdf677df4..3fbe7045e857 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -789,6 +789,7 @@ static struct serdev_device_id hci_ti_id[] = {
 	{ "wl1831-st", },
 	{ "wl1835-st", },
 	{ "wl1837-st", },
+	{ "hci-ti", },
 	{}
 };
 MODULE_DEVICE_TABLE(serdev, hci_ti_id);
-- 
2.17.1
