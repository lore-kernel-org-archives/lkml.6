Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D778920834
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNDHQB2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D778920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeHUMOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:14:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44230 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeHUMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:14:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id ba4-v6so8480275plb.11;
        Tue, 21 Aug 2018 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=IIifMhfwsoR9RaN+uOGfuOkx5DWqau4BXgGvwHWTK1o=;
        b=fNDHQB2q3ps4LlR/A/Mw6cB86cEvmGiavOGEeJ8t1z4wmeEJL82NgdAlgXAgUXR1ZR
         a489QhT3I+n8OtP3bA/FBy3Jw51MPAim89qoO6gY5lDsPdBuiNlDzrrcBiXLrvTjXZNL
         FNn2tCGANPGA++TPpRaXS2F3TQ82gWqU9wvKvEh3eSIXS2ALiHNAivTTtS8YX1xa6THB
         J0Ei8HjoSKfOtPufavNndGdsHioq8IxyRjLR2Ir8c2+dXqphjEpYa1Oqd+YKc74YpRa9
         5ef/avjsBdAk4FaHkEbSut/LSI9UHHQZ3SwOYpQujROI18k9v6T41qjewB9mpY15IR+1
         PzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=IIifMhfwsoR9RaN+uOGfuOkx5DWqau4BXgGvwHWTK1o=;
        b=WBcJvF51B2q4RGSBfeI+S5UActEFm/uTBqRu7UXZO3XiqTPRFZ0g6Eqt22Oc5F5a1O
         t96PSEo294wB7+AMBdc8VadHdcdLqkTtFCN5C35FGURkZUbrtJoJNSzOJcACg1kgFAUd
         x67l2HUL4CePWpJ9w/4IizN6NsfpKvgYjazbmXi2autEhgOp2RV3cx/2IfXP+2JAydql
         3I+Tgg3qYQvWlZfleNPboVZq/JAnP/WjgLagZiGll0kgTSMGX/M7Wm7WYptCBys478nn
         CoSWgTwvZiVLl3qZC8ABfrhNpcNc2cFWGIuegu9SyolPYTB+Q/annR6mSjr5XHbBokuX
         fH1Q==
X-Gm-Message-State: APzg51BaBUTV3KNbX2eEVSwsXBR5+kY86yMpH8aVag/uOOi9L9SXqy2A
        CEjiBpICqX09bXA66M9HHu4=
X-Google-Smtp-Source: ANB0VdYCtNAqyHMYiSBEBwEfSdFReHljlwC9P67J5L0PRju/vmGFIudYLBB2UK7dmSyB/I/Ocfu+JA==
X-Received: by 2002:a17:902:28eb:: with SMTP id f98-v6mr1486373plb.149.1534841716658;
        Tue, 21 Aug 2018 01:55:16 -0700 (PDT)
Received: from localhost (114-32-69-186.HINET-IP.hinet.net. [114.32.69.186])
        by smtp.gmail.com with ESMTPSA id 87-v6sm21121846pfn.103.2018.08.21.01.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 01:55:15 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: Fix flooded incomplete report after S3 on Rayd touchscreen
Date:   Tue, 21 Aug 2018 16:55:13 +0800
Message-Id: <20180821085513.13739-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The incomplete report flooded after S3 and touchscreen becomes
malfunctioned.
[ 1367.646244] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/18785)
[ 1367.649471] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/28743)
[ 1367.651092] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/26757)
[ 1367.652658] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/52280)
[ 1367.654287] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/56059)

Adding device ID, 04F3:30CC, to the quirk to re-send report description
after resume.

Cc: stable@vger.kernel.org
Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/hid/hid-ids.h         | 1 +
 drivers/hid/i2c-hid/i2c-hid.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c7981ddd8776..e80bcd71fe1e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -528,6 +528,7 @@
 
 #define I2C_VENDOR_ID_RAYD		0x2386
 #define I2C_PRODUCT_ID_RAYD_3118	0x3118
+#define I2C_PRODUCT_ID_RAYD_4B33	0x4B33
 
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index eae0cb3ddec6..5fd1159fc095 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -174,6 +174,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
 		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
+	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
+		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ 0, 0 }
 };
 
-- 
2.17.1

