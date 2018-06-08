Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id F9HmDqLIGVumCQAAmS7hNA
	; Fri, 08 Jun 2018 00:15:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 49DAA6074D; Fri,  8 Jun 2018 00:15:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NqD3vaqQ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B78A960290;
	Fri,  8 Jun 2018 00:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B78A960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeFHAPB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:15:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44097 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeFHAO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:14:59 -0400
Received: by mail-pg0-f66.google.com with SMTP id p21-v6so5516994pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TYKaJkpTCYGsbfpwKeHID7wfzbW4tYdKoFQ/IvO472U=;
        b=NqD3vaqQk5rcSi8IaWQI6WL0ld/TeZO4FCpAXF3BpuhVpgd5+3GZ6TrMLwoJb2bjbU
         OKZv/x7S2fK0E2TrNMkxjmvCfJDHhU40IwGEDimg4cJcwzeAUZKXJK3FlFCOwp2PBLsz
         JGNmDrzcD4Nxh4atyjW8yp4XbaEi28JKpZL4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TYKaJkpTCYGsbfpwKeHID7wfzbW4tYdKoFQ/IvO472U=;
        b=qN1eDvxtEwbBTUg0f/d2AzQunz4PqwQI9wtYUPDGn/+gN3a0VF6cTtM1bNTKU/Z+E3
         mvMzO826N6fLIOcG8U0MsZsUGlURDaK23CitnQcPyEjSoXleZGIHlx6QLUXo+vRpOIMB
         w6cH1G7OWCGJLO6AuyoPVyAFSsb3kqSbEgIvVLmbkjn1cTscPmI8XnhNnfZCKG++VwWI
         I3BNHh60n0ll2ij5hkp7ykdqDoce2i/jWEtKak4boDb0D32+lMU1+urrDE2Lf5OIiTyt
         ykiJv3vXBtUkBkuFDzAQg7gjY6GSL3rTLlc+ZsOVHOTksu8sVaWkhHFSTMTv+NFGbV3s
         6Jvw==
X-Gm-Message-State: APt69E0iseZkxuOS0YfIegdOzvmMNiwOKyn0dTbMQi8lwuQPtvFDRbI4
        FI1vqBGNgzeMecr999k19uaegHnrq48=
X-Google-Smtp-Source: ADUXVKKDdGyfLZxIhzfGfgtKjtQ88lV6gHYUTUfbvnBTMsBVdnUeTGHobMHqRImokyXkA9FiVTCbzA==
X-Received: by 2002:a62:121a:: with SMTP id a26-v6mr3712477pfj.104.1528416898545;
        Thu, 07 Jun 2018 17:14:58 -0700 (PDT)
Received: from drinkcat.tpe.corp.google.com ([2401:fa00:1:b:9ba:cd16:d555:bacf])
        by smtp.gmail.com with ESMTPSA id n76-v6sm7493419pfg.98.2018.06.07.17.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 17:14:57 -0700 (PDT)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: google: Add support for whiskers
Date: Fri,  8 Jun 2018 08:14:50 +0800
Message-Id: <20180608001450.76836-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another device in the hammer class, with USB id 0x5030.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 2 ++
 drivers/hid/hid-ids.h           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 7b8e17b03cb86..6bf4da7ad63a5 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -124,6 +124,8 @@ static const struct hid_device_id hammer_devices[] = {
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WHISKERS) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, hammer_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a85634fe033f0..c7981ddd87763 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -452,6 +452,7 @@
 #define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE	0x5028
 #define USB_DEVICE_ID_GOOGLE_STAFF	0x502b
 #define USB_DEVICE_ID_GOOGLE_WAND	0x502d
+#define USB_DEVICE_ID_GOOGLE_WHISKERS	0x5030
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.18.0.rc1.242.g61856ae69a-goog
