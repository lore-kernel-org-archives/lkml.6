Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9DEC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7908820844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhLOfDDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7908820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeKIJhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:37:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39975 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeKIJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:37:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id q19-v6so35956pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 15:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mDOmHxtHc9ah51l/1sssmVDALU79jF5UEijPBogPM8=;
        b=RhLOfDDohhu+PV9YUkZLW75wjxjk/JUwkqsf0zgHGgUgdU4ylKtIub6k6xcVJ3O9A3
         Ubkvs+NxvBTBruJFMCZh0Q0pu4Ln6Rz6Wt1aQU/ueBxEtG8sm02xYIN/8QnLzTO0+AYM
         qoYgMMLjweAK+SOC9YN95sB7aD4+qlIbIbCp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mDOmHxtHc9ah51l/1sssmVDALU79jF5UEijPBogPM8=;
        b=jRAF93+bSEMFXPmXb2GcG61LXImfJ8ek5PtLkkaGhspQGoRHlFT1Nn1YBeIK0OKbrA
         L+FegtOGNNU+/AMqaVsFK18EFTbErFz8LTDxM2W0F+QrtWVxy6aAow2ddDeSVFktwSq1
         1cJIPi0FG9orBIcU/d818UY/krpaxObB72oz79KiPwUsiCLZ9Pu9MkUAscelFLWcGK4f
         yzvlcyeOul6cBPKQXG2273JEHqIQV615AA8mBKinkvhmJbTOOc5x9I6dPnUy4T+IKham
         M5wtP9hd6Jbb5HfQEB2+Tq3JeDFOMDp1kFUXGgHFCIyzqHnB2b6al61GLmWiczBqeOIG
         f6IQ==
X-Gm-Message-State: AGRZ1gJjj72xwgBZtQKUk3unUKfKnhHjWK+bg73me2kWW5tkO6zwzr8M
        Ob0ADm4ymmfZoFj1/iJ4WeBDBA==
X-Google-Smtp-Source: AJdET5cEkgOaBGAiOUZDaE2G5trom/qjisMK4qfTueSrJ6oZcsp7ZfyQk0/uypDJzJV3pq8DAAs12w==
X-Received: by 2002:a17:902:f24:: with SMTP id 33-v6mr6830603ply.228.1541721565125;
        Thu, 08 Nov 2018 15:59:25 -0800 (PST)
Received: from decatoncale.mtv.corp.google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id v84-v6sm5729880pfd.182.2018.11.08.15.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 15:59:24 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dtor@chromium.org, dmitry.torokhov@gmail.com,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH] HID: input: Ignore battery reported by Symbol DS4308
Date:   Thu,  8 Nov 2018 15:59:21 -0800
Message-Id: <20181108235921.62193-1-bleung@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Motorola/Zebra Symbol DS4308-HD is a handheld USB barcode scanner
which does not have a battery, but reports one anyway that always has
capacity 2.

Let's apply the IGNORE quirk to prevent it from being treated like a
power supply so that userspaces don't get confused that this
accessory is almost out of power and warn the user that they need to charge
their wired barcode scanner.

Reported here: https://bugs.chromium.org/p/chromium/issues/detail?id=804720

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c0d668944dbe..07f6348b9f86 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1043,6 +1043,7 @@
 #define USB_VENDOR_ID_SYMBOL		0x05e0
 #define USB_DEVICE_ID_SYMBOL_SCANNER_1	0x0800
 #define USB_DEVICE_ID_SYMBOL_SCANNER_2	0x1300
+#define USB_DEVICE_ID_SYMBOL_SCANNER_3	0x1200
 
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index a2f74e6adc70..44ea8e7c71a9 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -325,6 +325,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
+		USB_DEVICE_ID_SYMBOL_SCANNER_3),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
-- 
2.19.1.930.g4563a0d9d0-goog

